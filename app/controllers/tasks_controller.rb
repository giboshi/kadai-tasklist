class TasksController < ApplicationController
  #before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
        
  def index
    #if logged_in?
     # @task = current_user.tasks.build  # form_for 用
      #@tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    #end
  end
    
  def show
    #@task = Task.find(params[:id])
    #redirect_to root_url unless @task.user == current_user
  end
    
  def new
   # @task = Task.new
    @task = current_user.tasks.new
  end
    
  def create
    #@task = Task.new(task_params)
        
    #if @task.save
    #  flash[:success] = 'Taskが正常に投稿されました'
    #  redirect_to @task
    #else
    #  flash.now[:danger] = 'Taskが投稿されませんでした'
    #  render :new
    #end
    
    
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render :new
    end
  end
    
  def edit
    # @task = Task.find(params[:id])
    # redirect_to root_url unless @task.user == current_user
  end
    
  def update
  #  if @task.update(task_params)
   #   flash[:success] = 'Taskが正常に更新されました'
    #  redirect_to @task
    #else
    #  flash.now[:danger] = 'Taskが更新されませんでした'
    #  render :edit
    #end
    if @task.update(task_params)
      flash[:success] = '正常に更新されました。'
      redirect_to root_url
    else
      flash.now[:danger] = '正常に更新されませんでした。'
      render :edit
    end
  end
    
  def destroy
    #@task.destroy
        
    #flash[:success] = 'Taskは正常に削除されました'
    #redirect_to tasks_url
    
    @task.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: root_path)
  end
    
  private
    
  #def set_task
  #  @task = Task.find(params[:id])
  #end
    
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
    # @task = Task.find(params[:id])
    # redirect_to root_url unless @task.user == current_user
  end
end

