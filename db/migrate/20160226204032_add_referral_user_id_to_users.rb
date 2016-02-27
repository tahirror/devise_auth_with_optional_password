class AddReferralUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :referral_user_id, :integer
  end
end
