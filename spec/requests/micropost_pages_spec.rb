require 'spec_helper'

describe "MicropostPages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "micropost creation" do
		before { visit root_path }

		describe "with invalid information" do

			it "should not create a micropost" do
				expect { click_button "Post" }.should_not change(Micropost, :count)
			end
		end

		describe "error messages" do
			before { click_button "Post" }
			it { should have_content('error') }
		end

		describe "with valid information" do
			before { fill_in 'micropost_content', with: "Lorem ipsum" }
			it "should create a micropost" do
				expect { click_button "Post" }.should change(Micropost, :count).by(1)
			end
		end
	end

	describe "micropost destruction" do
		before { FactoryGirl.create(:micropost, user: user) }

		describe "as a correct user" do
			before { visit root_path }

			it "should delete a micropost" do
				expect { click_link "delete" }.should change(Micropost, :count).by(-1)
			end
		end
	end
end
