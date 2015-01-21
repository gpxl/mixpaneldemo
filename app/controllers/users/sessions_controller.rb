class Users::SessionsController < Devise::SessionsController
  require 'mixpanel-ruby'
  after_action :alias_mixpanel_id, :only => [:create]
  around_action :track_logout, :only => [:destroy]

  protected

  def alias_mixpanel_id
    tracker = Mixpanel::Tracker.new(ENV['mixpanel_id'])
    tracker.track(resource.id, "Signed in")
  end

  def track_logout
    logout_id = current_user.id
    yield
    tracker = Mixpanel::Tracker.new(ENV['mixpanel_id'])
    tracker.track(logout_id, "Signed out")
  end
end
