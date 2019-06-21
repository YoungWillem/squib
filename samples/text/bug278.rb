# require 'squib'
require_relative '../../lib/squib'

Squib::Deck.new cards: 1 do
  background color: 'white'

  # This image renders as expected
  png file: 'semi-transparent.png', x: 100, y: 100

  # The semi-transparent portions of this image render much darker than expected
  text(str: '@ and @', x: 200, y: 100) do |embed|
    embed.png key: '@', file: 'semi-transparent.png'
  end

  save_png prefix: 'bug_278_'
end
