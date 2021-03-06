class TasksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  before_filter :find_task, only: [:update, :destroy]
  before_filter :setup_order, only: :index

  def index
    tasks = current_user.tasks.order(@order)
    tasks = tasks.send(params[:status]) if params[:status]
    respond_with tasks
  end

  def create
    respond_with current_user.tasks.create(task_params)
  end

  def update
    @task.update_attributes(task_params)
    respond_with @task
  end

  def destroy
    respond_with @task.destroy
  end

  private

  def find_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed, :priority, :due_date)
  end

  def setup_order
    order_by  = params[:order_by] || 'priority'
    direction = params[:direction] || 'asc'
    @order = "#{order_by} #{direction}"
  end
end
