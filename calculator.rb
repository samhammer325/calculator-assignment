
def add(x,y)
  puts x + y
end

def subtract(x,y)
  puts x - y
end

def multiply(x,y)
  puts x * y
end

def divide(x,y)
  puts x / y
end

# take user input for a number
def input_num()
	while true
  	puts "Input a number."
		num = gets.strip
		if /-\d+/.match(num)
			num = /\d+/.match(num)[0]
			return -num.to_i
		elsif /[^0-9]/.match(num)
			puts "Please only enter a number."
		elsif /\d+/.match(num)
			num = /\d+/.match(num)[0]
			return num.to_i
		else
			puts "Error"
		end
	end
end

# take user input for operator
def input_operator()
	while true
		puts "What do you want to do?"
		puts "+ -> add"
		puts "- -> subtract"
		puts "* -> multiply"
		puts "/ -> divide"
		
		op = gets.strip
		case op
		when "+"
			return "+"
		when "-"
			return "-"
		when "/"
			return "/"
		when "*"
			return "*"
		else
			puts "Please enter only + - * or /"
		end
	end
end

#ask to leave
def leave?()
	puts "Do you want to continue? y/n"
	while true
		exit_status = gets.strip.downcase
		if exit_status == "y"
			return true
		elsif exit_status == "n"
			return false
		else
			puts "Please enter either y to continue or n to quit."
		end
	end
end

# do equation and check for division by zero.
def calc()
	puts "Calculator:"
	calculate = true
	while calculate == true
		first_num = input_num()
		puts "> #{first_num}"
		operator = input_operator()
		puts "> #{first_num} #{operator}"
		second_num = input_num()
		puts "> #{first_num} #{operator} #{second_num}"
		
		if operator == "+"
			add(first_num, second_num)
		elsif operator == "-"
			subtract(first_num, second_num)
		elsif operator == "*"
			multiply(first_num, second_num)
		elsif operator == "/" && second_num == 0
			puts "Division by zero is undefined"
		elsif operator == "/"
			divide(first_num, second_num)
		else
			puts "Error"
		end
		calculate = leave?()
	end
end

# Get input for an equation
def input_equation()
	puts "Hello I'm a calculator"
	while true
		puts "Please input a math equation that has + - * or / (ex. 3 * 5)"
		user_input = gets.strip
		# remove all spaces from input
		user_input = user_input.gsub(/\s+/, "")
		# Find any characters not 0-9 + - / or *
		if /[^+\-\*\/0-9]/.match(user_input)
			puts "Please enter an equation with only numbers seperated by + - / or *"
			# Make sure equation has only one operator
		elsif /\A-?\d+\D-?\d+\z/.match(user_input)
			expression = /\A-?\d+\D-?\d+\z/.match(user_input)[0]
			return expression
		else
			puts "Please enter a simple math equation such as \"7 / 5\""
		end
	end
end

# Split equation into numbers and operator
def split_equation(equation)
	num1 = equation.slice!(/(-|)\d+/)
	operator = equation.slice!(/./)
	num2 = equation.slice!(/(-|)\d+/)

	return num1.to_i, operator, num2.to_i
end

def new_calc()
	calculate = true
	while calculate == true
			e = split_equation(input_equation)
			first_num = e[0]
			operator = e[1]
			second_num = e[2]
	
			operation = Hash.new()
			operation["+"] = lambda {puts first_num + second_num}
			operation["-"] = lambda {puts first_num - second_num}
			operation["/"] = lambda {puts first_num / second_num}
			operation["*"] = lambda {puts first_num * second_num}

			if operator == "+" || operator == "-" || operator =="*"
				operation[operator].call
			elsif operator == "/" && second_num == 0
				puts "Division by zero is undefined"
			elsif operator == "/"
				operation[operator].call
			else
				puts "Error"
			end
			calculate = leave?()
		end
end


new_calc

# calc
