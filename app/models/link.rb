class Link < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comment_count, :points

  validates :title, :url, :presence => true
  validates :url, :uniqueness => true
  has_many :comments
  has_many :votes
  belongs_to :user


  def votes
    Vote.find_all_by_link_id(id).count
  end

  def calc_points
    time = (Time.now - created_at)/3600
    points = (votes / time*5).ceil
  end

  def self.update_points
    links = Link.all
    links.each { |link| link.update_attributes(:points => link.calc_points) }
  end

end

# Use this to have Faker generate fake data
# 100.times do
#   link = Link.new(:title => Faker::Lorem.sentence(7), :url => Faker::Internet.url, :user_id => 1)
#   link.save
# end
