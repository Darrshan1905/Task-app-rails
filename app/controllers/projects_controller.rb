class ProjectsController < ApplicationController
    # before_action :authenticate_user!, except: [:index, :show]
    before_action :authenticate, only: [:new, :create]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def new
        # @project = Project.new
        @project = current_user.projects.build
    end

    def create
        # @project = Project.new(project_params)
        @project = current_user.projects.build(project_params)

        if @project.save
            redirect_to @project
        else
            render 'new'
        end
    end

    def index
        @projects = Project.all
    end

    def show
        @project = Project.find(params[:id])
    end 

    def edit
        @project = Project.find(params[:id])
    end

    def update
        @project = Project.find(params[:id])

        if @project.update(project_params)
            redirect_to @project
        else
            render 'edit'
        end
    end

    def destroy
        @project = Project.find(params[:id])

        @project.destroy

        redirect_to projects_path
    end

    def search
        @projects = Project.where("title LIKE ?","%" + params[:key] + "%")
    end

    def task_search
        @project = Project.find(params[:project_id])
        @tasks = @project.tasks.where("name LIKE ?", "%" + params[:key] + "%")
    end
    
    def correct_user
        if current_user
            @project = current_user.projects.find_by(id: params[:id])
            redirect_to projects_path, alert: "Not authorized to edit or delete this project" if @project.nil? && !current_user.admin?
        else
            authenticate
        end
    end

    private 

    def project_params
        params.require(:project).permit(:title, :start_date, :end_date, :user_id)
    end
end
