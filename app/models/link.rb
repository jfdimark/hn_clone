class Link < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comment_count, :points

  validates :title, :url, :presence => true
  validates :url, :uniqueness => true
  has_many :comments
  has_many :votes, :as => :object
  belongs_to :user

  def collected_votes
    Vote.find_all_by_object_id(id)
  end

  # def vote_count
  #   @vote_count ||= votes.count
  # end

  def vote_count
    Vote.find_all_by_object_id(id).count #TODO: also add type=Link
  end

  def calc_points
    time = (Time.now - created_at)/3600
    points = (vote_count / time*5).ceil
  end

  def self.update_points
    links = Link.all
    links.each { |link| link.update_attributes(:points => link.calc_points) }
  end

  def self.per_page
    20
  end

  # def link_votable?(current_user_id)
  #   (current_user_id != self.user_id) && (self.collected_votes.all? { |vote| vote.user_id != current_user_id })
  # end

end

# Use this to have Faker generate fake data
# 100.times do
#   link = Link.new(:title => Faker::Lorem.sentence(7), :url => Faker::Internet.url, :user_id => 1)
#   link.save
# end
