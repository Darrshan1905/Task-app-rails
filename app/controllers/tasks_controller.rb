class TasksController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @task = Task.new
    end
    def create
        @project = Project.find(params[:project_id])
        @task = @project.tasks.new(task_params)

        if @task.save
            redirect_to project_path(@project)
        else
            render 'new'
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])
        @task.destroy
        redirect_to project_path(@project)
    end

    def edit
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])
    end

    def update
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])

        if @task.update(task_params)
            redirect_to project_path(@project)
        else
            render 'edit'
        end
    end

    private

    def task_params
        params.require(:task).permit(:name, :duration, :description)
    end
end
