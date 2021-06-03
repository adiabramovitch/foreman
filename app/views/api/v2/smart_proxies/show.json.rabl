object @smart_proxy

extends "api/v2/smart_proxies/main"

node do |hostgroup|
  partial("api/v2/taxonomies/children_nodes", :object => hostgroup)
end

node(:version) { |smart_proxy| smart_proxy.statuses[:version].version['version'] }
child :smart_proxy_features => :features do
  glue :feature do
    attributes :name, :id
    node(:version) do |feature|
      @smart_proxy.statuses[:version].version['modules'][feature["name"].downcase]
    end
  end
end
