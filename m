Subject: Re: relabel python script.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <3FD0AB5C.4030103@redhat.com>
References: <3FD0AB5C.4030103@redhat.com>
Content-Type: text/plain
Message-Id: <1071001121.6729.80.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Tue, 09 Dec 2003 15:18:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-05 at 10:59, Daniel J Walsh wrote:
> The attached script is something I wrote to handle the problem of 
> labeling users home directories.  Russell's latest policy has added 
> several security contexts to files in the users home directories (.ssh, 
> .pgp, .xauthority etc).  The problem is the current 'make label' labels 
> all entries in the users home directory with user_*_t.  If you define a 
> certain user at staff_t (required by policy if you want to become 
> sysadm_t) by default he will not be able to login.
> 
> This script figures out the default role for all users and then if the 
> user is not root and the default role is not user_u, it adds entries to 
> file_contexts to properly label this users home directories.  The script 
> then runs a make relabel.
> 
> This functionality should probably be added to either seuser or make 
> relabel to make this easier to do. 
> 

I have added this to our list of wanted features for seuser. Hopefully
we can get to it for the release after next.

Karl

> Ideas?
> 
> Dan
> 
> ______________________________________________________________________
> #!/usr/bin/python
> import commands
> import sys
> import os
> 
> policy_dir="/etc/security/selinux/src/policy"
> context_dir="%s/file_contexts" % policy_dir
> 
> def makeFileContext():
> 	rc=commands.getstatusoutput("cd %s;rm file_contexts/file_contexts; make file_contexts/file_contexts" % policy_dir)
> 	if rc[0] != 0:
> 		raise ValueError, rc[1]
> def makeRelabel():
> 	rc=commands.getstatusoutput("cd %s;make relabel" % policy_dir)
> 	if rc[0] != 0:
> 		raise ValueError, rc[1]
> 	
> def getUsers():
> 	rc=commands.getstatusoutput("seuser show users")
> 	udict={}
> 	if rc[0] == 0:
> 		ulist=rc[1].strip().split("\n")
> 		for u in ulist:
> 			user=u.split(":")
> 			if user[0]=="root" or user[0]=="user_u" or user[0]=="system_u":
> 				continue
> 			role = user[1].split()[0].split("_r")[0]
> 			if role == "user":
> 				continue
> 			udict[user[0]]=role
> 	return udict
> 
> def usage():
> 	print "Usage: %s" % sys.argv[0]
> 	sys.exit(1)
> 	
> def update(user, role):
> 	rc=commands.getstatusoutput("cd %s; grep -h '/home/\[\^' file_contexts | grep -v vmware | sed 's|/home/\[\^\/\]+|/home/%s|g' | sed 's/user/%s/' > /tmp/user_context.tmp; cat /tmp/user_context.tmp >> file_contexts; rm /tmp/user_context.tmp" % (context_dir,user, role))
> 	if rc[0] != 0:
> 		print rc[1]
> 		sys.exit(1)
> 	return rc
> 
> try:
> 	makeFileContext()
> 	users=getUsers()
> 	for u in users.keys():
> 		update (u, users[u])
> 
>        	makeRelabel()
> except ValueError, error:
> 	print error
> 	
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
