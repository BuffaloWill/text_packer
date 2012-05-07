#!/usr/bin/env ruby

### Unpacker for jpg files
###
### This is based on Robin Wood's work and inspiration.
###   http://www.digininja.org/kreiosc2/
###

module Unpacker

class Jpg
### File format allows for no-greater than 200 characters
###    after the 24th character
  def initialize
  end

  def unpack(input)
    File.open(input, 'rb') {|file|
      jpg = file.read 
      i=24
      message = ""
    while jpg[i] != 0 and i < 225
      message += jpg[i,1]
      i+=1
    end
    return message
    }
  end

end

end
