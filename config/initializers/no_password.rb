require 'devise/strategies/authenticatable'

module Devise
  module Strategies

    class NoPassword < Authenticatable

      def valid?
        true
      end

      def authenticate!
        if params['user']
          user = User.where('email = ?', params['user']['email']).first
          if user.encrypted_password.empty?
            success!(user)
          else
            fail
          end
        end
      end

    end

  end
end

Warden::Strategies.add(:no_password, Devise::Strategies::NoPassword)