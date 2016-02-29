class PathsController < ApplicationController
  def index
    @paths = Path.all
  end

  def show
    @path = Path.find(params[:id])
  end

  def scan
    @path = Path.find(params[:id])
    PathScanJob.perform_later @path
    flash[:notice] = 'Added job to scan path'
    redirect_to @path
  end

  def new
    @path = Path.new
  end

  def edit
    @path = Path.find(params[:id])
  end

  def create
    @path = Path.new(path_params)
    if @path.save
      redirect_to @path
    else
      render 'new'
    end
  end

  def update
    @path = Path.find(params[:id])
    if @path.update(path_params)
      redirect_to @path
    else
      render 'edit'
    end
  end

  def destroy
    @path = Path.find(params[:id])
    @path.destroy

    redirect_to paths_path
  end

  private
    def path_params
      params.require(:path).permit(:path)
    end
end
