class InformsController < ApplicationController


  def index
    @inform =  Inform.all
  end


  def create

     @inform = Inform.new(inform_params)
    if @inform.save
     redirect_to informs_path,flash: {success: "公告提交成功"}
    else
      flash[:warning] = "公告失败"
    end

  end

  def show
    @inform = Inform.find(params[:id])
  end

  def edit
    @inform=Inform.find_by_id(params[:id])
  end

  def update
    @inform=Inform.find_by_id(params[:id])
    if @inform.update(inform_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
      redirect_to informs_path,flash: flash
  end

  def destroy
    @inform=Inform.find_by_id(params[:id])
    @inform.destroy
    flash={:success => "成功删除公告: #{@inform.name}"}
    redirect_to informs_path,flash:flash
  end


  def new
  end


private
 def inform_params
   params.require(:inform).permit(:name,:context)
 end

end

