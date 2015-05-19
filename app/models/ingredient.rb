class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :product
  accepts_nested_attributes_for :product, :reject_if => :all_blank, :allow_destroy => true
  attr_accessor :product_name, :product_proteins, :product_carbs, :product_fat
  validates :weight, :product_id, :recipe_id, presence: true
end
