class SalesReportsController < ApplicationController
  before_action :set_sales_report, only: [:show, :edit, :update, :destroy]

  def pull_from_repairq
    set_sales_report
    agent = Repairq.first
    # TODO: instantiate agent using first Repairq record

    @sales_report = agent.get_sales_report
  end



  # GET /sales_reports
  # GET /sales_reports.json
  def index
    @sales_reports = SalesReport.all
  end

  # GET /sales_reports/1
  # GET /sales_reports/1.json
  def show
  end

  # GET /sales_reports/new
  def new
    @sales_report = SalesReport.new
  end

  # GET /sales_reports/1/edit
  def edit
  end

  # POST /sales_reports
  # POST /sales_reports.json
  def create
    @sales_report = SalesReport.new(sales_report_params)

    report = Repairq.first.sales_report(date: @sales_report.date)
    @sales_report.net_sales = report[:net_sales]
    @sales_report.open_ticket_sales = report[:open_ticket_sales]
    @sales_report.closed_ticket_sales = report[:closed_ticket_sales]
    @sales_report.deposit = report[:deposit]
    @sales_report.tickets_created = report[:tickets_created]

    respond_to do |format|
      if @sales_report.save
        format.html { redirect_to @sales_report, notice: 'Sales report was successfully created.' }
        format.json { render :show, status: :created, location: @sales_report }
      else
        format.html { render :new }
        format.json { render json: @sales_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_reports/1
  # PATCH/PUT /sales_reports/1.json
  def update
    respond_to do |format|
      if @sales_report.update(sales_report_params)
        format.html { redirect_to @sales_report, notice: 'Sales report was successfully updated.' }
        format.json { render :show, status: :ok, location: @sales_report }
      else
        format.html { render :edit }
        format.json { render json: @sales_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_reports/1
  # DELETE /sales_reports/1.json
  def destroy
    @sales_report.destroy
    respond_to do |format|
      format.html { redirect_to sales_reports_url, notice: 'Sales report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def post_to_group_me
    set_sales_report
    group_me_bot = GroupMeBot.first
    numbers = "Location\n\nall  $#{'%.2f' % (@sales_report.net_sales.to_f/100).to_s}\nopen  $#{'%.2f' % (@sales_report.open_ticket_sales.to_f/100).to_s}\nclosed  $#{'%.2f' % (@sales_report.closed_ticket_sales.to_f/100).to_s}\ndeposit  $#{'%.2f' % (@sales_report.deposit.to_f/100).to_s}\ncreated  #{@sales_report.tickets_created}"
    group_me_bot.post numbers
    #render text: numbers
    redirect_to @sales_report
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_report
      @sales_report = SalesReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_report_params
      params.require(:sales_report).permit(:date, :net_sales, :open_ticket_sales, :closed_ticket_sales, :deposit, :tickets_created)
    end
end
