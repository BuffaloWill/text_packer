#!/usr/bin/env ruby

### Unpacker for docx, xlsx, and pptx
###
### This is based on Robin Wood's discussion.
###   http://www.digininja.org/kreiosc2/
###

module Unpacker

class Mso
  def initialize
  end

  # This whole thing suffers from command injection
  def unpack(mso)
    
    if File.exists?('TEMPXX')
      puts "ERROR:: TEMPXX directory already exists, deleting.."
      `rm -rf TEMPXX`
    end

    # mk a tmp directory
    `mkdir TEMPXX`
    
    # unzip the contents of the file in the temp dir
    `cp #{mso} TEMPXX/`
    `unzip TEMPXX/#{mso} -d ./TEMPXX/`
    
    # TODO gsub <!--
    # TODO how should multiple comments be handeled
    # write the command as a comment in the [Content_Types.xml] file
    file = File.new("TEMPXX/[Content_Types].xml","r")
    
    output = ""
    while(line = file.gets)
      if line =~ /<!--/
	output = line.split("<!-- ")[1].split(" -->")[0]
      end
    end
    
    # remove the temp directory
    `rm -rf TEMPXX/`
    
    return output
  end
end

end
