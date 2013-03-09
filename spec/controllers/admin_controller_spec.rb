require 'spec_helper'

describe AdminController do

  describe "GET 'add_moderator'" do
    it "returns http success" do
      get 'add_moderator'
      response.should be_success
    end
  end

end
