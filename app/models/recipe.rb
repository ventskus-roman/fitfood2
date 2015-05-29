class Recipe < ActiveRecord::Base
  include ActionView::Helpers::UrlHelper
  include ActionController::UrlFor
  include Rails.application.routes.url_helpers

  has_many :ingredients
  has_many :products, :through => :ingredients
  belongs_to :user
  validates :name, presence: { message: "не может быть пустым" }
  accepts_nested_attributes_for :ingredients, :reject_if => :all_blank, :allow_destroy => true
  attr_accessor :weight
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  before_validation :recalc_calories, :clear_ingredients_if_need, on: [:create, :update, :save]
  has_reputation :votes, source: :user
  slice :description, :as => :shorten, :slice => {:maximum => 300,:complete => /\n|\./}
  acts_as_taggable

  def recalc_calories
    if has_ingredients && ingredients && ingredients.length > 0
        self.calories = 0
        self.proteins = 0
        self.carbs = 0
        self.fat = 0
        total_weight = 0
        ingredients.each do |ingredient|
          if (ingredient.product)
            self.proteins = self.proteins + ingredient.product.proteins * ingredient.weight / 100
            self.carbs = self.carbs + ingredient.product.carbs * ingredient.weight / 100
            self.fat = self.fat + ingredient.product.fat * ingredient.weight / 100
            total_weight = total_weight + ingredient.weight;
          end
        end
        part = total_weight / 100
        self.proteins = (self.proteins / part).round
        self.carbs = (self.carbs / part).round
        self.fat = (self.fat / part).round
        self.calories = (calc_calories(proteins, carbs, fat) / part).round
    else
      self.calories = calc_calories(proteins, carbs, fat)
    end
  end

  private

  def clear_ingredients_if_need
    if has_ingredients == 0 || !has_ingredients
      self.ingredients.clear
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

  private

end
