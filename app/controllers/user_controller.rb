class UserController < ApplicationController
  def home
    if user_signed_in?
      @referral_link = current_user.referral_link.to_s
      unless current_user.referral_user_id.nil?
        userreferral = Userreferral.new(user_id: current_user.referral_user_id, referral_link: current_user.referral_link)
        userreferral.save!
      end
    end
  end
end