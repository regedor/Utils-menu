require 'rubygems'
require 'linode'
require 'crack'
require 'yaml'

class Linode::GB

  TTL_SEC = 86400
  SOA_EMAIL = 'admin@groupbuddies.com'
  API_KEY = 'rf6mpdTZBXNVPpHJajpJeLGAPytY0CBsNBKFK8ABaFHegiUsrQ6UyPDPup5sdnOU'

  # Creates new Linode object, with a given Linode api key (by default, the admin@groupbuddies.com key is used)
  def initialize()
	if File.exist?('config.yml')
	  @config    = YAML::load(File.open('config.yml'))
	end
	@config['linode']['api_key']   ||= 'rf6mpdTZBXNVPpHJajpJeLGAPytY0CBsNBKFK8ABaFHegiUsrQ6UyPDPup5sdnOU'
	@config['linode']['soa_email'] ||= 'admin@groupbuddies.com'
	@config['linode']['ttl_sec']   ||= 86400
    @linode = Linode.new(:api_key => @config['linode']['api_key'])
  end
  
  # Given a domain url, returns its domain id if it exists
  def get_domainid(domain)
	domains = @linode.domain.list.select {|x| x.domain == domain}
	if domains.empty? 
      raise "#{domain} does not exist!"
	else
      domains.first.domainid
	end
  end
  

  # Creates a domain and adds two records (with and without www)
  def add_naruto(domain)
    ip = '178.79.146.28'
  	puts "Creating domain '#{domain}' at '#{ip}'..."
  
  	domainid = @linode.domain.create(
	  :domain => domain,
	  :type => 'master',
	  :soa_email => SOA_EMAIL).domainid
	
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'A',     
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => ip)
  
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'A',     
      :name => 'www',       
      :ttl_sec => TTL_SEC, 
      :target => ip)
  end
  
  # Adds the common Google Apps records to an existing domain
  def add_google_apps(domain)
    domainid = self.get_domainid(domain)
  	puts "Adding Google Apps records for '#{domain}'..."
  
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'CNAME', 
      :name => 'mail',      
      :ttl_sec => TTL_SEC, 
      :target => 'ghs.google.com')
  
    @linode.domain.resource.create(:domainid => domainid, 
      :type => 'MX',    
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => 'ASPMX.L.GOOGLE.COM',      
      :priority => 1)
  
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'MX',    
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => 'ASPMX2.GOOGLEMAIL.COM',   
      :priority => 10)
  
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'MX',    
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => 'ASPMX3.GOOGLEMAIL.COM',   
      :priority => 10)
  
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'MX',    
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => 'ASPMX4.GOOGLEMAIL.COM',   
      :priority => 10)
  
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'MX',    
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => 'ASPMX5.GOOGLEMAIL.COM',   
      :priority => 10)
    
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'MX',    
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => 'ALT1.ASPMX.L.GOOGLE.COM', 
      :priority => 5)
  
    @linode.domain.resource.create(
      :domainid => domainid, 
      :type => 'MX',    
      :name => domain, 
      :ttl_sec => TTL_SEC, 
      :target => 'ALT2.ASPMX.L.GOOGLE.COM', 
      :priority => 5)
  end

  # Adds the Google Apps verification record to an existing domain
  def add_gapps_verif(domain,token)
    domainid = self.get_domainid(domain)
    @linode.domain.resource.create(
	  :domainid => domainid,
	  :type => 'TXT',
	  :name => '',
	  :target => "google-site-verification=#{token}",
	  :ttl_sec => 3600)
  end

end

