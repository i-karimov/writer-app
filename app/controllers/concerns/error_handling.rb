module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found(exception)
      logger.warn exception

      render file: 'public/404.html', status: 404, layout: false
    end
  end
end
