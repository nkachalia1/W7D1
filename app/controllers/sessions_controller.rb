class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

#       ?Reset the User's session_token.
#       ?Update the session hash with the new session_token.
        session[:session_token] = reset_session_token!

        if user.nil?
            render json: "Invalid credentials".to_json
        else
            login!(user)
            redirect_to user_url(user)
        end
    end

    def destroy
        if current_user
            reset_session_token!
        end

        session[:session_token] = nil
    end
end
