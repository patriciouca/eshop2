class UserSession < Authlogic::Session::Base
	logout_on_timeout true # default if false
end
