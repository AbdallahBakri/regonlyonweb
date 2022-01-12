# regonlyonweb for Minetest

Registration only on website (regonlyonweb), is a mod that prevents connection of created accounts to join Deal Minetest Open Server without registering on the website first.

## Settings

* `regonlyonweb.state = on/off`

Start or Stop regonlyonweb from running.

## Commands

Comands require the `regonlyonweb` privilege.

* `roow_state [ on | off]`

Without arguments, displays the general state of regonlyonweb ; else sets its state

* `roow_blockplayer>`

Adds a player to the block list and kick them if `regonlyonweb.state` is on.

* `roow_unblock <player>`

Allows a certian player to join Minetest Servers without registering on the website first.

* `roow_unblockalll`

Allows all users who were previously stopped from joining because they did not register on the website to join.
