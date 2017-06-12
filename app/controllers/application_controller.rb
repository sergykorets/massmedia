class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'author'

  # def for_devise
  # 	'author'	
  # end
end
