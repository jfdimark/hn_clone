require 'spec_helper'

describe Comment do

	context "when initiated" do
		it { should respond_to :body }
		it { should respond_to :link_id }
		it { should respond_to :user_id }
		it { should respond_to :parent_id }
		it { should respond_to :vote_count }

		it { should belong_to :link }
		it { should belong_to :user }
		it { should have_many :comments }
		it { should validate_presence_of :body }
	end




end
