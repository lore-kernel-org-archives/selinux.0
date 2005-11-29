Message-ID: <438C68D6.4040505@redhat.com>
Date: Tue, 29 Nov 2005 09:42:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to fix up sestatus, audit2allow and first version of semanage
Content-Type: multipart/mixed;
 boundary="------------020802060909030606020900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020802060909030606020900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 



--------------020802060909030606020900
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.27.29/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2005-11-28 21:47:54.000000000 -0500
+++ policycoreutils-1.27.29/audit2allow/audit2allow	2005-11-29 00:04:31.000000000 -0500
@@ -24,7 +24,7 @@
 #                                        02111-1307  USA
 #
 #  
-import commands, sys, os, pwd, string, getopt, re
+import commands, sys, os, pwd, string, getopt, re, selinux
 class allow:
 	def __init__(self, source, target, seclass):
 		self.source=source
@@ -81,6 +81,11 @@
 		self.roles=[]
 		self.load(input)
 		
+	def warning(self, error):
+		sys.stderr.write("%s: " % sys.argv[0])
+		sys.stderr.write("%s\n" % error)
+		sys.stderr.flush()
+
 	def load(self, input):
 		avc=[]
 		found=0
@@ -114,43 +119,47 @@
 			if "load_policy" in avc and self.last_reload:
 				self.allowRules={}
 			return
-		for i in range (0, len(avc)):
-			if avc[i]=="{":
-				i=i+1
-				while i<len(avc) and avc[i] != "}":
-					access.append(avc[i])
+		try:
+			for i in range (0, len(avc)):
+				if avc[i]=="{":
 					i=i+1
-				continue
+					while i<len(avc) and avc[i] != "}":
+						access.append(avc[i])
+						i=i+1
+					continue
 			
-			t=avc[i].split('=')
-			if len(t) < 2:
-				continue
-			if t[0]=="scontext":
-				context=t[1].split(":")
-				scon=context[2]
-				srole=context[1]
-				continue
-			if t[0]=="tcontext":
-				context=t[1].split(":")
-				tcon=context[2]
-				trole=context[1]
-				continue
-			if t[0]=="tclass":
-				seclass=t[1]
-				continue
-			if t[0]=="comm":
-				comm=t[1]
-				continue
-			if t[0]=="name":
-				name=t[1]
-				continue
-			if t[0]=="msg":
-				msg=t[1]
-				continue
-
-		if scon=="" or tcon =="" or seclass=="":
+				t=avc[i].split('=')
+				if len(t) < 2:
+					continue
+				if t[0]=="scontext":
+					context=t[1].split(":")
+					scon=context[2]
+					srole=context[1]
+					continue
+				if t[0]=="tcontext":
+					context=t[1].split(":")
+					tcon=context[2]
+					trole=context[1]
+					continue
+				if t[0]=="tclass":
+					seclass=t[1]
+					continue
+				if t[0]=="comm":
+					comm=t[1]
+					continue
+				if t[0]=="name":
+					name=t[1]
+					continue
+				if t[0]=="msg":
+					msg=t[1]
+					continue
+
+			if scon=="" or tcon =="" or seclass=="":
+				return
+		except IndexError, e:
+			self.warning("Bad AVC Line: %s" % avc)
 			return
-
+			
 		self.add_seclass(seclass, access)
 		self.add_type(tcon)
 		self.add_type(scon)
@@ -220,6 +229,12 @@
 
 if __name__ == '__main__':
 
+	def get_mls_flag():
+		if selinux.is_selinux_mls_enabled():
+			return "-M"
+		else:
+			return ""
+
 	def usage():
 		print 'audit2allow [-adhilrv] [-i <inputfile> ] [[-m|-M] <modulename> ] [-o <outputfile>]\n\
 		-a, --all        read input from audit and message log, conflicts with -i\n\
@@ -313,15 +328,17 @@
 		if buildPP:
 			print ("Generating type enforcment file: %s.te" % module)
 		output.write(out.out(requires, module))
+		output.flush()
 		if buildPP:
-			print ("Compiling policy: checkmodule -M -m -o %s.mod %s.te" % (module, module))
-			rc=commands.getstatusoutput("checkmodule -M -m -o %s.mod %s.te" % (module, module))
+			cmd="checkmodule %s -m -o %s.mod %s.te" % (get_mls_flag(), module, module)
+			print "Compiling policy: %s" % cmd
+			rc=commands.getstatusoutput(cmd)
 			if rc[0]==0:
 				print ("Building package: semodule_package -o %s.pp -m %s.mod" % (module, module))
 				rc=commands.getstatusoutput("semodule_package -o %s.pp -m %s.mod" % (module, module))
 				if rc[0]==0:
-					print ("\n*************** IMPORTANT ***********************\n")
-					print ("In order to load this newly created policy package,\nyou are required to execute \n\n\"semodule -i %s.pp\"\n\nto load the policy\n" % module)
+					print ("\n******************** IMPORTANT ***********************\n")
+					print ("In order to load this newly created policy package into the kernel,\nyou are required to execute \n\nsemodule -i %s.pp\n\n" % module)
 				else:
 					errorExit(rc[1])
 			else:
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow.1 policycoreutils-1.27.29/audit2allow/audit2allow.1
--- nsapolicycoreutils/audit2allow/audit2allow.1	2005-09-12 16:33:30.000000000 -0400
+++ policycoreutils-1.27.29/audit2allow/audit2allow.1	2005-11-29 00:04:31.000000000 -0500
@@ -30,26 +30,38 @@
 .RI [ options "] "
 .SH OPTIONS
 .TP
-.B "\-\-help"
+.B "\-a" | "\-\-all"
+Read input from audit and message log, conflicts with -i
+.TP
+.B "\-h" | "\-\-help"
 Print a short usage message
 .TP
-.B "\-d"
+.B "\-d" | "\-\-dmesg"
 Read input from output of 
 .I /bin/dmesg.
 Note that audit messages are not available via dmesg when
 auditd is running; use -i /var/log/audit/audit.log instead.
 .TP
-.B "\-v"
+.B "\-v" | "\-\-verbose"
 Turn on verbose output
 .TP
-.B "\-l"
+.B "\-l" | "\-\-lastreload"
 read input only after last policy reload
 .TP
-.B "\-i <inputfile>"
+.B "\-r" | "\-\-requires"
+Generate require output syntax for loadable modules.
+.TP
+.B "\-m <modulename>" | "\-\-module <modulename>"
+Generate module/require output <modulename>
+.TP
+.B "\-M <modulename>" 
+Generate loadable module package, conflicts with -o
+.TP
+.B "\-i  <inputfile>" | "\-\-input <inputfile>"
 read input from 
 .I <inputfile>
 .TP
-.B "\-o <outputfile>"
+.B "\-o <outputfile>"  | "\-\-output <outputfile>"
 append output to 
 .I <outputfile>
 .SH DESCRIPTION
@@ -76,18 +88,66 @@
 .PP
 .SH EXAMPLE
 .nf
-$ cd /etc/selinux/$(SELINUXTYPE)/src/policy
-$ /usr/bin/audit2allow -i < /var/log/audit/audit.log >> domains/misc/local.te
-<review domains/misc/local.te and customize as desired>
-$ make load
+.B Traditional Syntax
+cat /var/log/audit/audit.log.1 | audit2allow
+allow cupsd_config_t unconfined_t:fifo_file { getattr ioctl };
+
+
+.B Using audit2allow to generate module syntax
+
+$ cat /var/log/audit/audit.log | audit2allow -m local
+module local 1.0;
+
+require {
+        role system_r;
+
+
+        class fifo_file {  getattr ioctl };
+
+
+        type cupsd_config_t;
+        type unconfined_t;
+ };
+
+
+allow cupsd_config_t unconfined_t:fifo_file { getattr ioctl };
+
+.B Building a loadable module
+
+$ /usr/bin/audit2allow -m local -i /var/log/audit/audit.log >> local.te
+<review local.te and customize as desired>
+# Compile the module
+$ checkmodule -M -m -o local.mod local.te
+# Create the package 
+$ semodule_package -o local.pp -m local.mod
+# Load the module into the kernel
+$ semodule -i local.mod
+
+.B Building a loadable module automatically
+$ cat /var/log/audit/audit.log | audit2allow -M local
+Generating type enforcment file: local.te
+Compiling policy: checkmodule -M -m -o local.mod local.te
+Building package: semodule_package -o local.pp -m local.mod
+
+******************** IMPORTANT ***********************
+
+In order to load this newly created policy package into the kernel,
+you are required to execute
+
+semodule -i local.pp
+
 .fi
 .PP
 .SH AUTHOR
 This manual page was written by 
 .I Manoj Srivastava <srivasta@debian.org>,
-for the Debian GNU/Linux system. The 
+for the Debian GNU/Linux system. It was updated by Dan Walsh <dwalsh@redhat.com>
+.PP
+The 
 .B audit2allow
 utility has contributions from several people, including 
 .I Justin R. Smith 
 and 
 .I Yuichi Nakamura.
+and 
+.I Dan Walsh
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/Makefile policycoreutils-1.27.29/Makefile
--- nsapolicycoreutils/Makefile	2005-11-07 09:41:21.000000000 -0500
+++ policycoreutils-1.27.29/Makefile	2005-11-29 00:04:31.000000000 -0500
@@ -1,4 +1,4 @@
-SUBDIRS=setfiles load_policy newrole run_init restorecon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand setsebool po
+SUBDIRS=setfiles semanage load_policy newrole run_init restorecon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand setsebool po
 
 all install relabel clean: 
 	@for subdir in $(SUBDIRS); do \
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/Makefile policycoreutils-1.27.29/semanage/Makefile
--- nsapolicycoreutils/semanage/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.29/semanage/Makefile	2005-11-29 00:04:31.000000000 -0500
@@ -0,0 +1,19 @@
+# Installation directories.
+PREFIX ?= ${DESTDIR}/usr
+SBINDIR ?= $(PREFIX)/sbin
+MANDIR = $(PREFIX)/share/man
+
+TARGETS=semanage
+
+all: $(TARGETS)
+
+install: all
+	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
+	-mkdir -p $(SBINDIR)
+	install -m 755 semanage $(SBINDIR)
+	install -m 644 semanage.8 $(MANDIR)/man8
+
+clean:
+	rm -f semanage
+
+relabel:
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-1.27.29/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.29/semanage/semanage	2005-11-29 00:04:52.000000000 -0500
@@ -0,0 +1,377 @@
+#! /usr/bin/env python
+# Copyright (C) 2005 Red Hat 
+# see file 'COPYING' for use and warranty information
+#
+# semanage is a tool for managing SELinux configuration files
+#
+#    This program is free software; you can redistribute it and/or
+#    modify it under the terms of the GNU General Public License as
+#    published by the Free Software Foundation; either version 2 of
+#    the License, or (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License
+#    along with this program; if not, write to the Free Software
+#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA     
+#                                        02111-1307  USA
+#
+#  
+import commands, sys, os, pwd, string, getopt, pwd
+from semanage import *;
+class loginRecords:
+	def __init__(self):
+		self.sh=semanage_handle_create()
+		self.semanaged=semanage_is_managed(self.sh)
+		if self.semanaged:
+			semanage_connect(self.sh)
+
+	def add(self, name, sename, serange):
+		(rc,k)=semanage_seuser_key_create(self.sh, name)
+		(rc,exists)= semanage_seuser_exists(self.sh, k)
+		if exists:
+			raise ValueError("SELinux User %s mapping already defined" % name)
+		try:
+			pwd.getpwname(name)
+		except:
+			raise ValueError("Linux User %s does not exist" % name)
+			
+		(rc,u)= semanage_seuser_create(self.sh)
+		semanage_seuser_set_name(self.sh, u, name)
+		semanage_seuser_set_mlsrange(self.sh, u, serange)
+		semanage_seuser_set_sename(self.sh, u, sename)
+		semanage_begin_transaction(self.sh)
+		semanage_seuser_add(self.sh, k, u)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Failed to add SELinux user mapping")
+
+	def modify(self, name, sename="", serange=""):
+		(rc,k)=semanage_seuser_key_create(self.sh, name)
+		(rc,u)= semanage_seuser_query(self.sh, k)
+		if rc !=0 :
+			raise ValueError("SELinux user %s mapping is not defined." % name)
+		if sename == "" and serange=="":
+			raise ValueError("Requires, seuser or serange")
+		if serange != "":
+			semanage_seuser_set_mlsrange(self.sh, u, serange)
+		if sename != "":
+			semanage_seuser_set_sename(self.sh, u, sename)
+		semanage_begin_transaction(self.sh)
+		semanage_seuser_modify(self.sh, k, u)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Failed to modify SELinux user mapping")
+
+		
+	def delete(self, name):
+		(rc,k)=semanage_seuser_key_create(self.sh, name)
+		(rc,exists)= semanage_seuser_exists(self.sh, k)
+		if rc !=0 :
+			raise ValueError("SELinux user %s mapping is not defined." % name)
+		semanage_begin_transaction(self.sh)
+		semanage_seuser_del(self.sh, k)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("SELinux User %s mapping not defined" % name)
+		
+	def list(self):
+		print "\n%-25s %-25s %-25s\n" % ("Login Name", "SELinux User", "MLS/MCS Range")
+		(status, self.ulist, self.usize) = semanage_seuser_list(self.sh)
+		for idx in range(self.usize):
+			u=semanage_seuser_by_idx(self.ulist, idx)
+			name=semanage_seuser_get_name(u)
+			
+			print "%-25s %-25s %-25s" % (name, semanage_seuser_get_sename(u), semanage_seuser_get_mlsrange(u))
+
+class seluserRecords:
+	def __init__(self):
+		roles=[]
+		self.sh=semanage_handle_create()
+		self.semanaged=semanage_is_managed(self.sh)
+		if self.semanaged:
+			semanage_connect(self.sh)
+
+	def add(self, name, roles, selevel, serange):
+		(rc,k)=semanage_user_key_create(self.sh, name)
+		(rc,exists)= semanage_user_exists(self.sh, k)
+		if exists:
+			raise ValueError("Seuser %s already defined" % name)
+		(rc,u)= semanage_user_create(self.sh)
+		semanage_user_set_name(self.sh, u, name)
+		for r in roles:
+			semanage_user_add_role(self.sh, u, r)
+		semanage_user_set_mlsrange(self.sh, u, serange)
+		semanage_user_set_mlslevel(self.sh, u, selevel)
+		(rc,key) = semanage_user_key_extract(self.sh,u)
+		semanage_begin_transaction(self.sh)
+		semanage_user_add_local(self.sh, k, u)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Failed to add SELinux user")
+
+		self.dict[name]=seluser(name, roles, selevel, serange)
+		
+	def modify(self, name, roles=[], selevel="", serange=""):
+		(rc,k)=semanage_user_key_create(self.sh, name)
+		(rc,exists)= semanage_user_exists(self.sh, k)
+		if not exists:
+			raise ValueError("user %s is not defined" % name)
+		(rc,u)= semanage_user_query(self.sh, k)
+		if rc !=0 :
+			raise ValueError("User %s is not defined." % name)
+		if len(roles) == 0  and serange=="" and selevel=="":
+			raise ValueError("Requires, roles, level  or range")
+		if serange != "":
+			semanage_user_set_mlsrange(self.sh, u, serange)
+		if selevel != "":
+			semanage_user_set_mlslevel(self.sh, u, selevel)
+		if len(roles) != 0:
+			for r in roles:
+				print r
+				semanage_user_add_role(self.sh, u, r)
+		semanage_begin_transaction(self.sh)
+		semanage_user_modify_local(self.sh, k, u)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Failed to modify SELinux user")
+
+		
+	def delete(self, name):
+		(rc,k)=semanage_user_key_create(self.sh, name)
+		(rc,exists)= semanage_user_exists(self.sh, k)
+		if not exists:
+			raise ValueError("user %s is not defined" % name)
+		semanage_begin_transaction(self.sh)
+		semanage_user_del_local(self.sh, k)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Login User %s not defined" % name)
+		
+	def list(self):
+		print "\n%-15s %-10s %-20s" % ("", "MLS/", "MLS/")
+		print "%-15s %-10s %-15s %-20s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
+		(status, self.ulist, self.usize) = semanage_user_list(self.sh)
+		for idx in range(self.usize):
+			u=semanage_user_by_idx(self.ulist, idx)
+			name=semanage_user_get_name(u)
+			(status, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
+			roles=""
+
+			if rlist_size:
+				roles+=char_by_idx(rlist, 0)
+				for ridx in range (1,rlist_size):
+					roles+=" " + char_by_idx(rlist, ridx)
+			print "%-15s %-10s %-15s %s" % (semanage_user_get_name(u), semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
+
+class portRecords:
+	def __init__(self):
+		self.dict={}
+		self.sh=semanage_handle_create()
+		self.semanaged=semanage_is_managed(self.sh)
+		if self.semanaged:
+			semanage_connect(self.sh)
+
+	def add(self, name, type):
+		(rc,k)=semanage_port_key_create(self.sh, name)
+		(rc,exists)= semanage_port_exists(self.sh, k)
+		if exists:
+			raise ValueError("User %s already defined" % name)
+		(rc,u)= semanage_port_create(self.sh)
+		semanage_port_set_name(self.sh, u, name)
+		semanage_port_set_mlsrange(self.sh, u, serange)
+		semanage_port_set_sename(self.sh, u, sename)
+		semanage_begin_transaction(self.sh)
+		semanage_port_add(self.sh, k, u)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Failed to add port")
+
+	def modify(self, name, type):
+		(rc,k)=semanage_port_key_create(self.sh, name)
+		(rc,u)= semanage_port_query(self.sh, k)
+		if rc !=0 :
+			raise ValueError("User %s is not defined." % name)
+		if sename == "" and serange=="":
+			raise ValueError("Requires, port or serange")
+		if serange != "":
+			semanage_port_set_mlsrange(self.sh, u, serange)
+		if sename != "":
+			semanage_port_set_sename(self.sh, u, sename)
+		semanage_begin_transaction(self.sh)
+		semanage_port_modify(self.sh, k, u)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Failed to add port")
+		
+	def delete(self, name):
+		(rc,k)=semanage_port_key_create(self.sh, name)
+		semanage_begin_transaction(self.sh)
+		semanage_port_del(self.sh, k)
+		if semanage_commit(self.sh) != 0:
+			raise ValueError("Port %s not defined" % name)
+		
+	def list(self):
+		(status, self.plist, self.psize) = semanage_port_list(self.sh)
+		print "%-25s %s\n" % ("SELinux Port Name", "Port Number")
+		for idx in range(self.psize):
+			u=semanage_port_by_idx(self.plist, idx)
+			name=semanage_port_get_name(u)
+			print "%20s %d" % ( name, semanage_port_get_number(u))
+			
+if __name__ == '__main__':
+
+	def usage(message=""):
+		print '\
+semanage user [-admsRrh] SELINUX_USER\n\
+semanage login [-admsrh] LOGIN_NAME\n\
+semanage port [-admth] SELINUX_PORT_NAME\n\
+	-a, --add        Add a OBJECT record NAME\n\
+	-d, --delete     Delete a OBJECT record NAME\n\
+	-h, --help       display this message\n\
+	-l, --list       List the OBJECTS\n\
+	-m, --modify     Modify a OBJECT record NAME\n\
+	-r, --range      MLS/MCS Security Range\n\
+	-R, --roles      SELinux Roles (Separate by spaces)\n\
+	-s, --seuser     SELinux user name\n\
+	-t, --type       SELinux Type for the object\n\
+	-v, --verbose    verbose output\n\
+'
+		print message
+		sys.exit(1)
+		
+	def errorExit(error):
+		sys.stderr.write("%s: " % sys.argv[0])
+		sys.stderr.write("%s\n" % error)
+		sys.stderr.flush()
+		sys.exit(1)
+
+	#
+	# 
+	#
+	try:
+		objectlist=("login", "user", "port")
+		input=sys.stdin
+		output=sys.stdout
+		serange="s0"
+		selevel="s0"
+		roles=""
+		seuser=""
+		type=""
+		add=0
+		modify=0
+		delete=0
+		list=0
+		if len(sys.argv) < 3:
+			usage("Requires 2 or more arguments")
+			
+		object=sys.argv[1]
+		if object not in objectlist:
+			usage("%s not defined" % object)
+			
+		args=sys.argv[2:]
+		gopts, cmds = getopt.getopt(args,
+					    'adlhms:R:r:t:v',
+					    ['add',
+					     'delete',
+					     'help',
+					     'list', 
+					     'modify',
+					     'seuser=',
+					     'range=',
+					     'roles=',
+					     'type=',
+					     'verbose'
+					     ])
+		for o,a in gopts:
+			if o == "-a" or o == "--add":
+				if modify or delete:
+					usage()
+				add=1
+				
+			if o == "-d"  or o == "--delese":
+				if modify or add:
+					usage()
+				delete=1
+			if o == "-h" or o == "--help":
+				usage()
+
+			if o == "-m"or o == "--modify":
+				if delete or add:
+					usage()
+				modify=1
+				
+			if o == "-r" or o == '--range':
+				serange=a
+
+			if o == "-R" or o == '--roles':
+				roles=a
+
+			if o == "-t" or o == "--type":
+				type=a
+
+			if o == "-l" or o == "--list":
+				list=1
+
+			if o == "-s" or o == "--seuser":
+				seuser=a
+
+			if o == "-v" or o == "--verbose":
+				verbose=1
+
+		if object == "login":
+			OBJECT=loginRecords()
+
+		if object == "user":
+			OBJECT=seluserRecords()
+
+		if object == "port":
+			OBJECT=portRecords()
+		
+		if list:
+			OBJECT.list()
+			sys.exit(0);
+			
+		if len(cmds) != 1:
+			usage()
+
+		name=cmds[0]
+
+		if add:
+			if object == "login":
+				OBJECT.add(name, seuser, serange)
+
+			if object == "user":
+				rlist=roles.split()
+				print rlist
+				OBJECT.add(name, rlist, selevel, serange)
+
+			if object == "port":
+				OBJECT.add(name, type)
+
+			OBJECT.list()
+			sys.exit(0);
+			
+		if modify:
+			if object == "login":
+				OBJECT.modify(name, seuser, serange)
+
+			if object == "user":
+				rlist=roles.split()
+				print rlist
+				OBJECT.modify(name, rlist, selevel, serange)
+
+			if object == "port":
+				OBJECT.modify(name, type)
+				sys.exit(0);
+			OBJECT.list()
+			sys.exit(0);
+
+		if delete:
+			OBJECT.delete(name)
+			sys.exit(0);
+		usage()
+			
+	except getopt.error, error:
+		errorExit("Options Error " + error.msg)
+	except ValueError, error:
+		errorExit(error.args[0])
+	except IOError, error:
+		errorExit(error.args[1])
+	except KeyboardInterrupt, error:
+		sys.exit(0)
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.27.29/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.29/semanage/semanage.8	2005-11-29 00:04:31.000000000 -0500
@@ -0,0 +1,57 @@
+.TH "semanage" "8" "2005111103" "" ""
+.SH "NAME"
+semanage \- SELinux Policy Management tool
+
+.SH "SYNOPSIS"
+.B semanage OBJECTTYPE [\-admsrh] OBJECT
+.B semanage login [\-admsrh] login_name
+.br
+.B semanage seuser [\-admsrh] selinux_name
+.br
+.B semanage port [\-admth] port_number
+.P
+This tool is used to manage configuration of the SELinux policy
+
+.SH "DESCRIPTION"
+This manual page describes the
+.BR semanage
+program.
+.br
+This tool is used to manage configuration of SELinux Policy.  You can configure SELinux User Mappings, SELinux Port Mappings, SELinux Users.
+
+
+.SH "OPTIONS"
+.TP 
+                \-a, \-\-add        
+.P
+Add a OBJECT record NAME
+.B                \-d, \-\-delete     
+.P
+Delete a OBJECT record NAME
+.B                \-h, \-\-help       
+.P
+display this message
+.B                \-l, \-\-list       
+.P
+List the OBJECTS
+.B                \-m, \-\-modify     
+.P
+Modify a OBJECT record NAME
+.B                \-r, \-\-range      
+.P
+MLS/MCS Security Range
+.B                \-s, \-\-seuser     
+.P
+SELinux user name
+.B                \-t, \-\-type       
+.P
+SELinux Type for the object
+.B                \-v, \-\-verbose    
+.P
+verbose output
+
+.SH "AUTHOR"
+This man page was written by Daniel Walsh <dwalsh@redhat.com>.
+
+
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/sestatus/sestatus.8 policycoreutils-1.27.29/sestatus/sestatus.8
--- nsapolicycoreutils/sestatus/sestatus.8	2005-09-12 16:33:30.000000000 -0400
+++ policycoreutils-1.27.29/sestatus/sestatus.8	2005-11-29 00:04:31.000000000 -0500
@@ -1,10 +1,10 @@
-.TH "sestatus" "8" "2002031409" "" ""
+.TH "sestatus" "8" "2005111103" "" ""
 .SH "NAME"
 sestatus \- SELinux status tool
 
 .SH "SYNOPSIS"
 .B sestatus
-.I [\-v]  
+.I [\-v] [\-b]  
 .P
 This tool is used to get the status of a system running SELinux.
 
@@ -33,6 +33,10 @@
  Checks the contexts of a files , and a processes listed in the /etc/sestatus.conf file.  It also checks the context of the target, in cases of
 symlinks.
 
+.B \-b
+.P
+Display the current state of booleans.
+
 
 .SH "FILES"
 /etc/sestatus.conf
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/sestatus/sestatus.c policycoreutils-1.27.29/sestatus/sestatus.c
--- nsapolicycoreutils/sestatus/sestatus.c	2005-09-12 16:33:30.000000000 -0400
+++ policycoreutils-1.27.29/sestatus/sestatus.c	2005-11-29 00:04:31.000000000 -0500
@@ -178,19 +178,33 @@
 	char **bools;
 	int nbool;
 
+	int verbose=0;
+	int show_bools=0;
+
+
 	/* policy */
 	const char *pol_name;
 	char *pol_path;
 
-	opt=getopt(argc, argv, "v");
-	if(opt == '?') {
-		/* invalid option */
-		printf("\nUsage: %s [OPTION]\n\n", basename(argv[0]));
-		printf("  -v  Verbose check of process and file contexts.\n");
-		printf("\nWithout options, show SELinux status.\n");
-		return -1;
+	while (1) {
+		opt=getopt(argc, argv, "vb");
+		if (opt == -1)
+			break;
+		switch (opt) {
+		case 'v':
+			verbose=1;
+			break;
+		case 'b':
+			show_bools=1;
+			break;
+		default:
+			/* invalid option */
+			printf("\nUsage: %s [OPTION]\n\n", basename(argv[0]));
+			printf("  -v  Verbose check of process and file contexts.\n");
+			printf("\nWithout options, show SELinux status.\n");
+			return -1;
+		}
 	}
-
 	printf_tab("SELinux status:");
 	rc=is_selinux_enabled();
 
@@ -266,32 +280,34 @@
 		printf("error (%s)\n", strerror(errno));
 	}
 
-	/* show booleans */
-	if(security_get_boolean_names(&bools,&nbool) >= 0) {
-		printf("\nPolicy booleans:\n");
-
-		for( i=0 ; i<nbool ; i++ ) {
-			if (strlen(bools[i]) + 1 > COL) 
-			    COL=strlen(bools[i])+1;
-		}
-		for( i=0 ; i<nbool ; i++ ) {
-			printf_tab(bools[i]);
 
-			rc=security_get_boolean_active(bools[i]);
-			switch(rc) {
+	if (show_bools) {
+		/* show booleans */
+		if(security_get_boolean_names(&bools,&nbool) >= 0) {
+			printf("\nPolicy booleans:\n");
+			
+			for( i=0 ; i<nbool ; i++ ) {
+				if (strlen(bools[i]) + 1 > COL) 
+					COL=strlen(bools[i])+1;
+			}
+			for( i=0 ; i<nbool ; i++ ) {
+				printf_tab(bools[i]);
+				
+				rc=security_get_boolean_active(bools[i]);
+				switch(rc) {
 				case 1:
-					printf("active");
+					printf("on");
 					break;
 				case 0:
-					printf("inactive");
+					printf("off");
 					break;
 				default:
 					printf("unknown (%s)",strerror(errno));
 					break;
-			}
-			c=security_get_boolean_pending(bools[i]);
-			if(c != rc)
-				switch(c) {
+				}
+				c=security_get_boolean_pending(bools[i]);
+				if(c != rc)
+					switch(c) {
 					case 1:
 						printf(" (activate pending)");
 						break;
@@ -301,17 +317,17 @@
 					default:
 						printf(" (pending error: %s)",strerror(errno));
 						break;
-				}
-			printf("\n");
-
-			/* free up the booleans */
-			free(bools[i]);
+					}
+				printf("\n");
+				
+				/* free up the booleans */
+				free(bools[i]);
+			}
+			free(bools);
 		}
-		free(bools);
 	}
-
 	/* only show contexts if -v is given */
-	if(opt != 'v') return 0;
+	if(!verbose) return 0;
 
 	load_checks(pc,&npc,fc,&nfc);
 

--------------020802060909030606020900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
