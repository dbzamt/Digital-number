class DigitalNumberController < ApplicationController
  def index
  end

  def get_numbers
    data=params[:file_content] #get the content of file
    file = data.read #read the file
    str = file.split("\n") #split the file on the basis of new line character
    j=0
    overall_output = Array.new #its contain the overall result which will be send as an response
    while j<str.count   
      line_1 = str[j+0] # line_1 ,line_2 and line_3 contains the three string which will result in number 
      line_2 = str[j+1]
      line_3 = str[j+2]
      current_output = Hash.new #create to map input(line_1,line_2,line_3) to the output(number ex 123243324)
      res="" #used to contain the output number ex 131233123
      i=0
      while i<line_1.length #legths of line_1,line_2,line_3 are equals so this while loop run until the any of the lines reaches its end

        if line_1[i]=="_"  # if line_1 current character is "_" then these number 0,2,3,5,6,7,8,9									_							
          if line_2[i+1]=="|" && line_2[i-1]=="|"#under the above if condition, if line_2 == | |  which will be result in 0,8,9 as | |

          	#now if line_2 contain "_" in the i'th position then reslut in 8,9 else it will result in 0 
            if line_2[i]=="_"		 #8,9
              if line_3[i-1]=="|"  #8
                res+="8"
              else				 #9
                res+="9"
              end
            else 					 #0
              res +="0"
            end

            																								  				#	 _	
          elsif line_2[i-1]=="|"       #if line_2 at i-1 position is "|" and line_1 at ith  position is "_" then it result in   |  , only result in 6 or 5

            if line_2[i]=="_"
              if line_3[i-1] =="|"  #above will result in 6 if line_3 at i-1 == "|"  else it rsult in 5
                res+="6"
              else				 #5
                res+="5"
              end
            end																												#	_
          elsif line_2[i+1]=="|"       ##if line_2 at i+1 position is "|" and line_1 at ith  position is "_" then it result in   |  , only result in 2 or 3 or 7
            if line_2[i]=="_"			 #2,3										_
              #if line_2 at ith position is equal to "_" then its result in 3,2 as,	_|
              if line_3[i+1]=="|"  #3
                res+="3"
              else				 #2
                res+="2"
              end
            else					 #7												_	
              #if line_2 at ith position is equal to " " then its result in 7 as,	 | 
              res+="7"
            end

          end
          i+=2
        elsif  line_1[i]==" "

          if  line_1[i+1]!="_"					#4,1
            if line_2[i-1] == "|" and line_2[i]=="_"  #4
              res+="4"
            elsif line_2[i-1]!="|" and line_2[i]!="_" and line_2[i+1]=="|" and line_3[i+1]=="|"
            	if line_1[i+2]!="_" and line_3[i+2]!="_"
              		res+="1"
              	end
            end
          end


          # p line_2[i]
          i+=1
        end
      end

      #mapping  input key to line_1,line_2 and line_3 
      #output key contain res as value 
      current_output["input"] = "<br>"+line_1+"<br>"+line_2+"<br>"+line_3 
      current_output["output"] = res
      overall_output << current_output
      j = j+4
    end
    render json:{data:overall_output},status: :ok

  end
end
