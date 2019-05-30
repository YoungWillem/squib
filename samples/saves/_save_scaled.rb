# require 'squib'
require_relative '../../lib/squib'

Squib::Deck.new(width: 50, height: 20) do
  background color: :gray
  text str: 'Text!', font: 'Sans 5'

  save_png prefix: 'save_png_no_scaled_'
  save_png prefix: 'save_png_no_scaled_trimmed_', trim: 5, trim_radius: 5
  # save_png supports scaling to a different size
  save_png width: 100, height: 40, prefix: 'save_png_scaled_'
  save_png width: 100, height: 40, trim: 5, trim_radius: 5,
           prefix: 'save_png_scaled_trimmed_'
  save_png width: 40, height: 100, trim: 5, trim_radius: 5,
           rotate: :clockwise, prefix: 'save_png_scaled_trimmed_rotated_'
  save_png width: 40, height: 100,
           rotate: :clockwise, prefix: 'save_png_scaled_rotated_'
end
