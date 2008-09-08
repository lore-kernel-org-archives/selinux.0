Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88J5bVJ016050
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:05:37 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88J5ag7004768
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 19:05:36 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m88J5aOT014554
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:05:36 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m88J5ZT3012685
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:05:35 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m88J5Zji024050
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:05:35 -0400
Message-ID: <48C57780.6090408@redhat.com>
Date: Mon, 08 Sep 2008 15:05:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Changes to semanage to allow it to handle transactions.
Content-Type: multipart/mixed;
 boundary="------------080505080400020907010009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080505080400020907010009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

semanage -S targeted -i - << __eof
user -a -P user -R "unconfined_r system_r" -r s0-s0:c0.c1023 unconfined_u
user -a -P user -R guest_r guest_u
user -a -P user -R xguest_r xguest_u
__eof
semanage -S targeted -i - << __eof
login -m  -s unconfined_u -r s0-s0:c0.c1023 __default__
login -m  -s unconfined_u -r s0-s0:c0.c1023 root
__eof

So you can add multiple records in a single pass.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjFd4AACgkQrlYvE4MpobMaoQCgxeqYTX2mpRIiIr0461/fvblU
3fQAoIbM8x9rWL0f8iPz0UeoM2mf60XW
=hxC3
-----END PGP SIGNATURE-----

--------------080505080400020907010009
Content-Type: text/plain;
 name="semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.patch"

--- nsapolicycoreutils/semanage/semanage	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.55/semanage/semanage	2008-09-08 14:46:57.000000000 -0400
@@ -20,7 +20,7 @@
 #                                        02111-1307  USA
 #
 #  
-import os, sys, getopt
+import sys, getopt, re
 import seobject
 import selinux
 PROGNAME="policycoreutils"
@@ -43,7 +43,9 @@
 if __name__ == '__main__':
 
 	def usage(message = ""):
-		print _("""
+               raise ValueError(_("""
+semanage [ -S store ] -i [ input_file | - ]
+
 semanage {boolean|login|user|port|interface|node|fcontext|translation} -{l|D} [-n]
 semanage login -{a|d|m} [-sr] login_name | %groupname
 semanage user -{a|d|m} [-LrRP] selinux_name
@@ -60,6 +62,7 @@
 	-a, --add        Add a OBJECT record NAME
 	-d, --delete     Delete a OBJECT record NAME
 	-m, --modify     Modify a OBJECT record NAME
+        -i, --input      Input multiple semange commands in a transaction 
 	-l, --list       List the OBJECTS
 	-C, --locallist  List OBJECTS local customizations
 	-D, --deleteall  Remove all OBJECTS local customizations
@@ -91,9 +94,8 @@
 	-s, --seuser     SELinux User Name
 	-t, --type       SELinux Type for the object
 	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only)
-""")
-		print message
-		sys.exit(1)
+%s
+""") % message)
 		
 	def errorExit(error):
 		sys.stderr.write("%s: " % sys.argv[0])
@@ -124,12 +126,53 @@
 		valid_option["permissive"] += [ '-a', '--add', '-d', '--delete', '-l', '--list', '-h', '--help', '-n', '--noheading', '-D', '--deleteall' ]
 		return valid_option
 
-	#
-	# 
-	#
-	try:
-		input = sys.stdin
-		output = sys.stdout
+        def mkargv(line):
+               dquote = "\""
+               squote = "\'"
+               l = line.split()
+               ret = []
+               i = 0
+               while i < len(l):
+                      cnt = len(re.findall(dquote, l[i]))
+                      if cnt > 1:
+                             ret.append(l[i].strip(dquote))
+                             i = i + 1
+                             continue
+                      if cnt == 1:
+                             quote = [ l[i].strip(dquote) ]
+                             i = i + 1
+                             
+                             while i < len(l) and  dquote not in l[i]:
+                                    quote.append(l[i])
+                                    i = i + 1
+                             quote.append(l[i].strip(dquote))
+                             ret.append(" ".join(quote))
+                             i = i + 1
+                             continue
+
+                      cnt = len(re.findall(squote, l[i]))
+                      if cnt > 1:
+                             ret.append(l[i].strip(squote))
+                             i = i + 1
+                             continue
+                      if cnt == 1:
+                             quote = [ l[i].strip(squote) ]
+                             i = i + 1
+                             while i < len(l) and  squote not in l[i]:
+                                    quote.append(l[i])
+                                    i = i + 1
+
+                             quote.append(l[i].strip(squote))
+                             ret.append(" ".join(quote))
+                             i = i + 1
+                             continue
+
+                      ret.append(l[i])
+                      i = i + 1
+
+               return ret
+
+        def process_args(argv):
 		serange = ""
 		port = ""
 		proto = ""
@@ -151,24 +194,23 @@
 		locallist = False
 		use_file = False
                 store = ""
-		if len(sys.argv) < 3:
-			usage(_("Requires 2 or more arguments"))
 			
-		object = sys.argv[1]
+		object = argv[0]
 		option_dict=get_options()
 		if object not in option_dict.keys():
 			usage(_("%s not defined") % object)
 			
-		args = sys.argv[2:]
+		args = argv[1:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:lhmnp:s:FCDR:L:r:t:T:P:S:M:',
+					    '01adf:i:lhmnp:s:FCDR:L:r:t:T:P:S:M:',
 					    ['add',
 					     'delete',
 					     'deleteall',
 					     'ftype=',
 					     'file',
 					     'help',
+                                             'input=',
 					     'list', 
 					     'modify',
 					     'noheading',
@@ -184,7 +226,7 @@
 					     'type=',
 					     'trans=',
 					     'prefix=',
-                         'mask='
+                                             'mask='
 					     ])
 		for o, a in gopts:
 			if o not in option_dict[object]:
@@ -193,16 +235,16 @@
 		for o,a in gopts:
 			if o == "-a" or o == "--add":
 				if modify or delete:
-					usage()
+                                       raise ValueError(_("%s bad option") % o)
 				add = True
 				
 			if o == "-d"  or o == "--delete":
 				if modify or add:
-					usage()
+                                       raise ValueError(_("%s bad option") % o)
 				delete = True
 			if o == "-D"  or o == "--deleteall":
 				if modify:
-                                       usage()
+                                       raise ValueError(_("%s bad option") % o)
 				deleteall = True
 			if o == "-f"  or o == "--ftype":
 				ftype=a
@@ -211,7 +253,7 @@
 				use_file = True
 
 			if o == "-h" or o == "--help":
-				usage()
+                               raise ValueError(_("%s bad option") % o)
 
 			if o == "-n" or o == "--noheading":
 				heading = False
@@ -221,7 +263,7 @@
 
 			if o == "-m"or o == "--modify":
 				if delete or add:
-					usage()
+                                       raise ValueError(_("%s bad option") % o)
 				modify = True
 				
 			if o == "-S" or o == '--store':
@@ -229,7 +271,7 @@
 
 			if o == "-r" or o == '--range':
 				if is_mls_enabled == 0:
-					errorExit(_("range not supported on Non MLS machines"))
+                                       raise ValueError(_("range not supported on Non MLS machines"))
 				serange = a
 
 			if o == "-l" or o == "--list":
@@ -237,7 +279,7 @@
 
 			if o == "-L" or o == '--level':
 				if is_mls_enabled == 0:
-					errorExit(_("range not supported on Non MLS machines"))
+                                       raise ValueError(_("range not supported on Non MLS machines"))
 				selevel = a
 
 			if o == "-p" or o == '--proto':
@@ -280,7 +322,7 @@
 
 		if object == "node":
 			OBJECT = seobject.nodeRecords(store)
-		
+
 		if object == "fcontext":
 			OBJECT = seobject.fcontextRecords(store)
 		
@@ -298,14 +340,14 @@
                                OBJECT.list(heading, locallist, use_file)
 			else:
                                OBJECT.list(heading, locallist)
-			sys.exit(0);
+                        return
 			
 		if deleteall:
 			OBJECT.deleteall()
-			sys.exit(0);
+                        return
 			
 		if len(cmds) != 1:
-			usage()
+                       raise ValueError(_("%s bad option") % o)
                         
                 target = cmds[0]
 
@@ -317,10 +359,7 @@
 				OBJECT.add(target, setrans)
 
 			if object == "user":
-                               rlist = []
-                               if not use_file:
-                                      rlist = roles.split()
-                               OBJECT.add(target, rlist, selevel, serange, prefix)
+				OBJECT.add(target, roles.split(), selevel, serange, prefix)
 
 			if object == "port":
 				OBJECT.add(target, proto, serange, setype)
@@ -336,7 +375,7 @@
 			if object == "permissive":
 				OBJECT.add(target)
 
-			sys.exit(0);
+                        return
 			
 		if modify:
 			if object == "boolean":
@@ -364,7 +403,7 @@
 			if object == "fcontext":
 				OBJECT.modify(target, setype, ftype, serange, seuser)
 
-			sys.exit(0);
+                        return
 
 		if delete:
 			if object == "port":
@@ -379,16 +418,69 @@
 			else:
 				OBJECT.delete(target)
 
-			sys.exit(0);
-		usage()
+                        return
+
+                raise ValueError(_("Invalid command") % " ".join(argv))
+
+	#
+	# 
+	#
+	try:
+               input = None
+               store = ""
+
+               if len(sys.argv) < 3:
+                      usage(_("Requires 2 or more arguments"))
+                
+               gopts, cmds = getopt.getopt(sys.argv[1:],
+                                           '01adf:i:lhmnp:s:FCDR:L:r:t:T:P:S:',
+                                           ['add',
+                                            'delete',
+                                            'deleteall',
+                                            'ftype=',
+                                            'file',
+                                            'help',
+                                            'input=',
+                                            'list', 
+                                            'modify',
+                                            'noheading',
+                                            'localist',
+                                            'off', 
+                                            'on', 
+                                            'proto=',
+                                            'seuser=',
+                                            'store=',
+                                            'range=',
+                                            'level=',
+                                            'roles=',
+                                            'type=',
+                                            'trans=',
+                                            'prefix='
+                                            ])
+               for o, a in gopts:
+                      if o == "-S" or o == '--store':
+                             store = a
+                      if o == "-i" or o == '--input':
+                             input = a
+
+               if input != None:
+                      if input == "-":
+                             fd = sys.stdin
+                      else:
+                             fd = open(input, 'r')
+                      trans = seobject.semanageRecords(store)
+                      trans.begin()
+                      for l in fd.readlines():
+                             process_args(mkargv(l))
+                      trans.commit()
+               else:
+                      process_args(sys.argv[1:])
 			
 	except getopt.error, error:
-		errorExit(_("Options Error %s ") % error.msg)
+		usage(_("Options Error %s ") % error.msg)
 	except ValueError, error:
 		errorExit(error.args[0])
 	except KeyError, error:
 		errorExit(_("Invalid value %s") % error.args[0])
 	except IOError, error:
 		errorExit(error.args[1])
-	except KeyboardInterrupt, error:
-		sys.exit(0)
--- nsapolicycoreutils/semanage/seobject.py	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.55/semanage/seobject.py	2008-09-08 15:02:04.000000000 -0400
@@ -26,7 +26,6 @@
 PROGNAME="policycoreutils"
 import sepolgen.module as module
 
-import commands
 import gettext
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
@@ -40,6 +39,33 @@
 
 import syslog
 
+handle = None
+
+def get_handle(store):
+       global handle
+
+       handle = semanage_handle_create()
+       if not handle:
+              raise ValueError(_("Could not create semanage handle"))
+       
+       if store != "":
+              semanage_select_store(handle, store, SEMANAGE_CON_DIRECT);
+
+       if not semanage_is_managed(handle):
+              semanage_handle_destroy(handle)
+              raise ValueError(_("SELinux policy is not managed or store cannot be accessed."))
+
+       rc = semanage_access_check(handle)
+       if rc < SEMANAGE_CAN_READ:
+              semanage_handle_destroy(handle)
+              raise ValueError(_("Cannot read policy store."))
+
+       rc = semanage_connect(handle)
+       if rc < 0:
+              semanage_handle_destroy(handle)
+              raise ValueError(_("Could not establish semanage connection"))       
+       return handle
+
 file_types = {}
 file_types[""] = SEMANAGE_FCONTEXT_ALL;
 file_types["all files"] = SEMANAGE_FCONTEXT_ALL;
@@ -90,8 +116,6 @@
 			
 mylog = logger()		
 
-import sys, os
-import re
 import xml.etree.ElementTree
 
 booleans_dict={}
@@ -249,31 +273,36 @@
 		os.rename(newfilename, self.filename)
                 os.system("/sbin/service mcstrans reload > /dev/null")
 
-class permissiveRecords:
+class semanageRecords:
 	def __init__(self, store):
-               self.store = store
-               self.sh = semanage_handle_create()
-               if not self.sh:
-                      raise ValueError(_("Could not create semanage handle"))
-               
-               if store != "":
-                      semanage_select_store(self.sh, store, SEMANAGE_CON_DIRECT);
+               global handle
                       
-               self.semanaged = semanage_is_managed(self.sh)
-               
-               if not self.semanaged:
-                      semanage_handle_destroy(self.sh)
-                      raise ValueError(_("SELinux policy is not managed or store cannot be accessed."))
-
-               rc = semanage_access_check(self.sh)
-               if rc < SEMANAGE_CAN_READ:
-                      semanage_handle_destroy(self.sh)
-                      raise ValueError(_("Cannot read policy store."))
+               if handle != None:
+                      self.transaction = True
+                      self.sh = handle
+               else:
+                      self.sh=get_handle(store)
+                      self.transaction = False
+
+        def deleteall(self):
+               raise ValueError(_("Not yet implemented"))
 
-               rc = semanage_connect(self.sh)
+        def begin(self):
+               if self.transaction:
+                      return
+               rc = semanage_begin_transaction(self.sh)
+               if rc < 0:
+                      raise ValueError(_("Could not start semanage transaction"))
+        def commit(self):
+               if self.transaction:
+                      return
+               rc = semanage_commit(self.sh) 
                if rc < 0:
-                      semanage_handle_destroy(self.sh)
-                      raise ValueError(_("Could not establish semanage connection"))
+                      raise ValueError(_("Could not commit semanage transaction"))
+
+class permissiveRecords(semanageRecords):
+	def __init__(self, store):
+               semanageRecords.__init__(self, store)
 
 	def get_all(self):
                l = []
@@ -321,9 +350,9 @@
                rc = semanage_module_install(self.sh, data, len(data));
                if rc < 0:
 			raise ValueError(_("Could not set permissive domain %s (module installation failed)") % name)
-               rc = semanage_commit(self.sh)
-               if rc < 0:
-			raise ValueError(_("Could not set permissive domain %s (commit failed)") % name)
+
+               self.commit()
+
                for root, dirs, files in os.walk("tmp", topdown=False):
                       for name in files:
                              os.remove(os.path.join(root, name))
@@ -331,13 +360,12 @@
                              os.rmdir(os.path.join(root, name))
 
 	def delete(self, name):
-		for n in name.split():
-			rc = semanage_module_remove(self.sh, "permissive_%s" % n)
-			if rc < 0:
-	                        raise ValueError(_("Could not remove permissive domain %s (remove failed)") % name)
-			rc = semanage_commit(self.sh)
-			if rc < 0:
-                               raise ValueError(_("Could not remove permissive domain %s (commit failed)") % name)
+               for n in name.split():
+                      rc = semanage_module_remove(self.sh, "permissive_%s" % n)
+                      if rc < 0:
+                             raise ValueError(_("Could not remove permissive domain %s (remove failed)") % name)
+                      
+               self.commit()
 			
 	def deleteall(self):
                l = self.get_all()
@@ -345,39 +373,11 @@
                       all = " ".join(l)
                       self.delete(all)
 
-class semanageRecords:
-	def __init__(self, store):
-		self.sh = semanage_handle_create()
-		if not self.sh:
-		       raise ValueError(_("Could not create semanage handle"))
-		
-                if store != "":
-                       semanage_select_store(self.sh, store, SEMANAGE_CON_DIRECT);
-
-		self.semanaged = semanage_is_managed(self.sh)
-
-		if not self.semanaged:
-			semanage_handle_destroy(self.sh)
-			raise ValueError(_("SELinux policy is not managed or store cannot be accessed."))
-
-		rc = semanage_access_check(self.sh)
-		if rc < SEMANAGE_CAN_READ:
-			semanage_handle_destroy(self.sh)
-			raise ValueError(_("Cannot read policy store."))
-
-		rc = semanage_connect(self.sh)
-		if rc < 0:
-			semanage_handle_destroy(self.sh)
-			raise ValueError(_("Could not establish semanage connection"))
-        def deleteall(self):
-               raise ValueError(_("Not yet implemented"))
-               
-
 class loginRecords(semanageRecords):
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
 
-	def add(self, name, sename, serange):
+	def __add(self, name, sename, serange):
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"
@@ -387,153 +387,145 @@
 		if sename == "":
 			sename = "user_u"
 			
-		try:
-			(rc,k) = semanage_seuser_key_create(self.sh, name)
-			if rc < 0:
-				raise ValueError(_("Could not create a key for %s") % name)
+		(rc,k) = semanage_seuser_key_create(self.sh, name)
+		if rc < 0:
+			raise ValueError(_("Could not create a key for %s") % name)
 
-			(rc,exists) = semanage_seuser_exists(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if login mapping for %s is defined") % name)
-			if exists:
-				raise ValueError(_("Login mapping for %s is already defined") % name)
-                        if name[0] == '%':
-                                try:
-                                       grp.getgrnam(name[1:])
-                                except:
-                                       raise ValueError(_("Linux Group %s does not exist") % name[1:])
-                        else:
-                                try:
-                                       pwd.getpwnam(name)
-                                except:
-                                       raise ValueError(_("Linux User %s does not exist") % name)
+		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError(_("Could not check if login mapping for %s is defined") % name)
+		if exists:
+			raise ValueError(_("Login mapping for %s is already defined") % name)
+                if name[0] == '%':
+                       try:
+                              grp.getgrnam(name[1:])
+                       except:
+                              raise ValueError(_("Linux Group %s does not exist") % name[1:])
+                else:
+                       try:
+                              pwd.getpwnam(name)
+                       except:
+                              raise ValueError(_("Linux User %s does not exist") % name)
 
-			(rc,u) = semanage_seuser_create(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not create login mapping for %s") % name)
+                (rc,u) = semanage_seuser_create(self.sh)
+                if rc < 0:
+                       raise ValueError(_("Could not create login mapping for %s") % name)
 
-			rc = semanage_seuser_set_name(self.sh, u, name)
-			if rc < 0:
-				raise ValueError(_("Could not set name for %s") % name)
+                rc = semanage_seuser_set_name(self.sh, u, name)
+                if rc < 0:
+                       raise ValueError(_("Could not set name for %s") % name)
 
-			if serange != "":
-				rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
-				if rc < 0:
-					raise ValueError(_("Could not set MLS range for %s") % name)
+                if serange != "":
+                       rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
+                       if rc < 0:
+                              raise ValueError(_("Could not set MLS range for %s") % name)
 
-			rc = semanage_seuser_set_sename(self.sh, u, sename)
-			if rc < 0:
-				raise ValueError(_("Could not set SELinux user for %s") % name)
+                rc = semanage_seuser_set_sename(self.sh, u, sename)
+                if rc < 0:
+                       raise ValueError(_("Could not set SELinux user for %s") % name)
 
-			rc = semanage_begin_transaction(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not start semanage transaction"))
+                rc = semanage_seuser_modify_local(self.sh, k, u)
+                if rc < 0:
+                       raise ValueError(_("Could not add login mapping for %s") % name)
 
-			rc = semanage_seuser_modify_local(self.sh, k, u)
-			if rc < 0:
-				raise ValueError(_("Could not add login mapping for %s") % name)
+		semanage_seuser_key_free(k)
+		semanage_seuser_free(u)
 
-			rc = semanage_commit(self.sh) 
-			if rc < 0:
-				raise ValueError(_("Could not add login mapping for %s") % name)
+	def add(self, name, sename, serange):
+		try:
+                        self.begin()
+                        self.__add(name, sename, serange)
+                        self.commit()
 
 		except ValueError, error:
 			mylog.log(0, _("add SELinux user mapping"), name, sename, "", serange);
 			raise error
 		
 		mylog.log(1, _("add SELinux user mapping"), name, sename, "", serange);
-		semanage_seuser_key_free(k)
-		semanage_seuser_free(u)
 
-	def modify(self, name, sename = "", serange = ""):
-		oldsename = ""
-		oldserange = ""
-		try:
-			if sename == "" and serange == "":
-				raise ValueError(_("Requires seuser or serange"))
+	def __modify(self, name, sename = "", serange = ""):
+               if sename == "" and serange == "":
+                      raise ValueError(_("Requires seuser or serange"))
 
-			(rc,k) = semanage_seuser_key_create(self.sh, name)
-			if rc < 0:
-				raise ValueError(_("Could not create a key for %s") % name)
+               (rc,k) = semanage_seuser_key_create(self.sh, name)
+               if rc < 0:
+                      raise ValueError(_("Could not create a key for %s") % name)
 
-			(rc,exists) = semanage_seuser_exists(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if login mapping for %s is defined") % name)
-			if not exists:
-				raise ValueError(_("Login mapping for %s is not defined") % name)
+               (rc,exists) = semanage_seuser_exists(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not check if login mapping for %s is defined") % name)
+               if not exists:
+                      raise ValueError(_("Login mapping for %s is not defined") % name)
 
-			(rc,u) = semanage_seuser_query(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not query seuser for %s") % name)
+               (rc,u) = semanage_seuser_query(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not query seuser for %s") % name)
 
-			oldserange = semanage_seuser_get_mlsrange(u)
-			oldsename = semanage_seuser_get_sename(u)
-			if serange != "":
-				semanage_seuser_set_mlsrange(self.sh, u, untranslate(serange))
-			else:
-				serange = oldserange
-			if sename != "":
-				semanage_seuser_set_sename(self.sh, u, sename)
-			else:
-				sename = oldsename
+               oldserange = semanage_seuser_get_mlsrange(u)
+               oldsename = semanage_seuser_get_sename(u)
+               if serange != "":
+                      semanage_seuser_set_mlsrange(self.sh, u, untranslate(serange))
+               else:
+                      serange = oldserange
 
-			rc = semanage_begin_transaction(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not start semanage transaction"))
+               if sename != "":
+                      semanage_seuser_set_sename(self.sh, u, sename)
+               else:
+                      sename = oldsename
 
-			rc = semanage_seuser_modify_local(self.sh, k, u)
-			if rc < 0:
-				raise ValueError(_("Could not modify login mapping for %s") % name)
+               rc = semanage_seuser_modify_local(self.sh, k, u)
+               if rc < 0:
+                      raise ValueError(_("Could not modify login mapping for %s") % name)
 
-			rc = semanage_commit(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not modify login mapping for %s") % name)
+               semanage_seuser_key_free(k)
+               semanage_seuser_free(u)
 
-		except ValueError, error:
-			mylog.log(0,"modify selinux user mapping", name, sename,"", serange, oldsename, "", oldserange);
-			raise error
-		
-		mylog.log(1,"modify selinux user mapping", name, sename, "", serange, oldsename, "", oldserange);
-		semanage_seuser_key_free(k)
-		semanage_seuser_free(u)
+               mylog.log(1,"modify selinux user mapping", name, sename, "", serange, oldsename, "", oldserange);
 
-	def delete(self, name):
+	def modify(self, name, sename = "", serange = ""):
 		try:
-			(rc,k) = semanage_seuser_key_create(self.sh, name)
-			if rc < 0:
-				raise ValueError(_("Could not create a key for %s") % name)
+                        self.begin()
+                        self.__modify(name, sename, serange)
+                        self.commit()
 
-			(rc,exists) = semanage_seuser_exists(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if login mapping for %s is defined") % name)
-			if not exists:
-				raise ValueError(_("Login mapping for %s is not defined") % name)
+		except ValueError, error:
+			mylog.log(0,"modify selinux user mapping", name, sename,"", serange, "", "", "");
+			raise error
+		
+	def __delete(self, name):
+               (rc,k) = semanage_seuser_key_create(self.sh, name)
+               if rc < 0:
+                      raise ValueError(_("Could not create a key for %s") % name)
 
-			(rc,exists) = semanage_seuser_exists_local(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if login mapping for %s is defined") % name)
-			if not exists:
-				raise ValueError(_("Login mapping for %s is defined in policy, cannot be deleted") % name)
+               (rc,exists) = semanage_seuser_exists(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not check if login mapping for %s is defined") % name)
+               if not exists:
+                      raise ValueError(_("Login mapping for %s is not defined") % name)
 
-			rc = semanage_begin_transaction(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not start semanage transaction"))
+               (rc,exists) = semanage_seuser_exists_local(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not check if login mapping for %s is defined") % name)
+               if not exists:
+                      raise ValueError(_("Login mapping for %s is defined in policy, cannot be deleted") % name)
 
-			rc = semanage_seuser_del_local(self.sh, k)
+               rc = semanage_seuser_del_local(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not delete login mapping for %s") % name)
 
-			if rc < 0:
-				raise ValueError(_("Could not delete login mapping for %s") % name)
+               semanage_seuser_key_free(k)
 
-			rc = semanage_commit(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not delete login mapping for %s") % name)
+	def delete(self, name):
+		try:
+                       self.begin()
+                       self.__delete(name)
+                       self.commit()
 
 		except ValueError, error:
 			mylog.log(0,"delete SELinux user mapping", name);
 			raise error
 		
 		mylog.log(1,"delete SELinux user mapping", name);
-		semanage_seuser_key_free(k)
 
 	def get_all(self, locallist = 0):
 		ddict = {}
@@ -568,7 +560,7 @@
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
 
-	def add(self, name, roles, selevel, serange, prefix):
+	def __add(self, name, roles, selevel, serange, prefix):
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"
@@ -580,170 +572,167 @@
 			else:
 				selevel = untranslate(selevel)
 			
-		seroles = " ".join(roles)
-		try:
-			(rc,k) = semanage_user_key_create(self.sh, name)
-			if rc < 0:
-				raise ValueError(_("Could not create a key for %s") % name)
+                if len(roles) < 1:
+                       raise ValueError(_("You must add at least one role for %s") % name)
+                       
+                (rc,k) = semanage_user_key_create(self.sh, name)
+                if rc < 0:
+                       raise ValueError(_("Could not create a key for %s") % name)
 
-			(rc,exists) = semanage_user_exists(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if SELinux user %s is defined") % name)
-			if exists:
-				raise ValueError(_("SELinux user %s is already defined") % name)
+                (rc,exists) = semanage_user_exists(self.sh, k)
+                if rc < 0:
+                       raise ValueError(_("Could not check if SELinux user %s is defined") % name)
+                if exists:
+                       raise ValueError(_("SELinux user %s is already defined") % name)
 
-			(rc,u) = semanage_user_create(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not create SELinux user for %s") % name)
+                (rc,u) = semanage_user_create(self.sh)
+                if rc < 0:
+                       raise ValueError(_("Could not create SELinux user for %s") % name)
 
-			rc = semanage_user_set_name(self.sh, u, name)
-			if rc < 0:
-				raise ValueError(_("Could not set name for %s") % name)
+                rc = semanage_user_set_name(self.sh, u, name)
+                if rc < 0:
+                       raise ValueError(_("Could not set name for %s") % name)
 
-			for r in roles:
-				rc = semanage_user_add_role(self.sh, u, r)
-				if rc < 0:
-					raise ValueError(_("Could not add role %s for %s") % (r, name))
+                for r in roles:
+                       rc = semanage_user_add_role(self.sh, u, r)
+                       if rc < 0:
+                              raise ValueError(_("Could not add role %s for %s") % (r, name))
 
-			if is_mls_enabled == 1:
-				rc = semanage_user_set_mlsrange(self.sh, u, serange)
-				if rc < 0:
-					raise ValueError(_("Could not set MLS range for %s") % name)
-
-				rc = semanage_user_set_mlslevel(self.sh, u, selevel)
-				if rc < 0:
-					raise ValueError(_("Could not set MLS level for %s") % name)
-			rc = semanage_user_set_prefix(self.sh, u, prefix)
-			if rc < 0:
-				raise ValueError(_("Could not add prefix %s for %s") % (r, prefix))
-			(rc,key) = semanage_user_key_extract(self.sh,u)
-			if rc < 0:
-				raise ValueError(_("Could not extract key for %s") % name)
+                if is_mls_enabled == 1:
+                       rc = semanage_user_set_mlsrange(self.sh, u, serange)
+                       if rc < 0:
+                              raise ValueError(_("Could not set MLS range for %s") % name)
 
-			rc = semanage_begin_transaction(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not start semanage transaction"))
+                       rc = semanage_user_set_mlslevel(self.sh, u, selevel)
+                       if rc < 0:
+                              raise ValueError(_("Could not set MLS level for %s") % name)
+                rc = semanage_user_set_prefix(self.sh, u, prefix)
+                if rc < 0:
+                       raise ValueError(_("Could not add prefix %s for %s") % (r, prefix))
+                (rc,key) = semanage_user_key_extract(self.sh,u)
+                if rc < 0:
+                       raise ValueError(_("Could not extract key for %s") % name)
 
-			rc = semanage_user_modify_local(self.sh, k, u)
-			if rc < 0:
-				raise ValueError(_("Could not add SELinux user %s") % name)
+                rc = semanage_user_modify_local(self.sh, k, u)
+                if rc < 0:
+                       raise ValueError(_("Could not add SELinux user %s") % name)
 
-			rc = semanage_commit(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not add SELinux user %s") % name)
+                semanage_user_key_free(k)
+                semanage_user_free(u)
 
+	def add(self, name, roles, selevel, serange, prefix):
+		seroles = " ".join(roles)
+                try:
+                       self.begin()
+                       self.__add( name, roles, selevel, serange, prefix)
+                       self.commit()
 		except ValueError, error:
 			mylog.log(0,"add SELinux user record", name, name, seroles, serange)
 			raise error
 		
 		mylog.log(1,"add SELinux user record", name, name, seroles, serange)
-		semanage_user_key_free(k)
-		semanage_user_free(u)
 
-	def modify(self, name, roles = [], selevel = "", serange = "", prefix = ""):
+        def __modify(self, name, roles = [], selevel = "", serange = "", prefix = ""):
 		oldroles = ""
 		oldserange = ""
 		newroles = string.join(roles, ' ');
-		try:
-			if prefix == "" and len(roles) == 0  and serange == "" and selevel == "":
-				if is_mls_enabled == 1:
-					raise ValueError(_("Requires prefix, roles, level or range"))
-				else:
-					raise ValueError(_("Requires prefix or roles"))
-
-			(rc,k) = semanage_user_key_create(self.sh, name)
-			if rc < 0:
-				raise ValueError(_("Could not create a key for %s") % name)
+                if prefix == "" and len(roles) == 0  and serange == "" and selevel == "":
+                       if is_mls_enabled == 1:
+                              raise ValueError(_("Requires prefix, roles, level or range"))
+                       else:
+                              raise ValueError(_("Requires prefix or roles"))
 
-			(rc,exists) = semanage_user_exists(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if SELinux user %s is defined") % name)
-			if not exists:
-				raise ValueError(_("SELinux user %s is not defined") % name)
+                (rc,k) = semanage_user_key_create(self.sh, name)
+                if rc < 0:
+                       raise ValueError(_("Could not create a key for %s") % name)
 
-			(rc,u) = semanage_user_query(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not query user for %s") % name)
+                (rc,exists) = semanage_user_exists(self.sh, k)
+                if rc < 0:
+                       raise ValueError(_("Could not check if SELinux user %s is defined") % name)
+                if not exists:
+                       raise ValueError(_("SELinux user %s is not defined") % name)
 
-			oldserange = semanage_user_get_mlsrange(u)
-			(rc, rlist) = semanage_user_get_roles(self.sh, u)
-			if rc >= 0:
-				oldroles = string.join(rlist, ' ');
-			newroles = newroles + ' ' + oldroles;
-
-
-			if serange != "":
-				semanage_user_set_mlsrange(self.sh, u, untranslate(serange))
-			if selevel != "":
-				semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
-
-			if prefix != "":
-                               semanage_user_set_prefix(self.sh, u, prefix)
-
-			if len(roles) != 0:
-                               for r in rlist:
-                                      if r not in roles:
-                                             semanage_user_del_role(u, r)
-                               for r in roles:
-                                      if r not in rlist:
-                                             semanage_user_add_role(self.sh, u, r)
+                (rc,u) = semanage_user_query(self.sh, k)
+                if rc < 0:
+                       raise ValueError(_("Could not query user for %s") % name)
 
-			rc = semanage_begin_transaction(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not start semanage transaction"))
+                oldserange = semanage_user_get_mlsrange(u)
+                (rc, rlist) = semanage_user_get_roles(self.sh, u)
+                if rc >= 0:
+                       oldroles = string.join(rlist, ' ');
+                       newroles = newroles + ' ' + oldroles;
+
+
+                if serange != "":
+                       semanage_user_set_mlsrange(self.sh, u, untranslate(serange))
+                if selevel != "":
+                       semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
+
+                if prefix != "":
+                       semanage_user_set_prefix(self.sh, u, prefix)
+
+                if len(roles) != 0:
+                       for r in rlist:
+                              if r not in roles:
+                                     semanage_user_del_role(u, r)
+                       for r in roles:
+                              if r not in rlist:
+                                     semanage_user_add_role(self.sh, u, r)
 
-			rc = semanage_user_modify_local(self.sh, k, u)
-			if rc < 0:
-				raise ValueError(_("Could not modify SELinux user %s") % name)
-
-			rc = semanage_commit(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not modify SELinux user %s") % name)
+                rc = semanage_user_modify_local(self.sh, k, u)
+                if rc < 0:
+                       raise ValueError(_("Could not modify SELinux user %s") % name)
 
-		except ValueError, error:
-			mylog.log(0,"modify SELinux user record", name, "", newroles, serange, "", oldroles, oldserange)
-			raise error
+		semanage_user_key_free(k)
+		semanage_user_free(u)
 		
 		mylog.log(1,"modify SELinux user record", name, "", newroles, serange, "", oldroles, oldserange)
 
-		semanage_user_key_free(k)
-		semanage_user_free(u)
 
-	def delete(self, name):
+	def modify(self, name, roles = [], selevel = "", serange = "", prefix = ""):
 		try:
-			(rc,k) = semanage_user_key_create(self.sh, name)
-			if rc < 0:
-				raise ValueError(_("Could not create a key for %s") % name)
+                        self.begin()
+                        self.__modify(name, roles, selevel, serange, prefix)
+                        self.commit()
+
+		except ValueError, error:
+			mylog.log(0,"modify SELinux user record", name, "", " ".join(roles), serange, "", "", "")
+			raise error
+
+	def __delete(self, name):
+               (rc,k) = semanage_user_key_create(self.sh, name)
+               if rc < 0:
+                      raise ValueError(_("Could not create a key for %s") % name)
 			
-			(rc,exists) = semanage_user_exists(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if SELinux user %s is defined") % name)		
-			if not exists:
-				raise ValueError(_("SELinux user %s is not defined") % name)
+               (rc,exists) = semanage_user_exists(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not check if SELinux user %s is defined") % name)		
+               if not exists:
+                      raise ValueError(_("SELinux user %s is not defined") % name)
 
-			(rc,exists) = semanage_user_exists_local(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not check if SELinux user %s is defined") % name)
-			if not exists:
-				raise ValueError(_("SELinux user %s is defined in policy, cannot be deleted") % name)
+               (rc,exists) = semanage_user_exists_local(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not check if SELinux user %s is defined") % name)
+               if not exists:
+                      raise ValueError(_("SELinux user %s is defined in policy, cannot be deleted") % name)
 			
-			rc = semanage_begin_transaction(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not start semanage transaction"))
+               rc = semanage_user_del_local(self.sh, k)
+               if rc < 0:
+                      raise ValueError(_("Could not delete SELinux user %s") % name)
 
-			rc = semanage_user_del_local(self.sh, k)
-			if rc < 0:
-				raise ValueError(_("Could not delete SELinux user %s") % name)
+               semanage_user_key_free(k)		
+
+	def delete(self, name):
+		try:
+                        self.begin()
+                        self.__delete(name)
+                        self.commit()
 
-			rc = semanage_commit(self.sh)
-			if rc < 0:
-				raise ValueError(_("Could not delete SELinux user %s") % name)
 		except ValueError, error:
 			mylog.log(0,"delete SELinux user record", name)
 			raise error
 		
 		mylog.log(1,"delete SELinux user record", name)
-		semanage_user_key_free(k)		
 
 	def get_all(self, locallist = 0):
 		ddict = {}
@@ -808,7 +797,7 @@
 			raise ValueError(_("Could not create a key for %s/%s") % (proto, port))
 		return ( k, proto_d, low, high )
 
-	def add(self, port, proto, serange, type):
+	def __add(self, port, proto, serange, type):
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"
@@ -857,23 +846,20 @@
 		if rc < 0:
 			raise ValueError(_("Could not set port context for %s/%s") % (proto, port))
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_port_modify_local(self.sh, k, p)
 		if rc < 0:
 			raise ValueError(_("Could not add port %s/%s") % (proto, port))
 	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not add port %s/%s") % (proto, port))
-
 		semanage_context_free(con)
 		semanage_port_key_free(k)
 		semanage_port_free(p)
 
-	def modify(self, port, proto, serange, setype):
+	def add(self, port, proto, serange, type):
+                self.begin()
+                self.__add(port, proto, serange, type)
+                self.commit()
+
+	def __modify(self, port, proto, serange, setype):
 		if serange == "" and setype == "":
 			if is_mls_enabled == 1:
 				raise ValueError(_("Requires setype or serange"))
@@ -899,29 +885,24 @@
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_port_modify_local(self.sh, k, p)
 		if rc < 0:
 			raise ValueError(_("Could not modify port %s/%s") % (proto, port))
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not modify port %s/%s") % (proto, port))
-		
 		semanage_port_key_free(k)
 		semanage_port_free(p)
 
+	def modify(self, port, proto, serange, setype):
+                self.begin()
+                self.__modify(port, proto, serange, setype)
+                self.commit()
+
 	def deleteall(self):
 		(rc, plist) = semanage_port_list_local(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not list the ports"))
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
+                self.begin()
 
 		for port in plist:
                        proto = semanage_port_get_proto(port)
@@ -938,11 +919,9 @@
                               raise ValueError(_("Could not delete the port %s") % port_str)
                        semanage_port_key_free(k)
 	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete the %s") % port_str)
+                self.commit()
 
-	def delete(self, port, proto):
+	def __delete(self, port, proto):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 		(rc,exists) = semanage_port_exists(self.sh, k)
 		if rc < 0:
@@ -956,20 +935,17 @@
 		if not exists:
 			raise ValueError(_("Port %s/%s is defined in policy, cannot be deleted") % (proto, port))
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_port_del_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not delete port %s/%s") % (proto, port))
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete port %s/%s") % (proto, port))
-		
 		semanage_port_key_free(k)
 
+	def delete(self, port, proto):
+                self.begin()
+                self.__delete(port, proto)
+                self.commit()
+
 	def get_all(self, locallist = 0):
 		ddict = {}
                 if locallist:
@@ -1035,7 +1011,7 @@
        def __init__(self, store = ""):
                semanageRecords.__init__(self,store)
 
-       def add(self, addr, mask, proto, serange, ctype):
+       def __add(self, addr, mask, proto, serange, ctype):
                if addr == "":
                        raise ValueError(_("Node Address is required"))
 
@@ -1104,23 +1080,20 @@
                if rc < 0:
                        raise ValueError(_("Could not set addr context for %s") % addr)
 
-               rc = semanage_begin_transaction(self.sh)
-               if rc < 0:
-                       raise ValueError(_("Could not start semanage transaction"))
-
                rc = semanage_node_modify_local(self.sh, k, node)
                if rc < 0:
                        raise ValueError(_("Could not add addr %s") % addr)
 
-               rc = semanage_commit(self.sh)
-               if rc < 0:
-                       raise ValueError(_("Could not add addr %s") % addr)
-
                semanage_context_free(con)
                semanage_node_key_free(k)
                semanage_node_free(node)
 
-       def modify(self, addr, mask, proto, serange, setype):
+       def add(self, addr, mask, proto, serange, ctype):
+                self.begin()
+                self.__add(self, addr, mask, proto, serange, ctype)
+                self.commit()
+
+       def __modify(self, addr, mask, proto, serange, setype):
                if addr == "":
                        raise ValueError(_("Node Address is required"))
 
@@ -1158,22 +1131,19 @@
                if setype != "":
                        semanage_context_set_type(self.sh, con, setype)
 
-               rc = semanage_begin_transaction(self.sh)
-               if rc < 0:
-                       raise ValueError(_("Could not start semanage transaction"))
-
                rc = semanage_node_modify_local(self.sh, k, node)
                if rc < 0:
                        raise ValueError(_("Could not modify addr %s") % addr)
 
-               rc = semanage_commit(self.sh)
-               if rc < 0:
-                       raise ValueError(_("Could not modify addr %s") % addr)
-
                semanage_node_key_free(k)
                semanage_node_free(node)
 
-       def delete(self, addr, mask, proto):
+       def modify(self, addr, mask, proto, serange, setype):
+                self.begin()
+                self.__modify(addr, mask, proto, serange, setype)
+                self.commit()
+
+       def __delete(self, addr, mask, proto):
                if addr == "":
                        raise ValueError(_("Node Address is required"))
 
@@ -1203,20 +1173,17 @@
                if not exists:
                        raise ValueError(_("Addr %s is defined in policy, cannot be deleted") % addr)
 
-               rc = semanage_begin_transaction(self.sh)
-               if rc < 0:
-                       raise ValueError(_("Could not start semanage transaction"))
-
                rc = semanage_node_del_local(self.sh, k)
                if rc < 0:
                        raise ValueError(_("Could not delete addr %s") % addr)
 
-               rc = semanage_commit(self.sh)
-               if rc < 0:
-                       raise ValueError(_("Could not delete addr %s") % addr)
-
                semanage_node_key_free(k)
 
+       def delete(self, addr, mask, proto):
+              self.begin()
+              self.__delete(addr, mask, proto)
+              self.commit()
+		
        def get_all(self, locallist = 0):
                ddict = {}
 	       if locallist :
@@ -1260,7 +1227,7 @@
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
 
-	def add(self, interface, serange, ctype):
+	def __add(self, interface, serange, ctype):
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"
@@ -1314,23 +1281,20 @@
 		if rc < 0:
 			raise ValueError(_("Could not set message context for %s") % interface)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_iface_modify_local(self.sh, k, iface)
 		if rc < 0:
 			raise ValueError(_("Could not add interface %s") % interface)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not add interface %s") % interface)
-
 		semanage_context_free(con)
 		semanage_iface_key_free(k)
 		semanage_iface_free(iface)
 
-	def modify(self, interface, serange, setype):
+	def add(self, interface, serange, ctype):
+                self.begin()
+                self.__add(interface, serange, ctype)
+                self.commit()
+
+	def __modify(self, interface, serange, setype):
 		if serange == "" and setype == "":
 			raise ValueError(_("Requires setype or serange"))
 
@@ -1355,22 +1319,19 @@
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_iface_modify_local(self.sh, k, iface)
 		if rc < 0:
 			raise ValueError(_("Could not modify interface %s") % interface)
 		
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not modify interface %s") % interface)
-
 		semanage_iface_key_free(k)
 		semanage_iface_free(iface)
 
-	def delete(self, interface):
+	def modify(self, interface, serange, setype):
+                self.begin()
+                self.__modify(interface, serange, setype)
+                self.commit()
+
+	def __delete(self, interface):
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
 			raise ValueError(_("Could not create key for %s") % interface)
@@ -1387,20 +1348,17 @@
 		if not exists:
 			raise ValueError(_("Interface %s is defined in policy, cannot be deleted") % interface)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_iface_del_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not delete interface %s") % interface)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete interface %s") % interface)
-		
 		semanage_iface_key_free(k)
 
+	def delete(self, interface):
+                self.begin()
+                self.__delete(interface)
+                self.commit()
+		
 	def get_all(self, locallist = 0):
 		ddict = {}
                 if locallist:
@@ -1459,7 +1417,7 @@
                if target == "" or target.find("\n") >= 0:
                       raise ValueError(_("Invalid file specification"))
                       
-	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
+	def __add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
                 self.validate(target)
 
 		if is_mls_enabled == 1:
@@ -1500,24 +1458,21 @@
 
 		semanage_fcontext_set_type(fcontext, file_types[ftype])
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_fcontext_modify_local(self.sh, k, fcontext)
 		if rc < 0:
 			raise ValueError(_("Could not add file context for %s") % target)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not add file context for %s") % target)
-
                 if type != "<<none>>":
                        semanage_context_free(con)
 		semanage_fcontext_key_free(k)
 		semanage_fcontext_free(fcontext)
 
-	def modify(self, target, setype, ftype, serange, seuser):
+	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
+                self.begin()
+                self.__add(target, type, ftype, serange, seuser)
+                self.commit()
+
+	def __modify(self, target, setype, ftype, serange, seuser):
 		if serange == "" and setype == "" and seuser == "":
 			raise ValueError(_("Requires setype, serange or seuser"))
                 self.validate(target)
@@ -1558,29 +1513,25 @@
                        if rc < 0:
                               raise ValueError(_("Could not set file context for %s") % target)
                        
-                rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_fcontext_modify_local(self.sh, k, fcontext)
 		if rc < 0:
 			raise ValueError(_("Could not modify file context for %s") % target)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not modify file context for %s") % target)
-		
 		semanage_fcontext_key_free(k)
 		semanage_fcontext_free(fcontext)
 
+	def modify(self, target, setype, ftype, serange, seuser):
+                self.begin()
+                self.__modify(target, setype, ftype, serange, seuser)
+                self.commit()
+		
+
 	def deleteall(self):
 		(rc, flist) = semanage_fcontext_list_local(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not list the file contexts"))
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
+                self.begin()
 
 		for fcontext in flist:
                        target = semanage_fcontext_get_expr(fcontext)
@@ -1595,11 +1546,9 @@
                               raise ValueError(_("Could not delete the file context %s") % target)
                        semanage_fcontext_key_free(k)
 	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete the file context %s") % target)
+                self.commit()
 
-	def delete(self, target, ftype):
+	def __delete(self, target, ftype):
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
@@ -1616,20 +1565,17 @@
 			else:
 				raise ValueError(_("File context for %s is not defined") % target)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_fcontext_del_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not delete file context for %s") % target)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete file context for %s") % target)
-
 		semanage_fcontext_key_free(k)		
 
+	def delete(self, target, ftype):
+                self.begin()
+                self.__delete( target, ftype)
+                self.commit()
+
 	def get_all(self, locallist = 0):
 		l = []
                 if locallist:
@@ -1711,9 +1657,8 @@
 
 	def modify(self, name, value=None, use_file=False):
                 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
+                self.begin()
+
                 if use_file:
                        fd = open(name)
                        for b in fd.read().split("\n"):
@@ -1723,18 +1668,16 @@
 
                               try:
                                      boolname, val = b.split("=")
-                              except ValueError, e:
+                              except ValueError:
                                      raise ValueError(_("Bad format %s: Record %s" % ( name, b) ))
                               self.__mod(boolname.strip(), val.strip())
                        fd.close()
                 else:
                        self.__mod(name, value)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not modify boolean %s") % name)
+                self.commit()
 		
-	def delete(self, name):
+	def __delete(self, name):
 
                 (rc,k) = semanage_bool_key_create(self.sh, name)
                 if rc < 0:
@@ -1751,42 +1694,30 @@
 		if not exists:
 			raise ValueError(_("Boolean %s is defined in policy, cannot be deleted") % name)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
 		rc = semanage_bool_del_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not delete boolean %s") % name)
 	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete boolean %s") % name)
 		semanage_bool_key_free(k)
 
+	def delete(self, name):
+                self.begin()
+                self.__delete(name)
+                self.commit()
+
 	def deleteall(self):
 		(rc, self.blist) = semanage_bool_list_local(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not list booleans"))
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
+                self.begin()
 
 		for boolean in self.blist:
                        name = semanage_bool_get_name(boolean)
-                       (rc,k) = semanage_bool_key_create(self.sh, name)
-                       if rc < 0:
-                              raise ValueError(_("Could not create a key for %s") % name)
+                       self.__delete(name)
 
-                       rc = semanage_bool_del_local(self.sh, k)
-                       if rc < 0:
-                              raise ValueError(_("Could not delete boolean %s") % name)
-                       semanage_bool_key_free(k)
+                self.commit()
 	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete boolean %s") % name)
 	def get_all(self, locallist = 0):
 		ddict = {}
                 if locallist:

--------------080505080400020907010009
Content-Type: application/octet-stream;
 name="semanage.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="semanage.patch.sig"

iEYEABECAAYFAkjFd4AACgkQrlYvE4MpobMWkQCgxf7/eUYs5Z/HrYCjinpnS1V4OCwAn2Gl
yy07dDib/aaIYOxuMmZsIHGE
--------------080505080400020907010009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
