class TestSuitesController < ApplicationController
  before_action :set_test_suite, only: [:show, :edit, :update, :destroy, :archive, :unarchive]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy, :archive, :unarchive]

  def index
    @test_suites = current_account.test_suites.where(archived: false)
  end

  def new
    @test_suite = current_account.test_suites.new
    load_prompts_and_user_prompts
  end

  def create
    @test_suite = current_account.test_suites.new(test_suite_params)
    @test_suite.user_id = current_user.id
    @test_suite.account_id = current_account.id
    if @test_suite.save
      redirect_to @test_suite, notice: 'Test created.'
    else
      load_prompts_and_user_prompts
      Rails.logger.info @test_suite.errors.inspect
      flash.now[:alert] = @test_suite.errors.full_messages.join(', ')
      render :new
    end
  end

  def archive
    @test_suite.archived = true
    @test_suite.save
    redirect_to test_suites_path, notice: 'Test archived'
  end

  def unarchive
    @test_suite.archived = false
    @test_suite.save
    redirect_to test_suites_path, notice: 'Test unarchived'
  end

  def show
  end

  def edit
    load_prompts_and_user_prompts
  end

  def update
    if @test_suite.update(test_suite_params)
      redirect_to @test_suite, notice: 'Test suite was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @test_suite.destroy
    redirect_to test_suites_url, notice: 'Test suite was successfully destroyed.'
  end

  private

  def authorize_user!
    if current_account != TestSuite.find(params[:id]).account
      redirect_to root_path, notice: "Whoops. You do not have access to that test."
    end
  end

  def load_prompts_and_user_prompts
    @prompts = current_account.prompts
    @user_prompts = current_account.user_prompts
  end

  def set_test_suite
    @test_suite = TestSuite.find(params[:id])
  end

  def test_suite_params
    params.require(:test_suite).permit(:name, prompt_ids: [], user_prompt_ids: [])
  end
end
