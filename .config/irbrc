# vim: ft=ruby

begin
	require 'rubygems'
	require 'wirble'
	Wirble.init
	Wirble.colorize
rescue LoadError
	require 'irb/completion'
	
	ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
	
	# ri support
	def ri arg
		puts `ri #{arg}`
	end
	
	class Module
		def ri(meth=nil)
			if meth
				if instance_methods(false).include? meth.to_s
					puts `ri #{self}##{meth}`
				else
					super
				end
			else
				puts `ri #{self}`
			end
		end
	end
end
