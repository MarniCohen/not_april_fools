require 'rubygems'
require_relative './ldap.rb'

def upload_luke_photos
  ldap = ldap_bind
  filter = Net::LDAP::Filter.eq("uid", "*")
  ldap.search(:base => "dc=puppetlabs,dc=com", :filter => filter) do |entry|
    num = rand(1..5)
    luke_path = "Luked/#{num}.png"
    luke_photo = File.open(luke_path, "r")
    luke_photo_contents = luke_photo.read
    if entry[:jpegphoto].size > 0
      luked = [ 
        [:replace, :jpegphoto, luke_photo_contents] 
      ]
    else
      luked = [ 
        [:add, :jpegphoto, luke_photo_contents],
      ]
    end
    ldap.modify :dn => entry[:dn], :operations => luked
  end
end

upload_luke_photos

