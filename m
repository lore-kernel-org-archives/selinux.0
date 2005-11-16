Message-ID: <437ACC47.8000509@redhat.com>
Date: Wed, 16 Nov 2005 01:05:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Port of audit2allow to python
References: <437A0930.80906@redhat.com>	 <1132080405.28124.70.camel@moss-spartans.epoch.ncsc.mil> <1132081042.28124.75.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132081042.28124.75.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090709040906030801030904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090709040906030801030904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Tue, 2005-11-15 at 13:46 -0500, Stephen Smalley wrote:
>   
>> On Tue, 2005-11-15 at 11:13 -0500, Daniel J Walsh wrote:
>>     
>>> Next step add reference policy generation.
>>>       
>> Doesn't yield the same output as the old perl script, even after sorting
>> both outputs to avoid ordering issues.
>>
>> Looks like the new script is incorrectly adding allow rules for:
>> - security_compute_sid errors, and
>> - avc:  granted messages
>>     
>
> Also, the new script doesn't appear to support the -v option yet
> (collects up the auxiliary audit information like the comm= and name=
> information and saves it in comment lines after each allow rule). Not
> sure how crucial that is, or whether we should be saving the audit event
> id instead so that people can use ausearch to query the corresponding
> system call audit record easily.
>
>   
Another pass. 

-- 



--------------090709040906030801030904
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
	def __init__(self, source, target, seclass):
		self.source=source
		self.target=target
		self.seclass=seclass
		self.avcinfo={}
		
	def add(self, avc):
		for a in avc[0]:
			if a not in self.avcinfo.keys():
				self.avcinfo[a]=[]

			self.avcinfo[a].append(avc[1:])

	def getAccess(self):
		if len(self.avcinfo.keys()) == 1:
			for i in self.avcinfo.keys():
				return i
		else:
			keys=self.avcinfo.keys()
			keys.sort()
			ret="{"
			for i in keys:
				ret=ret + " " + i				
			ret=ret+" }"
			return ret
	def out(self, verbose=0):
		ret=""
		ret=ret+"allow %s %s:%s %s;" % (self.source, self.gettarget(), self.seclass, self.getAccess())
		if verbose:
			keys=self.avcinfo.keys()
			keys.sort()
			for i in keys:
				for x in self.avcinfo[i]:
					ret=ret+"\n#TYPE=AVC MSG=%s COMM=%s NAME=%s\t: " % x
					ret=ret + i
		return ret
	def gettarget(self):
		if self.source == self.target:
			return "self"
		else:
			return self.target
	
class allowRecords:
	def __init__(self, input, last_reload=0, verbose=0):
		self.last_reload=last_reload
		self.allowRules={}
		line = input.read()
		avc=[]
		while line:
			rec=line.split()
			for i in rec:
				if i=="avc:" or i=="message=avc:":
					self.add(avc)
					avc=[i]
				else:
					avc.append(i)
				
			line = input.read()
	def add(self,avc):
		scon=""
		tcon=""
		seclass=""
		comm=""
		name=""
		msg=""
		access=[]
		if "security_compute_sid" in avc:
			return
		
		if "granted" in avc:
			if "load_policy" in avc and self.last_reload:
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
			if t[0]=="comm":
				comm=t[1]
				continue
			if t[0]=="name":
				name=t[1]
				continue
			if t[0]=="msg":
				msg=t[1]
				continue
			if avc[i]=="{":
				i=i+1
				while i<len(avc) and avc[i] != "}":
					access.append(avc[i])
					i=i+1
					
		if scon=="" or tcon =="" or seclass=="":
			return

		if (scon, tcon, seclass) not in self.allowRules.keys():
			self.allowRules[(scon, tcon, seclass)]=allow(scon, tcon, seclass)
		self.allowRules[(scon, tcon, seclass)].add((access, msg, comm, name ))

	def outModule(self):
		contexts=[]
		class=[]
		for i in self.allowRules.keys():
			if i[0] not in contexts:
				contexts.append(i[0])
			if i[1] not in contexts:
				contexts.append(i[1])
			if i[2] not in class:
				class.append(i[1])
			
	def out(self):
		rec=""
		for i in self.allowRules.keys():
			rec=rec+self.allowRules[i].out(verbose)+"\n"
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
	verbose=0
	gopts, cmds = getopt.getopt(sys.argv[1:], 'vdo:hli:', ['help',
						'last_reload='])
	for o,a in gopts:
		if o == '--last_reload' or o == "-l":
			last_reload=1
		if o == "-v":
			verbose=1
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
	out=allowRecords(input, last_reload, verbose)
	output.write(out.out())

except getopt.error, error:
	errorExit(string.join("Options Error ", error))
except ValueError, error:
	errorExit(string.join("ValueError ", error))
except IndexError, error:
	errorExit("IndexError")

--------------090709040906030801030904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
