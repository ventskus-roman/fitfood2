class Product < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, :through => :ingredients
  validates :name, :proteins, :carbs, :fat, presence: { message: "не может быть пустым" }
  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true
end
