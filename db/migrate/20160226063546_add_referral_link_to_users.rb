class AddReferralLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :referral_link, :string
  end
end
