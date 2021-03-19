class UsersController < ApplicationController
    before_action :authorized, only: [:persist]

    def index 
        users = User.all 
        render json: users
    end

    def show
        if (user = User.find_by(id: params[:id]))
            render json: user
        else
            render json: {message: "User not found"}
        end
    end

    def login 
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            # has_secure_password contains authenticate method
            wristband = encode_token({user_id: @user.id})
            render json: { user: UserSerializer.new(@user), token: wristband }
        else
            # this else statement is not being hit for whatever reason
            render json: { message: 'Wrong username/password', status: 500 }
        end
    end

    def create
        @user = User.create(user_params)
        
        if @user.valid?
            wristband = encode_token({user_id: @user.id})
            render json: @user, token: wristband 
        else
            render json: {message: 'Username already taken', status: 500}
        end
    end

    def update_location
        @user = User.find(params[:id])

        @location = Location.find_by(country: params[:country])

        if @user.valid? && @location 

            @user.update(location: @location)
            render json: @user
        else
            render json: {error: "Location update failed"}, status: 500
        end
    end


    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        render json: @user
    end

    
    def destroy
        user = User.find(params[:id])
        user.destroy
    end

    def persist 
        wristband = encode_token({user_id: @user.id})
        render json: { user: UserSerializer.new(@user), token: wristband }
    end 

     # token decoding and AUTH methods
    def encode_token(payload)
     # save string as env variable later super important
    JWT.encode(payload, 'THISISOURMOTHERFUCKINGWRISTBAND')
    end
    
    def auth_header
         request.headers['Authorization']
    end 
    
    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, "THISISOURMOTHERFUCKINGWRISTBAND", { complete: true }, algorithm: 'HS256') 
            rescue JWT::DecodeError 
            nil
        end
        end 
    end
    
    def logged_in_user
        if decoded_token
             user_id = decoded_token[0]['user_id']
             @user = User.find_by(id: user_id) 
        end
    end 

    def logged_in?
        !!logged_in_user
    end 

    def authorized   
        render json: { message: "Please log in" }, status: :unauthorized unless logged_in? 
    end 
    
    private 

    def user_params 
        params.permit(:username, :password, :id, locations_attributes: [:country, :flag, :ISO, :confirmed, :deaths, :active, :recovered, :lat, :lon, :date], user: [:username])
    end

end
