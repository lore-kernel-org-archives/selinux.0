Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5G68orT000956
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 02:08:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5G68cdG025449
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 06:08:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 19CD561C7F
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 16:08:43 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16148-04 for <selinux@tycho.nsa.gov>;
	Wed, 16 Jun 2004 16:08:42 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 835A961BD6
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 16:08:42 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C7D71B5869
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 16:08:40 +1000 (EST)
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon
Date: Wed, 16 Jun 2004 16:08:40 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oP+zAMr/rw3gYb/"
Message-Id: <200406161608.40075.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_oP+zAMr/rw3gYb/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have made some minor changes to genhomedircon (attached a diff against the 
Fedora version and a copy of the modified script).

This improves the error handling code to make it clear when an error condition 
is caused by bad parameters and when it's by an internal error.  It also 
fixes a bug so that now the following line in the "users" file will be 
accepted and not cause the program to abort:
user root roles user_r;

Previously it demanded the following instead:
user root roles { user_r };

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_oP+zAMr/rw3gYb/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="g.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="g.diff"

--- genhomedircon.orig	2004-06-16 16:04:11.000000000 +1000
+++ genhomedircon	2004-06-16 16:00:59.000000000 +1000
@@ -51,7 +51,10 @@
 				if user[1] == "user_u" or user[1] == "system_u":
 					continue
 				# !!! chooses first role in the list to use in the file context !!!
-				role = user[4].split("_r")[0]
+				role = user[3]
+				if role == "{":
+					role = user[4]
+				role = role.split("_r")[0]
 				home = pwd.getpwnam(user[1])[5]
 				if home == "/":
 					continue
@@ -70,18 +73,24 @@
 	sys.stderr.flush()
 	sys.exit(1)
 	
+def errorExit(error):
+	sys.stderr.write("%s exiting for: " % sys.argv[0])
+	sys.stderr.write("%s\n" % error)
+	sys.stderr.flush()
+	sys.exit(1)
+	
 def update(filecontext, user, prefs):
 	rc=commands.getstatusoutput("grep -h '^HOME_DIR' %s | grep -v vmware | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (filecontext, prefs["home"], prefs["role"], user))
 	if rc[0] == 0:
 		print rc[1]
 	else:
-		usage(rc[1])
+		errorExit(join("grep/sed error ", rc[1]))
 	return rc
 
 try:
 	if len(sys.argv) != 3:
 		print len(sys.argv)
-		usage()
+		usage("Incorrect parameters")
 
 	FILECONTEXTDIR=sys.argv[1]
 	prefixes = getPrefixes()
@@ -91,8 +100,7 @@
 		homedir = rc[1].split("=")[1]
 	else:
 		sys.stderr.write("%s\n" % (rc[1],))
-		sys.stderr.write("You do not have access to /etc/default/useradd
-, default /home\n")
+		sys.stderr.write("You do not have access to /etc/default/useradd, default /home\n")
 		sys.stderr.flush()
 		homedir = "/home"
 		
@@ -109,7 +117,7 @@
 	if rc[0] == 0:
 		print rc[1]
 	else:
-		usage(rc[1])
+		errorExit(join("sed error ", rc[1]))
 
 	users = getUsers()
 	print "\n#\n# User-specific file contexts\n#\n"
@@ -118,6 +126,6 @@
 	for u in users.keys():
 		update(sys.argv[2], u, users[u]) 
 except ValueError, error:
-	usage(error)
+	errorExit(join("ValueError ", error))
 except IndexError, error:
-	usage()
+	errorExit("IndexError")

--Boundary-00=_oP+zAMr/rw3gYb/
Content-Type: application/x-python;
  name="genhomedircon"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="genhomedircon"

#! /usr/bin/env python
# Copyright (C) 2004 Tresys Technology, LLC
# see file 'COPYING' for use and warranty information

#
# genhomedircon - Replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files
#  with generic and user-specific values.
#
# Based off original script by Dan Walsh, <dwalsh@redhat.com>
#
# ASSUMPTIONS:
#
# If a user has more than one role in FILECONTEXTDIR/users, genhomedircon uses
#  the first role in the list.
#
# If a user is not listed in FILECONTEXTDIR/users, genhomedircon assumes that
#  the user's home dir will be found in one of the HOME_ROOTs.
#
# "Real" users (as opposed to system users) are those whose UID is greater than
#  or equal STARTING_UID (usually 100) and whose login is not a member of
#  EXCLUDE_LOGINS.  Users who are explicitly defined in FILECONTEXTDIR/users
#  are always "real" (including root, in the default configuration).
#

import commands, sys, os, pwd, string

EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
STARTING_UID=100

def getPrefixes():
	ulist = pwd.getpwall()
	prefixes = {}
	for u in ulist:
		if u[2] >= STARTING_UID and \
		   not u[6] in EXCLUDE_LOGINS and \
		   u[5] != "/" and \
		   string.count(u[5], "/") > 1:
			prefix = u[5][:string.rfind(u[5], "/")]
			if not prefixes.has_key(prefix):
				prefixes[prefix] = ""
	return prefixes
 
def getUsers():
	rc = commands.getstatusoutput("grep ^user %s/users" % FILECONTEXTDIR)
	udict = {}
	if rc[0] == 0:
		ulist = rc[1].strip().split("\n")
		for u in ulist:
			user = u.split()
			try:
				if user[1] == "user_u" or user[1] == "system_u":
					continue
				# !!! chooses first role in the list to use in the file context !!!
				role = user[3]
				if role == "{":
					role = user[4]
				role = role.split("_r")[0]
				home = pwd.getpwnam(user[1])[5]
				if home == "/":
					continue
				prefs = {}
				prefs["role"] = role
				prefs["home"] = home
				udict[user[1]] = prefs
			except KeyError:
				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % (user[1],))
	return udict

def usage(error = ""):
	if error != "":
		sys.stderr.write("%s\n" % (error,))
	sys.stderr.write("Usage: %s POLICYSOURCEDIR FILE_CONTEXTS\n" % sys.argv[0])
	sys.stderr.flush()
	sys.exit(1)
	
def errorExit(error):
	sys.stderr.write("%s exiting for: " % sys.argv[0])
	sys.stderr.write("%s\n" % error)
	sys.stderr.flush()
	sys.exit(1)
	
def update(filecontext, user, prefs):
	rc=commands.getstatusoutput("grep -h '^HOME_DIR' %s | grep -v vmware | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (filecontext, prefs["home"], prefs["role"], user))
	if rc[0] == 0:
		print rc[1]
	else:
		errorExit(join("grep/sed error ", rc[1]))
	return rc

try:
	if len(sys.argv) != 3:
		print len(sys.argv)
		usage("Incorrect parameters")

	FILECONTEXTDIR=sys.argv[1]
	prefixes = getPrefixes()

	rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
	if rc[0] == 0:
		homedir = rc[1].split("=")[1]
	else:
		sys.stderr.write("%s\n" % (rc[1],))
		sys.stderr.write("You do not have access to /etc/default/useradd, default /home\n")
		sys.stderr.flush()
		homedir = "/home"
		

	if not prefixes.has_key(homedir):
		prefixes[homedir] = ""

	# There may be a more elegant sed script to expand a macro to multiple lines, but this works
	sed_root = "h; s|^HOME_ROOT|%s|" % (string.join(prefixes.keys(), "|; p; g; s|^HOME_ROOT|"),)
	sed_dir = "h; s|^HOME_DIR|%s/[^/]+|; s|ROLE_|user_|" % (string.join(prefixes.keys(), "/[^/]+|; s|ROLE_|user_|; p; g; s|^HOME_DIR|"),)

	# Fill in HOME_ROOT, HOME_DIR, and ROLE for users not explicitly defined in /etc/security/selinux/src/policy/users
	rc=commands.getstatusoutput("sed -e \"/^HOME_ROOT/{%s}\" -e \"/^HOME_DIR/{%s}\" %s" % (sed_root, sed_dir, sys.argv[2]))
	if rc[0] == 0:
		print rc[1]
	else:
		errorExit(join("sed error ", rc[1]))

	users = getUsers()
	print "\n#\n# User-specific file contexts\n#\n"

	# Fill in HOME and ROLE for users that are defined
	for u in users.keys():
		update(sys.argv[2], u, users[u]) 
except ValueError, error:
	errorExit(join("ValueError ", error))
except IndexError, error:
	errorExit("IndexError")

--Boundary-00=_oP+zAMr/rw3gYb/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
