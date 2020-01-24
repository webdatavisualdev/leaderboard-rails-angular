class ReceiverController < ApplicationController
    before_action :cors_set_access_control_headers
    after_action :cors_set_access_control_headers

    def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

    #Post
    def post
        if params[:token] == 'FT7E3Y68UPA6'
            if Car.create(car_params)
                render json: { message: 'success' }, status: 200
            else
                render json: { message: 'something wrong' }, status: 400
            end
        else
            render json: { message: 'invalid token' }, status: 400
        end
    rescue => e
        puts e.inspect
        render json: { message: 'something wrong' }, status: 400
    end

    def get
        @cars = Car.last(10)
        render json: @cars
    end

    private

    def car_params
        params.require(:leaderboard).map{|c| c.permit(:driver_name, :country, :car_number, :car_colour, :position, :interval, :pitting, :last_lap)}
    end
end
