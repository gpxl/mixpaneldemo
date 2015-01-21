class Users::RegistrationsController < Devise::RegistrationsController
  require 'mixpanel-ruby'
  after_action :identify_mixpanel_id, :only => [:create]

  protected

  def identify_mixpanel_id
    if resource.id?
      tracker = Mixpanel::Tracker.new(ENV['mixpanel_id'])
      tracker.alias(resource.id, JSON.parse(cookies["mp_#{ENV['mixpanel_id']}_mixpanel"])['distinct_id'])
      tracker.people.set(resource.id, {
        '$email'      => resource.email,
        '$signed_up'  => resource.created_at
        });
    end
  end

end
