FactoryGirl.define :episode do |f|
  f.name         'Foo Bar'
  f.description  'Lorem'
  f.notes        'Ipsum'
  f.seconds      600
  f.published_at Time.now
end

FactoryGirl.define :tag do |f|
  f.name "Bar"
end

FactoryGirl.define :comment do |f|
  f.content  'Hello world.'
  f.episode { |c| c.association(:episode) }
  f.user { |c| c.association(:user) }
end

FactoryGirl.define :user do |f|
  f.name "Foo Bar"
  f.sequence(:github_username) { |n| "foo#{n}" }
  f.sequence(:github_uid) { |n| n }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.email_on_reply true
end

FactoryGirl.define :feedback_message do |f|
  f.name "Foo Bar"
  f.content "Hello World"
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end
