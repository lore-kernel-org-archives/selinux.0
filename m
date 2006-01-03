Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03IiuXf022476
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 13:44:56 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03Iisah028354
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 18:44:54 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k03Ii5O9032100
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 13:44:05 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k03Ii5XW032099
	for selinux@tycho.nsa.gov; Tue, 3 Jan 2006 13:44:05 -0500
Message-ID: <43BAC4EA.8020106@redhat.com>
Date: Tue, 03 Jan 2006 13:39:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Policycoreutils latest diffs.
Content-Type: multipart/mixed;
 boundary="------------000100040205090004060302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000100040205090004060302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes to restorecon to handle user_only_changed even in the -vv case.


Many fixes to chcat to get it working in the hundreds of different ways 
it can be used...

Changed fixfiles to sort before doing the diff.  New way of handling 
file_context seems to change the file_context sort order on every update 
causing fixfiles to falsely think things have changed.  This might not 
be ideal since ordering could cause problems.

genhomedircon fixes to make it work within anaconda.  Eliminated all 
calls to getstatusoutput.

Added test files to be run to make sure there are no regressions on 
updates.  Probably should get these to run automatically some how.

semanage modified to handle ports.  Currenly does not work because of 
some of Ivan's changes to libsepol, libsemanage and libselinux have not 
been added.



--------------000100040205090004060302
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.29.2/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2005-12-08 12:59:25.000000000 -0500
+++ policycoreutils-1.29.2/restorecon/restorecon.8	2006-01-02 14:35:46.000000000 -0500
@@ -45,7 +45,7 @@
 show changes in file labels, if type, role, or user are changing.
 .TP 
 .B \-F
-Force reset of context to match file_context for customizable files
+Force reset of context to match file_context for customizable files, or the user section, if it has changed. 
 .TP 
 .SH "ARGUMENTS"
 .B pathname...
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.29.2/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2005-12-08 12:59:25.000000000 -0500
+++ policycoreutils-1.29.2/restorecon/restorecon.c	2006-01-02 14:33:52.000000000 -0500
@@ -112,18 +112,16 @@
 void usage(const char * const name)
 {	
   fprintf(stderr,
-	  "usage:  %s [-rRnv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",  name);
+	  "usage:  %s [-FnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",  name);
   exit(1);
 }
 int restore(char *filename) {
   int retcontext=0;
-  int retval=0;
   security_context_t scontext=NULL;
   security_context_t prev_context=NULL;
   int len=strlen(filename);
   struct stat st;
   char path[PATH_MAX+1];
-  int user_only_changed=0;
   /* 
      Eliminate trailing /
   */
@@ -175,8 +173,7 @@
   if (excludeCtr > 0 && exclude(filename)) {
       return 0;
   }
-  retval = matchpathcon(filename, st.st_mode, &scontext);
-  if (retval < 0) {
+  if (matchpathcon(filename, st.st_mode, &scontext) < 0) {
     if (errno == ENOENT)
       return 0;
     fprintf(stderr,"matchpathcon(%s) failed %s\n", filename,strerror(errno));
@@ -194,27 +191,24 @@
     if (retcontext < 0 || force || 
 	(strcmp(prev_context,scontext) != 0 && 	
 	 !(customizable=is_context_customizable(prev_context) > 0))) {
-      if (outfile) {
-	fprintf(outfile, "%s\n", filename);
-      }
-      user_only_changed = only_changed_user(scontext, prev_context);
-      if (change && !user_only_changed) {
-	retval=lsetfilecon(filename,scontext);
-      }
-      if (retval<0) {
-	  fprintf(stderr,"%s set context %s->%s failed:'%s'\n",
-		  progname, filename, scontext, strerror(errno));
-	  if (retcontext >= 0)
-	    freecon(prev_context);
-	  freecon(scontext);
-	  return 1;
-      } else 	
-	      if (verbose && 
-		  (verbose > 1 || !user_only_changed))
+      if (only_changed_user(scontext, prev_context) == 0) {
+	      if (outfile) fprintf(outfile, "%s\n", filename);
+	      if (change) {
+		      if (lsetfilecon(filename,scontext) < 0) {
+			      fprintf(stderr,"%s set context %s->%s failed:'%s'\n",
+				      progname, filename, scontext, strerror(errno));
+			      if (retcontext >= 0)
+				      freecon(prev_context);
+			      freecon(scontext);
+			      return 1;
+		      }
+	      }
+	      if (verbose)
 		      printf("%s reset %s context %s->%s\n",
-			      progname, filename, (retcontext >= 0 ? prev_context : ""), scontext);
+			     progname, filename, (retcontext >= 0 ? prev_context : ""), scontext);
+      }
     }
-    if (verbose > 1 && customizable>0) {
+    if (verbose > 1 && ! force && customizable>0) {
 	    printf("%s: %s not reset customized by admin to %s\n",
 		      progname, filename, prev_context);
     }
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-1.29.2/scripts/chcat
--- nsapolicycoreutils/scripts/chcat	2005-12-14 14:16:50.000000000 -0500
+++ policycoreutils-1.29.2/scripts/chcat	2006-01-02 14:33:44.000000000 -0500
@@ -39,11 +39,11 @@
                 print("Can not modify sensitivity levels using '+' on %s" % f)
 
         if len(clist) > 1:
-            cats=clist[1].split(",")
-            if cat in cats:
+            if cat in clist[1:]:
                 print "%s is already in %s" % (f, orig)
                 continue
-            cats.append(cat)
+            clist.append(cat)
+            cats=clist[1:]
             cats.sort()
             cat_string=cats[0]
             for c in cats[1:]:
@@ -73,14 +73,13 @@
                 continue
             
         if len(clist) > 1:
-            cats=clist[1].split(",")
-            if cat not in cats:
+            if cat not in clist[1:]:
                 print "%s is not in %s" % (f, orig)
                 continue
-            cats.remove(cat)
-            if len(cats) > 0:
-                cat=cats[0]
-                for c in cats[1:]:
+            clist.remove(cat)
+            if len(clist) > 1:
+                cat=clist[1]
+                for c in clist[2:]:
                     cat="%s,%s" % (cat, c)
             else:
                 cat=""
@@ -91,7 +90,7 @@
         if len(cat) == 0: 
             cmd='chcon -l %s %s' % (sensitivity, f)
         else:
-            cmd='chcon -l %s:%s %s' % (sensitivity, cat, f)
+            cmd='chcon -l %s:%s %s' % (sensitivity,cat, f)
         rc=commands.getstatusoutput(cmd)
         if rc[0] != 0:
             print rc[1]
@@ -101,18 +100,17 @@
 def chcat_replace(orig, newcat, files):
     errors=0
     if len(newcat) == 1:
-        if newcat[0][0] == "s" and newcat[0][1:].isdigit() and int(newcat[0][1:]) in range(0,16):
-            sensitivity=newcat[0]
-            cmd='chcon -l %s ' % newcat[0]
-        else:
-            cmd='chcon -l s0:%s ' % newcat[0]
+        sensitivity=newcat[0]
+        cmd='chcon -l %s ' % newcat[0]
     else:
         sensitivity=newcat[0]
-        cat=newcat[1]
-        cmd='chcon -l %s:%s ' % (sensitivity, cat)
+        cmd='chcon -l %s:%s' % (sensitivity, newcat[1])
+        for cat in newcat[2:]:
+            cmd='%s,%s' % (cmd, cat)
         
     for f in files:
         cmd = "%s %s" % (cmd, f)
+
     rc=commands.getstatusoutput(cmd)
     if rc[0] != 0:
         print rc[1]
@@ -134,44 +132,73 @@
                 raise ValueError("Can not combine +/- with other types of categories")
     return replace_ind
 
+def isSensitivity(sensitivity):
+    if sensitivity[0] == "s" and sensitivity[1:].isdigit() and int(sensitivity[1:]) in range(0,16):
+        return 1
+    else:
+        return 0
+    
+def expandCats(cats):
+    newcats=[]
+    for c in cats:
+        if c.find(".") != -1:
+            c=c.split(".")
+            for i in range(int(c[0][1:]), int(c[1][1:])+1):
+                x=("c%d" % i)
+                if x not in newcats:
+                    newcats.append("c%d" % i)
+        else:
+            for i in c.split(","):
+                if i not in newcats:
+                    newcats.append(i)
+    return newcats
+
 def translate(cats):
     newcat=[]
+    if len(cats) == 0:
+        newcat.append("s0")
+        return newcat
     for c in cats:
         (rc, raw) = selinux.selinux_trans_to_raw_context("a:b:c:%s" % c)
         rlist=raw.split(":")[3:]
-        if len(rlist) > 1:
-            if len(newcat) == 0:
-                newcat.append(rlist[0])
-            else:
-                if newcat[0] != rlist[0]:
-                    raise ValueError("Can not have multiple sensitivities")
-            newcat.append(rlist[1])
-        else:
-            if rlist[0][0] == "s" and rlist[0][1:].isdigit() and int(rlist[0][1:]) in range(0,16):
-            
-                if len(newcat) == 0:
-                    newcat.append(rlist[0])
-                else:
-                    if newcat[0] != rlist[0]:
-                        raise ValueError("Can not have multiple sensitivities")
-            else:
-                if len(newcat) == 0:
-                    newcat.append("s0")
-                else:
-                    if newcat[0] != "s0":
-                        raise ValueError("Can not have multiple sensitivities")
-                newcat.append(rlist[0])
-                
+        tlist=[]
+        if isSensitivity(rlist[0])==0:
+            tlist.append("s0")
+            for i in expandCats(rlist):
+                tlist.append(i)
+        else:
+            tlist.append(rlist[0])
+            for i in expandCats(rlist[1:]):
+                tlist.append(i)
+        if len(newcat) == 0:
+            newcat.append(tlist[0])
+        else:
+            if newcat[0] != tlist[0]:
+                raise ValueError("Can not have multiple sensitivities")
+        for i in tlist[1:]:
+            newcat.append(i)
     return newcat
     
 def usage():
 	print "Usage %s CATEGORY File ..." % sys.argv[0]
 	print "Usage %s [[+|-]CATEGORY],...]q File ..." % sys.argv[0]
 	print "Usage %s -d File ..." % sys.argv[0]
+	print "Usage %s -l" % sys.argv[0]
         print "Use -- to end option list.  For example"
         print "chcat -- -CompanyConfidential /docs/businessplan.odt."
 	sys.exit(1)
 
+def listcats():
+    fd = open(selinux.selinux_translations_path())
+    for l in fd.read().split("\n"):
+        if l.startswith("#"):
+            continue
+        if l.find("=")!=-1:
+            rec=l.split("=")
+            print "%-30s %s" % tuple(rec)
+    fd.close()
+    return 0
+    
 def error(msg):
     print "%s: %s" % (sys.argv[0], msg)
     sys.exit(1)
@@ -184,10 +211,12 @@
         error("Requires an SELinux enabled system")
         
     delete_ind=0
+    list_ind=0
     try:
         gopts, cmds = getopt.getopt(sys.argv[1:],
-                                    'dh',
-                                    ['help',
+                                    'dhl',
+                                    ['list',
+                                     'help',
                                      'delete'])
 
         for o,a in gopts:
@@ -195,8 +224,10 @@
                 usage()
             if o == "-d" or o == "--delete":
                 delete_ind=1
+            if o == "-l" or o == "--list":
+                list_ind=1
 
-        if len(cmds) < 1:
+        if list_ind==0 and len(cmds) < 1:
             usage()
     except:
         usage()
@@ -204,6 +235,8 @@
     if delete_ind:
         sys.exit(chcat_replace(["s0"], ["s0"], cmds))
 
+    if list_ind:
+        sys.exit(listcats())
 
     if len(cmds) < 2:
         usage()
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat.8 policycoreutils-1.29.2/scripts/chcat.8
--- nsapolicycoreutils/scripts/chcat.8	2005-12-08 12:52:47.000000000 -0500
+++ policycoreutils-1.29.2/scripts/chcat.8	2006-01-02 14:33:44.000000000 -0500
@@ -11,6 +11,9 @@
 .B chcat
 [\fI-d\fR] \fIFILE\fR...
 .br
+.B chcat
+[\fI-l\fR] 
+.br
 .PP
 Change/Remove the security CATEGORY for each FILE.
 .PP
@@ -18,6 +21,9 @@
 .TP
 \fB\-d\fR
 delete the category from each file.
+.TP
+\fB\-l\fR
+list available categories.
 .SH "SEE ALSO"
 .TP
 chcon(1), selinux(8)
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.29.2/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-10-13 13:51:22.000000000 -0400
+++ policycoreutils-1.29.2/scripts/fixfiles	2006-01-02 14:33:44.000000000 -0500
@@ -62,8 +62,8 @@
 	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
 	test -z "$TEMPFILE" && exit
 	PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
-	sed -r -e 's,:s0, ,g' $PREFC > ${PREFCTEMPFILE}
-	sed -r -e 's,:s0, ,g' $FC | \
+	sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
+	sed -r -e 's,:s0, ,g' $FC | sort -u | \
 	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
 	    grep '^[<>]'|cut -c3-| grep ^/ | \
 	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.29.2/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-12-07 07:28:00.000000000 -0500
+++ policycoreutils-1.29.2/scripts/genhomedircon	2006-01-02 14:33:44.000000000 -0500
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/python
 # Copyright (C) 2004 Tresys Technology, LLC
 # see file 'COPYING' for use and warranty information
 #
@@ -26,64 +26,73 @@
 #
 #  
 
-import commands, sys, os, pwd, string, getopt, re
+import sys, os, pwd, string, getopt, re
 from semanage import *;
 
-fd=open("/etc/shells", 'r')
-VALID_SHELLS=fd.read().split('\n')
-fd.close()
-if "/sbin/nologin" in VALID_SHELLS:
-	VALID_SHELLS.remove("/sbin/nologin")
+try:
+	fd=open("/etc/shells", 'r')
+	VALID_SHELLS=fd.read().split('\n')
+	fd.close()
+	if "/sbin/nologin" in VALID_SHELLS:
+		VALID_SHELLS.remove("/sbin/nologin")
+except:
+	VALID_SHELLS = ['/bin/sh', '/bin/bash', '/bin/ash', '/bin/bsh', '/bin/ksh', '/usr/bin/ksh', '/usr/bin/pdksh', '/bin/tcsh', '/bin/csh', '/bin/zsh']
+
+def findval(file, var, delim=""):
+	val=""
+	try:
+		fd=open(file, 'r')
+		for i in  fd.read().split('\n'):
+			if i.startswith(var) == 1:
+				if delim == "":
+					val = i.split()[1]
+				else:
+					val = i.split(delim)[1]
+				val = val.split("#")[0]
+				val = val.strip()
+		fd.close()
+	except:
+		val=""
+	return val
 
 def getStartingUID():
 	starting_uid = sys.maxint
-	rc=commands.getstatusoutput("grep -h '^UID_MIN' /etc/login.defs")
-	if rc[0] == 0:
-		uid_min = re.sub("^UID_MIN[^0-9]*", "", rc[1])
-		#stip any comment from the end of the line
+	uid_min= findval("/etc/login.defs", "UID_MIN")
+	if uid_min != "":
 		uid_min = uid_min.split("#")[0]
 		uid_min = uid_min.strip()
 		if int(uid_min) < starting_uid:
 			starting_uid = int(uid_min)
-	rc=commands.getstatusoutput("grep -h '^LU_UIDNUMBER' /etc/libuser.conf")
-	if rc[0] == 0:
-		lu_uidnumber = re.sub("^LU_UIDNUMBER[^0-9]*", "", rc[1])
-		#stip any comment from the end of the line
-		lu_uidnumber = re.sub("[ \t].*", "", lu_uidnumber)
-		lu_uidnumber = lu_uidnumber.split("#")[0]
-		lu_uidnumber = lu_uidnumber.strip()
-		if int(lu_uidnumber) < starting_uid:
-			starting_uid = int(lu_uidnumber)
+
+	uid_min= findval("/etc/libuser.conf", "LU_UIDNUMBER", "=")
+	if uid_min != "":
+		uid_min = uid_min.split("#")[0]
+		uid_min = uid_min.strip()
+		if int(uid_min) < starting_uid:
+			starting_uid = int(uid_min)
+
 	if starting_uid == sys.maxint:
 		starting_uid = 500
 	return starting_uid
 
 def getDefaultHomeDir():
 	ret = []
-	rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
-	if rc[0] == 0:
-		homedir = rc[1].split("=")[1]
-		homedir = homedir.split("#")[0]
-		homedir = homedir.strip()
-		if not homedir in ret:
-			ret.append(homedir)
-
-	rc=commands.getstatusoutput("grep -h '^LU_HOMEDIRECTORY' /etc/libuser.conf")
-	if rc[0] == 0:
-		homedir = rc[1].split("=")[1]
-		homedir = homedir.split("#")[0]
-		homedir = homedir.strip()
-		if not homedir in ret:
-			ret.append(homedir)
-
+	homedir=findval("/etc/default/useradd", "HOME", "=")
+	if homedir != "" and not homedir in ret:
+		ret.append(homedir)
+	
+	homedir=findval("/etc/libuser.conf", "LU_HOMEDIRECTORY", "=")
+	if homedir != "" and not homedir in ret:
+		ret.append(homedir)
+	
 	if ret == []:
 		ret.append("/home")
 	return ret
 
 def getSELinuxType(directory):
-	rc=commands.getstatusoutput("grep ^SELINUXTYPE= %s/config" % directory)
-	if rc[0]==0:
-		return rc[1].split("=")[-1].strip()
+	val=findval(directory+"/config", "SELINUXTYPE", "=")
+	if val != "":
+		return val
 	return "targeted"
 
 def usage(error = ""):
@@ -129,11 +138,17 @@
 		return self.getFileContextDir()+"/homedir_template"
 
 	def getHomeRootContext(self, homedir):
-		rc=commands.getstatusoutput("grep HOME_ROOT  %s | sed -e \"s|^HOME_ROOT|%s|\"" % ( self.getHomeDirTemplate(), homedir))
-		if rc[0] == 0:
-			return rc[1]+"\n"
-		else:
-			errorExit("sed error %s" % rc[1])
+		ret=""
+		fd=open(self.getHomeDirTemplate(), 'r')
+
+		for i in  fd.read().split('\n'):
+			if i.find("HOME_ROOT") == 0:
+				i=i.replace("HOME_ROOT", homedir)
+				ret = i+"\n"
+		fd.close()
+		if ret=="":
+			errorExit("No Home Root Context Found")
+		return ret
 
 	def heading(self):
 		ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
@@ -152,32 +167,40 @@
 				return "user_r"
 		return name
 	def getOldRole(self, role):
-		rc = commands.getstatusoutput('grep "^user %s" %s' % (role, self.selinuxdir+self.type+"/users/system.users"))
-		if rc[0] != 0:					    
-			rc = commands.getstatusoutput('grep "^user %s" %s' % (role, self.selinuxdir+self.type+"/users/local.users"))
-		if rc[0] == 0:
-			user=rc[1].split()
+		rc=findval(self.selinuxdir+self.type+"/users/system.users", 'grep "^user %s"' % role, "=")
+		if rc == "":					    
+			rc=findval(self.selinuxdir+self.type+"/users/local.users", 'grep "^user %s"' % role, "=")
+		if rc != "":
+			user=rc.split()
 			role = user[3]
 			if role == "{":
 				role = user[4]
 		return role
 		
 	def adduser(self, udict, user, seuser, role):
+		if seuser == "user_u" or user == "__default__":
+			return
+		# !!! chooses first role in the list to use in the file context !!!
+		if role[-2:] == "_r" or role[-2:] == "_u":
+			role = role[:-2]
 		try:
-			if seuser == "user_u" or user == "__default__":
-				return
-			# !!! chooses first role in the list to use in the file context !!!
-			if role[-2:] == "_r" or role[-2:] == "_u":
-				role = role[:-2]
 			home = pwd.getpwnam(user)[5]
 			if home == "/":
-				return
-			prefs = {}
-			prefs["role"] = role
-			prefs["home"] = home
-			udict[seuser] = prefs
+				# Probably install so hard code to /root
+				if user == "root":
+					home="/root"
+				else:
+					return
 		except KeyError:
-			sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user)
+			if user == "root":
+				home = "/root"
+			else:
+				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user)
+				return
+		prefs = {}
+		prefs["role"] = role
+		prefs["home"] = home
+		udict[seuser] = prefs
 
 	def getUsers(self):
 		udict = {}
@@ -190,30 +213,50 @@
 				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, self.defaultrole(seusername))
 				
 		else:
-			rc = commands.getstatusoutput("grep -v '^ *#' %s" % self.selinuxdir+self.type+"/seusers")
-			if rc[0] == 0 and rc[1] != "":
-				ulist = rc[1].split("\n")
-				for u in ulist:
-					if len(u)==0:
+			try:
+				fd =open(self.selinuxdir+self.type+"/seusers")
+				for u in  fd.read().split('\n'):
+					u=u.strip()
+					if len(u)==0 or u[0]=="#":
 						continue
 					user = u.split(":")
 					if len(user) < 3:
 						continue
 					role=self.getOldRole(user[1])
 					self.adduser(udict, user[0], user[1], role)
+				fd.close()
+			except IOError, error:
+				# Must be install so force add of root
+				self.adduser(udict, "root", "root", "root")
+
 		return udict
 
 	def getHomeDirContext(self, user, home, role):
 		ret="\n\n#\n# Home Context for user %s\n#\n\n" % user
-		rc=commands.getstatusoutput("grep '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
-		return ret + rc[1] + "\n"
+		fd=open(self.getHomeDirTemplate(), 'r')
+		for i in  fd.read().split('\n'):
+			if i.startswith("HOME_DIR") == 1:
+				i=i.replace("HOME_DIR", home)
+				i=i.replace("ROLE", role)
+				i=i.replace("system_u", user)
+				ret = ret+i+"\n"
+		fd.close()
+		return ret
 
 	def getUserContext(self, user, sel_user, role):
-		rc=commands.getstatusoutput("grep 'USER' %s | sed -e 's/USER/%s/' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), user, role, sel_user))
-		return rc[1] + "\n"
+		ret=""
+		fd=open(self.getHomeDirTemplate(), 'r')
+		for i in  fd.read().split('\n'):
+			if i.find("USER") == 1:
+				i=i.replace("USER", user)
+				i=i.replace("ROLE", role)
+				i=i.replace("system_u", sel_user)
+				ret=ret+i+"\n"
+		fd.close()
+		return ret
 
 	def genHomeDirContext(self):
-		if commands.getstatusoutput("grep -q 'ROLE' %s" % self.getHomeDirTemplate())[0] == 0 and self.semanaged:
+		if self.semanaged and findval(self.getHomeDirTemplate(), "ROLE", "=") != "":
 			warning("genhomedircon:  Warning!  No support yet for expanding ROLE macros in the %s file when using libsemanage." % self.getHomeDirTemplate());
 			warning("genhomedircon:  You must manually update file_contexts.homedirs for any non-user_r users (including root).");
 		users = self.getUsers()
@@ -225,40 +268,23 @@
 		return ret+"\n"
 
 	def checkExists(self, home):
-		if commands.getstatusoutput("grep -E '^%s[^[:alnum:]_-]' %s" % (home, self.getFileContextFile()))[0] == 0:
-			return 0
-		#this works by grepping the file_contexts for
-		# 1. ^/ makes sure this is not a comment
-		# 2. prints only the regex in the first column first cut on \t then on space
-		rc=commands.getstatusoutput("grep \"^/\" %s | cut -f 1 | cut -f 1 -d \" \" " %  self.getFileContextFile() )
-		if rc[0] == 0:
-			prefix_regex = rc[1].split("\n")
-		else:
-			warning("%s\nYou do not have access to read %s\n" % (rc[1], self.getFileContextFile()))
-
-		exists=1
-		for regex in prefix_regex:
-			#match a trailing (/*)? which is actually a bug in rpc_pipefs
-			regex = re.sub("\(/\*\)\?$", "", regex)
-			#match a trailing .+
-			regex = re.sub("\.+$", "", regex)
-			#match a trailing .*
-			regex = re.sub("\.\*$", "", regex)
-			#strip a (/.*)? which matches anything trailing to a /*$ which matches trailing /'s
-			regex = re.sub("\(\/\.\*\)\?", "", regex)
-			regex = regex + "/*$"
-			if re.search(regex, home, 0):
-				exists = 0
-				break
-		if exists == 1:
-			return 1
-		else:
-			return 0
-
+		fd=open(self.getFileContextFile())
+                for i in  fd.read().split('\n'):
+                    if len(i)==0:
+                        return
+                    regex=i.split()[0]
+                    #match a trailing .+
+                    regex = re.sub("\.+$", "", regex)
+                    regex = re.sub("\.\*$", "", regex)
+                    #strip a (/.*)? which matches anything trailing to a /*$ which matches trailing /'s
+                    regex = re.sub("\(\/\.\*\)\?", "", regex)
+                    regex = regex + "/*$"
+                    if re.search(home, regex, 0):
+                        return 1
+		return 0
 
 	def getHomeDirs(self):
-		homedirs = []
-		homedirs = homedirs + getDefaultHomeDir()
+		homedirs = getDefaultHomeDir()
 		starting_uid=getStartingUID()
 		if self.usepwd==0:
 			return homedirs
@@ -270,8 +296,8 @@
 					string.count(u[5], "/") > 1:
 				homedir = u[5][:string.rfind(u[5], "/")]
 				if not homedir in homedirs:
-					if self.checkExists(homedir)==0:
-						warning("%s homedir %s or its parent directoy conflicts with a\ndefined context in %s,\n%s will not create a new context." % (u[0], u[5], self.getFileContextFile(), sys.argv[0]))
+					if self.checkExists(homedir)==1:
+						warning("%s homedir %s or its parent directory conflicts with a\ndefined context in %s,\n%s will not create a new context." % (u[0], u[5], self.getFileContextFile(), sys.argv[0]))
 					else:
 						homedirs.append(homedir)
 
@@ -333,7 +359,3 @@
 
 except getopt.error, error:
 	errorExit("Options Error %s " % error)
-except ValueError, error:
-	errorExit("ValueError %s" % error)
-except IndexError, error:
-	errorExit("IndexError")
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/selisteners policycoreutils-1.29.2/scripts/selisteners
--- nsapolicycoreutils/scripts/selisteners	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.29.2/scripts/selisteners	2006-01-02 14:33:44.000000000 -0500
@@ -0,0 +1,37 @@
+#! /usr/bin/env python
+# Copyright (C) 2005 Red Hat
+# see file 'COPYING' for use and warranty information
+#
+# listeners - this script finds all processes listening on a TCP or UDP Port
+# configuration entries for user home directories based on their
+# default roles and is run when building the policy. Specifically, we
+# replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files with
+# generic and user-specific values.
+#
+# Based off original script by Dan Walsh, <dwalsh@redhat.com>
+#
+# ASSUMPTIONS:
+#
+# The file CONTEXTDIR/files/homedir_template exists.  This file is used to
+# set up the home directory context for each real user.
+# 
+# If a user has more than one role, genhomedircon uses the first role in the list.
+#
+# If a user is not listed in CONTEXTDIR/seusers, he will default to user_u, role user
+#
+# "Real" users (as opposed to system users) are those whose UID is greater than
+#  or equal STARTING_UID (usually 500) and whose login is not a member of
+#  EXCLUDE_LOGINS.  Users who are explicitly defined in CONTEXTDIR/seusers
+#  are always "real" (including root, in the default configuration).
+#
+#  
+import commands, string
+import selinux
+rc=commands.getstatusoutput("netstat -aptul")
+out=rc[1].split("\n")
+for i in out:
+    x=i.split()
+    y=x[-1].split("/")
+    if len(y)==2:
+        pid=string.atoi(y[0])
+        print "%s %-40s %-10s\t%-20s\t%s" % (x[0], x[3], pid,y[1],selinux.getpidcon(pid)[1])
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/tests/chcat_test policycoreutils-1.29.2/scripts/tests/chcat_test
--- nsapolicycoreutils/scripts/tests/chcat_test	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.29.2/scripts/tests/chcat_test	2006-01-02 14:33:44.000000000 -0500
@@ -0,0 +1,43 @@
+#!/bin/sh -x
+#
+#  You must copy the setrans.conf file in place before testing
+#
+chcat -l
+rm -f /tmp/chcat_test
+touch /tmp/chcat_test
+chcat -d /tmp/chcat_test
+chcat -d /tmp/chcat_test
+chcat -- -Payroll /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- +Payroll /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- -Payroll /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat Payroll,Marketing /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- +Payroll /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- Payroll /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- -Payroll,+Marketing /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- +Payroll,-Marketing /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- -Payroll,+Marketing,+NDA_Yoyodyne /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- -Marketing,-NDA_Yoyodyne /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- -s0 /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- s0 /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- s0:c1 /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- s0:c1,c2 /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- s0:c1.c3 /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- -s0:c3 /tmp/chcat_test
+ls -lZ /tmp/chcat_test
+chcat -- -s0:c2,+c3 /tmp/chcat_test
+ls -lZ /tmp/chcat_test
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/tests/setrans.conf policycoreutils-1.29.2/scripts/tests/setrans.conf
--- nsapolicycoreutils/scripts/tests/setrans.conf	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.29.2/scripts/tests/setrans.conf	2006-01-02 14:33:44.000000000 -0500
@@ -0,0 +1,23 @@
+#
+# Multi-Category Security translation table for SELinux
+# 
+# Uncomment the following to disable translation libary
+# disable=1
+#
+# Objects can be categorized with 0-256 categories defined by the admin.
+# Objects can be in more than one category at a time.
+# Categories are stored in the system as c0-c255.  Users can use this
+# table to translate the categories into a more meaningful output.
+# Examples:
+# s0:c0=CompanyConfidential
+# s0:c1=PatientRecord
+# s0:c2=Unclassified
+# s0:c3=TopSecret
+# s0:c1,c3=CompanyConfidentialRedHat
+s0=
+s0-s0:c0.c255=SystemLow-SystemHigh
+s0:c0.c255=SystemHigh
+s0:c0=Company_Confidential
+s0:c1=Marketing
+s0:c2=Payroll
+s0:c3=NDA_Yoyodyne
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-1.29.2/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2005-11-29 10:55:01.000000000 -0500
+++ policycoreutils-1.29.2/semanage/semanage	2006-01-02 14:33:44.000000000 -0500
@@ -24,22 +24,33 @@
 from semanage import *;
 class loginRecords:
 	def __init__(self):
-		self.sh=semanage_handle_create()
-		self.semanaged=semanage_is_managed(self.sh)
+		self.sh = semanage_handle_create()
+		self.semanaged = semanage_is_managed(self.sh)
 		if self.semanaged:
 			semanage_connect(self.sh)
 
 	def add(self, name, sename, serange):
-		(rc,k)=semanage_seuser_key_create(self.sh, name)
-		(rc,exists)= semanage_seuser_exists(self.sh, k)
+		if serange == "":
+			serange = "s0"
+		if sename == "":
+			sename = "user_u"
+			
+		(rc,k) = semanage_seuser_key_create(self.sh, name)
+		if rc != 0:
+			raise ValueError("Could not create a key for %s" % name)
+
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if exists:
 			raise ValueError("SELinux User %s mapping already defined" % name)
 		try:
-			pwd.getpwname(name)
+			pwd.getpwnam(name)
 		except:
 			raise ValueError("Linux User %s does not exist" % name)
 			
-		(rc,u)= semanage_seuser_create(self.sh)
+		(rc,u) = semanage_seuser_create(self.sh)
+		if rc != 0:
+			raise ValueError("Could not create seuser for %s" % name)
+
 		semanage_seuser_set_name(self.sh, u, name)
 		semanage_seuser_set_mlsrange(self.sh, u, serange)
 		semanage_seuser_set_sename(self.sh, u, sename)
@@ -48,13 +59,22 @@
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Failed to add SELinux user mapping")
 
-	def modify(self, name, sename="", serange=""):
-		(rc,k)=semanage_seuser_key_create(self.sh, name)
-		(rc,u)= semanage_seuser_query(self.sh, k)
-		if rc !=0 :
-			raise ValueError("SELinux user %s mapping is not defined." % name)
-		if sename == "" and serange=="":
+	def modify(self, name, sename = "", serange = ""):
+		(rc,k) = semanage_seuser_key_create(self.sh, name)
+		if rc != 0:
+			raise ValueError("Could not create a key for %s" % name)
+
+		if sename == "" and serange == "":
 			raise ValueError("Requires, seuser or serange")
+
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		if exists:
+			(rc,u) = semanage_seuser_query(self.sh, k)
+			if rc != 0:
+				raise ValueError("Could not query seuser for %s" % name)
+		else:
+			raise ValueError("SELinux user %s mapping is not defined." % name)
+
 		if serange != "":
 			semanage_seuser_set_mlsrange(self.sh, u, serange)
 		if sename != "":
@@ -66,78 +86,107 @@
 
 		
 	def delete(self, name):
-		(rc,k)=semanage_seuser_key_create(self.sh, name)
-		(rc,exists)= semanage_seuser_exists(self.sh, k)
-		if rc !=0 :
+		(rc,k) = semanage_seuser_key_create(self.sh, name)
+		if rc != 0:
+			raise ValueError("Could not create a key for %s" % name)
+
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		if not exists:
 			raise ValueError("SELinux user %s mapping is not defined." % name)
 		semanage_begin_transaction(self.sh)
 		semanage_seuser_del(self.sh, k)
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("SELinux User %s mapping not defined" % name)
 		
-	def list(self):
-		print "\n%-25s %-25s %-25s\n" % ("Login Name", "SELinux User", "MLS/MCS Range")
+	def list(self,heading=1):
+		if heading:
+			print "\n%-25s %-25s %-25s\n" % ("Login Name", "SELinux User", "MLS/MCS Range")
 		(status, self.ulist, self.usize) = semanage_seuser_list(self.sh)
 		for idx in range(self.usize):
-			u=semanage_seuser_by_idx(self.ulist, idx)
-			name=semanage_seuser_get_name(u)
-			
+			u = semanage_seuser_by_idx(self.ulist, idx)
+			name = semanage_seuser_get_name(u)
 			print "%-25s %-25s %-25s" % (name, semanage_seuser_get_sename(u), semanage_seuser_get_mlsrange(u))
 
 class seluserRecords:
 	def __init__(self):
-		roles=[]
-		self.sh=semanage_handle_create()
-		self.semanaged=semanage_is_managed(self.sh)
+		roles = []
+		self.sh = semanage_handle_create()
+		self.semanaged = semanage_is_managed(self.sh)
 		if self.semanaged:
 			semanage_connect(self.sh)
 
 	def add(self, name, roles, selevel, serange):
-		(rc,k)=semanage_user_key_create(self.sh, name)
-		(rc,exists)= semanage_user_exists(self.sh, k)
-		if exists:
-			raise ValueError("Seuser %s already defined" % name)
-		(rc,u)= semanage_user_create(self.sh)
+		if serange == "":
+			serange = "s0"
+		if selevel == "":
+			selevel = "s0"
+
+		(rc,k) = semanage_user_key_create(self.sh, name)
+		if rc != 0:
+			raise ValueError("Could not create a key for %s" % name)
+
+		(rc,exists) = semanage_user_exists_local(self.sh, k)
+		if not exists:
+			(rc,exists) = semanage_user_exists(self.sh, k)
+			if not exists:
+				raise ValueError("SELinux user %s is already defined." % name)
+
+		(rc,u) = semanage_user_create(self.sh)
+		if rc != 0:
+			raise ValueError("Could not create login mapping for %s" % name)
+
 		semanage_user_set_name(self.sh, u, name)
 		for r in roles:
 			semanage_user_add_role(self.sh, u, r)
 		semanage_user_set_mlsrange(self.sh, u, serange)
 		semanage_user_set_mlslevel(self.sh, u, selevel)
 		(rc,key) = semanage_user_key_extract(self.sh,u)
+		if rc != 0:
+			raise ValueError("Could not extract key for %s" % name)
+
 		semanage_begin_transaction(self.sh)
 		semanage_user_add_local(self.sh, k, u)
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Failed to add SELinux user")
 
-		self.dict[name]=seluser(name, roles, selevel, serange)
-		
-	def modify(self, name, roles=[], selevel="", serange=""):
-		(rc,k)=semanage_user_key_create(self.sh, name)
-		(rc,exists)= semanage_user_exists(self.sh, k)
-		if not exists:
-			raise ValueError("user %s is not defined" % name)
-		(rc,u)= semanage_user_query(self.sh, k)
-		if rc !=0 :
-			raise ValueError("User %s is not defined." % name)
-		if len(roles) == 0  and serange=="" and selevel=="":
+	def modify(self, name, roles = [], selevel = "", serange = ""):
+		if len(roles) == 0  and serange == "" and selevel == "":
 			raise ValueError("Requires, roles, level  or range")
+
+		(rc,k) = semanage_user_key_create(self.sh, name)
+		if rc != 0:
+			raise ValueError("Could not create a key for %s" % name)
+
+		(rc,exists) = semanage_user_exists_local(self.sh, k)
+		if exists:
+			(rc,u) = semanage_user_query_local(self.sh, k)
+		else:
+			(rc,exists) = semanage_user_exists(self.sh, k)
+			if exists:
+				(rc,u) = semanage_user_query(self.sh, k)
+			else:
+				raise ValueError("SELinux user %s mapping is not defined." % name)
+		if rc != 0:
+			raise ValueError("Could not query user for %s" % name)
+
 		if serange != "":
 			semanage_user_set_mlsrange(self.sh, u, serange)
 		if selevel != "":
 			semanage_user_set_mlslevel(self.sh, u, selevel)
 		if len(roles) != 0:
 			for r in roles:
-				print r
 				semanage_user_add_role(self.sh, u, r)
 		semanage_begin_transaction(self.sh)
 		semanage_user_modify_local(self.sh, k, u)
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Failed to modify SELinux user")
-
 		
 	def delete(self, name):
-		(rc,k)=semanage_user_key_create(self.sh, name)
-		(rc,exists)= semanage_user_exists(self.sh, k)
+		(rc,k) = semanage_user_key_create(self.sh, name)
+		if rc != 0:
+			raise ValueError("Could not crpppeate a key for %s" % name)
+
+		(rc,exists) = semanage_user_exists_local(self.sh, k)
 		if not exists:
 			raise ValueError("user %s is not defined" % name)
 		semanage_begin_transaction(self.sh)
@@ -145,86 +194,183 @@
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Login User %s not defined" % name)
 		
-	def list(self):
-		print "\n%-15s %-10s %-20s" % ("", "MLS/", "MLS/")
-		print "%-15s %-10s %-15s %-20s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
+	def list(self, heading=1):
+		if heading:
+			print "\n%-15s %-10s %-20s" % ("", "MLS/", "MLS/")
+			print "%-15s %-10s %-15s %-20s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
 		(status, self.ulist, self.usize) = semanage_user_list(self.sh)
 		for idx in range(self.usize):
-			u=semanage_user_by_idx(self.ulist, idx)
-			name=semanage_user_get_name(u)
+			u = semanage_user_by_idx(self.ulist, idx)
+			name = semanage_user_get_name(u)
 			(status, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
-			roles=""
+			roles = ""
 
 			if rlist_size:
-				roles+=char_by_idx(rlist, 0)
+				roles += char_by_idx(rlist, 0)
 				for ridx in range (1,rlist_size):
-					roles+=" " + char_by_idx(rlist, ridx)
+					roles += " " + char_by_idx(rlist, ridx)
 			print "%-15s %-10s %-15s %s" % (semanage_user_get_name(u), semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
 
 class portRecords:
 	def __init__(self):
-		self.dict={}
-		self.sh=semanage_handle_create()
-		self.semanaged=semanage_is_managed(self.sh)
+		self.sh = semanage_handle_create()
+		self.semanaged = semanage_is_managed(self.sh)
 		if self.semanaged:
 			semanage_connect(self.sh)
 
-	def add(self, name, type):
-		(rc,k)=semanage_port_key_create(self.sh, name)
-		(rc,exists)= semanage_port_exists(self.sh, k)
+	def __genkey(self, port, proto):
+		if proto == "tcp":
+			proto_d=SEMANAGE_PROTO_TCP
+		else:
+			if proto == "udp":
+				proto_d=SEMANAGE_PROTO_UDP
+			else:
+				raise ValueError("Protocol udp or tcp is required")
+		if port == "":
+			raise ValueError("Port is required")
+			
+		ports=port.split("-")
+		if len(ports) == 1:
+			low=string.atoi(ports[0])
+			high=string.atoi(ports[0])
+		else:
+			low=string.atoi(ports[0])
+			high=string.atoi(ports[1])
+			
+		(rc,k) = semanage_port_key_create(self.sh, low, high, proto_d)
+		if rc != 0:
+			raise ValueError("Could not create a key for %s/%s" % (proto, port))
+		return ( k, proto_d, low, high )
+
+	def add(self, port, proto, serange, type):
+		if serange == "":
+			serange="s0"
+			
+		if type == "":
+			raise ValueError("Type is required")
+
+		( k, proto_d, low, high ) = self.__genkey(port, proto)			
+
+		(rc,exists) = semanage_port_exists(self.sh, k)
+		if exists:
+			raise ValueError("Port %s/%s already defined" % (proto, port))
+
+		(rc,exists) = semanage_port_exists_local(self.sh, k)
 		if exists:
-			raise ValueError("User %s already defined" % name)
-		(rc,u)= semanage_port_create(self.sh)
-		semanage_port_set_name(self.sh, u, name)
-		semanage_port_set_mlsrange(self.sh, u, serange)
-		semanage_port_set_sename(self.sh, u, sename)
+			raise ValueError("Port %s/%s already defined locally" % (proto, port))
+
+		(rc,p) = semanage_port_create(self.sh)
+		if rc != 0:
+			raise ValueError("Could not create port for %s/%s" % (proto, port))
+		
+		semanage_port_set_proto(p, proto_d)
+		semanage_port_set_range(p, low, high)
+		(rc, con) = semanage_context_create(self.sh)
+		if rc != 0:
+			raise ValueError("Could not create context for %s/%s" % (proto, port))
+
+		semanage_context_set_user(self.sh, con, "system_u")
+		semanage_context_set_role(self.sh, con, "object_r")
+		semanage_context_set_type(self.sh, con, type)
+		semanage_context_set_mls(self.sh, con, serange)
+		semanage_port_set_con(p, con)
 		semanage_begin_transaction(self.sh)
-		semanage_port_add(self.sh, k, u)
+		semanage_port_add_local(self.sh, k, p)
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Failed to add port")
 
-	def modify(self, name, type):
-		(rc,k)=semanage_port_key_create(self.sh, name)
-		(rc,u)= semanage_port_query(self.sh, k)
-		if rc !=0 :
-			raise ValueError("User %s is not defined." % name)
-		if sename == "" and serange=="":
-			raise ValueError("Requires, port or serange")
+	def modify(self, port, proto, serange, setype):
+		if serange == "" and setype == "":
+			raise ValueError("Requires, setype or serange")
+
+		( k, proto_d, low, high ) = self.__genkey(port, proto)
+
+		(rc,exists) = semanage_port_exists_local(self.sh, k)
+		if exists:
+			(rc,p) = semanage_port_query_local(self.sh, k)
+			(rc,exists) = semanage_port_exists(self.sh, k)
+			if exists:
+				(rc,p) = semanage_port_query(self.sh, k)
+			else:
+				raise ValueError("port %s/%s is not defined." % (proto,port))
+
+		if rc != 0:
+			raise ValueError("Could not query port for %s/%s" % (proto, port))
+
+		con = semanage_port_get_con(p)
+		semanage_context_set_mls(self.sh, con, serange)	
 		if serange != "":
-			semanage_port_set_mlsrange(self.sh, u, serange)
-		if sename != "":
-			semanage_port_set_sename(self.sh, u, sename)
+			semanage_context_set_mls(self.sh, con, serange)	
+		if setype != "":
+			semanage_context_set_type(self.sh, con, setype)
+		semanage_port_set_con(p, con)
 		semanage_begin_transaction(self.sh)
-		semanage_port_modify(self.sh, k, u)
+		semanage_port_modify_local(self.sh, k, p)
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Failed to add port")
 		
-	def delete(self, name):
-		(rc,k)=semanage_port_key_create(self.sh, name)
+	def delete(self, port, proto):
+		( k, proto_d, low, high ) = self.__genkey(port, proto)
+		(rc,exists) = semanage_port_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("port %s/%s is not defined localy." % (proto,port))
+
 		semanage_begin_transaction(self.sh)
-		semanage_port_del(self.sh, k)
+		semanage_port_del_local(self.sh, k)
 		if semanage_commit(self.sh) != 0:
-			raise ValueError("Port %s not defined" % name)
+			raise ValueError("Port %s/%s not defined" % (proto,port))
 		
-	def list(self):
+	def list(self, heading=1):
 		(status, self.plist, self.psize) = semanage_port_list(self.sh)
-		print "%-25s %s\n" % ("SELinux Port Name", "Port Number")
+		if heading:
+			print "%-30s %-8s %s\n" % ("SELinux Port Name", "Proto", "Port Number")
+		dict={}
+		for idx in range(self.psize):
+			u = semanage_port_by_idx(self.plist, idx)
+			con = semanage_port_get_con(u)
+			name = semanage_context_get_type(con)
+			proto=semanage_port_get_proto_str(u)
+			low=semanage_port_get_low(u)
+			high = semanage_port_get_high(u)
+			if (name, proto) not in dict.keys():
+				dict[(name,proto)]=[]
+			if low == high:
+				dict[(name,proto)].append("%d" % low)
+			else:
+				dict[(name,proto)].append("%d-%d" % (low, high))
+		(status, self.plist, self.psize) = semanage_port_list_local(self.sh)
 		for idx in range(self.psize):
-			u=semanage_port_by_idx(self.plist, idx)
-			name=semanage_port_get_name(u)
-			print "%20s %d" % ( name, semanage_port_get_number(u))
+			u = semanage_port_by_idx(self.plist, idx)
+			con = semanage_port_get_con(u)
+			name = semanage_context_get_type(con)
+			proto=semanage_port_get_proto_str(u)
+			low=semanage_port_get_low(u)
+			high = semanage_port_get_high(u)
+			if (name, proto) not in dict.keys():
+				dict[(name,proto)]=[]
+			if low == high:
+				dict[(name,proto)].append("%d" % low)
+			else:
+				dict[(name,proto)].append("%d-%d" % (low, high))
+		for i in dict.keys():
+			rec = "%-30s %-8s " % i
+			rec += "%s" % dict[i][0]
+			for p in dict[i][1:]:
+				rec += ", %s" % p
+			print rec
 			
 if __name__ == '__main__':
 
-	def usage(message=""):
+	def usage(message = ""):
 		print '\
 semanage user [-admsRrh] SELINUX_USER\n\
 semanage login [-admsrh] LOGIN_NAME\n\
-semanage port [-admth] SELINUX_PORT_NAME\n\
+semanage port [-admth] PORT | PORTRANGE\n\
 	-a, --add        Add a OBJECT record NAME\n\
 	-d, --delete     Delete a OBJECT record NAME\n\
 	-h, --help       display this message\n\
 	-l, --list       List the OBJECTS\n\
+	-n, --noheading  Do not print heading when listing OBJECTS\n\
 	-m, --modify     Modify a OBJECT record NAME\n\
 	-r, --range      MLS/MCS Security Range\n\
 	-R, --roles      SELinux Roles (Separate by spaces)\n\
@@ -245,33 +391,40 @@
 	# 
 	#
 	try:
-		objectlist=("login", "user", "port")
-		input=sys.stdin
-		output=sys.stdout
-		serange="s0"
-		selevel="s0"
-		roles=""
-		seuser=""
-		type=""
-		add=0
-		modify=0
-		delete=0
-		list=0
+		objectlist = ("login", "user", "port")
+		input = sys.stdin
+		output = sys.stdout
+		serange = ""
+		port = ""
+		proto = ""
+		selevel = ""
+		setype = ""
+		roles = ""
+		seuser = ""
+		heading=1
+
+		add = 0
+		modify = 0
+		delete = 0
+		list = 0
 		if len(sys.argv) < 3:
 			usage("Requires 2 or more arguments")
 			
-		object=sys.argv[1]
+		object = sys.argv[1]
 		if object not in objectlist:
 			usage("%s not defined" % object)
 			
-		args=sys.argv[2:]
+		args = sys.argv[2:]
 		gopts, cmds = getopt.getopt(args,
-					    'adlhms:R:r:t:v',
+					    'adlhmnp:P:s:R:r:t:v',
 					    ['add',
 					     'delete',
 					     'help',
 					     'list', 
 					     'modify',
+					     'noheading',
+					     'port=',
+					     'proto=',
 					     'seuser=',
 					     'range=',
 					     'roles=',
@@ -282,88 +435,95 @@
 			if o == "-a" or o == "--add":
 				if modify or delete:
 					usage()
-				add=1
+				add = 1
 				
 			if o == "-d"  or o == "--delese":
 				if modify or add:
 					usage()
-				delete=1
+				delete = 1
 			if o == "-h" or o == "--help":
 				usage()
 
+			if o == "-n" or o == "--nohead":
+				heading=0
+
 			if o == "-m"or o == "--modify":
 				if delete or add:
 					usage()
-				modify=1
+				modify = 1
 				
 			if o == "-r" or o == '--range':
-				serange=a
+				serange = a
+
+			if o == "-P" or o == '--proto':
+				proto = a
 
 			if o == "-R" or o == '--roles':
-				roles=a
+				roles = a
 
 			if o == "-t" or o == "--type":
-				type=a
+				setype = a
 
 			if o == "-l" or o == "--list":
-				list=1
+				list = 1
 
 			if o == "-s" or o == "--seuser":
-				seuser=a
+				seuser = a
 
 			if o == "-v" or o == "--verbose":
-				verbose=1
+				verbose = 1
 
 		if object == "login":
-			OBJECT=loginRecords()
+			OBJECT = loginRecords()
 
 		if object == "user":
-			OBJECT=seluserRecords()
+			OBJECT = seluserRecords()
 
 		if object == "port":
-			OBJECT=portRecords()
+			OBJECT = portRecords()
 		
 		if list:
-			OBJECT.list()
+			OBJECT.list(heading)
 			sys.exit(0);
 			
 		if len(cmds) != 1:
 			usage()
 
-		name=cmds[0]
+		target = cmds[0]
 
 		if add:
 			if object == "login":
-				OBJECT.add(name, seuser, serange)
+				OBJECT.add(target, seuser, serange)
 
 			if object == "user":
-				rlist=roles.split()
-				print rlist
-				OBJECT.add(name, rlist, selevel, serange)
+				rlist = roles.split()
+				if len(rlist) == 0:
+					raise ValueError("You must specify a role")
+				OBJECT.add(target, rlist, selevel, serange)
 
 			if object == "port":
-				OBJECT.add(name, type)
+				OBJECT.add(target, proto, serange, setype)
 
-			OBJECT.list()
 			sys.exit(0);
 			
 		if modify:
 			if object == "login":
-				OBJECT.modify(name, seuser, serange)
+				OBJECT.modify(target, seuser, serange)
 
 			if object == "user":
-				rlist=roles.split()
-				print rlist
-				OBJECT.modify(name, rlist, selevel, serange)
+				rlist = roles.split()
+				OBJECT.modify(target, rlist, selevel, serange)
 
 			if object == "port":
-				OBJECT.modify(name, type)
+				OBJECT.modify(target, proto, serange, setype)
 				sys.exit(0);
-			OBJECT.list()
 			sys.exit(0);
 
 		if delete:
-			OBJECT.delete(name)
+			if object == "port":
+				OBJECT.delete(target, proto)
+			else:
+				OBJECT.delete(target)
 			sys.exit(0);
 		usage()
 			
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/tests/semanage_test policycoreutils-1.29.2/semanage/tests/semanage_test
--- nsapolicycoreutils/semanage/tests/semanage_test	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.29.2/semanage/tests/semanage_test	2006-01-02 14:33:44.000000000 -0500
@@ -0,0 +1,67 @@
+#!/bin/sh -x
+#
+#  This is a test script for the semanage command
+#
+echo "
+
+******************** semanage List Failue test ************************
+"
+semanage -l
+echo "
+
+******************** semanage Mapping test ************************
+"
+echo " * Mapping List test"
+semanage login -l 
+echo " * Add mapping exist test"
+semanage login -a root 
+echo " * Add new test"
+echo " * Add selinux login to selinux user mapping, username wrong"
+semanage login -a semanage_test1
+userdel -r semanage_test1 2> /dev/null
+useradd semanage_test1
+echo " * Add selinux login to selinux user mapping, Bad SELinux User"
+semanage login -a -s BadUser semanage_test1
+echo " * Add selinux login to selinux user mapping, username correct"
+semanage login -a semanage_test1
+semanage login -l 
+userdel -r semanage_test1
+echo " * remove selinux login to selinux user mapping, username wrong"
+semanage login -d semanage_test2
+echo " * remove selinux login to selinux user mapping, username correct"
+semanage login -d semanage_test1
+semanage login -l 
+
+echo "
+
+******************** semanage SELinux User test ************************
+"
+echo " * SELinux User List test"
+semanage user -l 
+echo " * Add SELinux User exist test: Fail because root exist"
+semanage user -a -R user_r root 
+echo " * Add SELinux User exist test: Fail because no role specified"
+semanage user -a -r s0 semanage_test1
+echo " * Add selinux user semanage_test1: Success"
+semanage user -a -R user_r -r s0 semanage_test1
+semanage user -l 
+echo " * Modify selinux user semanage_test1 Failue bad range"
+semanage user -m -r BadRange semanage_test1
+echo " * Modify selinux user semanage_test1 Failue bad role"
+semanage user -m -R BadRole semanage_test1
+echo " * Modify selinux user semanage_test1"
+semanage user -m -r s0:c1,c5 semanage_test1
+semanage user -l 
+echo " * Delete selinux user semanage_test2: Fail does not exist"
+semanage user -d semanage_test2
+echo " * Delete selinux user semanage_test1"
+semanage user -d semanage_test1
+semanage user -l 
+
+#echo "
+#
+#******************** semanage SELinux ports test ************************
+#"
+semanage port -l 
+semanage port -a -P tcp 123456
+semanage port -d -P tcp 123456

--------------000100040205090004060302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
