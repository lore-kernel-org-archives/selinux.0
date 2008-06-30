Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UG37Xm017613
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:03:07 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5UG36dv002174
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 16:03:06 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5UG2645029240
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:02:06 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5UG25r7012710
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:02:05 -0400
Received: from localhost.localdomain (dhcp-10-16-61-233.boston.devel.redhat.com [10.16.61.233])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5UG24XG032734
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:02:05 -0400
Message-ID: <4869037D.5040208@redhat.com>
Date: Mon, 30 Jun 2008 12:02:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: This patch adds permissive to semanage
Content-Type: multipart/mixed;
 boundary="------------080502040904080608080508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080502040904080608080508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gives users the ability to set a domain as permissive


semanage permissive -a http_t

It created a policy module named permissive_httpd_t.pp with the
permissive call.


--------------080502040904080608080508
Content-Type: text/plain;
 name="permissive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="permissive.patch"

--- nsapolicycoreutils/semanage/semanage	2008-06-12 23:25:21.000000000 -0400
+++ policycoreutils-2.0.50/semanage/semanage	2008-06-30 11:49:38.000000000 -0400
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
--- nsapolicycoreutils/semanage/semanage.8	2008-06-12 23:25:21.000000000 -0400
+++ policycoreutils-2.0.50/semanage/semanage.8	2008-06-30 11:49:38.000000000 -0400
@@ -17,6 +17,8 @@
 .br
 .B semanage fcontext \-{a|d|m} [\-frst] file_spec
 .br
+.B semanage permissive \-{a|d} type
+.br
 .B semanage translation \-{a|d|m} [\-T] level
 .P
 
@@ -101,10 +103,11 @@
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
--- nsapolicycoreutils/semanage/seobject.py	2008-06-12 23:25:21.000000000 -0400
+++ policycoreutils-2.0.50/semanage/seobject.py	2008-06-30 11:49:38.000000000 -0400
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
@@ -246,7 +248,67 @@
 		os.close(fd)
 		os.rename(newfilename, self.filename)
                 os.system("/sbin/service mcstrans reload > /dev/null")
-                
+
+class permissiveRecords:
+	def __init__(self, store):
+               self.store = store
+
+	def get_all(self):
+               rc, out = commands.getstatusoutput("semodule -l | grep ^permissive");
+               l = []
+               for i in out.split():
+                      if i.startswith("permissive_"):
+                             l.append(i.split("permissive_")[1])
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
+               rc, out = commands.getstatusoutput("semodule -i permissive_%s.pp" % type);
+               for root, dirs, files in os.walk("top", topdown=False):
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
+               rc, out = commands.getstatusoutput("semodule -r permissive_%s" % name );
+               if rc != 0:
+                      raise ValueError(out)			
+
+	def deleteall(self):
+               l = self.get_all()
+               if len(l) > 0:
+                      all = " permissive_".join(l)
+                      self.delete(all)
+
 class semanageRecords:
 	def __init__(self, store):
 		self.sh = semanage_handle_create()
@@ -464,7 +526,7 @@
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
 
-	def add(self, name, roles, selevel, serange, prefix):
+	def add(self, name, roles, selevel, serange, prefix = "user"):
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"

--------------080502040904080608080508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
