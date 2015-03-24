require 'rubygems'
require_relative './ldap.rb'

def upload_photos
  if LDAP.bind_as_user
    for LDAP.get_all_users.each do |user|
      File open #{uid}.jpg uh figure it out
    end
  end
end

