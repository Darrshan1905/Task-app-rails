class CommentService
    def initialize(user)
      @user = user
    end
  
    def create_comment(project_id, task_id, params)
      project = Project.find_by(id: project_id)
      return unless project
  
      task = project.tasks.find_by(id: task_id)
      return unless task
    
      task.comments.create(params)
    end
  
    def delete_comment(comment_id)
      comment = Comment.find_by(id: comment_id)
      return unless comment
  
      comment.destroy
    end
end
  