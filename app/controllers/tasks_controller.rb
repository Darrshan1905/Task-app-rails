class TasksController < ApplicationController
    before_action :correct_user, only: [:new, :create, :destroy, :edit, :update]
    
    def new
        @task = Task.new
    end
    
    def create
        @task = task_service.create_task(params[:project_id], task_params)

        # @project = Project.find(params[:project_id])
        # @task = @project.tasks.new(task_params)

        if @task.save
            redirect_to_project_with_notice("Task created successfully.")
        else
            render 'new'
        end
    end

    def destroy
        task_service.delete_task(params[:id])

        # @project = Project.find(params[:project_id])
        # @task = @project.tasks.find(params[:id])
        # @task.destroy

        redirect_to_project_with_notice("Task deleted successfully.")
    end

    def edit
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])
    end

    def update
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])

        if task_service.update_task(@task, task_params)
            redirect_to_project_with_notice("Task updated successfully.")
        else
            render 'edit'
        end
    end 

    def correct_user
        if current_user
            @project = current_user.projects.find_by(id: params[:project_id])
            @current_project = Project.find(params[:project_id])
            redirect_to project_path(@current_project), alert: "Not authorized to add, edit or delete a task for this project" if @project.nil? && !current_user.admin?
        else
            authenticate
        end
    end

    private

    def task_params
        params.require(:task).permit(:name, :duration, :description, :user_id)
    end

    def task_service
        TaskService.new(current_user)
    end   

    def redirect_to_project_with_notice(notice_message)
        redirect_to project_path(params[:project_id]), notice: notice_message
      end
end
