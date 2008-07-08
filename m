Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m68JrQj2015377
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 15:53:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m68JrPt7002606
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 19:53:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m68JrMuF023348
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 15:53:25 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m68JrMnf028973
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 15:53:22 -0400
Received: from localhost.localdomain (dhcp-10-16-61-233.boston.devel.redhat.com [10.16.61.233])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m68JrMx1017872
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 15:53:22 -0400
Message-ID: <4873C5B2.20009@redhat.com>
Date: Tue, 08 Jul 2008 15:53:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: semanage patch to allow boolean files to be imported.
Content-Type: multipart/mixed;
 boundary="------------020208070909040002020901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020208070909040002020901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Added flag to semanage to be able to import and export boolean files
into the current system.

Also cleaned up constants to use True/False instead of 1/0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhzxbIACgkQrlYvE4MpobNTDACfeq0yKwoeEpqOEEoit4m2g771
IFAAnjZTz0UNNuRA+QfgPtZH9w56C1ta
=nHLb
-----END PGP SIGNATURE-----

--------------020208070909040002020901
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.52/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.52/semanage/semanage	2008-07-08 15:50:17.000000000 -0400
@@ -51,7 +51,7 @@
 semanage interface -{a|d|m} [-tr] interface_spec
 semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
-semanage boolean -{d|m} boolean
+semanage boolean -{d|m} [-F]  boolean | boolean_file
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
@@ -136,13 +137,14 @@
 		seuser = ""
 		prefix = ""
 		heading=1
-                value=0
-		add = 0
-		modify = 0
-		delete = 0
-		deleteall = 0
-		list = 0
-		locallist = 0
+                value = ""
+		add = False
+		modify = False
+		delete = False
+		deleteall = False
+		list = False
+		locallist = False
+                use_file = False
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
@@ -185,18 +188,22 @@
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
 
@@ -204,12 +211,12 @@
 				heading=0
 
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
+                               value = True
                         if o == "-off" or o == "-0":
-                               value = 0
+                               value = False
 
 		if object == "login":
 			OBJECT = seobject.loginRecords(store)
@@ -275,7 +282,10 @@
 			OBJECT = seobject.permissiveRecords(store)
 		
 		if list:
-			OBJECT.list(heading, locallist)
+                        if object == "boolean":
+                               OBJECT.list(heading, locallist, use_file)
+                        else:
+                               OBJECT.list(heading, locallist)
 			sys.exit(0);
 			
 		if deleteall:
@@ -298,8 +308,6 @@
 				rlist = roles.split()
 				if len(rlist) == 0:
 					raise ValueError(_("You must specify a role"))
-				if prefix == "":
-					raise ValueError(_("You must specify a prefix"))
 				OBJECT.add(target, rlist, selevel, serange, prefix)
 
 			if object == "port":
@@ -317,7 +325,12 @@
 			
 		if modify:
 			if object == "boolean":
-				OBJECT.modify(target, value)
+                                if use_file:
+                                       OBJECT.modify(target, use_file = use_file)
+                                else:
+                                       if value == "":
+                                              raise ValueError(_("boolean requires value"))
+                                       OBJECT.modify(target, value)
 
 			if object == "login":
 				OBJECT.modify(target, seuser, serange)
diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-2.0.52/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.52/semanage/semanage.8	2008-07-08 15:50:17.000000000 -0400
@@ -3,9 +3,9 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|lC|D} [\-n] 
+.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] [\-S store] 
 .br
-.B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] boolean
+.B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] -F boolean | boolean_file
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
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
diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.52/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.52/semanage/seobject.py	2008-07-08 15:50:17.000000000 -0400
@@ -1448,53 +1448,58 @@
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
 
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
-
-		if value != "":
-			nvalue = int(value)
-			semanage_bool_set_value(b, nvalue)
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
+
+                if value != "":
+                       nvalue = int(value)
+                       semanage_bool_set_value(b, nvalue)
                 else:
                        raise ValueError(_("You must specify a value"))
+                
+                rc = semanage_bool_set_active(self.sh, k, b)
+                if rc < 0:
+                       raise ValueError(_("Could not set active value of boolean %s") % name)
+                rc = semanage_bool_modify_local(self.sh, k, b)
+                if rc < 0:
+                       raise ValueError(_("Could not modify boolean %s") % name)
+		semanage_bool_key_free(k)
+		semanage_bool_free(b)
 
+	def modify(self, name, value=False, use_file=False):
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
+                       for b in fd.read().split():
+                              bool, val = b.split("=")
+                              self.__mod(bool, val)
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
@@ -1571,8 +1576,15 @@
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

--------------020208070909040002020901
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkhzxbIACgkQrlYvE4MpobOjmgCeNi9lN1uocFPy19UzWhS/XyjdeR4An3nQ
101OULKosYtRaAK8wcELE0wL
--------------020208070909040002020901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
