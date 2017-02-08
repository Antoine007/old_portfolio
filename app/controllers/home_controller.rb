class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def veinte_nudos
    # @colours = %w( 123133 918713 124834 257693 298334 098721 987343 198744 098713)
    @colours = {"123133": "Green", "918713": "Red", "124834": "Blue", "257693": "Fuck", "298334": "blab", "098721": "zing", "987343": "yum", "198744": "wow", "098713": "hello"}
  end
end
