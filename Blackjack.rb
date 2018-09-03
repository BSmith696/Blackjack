require_relative "blackjack_methods"

deck = Array.new(13) {Array.new(2,0)}
human = Array.new
dealer = Array.new

play = true
score = Array.new(2, 0)

getwinlossrecord(score)

genericinputtext = ["\n\n	...Press [Enter] to continue...",[]]
hitorstandtext = ["\n\n	...[H]it or [S]tand...", ["H","S"]]
yesornoinputtext = ["\n\n	...[Y]es or [N]o...", ["Y","N"]]

reveald = false

gamephases = ["INIT", "HUMAN", "DEALER", "EVAL"]
currphase = gamephases[0]

puts "
	Welcome to Blackjack!
	
	Wins: #{score[0]}  Losses: #{score[1]}
		
	Would you like to read an explanation
	of what\'s specific to this version?"
if handleinput(yesornoinputtext) == "Y"
	puts "

	For this version of blackjack,
	aces are initially treated as having a value of 11.
		
	Should you draw a card that would
	put your total over 21, any \"aces\" you have
	will be automatically converted to a value of 1.

	Additionally, both of the dealer\'s first cards are visible.
		
	You may [Q]uit the game at anytime
	by entering \"q\" or \"Q\".
					
	That's all!"
	handleinput(genericinputtext)
end

puts "\n\n	Let's play!"
handleinput(genericinputtext)

while play
	case currphase
	when "INIT"
		initializedeck(deck)
		2.times {deal(human, deck)}
		2.times {deal(dealer, deck)}
		
		updategametext(dealer, human, reveald)
		puts "\n\n	>Initial deal"
		
		if human.sum >= 21
			currphase = "EVAL"
		else
			currphase = "HUMAN"
		end
		
		handleinput(genericinputtext)
	when "HUMAN"
		updategametext(dealer, human, reveald)
		puts "\n\n	>What do you do?"
		if handleinput(hitorstandtext) == "H"
			puts "\n\n	>You hit"
			deal(human, deck)
			puts "\n\n	>You got a: #{human[human.size-1]}"
		else
			puts "\n\n	>You stand\n\n"
			currphase = gamephases[2]
		end
		handleinput(genericinputtext)
	when "DEALER"
		updategametext(dealer, human, reveald)
		puts "\n\n	>Dealer\'s turn"
		handleinput(genericinputtext)
		if checkfordealerhit(dealer)
			puts "\n\n	>Dealer hits"
			deal(dealer, deck)
			puts "\n\n	>Dealer got a: #{dealer[dealer.size-1]}"
		else
			puts "\n\n	>Dealer stands"
			handleinput(genericinputtext)
			
			reveald = true
			updategametext(dealer, human, reveald)
			puts "\n\n	>Dealer reveals facedown card"
			
			currphase = gamephases[3]
		end
		handleinput(genericinputtext)
	when "EVAL"
		updategametext(dealer, human, reveald)
		checkforwin(dealer, dealer.sum, human, human.sum, score)
		handleinput(genericinputtext)
		
		puts "\n\n	>Would you like to play again?"
		
		if handleinput(yesornoinputtext) == "Y"
			deck.replace Array.new(13) {Array.new(2,0)}
			human.replace Array.new
			dealer.replace Array.new
			reveald = false
			currphase = gamephases[0]
		else
			puts "\n\n	>Thanks for playing!"
			play = false
		end
	end
end
