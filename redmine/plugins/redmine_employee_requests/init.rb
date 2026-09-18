Redmine::Plugin.register :redmine_employee_requests do
  name 'Employee Requests Plugin'
  author 'Antigravity'
  description 'Employee self-service requests: work from home, permissions, leave, expenses and more'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  menu :top_menu, :employee_requests, { controller: 'employee_requests', action: 'index' }, caption: 'Employee Requests'
end
