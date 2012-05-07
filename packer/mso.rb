#!/usr/bin/env ruby

### Packer for docx, xlsx, and pptx
###
### This is based on Robin Wood's discussion.
###   http://www.digininja.org/kreiosc2/
###

module Packer

class Mso
  def initialize
  end

  # This whole thing suffers from command injection
  def pack(mso, command)
    if File.exists?('TEMPXX')
      puts "ERROR:: TEMPXX directory already exists, deleting.."
      `rm -rf TEMPXX`
    end
    # mkdir a tmp directory
    `mkdir TEMPXX`
    
    # unzip the contents of the file in the temp dir
    `cp #{mso} TEMPXX/`
    `unzip TEMPXX/#{mso} -d ./TEMPXX/`

    # TODO gsub <!--
    # write the command as a comment in the [Content_Types.xml] file
    open("TEMPXX/[Content_Types].xml","a") do |file|
      file << "<!-- #{command} -->\n"
    end
    
    # zip up the contents, overwrite the file, and delete the directory
    `rm TEMPXX/#{mso}`
    `cd TEMPXX && zip -r ../#{mso} *`
    `rm -rf TEMPXX/`
  end
end

end
