class LibrariesController < ApplicationController
  def index
    @library = current_user.library
  end
end
