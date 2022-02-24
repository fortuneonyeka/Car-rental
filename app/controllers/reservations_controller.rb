class ReservationsController < ApplicationController
  # before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :user_signed_in?, only: [:show, :edit, :index, :new, :create, :pickup, :returncar, :cancel, :destroy]

  require 'date'
  Time.zone = 'Eastern Time (US & Canada)'

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    car_id = reservation_params[:car_id]
    user_id = reservation_params[:user_id]
    if user_id==""
      flash[:danger] = "You should select a user."
      redirect_to new_reservation_path(:car_id => car_id)
      return
    end
    unless Car.find(car_id).status == "Available"
      flash[:danger] = "This car is not available."
      redirect_to cars_path
      return
    end
    user = User.find(user_id)
    if user.available
      @reservation = Reservation.new(reservation_params)
      if @reservation.save
        flash[:success] = 'Reservation was successfully created.'
        PickupCheckJob.set(wait_until: @reservation.checkOutTime + 30.minutes).perform_later(@reservation.id)
        redirect_to @reservation
        car = Car.find(@reservation.car_id)
        car.update_attribute(:status, "Reserved")
        user.update_attribute(:available, false)
      else
        if @reservation.errors.any?
          @reservation.errors.full_messages.each do |message|
            flash[:errors] = message
        end
      end
      redirect_to new_reservation_path(:car_id => car_id)
    end
    else
      flash[:danger] = "This user have a car in hold, and cannot reserve another car until you return it."
      redirect_to user
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    @reservation = Reservation.find(params[:id])
      if @reservation.update(reservation_params)
        flash[:success] = 'Reservation is successfully updated'
        redirect_to @reservation
        else
          render :edit
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation = Reservation.find(params[:id])
    User.find(reservation.user_id).update_attribute(:available, true)
    Car.find(reservation.car_id).update_attribute(:status, "Available")
    @reservation.destroy
    flash[:success] = 'Reservation deleted'
    redirect_to reservations_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:checkOutTime, :pickUpTime, :expectedReturnTime, :returnTime, :status, :user_id, :car_id)
    end
end
