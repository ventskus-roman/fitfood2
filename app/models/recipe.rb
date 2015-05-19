class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :products, :through => :ingredients
  validates :name, presence: { message: "не может быть пустым" }
  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true
  attr_accessor :weight
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  before_validation :recalc_calories, on: [:create, :update]

  def recalc_calories
    if ingredients && ingredients.length > 0
        self.calories = 0
        self.proteins = 0
        self.carbs = 0
        self.fat = 0
        ingredients.each do |ingredient|
          self.proteins = self.proteins + ingredient.product.proteins * ingredient.weight / 100
          self.carbs = self.carbs + ingredient.product.carbs * ingredient.weight / 100
          self.fat = self.fat + ingredient.product.fat * ingredient.weight / 100
        end
        self.proteins = self.proteins.round
        self.carbs = self.carbs.round
        self.fat = self.fat.round
        self.calories = calc_calories(proteins, carbs, fat).round
    else
      self.calories = calc_calories(proteins, carbs, fat)
    end
  end

  private

  def calc_calories(_proteins, _carbs, _fat)
    _proteins = _proteins ? _proteins : 0
    _carbs = _carbs ? _carbs : 0
    _fat = _fat ? _fat : 0
    _calories = _proteins * 4 + _carbs * 4 + _fat * 9
    _calories
  end
end
