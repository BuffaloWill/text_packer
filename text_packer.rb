#!/usr/bin/env ruby

require 'optparse'

# require all the packers and unpackers
Dir[File.dirname(__FILE__) + '/packer/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/unpacker/*.rb'].each {|file| require file }

options = {}

# the supported filetypes
supported = ["jpg","mso","swf"]
 
optparse = OptionParser.new do|opts|
   # Set a banner, displayed at the top
   # of the help screen.
   opts.banner = "fp.rb [options]"
 
   options[:input] = nil
   opts.on( '-i', '--input file', 'Input file.' ) do |file|
    options[:input] = file
    
    if !File.exists?(file)
      puts "#{file} does not exist, try again. \n"
      exit
    end
   end

    options[:unpack] = false
    opts.on( '-u', '--unpack', 'Unpack the file.' ) do |file|
     options[:unpack] = true
    end
    
    options[:pack] = false
    opts.on( '-p', '--pack', 'Pack the file.' ) do |file|
     options[:pack] = true
    end

    options[:command] = nil
    opts.on( '-c', '--command text', 'Text to pack into the file.' ) do |file|
     options[:command] = file
    end
  
    options[:ft] = nil
    opts.on( '-f', '--filetype text', 'The type of file to pack or unpack.' ) do |file|
      if !supported.include?("#{file}")
	  puts "ERROR: That file type is not supported. The supported types are:"
	  supported.each{|fts| puts "\t- #{fts}"}
	  puts "NOTE: for docx, xlsx, pptx use mso\n"
	  exit
      end
     options[:ft] = file
    end
   
   # This displays the help screen, all programs are
   # assumed to have this option.
   opts.on( '-h', '--help', 'Display this screen' ) do
     puts opts
     exit
   end
 end
 
optparse.parse!

if (options[:unpack] and options[:pack]) or (!options[:unpack] and !options[:pack])
  puts "ERROR: You must either pack or unpack a file..."
  exit
end

if options[:input] == nil
  puts "ERROR: You must include an input file to pack or an input file to unpack."
  exit
end

if options[:ft] == nil
  puts "ERROR: Please specify the filetype you are using."
  die
end

case options[:ft]
  when "jpg"
    if options[:unpack]  
      unpacked = Unpacker::Jpg.new.unpack(options[:input])
      puts unpacked
    else
      # packs the file directly
      Packer::Jpg.new.pack(options[:input],options[:command])
      puts "#{options[:input]} PACKED"
    end
  when "mso"
    if options[:unpack]  
      unpacked = Unpacker::Mso.new.unpack(options[:input])
      puts unpacked
    else
      # packs the file directly
      Packer::Mso.new.pack(options[:input],options[:command])
      puts "#{options[:input]} PACKED"
    end
  when "swf"
    if options[:unpack]  
      unpacked = Unpacker::Swf.new.unpack(options[:input])
      puts unpacked
    else
      # packs the file directly
      Packer::Swf.new.pack(options[:input],options[:command])
      puts "#{options[:input]} PACKED"
    end
  else
    return false
end
