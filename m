Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i23LapRb014338
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 16:36:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i23Lao0F003097
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 21:36:50 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id i23LangZ003094 for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 21:36:49 GMT
Subject: Re: Proposed patch to policy file_contexts
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1078348887.13948.191.camel@moss-spartans.epoch.ncsc.mil>
References: <403E52AD.5090103@redhat.com>
	 <1077916703.11720.274.camel@colossus.columbia.tresys.com>
	 <4044B7F5.1010302@redhat.com>
	 <1078323734.9541.28.camel@colossus.columbia.tresys.com>
	 <1078348887.13948.191.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-qs2HDWHsZbNrUr3O8Eis"
Message-Id: <1078349802.9541.47.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 03 Mar 2004 16:36:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qs2HDWHsZbNrUr3O8Eis
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-03-03 at 16:21, Stephen Smalley wrote:
> On Wed, 2004-03-03 at 09:22, Karl MacMillan wrote:
> > I have attached a patch. It is against a cvs version from last week, so
> > I'm not certain that it is completely current.
> 
> It appears that error messages from the script are being written to the
> generated file contexts file rather than stderr, e.g. if you have a user
> in your policy/users file that is not in /etc/passwd, then you'll get:
> User "foo is not present in the passwd file, skipping
> in the file contexts configuration.

Here is an updated version that writes all of the error messages to
stderr. There are 2 patches - the first is against the patch I sent
before and the other is the full version.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134

--=-qs2HDWHsZbNrUr3O8Eis
Content-Disposition: attachment; filename=genhomedircon-2-3-2004-ver2
Content-Type: text/x-patch; name=genhomedircon-2-3-2004-ver2; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nru a/selinux-usr/policy/Makefile b/selinux-usr/policy/Makefile
--- a/selinux-usr/policy/Makefile	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/Makefile	Wed Mar  3 16:34:30 2004
@@ -81,7 +81,7 @@
 $(POLICYVER):  policy.conf $(CHECKPOLICY)
 	$(CHECKPOLICY) $(POLICYCOMPAT) -o $@ policy.conf
 
-$(POLICYCONF): policy.conf 
+$(POLICYCONF): policy.conf
 	mkdir -p $(SRCINSTALLDIR)
 	install -m 644 policy.conf $@
 
@@ -120,10 +120,8 @@
 
 $(FC): $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users
 	m4 $(FCFILES) > $@.tmp
-	@/usr/sbin/genhomedircon $@.tmp  > $@.homedirtmp
-	cat $@.homedirtmp >> $@.tmp
-	@rm $@.homedirtmp
-	mv $@.tmp $@
+	/usr/sbin/genhomedircon $@.tmp > $@
+	rm $@.tmp
 
 clean:
 	rm -f policy.conf
diff -Nru a/selinux-usr/policy/file_contexts/program/apache.fc b/selinux-usr/policy/file_contexts/program/apache.fc
--- a/selinux-usr/policy/file_contexts/program/apache.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/apache.fc	Wed Mar  3 16:34:30 2004
@@ -1,5 +1,5 @@
 # apache
-/home/[^/]+/((www)|(web)|(public_html))(/.+)? system_u:object_r:httpd_user_content_t
+HOME_DIR/((www)|(web)|(public_html))(/.+)? system_u:object_r:httpd_ROLE_content_t
 /var/www		-d	system_u:object_r:httpd_sys_content_t
 /var/www/html(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/www/mrtg(/.*)?		system_u:object_r:httpd_sys_content_t
diff -Nru a/selinux-usr/policy/file_contexts/program/gpg.fc b/selinux-usr/policy/file_contexts/program/gpg.fc
--- a/selinux-usr/policy/file_contexts/program/gpg.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/gpg.fc	Wed Mar  3 16:34:30 2004
@@ -1,4 +1,3 @@
 # gpg
-/home/[^/]+/\.gnupg(/.+)?	system_u:object_r:user_gpg_secret_t
-/root/\.gnupg(/.+)?		system_u:object_r:sysadm_gpg_secret_t
+HOME_DIR/\.gnupg(/.+)?	system_u:object_r:ROLE_gpg_secret_t
 /usr/bin/gpg		--	system_u:object_r:gpg_exec_t
diff -Nru a/selinux-usr/policy/file_contexts/program/irc.fc b/selinux-usr/policy/file_contexts/program/irc.fc
--- a/selinux-usr/policy/file_contexts/program/irc.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/irc.fc	Wed Mar  3 16:34:30 2004
@@ -2,4 +2,4 @@
 /usr/bin/[st]irc	--	system_u:object_r:irc_exec_t
 /usr/bin/ircII		--	system_u:object_r:irc_exec_t
 /usr/bin/tinyirc	--	system_u:object_r:irc_exec_t
-/home/[^/]+/.ircmotd	--	system_u:object_r:user_home_irc_t
+HOME_DIR/.ircmotd	--	system_u:object_r:ROLE_home_irc_t
diff -Nru a/selinux-usr/policy/file_contexts/program/mozilla.fc b/selinux-usr/policy/file_contexts/program/mozilla.fc
--- a/selinux-usr/policy/file_contexts/program/mozilla.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/mozilla.fc	Wed Mar  3 16:34:30 2004
@@ -1,8 +1,6 @@
 #  netscape/mozilla
-/root/\.netscape(/.*)?		system_u:object_r:sysadm_mozilla_rw_t
-/root/\.mozilla(/.*)?		system_u:object_r:sysadm_mozilla_rw_t
-/home/[^/]+/\.netscape(/.*)?	system_u:object_r:user_mozilla_rw_t
-/home/[^/]+/\.mozilla(/.*)?	system_u:object_r:user_mozilla_rw_t
+HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
+HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
diff -Nru a/selinux-usr/policy/file_contexts/program/quota.fc b/selinux-usr/policy/file_contexts/program/quota.fc
--- a/selinux-usr/policy/file_contexts/program/quota.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/quota.fc	Wed Mar  3 16:34:30 2004
@@ -1,4 +1,5 @@
 # quota system
 /var/lib/quota(/.*)?		system_u:object_r:quota_flag_t
 /sbin/quota(check|on)	--	system_u:object_r:quota_exec_t
-/(|home/|var/)quota.(user|group) -- system_u:object_r:quota_db_t
+HOME_ROOT/quota.(user|group) -- system_u:object_r:quota_db_t
+/var/quota.(user|group) -- system_u:object_r:quota_db_t
diff -Nru a/selinux-usr/policy/file_contexts/program/screen.fc b/selinux-usr/policy/file_contexts/program/screen.fc
--- a/selinux-usr/policy/file_contexts/program/screen.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/screen.fc	Wed Mar  3 16:34:30 2004
@@ -1,5 +1,5 @@
 # screen
 /usr/bin/screen		--	system_u:object_r:screen_exec_t
-/home/[^/]+/\.screenrc	--	system_u:object_r:user_home_screen_t
+HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_home_screen_t
 /var/run/screen/S-[^/]+	-d	system_u:object_r:screen_dir_t
 /var/run/screen/S-[^/]+/.*	<<none>>
diff -Nru a/selinux-usr/policy/file_contexts/program/ssh.fc b/selinux-usr/policy/file_contexts/program/ssh.fc
--- a/selinux-usr/policy/file_contexts/program/ssh.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/ssh.fc	Wed Mar  3 16:34:30 2004
@@ -6,8 +6,7 @@
 /etc/ssh/ssh_host_dsa_key --	system_u:object_r:sshd_key_t
 /etc/ssh/ssh_host_rsa_key --	system_u:object_r:sshd_key_t
 /usr/sbin/sshd	        --	system_u:object_r:sshd_exec_t
-/root/\.ssh(/.*)?		system_u:object_r:sysadm_home_ssh_t
-/home/[^/]+/\.ssh(/.*)?		system_u:object_r:user_home_ssh_t
+HOME_DIR/\.ssh(/.*)?		system_u:object_r:ROLE_home_ssh_t
 # subsystems
 /usr/lib/misc/sftp-server --	system_u:object_r:bin_t
 /usr/libexec/openssh/sftp-server -- system_u:object_r:bin_t
diff -Nru a/selinux-usr/policy/file_contexts/program/vmware.fc b/selinux-usr/policy/file_contexts/program/vmware.fc
--- a/selinux-usr/policy/file_contexts/program/vmware.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/vmware.fc	Wed Mar  3 16:34:30 2004
@@ -38,6 +38,6 @@
 # The rules below assume that the user VMWare virtual disks are in the
 # ~/vmware, and the preferences and license files are in ~/.vmware.
 #
-/home/[^/]+/\.vmware(/.*)?	system_u:object_r:vmware_user_file_t
-/home/[^/]+/\vmware(/.*)?	system_u:object_r:vmware_user_file_t
-/home/[^/]+/\vmware[^/]*/.*\.cfg -- system_u:object_r:vmware_user_conf_t
+HOME_DIR/\.vmware(/.*)?	system_u:object_r:vmware_ROLE_file_t
+HOME_DIR/\vmware(/.*)?	system_u:object_r:vmware_ROLE_file_t
+HOME_DIR/\vmware[^/]*/.*\.cfg	--	system_u:object_r:vmware_ROLE_conf_t
diff -Nru a/selinux-usr/policy/file_contexts/program/xauth.fc b/selinux-usr/policy/file_contexts/program/xauth.fc
--- a/selinux-usr/policy/file_contexts/program/xauth.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/program/xauth.fc	Wed Mar  3 16:34:30 2004
@@ -1,4 +1,3 @@
 # xauth
 /usr/X11R6/bin/xauth	--	system_u:object_r:xauth_exec_t
-/home/[^/]+/\.Xauthority.* --	system_u:object_r:user_home_xauth_t
-/root/\.Xauthority.*	 --	system_u:object_r:sysadm_home_xauth_t
+HOME_DIR/\.Xauthority.* --	system_u:object_r:ROLE_home_xauth_t
diff -Nru a/selinux-usr/policy/file_contexts/types.fc b/selinux-usr/policy/file_contexts/types.fc
--- a/selinux-usr/policy/file_contexts/types.fc	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policy/file_contexts/types.fc	Wed Mar  3 16:34:30 2004
@@ -14,13 +14,13 @@
 # The optional type field specifies the file type as shown in the mode
 # field by ls, e.g. use -d to match only directories or -- to match only
 # regular files.
-# 
+#
 # The value of <<none> may be used to indicate that matching files
 # should not be relabeled.
 #
 # The last matching specification is used.
 #
-# If there are multiple hard links to a file that match 
+# If there are multiple hard links to a file that match
 # different specifications and those specifications indicate
 # different security contexts, then a warning is displayed
 # but the file is still labeled based on the last matching
@@ -44,6 +44,17 @@
 /			-d	system_u:object_r:root_t
 
 #
+# Ordinary user home directories.
+# HOME_ROOT expands to all valid home directory prefixes found in /etc/passwd
+# HOME_DIR expands to each user's home directory,
+#                  and to HOME_ROOT/[^/]+ for each HOME_ROOT.
+# ROLE expands to each user's role when role != user_r, and to "user" otherwise.
+#
+HOME_ROOT		-d	system_u:object_r:home_root_t
+HOME_DIR		-d	system_u:object_r:ROLE_home_dir_t
+HOME_DIR/.+			system_u:object_r:ROLE_home_t
+
+#
 # A common mount point
 /mnt			-d	system_u:object_r:root_t
 /mnt/cdrom		-d	system_u:object_r:mnt_t
@@ -75,19 +86,6 @@
 /var/ftp/lib/lib.*\.so.* --	system_u:object_r:shlib_t
 /var/ftp/etc(/.*)?		system_u:object_r:etc_t
 
-# 
-# The superuser home directory.
-#
-/root(/.*)?			system_u:object_r:sysadm_home_t
-/root			-d	system_u:object_r:sysadm_home_dir_t
-
-# 
-# Ordinary user home directories.
-#
-/home			-d	system_u:object_r:home_root_t
-/home/[^/]+		-d	system_u:object_r:user_home_dir_t
-/home/[^/]+/.+			system_u:object_r:user_home_t
-
 #
 # /bin
 #
@@ -408,7 +406,7 @@
 /\.journal			<<none>>
 /usr/\.journal			<<none>>
 /boot/\.journal			<<none>>
-/home/\.journal			<<none>>
+HOME_ROOT/\.journal		<<none>>
 /var/\.journal			<<none>>
 /tmp/\.journal			<<none>>
 /usr/local/\.journal		<<none>>
@@ -419,7 +417,7 @@
 /lost\+found(/.*)?		system_u:object_r:lost_found_t
 /usr/lost\+found(/.*)?		system_u:object_r:lost_found_t
 /boot/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/home/lost\+found(/.*)?		system_u:object_r:lost_found_t
+HOME_ROOT/lost\+found(/.*)?	system_u:object_r:lost_found_t
 /var/lost\+found(/.*)?		system_u:object_r:lost_found_t
 /tmp/lost\+found(/.*)?		system_u:object_r:lost_found_t
 /usr/local/lost\+found(/.*)?	system_u:object_r:lost_found_t
diff -Nru a/selinux-usr/policycoreutils/scripts/genhomedircon b/selinux-usr/policycoreutils/scripts/genhomedircon
--- a/selinux-usr/policycoreutils/scripts/genhomedircon	Wed Mar  3 16:34:30 2004
+++ b/selinux-usr/policycoreutils/scripts/genhomedircon	Wed Mar  3 16:34:30 2004
@@ -1,32 +1,76 @@
-#!/usr/bin/python
-import commands
-import sys
-import os
+#! /usr/bin/env python
+# Copyright (C) 2004 Tresys Technology, LLC
+# see file 'COPYING' for use and warranty information
+
+#
+# genhomedircon - Replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files
+#  with generic and user-specific values.
+#
+# ASSUMPTIONS:
+#
+# If a user has more than one role in FILECONTEXTDIR/users, genhomedircon uses
+#  the first role in the list.
+#
+# If a user is not listed in FILECONTEXTDIR/users, genhomedircon assumes that
+#  the user's home dir will be found in one of the HOME_ROOTs.
+#
+# "Real" users (as opposed to system users) are those whose UID is greater than
+#  or equal STARTING_UID (usually 100) and whose login is not a member of
+#  EXCLUDE_LOGINS.  Users who are explicitly defined in FILECONTEXTDIR/users
+#  are always "real" (including root, in the default configuration).
+#
+
+import commands, sys, os, pwd, string
+
 FILECONTEXTDIR="/etc/security/selinux/src/policy/"
+EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
+STARTING_UID=100
+
+def getPrefixes():
+	ulist = pwd.getpwall()
+	prefixes = {}
+	for u in ulist:
+		if u[2] >= STARTING_UID and \
+		   not u[6] in EXCLUDE_LOGINS and \
+		   u[5] != "/" and \
+		   string.count(u[5], "/") > 1:
+			prefix = u[5][:string.rfind(u[5], "/")]
+			if not prefixes.has_key(prefix):
+				prefixes[prefix] = ""
+	return prefixes
 
 def getUsers():
-	rc=commands.getstatusoutput("grep ^user %s/users" % FILECONTEXTDIR)
-	udict={}
+	rc = commands.getstatusoutput("grep ^user %s/users" % FILECONTEXTDIR)
+	udict = {}
 	if rc[0] == 0:
-		ulist=rc[1].strip().split("\n")
+		ulist = rc[1].strip().split("\n")
 		for u in ulist:
-			user=u.split()
-			if user[1]=="root" or user[1]=="user_u" or user[1]=="system_u":
-				continue
-			role = user[4].split("_r")[0]
-			if role == "user":
-				continue
-			udict[user[1]]=role
+			user = u.split()
+			try:
+				if user[1] == "user_u" or user[1] == "system_u":
+					continue
+				# !!! chooses first role in the list to use in the file context !!!
+				role = user[4].split("_r")[0]
+				home = pwd.getpwnam(user[1])[5]
+				if home == "/":
+					continue
+				prefs = {}
+				prefs["role"] = role
+				prefs["home"] = home
+				udict[user[1]] = prefs
+			except KeyError:
+				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % (user[1],))
 	return udict
 
-def usage(error=""):
+def usage(error = ""):
 	if error != "":
-		print error
-	print "Usage: %s FILE_CONTEXTS" % sys.argv[0]
+		sys.stderr.write("%s\n" % (error,))
+	sys.stderr.write("Usage: %s FILE_CONTEXTS\n" % sys.argv[0])
+	sys.stderr.flush()
 	sys.exit(1)
-	
-def update(filecontext, user, role):
-	rc=commands.getstatusoutput("grep -h '/home/\[\^' %s | grep -v vmware | sed -e 's|/home/\[\^\/\]+|/home/%s|g' -e 's/user/%s/' -e 's/system_u/%s/'" % (filecontext, user, role, user))
+
+def update(filecontext, user, prefs):
+	rc=commands.getstatusoutput("grep -h '^HOME_DIR' %s | grep -v vmware | sed -e 's|HOME_DIR|%s|g' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (filecontext, prefs["home"], prefs["role"], user))
 	if rc[0] == 0:
 		print rc[1]
 	else:
@@ -34,11 +78,41 @@
 	return rc
 
 try:
-	users=getUsers()
+	prefixes = getPrefixes()
+
+	rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
+	if rc[0] == 0:
+		homedir = rc[1].split("=")[1]
+	else:
+		sys.stderr.write("%s\n" % (rc[1],))
+		sys.stderr.write("Do you have access to /etc/default/useradd?\n")
+		sys.stderr.flush()
+		sys.exit(1)
+
+	if not prefixes.has_key(homedir):
+		prefixes[homedir] = ""
+
+	if len(prefixes) == 1:
+		regex_root = prefixes.keys()[0]
+	else:
+		regex_root = "(%s)" % (string.join(prefixes, "\|"),)
+	regex_dir = "%s/[^/]+" % (regex_root,)
+
+	# Fill in HOME_ROOT, HOME_DIR, and ROLE for users not explicitly defined in /etc/security/selinux/src/policy/users
+	rc=commands.getstatusoutput("sed -e 's|^HOME_ROOT|%s|g' -e 's|^HOME_DIR|%s|g' -e 's/ROLE_/user_/' %s" % (regex_root, regex_dir, sys.argv[1]))
+	if rc[0] == 0:
+		print rc[1]
+	else:
+		usage(rc[1])
+
+	users = getUsers()
+	print "\n#\n# User-specific file contexts\n#\n"
+
+	# Fill in HOME and ROLE for users that are defined
 	for u in users.keys():
-		update(sys.argv[1], u, users[u]) 
+		update(sys.argv[1], u, users[u])
+
 except ValueError, error:
 	usage(error)
 except IndexError, error:
 	usage()
-	

--=-qs2HDWHsZbNrUr3O8Eis
Content-Disposition: attachment; filename=genhomedircon-2-3-2004-ver2-relative
Content-Type: text/x-patch; name=genhomedircon-2-3-2004-ver2-relative; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nru a/selinux-usr/policycoreutils/scripts/genhomedircon b/selinux-usr/policycoreutils/scripts/genhomedircon
--- a/selinux-usr/policycoreutils/scripts/genhomedircon	Wed Mar  3 16:34:05 2004
+++ b/selinux-usr/policycoreutils/scripts/genhomedircon	Wed Mar  3 16:34:05 2004
@@ -1,4 +1,7 @@
-#!/usr/bin/python
+#! /usr/bin/env python
+# Copyright (C) 2004 Tresys Technology, LLC
+# see file 'COPYING' for use and warranty information
+
 #
 # genhomedircon - Replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files
 #  with generic and user-specific values.
@@ -8,8 +11,8 @@
 # If a user has more than one role in FILECONTEXTDIR/users, genhomedircon uses
 #  the first role in the list.
 #
-# If a user is not listed in FILECONTEXTDIR/user genhomedircon assumes that the user's 
-#  home dir will be found in one of the HOME_ROOTs.
+# If a user is not listed in FILECONTEXTDIR/users, genhomedircon assumes that
+#  the user's home dir will be found in one of the HOME_ROOTs.
 #
 # "Real" users (as opposed to system users) are those whose UID is greater than
 #  or equal STARTING_UID (usually 100) and whose login is not a member of
@@ -28,9 +31,9 @@
 	prefixes = {}
 	for u in ulist:
 		if u[2] >= STARTING_UID and \
-		not u[6] in EXCLUDE_LOGINS and \
-		u[5] != "/" and \
-		string.count(u[5], "/") > 1:
+		   not u[6] in EXCLUDE_LOGINS and \
+		   u[5] != "/" and \
+		   string.count(u[5], "/") > 1:
 			prefix = u[5][:string.rfind(u[5], "/")]
 			if not prefixes.has_key(prefix):
 				prefixes[prefix] = ""
@@ -56,13 +59,14 @@
 				prefs["home"] = home
 				udict[user[1]] = prefs
 			except KeyError:
-				print "User \"%s\" is not present in the passwd file, skipping" % (user[1],)
+				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % (user[1],))
 	return udict
 
 def usage(error = ""):
 	if error != "":
-		print error
-	print "Usage: %s FILE_CONTEXTS" % sys.argv[0]
+		sys.stderr.write("%s\n" % (error,))
+	sys.stderr.write("Usage: %s FILE_CONTEXTS\n" % sys.argv[0])
+	sys.stderr.flush()
 	sys.exit(1)
 
 def update(filecontext, user, prefs):
@@ -80,8 +84,9 @@
 	if rc[0] == 0:
 		homedir = rc[1].split("=")[1]
 	else:
-		print rc[1]
-		print "Do you have access to /etc/default/useradd?"
+		sys.stderr.write("%s\n" % (rc[1],))
+		sys.stderr.write("Do you have access to /etc/default/useradd?\n")
+		sys.stderr.flush()
 		sys.exit(1)
 
 	if not prefixes.has_key(homedir):

--=-qs2HDWHsZbNrUr3O8Eis--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
