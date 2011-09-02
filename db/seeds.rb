# Create a user

user = User.create! :name => 'Test User', :initials => 'TU',
                    :email => 'test234@fulcrum.local', :password => 'top_secret'
user.confirm!

project = Project.create! :name => 'Test Project', :users => [user]

project.stories.create! :title => "A user should be able to create features",
  :story_type => 'feature', :requested_by => user
project.stories.create! :title => "A user should be able to create bugs",
  :story_type => 'bug', :requested_by => user
project.stories.create! :title => "A user should be able to create chores",
  :story_type => 'chore', :requested_by => user
project.stories.create! :title => "A user should be able to create releases",
  :story_type => 'release', :requested_by => user
project.stories.create! :title => "A user should be able to estimate features",
  :story_type => 'feature', :requested_by => user, :estimate => 1
