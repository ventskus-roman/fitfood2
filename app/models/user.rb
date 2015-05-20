class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many(:users,
    :join_table => "subscribtions",
    :foreign_key => "owner_id",
    :association_foreign_key => "target_id")
end
