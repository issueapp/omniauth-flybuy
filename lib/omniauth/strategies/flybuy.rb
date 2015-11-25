require 'mechanize'
require 'omniauth'

module OmniAuth
  module Strategies
    class Flybuy
      include OmniAuth::Strategy

      uid  { flybuy.uid  }
      info { flybuy.info }

      def callback_phase
        flybuy ? super : fail!(:invalid_credentials)
      end

      def flybuy
        @flybuy ||= begin
          uid = request['id']
          info = {}

          login_url = options.login_url || 'https://www.flybuys.com.au/sign-in'
          login_form_id = options.login_form_id || 'myLogin'

          a = Mechanize.new { |agent|
            agent.user_agent_alias = 'Mac Safari'
          }

          a.get(login_url) do |page|
            login_result = page.form_with(:id => login_form_id) do |login|
              login.field_with!(:id => 'fullCardNumber').value = uid
              login.field_with!(:type => 'password').value = request['password']
            end.submit

            puts login_result.inspect

            # TODO get name, age info
            # info['name'] = ...
            # info['age'] = ...
          end

          Struct.new(:uid, :info).new(uid, info)
        end
      end
    end
  end
end
