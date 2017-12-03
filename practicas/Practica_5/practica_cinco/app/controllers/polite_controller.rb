class PoliteController < ApplicationController
  def salute
    @message = ["Good day sir/ma'am", "Hola, que tal?", "Hello world", "Aguante Rails", "Aguante Ruby"].shuffle.first
  end
end
