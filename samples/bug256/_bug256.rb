# require 'squib'
require_relative '../../lib/squib'


Squib::Deck.new do
  background color: :white
  # text str: 'Hello, :world:', font_size: 10 do |embed|
  #   embed.svg key: ':world:', file: 'A01.svg', width: 10, height: 0
  # end
  svg file: 'A01.svg', width: 0

  save_png
end
