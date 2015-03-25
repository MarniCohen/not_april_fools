require 'rubygems'
require_relative 'ldap.rb'

def restore_all_photos
  ldap = ldap_bind
  filter = Net::LDAP::Filter.eq("uid", "*")
  ldap.search(:base => "dc=puppetlabs,dc=com", :filter => filter) do |entry|
    uid = entry[:uid].join
    photo_path = "ldap_photos/#{uid}.jpg"
    if File.exist?(photo_path)
      photo = File.open(photo_path, "r")
      photo_contents = photo.read
      un_luked = [[:replace, :jpegphoto, photo_contents]]
      ldap.modify :dn => entry[:dn], :operations => un_luked
    else
    end
  end
end

restore_all_photos
