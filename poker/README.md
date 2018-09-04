#Poker

This is 5 card draw written in Ruby.

To play, run game.rb in your terminal followed by any number of names who become the players.
If you enter no names, the script defaults to a two player game with Tom and Jerry.

Example:

    $ ruby ./lib/game.rb Larry Curly Moe

## Testing

Tests are written in Rspec. 

    $ rake spec


## TODO

* Extend Hand#rank method to account for high cards
* Extend Game#calculate_winner to account for ties
* Implement betting rounds (currently there is only an ante)
* Implement end game conditions other than asking "Play again?" after each round
* Make ante and betting values configurable
