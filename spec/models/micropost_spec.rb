require 'spec_helper'

describe Micropost do

	let(:user) { FactoryGirl.create(:user) }

	before { @micropost = user.microposts.build(content: "Test content stuffff") }

	subject { @micropost }

	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @micropost.user_id = nil }
		it { should_not be_valid }
	end

	describe "When content is blank" do
		before { @micropost.content = "  " }
		it { should_not be_valid }
	end

	describe "When content is too long" do
		before { @micropost.content = "a"*141 }
		it { should_not be_valid }
	end

	describe "When content is appropriate" do
		before { @micropost.content = "a"*139 }
		it { should be_valid }
	end

end
