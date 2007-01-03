Message-ID: <459BF062.4050107@redhat.com>
Date: Wed, 03 Jan 2007 13:05:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Policycoreutils patches
Content-Type: multipart/mixed;
 boundary="------------020301000904050900070001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020301000904050900070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bunch of patches separated so you can approve/deny them separately.

avc patch Removes optional_policy name from audit2allow

pyver patch removes hardcoding of python version from makefile.  Will 
use version of installed python version.

newrole patch to use O_RDWR for terminals to fix more problem.

fixfiles patch fixes a problem with fixfiles was writing "not a tty" to 
the current directory when there was no terminal.

seobject patch is somewhat more controversial, but at least parts of it 
should be accepted.

- Fixes translation of portions of security context.
- Get rid of excess "\n"
- Restart mcstrans to relize file changed.
- Verify prefix is valid
- Modify roles correctly, currently role removal does not work without 
this fix.

--------------020301000904050900070001
Content-Type: text/x-patch;
 name="policycoreutils-avc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-avc.patch"

--- nsapolicycoreutils/audit2allow/avc.py	2006-11-16 17:14:29.000000000 -0500
+++ policycoreutils-1.33.6/audit2allow/avc.py	2006-12-20 14:59:04.000000000 -0500
@@ -231,7 +231,7 @@
 		else:
 			file = m[0][1]
 			ret = "\n#%s\n"% self.out()
-			ret += "optional_policy(`%s', `\n" % m[0][1]
+			ret += "optional_policy(`\n" 
 			first = True
 			for i in m:
 				if file != i[1]:

--------------020301000904050900070001
Content-Type: text/x-patch;
 name="policycoreutils-pyver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-pyver.patch"

diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/audit2allow/Makefile policycoreutils-1.33.6/audit2allow/Makefile
--- nsapolicycoreutils/audit2allow/Makefile	2006-11-16 17:14:29.000000000 -0500
+++ policycoreutils-1.33.6/audit2allow/Makefile	2006-12-20 14:59:04.000000000 -0500
@@ -4,7 +4,7 @@
 LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
-PYLIBVER ?= python2.4
+PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
 PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
 
 TARGETS=audit2allow
diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/Makefile policycoreutils-1.33.6/semanage/Makefile
--- nsapolicycoreutils/semanage/Makefile	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-1.33.6/semanage/Makefile	2006-12-20 14:59:04.000000000 -0500
@@ -3,7 +3,7 @@
 LIBDIR ?= $(PREFIX)/lib
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-PYLIBVER ?= python2.4
+PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
 PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
 
 TARGETS=semanage

--------------020301000904050900070001
Content-Type: text/x-patch;
 name="policycoreutils-newrole.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-newrole.patch"

--- nsapolicycoreutils/newrole/newrole.c	2006-11-29 17:11:18.000000000 -0500
+++ policycoreutils-1.33.6/newrole/newrole.c	2006-12-20 14:59:04.000000000 -0500
@@ -1120,10 +1120,10 @@
 	fd = open(ttyn, O_RDONLY);
 	if (fd != 0)
 		goto err_close_pam;
-	fd = open(ttyn, O_WRONLY);
+	fd = open(ttyn, O_RDWR);
 	if (fd != 1)
 		goto err_close_pam;
-	fd = open(ttyn, O_WRONLY);
+	fd = open(ttyn, O_RDWR);
 	if (fd != 2)
 		goto err_close_pam;
 

--------------020301000904050900070001
Content-Type: text/x-patch;
 name="policycoreutils-fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.33.6/scripts/fixfiles	2007-01-02 10:51:58.000000000 -0500
@@ -29,6 +29,9 @@
 RPMILES=""
 OUTFILES=""
 LOGFILE=`tty`
+if [ $1 != 0 ]; then
+    LOGFILE="/dev/null"
+fi
 SYSLOGFLAG="-l"
 LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles

--------------020301000904050900070001
Content-Type: text/x-patch;
 name="policycoreutils-seobject.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-seobject.patch"

--- nsapolicycoreutils/semanage/seobject.py	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-1.33.6/semanage/seobject.py	2006-12-20 14:59:04.000000000 -0500
@@ -94,23 +94,25 @@
 	return re.search("^" + reg +"$",raw)
 
 def translate(raw, prepend = 1):
-	if prepend == 1:
-		context = "a:b:c:%s" % raw
+        filler="a:b:c:"
+        if prepend == 1:
+		context = "%s%s" % (filler,raw)
 	else:
 		context = raw
-	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
+ 	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
 	if rc != 0:
 		return raw
 	if prepend:
-		trans = trans.strip("a:b:c")
+		trans = trans[len(filler):]
 	if trans == "":
 		return raw
 	else:
 		return trans
 	
 def untranslate(trans, prepend = 1):
+        filler="a:b:c:"
  	if prepend == 1:
-		context = "a:b:c:%s" % trans
+		context = "%s%s" % (filler,trans)
 	else:
 		context = trans
 
@@ -118,7 +120,7 @@
 	if rc != 0:
 		return trans
 	if prepend:
-		raw = raw.strip("a:b:c")	
+		raw = raw[len(filler):]
 	if raw == "":
 		return trans
 	else:
@@ -157,7 +159,7 @@
 	def out(self):
 		rec = ""
 		for c in self.comments:
-			rec += c +"\n"
+			rec += c
 		keys = self.ddict.keys()
 		keys.sort()
 		for k in keys:
@@ -204,7 +206,8 @@
 		os.write(fd, self.out())
 		os.close(fd)
 		os.rename(newfilename, self.filename)
-
+                os.system("/sbin/service mcstrans reload > /dev/null")
+                
 class semanageRecords:
 	def __init__(self):
 		self.sh = semanage_handle_create()
@@ -456,7 +460,8 @@
 				rc = semanage_user_set_mlslevel(self.sh, u, selevel)
 				if rc < 0:
 					raise ValueError(_("Could not set MLS level for %s") % name)
-
+                        if selinux.security_check_context("system_u:object_r:%s_home_t:s0" % prefix) != 0:
+                               raise ValueError(_("Invalid prefix %s") % prefix)
 			rc = semanage_user_set_prefix(self.sh, u, prefix)
 			if rc < 0:
 				raise ValueError(_("Could not add prefix %s for %s") % (r, prefix))
@@ -522,11 +527,17 @@
 				semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
 
 			if prefix != "":
-				semanage_user_set_prefix(self.sh, u, prefix)
+                               if selinux.security_check_context("system_u:object_r:%s_home_t" % prefix) != 0:
+                                      raise ValueError(_("Invalid prefix %s") % prefix)
+                               semanage_user_set_prefix(self.sh, u, prefix)
 
 			if len(roles) != 0:
-				for r in roles:
-					semanage_user_add_role(self.sh, u, r)
+                               for r in rlist:
+                                      if r not in roles:
+                                             semanage_user_del_role(u, r)
+                               for r in roles:
+                                      if r not in rlist:
+                                             semanage_user_add_role(self.sh, u, r)
 
 			rc = semanage_begin_transaction(self.sh)
 			if rc < 0:

--------------020301000904050900070001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
