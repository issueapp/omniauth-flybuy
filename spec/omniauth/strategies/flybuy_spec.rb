require 'omniauth/strategies/flybuy'

describe OmniAuth::Strategies::Flybuy do

  attr_accessor :app

  let(:auth_hash){ last_response.headers['env']['omniauth.auth'] }

  def set_app!
    self.app = Rack::Builder.app do
      use Rack::Session::Cookie, secret: '123'
      use OmniAuth::Strategies::Flybuy
      run lambda{|env| [404, {'env' => env}, ["HELLO!"]]}
    end
  end

  before :all do
    set_app!
  end

  describe '#callback_phase' do
    context 'with valid credentials' do
      before do
        post '/auth/flybuy/callback', :id => '12345', :password => 'elite'
      end

      it 'should populate the auth hash' do
        auth_hash.should be_kind_of(Hash)
      end

      it 'should populate the uid' do
        auth_hash['uid'].should == 'user1'
      end

      it 'should populate the info hash' do
        auth_hash['info'].should == {'name' => "Jeanne d'Arc"}
      end
    end

    context 'with invalid credentials' do
    end
  end
end
