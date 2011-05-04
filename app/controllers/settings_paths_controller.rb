class SettingsPathsController < ApplicationController
  # GET /settings_paths
  # GET /settings_paths.xml
  def index
    @settings_paths = SettingsPath.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settings_paths }
    end
  end

  # GET /settings_paths/1
  # GET /settings_paths/1.xml
  def show
    @settings_path = SettingsPath.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @settings_path }
    end
  end

  # GET /settings_paths/new
  # GET /settings_paths/new.xml
  def new
    @settings_path = SettingsPath.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @settings_path }
    end
  end

  # GET /settings_paths/1/edit
  def edit
    @settings_path = SettingsPath.find(params[:id])
  end

  # POST /settings_paths
  # POST /settings_paths.xml
  def create
    @settings_path = SettingsPath.new(params[:settings_path])

    respond_to do |format|
      if @settings_path.save
        flash[:notice] = 'SettingsPath was successfully created.'
        format.html { redirect_to(@settings_path) }
        format.xml  { render :xml => @settings_path, :status => :created, :location => @settings_path }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @settings_path.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settings_paths/1
  # PUT /settings_paths/1.xml
  def update
    @settings_path = SettingsPath.find(params[:id])

    respond_to do |format|
      if @settings_path.update_attributes(params[:settings_path])
        flash[:notice] = 'SettingsPath was successfully updated.'
        format.html { redirect_to(@settings_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @settings_path.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /settings_paths/1
  # DELETE /settings_paths/1.xml
  def destroy
    @settings_path = SettingsPath.find(params[:id])
    @settings_path.destroy

    respond_to do |format|
      format.html { redirect_to(settings_paths_url) }
      format.xml  { head :ok }
    end
  end
end
