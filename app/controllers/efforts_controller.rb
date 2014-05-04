class EffortsController < ApplicationController
  # GET /efforts
  # GET /efforts.xml

  require 'date'

  @userOptions
  @taskOptions
  @userOptions2
  @taskOptions2
  @taskDate
  @users
  @tasks

  def index
    @efforts = Effort.all
    helper 1
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @efforts }
    end
  end

  # GET /efforts/1
  # GET /efforts/1.xml
  def show
    helper 1
    @effort = Effort.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @effort }
    end
  end

  # GET /efforts/new
  # GET /efforts/new.xml
  def new
    helper 0
    @effort = Effort.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @effort }
    end
  end

  # GET /efforts/1/edit
  def edit
    @effort = Effort.find(params[:id])
    helper 0
    @users = Users.find(:all)
    @tasks = Tasks.find(:all)

    @userOptions2 = Hash.new
    @taskOptions2 = Hash.new


      @users.each do |var|
        @userOptions2.store(var.id, var.user_name)
      end

      @tasks.each do |var|
        @taskOptions2.store(var.id, var.task_name)
      end
  end

  # POST /efforts
  # POST /efforts.xml
  def create
    @effort = Effort.new(params[:effort])
    datehash = params[:taskDate]
    @effort.task_date = Date.parse(datehash["taskDate(1i)"].to_s+'-'+datehash["taskDate(2i)"].to_s+'-'+datehash["taskDate(3i)"].to_s)

    respond_to do |format|
      if @effort.save
        format.html { redirect_to(@effort, :notice => 'Effort was successfully created.') }
        format.xml  { render :xml => @effort, :status => :created, :location => @effort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /efforts/1
  # PUT /efforts/1.xml
  def update
    @effort = Effort.find(params[:id])
    
    respond_to do |format|
      if @effort.update_attributes(params[:effort])
        format.html { redirect_to(@effort, :notice => 'Effort was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /efforts/1
  # DELETE /efforts/1.xml
  def destroy
    @effort = Effort.find(params[:id])
    @effort.destroy

    respond_to do |format|
      format.html { redirect_to(efforts_url) }
      format.xml  { head :ok }
    end
  end

  def helper(var)
    @users = Users.find(:all)
    @tasks = Tasks.find(:all)

    @userOptions = Hash.new
    @taskOptions = Hash.new

    if(var == 0)
      @users.each do |var|
        @userOptions.store(var.user_name, var.id)
      end

      @tasks.each do |var|
        @taskOptions.store(var.task_name, var.id)
      end
    else
      @users.each do |var|
        @userOptions.store(var.id, var.user_name)
      end

      @tasks.each do |var|
        @taskOptions.store(var.id, var.task_name)
      end
    end
  end

  def report
    helper 1
    months = [31,29,31,30,31,30,31,31,30,31,30,31]
    time = Time.new
    start_date = Date.parse('1-'+time.month.to_s+'-'+time.year.to_s).to_s
    puts start_date
    end_date = Date.parse(months[time.month.to_i-1].to_s+'-'+time.month.to_s+'-'+time.year.to_s).to_s
    puts end_date
    query = "SELECT user_id, task_id, count(task_id) as task_count
                  FROM efforts WHERE task_date BETWEEN '" + start_date + "' AND '" + end_date + "' GROUP BY user_id, task_id order by user_id"
    puts query
    points_hash = Hash.new
    @tasks.each do |t|
      points_hash.store(t.id, t.credit)
    end
    @efforts = Effort.find_by_sql(query)

    @user_points_hash = Hash.new
    @user_task_count = Hash.new
    @count = 0
    @sum = 0
    preval = curval = nil
    @efforts.each do |e|
      curval = e.user_id
      if(preval != nil && curval != preval)
        @user_points_hash.store(preval,@sum)
        @user_task_count.store(preval,@count)
        @sum = 0
        @count = 0
      end
      @sum += e.task_count.to_i*points_hash[e.task_id]
      @count+=1
      preval = curval
    end
    @user_points_hash.store(preval,@sum)
    @user_task_count.store(preval,@count)
  end
end
