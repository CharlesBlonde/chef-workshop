#
# Cookbook Name:: cocktail
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#mongodbservers = search(:node,"role:mongodb")
template "/etc/tomcat7/catalina.properties" do
        source 'catalina.properties.erb'
        variables({
                :mongodbservers => search(:node,"role:mongodb")
        })
        notifies :restart, 'service[tomcat7]'
end

cookbook_file "/var/lib/tomcat7/webapps/cocktail.war" do
        source "cocktail.war"
        mode "0644"
        notifies :restart, 'service[tomcat7]'
end

service 'tomcat7' do
        action [:enable, :start]
end

