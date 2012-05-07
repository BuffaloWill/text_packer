#!/usr/bin/env ruby

### Packer for jpg files
###
### This is based on Robin Wood's work and inspiration.
###   http://www.digininja.org/kreiosc2/
###

module Packer

class Jpg
### File format allows for no-greater than 200 characters
###    after the 24th character
  def initialize
  end

  def pack(jpg, command)
    if command.length > 199
      puts "Command is too long, 200 characters is the max"
      return
    end

    # why mess with a good thing - greetz rw    
    command = command + "\00"
    output = File.new("#{jpg}","r+")
    output.seek 24
    output.print command
    output.close
    return output    
  end
end

end
