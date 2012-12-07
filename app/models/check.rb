# == Schema Information
#
# Table name: checks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  beer_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Check < ActiveRecord::Base
  include BeechServer::Eventable
  attr_accessible :user_id, :beer_id, :user, :beer

  acts_as_eventable

  belongs_to :user
  belongs_to :beer

  delegate :name, to: :beer

  validates :beer, presence: true
  validates :user, presence: true

  default_scope -> { includes(:user, :beer).order('created_at DESC') }

end

