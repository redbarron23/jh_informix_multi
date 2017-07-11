# http://www-01.ibm.com/support/docview.wss?uid=swg21504585

# system related stuff
package 'ksh'
package 'git'
package 'libaio'

 template '/etc/sysctl.conf' do
   source 'sysctl.conf.erb'
   owner 'root'
   group 'root'
   mode '0644'
 end
 
 template '/etc/security/limits.conf' do
   source 'limits.conf.erb'
   owner 'root'
   group 'root'
   mode '0644'
 end
 
 # Stating informix configuration 
 group "informix" do
   action :create
   not_if { etc.getgrnam("informix") rescue nil  }
 end
 
 user "informix" do
   gid "informix"
   home "/home/informix"
   manage_home true
   shell "/bin/bash"
   not_if { Etc.getpwnam("informix") rescue nil  }
 end
 
 directory '/home/informix' do
   owner 'informix'
   group 'informix'
   mode '0750'
   action :create
 end
 
 directory '/opt/Informix_Software_Bundle' do
   owner 'informix'
   group 'informix'
   mode '0755'
   action :create
 end
 
 # needs to be refactored for install from artifactory
 package 'informix' do
   action :install
   source '/home/ec2-user/informix-12.0-1.x86_64.rpm'
   provider Chef::Provider::Package::Rpm
 end
 
 directory '/opt/Informix_Software_Bundle' do
   owner 'informix'
   group 'informix'
   mode '0755'
   recursive true
 end
 
 %w[ /infxdwdb /infxoltpdb ].each do |path|  
   directory path do
   owner 'informix'
   group 'informix'
   mode '0770'
   recursive true
   end
 end

#===================================
# needs to be moved to another recipe 
# because this will clobber the DB
#===================================
#file '/infxdwdb/efdwrootdbs' do
#  mode '0600'
#  owner 'informix'
#  group 'informix'
#end

#file '/infxoltpdb/efdwrootdbs' do
#  mode '0600'
#  owner 'informix'
#  group 'informix'
#end
 
 template '/home/informix/.bashrc' do
   source '.bashrc.erb'
   owner 'informix'
   group 'informix'
   mode '0640'
 end
 
 template '/etc/services' do
   source 'services.erb'
   owner 'root'
   group 'root'
   mode '0644'
 end
 
 template '/opt/Informix_Software_Bundle/etc/onconfig.efdb' do
   source 'onconfig.efdb.erb'
   owner 'informix'
   group 'informix'
   mode '0644'
 end
 
 template '/opt/Informix_Software_Bundle/etc/onconfig.efdw' do
   source 'onconfig.efdw.erb'
   owner 'informix'
   group 'informix'
   mode '0644'
 end
 
 template '/opt/Informix_Software_Bundle/etc/sqlhosts' do
   source 'sqlhosts.erb'
   owner 'informix'
   group 'informix'
   mode '0644'
 end
 
