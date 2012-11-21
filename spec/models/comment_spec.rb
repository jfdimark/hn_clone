require 'spec_helper'

describe Comment do
	subject { Comment.new }

	context 'when initiated' do
		it 'responds to body' do
			subject { should respond_to :body }
		end
	end

end
