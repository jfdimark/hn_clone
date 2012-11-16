class Link < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comment_count

  validates :title, :url, :presence => true
  validates :url, :uniqueness => true
  has_many :comments
  has_many :votes
  belongs_to :user


  def votes
    Vote.find_all_by_link_id(id).count
  end
end

# Use this to have Faker generate fake data
# 100.times do
#   link = Link.new(:title => Faker::Lorem.sentence(7), :url => Faker::Internet.url, :user_id => 1)
#   link.save
# end