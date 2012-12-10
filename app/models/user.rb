# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nickname               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  avatar                 :string(255)
#

class User < ActiveRecord::Base
  include BeechServer::Searchable::Models
  include BeechServer::Models::Badges
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :nickname

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  acts_as_searchable

  has_many :awards
  has_many :badges, through: :awards
  has_many :checks
  has_many :beers, through: :checks
  has_many :events

  has_many :followings, foreign_key: :follower_id, class_name: 'Following'
  has_many :following_users, through: :followings, source: :followee
  has_many :followers, foreign_key: :followee_id, class_name: 'Following'
  has_many :follower_users, through: :followers, source: :follower

  has_many :memberships
  has_many :roles, through: :memberships

  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true

  scope :except, ->(users = []) do
    users = [users] unless users.is_a?(Array)
    if users.any?
      where('id NOT IN (?) ', users.map(&:id))
    else
      scoped
    end
  end

  def admin?
    roles.include? Role.admin_role
  end

end

