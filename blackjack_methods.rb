at_exit {puts "\n\n	Goodbye!"}

def checkfordealerhit(dealer)
	if dealer.sum > 17
		return false
	elsif dealer.sum == 17
		hasace = false
		hassix = false
		dealer.each_index do |x|
			if x == 1 || x == 11
				hasace = true
			end
			dealer.each_index do |y|
				if y > x
					if y + x == 6
						hassix = true
					end
				end
			end
		end
		if hasace and hassix
			return true
		else
			return false
		end
	else
		return true
	end
end

def checkforwin (dealerhand, dealer, humanhand, human, score)
	if human > 21
		score[1] += 1
		puts "\n\n	>You bust! You lose!"
	elsif human == 21
		score[0] += 1
		puts "\n\n	>Blackjack!  You win!"
	elsif dealer == 21
		score[1] += 1
		puts "\n\n	Dealer gets Blackjack! You lose!"
	elsif dealer > 21
		score[0] += 1
		puts "\n\n	>Dealer busts! You win!"
	elsif human > dealer
		score[0] += 1
		puts "\n\n	>Your total is higher. You win!"
	elsif human < dealer
		score[1] += 1
		puts "\n\n	>Your total is lower.  You lose!"
	else
		puts "\n\n	>You and the dealer tie. No win or loss."
	end
	savewinlossrecord(score)
	puts "\n\n	Wins: #{score[0]}  Losses: #{score[1]}"
end

def deal (player, deck)
	index = Random.rand(deck.length)
	player.push(deck[index][1])
	if player.sum > 21
		if player.find_index(11)
			player[player.find_index(11)] = 1
		end
	end
	deck[index][0]+=1
	if deck[index][0] == 4
		deck.delete_at(index)
	end
end

def getwinlossrecord(score)
	a = IO.readlines("winlossrecord.txt")
	if !a.empty?
		score[0] = a[0].to_i
		score[1] = a[1].to_i
	end
end

def handleinput(inputtext)
	puts inputtext[0]
	correctinput = false
	if inputtext[1].empty?
		input = gets.chomp.capitalize
			if input == "Q"
				exit
			end
	else
		until correctinput
			input = gets.chomp.capitalize
			if input == "Q"
				exit
			end
			inputtext[1].each do |x|
				if input == x
					correctinput = true
					return input
				end
			end
		end
	end
end

def initializedeck (deck)
	(0...8).each {|x| deck[x][1] = x+2}
	(8...12).each {|x| deck[x][1] = 10}
	deck[12][1]=11
end

def performsetup (human, dealer, deck)
	initializedeck(deck)
	deal(human, deck)
	deal(human, deck)
	deal(dealer, deck)
	deal(dealer, deck)
end

def savewinlossrecord(score)
	IO.write("winlossrecord.txt", score[0].to_s+"\n"+score[1].to_s)
end

def updategametext (dealerhand, humanhand, reveal)
	if !reveal
		temparray = Array.new
		temparray.replace dealerhand
		temparray[0] = "?"
		
		puts "\n\n\n	Dealer
	
	Hand: #{temparray.join(", ")}
			
	Total: ?+#{dealerhand.sum-dealerhand[0]}
			
			
	You
			
	Hand: #{humanhand.join(", ")}
			
	Total: #{humanhand.sum}"
	else
		puts "\n\n\n	Dealer
	
	Hand: #{dealerhand.join(", ")}
			
	Total: #{dealerhand.sum}
			
			
	You
			
	Hand: #{humanhand.join(", ")}
			
	Total: #{humanhand.sum}"
	end
end
