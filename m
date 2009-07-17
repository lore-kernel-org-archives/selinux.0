Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6HAAmWv030393
	for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2009 06:10:48 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6HAAPiA026571
	for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2009 10:10:26 GMT
Message-ID: <4A604E1D.2020202@redhat.com>
Date: Fri, 17 Jul 2009 06:10:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to semanage
References: <C684E22D.A8D06%csellers@tresys.com>
In-Reply-To: <C684E22D.A8D06%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------060700020609050108000909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060700020609050108000909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ok lets try the patch again.

Added equal patch (spelled correctly.)
Beginning to add modules support to consolidate on one management command.  
	Eventually replace semodule/setsebool with semanage command.
Some white space fixing in seobject.py

--------------060700020609050108000909
Content-Type: text/plain;
 name="semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="semanage.patch"

--- nsapolicycoreutils/semanage/semanage	2009-05-18 13:53:14.000000000 -0400
+++ policycoreutils-2.0.67/semanage/semanage	2009-07-17 05:59:41.000000000 -0400
@@ -44,16 +44,17 @@
                text = _("""
 semanage [ -S store ] -i [ input_file | - ]
 
-semanage {boolean|login|user|port|interface|node|fcontext|translation} -{l|D} [-n]
+semanage {module,boolean|login|user|port|interface|node|fcontext|translation} -{l|D} [-n]
 semanage login -{a|d|m} [-sr] login_name | %groupname
 semanage user -{a|d|m} [-LrRP] selinux_name
 semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
 semanage interface -{a|d|m} [-tr] interface_spec
 semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr
-semanage fcontext -{a|d|m} [-frst] file_spec
+semanage fcontext -{a|d|m} [-frst] [-e path ] file_spec
 semanage translation -{a|d|m} [-T] level
 semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
-semanage permissive -{d|a} type
+semanage permissive -{a|d} type
+semanage module -{a|d|} module
 
 Primary Options:
 
@@ -68,6 +69,7 @@
 	-h, --help       Display this message
 	-n, --noheading  Do not print heading when listing OBJECTS
         -S, --store      Select and alternate SELinux store to manage
+        --dontaudit      Turn on or off dontaudit rules
 
 Object-specific Options (see above):
 
@@ -84,6 +86,7 @@
         -F, --file       Treat target as an input file for command, change multiple settings
 	-p, --proto      Port protocol (tcp or udp) or internet protocol version of node (ipv4 or ipv6)
 	-M, --mask       Netmask
+        -e, --equal      Make target equal to this paths labeling
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")
@@ -115,11 +118,14 @@
 		valid_option["node"] = []
 		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol']
 		valid_option["fcontext"] = []
-		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
+		valid_option["fcontext"] += valid_everyone + [ '-e', '--equal', '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
 		valid_option["translation"] = []
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
 		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0", "-F", "--file"] 
+		valid_option["module"] = []
+		valid_option["module"] += [ '-a', '--add', '-d', '--delete', '-l', '--list', '-h', '--help', '-n', '--noheading', '--dontaudit']
+
 		valid_option["permissive"] = []
 		valid_option["permissive"] += [ '-a', '--add', '-d', '--delete', '-l', '--list', '-h', '--help', '-n', '--noheading', '-D', '--deleteall' ]
 		return valid_option
@@ -192,7 +198,10 @@
 		locallist = False
 		use_file = False
                 store = ""
+                equal=""
 			
+                dontaudit = ""
+
 		object = argv[0]
 		option_dict=get_options()
 		if object not in option_dict.keys():
@@ -201,10 +210,12 @@
 		args = argv[1:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:i:lhmnp:s:FCDR:L:r:t:T:P:S:M:',
+					    '01ade:f:i:lhmnp:s:FCDR:L:r:t:T:P:S:M:',
 					    ['add',
 					     'delete',
 					     'deleteall',
+					     'dontaudit=',
+					     'equal=',
 					     'ftype=',
 					     'file',
 					     'help',
@@ -241,16 +252,24 @@
 				if modify or add:
                                        raise ValueError(_("%s bad option") % o)
 				delete = True
+
 			if o == "-D"  or o == "--deleteall":
 				if modify:
                                        raise ValueError(_("%s bad option") % o)
 				deleteall = True
+
 			if o == "-f"  or o == "--ftype":
-				ftype=a
+				ftype = a
+
+			if o == "-e"  or o == "--equal":
+				equal = a
 
 			if o == "-F"  or o == "--file":
 				use_file = True
 
+			if o == "--dontaudit":
+                                dontaudit = not int(a)
+
 			if o == "-h" or o == "--help":
                                raise ValueError(_("%s bad option") % o)
 
@@ -323,6 +342,9 @@
 		
 		if object == "boolean":
 			OBJECT = seobject.booleanRecords(store)
+
+		if object == "module":
+			OBJECT = seobject.moduleRecords(store)
 		
 		if object == "translation":
 			OBJECT = seobject.setransRecords()
@@ -341,6 +363,13 @@
 			OBJECT.deleteall()
                         return
 			
+		if dontaudit != "":
+			if object == "module":
+                               OBJECT.dontaudit(dontaudit)
+                        else:
+                               raise ValueError(_("%s bad option") % o)
+                        return
+
 		if len(cmds) != 1:
                        raise ValueError(_("%s bad option") % o)
                         
@@ -362,11 +391,17 @@
 			if object == "interface":
 				OBJECT.add(target, serange, setype)
 
+			if object == "module":
+				OBJECT.add(target)
+
 			if object == "node":
 				OBJECT.add(target, mask, proto, serange, setype)
 
 			if object == "fcontext":
-				OBJECT.add(target, setype, ftype, serange, seuser)
+                                if equal == "":
+                                       OBJECT.add(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.add_equal(target, equal)
 			if object == "permissive":
 				OBJECT.add(target)
 
@@ -386,6 +421,9 @@
 				rlist = roles.split()
 				OBJECT.modify(target, rlist, selevel, serange, prefix)
 
+			if object == "module":
+				OBJECT.modify(target)
+
 			if object == "port":
 				OBJECT.modify(target, proto, serange, setype)
 
@@ -396,7 +434,10 @@
 				OBJECT.modify(target, mask, proto, serange, setype)
 
 			if object == "fcontext":
-				OBJECT.modify(target, setype, ftype, serange, seuser)
+                                if equal == "":
+                                       OBJECT.modify(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.modify_equal(target, equal)
 
                         return
 
@@ -405,7 +446,7 @@
 				OBJECT.delete(target, proto)
 
 			elif object == "fcontext":
-				OBJECT.delete(target, ftype)
+                                OBJECT.delete(target, ftype)
 
 			elif object == "node":
 				OBJECT.delete(target, mask, proto)
--- nsapolicycoreutils/semanage/semanage.8	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.67/semanage/semanage.8	2009-07-07 16:47:35.000000000 -0400
@@ -21,6 +21,8 @@
 .br
 .B semanage permissive \-{a|d} type
 .br
+.B semanage module \-{a|d} policy_package
+.br
 .B semanage translation \-{a|d|m} [\-T] level
 .P
 
--- nsapolicycoreutils/semanage/seobject.py	2009-05-18 13:53:14.000000000 -0400
+++ policycoreutils-2.0.67/semanage/seobject.py	2009-07-17 05:59:45.000000000 -0400
@@ -1,5 +1,5 @@
 #! /usr/bin/python -E
-# Copyright (C) 2005, 2006, 2007, 2008 Red Hat 
+# Copyright (C) 2005, 2006, 2007, 2008, 2009 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
 # semanage is a tool for managing SELinux configuration files
@@ -21,16 +21,16 @@
 #
 #  
 
-import pwd, grp, string, selinux, tempfile, os, re, sys
+import pwd, grp, string, selinux, tempfile, os, re, sys, stat
 from semanage import *;
-PROGNAME="policycoreutils"
+PROGNAME = "policycoreutils"
 import sepolgen.module as module
 
 import gettext
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
 try:
-       gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
+       gettext.install(PROGNAME, localedir = "/usr/share/locale", unicode = 1)
 except IOError:
        import __builtin__
        __builtin__.__dict__['_'] = unicode
@@ -96,7 +96,7 @@
 			self.audit_fd = audit.audit_open()
 
 		def log(self, success, msg, name = "", sename = "", serole = "", serange = "", old_sename = "", old_serole = "", old_serange = ""):
-			audit.audit_log_semanage_message(self.audit_fd, audit.AUDIT_USER_ROLE_CHANGE, sys.argv[0],str(msg), name, 0, sename, serole, serange, old_sename, old_serole, old_serange, "", "", "", success);
+			audit.audit_log_semanage_message(self.audit_fd, audit.AUDIT_USER_ROLE_CHANGE, sys.argv[0], str(msg), name, 0, sename, serole, serange, old_sename, old_serole, old_serange, "", "", "", success);
 except:
 	class logger:
 		def log(self, success, msg, name = "", sename = "", serole = "", serange = "", old_sename = "", old_serole = "", old_serange = ""):
@@ -104,7 +104,7 @@
 				message = "Successful: "
 			else:
 				message = "Failed: "
-			message += " %s name=%s" % (msg,name)
+			message += " %s name=%s" % (msg, name)
 			if sename != "":
 				message += " sename=" + sename
 			if old_sename != "":
@@ -123,9 +123,9 @@
 
 import xml.etree.ElementTree
 
-booleans_dict={}
+booleans_dict = {}
 try:
-       tree=xml.etree.ElementTree.parse("/usr/share/selinux/devel/policy.xml")
+       tree = xml.etree.ElementTree.parse("/usr/share/selinux/devel/policy.xml")
        for l in  tree.findall("layer"):
               for m in  l.findall("module"):
                      for b in  m.findall("tunable"):
@@ -160,12 +160,12 @@
 	cat_range = category + "(\." + category +")?"
 	categories = cat_range + "(\," + cat_range + ")*"
 	reg = sensitivity + "(-" + sensitivity + ")?" + "(:" + categories + ")?"
-	return re.search("^" + reg +"$",raw)
+	return re.search("^" + reg +"$", raw)
 
 def translate(raw, prepend = 1):
-        filler="a:b:c:"
+        filler = "a:b:c:"
         if prepend == 1:
-		context = "%s%s" % (filler,raw)
+		context = "%s%s" % (filler, raw)
 	else:
 		context = raw
 	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
@@ -179,9 +179,9 @@
 		return trans
 	
 def untranslate(trans, prepend = 1):
-        filler="a:b:c:"
+        filler = "a:b:c:"
  	if prepend == 1:
-		context = "%s%s" % (filler,trans)
+		context = "%s%s" % (filler, trans)
 	else:
 		context = trans
 
@@ -234,7 +234,7 @@
 			rec += "%s=%s\n" %  (k, self.ddict[k])
 		return rec
 	
-	def list(self,heading = 1, locallist = 0):
+	def list(self, heading = 1, locallist = 0):
 		if heading:
 			print "\n%-25s %s\n" % (_("Level"), _("Translation"))
 		keys = self.ddict.keys()
@@ -273,6 +273,7 @@
 		(fd, newfilename) = tempfile.mkstemp('', self.filename)
 		os.write(fd, self.out())
 		os.close(fd)
+                os.chmod(newfilename, os.stat(self.filename)[stat.ST_MODE])
 		os.rename(newfilename, self.filename)
                 os.system("/sbin/service mcstrans reload > /dev/null")
 
@@ -283,7 +284,7 @@
                if handle != None:
                       self.sh = handle
                else:
-                      self.sh=get_handle(store)
+                      self.sh = get_handle(store)
                self.transaction = False
 
         def deleteall(self):
@@ -314,6 +315,49 @@
                self.transaction = False
                self.commit()
 
+class moduleRecords(semanageRecords):
+	def __init__(self, store):
+               semanageRecords.__init__(self, store)
+
+	def get_all(self):
+               l = []
+               (rc, mlist, number) = semanage_module_list(self.sh)
+               if rc < 0:
+                      raise ValueError(_("Could not list SELinux modules"))
+
+               for i in range(number):
+                      mod = semanage_module_list_nth(mlist, i)
+                      name = semanage_module_get_name(mod)
+                      l.append(name)
+               return l
+
+	def dontaudit(self, dontaudit = 0):
+               self.begin()
+               rc = semanage_set_disable_dontaudit(self.sh, dontaudit)
+               self.commit()
+               rc = semanage_reload_policy(self.sh)
+
+	def list(self, heading = 1, locallist = 0):
+		if heading:
+			print "\n%-25s\n" % (_("Modules"))
+                for t in self.get_all():
+                       print t
+
+	def add(self, modules):
+               import glob
+               for m in modules.split():
+                      rc = semanage_module_install_file(self.sh, m);
+               if rc >= 0:
+                      self.commit()
+
+	def delete(self, modules):
+               for m in modules.split():
+                      rc = semanage_module_remove(self.sh, m)
+                      if rc < 0:
+                             raise ValueError(_("Could not remove module %s (remove failed)") % name)
+                      
+               self.commit()
+			
 class permissiveRecords(semanageRecords):
 	def __init__(self, store):
                semanageRecords.__init__(self, store)
@@ -331,7 +375,7 @@
                              l.append(name.split("permissive_")[1])
                return l
 
-	def list(self,heading = 1, locallist = 0):
+	def list(self, heading = 1, locallist = 0):
 		if heading:
 			print "\n%-25s\n" % (_("Permissive Types"))
                 for t in self.get_all():
@@ -353,7 +397,7 @@
 
 permissive %s;
 """ % (name, type, type)
-               fd = open(filename,'w')
+               fd = open(filename, 'w')
                fd.write(modtxt)
                fd.close()
                mc = module.ModuleCompiler()
@@ -366,7 +410,7 @@
                if rc >= 0:
                       self.commit()
 
-               for root, dirs, files in os.walk("tmp", topdown=False):
+               for root, dirs, files in os.walk("tmp", topdown = False):
                       for name in files:
                              os.remove(os.path.join(root, name))
                       for name in dirs:
@@ -405,11 +449,11 @@
 		if sename == "":
 			sename = "user_u"
 			
-		(rc,k) = semanage_seuser_key_create(self.sh, name)
+		(rc, k) = semanage_seuser_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % name)
 
-		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		(rc, exists) = semanage_seuser_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if login mapping for %s is defined") % name)
 		if exists:
@@ -425,7 +469,7 @@
                        except:
                               raise ValueError(_("Linux User %s does not exist") % name)
 
-                (rc,u) = semanage_seuser_create(self.sh)
+                (rc, u) = semanage_seuser_create(self.sh)
                 if rc < 0:
                        raise ValueError(_("Could not create login mapping for %s") % name)
 
@@ -465,17 +509,17 @@
                if sename == "" and serange == "":
                       raise ValueError(_("Requires seuser or serange"))
 
-               (rc,k) = semanage_seuser_key_create(self.sh, name)
+               (rc, k) = semanage_seuser_key_create(self.sh, name)
                if rc < 0:
                       raise ValueError(_("Could not create a key for %s") % name)
 
-               (rc,exists) = semanage_seuser_exists(self.sh, k)
+               (rc, exists) = semanage_seuser_exists(self.sh, k)
                if rc < 0:
                       raise ValueError(_("Could not check if login mapping for %s is defined") % name)
                if not exists:
                       raise ValueError(_("Login mapping for %s is not defined") % name)
 
-               (rc,u) = semanage_seuser_query(self.sh, k)
+               (rc, u) = semanage_seuser_query(self.sh, k)
                if rc < 0:
                       raise ValueError(_("Could not query seuser for %s") % name)
 
@@ -498,7 +542,7 @@
                semanage_seuser_key_free(k)
                semanage_seuser_free(u)
 
-               mylog.log(1,"modify selinux user mapping", name, sename, "", serange, oldsename, "", oldserange);
+               mylog.log(1, "modify selinux user mapping", name, sename, "", serange, oldsename, "", oldserange);
 
 	def modify(self, name, sename = "", serange = ""):
 		try:
@@ -507,21 +551,21 @@
                         self.commit()
 
 		except ValueError, error:
-			mylog.log(0,"modify selinux user mapping", name, sename,"", serange, "", "", "");
+			mylog.log(0, "modify selinux user mapping", name, sename, "", serange, "", "", "");
 			raise error
 		
 	def __delete(self, name):
-               (rc,k) = semanage_seuser_key_create(self.sh, name)
+               (rc, k) = semanage_seuser_key_create(self.sh, name)
                if rc < 0:
                       raise ValueError(_("Could not create a key for %s") % name)
 
-               (rc,exists) = semanage_seuser_exists(self.sh, k)
+               (rc, exists) = semanage_seuser_exists(self.sh, k)
                if rc < 0:
                       raise ValueError(_("Could not check if login mapping for %s is defined") % name)
                if not exists:
                       raise ValueError(_("Login mapping for %s is not defined") % name)
 
-               (rc,exists) = semanage_seuser_exists_local(self.sh, k)
+               (rc, exists) = semanage_seuser_exists_local(self.sh, k)
                if rc < 0:
                       raise ValueError(_("Could not check if login mapping for %s is defined") % name)
                if not exists:
@@ -540,10 +584,10 @@
                        self.commit()
 
 		except ValueError, error:
-			mylog.log(0,"delete SELinux user mapping", name);
+			mylog.log(0, "delete SELinux user mapping", name);
 			raise error
 		
-		mylog.log(1,"delete SELinux user mapping", name);
+		mylog.log(1, "delete SELinux user mapping", name);
 
 	def get_all(self, locallist = 0):
 		ddict = {}
@@ -593,17 +637,17 @@
                 if len(roles) < 1:
                        raise ValueError(_("You must add at least one role for %s") % name)
                        
-                (rc,k) = semanage_user_key_create(self.sh, name)
+                (rc, k) = semanage_user_key_create(self.sh, name)
                 if rc < 0:
                        raise ValueError(_("Could not create a key for %s") % name)
 
-                (rc,exists) = semanage_user_exists(self.sh, k)
+                (rc, exists) = semanage_user_exists(self.sh, k)
                 if rc < 0:
                        raise ValueError(_("Could not check if SELinux user %s is defined") % name)
                 if exists:
                        raise ValueError(_("SELinux user %s is already defined") % name)
 
-                (rc,u) = semanage_user_create(self.sh)
+                (rc, u) = semanage_user_create(self.sh)
                 if rc < 0:
                        raise ValueError(_("Could not create SELinux user for %s") % name)
 
@@ -627,7 +671,7 @@
                 rc = semanage_user_set_prefix(self.sh, u, prefix)
                 if rc < 0:
                        raise ValueError(_("Could not add prefix %s for %s") % (r, prefix))
-                (rc,key) = semanage_user_key_extract(self.sh,u)
+                (rc, key) = semanage_user_key_extract(self.sh,u)
                 if rc < 0:
                        raise ValueError(_("Could not extract key for %s") % name)
 
@@ -660,17 +704,17 @@
                        else:
                               raise ValueError(_("Requires prefix or roles"))
 
-                (rc,k) = semanage_user_key_create(self.sh, name)
+                (rc, k) = semanage_user_key_create(self.sh, name)
                 if rc < 0:
                        raise ValueError(_("Could not create a key for %s") % name)
 
-                (rc,exists) = semanage_user_exists(self.sh, k)
+                (rc, exists) = semanage_user_exists(self.sh, k)
                 if rc < 0:
                        raise ValueError(_("Could not check if SELinux user %s is defined") % name)
                 if not exists:
                        raise ValueError(_("SELinux user %s is not defined") % name)
 
-                (rc,u) = semanage_user_query(self.sh, k)
+                (rc, u) = semanage_user_query(self.sh, k)
                 if rc < 0:
                        raise ValueError(_("Could not query user for %s") % name)
 
@@ -718,17 +762,17 @@
 			raise error
 
 	def __delete(self, name):
-               (rc,k) = semanage_user_key_create(self.sh, name)
+               (rc, k) = semanage_user_key_create(self.sh, name)
                if rc < 0:
                       raise ValueError(_("Could not create a key for %s") % name)
 			
-               (rc,exists) = semanage_user_exists(self.sh, k)
+               (rc, exists) = semanage_user_exists(self.sh, k)
                if rc < 0:
                       raise ValueError(_("Could not check if SELinux user %s is defined") % name)		
                if not exists:
                       raise ValueError(_("SELinux user %s is not defined") % name)
 
-               (rc,exists) = semanage_user_exists_local(self.sh, k)
+               (rc, exists) = semanage_user_exists_local(self.sh, k)
                if rc < 0:
                       raise ValueError(_("Could not check if SELinux user %s is defined") % name)
                if not exists:
@@ -810,7 +854,7 @@
 			low = int(ports[0])
 			high = int(ports[1])
 
-		(rc,k) = semanage_port_key_create(self.sh, low, high, proto_d)
+		(rc, k) = semanage_port_key_create(self.sh, low, high, proto_d)
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s/%s") % (proto, port))
 		return ( k, proto_d, low, high )
@@ -827,13 +871,13 @@
 
 		( k, proto_d, low, high ) = self.__genkey(port, proto)			
 
-		(rc,exists) = semanage_port_exists(self.sh, k)
+		(rc, exists) = semanage_port_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if port %s/%s is defined") % (proto, port))
 		if exists:
 			raise ValueError(_("Port %s/%s already defined") % (proto, port))
 
-		(rc,p) = semanage_port_create(self.sh)
+		(rc, p) = semanage_port_create(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not create port for %s/%s") % (proto, port))
 		
@@ -886,13 +930,13 @@
 
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 
-		(rc,exists) = semanage_port_exists(self.sh, k)
+		(rc, exists) = semanage_port_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if port %s/%s is defined") % (proto, port))
 		if not exists:
 			raise ValueError(_("Port %s/%s is not defined") % (proto,port))
 	
-		(rc,p) = semanage_port_query(self.sh, k)
+		(rc, p) = semanage_port_query(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not query port %s/%s") % (proto, port))
 
@@ -941,13 +985,13 @@
 
 	def __delete(self, port, proto):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
-		(rc,exists) = semanage_port_exists(self.sh, k)
+		(rc, exists) = semanage_port_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if port %s/%s is defined") % (proto, port))
 		if not exists:
 			raise ValueError(_("Port %s/%s is not defined") % (proto, port))
 		
-		(rc,exists) = semanage_port_exists_local(self.sh, k)
+		(rc, exists) = semanage_port_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if port %s/%s is defined") % (proto, port))
 		if not exists:
@@ -983,7 +1027,7 @@
 			proto_str = semanage_port_get_proto_str(proto)
 			low = semanage_port_get_low(port)
 			high = semanage_port_get_high(port)
-			ddict[(low, high)] = (ctype, proto_str, level)
+			ddict[(low, high, proto_str)] = (ctype, level)
 		return ddict
 
 	def get_all_by_type(self, locallist = 0):
@@ -1053,17 +1097,17 @@
                if ctype == "":
                        raise ValueError(_("SELinux Type is required"))
 
-               (rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+               (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
                if rc < 0:
                        raise ValueError(_("Could not create key for %s") % addr)
                if rc < 0:
                        raise ValueError(_("Could not check if addr %s is defined") % addr)
 
-               (rc,exists) = semanage_node_exists(self.sh, k)
+               (rc, exists) = semanage_node_exists(self.sh, k)
                if exists:
                        raise ValueError(_("Addr %s already defined") % addr)
 
-               (rc,node) = semanage_node_create(self.sh)
+               (rc, node) = semanage_node_create(self.sh)
                if rc < 0:
                        raise ValueError(_("Could not create addr for %s") % addr)
 
@@ -1128,17 +1172,17 @@
                if serange == "" and setype == "":
                        raise ValueError(_("Requires setype or serange"))
 
-               (rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+               (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
                if rc < 0:
                        raise ValueError(_("Could not create key for %s") % addr)
 
-               (rc,exists) = semanage_node_exists(self.sh, k)
+               (rc, exists) = semanage_node_exists(self.sh, k)
                if rc < 0:
                        raise ValueError(_("Could not check if addr %s is defined") % addr)
                if not exists:
                        raise ValueError(_("Addr %s is not defined") % addr)
 
-               (rc,node) = semanage_node_query(self.sh, k)
+               (rc, node) = semanage_node_query(self.sh, k)
                if rc < 0:
                        raise ValueError(_("Could not query addr %s") % addr)
 
@@ -1175,17 +1219,17 @@
                else:
                       raise ValueError(_("Unknown or missing protocol"))
 
-               (rc,k) = semanage_node_key_create(self.sh, addr, mask, proto)
+               (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
                if rc < 0:
                        raise ValueError(_("Could not create key for %s") % addr)
 
-               (rc,exists) = semanage_node_exists(self.sh, k)
+               (rc, exists) = semanage_node_exists(self.sh, k)
                if rc < 0:
                        raise ValueError(_("Could not check if addr %s is defined") % addr)
                if not exists:
                        raise ValueError(_("Addr %s is not defined") % addr)
 
-               (rc,exists) = semanage_node_exists_local(self.sh, k)
+               (rc, exists) = semanage_node_exists_local(self.sh, k)
                if rc < 0:
                        raise ValueError(_("Could not check if addr %s is defined") % addr)
                if not exists:
@@ -1255,17 +1299,17 @@
 		if ctype == "":
 			raise ValueError(_("SELinux Type is required"))
 
-		(rc,k) = semanage_iface_key_create(self.sh, interface)
+		(rc, k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
 			raise ValueError(_("Could not create key for %s") % interface)
 
-		(rc,exists) = semanage_iface_exists(self.sh, k)
+		(rc, exists) = semanage_iface_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if interface %s is defined") % interface)
 		if exists:
 			raise ValueError(_("Interface %s already defined") % interface)
 
-		(rc,iface) = semanage_iface_create(self.sh)
+		(rc, iface) = semanage_iface_create(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not create interface for %s") % interface)
 		
@@ -1316,17 +1360,17 @@
 		if serange == "" and setype == "":
 			raise ValueError(_("Requires setype or serange"))
 
-		(rc,k) = semanage_iface_key_create(self.sh, interface)
+		(rc, k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
 			raise ValueError(_("Could not create key for %s") % interface)
 
-		(rc,exists) = semanage_iface_exists(self.sh, k)
+		(rc, exists) = semanage_iface_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if interface %s is defined") % interface)
 		if not exists:
 			raise ValueError(_("Interface %s is not defined") % interface)
 	
-		(rc,iface) = semanage_iface_query(self.sh, k)
+		(rc, iface) = semanage_iface_query(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not query interface %s") % interface)
 
@@ -1350,17 +1394,17 @@
                 self.commit()
 
 	def __delete(self, interface):
-		(rc,k) = semanage_iface_key_create(self.sh, interface)
+		(rc, k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
 			raise ValueError(_("Could not create key for %s") % interface)
 
-		(rc,exists) = semanage_iface_exists(self.sh, k)
+		(rc, exists) = semanage_iface_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if interface %s is defined") % interface)
 		if not exists:
 			raise ValueError(_("Interface %s is not defined") % interface)
 
-		(rc,exists) = semanage_iface_exists_local(self.sh, k)
+		(rc, exists) = semanage_iface_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if interface %s is defined") % interface)
 		if not exists:
@@ -1408,6 +1452,48 @@
 class fcontextRecords(semanageRecords):
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
+                self.equiv = {}
+                self.equal_ind = False
+                try:
+                       fd = open(selinux.selinux_file_context_subs_path(), "r")
+                       for i in fd.readlines():
+                              src, dst = i.split()
+                              self.equiv[src] = dst
+                       fd.close()
+                except IOError:
+                       pass
+
+        def commit(self):
+                if self.equal_ind:
+                       subs_file = selinux.selinux_file_context_subs_path()
+                       tmpfile = "%s.tmp" % subs_file
+                       fd = open(tmpfile, "w")
+                       for src in self.equiv.keys():
+                              fd.write("%s %s\n" % (src, self.equiv[src]))
+                       fd.close()
+                       try:
+                              os.chmod(tmpfile, os.stat(subs_file)[stat.ST_MODE])
+                       except:
+                              pass
+                       os.rename(tmpfile,subs_file)
+                       self.equal_ind = False
+		semanageRecords.commit(self)
+
+        def add_equal(self, src, dst):
+                self.begin()
+                if src in self.equiv.keys():
+                       raise ValueError(_("Equivalence class for %s already exists") % src)
+                self.equiv[src] = dst
+                self.equal_ind = True
+                self.commit()
+
+        def modify_equal(self, src, dst):
+                self.begin()
+                if src not in self.equiv.keys():
+                       raise ValueError(_("Equivalence class for %s does not exists") % src)
+                self.equiv[src] = dst
+                self.equal_ind = True
+                self.commit()
 
         def createcon(self, target, seuser = "system_u"):
                 (rc, con) = semanage_context_create(self.sh)
@@ -1444,23 +1530,23 @@
 		if type == "":
 			raise ValueError(_("SELinux Type is required"))
 
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
+		(rc, k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:
 			raise ValueError(_("Could not create key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+		(rc, exists) = semanage_fcontext_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 
 		if not exists:
-                       (rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+                       (rc, exists) = semanage_fcontext_exists_local(self.sh, k)
                        if rc < 0:
                               raise ValueError(_("Could not check if file context for %s is defined") % target)
 
                 if exists:
                        raise ValueError(_("File context for %s already defined") % target)
 
-		(rc,fcontext) = semanage_fcontext_create(self.sh)
+		(rc, fcontext) = semanage_fcontext_create(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not create file context for %s") % target)
 		
@@ -1501,21 +1587,21 @@
 			raise ValueError(_("Requires setype, serange or seuser"))
                 self.validate(target)
 
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
+		(rc, k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+		(rc, exists) = semanage_fcontext_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 		if not exists:
-                       (rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+                       (rc, exists) = semanage_fcontext_exists_local(self.sh, k)
                        if not exists:
                               raise ValueError(_("File context for %s is not defined") % target)
 		
-		(rc,fcontext) = semanage_fcontext_query_local(self.sh, k)
+		(rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
 		if rc < 0:
-                       (rc,fcontext) = semanage_fcontext_query(self.sh, k)
+                       (rc, fcontext) = semanage_fcontext_query(self.sh, k)
                        if rc < 0:
                               raise ValueError(_("Could not query file context for %s") % target)
 
@@ -1565,7 +1651,7 @@
                        target = semanage_fcontext_get_expr(fcontext)
                        ftype = semanage_fcontext_get_type(fcontext)
                        ftype_str = semanage_fcontext_get_type_str(ftype)
-                       (rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype_str])
+                       (rc, k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype_str])
                        if rc < 0:
                               raise ValueError(_("Could not create a key for %s") % target)
 
@@ -1573,19 +1659,26 @@
                        if rc < 0:
                               raise ValueError(_("Could not delete the file context %s") % target)
                        semanage_fcontext_key_free(k)
-	
+
+                self.equiv = {}
+                self.equal_ind = True
                 self.commit()
 
 	def __delete(self, target, ftype):
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
+                if target in self.equiv.keys():
+                       self.equiv.pop(target)
+                       self.equal_ind = True
+                       return
+
+		(rc, k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+		(rc, exists) = semanage_fcontext_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 		if not exists:
-			(rc,exists) = semanage_fcontext_exists(self.sh, k)
+			(rc, exists) = semanage_fcontext_exists(self.sh, k)
 			if rc < 0:
 				raise ValueError(_("Could not check if file context for %s is defined") % target)
 			if exists:
@@ -1632,11 +1725,11 @@
 		return ddict
 			
 	def list(self, heading = 1, locallist = 0 ):
-		if heading:
-			print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
 		fcon_dict = self.get_all(locallist)
                 keys = fcon_dict.keys()
                 keys.sort()
+                if len(keys) > 0 and heading:
+			print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
 		for k in keys:
 			if fcon_dict[k]:
 				if is_mls_enabled:
@@ -1645,11 +1738,17 @@
 					print "%-50s %-18s %s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1],fcon_dict[k][2])
 			else:
 				print "%-50s %-18s <<None>>" % (k[0], k[1])
+                if len(self.equiv.keys()) > 0:
+                       if heading:
+                              print _("\nSELinux fcontext Equivalence \n")
+                       
+                       for src in self.equiv.keys():
+                              print "%s == %s" % (src, self.equiv[src])
 				
 class booleanRecords(semanageRecords):
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
-                self.dict={}
+                self.dict = {}
                 self.dict["TRUE"] = 1
                 self.dict["FALSE"] = 0
                 self.dict["ON"] = 1
@@ -1658,16 +1757,16 @@
                 self.dict["0"] = 0
 
 	def __mod(self, name, value):
-                (rc,k) = semanage_bool_key_create(self.sh, name)
+                (rc, k) = semanage_bool_key_create(self.sh, name)
                 if rc < 0:
                        raise ValueError(_("Could not create a key for %s") % name)
-                (rc,exists) = semanage_bool_exists(self.sh, k)
+                (rc, exists) = semanage_bool_exists(self.sh, k)
                 if rc < 0:
                        raise ValueError(_("Could not check if boolean %s is defined") % name)
                 if not exists:
                        raise ValueError(_("Boolean %s is not defined") % name)	
                 
-                (rc,b) = semanage_bool_query(self.sh, k)
+                (rc, b) = semanage_bool_query(self.sh, k)
                 if rc < 0:
                        raise ValueError(_("Could not query file context %s") % name)
 
@@ -1685,7 +1784,7 @@
 		semanage_bool_key_free(k)
 		semanage_bool_free(b)
 
-	def modify(self, name, value=None, use_file=False):
+	def modify(self, name, value = None, use_file = False):
                 
                 self.begin()
 
@@ -1709,16 +1808,16 @@
 		
 	def __delete(self, name):
 
-                (rc,k) = semanage_bool_key_create(self.sh, name)
+                (rc, k) = semanage_bool_key_create(self.sh, name)
                 if rc < 0:
                       raise ValueError(_("Could not create a key for %s") % name)
-		(rc,exists) = semanage_bool_exists(self.sh, k)
+		(rc, exists) = semanage_bool_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if boolean %s is defined") % name)
 		if not exists:
 			raise ValueError(_("Boolean %s is not defined") % name)
 	
-		(rc,exists) = semanage_bool_exists_local(self.sh, k)
+		(rc, exists) = semanage_bool_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if boolean %s is defined") % name)
 		if not exists:
@@ -1777,7 +1876,7 @@
                       return _("unknown")
 
 	def list(self, heading = True, locallist = False, use_file = False):
-                on_off = (_("off"),_("on")) 
+                on_off = (_("off"), _("on")) 
 		if use_file:
                        ddict = self.get_all(locallist)
                        keys = ddict.keys()

--------------060700020609050108000909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
