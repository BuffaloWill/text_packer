#!/usr/bi n/env ruby

### Unpacker for swf files
###
### This is based on basic testing I did. Seems a properly delimeted
###	swf file can have text appended to it without consequence.
###

module Unpacker

class Swf
  def initialize
  end

  def unpack(input)
    File.open(input, 'rb') {|file|
      swf = file.read 
      i=0
      message = ""
      readin = true
    while(readin)
      # If we find XXXX the message is starting
      if swf[i] == 88 and swf[i+1] == 88 and swf[i+2] == 88 and swf[i+3] == 88
	# found delimeter, read in the text
	i += 4
	while swf[i] != 0 
	  message += swf[i,1]
	  i += 1
	end
	readin = false
      end
      i += 1
    end
    return message
    }
  end

end

end
