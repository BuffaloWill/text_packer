#!/usr/bin/env ruby

### Packer for swf
###
### This is based on basic testing I did. Seems a properly delimeted
###	swf file can have text appended to it without consequence.
###

module Packer

class Swf
  def initialize
  end

  def pack(swf, command)
    File.open(swf, 'a') {|f| f.write("XXXX"+command+"\00") }
  end
end

end
