

package 'java-1.7.0-openjdk-devel'

group 'chef' do
  action :create
end

user 'chef' do
  group 'chef'
end

directory '/opt/tomcat' do
  action :create
  recursive true
end

remote_file '/tmp/apache-tomcat-8.0.47.tar.gz' do
	source 'http://mirror.cc.columbia.edu/pub/software/apache/tomcat/tomcat-8/v8.0.47/bin/apache-tomcat-8.0.47.tar.gz'
end

execute 'extract_tomcat' do
  command 'tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
  cwd '/tmp'
end

execute 'chgrp -R chef /opt/tomcat/conf'

directory '/opt/tomcat/conf' do
  group 'chef'
  mode '0575'
end

execute 'chmod g+r conf/*' do
  cwd '/opt/tomcat'
end

execute 'chown -R chef webapps/ work/ temp/ logs/ conf/' do
  cwd '/opt/tomcat'
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end


