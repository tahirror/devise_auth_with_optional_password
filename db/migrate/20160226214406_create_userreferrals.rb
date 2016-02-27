class CreateUserreferrals < ActiveRecord::Migration
  def change
    create_table :userreferrals do |t|
      t.integer :user_id
      t.string :referral_link

      t.timestamps null: false
    end
  end
end
