package 'haproxy' do
        action :install
end

template '/etc/haproxy/haproxy.cfg' do
        source 'haproxy.cfg.erb'
        variables({
                :tomcatservers => search(:node,"role:tomcat"),
                :publicip => node[:cloud][:local_ipv4]
        })
        notifies :restart, 'service[haproxy]'
end

cookbook_file '/etc/default/haproxy' do
        source 'haproxy'
        mode "0644"
        notifies :restart, 'service[haproxy]'
end

service 'haproxy' do
        action [:enable, :start]
end

