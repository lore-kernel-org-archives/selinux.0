Message-ID: <46B22681.2030107@redhat.com>
Date: Thu, 02 Aug 2007 14:46:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patches
Content-Type: multipart/mixed;
 boundary="------------070903040906030002010204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070903040906030002010204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

nsapolicycoreutils_audit2allow_Makefile - Move sepolgen-iggen to sbindir. 
nsapolicycoreutils_run_init_Makefile Change permissions to 755 instead 
of 555, Some audit scripts are reporting problems with 755 permissions.


nsapolicycoreutils_scripts_chcat - Missing : after else commands
nsapolicycoreutils_scripts_fixfiles - Certain patterns were not 
expanding.  So relabel was not complete also fix error handling

nsapolicycoreutils_scripts_genhomedircon - Speed up processing by a 
factor of 10 by precompiling regex
nsapolicycoreutils_semanage_semanage - Fix handling of internationalization
nsapolicycoreutils_semanage_seobject.py - Allow users to specify <<none>>


--------------070903040906030002010204
Content-Type: text/plain;
 name="nsapolicycoreutils_audit2allow_Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_audit2allow_Makefile"

--- nsapolicycoreutils/audit2allow/Makefile	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/audit2allow/Makefile	2007-07-31 15:45:57.000000000 -0400
@@ -1,6 +1,7 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
 BINDIR ?= $(PREFIX)/bin
+SBINDIR ?= $(PREFIX)/sbin
 LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
@@ -10,7 +11,7 @@
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 audit2allow $(BINDIR)
-	install -m 755 sepolgen-ifgen $(BINDIR)
+	install -m 755 sepolgen-ifgen $(SBINDIR)
 	-mkdir -p $(MANDIR)/man1
 	install -m 644 audit2allow.1 $(MANDIR)/man1/
 

--------------070903040906030002010204
Content-Type: text/plain;
 name="nsapolicycoreutils_run_init_Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_run_init_Makefile"

--- nsapolicycoreutils/run_init/Makefile	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/run_init/Makefile	2007-07-31 15:45:57.000000000 -0400
@@ -34,8 +34,8 @@
 install: all
 	test -d $(SBINDIR)      || install -m 755 -d $(SBINDIR)
 	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
-	install -m 555 run_init $(SBINDIR)
-	install -m 555 open_init_pty $(SBINDIR)
+	install -m 755 run_init $(SBINDIR)
+	install -m 755 open_init_pty $(SBINDIR)
 	install -m 644 run_init.8 $(MANDIR)/man8/
 	install -m 644 open_init_pty.8 $(MANDIR)/man8/
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)

--------------070903040906030002010204
Content-Type: text/plain;
 name="nsapolicycoreutils_scripts_chcat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_scripts_chcat"

--- nsapolicycoreutils/scripts/chcat	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/scripts/chcat	2007-07-31 15:45:57.000000000 -0400
@@ -77,7 +77,7 @@
             
         if len(cats) > 0:
             new_serange = "%s-%s:%s" % (serange[0], top[0], ",".join(cats))
-        else
+        else:
             new_serange = "%s-%s" % (serange[0], top[0])
             
         if add_ind:
@@ -155,7 +155,7 @@
 
         if len(cats) > 0:
             new_serange = "%s-%s:%s" % (serange[0], top[0], ",".join(cats))
-        else
+        else:
             new_serange = "%s-%s" % (serange[0], top[0])
             
         if add_ind:

--------------070903040906030002010204
Content-Type: text/plain;
 name="nsapolicycoreutils_scripts_fixfiles"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_scripts_fixfiles"

--- nsapolicycoreutils/scripts/fixfiles	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/scripts/fixfiles	2007-07-31 15:45:57.000000000 -0400
@@ -88,7 +88,7 @@
                   esac; \
                fi; \
             done | \
-	while read pattern ; do find $pattern \
+	while read pattern ; do sh -c "find $pattern" \
 		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o \
 		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print; \
 		      done 2> /dev/null | \
@@ -108,6 +108,7 @@
 
 rpmlist() {
 rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
+[ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
 }
 
 # 

--------------070903040906030002010204
Content-Type: text/plain;
 name="nsapolicycoreutils_scripts_genhomedircon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_scripts_genhomedircon"

--- nsapolicycoreutils/scripts/genhomedircon	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/scripts/genhomedircon	2007-08-01 16:03:41.000000000 -0400
@@ -139,7 +139,22 @@
 		self.default_user = "user_u"
 		self.default_prefix = "user"
 		self.users = self.getUsers()
+		fd = open(self.getFileContextFile())
+		self.fclines=[]
+		for i in fd.readlines():
+		    try:
+			    regex = i.split()[0]
+			    #match a trailing .+
+			    regex = re.sub("\.+$", "", regex)
+			    regex = re.sub("\.\*$", "", regex)
+			    regex = re.sub("\(\/\.\*\)\?", "", regex)
+			    regex = regex + "/*$"
+			    self.fclines.append(re.compile(regex))
+		    except:
+			    continue
 
+		fd.close()
+		
 	def getFileContextDir(self):
 		return self.selinuxdir+self.type+self.filecontextdir
 
@@ -289,20 +304,9 @@
 		return ret+"\n"
 
 	def checkExists(self, home):
-		fd = open(self.getFileContextFile())
-		for i in  fd.readlines():
-                    if len(i) == 0:
-			    continue
+		for i in self.fclines:
 		    try:
-			    regex = i.split()[0]
-			    #match a trailing .+
-			    regex = re.sub("\.+$", "", regex)
-			    regex = re.sub("\.\*$", "", regex)
-			    #strip a (/.*)? which matches anything trailing to a /*$ which matches trailing /'s
-			    
-			    regex = re.sub("\(\/\.\*\)\?", "", regex)
-			    regex = regex + "/*$"
-			    if re.search(regex,home, 0):
+			    if i.match(home):
 				    return 1
 		    except:
 			    continue

--------------070903040906030002010204
Content-Type: text/plain;
 name="nsapolicycoreutils_semanage_semanage"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_semanage_semanage"

--- nsapolicycoreutils/semanage/semanage	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/semanage/semanage	2007-07-31 15:45:57.000000000 -0400
@@ -34,7 +34,10 @@
 sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__, 'replace')
 
 try:
-       gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
+       gettext.install(PROGNAME,
+                       localedir="/usr/share/locale",
+                       unicode=False,
+                       codeset = 'utf-8')
 except IOError:
        import __builtin__
        __builtin__.__dict__['_'] = unicode

--------------070903040906030002010204
Content-Type: text/x-python;
 name="nsapolicycoreutils_semanage_seobject.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsapolicycoreutils_semanage_seobject.py"

--- nsapolicycoreutils/semanage/seobject.py	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/semanage/seobject.py	2007-08-01 09:54:14.000000000 -0400
@@ -1024,14 +1025,31 @@
 	def __init__(self):
 		semanageRecords.__init__(self)
 		
-	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
+        def createcon(self, target, seuser = "system_u"):
+                (rc, con) = semanage_context_create(self.sh)
+                if rc < 0:
+                       raise ValueError(_("Could not create context for %s") % target)
 		if seuser == "":
 			seuser = "system_u"
+
+                rc = semanage_context_set_user(self.sh, con, seuser)
+                if rc < 0:
+                       raise ValueError(_("Could not set user in file context for %s") % target)
+		
+                rc = semanage_context_set_role(self.sh, con, "object_r")
+                if rc < 0:
+                       raise ValueError(_("Could not set role in file context for %s") % target)
+
 		if is_mls_enabled == 1:
-			if serange == "":
-				serange = "s0"
-			else:
-				serange = untranslate(serange)
+                       rc = semanage_context_set_mls(self.sh, con, "s0")
+                       if rc < 0:
+                              raise ValueError(_("Could not set mls fields in file context for %s") % target)
+
+                return con
+               
+	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
+		if is_mls_enabled == 1:
+                       serange = untranslate(serange)
 			
 		if type == "":
 			raise ValueError(_("SELinux Type is required"))
@@ -1051,33 +1069,23 @@
 			raise ValueError(_("Could not create file context for %s") % target)
 		
 		rc = semanage_fcontext_set_expr(self.sh, fcontext, target)
-		(rc, con) = semanage_context_create(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not create context for %s") % target)
-
-		rc = semanage_context_set_user(self.sh, con, seuser)
-		if rc < 0:
-			raise ValueError(_("Could not set user in file context for %s") % target)
-		
-		rc = semanage_context_set_role(self.sh, con, "object_r")
-		if rc < 0:
-			raise ValueError(_("Could not set role in file context for %s") % target)
-
-		rc = semanage_context_set_type(self.sh, con, type)
-		if rc < 0:
-			raise ValueError(_("Could not set type in file context for %s") % target)
+                if type != "<<none>>":
+                       con = self.createcon(target, seuser)
 
-		if serange != "":
-			rc = semanage_context_set_mls(self.sh, con, serange)
-			if rc < 0:
-				raise ValueError(_("Could not set mls fields in file context for %s") % target)
+                       rc = semanage_context_set_type(self.sh, con, type)
+                       if rc < 0:
+                              raise ValueError(_("Could not set type in file context for %s") % target)
+
+                       if serange != "":
+                              rc = semanage_context_set_mls(self.sh, con, serange)
+                              if rc < 0:
+                                     raise ValueError(_("Could not set mls fields in file context for %s") % target)
+                       rc = semanage_fcontext_set_con(self.sh, fcontext, con)
+                       if rc < 0:
+                              raise ValueError(_("Could not set file context for %s") % target)
 
 		semanage_fcontext_set_type(fcontext, file_types[ftype])
 
-		rc = semanage_fcontext_set_con(self.sh, fcontext, con)
-		if rc < 0:
-			raise ValueError(_("Could not set file context for %s") % target)
-
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not start semanage transaction"))
@@ -1090,7 +1098,8 @@
 		if rc < 0:
 			raise ValueError(_("Could not add file context for %s") % target)
 
-		semanage_context_free(con)
+                if type != "<<none>>":
+                       semanage_context_free(con)
 		semanage_fcontext_key_free(k)
 		semanage_fcontext_free(fcontext)
 
@@ -1112,16 +1121,29 @@
 		if rc < 0:
 			raise ValueError(_("Could not query file context for %s") % target)
 
-		con = semanage_fcontext_get_con(fcontext)
+                if setype != "<<none>>":
+                       con = semanage_fcontext_get_con(fcontext)
 			
-		if serange != "":
-			semanage_context_set_mls(self.sh, con, untranslate(serange))
-		if seuser != "":
-			semanage_context_set_user(self.sh, con, seuser)	
-		if setype != "":
-			semanage_context_set_type(self.sh, con, setype)
-
-		rc = semanage_begin_transaction(self.sh)
+                       if con == None:
+                              con = self.createcon(target)
+                              
+                       if serange != "":
+                              semanage_context_set_mls(self.sh, con, untranslate(serange))
+                       if seuser != "":
+                              semanage_context_set_user(self.sh, con, seuser)
+                              
+                       if setype != "":
+                              semanage_context_set_type(self.sh, con, setype)
+
+                       rc = semanage_fcontext_set_con(self.sh, fcontext, con)
+                       if rc < 0:
+                              raise ValueError(_("Could not set file context for %s") % target)
+                else:
+                       rc = semanage_fcontext_set_con(self.sh, fcontext, None)
+                       if rc < 0:
+                              raise ValueError(_("Could not set file context for %s") % target)
+                       
+                rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not start semanage transaction"))
 
@@ -1283,9 +1305,12 @@
 			raise ValueError(_("Could not list booleans"))
 
 		for boolean in self.blist:
-			name = semanage_bool_get_name(boolean)
-			value = semanage_bool_get_value(boolean)
-			ddict[name] = value
+                       value = []
+                       name = semanage_bool_get_name(boolean)
+                       value[0] = semanage_bool_get_value(boolean)
+                       value[1] = selinux.security_get_boolean_pending(boolean)
+                       value[2] = selinux.security_get_boolean_active(boolean)
+                       ddict[name] = value
 
 		return ddict
 			

--------------070903040906030002010204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
