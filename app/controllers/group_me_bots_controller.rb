class GroupMeBotsController < ApplicationController
  before_action :set_group_me_bot, only: [:show, :edit, :update, :destroy]

  # GET /group_me_bots
  # GET /group_me_bots.json
  def index
    @group_me_bots = GroupMeBot.all
  end

  # GET /group_me_bots/1
  # GET /group_me_bots/1.json
  def show
  end

  # GET /group_me_bots/new
  def new
    @group_me_bot = GroupMeBot.new
  end

  # GET /group_me_bots/1/edit
  def edit
  end

  # POST /group_me_bots
  # POST /group_me_bots.json
  def create
    @group_me_bot = GroupMeBot.new(group_me_bot_params)

    respond_to do |format|
      if @group_me_bot.save
        format.html { redirect_to @group_me_bot, notice: 'Group me bot was successfully created.' }
        format.json { render :show, status: :created, location: @group_me_bot }
      else
        format.html { render :new }
        format.json { render json: @group_me_bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_me_bots/1
  # PATCH/PUT /group_me_bots/1.json
  def update
    respond_to do |format|
      if @group_me_bot.update(group_me_bot_params)
        format.html { redirect_to @group_me_bot, notice: 'Group me bot was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_me_bot }
      else
        format.html { render :edit }
        format.json { render json: @group_me_bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_me_bots/1
  # DELETE /group_me_bots/1.json
  def destroy
    @group_me_bot.destroy
    respond_to do |format|
      format.html { redirect_to group_me_bots_url, notice: 'Group me bot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def test
    dummy_numbers = "Location Name (automated)\n\nall  $644.98\nopen  $55.00\nclosed  $589.96\n\ndeposit  $131.87\ncreated  8"
    set_group_me_bot
    @result = @group_me_bot.post(dummy_numbers)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_me_bot
      @group_me_bot = GroupMeBot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_me_bot_params
      params.require(:group_me_bot).permit(:token, :bot_id, :name)
    end
end
