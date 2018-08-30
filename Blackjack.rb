require_relative "blackjack_methods"

deck = Array.new(13) {Array.new(2,0)}
human = Array.new
dealer = Array.new
stand = false
play = true
gameend = false
score = Array.new(2, 0)

getwinlossrecord(score)

introduction(score)

performsetup(human,dealer,deck)

while play
	updategametext(dealer, dealer.sum, human, human.sum)
	if human.sum >= 21
		gameend = true
	end
	unless gameend
		if !stand
			puts "\n\n\n	[H]it or [S]tand"
			input = handleinput(["h","H","s","S"])
			if input.capitalize == "H"
				deal(human,deck)
				if human.sum >= 21
					gameend = true
				end
			elsif input.capitalize == "S"
				stand = true
			end
		else
			if checkfordealerhit(dealer)
				deal(dealer,deck)
				
				puts "\n\n\n	Dealer hits.
				
	Press [Enter] to continue."
				handleinput([])
			else
				puts "\n\n\n	Dealer stands.
				
	Press [Enter] to continue."
				gameend = true
			end
		end
	else
		puts "
		
	Press [Enter] to continue.
	"
		handleinput([])
		checkforwin(dealer, dealer.sum, human, human.sum, score)
		handleinput([])
		puts "\n\n\n	Do you wish to play again?
		
	[Y]es or [N]o"
		input = handleinput(["y","Y","n","N"])
		if input.capitalize == "N"
			play = false
			exit
		else
			deck.replace Array.new(13) {Array.new(2,0)}
			human.replace Array.new
			dealer.replace Array.new
			gameend = false
			stand = false
			performsetup(human,dealer,deck)
		end
	end
end

