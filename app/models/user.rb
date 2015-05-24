class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many(:users,
    :join_table => "subscribtions",
    :foreign_key => "owner_id",
    :association_foreign_key => "target_id")
  has_many :recipes
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  has_reputation :votes, source: {reputation: :votes, of: :recipes}

  def voted_for?(recipe)
    evaluations.where(target_type: recipe.class, target_id: recipe.id).present?
  end
end
