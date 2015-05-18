class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :products, :through => :ingredients
  validates :name, presence: { message: "не может быть пустым" }
  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true
  attr_accessor :weight
end
