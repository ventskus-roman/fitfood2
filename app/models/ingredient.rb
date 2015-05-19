class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :product
  accepts_nested_attributes_for :product, :reject_if => :all_blank, :allow_destroy => true
  attr_accessor :product_name
end
