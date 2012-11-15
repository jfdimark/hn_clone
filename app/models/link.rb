class Link < ActiveRecord::Base
  attr_accessible :body, :url, :user_id
end
