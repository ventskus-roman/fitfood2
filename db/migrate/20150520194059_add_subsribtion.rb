class AddSubsribtion < ActiveRecord::Migration
  def change
    create_table "subscribtions", :force => true, :id => false do |t|
      t.integer "owner_id", :null => false
      t.integer "target_id", :null => false
    end
  end
end
