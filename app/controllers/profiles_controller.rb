class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      redirect_to @profile, notice: "Profile was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy!

    redirect_to profiles_path, status: :see_other, notice: "Profile was successfully destroyed."
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :following, :followers, :stars, :repos, :address, :company)
  end
end
