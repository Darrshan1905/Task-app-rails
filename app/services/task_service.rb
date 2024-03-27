class TaskService
    def initialize(user)
      @user = user
    end
  
    def create_task(project_id, params)
      project = @user.projects.find_by(id: project_id)
      return unless project
  
      project.tasks.create(params)
    end
  
    def update_task(task, params)
      task.update(params)
    end
  
    def delete_task(task_id)
      task = Task.find_by(id: task_id)
      return unless task
  
      task.destroy
    end
  end