require './app/controllers/index_controller.rb'
require './app/controllers/users_controller.rb'

class Router  
  ROUTES = {
    "/index" => {
      GET: IndexController,
    },
    "/users" => {
      GET: UsersController,
    },
  }

  def route(str)
    Keeper.logger.info("Received #{str}")
    Keeper.logger.info([str, str.split])
    verb, path, _ = str.split
    path, query = path.split("?")        
    path = path.split("/").reject(&:empty?)
    Keeper.logger.info("/#{path[0]}")
    ROUTES["/#{path[0]}"]&.[](verb.to_sym)
  end
end
