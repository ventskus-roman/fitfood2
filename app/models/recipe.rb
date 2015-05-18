class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :products, :through => :ingredients
  validates :name, presence: { message: "не может быть пустым" }
  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true
  attr_accessor :weight
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
