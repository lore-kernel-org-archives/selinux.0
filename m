Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m620prIJ029042
	for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2008 20:51:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m620pqhC021132
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2008 00:51:52 GMT
Message-ID: <486AD0C5.1070106@redhat.com>
Date: Tue, 01 Jul 2008 20:50:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch adds permissive to semanage
References: <4869037D.5040208@redhat.com> <48691EB3.30706@manicmethod.com>
In-Reply-To: <48691EB3.30706@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------090301030403020307000902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090301030403020307000902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
| Daniel J Walsh wrote:
|> Gives users the ability to set a domain as permissive
|>
|>
|> semanage permissive -a http_t
|>
|> It created a policy module named permissive_httpd_t.pp with the
|> permissive call.
|>
|
| So, a really quick glance brings up a couple issues. First you have
'-n', '--noheading' which aren't documented in the man page or
elsewhere. Second (and more importantly) why are you executing semodule
like that? libsemanage is the library that manages modules, and also the
library used by semanage for everything else.
|
| I would prefer a more 'pure' approach where we keep a list of
permissive types and inject them into the kernel policy after linking
(like libsemanage does with users, ports, nodes, etc) but I understand
that adding a whole new set of databases and interfaces is both annoying
and time consuming so I'm fine with it working on modules, I'd just like
to see it using libsemanage interfaces instead of calling semodule.
|
|
Rewrote patch to use libsemanage functions.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhq0MQACgkQrlYvE4MpobOg0ACgwl8+koyNS7ktbc2jplovEano
WZQAnj+ITOMlmeBuO/HTUXCS2m9Jcqj/
=/3Bu
-----END PGP SIGNATURE-----

--------------090301030403020307000902
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.50/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2008-05-06 14:33:04.000000000 -0400
+++ policycoreutils-2.0.50/semanage/semanage	2008-07-01 20:31:40.000000000 -0400
@@ -43,49 +43,52 @@
 if __name__ == '__main__':
 
 	def usage(message = ""):
-		print _('\
-semanage {boolean|login|user|port|interface|fcontext|translation} -{l|D} [-n] \n\
-semanage login -{a|d|m} [-sr] login_name\n\
-semanage user -{a|d|m} [-LrRP] selinux_name\n\
-semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range\n\
-semanage interface -{a|d|m} [-tr] interface_spec\n\
-semanage fcontext -{a|d|m} [-frst] file_spec\n\
-semanage translation -{a|d|m} [-T] level\n\n\
-semanage boolean -{d|m} boolean\n\n\
-\
-Primary Options:\n\
-\
-	-a, --add        Add a OBJECT record NAME\n\
-	-d, --delete     Delete a OBJECT record NAME\n\
-	-m, --modify     Modify a OBJECT record NAME\n\
-	-l, --list       List the OBJECTS\n\n\
-	-C, --locallist  List OBJECTS local customizations\n\n\
-	-D, --deleteall  Remove all OBJECTS local customizations\n\
-\
-	-h, --help       Display this message\n\
-	-n, --noheading  Do not print heading when listing OBJECTS\n\
-        -S, --store      Select and alternate SELinux store to manage\n\n\
-Object-specific Options (see above):\n\
-	-f, --ftype      File Type of OBJECT \n\
-		"" (all files) \n\
-		-- (regular file) \n\
-		-d (directory) \n\
-		-c (character device) \n\
-		-b (block device) \n\
-		-s (socket) \n\
-		-l (symbolic link) \n\
-		-p (named pipe) \n\n\
-\
-	-p, --proto      Port protocol (tcp or udp)\n\
-	-P, --prefix     Prefix for home directory labeling\n\
-	-L, --level      Default SELinux Level (MLS/MCS Systems only)\n\
-	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")\n\
-	-T, --trans      SELinux Level Translation (MLS/MCS Systems only)\n\n\
-\
-	-s, --seuser     SELinux User Name\n\
-	-t, --type       SELinux Type for the object\n\
-	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only)\n\
-')
+		print _("""
+semanage {boolean|login|user|port|interface|fcontext|translation} -{l|D} [-n] 
+semanage login -{a|d|m} [-sr] login_name
+semanage user -{a|d|m} [-LrRP] selinux_name
+semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
+semanage interface -{a|d|m} [-tr] interface_spec
+semanage fcontext -{a|d|m} [-frst] file_spec
+semanage translation -{a|d|m} [-T] level
+semanage boolean -{d|m} boolean
+semanage permissive -{d|a} type
+
+Primary Options:
+
+	-a, --add        Add a OBJECT record NAME
+	-d, --delete     Delete a OBJECT record NAME
+	-m, --modify     Modify a OBJECT record NAME
+	-l, --list       List the OBJECTS
+	-C, --locallist  List OBJECTS local customizations
+	-D, --deleteall  Remove all OBJECTS local customizations
+
+	-h, --help       Display this message
+	-n, --noheading  Do not print heading when listing OBJECTS
+        -S, --store      Select and alternate SELinux store to manage
+
+Object-specific Options (see above):
+
+	-f, --ftype      File Type of OBJECT 
+		"" (all files) 
+		-- (regular file) 
+		-d (directory) 
+		-c (character device) 
+		-b (block device) 
+		-s (socket) 
+		-l (symbolic link) 
+		-p (named pipe) 
+
+	-p, --proto      Port protocol (tcp or udp)
+	-P, --prefix     Prefix for home directory labeling
+	-L, --level      Default SELinux Level (MLS/MCS Systems only)
+	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")
+	-T, --trans      SELinux Level Translation (MLS/MCS Systems only)
+
+	-s, --seuser     SELinux User Name
+	-t, --type       SELinux Type for the object
+	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only)
+""")
 		print message
 		sys.exit(1)
 		
@@ -112,6 +115,8 @@
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
 		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0" ] 
+		valid_option["permissive"] = []
+		valid_option["permissive"] += [ '-a', '--add', '-d', '--delete', '-l', '--list', '-h', '--help', '-n', '--noheading', '-D', '--deleteall' ]
 		return valid_option
 
 	#
@@ -266,6 +271,9 @@
 		if object == "translation":
 			OBJECT = seobject.setransRecords()
 		
+		if object == "permissive":
+			OBJECT = seobject.permissiveRecords(store)
+		
 		if list:
 			OBJECT.list(heading, locallist)
 			sys.exit(0);
@@ -302,6 +310,9 @@
 
 			if object == "fcontext":
 				OBJECT.add(target, setype, ftype, serange, seuser)
+			if object == "permissive":
+				OBJECT.add(target)
+
 			sys.exit(0);
 			
 		if modify:
diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-2.0.50/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2008-05-06 14:33:04.000000000 -0400
+++ policycoreutils-2.0.50/semanage/semanage.8	2008-07-01 20:33:48.000000000 -0400
@@ -3,7 +3,7 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|lC|D} [\-n] 
+.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] [\-S store] 
 .br
 .B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] boolean
 .br
@@ -17,6 +17,8 @@
 .br
 .B semanage fcontext \-{a|d|m} [\-frst] file_spec
 .br
+.B semanage permissive \-{a|d} type
+.br
 .B semanage translation \-{a|d|m} [\-T] level
 .P
 
@@ -85,6 +87,9 @@
 .I                \-s, \-\-seuser     
 SELinux user name
 .TP
+.I                \-S, \-\-store
+Select and alternate SELinux store to manage
+.TP
 .I                \-t, \-\-type       
 SELinux Type for the object
 .TP
@@ -101,10 +106,11 @@
 $ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
 # Allow Apache to listen on port 81
 $ semanage port -a -t http_port_t -p tcp 81
+# Change apache to a permissive domain
+$ semanage permissive -a http_t
 .fi
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com> and
 Russell Coker <rcoker@redhat.com>.
 Examples by Thomas Bleher <ThomasBleher@gmx.de>.
-
diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.50/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-05-16 10:55:38.000000000 -0400
+++ policycoreutils-2.0.50/semanage/seobject.py	2008-07-01 20:30:55.000000000 -0400
@@ -1,5 +1,5 @@
 #! /usr/bin/python -E
-# Copyright (C) 2005, 2006, 2007 Red Hat 
+# Copyright (C) 2005, 2006, 2007, 2008 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
 # semanage is a tool for managing SELinux configuration files
@@ -24,7 +24,9 @@
 import pwd, string, selinux, tempfile, os, re, sys
 from semanage import *;
 PROGNAME="policycoreutils"
+import sepolgen.module as module
 
+import commands
 import gettext
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
@@ -246,7 +248,103 @@
 		os.close(fd)
 		os.rename(newfilename, self.filename)
                 os.system("/sbin/service mcstrans reload > /dev/null")
-                
+
+class permissiveRecords:
+	def __init__(self, store):
+               self.store = store
+               self.sh = semanage_handle_create()
+               if not self.sh:
+                      raise ValueError(_("Could not create semanage handle"))
+               
+               if store != "":
+                      semanage_select_store(self.sh, store, SEMANAGE_CON_DIRECT);
+                      
+               self.semanaged = semanage_is_managed(self.sh)
+               
+               if not self.semanaged:
+                      semanage_handle_destroy(self.sh)
+                      raise ValueError(_("SELinux policy is not managed or store cannot be accessed."))
+
+               rc = semanage_access_check(self.sh)
+               if rc < SEMANAGE_CAN_READ:
+                      semanage_handle_destroy(self.sh)
+                      raise ValueError(_("Cannot read policy store."))
+
+               rc = semanage_connect(self.sh)
+               if rc < 0:
+                      semanage_handle_destroy(self.sh)
+                      raise ValueError(_("Could not establish semanage connection"))
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
+                      if name and name.startswith("permissive_"):
+                             l.append(name.split("permissive_")[1])
+               return l
+
+	def list(self,heading = 1, locallist = 0):
+		if heading:
+			print "\n%-25s\n" % (_("Permissive Types"))
+                for t in self.get_all():
+                       print t
+
+
+	def add(self, type):
+               name = "permissive_%s" % type
+               dirname = "/var/lib/selinux"
+               os.chdir(dirname)
+               filename = "%s.te" % name
+               modtxt = """
+module %s 1.0;
+
+require {
+          type %s;
+}
+
+permissive %s;
+""" % (name, type, type)
+               fd = open(filename,'w')
+               fd.write(modtxt)
+               fd.close()
+               mc = module.ModuleCompiler()
+               mc.create_module_package(filename, 1)
+               fd = open("permissive_%s.pp" % type)
+               data = fd.read()
+               fd.close()
+
+               rc = semanage_module_install(self.sh, data, len(data));
+               rc = semanage_commit(self.sh)
+               if rc < 0:
+			raise ValueError(_("Could not set permissive domain %s") % name)
+               for root, dirs, files in os.walk("tmp", topdown=False):
+                      for name in files:
+                             os.remove(os.path.join(root, name))
+                      for name in dirs:
+                             os.rmdir(os.path.join(root, name))
+
+               if rc != 0:
+                      raise ValueError(out)			
+
+
+	def delete(self, name):
+               for n in name.split():
+                      rc = semanage_module_remove(self.sh, "permissive_%s" % n)
+               rc = semanage_commit(self.sh)
+               if rc < 0:
+			raise ValueError(_("Could not remove permissive domain %s") % name)
+
+	def deleteall(self):
+               l = self.get_all()
+               if len(l) > 0:
+                      all = " ".join(l)
+                      self.delete(all)
+
 class semanageRecords:
 	def __init__(self, store):
 		self.sh = semanage_handle_create()
@@ -464,7 +562,7 @@
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
 
-	def add(self, name, roles, selevel, serange, prefix):
+	def add(self, name, roles, selevel, serange, prefix = "user"):
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"

--------------090301030403020307000902
Content-Type: application/pgp-signature;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff.sig"

iEYEABECAAYFAkhq0MQACgkQrlYvE4MpobMSuACeMrHHlTr/TX6nlN4ELDVMhaONwvIAn1qU
2eceRsi/C9iXMbPDY3AMWWjZ
--------------090301030403020307000902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
