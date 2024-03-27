class ProjectService
    def initialize(user)
      @user = user
    end
  
    def create_project(params)
      @user.projects.create(params)
    end
  
    def update_project(project, params)
      project.update(params)
    end
  
    def delete_project(project)
      project.destroy
    end
end