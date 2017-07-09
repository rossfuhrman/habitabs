class JournalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  def index
    @journals = Journal.all.order('date DESC')
  end

  def show
  end

  def new
    @journal = Journal.new
    @journal.date = params[:date]
  end

  def edit
  end

  def create
    @journal = Journal.new(journal_params)

    respond_to do |format|
      if @journal.save
        format.html { redirect_to @journal, notice: 'Journal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @journal }
      else
        format.html { render action: 'new' }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.html { redirect_to @journal, notice: 'Journal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @journal.destroy
    respond_to do |format|
      format.html { redirect_to journals_url }
      format.json { head :no_content }
    end
  end

  private

    def set_journal
      @journal = current_user.journals.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def journal_params
      params.require(:journal).permit(:entry, :date, :user_id).merge(user_id: current_user.id)
    end
end
