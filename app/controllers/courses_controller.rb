class CoursesController < ApplicationController

  before_action :student_logged_in, only: [:select, :quit, :list]
  before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update, :open, :close]#add open by qiao
  before_action :logged_in, only: :index

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
  end
  def show
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @course=Course.find_by_id(params[:id])
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      @course.save
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def open
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: true)
    @course.save
    redirect_to courses_path, flash: {:success => "已经成功开启该课程:#{ @course.name}"}
  end

  def close
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: false)
    @course.save
    redirect_to courses_path, flash: {:success => "已经成功关闭该课程:#{ @course.name}"}
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    current_user.teaching_courses.delete(@course)
    @course.destroy
    @course.save
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  #-------------------------for students----------------------

  def list
    #-------QiaoCode--------
    @courses = Course.where(:open=>true).paginate(page: params[:page], per_page: 4)
    @course = @courses-current_user.courses
    tmp=[]
    @course.each do |course|
      if course.open==true
        tmp<<course
      end
    end
    @course=tmp
  end

  def select
    @course=Course.find_by_id(params[:id])
    flag=0

    current_user.courses.each do |course|
      if course.name==@course.name
        flag=1
      end


      if course.course_time==@course.course_time
        flag=2
      end


      if @course.limit_num != nil
         if @course.limit_num <= @course.student_num
        flag=3
         end
      end
    end

    if flag==0
       current_user.courses<<@course
       @course.student_num += 1
       @course.save
       flash={:suceess => "成功选择课程: #{@course.name}"}

    end
    if flag==1
        flash={:fail => "选课失败，你已选择该课程: #{@course.name}"}
    end

    if flag==2
        flash={:fail => "选课失败，选课时间冲突: #{@course.name}"}
    end

    if flag==3
        flash={:fail => "选课失败，选课人数超限: #{@course.name}"}
    end


    redirect_to courses_path, flash: flash
  end


  def schedule
     @courses=current_user.courses
     @course_Mon = Array.new(5)
     @course_Tus = Array.new(5)
     @course_Wed = Array.new(5)
     @course_Thu = Array.new(5)
     @course_Fri = Array.new(5)
     @courses.each do |course|
       if course.course_time == "周一(1-2)"
         @course_Mon[0] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周一(3-4)"
         @course_Mon[1] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周一(5-7)"
         @course_Mon[2] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周一(9-11)"
         @course_Mon[4] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周二(1-2)"
         @course_Tus[0] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周二(3-4)"
         @course_Tus[1] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周二(5-7)"
         @course_Tus[2] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周二(9-11)"
         @course_Tus[4] = course.name+"\n"+course.course_week
       end

       if course.course_time == "周三(1-2)"
         @course_Wed[0] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周三(3-4)"
         @course_Wed[1] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周三(5-7)"
         @course_Wed[2] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周三(9-11)"
         @course_Wed[4] = course.name+"\n"+course.course_week
       end

       if course.course_time == "周四(1-2)"
         @course_Thu[0] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周四(3-4)"
         @course_Thu[1] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周四(5-7)"
         @course_Thu[2] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周四(9-11)"
         @course_Thu[4] = course.name+"\n"+course.course_week
       end

       if course.course_time == "周五(1-2)"
         @course_Fri[0] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周五(3-4)"
         @course_Fri[1] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周五(5-7)"
         @course_Fri[2] = course.name+"\n"+course.course_week
       end
       if course.course_time == "周五(9-11)"
         @course_Fri[4] = course.name+"\n"+course.course_week
       end
     end

  end

  def filter

  #  @courses = Course.where("course_type => '专业核心课'").paginate(page: params[:page],per_page:4)
    @Select_exam_type=params[:select_exam_type]
    @Select_course_type=params[:select_course_type]
    @Select_credit=params[:select_credit]

    @courses = Course.where(:open=>true).paginate(page: params[:page], per_page: 4)
    @course = @courses-current_user.courses

    if( @Select_course_type!="" && @Select_exam_type=="" &&@Select_credit=="")
        tmp=[]
      @course.each do |course|
        if course.course_type == @Select_course_type
             tmp<<course
        end
      end

    @course=tmp
    end

    if(@Select_exam_type != "" && @Select_credit=="" && @Select_course_type =="")
        tmp=[]
      @course.each do |course|
        if course.exam_type == @Select_exam_type
             tmp<<course
        end
      end
    @course=tmp
    end

    if(@Select_exam_type == "" && @Select_credit!="" && @Select_course_type =="")
        tmp=[]
      @course.each do |course|
        if course.credit == @Select_credit
             tmp<<course
        end
      end
    @course=tmp
    end


    if(@Select_exam_type != "" && @Select_credit!="" && @Select_course_type !="")
        tmp=[]
      @course.each do |course|
        if course.credit == @Select_credit && course.course_type ==@Select_course_type && course.exam_type == @Select_exam_type
             tmp<<course
        end
      end
    @course=tmp
    end
 end


  def credit
    @courses = current_user.courses
    @degree_credit = 0
    @get_degree_credit=0
    @sum_credit=0
    @get_sum_credit=0
    @public_credit=0
    @get_public_credit=0
    @public_must_credit
    @get_pubilc_must_credit=0

    @courses.each do |course|
         @credit = course.credit[3..5]

      if course.name == "中国特色社会主义理论与实践研究"
         @public_must_credit = @public_must_credit + course.name+"("+@credit + "学分"+")"+"\n"
      end

      if course.name == "自然辩证法概论"
         @public_must_credit = @public_must_credit + course.name+"("+@credit + "学分"+")"+"\n"
      end

      if course.name == "硕士学位英语"
         @public_must_credit = @public_must_credit + course.name+"("+@credit + "学分"+")"+"\n"
      end


       if course.course_type=="公共必修课"
         current_user.grades.each do |grade|
           if grade.grade != nil
             if grade.course.name == course.name && grade.grade >= 60
                @get_publici_must_credit += @credit.to_f
             end
           end
         end
       end

       if course.course_degree=="是"
         @degree_credit += @credit.to_f
         current_user.grades.each do |grade|
           if grade.grade != nil
             if grade.course.name == course.name && grade.grade >= 60
                @get_degree_credit += @credit.to_f
             end
           end
         end
      end


       if course.course_type=="公共选修课"
         @public_credit += @credit.to_f
         current_user.grades.each do |grade|
           if grade.grade != nil
             if grade.course.name == course.name && grade.grade >= 60
                @get_public_credit += @credit.to_f
             end
           end
         end
       end

        @sum_credit += @credit.to_f

    end

         current_user.grades.each do |grade|
           if grade.grade != nil && grade.grade >= 60
                @get_sum_credit += @credit.to_f
           end
         end

  end


  def quit
    @course=Course.find_by_id(params[:id])
    current_user.courses.delete(@course)
    @course.student_num -=1
    @course.save
    flash={:success => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end


  #-------------------------for both teachers and students----------------------

  def index
    @course=current_user.teaching_courses.paginate(page: params[:page], per_page: 4) if teacher_logged_in?
    @course=current_user.courses.paginate(page: params[:page], per_page: 4) if student_logged_in?
  end


  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num,:student_num, :class_room, :course_time, :course_week,:course_degree)
  end


end
