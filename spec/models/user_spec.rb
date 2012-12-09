require 'spec_helper'

describe User do
  it { should have_many :awards }
  it { should have_many(:badges).through(:awards) }
  it { should have_many :checks }
  it { should have_many(:beers).through(:checks) }
  it { should have_many(:events) }
  it { should have_many(:followings) }
  it { should have_many(:following_users).through(:followings) }
  it { should have_many(:followers) }
  it { should have_many(:follower_users).through(:followers) }
  it { should have_many(:memberships) }
  it { should have_many(:roles).through(:memberships) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :nickname }

  context 'with a new instance' do
    subject { create :user }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:nickname) }
  end

  describe '#admin?' do

    context 'with a regular user' do
      subject { create :user }
      it 'should return false' do
        should_not be_admin
      end
    end

    context 'with an admin' do
      subject { create :user, :admin }
      it 'should return true' do
        should be_admin
      end
    end
  end

  describe '.except' do
    before(:each) do
      @users = 20.times.map { create :user }
    end

    context 'without params' do
      before(:each) do
        @excepted_users = User.except
      end

      it 'should return all users' do
        @excepted_users.size.should == 20
        @users.each do |u|
          @excepted_users.should include(u)
        end
      end

    end

    context 'with a single user' do
      before(:each) do
        @black_listed = create :user
        @excepted_users = User.except @black_listed
      end

      it 'should return all users except the given one' do
        @excepted_users.size.should == 20
        @users.each do |u|
          @excepted_users.should include(u)
        end
        @excepted_users.should_not include(@black_list)
      end
    end

    context 'with users' do
      before(:each) do
        @black_list = 3.times.map { create :user }
        @excepted_users = User.except @black_list
      end

      it 'should return all users' do
        @excepted_users.size.should == 20
        @users.each do |u|
          @excepted_users.should include(u)
        end
        @black_list.each do |u|
          @excepted_users.should_not include(u)
        end
      end
    end
  end
end
