class ApplicationController < ActionController::Base
	include ApplicationHelper
	include SessionHelper
  protect_from_forgery	
end
