#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

sys.path.append('/Users/agr/Projects/odoo/odoo/')
sys.path.append('/Users/agr/Projects/odoo/.env/lib/python2.7/site-packages/')


class DB(object):
    def __init__(self, db):
        import openerp
        self._db = db
        self._pool = openerp.registry(db)
        self._cr = self._pool.cursor()

    def __getattr__(self, attr):
        model = attr.replace('_', '.')
        return self._pool[model]

    pass


"""
A pretty-printing dump function for the ast module.  The code was copied from
the ast.dump function and modified slightly to pretty-print.

Alex Leone (acleone ~AT~ gmail.com), 2010-01-30
"""
import ast


def dump(node, annotate_fields=True, include_attributes=False, indent='  '):
    """
    Return a formatted dump of the tree in *node*.  This is mainly useful for
    debugging purposes.  The returned string will show the names and the values
    for fields.  This makes the code impossible to evaluate, so if evaluation is
    wanted *annotate_fields* must be set to False.  Attributes such as line
    numbers and column offsets are not dumped by default.  If this is wanted,
    *include_attributes* can be set to True.
    """
    def _format(node, level=0):
        if isinstance(node, ast.AST):
            fields = [(a, _format(b, level)) for a, b in ast.iter_fields(node)]
            if include_attributes and node._attributes:
                fields.extend([(a, _format(getattr(node, a), level))
                               for a in node._attributes])
            return ''.join([
                node.__class__.__name__,
                '(',
                ', '.join(('%s=%s' % field for field in fields)
                           if annotate_fields else
                           (b for a, b in fields)),
                ')'])
        elif isinstance(node, list):
            lines = ['[']
            lines.extend((indent * (level + 2) + _format(x, level + 2) + ','
                         for x in node))
            if len(lines) > 1:
                lines.append(indent * (level + 1) + ']')
            else:
                lines[-1] += ']'
            return '\n'.join(lines)
        return repr(node)
    if not isinstance(node, ast.AST):
        raise TypeError('expected AST, got %r' % node.__class__.__name__)
    return _format(node)

def ppast(code):
    """
    Print pretty ast.
    """
    """
    Used this before
    http://furius.ca/pubcode/pub/conf/lib/python/astpretty.py.html#download
    but now, just `pip install astor`
    """
    # print dump(ast.parse(code, filename=filename), include_attributes=True)
    print dump(ast.parse(code), include_attributes=True)

#############################################################
# Wakeup
#
# import socket
# s=socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# #s.sendto('\xff'*6+'\x01\x23\x45\x67\x89\x0a'*16, ('192.168.1.255', 80))
# s.sendto('\xff'*6+'\x00\x1F\x3B\x13\xC2\x43'*16, ('192.168.1.255', 80))

#############################################################
# rwed (set up chmod for amiga executable under uae
#
# #!/usr/bin/ruby
# require "find"
# Find.find(".") do |path|
# 	if `file -b "#{path}"`.strip == "AmigaOS loadseg()ble executable/binary"
# 		cmd = "chmod u+rwx,og-rwx \"#{path}\""
# 		puts cmd
# 		system(cmd)
# 	end
# end
######## PLUS WHD RENAMES
# #!/bin/bash
# mv *.info WHD-Game.info
# mv *.slave WHD-Game.slave
# mv *.Slave WHD-Game.slave
# agr_chmod
# #chmod a-x *
# mv readme ReadMe
# mv solution Solution
# mv manual Manual
# mv hints Hints
# mv instructions Manual
# mv Instructions Manual
#
########### SAME FOR DEMOS
# mv *.info WHD-Demo.info
# mv *.slave WHD-Demo.slave
# mv *.Slave WHD-Demo.slave
# agr_chmod
# #chmod a-x *
# mv readme ReadMe

#############################################################
# apple keyboard
#
# #! /bin/bash
# kbdrate -r 30 -d 10
# xset r on

#############################################################
# image dates (TODO: image compression and resize)
#
# #!/usr/bin/python
# import os, sys, commands, re
# if len(sys.argv) == 1:
# 	name = sys.argv[0].split("/").pop()
# 	print "Usage: %s <image file(s)> " % (name)
# 	sys.exit()

# for file in sys.argv[1:]:
# 	try:
# 		date = commands.getoutput("exif %s | grep 'Date and Time'" % file).split("\n")[0].split("|")[1].strip().replace(":", "-", 2)
# 		print "%s : Will set date to %s" % (file, date)
# 		cmd = "touch -d '%s' \"%s\"" % (date, file)
# 		commands.getoutput(cmd)
# 	except:
# 		print "%s : Can't find EXIF data inside" % file

#############################################################
# TODO: music related
# FLAC2OGG.py
# import os, sys, commands, re
#
# quality = 6
# if len(sys.argv) == 3 and sys.argv[1] == "-q" and re.match("^[1-9]$", sys.argv[2]):
# 	quality = sys.argv[2]
#
# oggenc = 'oggenc -q %s --artist "%s" --album "%s" --title "%s" --date "%s" --tracknum "%s" --genre "%s" "%s"'
#
# files = os.listdir("./")
#
# for i in files:
# 	ext = i.split(".")[-1]
# 	if ext == "flac":
# 		print "Encoding " + i
# 		metas = {'artist' : '', 'album' : '', 'title' : '', 'date' : '', 'tracknumber' : '', 'genre' : ''}
# 		#print "metaflac --list \"" + i.replace('"', '\\"') + "\" | grep 'comment\['"
# 		meta = commands.getoutput("metaflac --list \"" + i.replace('"', '\\"') + "\" | grep 'comment\['").splitlines()
# 		for j in meta:
# 			p = j.split("]: ")[1].split("=")
# 			metas[p[0].lower()] = p[1]
# 		for j in metas:
# 			metas[j] = metas[j].replace('"', '\"')
# 		cmd = oggenc % (quality, metas["artist"], metas["album"], metas["title"], metas["date"], metas["tracknumber"], metas["genre"], i)
# 		#print cmd
# 		status = commands.getoutput(cmd)
#
#############################################################
# FLAC2OGG.rb
#!/usr/bin/ruby
# require "shellwords"
# require "open3"
#
# def is_installed?(prog)
# 	return `which #{prog}`.strip != ""
# end
#
# def is_flac?(file)
# 	# todo
# 	# 66 4C 61 43 : fLaC
# 	#hex = IO.popen("hexdump -c -n 10000 \"#{file}\"").readlines.join("").gsub(" ", "")
# 	#p hex.count("fLaCd")
# 	return false unless File.exists? file
# 	(stdin, stdout, stderr) = Open3.popen3("metaflac --export-tags-to=- #{Shellwords.escape(file)}")
# 	return stderr.read.strip.empty?
# end
#
# "flac,metaflac,oggenc".split(",").each do |prog|
# 	abort "#{prog} not found, please install this program first" unless is_installed? prog
# end
#
# abort "Nothing to convert" if ARGV.empty?
#
# ARGV.each do |file|
# 	flac_file = File.expand_path(file)
# 	abort "ERROR: File not found : #{flac_file}" unless File.exists? flac_file
# 	abort "ERROR: Not a flac file : #{flac_file}" unless is_flac? flac_file
# 	comments = IO.popen("metaflac --export-tags-to=- #{Shellwords.escape(flac_file)}").readlines
# 	ogg_file = flac_file.split(".flac")[0] + ".ogg"
# 	comments_cmd = comments.collect { |line| "-c \"#{line.split("\n")[0]}\"" }.join(" ")
# 	#convertIO = IO.popen("flac -d -c #{Shellwords.escape(flac_file)} | oggenc - #{comments_cmd} -o #{Shellwords.escape(ogg_file)}") { |f| f.read }
# 	#puts "flac -d -c #{Shellwords.escape(flac_file)} | oggenc -q 7 -Q - #{comments_cmd} -o #{Shellwords.escape(ogg_file)}"
# 	`flac -d -c #{Shellwords.escape(flac_file)} | oggenc -q 7 -Q - #{comments_cmd} -o #{Shellwords.escape(ogg_file)}`
# end

#############################################################
# TODO: backup
#!/bin/bash
#if test $USER != "root"; then
#    echo "This tool backups all the system and then needs the root privilege"
#    exit 1
#fi
# RSYNC="--delete --exclude /dev --exclude /sys --exclude /proc --exclude /media --exclude /mnt --exclude /tmp"
#
# if test "$1" = "-y"; then
#     REPLY="y"
# else
#     echo "rsync -avn $RSYNC / /media/AGRMOBILE/ > /tmp/backup.log" | sudo sh
#     less /tmp/backup.log
#     rm /tmp/backup.log
#     echo    "---------------------"
#     read -p "Confirm rsync ? (y/n)"
# fi
#
# if [ "$REPLY" != "y" ]; then
#     exit
# fi
#
# sudo rsync -av --progress $RSYNC / /media/AGRMOBILE/

#############################################################
# codelen.py
#
# #!/usr/bin/python
# import sys
#
# if len(sys.argv) != 2:
#   sys.exit("invalid arguments")
#
# try:
#   file = open(sys.argv[1], "rb")
# except IOError:
#   sys.exit("could not open %r" % sys.argv[1])
#
# longest = ""
# longest_on = count = 0
# for line in file:
#   count += 1
#   if len(line) > len(longest):
#     longest = line
#     longest_on = count
#
# longest = longest.rstrip("\n")
# print "File has total of", count, "lines."
# print "Longest line found on line", longest_on, "with", len(longest), "characters."
# print "The line is:", longest

#############################################################
# TODO: check if still usefull, if true make a rule for it
#
# disper
# valgrind
# autodownload java/bfg-1.11.7.jar ???


#############################################################
# ipadbook.sh
# #!/bin/bash
# curl -i -s -F author="$1" -F datafile=@"$2" http://192.168.0.3:8080/post

#############################################################
# TODO: ipban, restore, ...
# #!/bin/bash
# iptables -A INPUT -s $1 -j DROP

#############################################################
# Multiple downloads. Should also give possibility to instruct about paging system trough css class
# #!/usr/bin/ruby
# require "rubygems"
# require "open-uri"
# require "nokogiri"
# require "escape"
# require "uri"

# url = ARGV[0]
# prefix = ARGV[1] || ""
# doc = Nokogiri::HTML(open(url))
# uri = URI.parse(url)
# exclude_ext = "html,htm,php,jpg,jpeg".split(",")
# already_downloaded = []
# doc.css("a").each do |link|
# 	l = link["href"].strip
# 	if l =~ /\.[a-zA-Z0-9]+$/
# 		file = l.split("/").last
# 		ext = file.split(".").last.downcase
# 		if already_downloaded.count(l).zero? and exclude_ext.count(ext).zero?
# 			if l.downcase !=~ /^[a-z]+:\/\//
# 				l = uri.merge(l).to_s
# 			end
# 			#w = `#{Escape.shell_command(["wget", "-q", l])}`
# 			dest = prefix + file
# 			puts "Downloading #{l} -> #{dest}"
# 			w = `#{Escape.shell_command(["curl", "-o", dest, l])}`
# 			already_downloaded << l
# 		else
# 			puts "Not downloading #{l}"
# 		end
# 	end
# end

#############################################################
# OSX reload audio
# #!/usr/bin/ruby
# #!/bin/bash
# sudo kextunload /System/Library/Extensions/AppleHDA.kext
# sudo kextload /System/Library/Extensions/AppleHDA.kext

#############################################################
# fun with words and letters
# #!/usr/bin/python
# import sys
# from itertools import permutations
#
# if len(sys.argv) != 2:
# 	print 'Usage: permutations <letters>'
# 	sys.exit(1)
#
# letters = sys.argv[1]
# for i in permutations(letters, len(letters)):
# 	print ''.join(i)

#############################################################
# linux screen shot
# #!/bin/bash
# default_app="qiv"
# APP=${1:-$default_app}
#
# scrot "/tmp/%Y-%m-%d_$wx$h.png" -e "$APP \$f &" -s

#############################################################
# linux multitail
# #!/bin/bash
# alias logs="cd /var/log; multitail -s 2 auth.log  daemon.log  dpkg.log  fail2ban.log  fontconfig.log  kern.log  lpr.log  mail.log  pycentral.log  user.log; cd -"
#
# scrot "/tmp/%Y-%m-%d_$wx$h.png" -e "$APP \$f &" -s

def cli():
    print("CLI")
