Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0EBJlXf004237
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2006 06:19:48 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0EBJgdI017319
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2006 11:19:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: semanage patch
Date: Sat, 14 Jan 2006 22:19:23 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_M5NyDjK5HJJU0xX"
Message-Id: <200601142219.40316.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_M5NyDjK5HJJU0xX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch fixes a bug in a check for user existence that prevented 
adding a new user, allows specifying the default level for users via the -L 
option, and fixes a mis-spelling of "delete" in code.

Also attached a re-written man page that uses better formatting and more 
precision in the SYNOPSIS section.  The changes were significant enough that 
diff wouldn't do anything useful.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_M5NyDjK5HJJU0xX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- seobject.py.orig	2006-01-15 07:06:59.000000000 +1100
+++ seobject.py	2006-01-15 07:07:03.000000000 +1100
@@ -134,7 +134,7 @@
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
-		if not exists:
+		if exists:
 			raise ValueError("SELinux user %s is already defined." % name)
 
 		(rc,u) = semanage_user_create(self.sh)
--- semanage.orig	2006-01-15 07:03:30.000000000 +1100
+++ semanage	2006-01-15 07:08:52.000000000 +1100
@@ -84,7 +84,7 @@
 			
 		args = sys.argv[2:]
 		gopts, cmds = getopt.getopt(args,
-					    'adf:lhmnp:P:s:R:r:t:v',
+					    'adf:lhmnp:P:s:R:L:r:t:v',
 					    ['add',
 					     'delete',
 					     'ftype=',
@@ -96,6 +96,7 @@
 					     'proto=',
 					     'seuser=',
 					     'range=',
+					     'level=',
 					     'roles=',
 					     'type=',
 					     'verbose'
@@ -106,7 +107,7 @@
 					usage()
 				add = 1
 				
-			if o == "-d"  or o == "--delese":
+			if o == "-d"  or o == "--delete":
 				if modify or add:
 					usage()
 				delete = 1
@@ -126,6 +127,9 @@
 			if o == "-r" or o == '--range':
 				serange = a
 
+			if o == "-L" or o == '--level':
+				selevel = a
+
 			if o == "-P" or o == '--proto':
 				proto = a
 

--Boundary-00=_M5NyDjK5HJJU0xX
Content-Type: application/x-troff;
  name="semanage.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="semanage.8"

.TH "semanage" "8" "2005111103" "" ""
.SH "NAME"
semanage \- SELinux Policy Management tool

.SH "SYNOPSIS"
.B semanage {login|user|port} \-l
.br
.B semanage login \-{a|d|m} [\-sr] login_name
.br
.B semanage user \-{a|d|m} [\-LrR] selinux_name
.br
.B semanage port \-{a|d|m} [\-t] port_number
.P
This tool is used to manage configuration of the SELinux policy

.SH "DESCRIPTION"
This manual page describes the
.BR semanage
program.
.br
This tool is used to manage configuration of SELinux Policy.  You can configure SELinux User Mappings, SELinux Port Mappings, SELinux Users.


.SH "OPTIONS"
.TP
.I                \-l, \-\-list       
List the OBJECTS
.TP
.I                \-a, \-\-add        
Add a OBJECT record NAME
.TP
.I                \-d, \-\-delete     
Delete a OBJECT record NAME
.TP
.I                \-h, \-\-help       
display this message
.TP
.I                \-m, \-\-modify     
Modify a OBJECT record NAME
.TP
.I                \-r, \-\-range      
MLS/MCS Security Range
.TP
.I                \-s, \-\-seuser     
SELinux user name
.TP
.I                \-t, \-\-type       
SELinux Type for the object
.TP
.I                \-v, \-\-verbose    
verbose output

.SH "AUTHOR"
This man page was written by Daniel Walsh <dwalsh@redhat.com> and
Russell Coker <rcoker@redhat.com>.


--Boundary-00=_M5NyDjK5HJJU0xX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
