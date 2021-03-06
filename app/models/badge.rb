# == Schema Information
#
# Table name: badges
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  badge_type  :string(255)
#  condition   :text
#  quantity    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  photo       :string(255)
#  published   :boolean
#

class Badge < ActiveRecord::Base
  attr_accessible :name, :badge_type, :condition, :quantity, :description,
                  :photo, :published

  has_many :awards, dependent: :destroy
  has_many :users, through: :awards

  validates :condition, presence: true

  attr_accessible :condition, :name, :badge_type, :quantity

  mount_uploader :photo, BadgePhotoUploader

  scope :ordered, -> { order('created_at DESC') }
  scope :published, -> { where('published IS TRUE') }

end
