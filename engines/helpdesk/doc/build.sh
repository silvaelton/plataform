rails g scaffold status name
rails g scaffold order_service opened_by required_by sector:references branch_line:references user:references good:references status:references
rails g scaffold qualification name status:boolean order_service:references
rails g scaffold monitor_service_order appointment:text attachment name status:boolean order_service:references
