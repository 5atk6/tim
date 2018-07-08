require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
  has_secure_password
  validates :mail,
    presence: true,
    format: { with: /s[0-9]{7}@s.tsukuba.ac.jp/}
end

class Category < ActiveRecord::Base
  has_many :organizations
end

class Organization < ActiveRecord::Base
  belongs_to :category
end

class Event < ActiveRecord::Base
  
end

class Opinion < ActiveRecord::Base
  
end

class Idea < ActiveRecord::Base
  
end