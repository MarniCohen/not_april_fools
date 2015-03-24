require 'rubygems'
#require 'active_ldap'
require 'net/ldap'
require 'yaml'

def ldap_bind
  config = YAML.load(File.read('etc/config.yaml'))
  ldap_host = config['host']
  ldap_dn = config['dn']
  ldap_port = config['port']
  ldap_pass = config['pass']

  ldap = Net::LDAP.new :host => ldap_host,
                       :port => ldap_port,
                       :encryption => :simple_tls,
                       :auth => {
                          :method => :simple,
                          :username => ldap_dn,
                          :password => ldap_pass
  }
  read_all_users(ldap)
end

def read_all_users(ldap)
  filter = Net::LDAP::Filter.eq("uid", "*")
  ldap.search(:base => "dc=puppetlabs,dc=com", :filter => filter) do |entry|
    if entry[:jpegphoto]
      ldap_photo = entry[:jpegphoto].inspect
      uid = entry[:uid].inspect
      photo_path = "ldap_photos/#{uid}.jpg"
      File.open(photo_path, 'wb') { |f| f.write(ldap_photo) }
    else
    end
  end
end

def upload(var)
end

def read_attr(attr)
end

def write_attr(attr, value)
end

ldap_bind
