require 'spec_helper'

describe "StaticPages" do

  subject { page }
  
  describe "Home page" do

    before {visit root_path}

  	it { should have_content('Sample App') }

    it { should have_title(full_title('')) }

    it { should_not have_title('| Home') }

    describe "for signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following statistics" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it {should have_link("0 following", href: following_user_path(user)) }
        it {should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before{visit help_path}
  	
    it "should have the content 'Help'" do
  		
  		expect(page).to have_content('Help')
  	end

    it "should have the title 'Help'" do
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end

  end

  describe "About page" do
    before {visit about_path}
    
    it "should have the content 'About Us'" do
      
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end

  end

  # this is the 'old' way
  describe "Contact page" do 
    before {visit contact_path}

    it "should have the content 'contact'" do
      
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
    end
  end

end
