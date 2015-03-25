require 'rubygems'
require_relative 'ldap.rb'

def save_all_photos
  ldap = ldap_bind
  filter = Net::LDAP::Filter.eq("uid", "*")
  ldap.search(:base => "dc=puppetlabs,dc=com", :filter => filter) do |entry|
    if !entry[:jpegphoto].empty?
      ldap_photo = entry[:jpegphoto].join
      uid = entry[:uid].join
      photo_path = "ldap_photos/#{uid}.jpg"
      backup_photo = File.open(photo_path, 'wb') { |f| f.write(ldap_photo)     }
      if File.size?(photo_path)
      else
        File.delete(photo_path)
      end
    end
  end
end

save_all_photos
