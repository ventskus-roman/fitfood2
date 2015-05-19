class Product < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, :through => :ingredients
  validates :name, :proteins, :carbs, :fat, presence: { message: "не может быть пустым" }
  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true
  before_validation :recalc_calories, on: [:create, :update]

  def recalc_calories
    proteins = proteins ? proteins : 0
    carbs = carbs ? carbs : 0
    fat = fat ? fat : 0
    self.calories = proteins * 4 + carbs * 4 + fat * 9
  end
end
