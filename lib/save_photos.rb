require 'rubygems'
require 'activeldap'
require_relative 'ldap.rb'

def save_all_photos
  if ldap_bind.bind
    read_all_users(ldap)
    for user_array.each do |user|
      uid = user.uid
      photo_path = "/ldap_photos/#{uid}.jpg"
      if user.has_photo?(uid)
        ldap_photo = user.photo
        File.open(photo_path, 'wb') { |f| f.write(ldap_photo) }
      end
    end
  end
end
