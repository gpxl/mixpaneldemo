class WelcomeController < ApplicationController

  before_action :authenticate_user!, only: :protected

  def index
  end

  def protected
    tracker = Mixpanel::Tracker.new(ENV['mixpanel_id'])
      tracker.track(current_user.id, "Protected Page Visit")
  end

end
