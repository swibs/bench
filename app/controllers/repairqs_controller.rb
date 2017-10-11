class RepairqsController < ApplicationController
  before_action :set_repairq, only: [:show, :edit, :update, :destroy]



  def test_login
    set_repairq
    if username = @repairq.username
      render html: "Successfully logged in is #{username}"
    else
      render html: "Cannot get username"
    end
  end

  def todays_sales
    set_repairq
    render html: @repairq.sales_report(date: Date.today.to_s).inspect
  end


  # GET /repairqs
  # GET /repairqs.json
  def index
    @repairqs = Repairq.all
  end

  # GET /repairqs/1
  # GET /repairqs/1.json
  def show
  end

  # GET /repairqs/new
  def new
    @repairq = Repairq.new
  end

  # GET /repairqs/1/edit
  def edit
  end

  # POST /repairqs
  # POST /repairqs.json
  def create
    @repairq = Repairq.new(repairq_params)

    respond_to do |format|
      if @repairq.save
        format.html { redirect_to @repairq, notice: 'Repairq was successfully created.' }
        format.json { render :show, status: :created, location: @repairq }
      else
        format.html { render :new }
        format.json { render json: @repairq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repairqs/1
  # PATCH/PUT /repairqs/1.json
  def update
    respond_to do |format|
      if @repairq.update(repairq_params)
        format.html { redirect_to @repairq, notice: 'Repairq was successfully updated.' }
        format.json { render :show, status: :ok, location: @repairq }
      else
        format.html { render :edit }
        format.json { render json: @repairq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repairqs/1
  # DELETE /repairqs/1.json
  def destroy
    @repairq.destroy
    respond_to do |format|
      format.html { redirect_to repairqs_url, notice: 'Repairq was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repairq
      @repairq = Repairq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repairq_params
      params.require(:repairq).permit(:name, :server, :location, :default_login, :default_pin)
    end
end
