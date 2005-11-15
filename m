Message-ID: <437A0930.80906@redhat.com>
Date: Tue, 15 Nov 2005 11:13:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Port of audit2allow to python
Content-Type: multipart/mixed;
 boundary="------------090800090004020302020403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090800090004020302020403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Next step add reference policy generation.

-- 



--------------090800090004020302020403
Content-Type: text/x-python;
 name="audit2allow.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2allow.py"

#! /usr/bin/env python
# Copyright (C) 2005 Red Hat 
# see file 'COPYING' for use and warranty information
#
# Audit2allow is a rewrite of prior perl script.
#
# Based off original audit2allow perl script: which credits
#    newrules.pl, Copyright (C) 2001 Justin R. Smith (jsmith@mcs.drexel.edu)
#    2003 Oct 11: Add -l option by Yuichi Nakamura(ynakam@users.sourceforge.jp)
#
#
#  
import commands, sys, os, pwd, string, getopt, re
class allow:
	def __init__(self, source, target, seclass, access):
		self.source=source
		self.target=target
		self.seclass=seclass
		self.access=[]
		self.add(access)
	def add(self, access):
		for i in access:
			if i not in self.access:
				self.access.append(i)
	def getAccess(self):
		if len(self.access) == 1:
			return self.access[0]
		else:
			self.access.sort()
			ret="{"
			for i in self.access:
				ret=ret + " " + i
				
			ret=ret+" }"
			return ret
	def out(self):
		ret="allow %s %s:%s %s;" % (self.source, self.gettarget(), self.seclass, self.getAccess())
		return ret
	def gettarget(self):
		if self.source == self.target:
			return "self"
		else:
			return self.target
	
class allowRecords:
	def __init__(self, input, last_reload=0):
		self.last_reload=last_reload
		self.allowRules={}
		line = input.read()
		avc=[]
		while line:
			rec=line.split()
			for i in rec:
				if i=="avc:" :
					self.add(avc)
					avc=[i]
				else:
					avc.append(i)
				
			line = input.read()
	def add(self,avc):
		scon=""
		tcon=""
		seclass=""
		access=[]
		if "granted" in avc and "load_policy" in avc:
			if self.last_reload:
				self.allowRules={}
			return
		for i in range (0, len(avc)):
			t=avc[i].split('=')
			if t[0]=="scontext":
				scon=t[1].split(":")[2]
				continue
			if t[0]=="tcontext":
				tcon=t[1].split(":")[2]
				continue
			if t[0]=="tclass":
				seclass=t[1]
				continue
			if avc[i]=="{":
				i=i+1
				while i<len(avc) and avc[i] != "}":
					access.append(avc[i])
					i=i+1
					
		if scon=="" or tcon =="" or seclass=="":
			return
		if (scon, tcon, seclass) in self.allowRules.keys():
			self.allowRules[(scon, tcon, seclass)].add(access)
		else:
			self.allowRules[(scon, tcon, seclass)]=allow(scon, tcon, seclass, access)

	def out(self):
		rec=""
		for i in self.allowRules.keys():
			rec=rec+self.allowRules[i].out()+"\n"
		return rec
def usage():
	print 'audit2allow [-d] [-v] [-l] [-i <inputfile> ] [-o <outputfile>]\n\
        -d      read input from output of /bin/dmesg\n\
        -v      verbose output\n\
        -l      read input only after last \"load_policy\"\n\
        -i      read input from <inputfile>\n\
        -o      append output to <outputfile>\n'
	sys.exit(1)
#
# This script will generate home dir file context
# based off the homedir_template file, entries in the password file, and
#
try:
	last_reload=0
	input=sys.stdin
	output=sys.stdout
	gopts, cmds = getopt.getopt(sys.argv[1:], 'do:hli:', ['help',
						'last_reload='])
	for o,a in gopts:
		if o == '--last_reload' or o == "-l":
			last_reload=1
		if o == "-i":
			input=open(a, "r")
		if o == '--help':
			usage()
		if o == "-d":
			input=os.popen("/bin/dmesg", "r")
		if o == "-o":
			output=open(a, "a")
	if len(cmds) != 0:
		usage()
	out=allowRecords(input, last_reload)
	output.write(out.out())

except getopt.error, error:
	errorExit(string.join("Options Error ", error))
except ValueError, error:
	errorExit(string.join("ValueError ", error))
except IndexError, error:
	errorExit("IndexError")

--------------090800090004020302020403--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
