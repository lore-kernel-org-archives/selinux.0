Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m71Bi9t7012759
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:44:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m71Bi75l012984
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 11:44:07 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m71Bi4SO012491
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:44:04 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m71Bi4xe021754
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:44:04 -0400
Received: from localhost.localdomain (vpn-12-61.rdu.redhat.com [10.11.12.61])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m71Bi32w008589
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:44:03 -0400
Message-ID: <4892F6E0.10008@redhat.com>
Date: Fri, 01 Aug 2008 07:43:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patch
Content-Type: multipart/mixed;
 boundary="------------050502000507040207020006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050502000507040207020006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adds support for boolean files, name/value pairs as input and output.
Allows you to set a large amount of booleans at once.

Add support from groupname in semanage login.  This will allow you to
associate groups of Linux Users with an SELinux user.  Uses same syntax
as sudo.  Requires patch to libselinux.

Cleanup of semanage variables.  Change use of 1/0 to True/False.

Remove bad use of raise(out)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiS9t8ACgkQrlYvE4MpobN0/gCgsoXMR/oDibFEw3SNFxwQlhrY
gZIAn1wMYnPg+o2ixNVQsWYBOw1NN4Pd
=69RK
-----END PGP SIGNATURE-----

--------------050502000507040207020006
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/Makefile policycoreutils-2.0.53/Makefile
--- nsapolicycoreutils/Makefile	2008-06-12 23:25:24.000000000 -0400
+++ policycoreutils-2.0.53/Makefile	2008-07-29 16:25:16.000000000 -0400
@@ -1,4 +1,4 @@
-SUBDIRS = setfiles semanage load_policy newrole run_init secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
+SUBDIRS = setfiles semanage load_policy newrole run_init secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po gui
 
 INOTIFYH = $(shell ls /usr/include/sys/inotify.h 2>/dev/null)
 
diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/restorecond/restorecond.c policycoreutils-2.0.53/restorecond/restorecond.c
--- nsapolicycoreutils/restorecond/restorecond.c	2008-06-12 23:25:21.000000000 -0400
+++ policycoreutils-2.0.53/restorecond/restorecond.c	2008-07-29 16:25:16.000000000 -0400
@@ -210,9 +210,10 @@
 			}
 
 			if (fsetfilecon(fd, scontext) < 0) {
-				syslog(LOG_ERR,
-				       "set context %s->%s failed:'%s'\n",
-				       filename, scontext, strerror(errno));
+				if (errno != EOPNOTSUPP) 
+					syslog(LOG_ERR,
+					       "set context %s->%s failed:'%s'\n",
+					       filename, scontext, strerror(errno));
 				if (retcontext >= 0)
 					free(prev_context);
 				free(scontext);
@@ -225,8 +226,9 @@
 		if (retcontext >= 0)
 			free(prev_context);
 	} else {
-		syslog(LOG_ERR, "get context on %s failed: '%s'\n",
-		       filename, strerror(errno));
+		if (errno != EOPNOTSUPP) 
+			syslog(LOG_ERR, "get context on %s failed: '%s'\n",
+			       filename, strerror(errno));
 	}
 	free(scontext);
 	close(fd);
diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.53/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.53/semanage/semanage	2008-08-01 07:30:43.000000000 -0400
@@ -45,13 +45,13 @@
 	def usage(message = ""):
 		print _("""
 semanage {boolean|login|user|port|interface|fcontext|translation} -{l|D} [-n] 
-semanage login -{a|d|m} [-sr] login_name
+semanage login -{a|d|m} [-sr] login_name | %groupname
 semanage user -{a|d|m} [-LrRP] selinux_name
 semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
 semanage interface -{a|d|m} [-tr] interface_spec
 semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
-semanage boolean -{d|m} boolean
+semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
 semanage permissive -{d|a} type
 
 Primary Options:
@@ -79,6 +79,7 @@
 		-l (symbolic link) 
 		-p (named pipe) 
 
+        -F, --file       Treat target as an input file for command, change multiple settings
 	-p, --proto      Port protocol (tcp or udp)
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
@@ -114,7 +115,7 @@
 		valid_option["translation"] = []
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
-		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0" ] 
+		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0", "-F", "--file"] 
 		valid_option["permissive"] = []
 		valid_option["permissive"] += [ '-a', '--add', '-d', '--delete', '-l', '--list', '-h', '--help', '-n', '--noheading', '-D', '--deleteall' ]
 		return valid_option
@@ -134,15 +135,16 @@
 		setrans = ""
 		roles = ""
 		seuser = ""
-		prefix = ""
-		heading=1
-                value=0
-		add = 0
-		modify = 0
-		delete = 0
-		deleteall = 0
-		list = 0
-		locallist = 0
+		prefix = "user"
+		heading = True
+		value = None
+		add = False
+		modify = False
+		delete = False
+		deleteall = False
+		list = False
+		locallist = False
+		use_file = False
                 store = ""
 		if len(sys.argv) < 3:
 			usage(_("Requires 2 or more arguments"))
@@ -155,11 +157,12 @@
 		args = sys.argv[2:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:lhmnp:s:CDR:L:r:t:T:P:S:',
+					    '01adf:lhmnp:s:FCDR:L:r:t:T:P:S:',
 					    ['add',
 					     'delete',
 					     'deleteall',
 					     'ftype=',
+					     'file',
 					     'help',
 					     'list', 
 					     'modify',
@@ -185,31 +188,35 @@
 			if o == "-a" or o == "--add":
 				if modify or delete:
 					usage()
-				add = 1
+				add = True
 				
 			if o == "-d"  or o == "--delete":
 				if modify or add:
 					usage()
-				delete = 1
+				delete = True
 			if o == "-D"  or o == "--deleteall":
 				if modify:
                                        usage()
-				deleteall = 1
+				deleteall = True
 			if o == "-f"  or o == "--ftype":
 				ftype=a
+
+			if o == "-F"  or o == "--file":
+				use_file = True
+
 			if o == "-h" or o == "--help":
 				usage()
 
 			if o == "-n" or o == "--noheading":
-				heading=0
+				heading = False
 
 			if o == "-C" or o == "--locallist":
-				locallist=1
+				locallist = True
 
 			if o == "-m"or o == "--modify":
 				if delete or add:
 					usage()
-				modify = 1
+				modify = True
 				
 			if o == "-S" or o == '--store':
 				store = a
@@ -220,7 +227,7 @@
 				serange = a
 
 			if o == "-l" or o == "--list":
-				list = 1
+				list = True
 
 			if o == "-L" or o == '--level':
 				if is_mls_enabled == 0:
@@ -246,9 +253,9 @@
 				setrans = a
 
                         if o == "--on" or o == "-1":
-                               value = 1
-                        if o == "-off" or o == "-0":
-                               value = 0
+                               value = "on"
+                        if o == "--off" or o == "-0":
+                               value = "off"
 
 		if object == "login":
 			OBJECT = seobject.loginRecords(store)
@@ -275,7 +282,10 @@
 			OBJECT = seobject.permissiveRecords(store)
 		
 		if list:
-			OBJECT.list(heading, locallist)
+			if object == "boolean":
+                               OBJECT.list(heading, locallist, use_file)
+			else:
+                               OBJECT.list(heading, locallist)
 			sys.exit(0);
 			
 		if deleteall:
@@ -295,12 +305,10 @@
 				OBJECT.add(target, setrans)
 
 			if object == "user":
-				rlist = roles.split()
-				if len(rlist) == 0:
-					raise ValueError(_("You must specify a role"))
-				if prefix == "":
-					raise ValueError(_("You must specify a prefix"))
-				OBJECT.add(target, rlist, selevel, serange, prefix)
+                               rlist = []
+                               if not use_file:
+                                      rlist = roles.split()
+                               OBJECT.add(target, rlist, selevel, serange, prefix)
 
 			if object == "port":
 				OBJECT.add(target, proto, serange, setype)
@@ -317,7 +325,7 @@
 			
 		if modify:
 			if object == "boolean":
-				OBJECT.modify(target, value)
+                               OBJECT.modify(target, value, use_file)
 
 			if object == "login":
 				OBJECT.modify(target, seuser, serange)
diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-2.0.53/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.53/semanage/semanage.8	2008-08-01 07:05:54.000000000 -0400
@@ -3,11 +3,11 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|lC|D} [\-n] 
+.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] [\-S store] 
 .br
-.B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] boolean
+.B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] -F boolean | boolean_file
 .br
-.B semanage login \-{a|d|m} [\-sr] login_name
+.B semanage login \-{a|d|m} [\-sr] login_name | %groupname
 .br
 .B semanage user \-{a|d|m} [\-LrRP] selinux_name
 .br
@@ -54,6 +54,11 @@
 File Type.   This is used with fcontext.
 Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
 .TP
+.I                \-F, \-\-file
+Set multiple records from the input file.  When used with the \-l \-\-list, it will output the current settings to stdout in the proper format.
+
+Currently booleans only.
+.TP
 .I                \-h, \-\-help       
 display this message
 .TP
@@ -87,6 +92,9 @@
 .I                \-s, \-\-seuser     
 SELinux user name
 .TP
+.I                \-S, \-\-store
+Select and alternate SELinux store to manage
+.TP
 .I                \-t, \-\-type       
 SELinux Type for the object
 .TP
@@ -99,6 +107,8 @@
 $ semanage user -l
 # Allow joe to login as staff_u
 $ semanage login -a -s staff_u joe
+# Allow the group clerks to login as user_u
+$ semanage login -a -s user_u %clerks
 # Add file-context for everything under /web (used by restorecon)
 $ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
 # Allow Apache to listen on port 81
diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.53/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-07-29 09:15:39.000000000 -0400
+++ policycoreutils-2.0.53/semanage/seobject.py	2008-08-01 07:24:34.000000000 -0400
@@ -21,7 +21,7 @@
 #
 #  
 
-import pwd, string, selinux, tempfile, os, re, sys
+import pwd, grp, string, selinux, tempfile, os, re, sys
 from semanage import *;
 PROGNAME="policycoreutils"
 import sepolgen.module as module
@@ -330,20 +330,15 @@
                       for name in dirs:
                              os.rmdir(os.path.join(root, name))
 
-               if rc != 0:
-                      raise ValueError(out)			
-
-
 	def delete(self, name):
 		for n in name.split():
 			rc = semanage_module_remove(self.sh, "permissive_%s" % n)
 			if rc < 0:
 	                        raise ValueError(_("Could not remove permissive domain %s (remove failed)") % name)
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-                       raise ValueError(_("Could not remove permissive domain %s (commit failed)") % name)
+			rc = semanage_commit(self.sh)
+			if rc < 0:
+                               raise ValueError(_("Could not remove permissive domain %s (commit failed)") % name)
 			
-
 	def deleteall(self):
                l = self.get_all()
                if len(l) > 0:
@@ -402,10 +397,16 @@
 				raise ValueError(_("Could not check if login mapping for %s is defined") % name)
 			if exists:
 				raise ValueError(_("Login mapping for %s is already defined") % name)
-			try:
-				pwd.getpwnam(name)
-			except:
-				raise ValueError(_("Linux User %s does not exist") % name)
+                        if name[0] == '%':
+                                try:
+                                       grp.getgrnam(name[1:])
+                                except:
+                                       raise ValueError(_("Linux Group %s does not exist") % name[1:])
+                        else:
+                                try:
+                                       pwd.getpwnam(name)
+                                except:
+                                       raise ValueError(_("Linux User %s does not exist") % name)
 
 			(rc,u) = semanage_seuser_create(self.sh)
 			if rc < 0:
@@ -1447,54 +1448,72 @@
 class booleanRecords(semanageRecords):
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
+                self.dict={}
+                self.dict["TRUE"] = 1
+                self.dict["FALSE"] = 0
+                self.dict["ON"] = 1
+                self.dict["OFF"] = 0
+                self.dict["1"] = 1
+                self.dict["0"] = 0
 
-	def modify(self, name, value = ""):
-		if value == "":
-			raise ValueError(_("Requires value"))
-
-		(rc,k) = semanage_bool_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError(_("Could not create a key for %s") % name)
-
-		(rc,exists) = semanage_bool_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError(_("Could not check if boolean %s is defined") % name)
-		if not exists:
-			raise ValueError(_("Boolean %s is not defined") % name)	
-
-		(rc,b) = semanage_bool_query(self.sh, k)
-		if rc < 0:
-			raise ValueError(_("Could not query file context %s") % name)
+	def __mod(self, name, value):
+                (rc,k) = semanage_bool_key_create(self.sh, name)
+                if rc < 0:
+                       raise ValueError(_("Could not create a key for %s") % name)
+                (rc,exists) = semanage_bool_exists(self.sh, k)
+                if rc < 0:
+                       raise ValueError(_("Could not check if boolean %s is defined") % name)
+                if not exists:
+                       raise ValueError(_("Boolean %s is not defined") % name)	
+                
+                (rc,b) = semanage_bool_query(self.sh, k)
+                if rc < 0:
+                       raise ValueError(_("Could not query file context %s") % name)
 
-		if value != "":
-			nvalue = int(value)
-			semanage_bool_set_value(b, nvalue)
+                if value.upper() in self.dict:
+                       semanage_bool_set_value(b, self.dict[value.upper()])
                 else:
-                       raise ValueError(_("You must specify a value"))
+                       raise ValueError(_("You must specify one of the following values: %s") % ", ".join(self.dict.keys()) )
+                
+                rc = semanage_bool_set_active(self.sh, k, b)
+                if rc < 0:
+                       raise ValueError(_("Could not set active value of boolean %s") % name)
+                rc = semanage_bool_modify_local(self.sh, k, b)
+                if rc < 0:
+                       raise ValueError(_("Could not modify boolean %s") % name)
+		semanage_bool_key_free(k)
+		semanage_bool_free(b)
 
+	def modify(self, name, value=None, use_file=False):
+                
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not start semanage transaction"))
-
-		rc = semanage_bool_set_active(self.sh, k, b)
-		if rc < 0:
-			raise ValueError(_("Could not set active value of boolean %s") % name)
-		rc = semanage_bool_modify_local(self.sh, k, b)
-		if rc < 0:
-			raise ValueError(_("Could not modify boolean %s") % name)
+                if use_file:
+                       fd = open(name)
+                       for b in fd.read().split("\n"):
+                              b = b.strip()
+                              if len(b) == 0:
+                                     continue
+
+                              try:
+                                     boolname, val = b.split("=")
+                              except ValueError, e:
+                                     raise ValueError(_("Bad format %s: Record %s" % ( name, b) ))
+                              self.__mod(boolname.strip(), val.strip())
+                       fd.close()
+                else:
+                       self.__mod(name, value)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not modify boolean %s") % name)
 		
-		semanage_bool_key_free(k)
-		semanage_bool_free(b)
-
 	def delete(self, name):
-		(rc,k) = semanage_bool_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError(_("Could not create a key for %s") % name)
 
+                (rc,k) = semanage_bool_key_create(self.sh, name)
+                if rc < 0:
+                      raise ValueError(_("Could not create a key for %s") % name)
 		(rc,exists) = semanage_bool_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if boolean %s is defined") % name)
@@ -1571,8 +1590,15 @@
                else:
                       return _("unknown")
 
-	def list(self, heading = 1, locallist = 0):
+	def list(self, heading = True, locallist = False, use_file = False):
                 on_off = (_("off"),_("on")) 
+		if use_file:
+                       ddict = self.get_all(locallist)
+                       keys = ddict.keys()
+                       for k in keys:
+                              if ddict[k]:
+                                     print "%s=%s" %  (k, ddict[k][2])
+                       return
 		if heading:
 			print "%-40s %s\n" % (_("SELinux boolean"), _("Description"))
 		ddict = self.get_all(locallist)

--------------050502000507040207020006
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkiS9uAACgkQrlYvE4MpobMVpwCbBVaPSCKKHQVUFSa4C/4SHtKuJrkAn37O
IYRAbfo94snBFnYyawOQC5iM
--------------050502000507040207020006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
