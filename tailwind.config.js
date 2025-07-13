// tailwind.config.js
module.exports = {
  content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue', // if you use Vue
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
