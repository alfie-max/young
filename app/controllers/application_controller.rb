class ApplicationController < ActionController::Base
    
    before_action :getCatSection, :getPostSection, :getAdvertSection, :getLowAdvertSection, :getMediumAdvertSection, :getHighAdvertSection, :getVeryhighAdvertSection
    
    
    
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def getCatSection
        @catSections = Category.all.order("created_at DESC")
    end
    
    def getPostSection
        @postSections = Post.all.order("created_at DESC")
    end
    
    def getAdvertSection
        @advertSections = Advert.all.order("created_at DESC")
    end
    
    def getLowAdvertSection
        @lowadvertSections = Advert.low.order("created_at DESC")
    end
    
    def getMediumAdvertSection
        @mediumadvertSections = Advert.medium.order("created_at DESC")
    end
    
    def getHighAdvertSection
        @highadvertSections = Advert.high.order("created_at DESC")
    end
    
    def getVeryhighAdvertSection
        @veryhighadvertSections = Advert.veryhigh.order("created_at DESC")
    end

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth) }
        end
        
        
end
