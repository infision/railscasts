require "spec_helper"
require "ostruct"

describe Comment do
  it "should validate the presence of episode_id and content" do
    comment = Comment.new
    %w[episode_id content].each do |attr|
      comment.should have(1).error_on(attr)
    end
  end

  it "should set request based attributes" do
    comment = Factory.build(:comment, :site_url => 'example.com')
    comment.request = OpenStruct.new(:remote_ip => 'ip', :env => { 'HTTP_USER_AGENT' => 'agent', 'HTTP_REFERER' => 'referrer' })
    comment.user_ip.should == 'ip'
    comment.user_agent.should == 'agent'
    comment.referrer.should == 'referrer'
  end

  it "should sort recent comments in descending order by created_at time" do
    Comment.delete_all
    c1 = Factory(:comment, :created_at => 2.weeks.ago)
    c2 = Factory(:comment, :created_at => Time.now)
    Comment.recent.should == [c2, c1]
  end

  it "should notify owners of all previous commenters except self" do
    c1 = Factory(:comment)
    c2a = Factory(:comment, :parent => c1)
    c2b = Factory(:comment, :parent => c1)
    c3 = Factory(:comment, :parent => c2a, :user => c2a.user)
    c3.notify_other_commenters
    email_count.should eq(1)
    last_email.to.should include(c1.user.email)
  end

  it "should not notify user when user does not want email" do
    c1 = Factory(:comment, :user => nil)
    c2 = Factory(:comment, :parent => c2, :user => Factory(:user, :email_on_reply => false))
    c3 = Factory(:comment, :parent => c2, :user => Factory(:user, :email => ""))
    c4 = Factory(:comment, :parent => c3)
    c4.users_to_notify.should eq([])
  end
end
