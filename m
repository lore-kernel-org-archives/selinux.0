Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HLIPXf009436
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 16:18:25 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HLHHP2010936
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 21:17:17 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k0HLHUqY030462
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 16:17:30 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k0HLHUuv030461
	for selinux@tycho.nsa.gov; Tue, 17 Jan 2006 16:17:30 -0500
Message-ID: <43CD54B9.4030307@redhat.com>
Date: Tue, 17 Jan 2006 15:34:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Latest policycoreutils patch
Content-Type: multipart/mixed;
 boundary="------------010209060602000108030902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010209060602000108030902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Includes Ivan and Russells changes

Now checks to make sure run as root.

Also chcat can now manipulate categories of users as well as files.



--------------010209060602000108030902
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-1.29.7/scripts/chcat
--- nsapolicycoreutils/scripts/chcat	2006-01-04 13:07:46.000000000 -0500
+++ policycoreutils-1.29.7/scripts/chcat	2006-01-17 12:44:55.000000000 -0500
@@ -23,15 +23,51 @@
 #
 #  
 import commands, sys, os, pwd, string, getopt, re, selinux
+import seobject
 
-def chcat_add(orig, newcat, files):
+def chcat_user_add(orig, newcat, users):
+    errors=0
+    logins = seobject.loginRecords()
+    seusers=logins.get_all()
+    add_ind=0
+    for u in users:
+        if u in seusers.keys():
+            user=seusers[u]
+        else:
+            add_ind=1
+            user=seusers["__default__"]
+        range=user[1].split("-")
+        cats=[]
+        top=["s0"]
+        if len(range) > 1:
+            top=range[1].split(":")
+            if len(top) > 1:
+                cats.append(top[1])
+                cats = expandCats(cats)
+
+        for i in newcat[1:]:
+            if i not in cats:
+                cats.append(i)
+        new_range="%s-%s:%s" % (range[0], top[0], string.join(cats, ","))
+        
+        if add_ind:
+            logins.add(u, user[0], new_range)
+        else:
+            logins.modify(u, user[0], new_range)
+    return errors
+        
+def chcat_add(orig, newcat, objects,login_ind):
     if len(newcat) == 1:
         raise ValueError("Requires at least one category")
+
+    if login_ind == 1:
+        return chcat_user_add(orig, newcat, objects)
+    
     errors=0
     sensitivity=newcat[0]
     cat=newcat[1]
     cmd='chcon -l %s' % sensitivity
-    for f in files:
+    for f in objects:
         (rc, c) = selinux.getfilecon(f)
         con=c.split(":")[3:]
         clist = translate(con)
@@ -57,14 +93,50 @@
             errors+=1
     return errors
 
-def chcat_remove(orig, newcat, files):
+def chcat_user_remove(orig, newcat, users):
+    errors=0
+    logins = seobject.loginRecords()
+    seusers=logins.get_all()
+    add_ind=0
+    for u in users:
+        if u in seusers.keys():
+            user=seusers[u]
+        else:
+            add_ind=1
+            user=seusers["__default__"]
+        range=user[1].split("-")
+        cats=[]
+        top=["s0"]
+        if len(range) > 1:
+            top=range[1].split(":")
+            if len(top) > 1:
+                cats.append(top[1])
+                cats = expandCats(cats)
+
+        for i in newcat[1:]:
+            if i in cats:
+                cats.remove(i)
+
+        new_range="%s-%s:%s" % (range[0], top[0], string.join(cats, ","))
+        
+        if add_ind:
+            logins.add(u, user[0], new_range)
+        else:
+            logins.modify(u, user[0], new_range)
+    return errors
+        
+def chcat_remove(orig, newcat, objects, login_ind):
     if len(newcat) == 1:
         raise ValueError("Requires at least one category")
+
+    if login_ind == 1:
+        return chcat_user_remove(orig, newcat, objects)
+
     errors=0
     sensitivity=newcat[0]
     cat=newcat[1]
 
-    for f in files:
+    for f in objects:
         (rc, c) = selinux.getfilecon(f)
         con=c.split(":")[3:]
         clist = translate(con)
@@ -97,7 +169,29 @@
             errors+=1
     return errors
 
-def chcat_replace(orig, newcat, files):
+def chcat_user_replace(orig, newcat, users):
+    errors=0
+    logins = seobject.loginRecords()
+    seusers=logins.get_all()
+    add_ind=0
+    for u in users:
+        if u in seusers.keys():
+            user=seusers[u]
+        else:
+            add_ind=1
+            user=seusers["__default__"]
+        range=user[1].split("-")
+        new_range="%s-%s:%s" % (range[0],newcat[0], string.join(newcat[1:], ","))
+        
+        if add_ind:
+            logins.add(u, user[0], new_range)
+        else:
+            logins.modify(u, user[0], new_range)
+    return errors
+    
+def chcat_replace(orig, newcat, objects, login_ind):
+    if login_ind == 1:
+        return chcat_user_replace(orig, newcat, objects)
     errors=0
     if len(newcat) == 1:
         sensitivity=newcat[0]
@@ -108,7 +202,7 @@
         for cat in newcat[2:]:
             cmd='%s,%s' % (cmd, cat)
         
-    for f in files:
+    for f in objects:
         cmd = "%s %s" % (cmd, f)
 
     rc=commands.getstatusoutput(cmd)
@@ -181,11 +275,15 @@
     
 def usage():
 	print "Usage %s CATEGORY File ..." % sys.argv[0]
+	print "Usage %s -l CATEGORY user ..." % sys.argv[0]
 	print "Usage %s [[+|-]CATEGORY],...]q File ..." % sys.argv[0]
+	print "Usage %s -l [[+|-]CATEGORY],...]q user ..." % sys.argv[0]
 	print "Usage %s -d File ..." % sys.argv[0]
-	print "Usage %s -l" % sys.argv[0]
+	print "Usage %s -l -d user ..." % sys.argv[0]
+	print "Usage %s -L" % sys.argv[0]
         print "Use -- to end option list.  For example"
-        print "chcat -- -CompanyConfidential /docs/businessplan.odt."
+        print "chcat -- -CompanyConfidential /docs/businessplan.odt"
+        print "chcat -l +CompanyConfidential juser"
 	sys.exit(1)
 
 def listcats():
@@ -199,6 +297,19 @@
     fd.close()
     return 0
     
+def listusercats(users):
+    seusers = seobject.loginRecords().get_all()
+    for u in users:
+        if u in seusers.keys():
+            cats=seobject.translate(seusers[u][1])
+        else:
+            cats=seobject.translate(seusers["__default__"][1])
+        cats=cats.split("-")
+        if len(cats) > 1 and cats[1] != "s0":
+            print "%s: %s" % (u, cats[1])
+        else:
+            print "%s:" % u
+            
 def error(msg):
     print "%s: %s" % (sys.argv[0], msg)
     sys.exit(1)
@@ -212,10 +323,12 @@
         
     delete_ind=0
     list_ind=0
+    login_ind=0
     try:
         gopts, cmds = getopt.getopt(sys.argv[1:],
-                                    'dhl',
+                                    'dhlL',
                                     ['list',
+                                     'login',
                                      'help',
                                      'delete'])
 
@@ -224,8 +337,10 @@
                 usage()
             if o == "-d" or o == "--delete":
                 delete_ind=1
-            if o == "-l" or o == "--list":
+            if o == "-L" or o == "--list":
                 list_ind=1
+            if o == "-l" or o == "--login":
+                login_ind=1
 
         if list_ind==0 and len(cmds) < 1:
             usage()
@@ -233,10 +348,17 @@
         usage()
 
     if delete_ind:
-        sys.exit(chcat_replace(["s0"], ["s0"], cmds))
+        sys.exit(chcat_replace(["s0"], ["s0"], cmds, login_ind))
 
     if list_ind:
-        sys.exit(listcats())
+        if login_ind:
+            if len(cmds) < 1:
+                usage()
+            sys.exit(listusercats(cmds))
+        else:
+            if len(cmds) > 0:
+                usage()
+            sys.exit(listcats())
 
     if len(cmds) < 2:
         usage()
@@ -245,19 +367,19 @@
     cats=cmds[0].split(",")
     mod_ind=0
     errors=0
-    files=cmds[1:]
+    objects=cmds[1:]
     try:
         if check_replace(cats):
-            errors=chcat_replace(cats,translate(cats), files)
+            errors=chcat_replace(cats,translate(cats), objects, login_ind)
         else:
             for c in cats:
                 l=[]
                 l.append(c[1:])
                 if len(c) > 0 and c[0] == "+":
-                    errors += chcat_add(c[1:],translate(l), files)
+                    errors += chcat_add(c[1:],translate(l), objects, login_ind)
                     continue
                 if len(c) > 0 and c[0] == "-":
-                    errors += chcat_remove(c[1:],translate(l), files)
+                    errors += chcat_remove(c[1:],translate(l), objects, login_ind)
                     continue
     except ValueError, e:
         error(e)
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat.8 policycoreutils-1.29.7/scripts/chcat.8
--- nsapolicycoreutils/scripts/chcat.8	2006-01-04 13:07:46.000000000 -0500
+++ policycoreutils-1.29.7/scripts/chcat.8	2006-01-17 12:49:34.000000000 -0500
@@ -5,31 +5,45 @@
 .B chcat
 \fICATEGORY FILE\fR...
 .br
+.B chcat -l 
+\fICATEGORY USER\fR...
+.br
 .B chcat
 \fI[[+|-]CATEGORY],...]  FILE\fR...
 .br
+.B chcat -l 
+\fI[[+|-]CATEGORY],...]  USER\fR...
+.br
 .B chcat
 [\fI-d\fR] \fIFILE\fR...
 .br
+.B chcat -l 
+[\fI-d\fR] \fIUSER\fR...
+.br
 .B chcat
-[\fI-l\fR] 
+\fI-L\fR [-l] [ USER ... ] 
 .br
 .PP
-Change/Remove the security CATEGORY for each FILE.
+Change/Remove the security CATEGORY for each FILE/USER.
 .PP
-Use +/- to add/remove categories from a FILE.
+Use +/- to add/remove categories from a FILE/USER.
 .TP
 \fB\-d\fR
-delete the category from each file.
+delete the category from each FILE/USER.
 .TP
-\fB\-l\fR
+\fB\-L\fR
 list available categories.
+.TP
+\fB\-l\fR
+Tells chcat to operate on users instead of files.
 .SH "SEE ALSO"
 .TP
-chcon(1), selinux(8)
+chcon(1), selinux(8), semanage(8)
 .PP
 .br
-This script wraps the chcon command.
+When operating on files this script wraps the chcon command.
 .SH "FILES"
 /etc/selinux/{SELINUXTYPE}/setrans.conf 
+.br
+/etc/selinux/{SELINUXTYPE}/seuser
 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.29.7/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2006-01-13 09:47:40.000000000 -0500
+++ policycoreutils-1.29.7/scripts/genhomedircon	2006-01-15 08:42:38.000000000 -0500
@@ -327,6 +327,9 @@
 			sys.stderr.write("%s: %s\n" % ( sys.argv[0], error ))
 
 
+if os.getuid() > 0 or os.geteuid() > 0:
+	print "You must be root to run %s." % sys.argv[0]
+	sys.exit(0)
 
 #
 # This script will generate home dir file context
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-1.29.7/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2006-01-13 09:47:40.000000000 -0500
+++ policycoreutils-1.29.7/semanage/semanage	2006-01-15 09:04:05.000000000 -0500
@@ -20,23 +20,27 @@
 #                                        02111-1307  USA
 #
 #  
-import sys, getopt
+import os, sys, getopt
 import seobject
 
 if __name__ == '__main__':
+	if os.getuid() > 0 or os.geteuid() > 0:
+		print "You must be root to run %s." % sys.argv[0]
+		sys.exit(0)
 
 	def usage(message = ""):
 		print '\
-semanage user [-admsRrh] SELINUX_USER\n\
-semanage login [-admsrh] LOGIN_NAME\n\
-semanage port [-admth] PORT | PORTRANGE\n\
-semanage interface [-admth] INTERFACE\n\
-semanage fcontext [-admhfst] INTERFACE\n\
+semanage user [-admLRr] SELINUX_USER\n\
+semanage login [-admsr] LOGIN_NAME\n\
+semanage port [-admtpr] PORT | PORTRANGE\n\
+semanage interface [-admtr] INTERFACE\n\
+semanage fcontext [-admhfrst] INTERFACE\n\
 	-a, --add        Add a OBJECT record NAME\n\
 	-d, --delete     Delete a OBJECT record NAME\n\
 	-f, --ftype      File Type of OBJECT \n\
 	-h, --help       display this message\n\
 	-l, --list       List the OBJECTS\n\
+	-L, --level      Default SELinux Level\n\
 	-n, --noheading  Do not print heading when listing OBJECTS\n\
 	-m, --modify     Modify a OBJECT record NAME\n\
 	-r, --range      MLS/MCS Security Range\n\
@@ -84,7 +88,7 @@
 			
 		args = sys.argv[2:]
 		gopts, cmds = getopt.getopt(args,
-					    'adf:lhmnp:P:s:R:r:t:v',
+					    'adf:lhmnp:P:s:R:L:r:t:v',
 					    ['add',
 					     'delete',
 					     'ftype=',
@@ -96,6 +100,7 @@
 					     'proto=',
 					     'seuser=',
 					     'range=',
+					     'level=',
 					     'roles=',
 					     'type=',
 					     'verbose'
@@ -106,7 +111,7 @@
 					usage()
 				add = 1
 				
-			if o == "-d"  or o == "--delese":
+			if o == "-d"  or o == "--delete":
 				if modify or add:
 					usage()
 				delete = 1
@@ -126,21 +131,24 @@
 			if o == "-r" or o == '--range':
 				serange = a
 
+			if o == "-l" or o == "--list":
+				list = 1
+
+			if o == "-L" or o == '--level':
+				selevel = a
+
 			if o == "-P" or o == '--proto':
 				proto = a
 
 			if o == "-R" or o == '--roles':
 				roles = a
 
-			if o == "-t" or o == "--type":
-				setype = a
-
-			if o == "-l" or o == "--list":
-				list = 1
-
 			if o == "-s" or o == "--seuser":
 				seuser = a
 
+			if o == "-t" or o == "--type":
+				setype = a
+
 			if o == "-v" or o == "--verbose":
 				verbose = 1
 
@@ -210,8 +218,13 @@
 		if delete:
 			if object == "port":
 				OBJECT.delete(target, proto)
+
+			if object == "fcontext":
+				OBJECT.delete(target, ftype)
+
 			else:
 				OBJECT.delete(target)
+
 			sys.exit(0);
 		usage()
 			
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.29.7/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2005-11-29 10:55:01.000000000 -0500
+++ policycoreutils-1.29.7/semanage/semanage.8	2006-01-15 09:04:56.000000000 -0500
@@ -3,55 +3,71 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage OBJECTTYPE [\-admsrh] OBJECT
-.B semanage login [\-admsrh] login_name
+.B semanage {login|user|port|interface|fcontext} \-l
 .br
-.B semanage seuser [\-admsrh] selinux_name
+.B semanage login \-{a|d|m} [\-sr] login_name
 .br
-.B semanage port [\-admth] port_number
+.B semanage user \-{a|d|m} [\-LrR] selinux_name
+.br
+.B semanage port \-{a|d|m} [\-tp] port_number
+.br
+.B semanage interface \-{a|d|m} [\-tr] interface_spec
+.br
+.B semanage fcontext \-{a|d|m} [\-frst] file_spec
 .P
-This tool is used to manage configuration of the SELinux policy
+
+This tool is used to configure SELinux policy
 
 .SH "DESCRIPTION"
 This manual page describes the
 .BR semanage
 program.
 .br
-This tool is used to manage configuration of SELinux Policy.  You can configure SELinux User Mappings, SELinux Port Mappings, SELinux Users.
-
+This tool is used to configure SELinux Policy.  You can configure SELinux User Mappings, SELinux Port Mappings, SELinux Users. File Context and Network Interfaces.
 
 .SH "OPTIONS"
-.TP 
-                \-a, \-\-add        
-.P
+.TP
+.I                \-a, \-\-add        
 Add a OBJECT record NAME
-.B                \-d, \-\-delete     
-.P
+.TP
+.I                \-d, \-\-delete     
 Delete a OBJECT record NAME
-.B                \-h, \-\-help       
-.P
+.TP
+.I                \-h, \-\-help       
 display this message
-.B                \-l, \-\-list       
-.P
+.TP
+.I                \-f, \-\-ftype
+File Type.   This is used with fcontext.
+Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
+.TP
+.I                \-l, \-\-list       
 List the OBJECTS
-.B                \-m, \-\-modify     
-.P
+.TP
+.I                \-L, \-\-level
+Default SELinux Level for SELinux use. (s0)
+.TP
+.I                \-m, \-\-modify     
 Modify a OBJECT record NAME
-.B                \-r, \-\-range      
-.P
+.TP
+.I                \-p, \-\-proto
+Protocol for the specified port (tcp|udp).
+.TP
+.I                \-R, \-\-role
+SELinux Roles (Separate by spaces)
+.TP
+.I                \-r, \-\-range      
 MLS/MCS Security Range
-.B                \-s, \-\-seuser     
-.P
+.TP
+.I                \-s, \-\-seuser     
 SELinux user name
-.B                \-t, \-\-type       
-.P
+.TP
+.I                \-t, \-\-type       
 SELinux Type for the object
-.B                \-v, \-\-verbose    
-.P
+.TP
+.I                \-v, \-\-verbose    
 verbose output
 
 .SH "AUTHOR"
-This man page was written by Daniel Walsh <dwalsh@redhat.com>.
-
-
+This man page was written by Daniel Walsh <dwalsh@redhat.com> and
+Russell Coker <rcoker@redhat.com>.
 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.29.7/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-01-13 08:39:11.000000000 -0500
+++ policycoreutils-1.29.7/semanage/seobject.py	2006-01-15 09:50:28.000000000 -0500
@@ -21,8 +21,39 @@
 #
 #  
 
-import pwd, string
+import pwd, string, selinux
 from semanage import *;
+
+def translate(raw, prepend=1):
+	if prepend == 1:
+		context="a:b:c:%s" % raw
+	else:
+		context=raw
+	(rc, trans)=selinux.selinux_raw_to_trans_context(context)
+	if rc != 0:
+		return raw
+	if prepend:
+		trans = trans.strip("a:b:c")
+	if trans == "":
+		return raw
+	else:
+		return trans
+	
+def untranslate(trans, prepend=1):
+ 	if prepend == 1:
+		context="a:b:c:%s" % trans
+	else:
+		context=raw
+	(rc, raw)=selinux.selinux_trans_to_raw_context(context)
+	if rc != 0:
+		return trans
+	if prepend:
+		raw = raw.strip("a:b:c")	
+	if raw == "":
+		return trans
+	else:
+		return raw
+	
 class semanageRecords:
 	def __init__(self):
 		self.sh = semanage_handle_create()
@@ -37,6 +68,9 @@
 	def add(self, name, sename, serange):
 		if serange == "":
 			serange = "s0"
+		else:
+			serange = untranslate(serange)
+			
 		if sename == "":
 			sename = "user_u"
 			
@@ -46,7 +80,7 @@
 
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if exists:
-			raise ValueError("SELinux User %s mapping already defined" % name)
+			raise ValueError("Login mapping for %s is already defined" % name)
 		try:
 			pwd.getpwnam(name)
 		except:
@@ -54,40 +88,65 @@
 			
 		(rc,u) = semanage_seuser_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create seuser for %s" % name)
+			raise ValueError("Could not create login mapping for %s" % name)
 
-		semanage_seuser_set_name(self.sh, u, name)
-		semanage_seuser_set_mlsrange(self.sh, u, serange)
-		semanage_seuser_set_sename(self.sh, u, sename)
-		semanage_begin_transaction(self.sh)
-		semanage_seuser_add(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add SELinux user mapping")
+		rc = semanage_seuser_set_name(self.sh, u, name)
+		if rc < 0:
+			raise ValueError("Could not set name for %s" % name)
+
+		rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
+		if rc < 0:
+			raise ValueError("Could not set MLS range for %s" % name)
+
+		rc = semanage_seuser_set_sename(self.sh, u, sename)
+		if rc < 0:
+			raise ValueError("Could not set SELinux user for %s" % name)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_seuser_modify(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to add login mapping for %s" % name)
+
+		rc = semanage_commit(self.sh) 
+		if rc < 0:
+			raise ValueError("Failed to add login mapping for %s" % name)
 
 	def modify(self, name, sename = "", serange = ""):
+		if sename == "" and serange == "":
+			raise ValueError("Requires seuser or serange")
+
 		(rc,k) = semanage_seuser_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		if sename == "" and serange == "":
-			raise ValueError("Requires, seuser or serange")
-
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
-		if exists:
-			(rc,u) = semanage_seuser_query(self.sh, k)
-			if rc < 0:
-				raise ValueError("Could not query seuser for %s" % name)
-		else:
-			raise ValueError("SELinux user %s mapping is not defined." % name)
+		if not exists:
+			raise ValueError("Login mapping for %s is not defined" % name)
+
+		(rc,u) = semanage_seuser_query(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not query seuser for %s" % name)
 
 		if serange != "":
-			semanage_seuser_set_mlsrange(self.sh, u, serange)
+			semanage_seuser_set_mlsrange(self.sh, u, untranslate(serange))
 		if sename != "":
 			semanage_seuser_set_sename(self.sh, u, sename)
-		semanage_begin_transaction(self.sh)
-		semanage_seuser_modify_local(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to modify SELinux user mapping")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not srart semanage transaction")
+
+		rc = semanage_seuser_modify(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to modify login mapping for %s" % name)
+	
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to modify login mapping for %s" % name)
+
 	def delete(self, name):
 		(rc,k) = semanage_seuser_key_create(self.sh, name)
 		if rc < 0:
@@ -95,15 +154,26 @@
 
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if not exists:
-			raise ValueError("SELinux user %s mapping is not defined." % name)
-		semanage_begin_transaction(self.sh)
-		semanage_seuser_del(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("SELinux User %s mapping not defined" % name)
+			raise ValueError("Login mapping for %s is not defined" % name)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_seuser_del(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete login mapping for %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete login mapping for %s" % name)
 		
 	def get_all(self):
 		dict={}
-		(status, self.ulist, self.usize) = semanage_seuser_list(self.sh)
+		(rc, self.ulist, self.usize) = semanage_seuser_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list login mappings")
+
 		for idx in range(self.usize):
 			u = semanage_seuser_by_idx(self.ulist, idx)
 			name = semanage_seuser_get_name(u)
@@ -117,7 +187,7 @@
 		keys=dict.keys()
 		keys.sort()
 		for k in keys:
-			print "%-25s %-25s %-25s" % (k, dict[k][0], dict[k][1])
+			print "%-25s %-25s %-25s" % (k, dict[k][0], translate(dict[k][1]))
 
 class seluserRecords(semanageRecords):
 	def __init__(self):
@@ -126,87 +196,134 @@
 	def add(self, name, roles, selevel, serange):
 		if serange == "":
 			serange = "s0"
+		else:
+			serange = untranslate(serange)
+			
 		if selevel == "":
 			selevel = "s0"
+		else:
+			selevel = untranslate(selevel)
 
 		(rc,k) = semanage_user_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
-		if not exists:
-			raise ValueError("SELinux user %s is already defined." % name)
+		if exists:
+			raise ValueError("SELinux user %s is already defined" % name)
 
 		(rc,u) = semanage_user_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create login mapping for %s" % name)
+			raise ValueError("Could not create SELinux user for %s" % name)
+
+		rc = semanage_user_set_name(self.sh, u, name)
+		if rc < 0:
+			raise ValueError("Could not set name for %s" % name)
 
-		semanage_user_set_name(self.sh, u, name)
 		for r in roles:
-			semanage_user_add_role(self.sh, u, r)
-		semanage_user_set_mlsrange(self.sh, u, serange)
-		semanage_user_set_mlslevel(self.sh, u, selevel)
+			rc = semanage_user_add_role(self.sh, u, r)
+			if rc < 0:
+				raise ValueError("Could not add role %s for %s" % (r, name))
+
+		rc = semanage_user_set_mlsrange(self.sh, u, serange)
+		if rc < 0:
+			raise ValueError("Could not set MLS range for %s" % name)
+
+		rc = semanage_user_set_mlslevel(self.sh, u, selevel)
+		if rc < 0:
+			raise ValueError("Could not set MLS level for %s" % name)
+
 		(rc,key) = semanage_user_key_extract(self.sh,u)
 		if rc < 0:
 			raise ValueError("Could not extract key for %s" % name)
 
-		semanage_begin_transaction(self.sh)
-		semanage_user_modify_local(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add SELinux user")
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_user_modify_local(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to add SELinux user %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add SELinux user %s" % name)
 
 	def modify(self, name, roles = [], selevel = "", serange = ""):
 		if len(roles) == 0  and serange == "" and selevel == "":
-			raise ValueError("Requires, roles, level  or range")
+			raise ValueError("Requires roles, level or range")
 
 		(rc,k) = semanage_user_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
-		if exists:
-			(rc,u) = semanage_user_query(self.sh, k)
-		else:
-			raise ValueError("SELinux user %s mapping is not defined locally." % name)
+		if not exists:
+			raise ValueError("SELinux user %s is not defined" % name)
+		
+		(rc,u) = semanage_user_query(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not query user for %s" % name)
 
 		if serange != "":
-			semanage_user_set_mlsrange(self.sh, u, serange)
+			semanage_user_set_mlsrange(self.sh, u, untranslate(serange))
 		if selevel != "":
-			semanage_user_set_mlslevel(self.sh, u, selevel)
+			semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
+			
 		if len(roles) != 0:
 			for r in roles:
 				semanage_user_add_role(self.sh, u, r)
-		semanage_begin_transaction(self.sh)
-		semanage_user_modify_local(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to modify SELinux user")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_user_modify_local(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to modify SELinux user %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to modify SELinux user %s" % name)
 		
 	def delete(self, name):
 		(rc,k) = semanage_user_key_create(self.sh, name)
 		if rc < 0:
-			raise ValueError("Could not crpppeate a key for %s" % name)
+			raise ValueError("Could not create a key for %s" % name)
+
 		(rc,exists) = semanage_user_exists(self.sh, k)
 		if not exists:
-			raise ValueError("user %s is not defined" % name)
-		else:
-			(rc,exists) = semanage_user_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("user %s is not defined locally, can not delete " % name)
-			
-		semanage_begin_transaction(self.sh)
-		semanage_user_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Login User %s not defined" % name)
+			raise ValueError("SELinux user %s is not defined" % name)
+
+		(rc,exists) = semanage_user_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("SELinux user %s is defined in policy, cannot be deleted" % name)
+			
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_user_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete SELinux user %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete SELinux user %s" % name)
 		
 	def get_all(self):
 		dict={}
-		(status, self.ulist, self.usize) = semanage_user_list(self.sh)
+		(rc, self.ulist, self.usize) = semanage_user_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list SELinux users")
+
 		for idx in range(self.usize):
 			u = semanage_user_by_idx(self.ulist, idx)
 			name = semanage_user_get_name(u)
-			(status, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
+			(rc, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
+			if rc < 0:
+				raise ValueError("Could not list roles for user %s" % name)
+
 			roles = ""
 
 			if rlist_size:
@@ -219,13 +336,13 @@
 
 	def list(self, heading=1):
 		if heading:
-			print "\n%-15s %-10s %-20s" % ("", "MLS/", "MLS/")
-			print "%-15s %-10s %-15s %-20s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
+			print "\n%-15s %-10s %-30s" % ("", "MLS/", "MLS/")
+			print "%-15s %-10s %-30s %s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
 		dict=self.get_all()
 		keys=dict.keys()
 		keys.sort()
 		for k in keys:
-			print "%-15s %-10s %-15s %s" % (k, dict[k][0], dict[k][1], dict[k][2])
+			print "%-15s %-10s %-30s %s" % (k, translate(dict[k][0]), translate(dict[k][1]), dict[k][2])
 
 class portRecords(semanageRecords):
 	def __init__(self):
@@ -258,6 +375,8 @@
 	def add(self, port, proto, serange, type):
 		if serange == "":
 			serange="s0"
+		else:
+			serange=untranslate(serange)
 			
 		if type == "":
 			raise ValueError("Type is required")
@@ -278,62 +397,97 @@
 		if rc < 0:
 			raise ValueError("Could not create context for %s/%s" % (proto, port))
 
-		semanage_context_set_user(self.sh, con, "system_u")
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
-		semanage_begin_transaction(self.sh)
+		rc = semanage_context_set_user(self.sh, con, "system_u")
+		if rc < 0:
+			raise ValueError("Could not set user in port context for %s/%s" % (proto, port))
+
+		rc = semanage_context_set_role(self.sh, con, "object_r")
+		if rc < 0:
+			raise ValueError("Could not set role in port context for %s/%s" % (proto, port))
+
+		rc = semanage_context_set_type(self.sh, con, type)
+		if rc < 0:
+			raise ValueError("Could not set type in port context for %s/%s" % (proto, port))
+
+		rc = semanage_context_set_mls(self.sh, con, serange)
+		if rc < 0:
+			raise ValueError("Could not set mls fields in port context for %s/%s" % (proto, port))
+
 		semanage_port_set_con(p, con)
-		semanage_port_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add port")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_port_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to add port %s/%s" % (proto, port))
+	
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add port %s/%s" % (proto, port))
 
 	def modify(self, port, proto, serange, setype):
 		if serange == "" and setype == "":
-			raise ValueError("Requires, setype or serange")
+			raise ValueError("Requires setype or serange")
 
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 
 		(rc,exists) = semanage_port_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_port_query(self.sh, k)
-		else:
-			raise ValueError("port %s/%s is not defined." % (proto,port))
-
+		if not exists:
+			raise ValueError("Port %s/%s is not defined" % (proto,port))
+	
+		(rc,p) = semanage_port_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Could not query port for %s/%s" % (proto, port))
+			raise ValueError("Could not query port %s/%s" % (proto, port))
 
 		con = semanage_port_get_con(p)
-		if rc < 0:
-			raise ValueError("Could not get port context for %s/%s" % (proto, port))
 			
 		if serange != "":
-			semanage_context_set_mls(self.sh, con, serange)	
+			semanage_context_set_mls(self.sh, con, untranslate(serange))
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
-		semanage_begin_transaction(self.sh)
-		semanage_port_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add port")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_port_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to modify port %s/%s" % (proto, port))
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add port %s/%s" % (proto, port))
 		
 	def delete(self, port, proto):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 		(rc,exists) = semanage_port_exists(self.sh, k)
 		if not exists:
-			raise ValueError("port %s/%s is not defined." % (proto,port))
-		else:
-			(rc,exists) = semanage_port_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("port %s/%s is not defined localy, can not be deleted." % (proto,port))
-
-		semanage_begin_transaction(self.sh)
-		semanage_port_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Port %s/%s not defined" % (proto,port))
+			raise ValueError("Port %s/%s is not defined" % (proto, port))
+		
+		(rc,exists) = semanage_port_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("Port %s/%s is defined in policy, cannot be deleted" % (proto, port))
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_port_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not delete port %s/%s" % (proto, port))
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Could not delete port %s/%s" % (proto, port))
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_port_list(self.sh)
+		(rc, self.plist, self.psize) = semanage_port_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list ports")
+
 		for idx in range(self.psize):
 			u = semanage_port_by_idx(self.plist, idx)
 			con = semanage_port_get_con(u)
@@ -369,89 +523,130 @@
 	def add(self, interface, serange, type):
 		if serange == "":
 			serange="s0"
+		else:
+			serange=untranslate(serange)
 			
 		if type == "":
 			raise ValueError("SELinux Type is required")
 
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % interface)
+			raise ValueError("Could not create key for %s" % interface)
+
 		(rc,exists) = semanage_iface_exists(self.sh, k)
 		if exists:
 			raise ValueError("Interface %s already defined" % interface)
 
 		(rc,iface) = semanage_iface_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create interface for %s" % (interface))
+			raise ValueError("Could not create interface for %s" % interface)
 		
 		rc = semanage_iface_set_name(self.sh, iface, interface)
 		(rc, con) = semanage_context_create(self.sh)
 		if rc < 0:
 			raise ValueError("Could not create context for %s" % interface)
 
-		semanage_context_set_user(self.sh, con, "system_u")
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
-		semanage_begin_transaction(self.sh)
+		rc = semanage_context_set_user(self.sh, con, "system_u")
+		if rc < 0:
+			raise ValueError("Could not set user in interface context for %s" % interface)
+
+		rc = semanage_context_set_role(self.sh, con, "object_r")
+		if rc < 0:
+			raise ValueError("Could not set role in interface context for %s" % interface)
+
+		rc = semanage_context_set_type(self.sh, con, type)
+		if rc < 0:
+			raise ValueError("Could not set type in interface context for %s" % interface)
+
+		rc = semanage_context_set_mls(self.sh, con, serange)
+		if rc < 0:
+			raise ValueError("Could not set mls fields in interface context for %s" % interface)
+
+		(rc, con2) = semanage_context_clone(self.sh, con)
+		if rc < 0:
+			raise ValueError("Could not clone interface context for %s" % interface)
+
 		semanage_iface_set_ifcon(iface, con)
-		semanage_iface_set_msgcon(iface, con)
-		semanage_iface_add_local(self.sh, k, iface)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add interface")
+		semanage_iface_set_msgcon(iface, con2)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_iface_modify_local(self.sh, k, iface)
+		if rc < 0:
+			raise ValueError("Failed to add interface %s" % interface)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add interface %s" % interface)
 
 	def modify(self, interface, serange, setype):
 		if serange == "" and setype == "":
-			raise ValueError("Requires, setype or serange")
+			raise ValueError("Requires setype or serange")
 
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
-			raise ValueError("Can't creater key for %s" % interface)
-		(rc,exists) = semanage_iface_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_iface_query(self.sh, k)
-		else:
-			raise ValueError("interface %s is not defined." % interface)
+			raise ValueError("Could not create key for %s" % interface)
 
+		(rc,exists) = semanage_iface_exists(self.sh, k)
+		if not exists:
+			raise ValueError("Interface %s is not defined" % interface)
+	
+		(rc,p) = semanage_iface_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Could not query interface for %s" % interface)
+			raise ValueError("Could not query interface %s" % interface)
 
 		con = semanage_iface_get_ifcon(p)
-		if rc < 0:
-			raise ValueError("Could not get interface context for %s" % interface)
 			
 		if serange != "":
-			semanage_context_set_mls(self.sh, con, serange)	
+			semanage_context_set_mls(self.sh, con, untranslate(serange))
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
 
-		semanage_begin_transaction(self.sh)
-		semanage_iface_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add interface")
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_iface_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to modify interface %s" % interface)
 		
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add interface %s" % interface)
+
 	def delete(self, interface):
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % interface)
+			raise ValueError("Could not create key for %s" % interface)
+
 		(rc,exists) = semanage_iface_exists(self.sh, k)
 		if not exists:
-			raise ValueError("interface %s is not defined." % interface)
-		else:
-			(rc,exists) = semanage_iface_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("interface %s is not defined localy, can not be deleted." % interface)
-
-		semanage_begin_transaction(self.sh)
-		semanage_iface_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Interface %s not defined" % interface)
+			raise ValueError("Interface %s is not defined" % interface)
+
+		(rc,exists) = semanage_iface_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("Interface %s is defined in policy, cannot be deleted" % interface)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_iface_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete interface %s" % interface)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete interface %s" % interface)
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_iface_list(self.sh)
-		if status < 0:
-			raise ValueError("Unable to list interfaces")
+		(rc, self.plist, self.psize) = semanage_iface_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list interfaces")
+
 		for idx in range(self.psize):
 			interface = semanage_iface_by_idx(self.plist, idx)
 			con = semanage_iface_get_ifcon(interface)
@@ -466,7 +661,7 @@
 		keys=dict.keys()
 		keys.sort()
 		for k in keys:
-			print "%-30s %s:%s:%s:%s " % (k,dict[k][0], dict[k][1],dict[k][2], dict[k][3])
+			print "%-30s %s:%s:%s:%s " % (k,dict[k][0], dict[k][1],dict[k][2], translate(dict[k][3], False))
 			
 class fcontextRecords(semanageRecords):
 	def __init__(self):
@@ -495,89 +690,127 @@
 			
 		if serange == "":
 			serange="s0"
+		else:
+			serange=untranslate(serange)
 			
 		if type == "":
 			raise ValueError("SELinux Type is required")
 
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
+			raise ValueError("Could not create key for %s" % target)
+
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		print (rc, exists, target)
 		if exists:
-			raise ValueError("fcontext %s already defined" % target)
+			raise ValueError("File context for %s already defined" % target)
+
 		(rc,fcontext) = semanage_fcontext_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create fcontext for %s" % target)
+			raise ValueError("Could not create file context for %s" % target)
 		
 		rc = semanage_fcontext_set_expr(self.sh, fcontext, target)
 		(rc, con) = semanage_context_create(self.sh)
 		if rc < 0:
 			raise ValueError("Could not create context for %s" % target)
 
-		semanage_context_set_user(self.sh, con, seuser)
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
+		rc = semanage_context_set_user(self.sh, con, seuser)
+		if rc < 0:
+			raise ValueError("Could not set user in file context for %s" % target)
+		
+		rc = semanage_context_set_role(self.sh, con, "object_r")
+		if rc < 0:
+			raise ValueError("Could not set role in file context for %s" % target)
+
+		rc = semanage_context_set_type(self.sh, con, type)
+		if rc < 0:
+			raise ValueError("Could not set type in file context for %s" % target)
+
+		rc = semanage_context_set_mls(self.sh, con, serange)
+		if rc < 0:
+			raise ValueError("Could not set mls fields in file context for %s" % target)
+
 		semanage_fcontext_set_type(fcontext, self.file_types[ftype])
-		semanage_begin_transaction(self.sh)
 		semanage_fcontext_set_con(fcontext, con)
-		semanage_fcontext_add_local(self.sh, k, fcontext)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_modify_local(self.sh, k, fcontext)
+		if rc < 0:
+			raise ValueError("Failed to add file context for %s" % target)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add file context for %s" % target)
 
 	def modify(self, target, setype, ftype, serange, seuser):
 		if serange == "" and setype == "" and seuser == "":
-			raise ValueError("Requires, setype, serange or seuser")
+			raise ValueError("Requires setype, serange or seuser")
 
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
 		if rc < 0:
-			raise ValueError("Can't creater key for %s" % target)
+			raise ValueError("Could not create a key for %s" % target)
+
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_fcontext_query(self.sh, k)
-		else:
-			raise ValueError("fcontext %s is not defined." % target)
+		if not exists:
+			raise ValueError("File context for %s is not defined" % target)
+		
+		(rc,p) = semanage_fcontext_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Could not query fcontext for %s" % target)
+			raise ValueError("Could not query file context for %s" % target)
+
 		con = semanage_fcontext_get_con(p)
-		if rc < 0:
-			raise ValueError("Could not get fcontext context for %s" % target)
 			
 		if serange != "":
-			semanage_context_set_mls(self.sh, con, serange)	
+			semanage_context_set_mls(self.sh, con, untranslate(serange))
 		if seuser != "":
 			semanage_context_set_user(self.sh, con, seuser)	
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
 
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to modify file context for %s" % target)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add file context for %s" % target)
 		
-	def delete(self, target):
+	def delete(self, target, ftype):
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
+			raise ValueError("Could not create a key for %s" % target)
+
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
 		if not exists:
-			raise ValueError("fcontext %s is not defined." % target)
-		else:
-			(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("fcontext %s is not defined localy, can not be deleted." % target)
-
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("fcontext %s not defined" % target)
+			raise ValueError("File context for %s is not defined" % target)
+		
+		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("File context for %s is defined in policy, cannot be deleted" % target)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete file context for %s" % target)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete file context for %s" % target)
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_fcontext_list(self.sh)
-		if status < 0:
-			raise ValueError("Unable to list fcontexts")
+		(rc, self.plist, self.psize) = semanage_fcontext_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list file contexts")
 
 		for idx in range(self.psize):
 			fcontext = semanage_fcontext_by_idx(self.plist, idx)
@@ -598,7 +831,7 @@
 		keys=dict.keys()
 		for k in keys:
 			if dict[k]:
-				print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], dict[k][0], dict[k][1],dict[k][2], dict[k][3])
+				print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], dict[k][0], dict[k][1],dict[k][2], translate(dict[k][3],False))
 			else:
 				print "%-50s %-18s <<None>>" % (k[0], k[1])
 				
@@ -606,117 +839,82 @@
 	def __init__(self):
 		semanageRecords.__init__(self)
 		
-	def add(self, target, type, ftype="", serange="s0", seuser="system_u"):
-		if seuser == "":
-			seuser="system_u"
-			
-		if serange == "":
-			serange="s0"
-			
-		if type == "":
-			raise ValueError("SELinux Type is required")
+	def modify(self, name, value = ""):
+		if value == "":
+			raise ValueError("Requires value")
 
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
-		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		print (rc, exists, target)
-		if exists:
-			raise ValueError("fcontext %s already defined" % target)
-		(rc,fcontext) = semanage_fcontext_create(self.sh)
-		if rc < 0:
-			raise ValueError("Could not create fcontext for %s" % target)
-		
-		rc = semanage_fcontext_set_expr(self.sh, fcontext, target)
-		(rc, con) = semanage_context_create(self.sh)
+		(rc,k) = semanage_bool_key_create(self.sh, name)
 		if rc < 0:
-			raise ValueError("Could not create context for %s" % target)
-
-		semanage_context_set_user(self.sh, con, seuser)
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
-		semanage_fcontext_set_type(fcontext, self.file_types[ftype])
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_set_con(fcontext, con)
-		semanage_fcontext_add_local(self.sh, k, fcontext)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+			raise ValueError("Could not create a key for %s" % name)
 
-	def modify(self, target, setype, ftype, serange, seuser):
-		if serange == "" and setype == "" and seuser == "":
-			raise ValueError("Requires, setype, serange or seuser")
+		(rc,exists) = semanage_bool_exists(self.sh, k)
+		if not exists:
+			raise ValueError("Boolean %s is not defined" % name)	
 
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
+		(rc,b) = semanage_bool_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Can't creater key for %s" % target)
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_fcontext_query(self.sh, k)
-		else:
-			raise ValueError("fcontext %s is not defined." % target)
+			raise ValueError("Could not query file context %s" % name)
+
+		if value != "":
+			nvalue = string.atoi(value)
+			semanage_bool_set_value(b, nvalue)
+
+		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
-			raise ValueError("Could not query fcontext for %s" % target)
-		con = semanage_fcontext_get_con(p)
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_bool_modify_local(self.sh, k, b)
 		if rc < 0:
-			raise ValueError("Could not get fcontext context for %s" % target)
-			
-		if serange != "":
-			semanage_context_set_mls(self.sh, con, serange)	
-		if seuser != "":
-			semanage_context_set_user(self.sh, con, seuser)	
-		if setype != "":
-			semanage_context_set_type(self.sh, con, setype)
+			raise ValueError("Failed to modify boolean %s" % name)
 
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to modify boolean %s" % name)
 		
-	def delete(self, target):
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
+	def delete(self, name):
+		(rc,k) = semanage_bool_key_create(self.sh, name)
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+			raise ValueError("Could not create a key for %s" % name)
+
+		(rc,exists) = semanage_bool_exists(self.sh, k)
 		if not exists:
-			raise ValueError("fcontext %s is not defined." % target)
-		else:
-			(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("fcontext %s is not defined localy, can not be deleted." % target)
-
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("fcontext %s not defined" % target)
+			raise ValueError("Boolean %s is not defined" % name)
+	
+		(rc,exists) = semanage_bool_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("Boolean %s is defined in policy, cannot be deleted" % name)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete boolean %s" % name)
+	
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete boolean %s" % name)
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_fcontext_list(self.sh)
-		if status < 0:
-			raise ValueError("Unable to list fcontexts")
+		(rc, self.blist, self.bsize) = semanage_bool_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list booleans")
 
-		for idx in range(self.psize):
-			fcontext = semanage_fcontext_by_idx(self.plist, idx)
-			expr=semanage_fcontext_get_expr(fcontext)
-			ftype=semanage_fcontext_get_type_str(fcontext)
-			con = semanage_fcontext_get_con(fcontext)
-			if con:
-				dict[expr, ftype]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
-			else:
-				dict[expr, ftype]=con
+		for idx in range(self.bsize):
+			boolean = semanage_bool_by_idx(self.blist, idx)
+			name = semanage_bool_get_name(boolean)
+			value = semanage_bool_get_value(boolean)
+			dict[name] = value
 
 		return dict
 			
 	def list(self, heading=1):
 		if heading:
-			print "%-50s %-18s %s\n" % ("SELinux fcontext", "type", "Context")
+			print "%-50s %-18s\n" % ("SELinux boolean", "value")
 		dict=self.get_all()
 		keys=dict.keys()
 		for k in keys:
 			if dict[k]:
-				print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], dict[k][0], dict[k][1],dict[k][2], dict[k][3])
-			else:
-				print "%-50s %-18s <<None>>" % (k[0], k[1])
-				
-			
+				print "%-50s %-18s " % (k[0], dict[k][0])
Binary files nsapolicycoreutils/semanage/seobject.pyc and policycoreutils-1.29.7/semanage/seobject.pyc differ

--------------010209060602000108030902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
