// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  document.querySelector(".cep-input")?.addEventListener("input", (event) => {
    const input = event.target;
    input.value = input.value.replace(/(\D)/g,"").replace(/(\d{5})(\d{3}).*/g, "$1-$2")
  });
});
