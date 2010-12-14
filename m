Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBEDNPGO001714
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2010 08:23:25 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBEDNMuu003869
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2010 13:23:23 GMT
Message-ID: <4D076FC5.3070601@redhat.com>
Date: Tue, 14 Dec 2010 08:23:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Semanage Patch
References: <C92C0B59.BBA5F%csellers@tresys.com>
In-Reply-To: <C92C0B59.BBA5F%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------060308040509050001080400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060308040509050001080400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch adds handling of modules.
Fixes up lots of --help and man pages to match reality
Adds disable/enable module handling
Lots of bug fixes


If you want to discuss sections we can do that.  Breaking it up into
several different patches would be difficult now.  But if you take the
easy stuff,  We can discuss more difficult sections.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0Hb8EACgkQrlYvE4MpobM5qACfY+vmOtJIm7S+k88z7qNfW6EG
5+EAn2FQDnIIobmshGHUrDJAth2Ohm7j
=TBte
-----END PGP SIGNATURE-----

--------------060308040509050001080400
Content-Type: text/plain;
 name="policycoreutils-semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-semanage.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index ffaca5b..75b53e8 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -1,4 +1,4 @@
-#! /usr/bin/python -E
+#! /usr/bin/python -Es
 # Copyright (C) 2005, 2006, 2007 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
@@ -20,6 +20,7 @@
 #                                        02111-1307  USA
 #
 #  
+import policycoreutils.default_encoding_utf8
 import sys, getopt, re
 import seobject
 import selinux
@@ -32,27 +33,36 @@ gettext.textdomain(PROGNAME)
 try:
        gettext.install(PROGNAME,
                        localedir="/usr/share/locale",
-                       unicode=False,
+                       unicode=True,
                        codeset = 'utf-8')
 except IOError:
        import __builtin__
        __builtin__.__dict__['_'] = unicode
 
 if __name__ == '__main__':
-
+        action  = False
+        manageditems=[ "boolean", "login", "user", "port", "interface", "node", "fcontext"]
+        def set_action(option):
+               global action
+               if action:
+                      raise ValueError(_("%s bad option") % option)
+               action = True
+                      
 	def usage(message = ""):
                text = _("""
 semanage [ -S store ] -i [ input_file | - ]
+semanage [ -S store ] -o [ output_file | - ]
 
-semanage {boolean|login|user|port|interface|node|fcontext} -{l|D} [-n]
+semanage {boolean|login|user|port|interface|module|node|fcontext} -{l|D|E} [-n]
 semanage login -{a|d|m} [-sr] login_name | %groupname
 semanage user -{a|d|m} [-LrRP] selinux_name
 semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
 semanage interface -{a|d|m} [-tr] interface_spec
+semanage module -{a|d|m} [--enable|--disable] module
 semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr
-semanage fcontext -{a|d|m} [-frst] file_spec
+semanage fcontext -{a|d|m} [-efrst] file_spec
 semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
-semanage permissive -{d|a} type
+semanage permissive -{d|a|l} type 
 semanage dontaudit [ on | off ]
 
 Primary Options:
@@ -61,7 +71,9 @@ Primary Options:
 	-d, --delete     Delete a OBJECT record NAME
 	-m, --modify     Modify a OBJECT record NAME
         -i, --input      Input multiple semange commands in a transaction 
+        -o, --output     Output current customizations as semange commands 
 	-l, --list       List the OBJECTS
+	-E, --extract    extract customizable commands
 	-C, --locallist  List OBJECTS local customizations
 	-D, --deleteall  Remove all OBJECTS local customizations
 
@@ -84,12 +96,15 @@ Object-specific Options (see above):
         -F, --file       Treat target as an input file for command, change multiple settings
 	-p, --proto      Port protocol (tcp or udp) or internet protocol version of node (ipv4 or ipv6)
 	-M, --mask       Netmask
+        -e, --equal      Substitue source path for dest path when labeling
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")
 	-s, --seuser     SELinux User Name
 	-t, --type       SELinux Type for the object
 	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only)
+        --enable         Enable a module
+        --disable        Disable a module
 """)
                raise ValueError("%s\n%s" % (text, message))
 		
@@ -101,7 +116,7 @@ Object-specific Options (see above):
 
 	def get_options():
 		valid_option={}
-		valid_everyone=[ '-a', '--add', '-d', '--delete', '-m', '--modify', '-l', '--list', '-h', '--help', '-n', '--noheading', '-C', '--locallist', '-D', '--deleteall', '-S', '--store' ]
+		valid_everyone=[ '-a', '--add', '-d', '--delete', '-E', '--extract', '-m', '--modify', '-l', '--list', '-h', '--help', '-n', '--noheading', '-C', '--locallist', '-D', '--deleteall', '-S', '--store' ]
 		valid_option["login"] = []
 		valid_option["login"] += valid_everyone + [ '-s', '--seuser', '-r', '--range']
 		valid_option["user"] = []
@@ -112,8 +127,10 @@ Object-specific Options (see above):
 		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range']
 		valid_option["node"] = []
 		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol']
+		valid_option["module"] = []
+		valid_option["module"] += valid_everyone + [ '--enable', '--disable']
 		valid_option["fcontext"] = []
-		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
+		valid_option["fcontext"] += valid_everyone + [ '-e', '--equal', '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
 		valid_option["dontaudit"] = [ '-S', '--store' ]
 		valid_option["boolean"] = []
 		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0", "-F", "--file"] 
@@ -168,6 +185,8 @@ Object-specific Options (see above):
                return ret
 
         def process_args(argv):
+                global action
+                action = False
 		serange = ""
 		port = ""
 		proto = ""
@@ -184,11 +203,17 @@ Object-specific Options (see above):
 		modify = False
 		delete = False
 		deleteall = False
+		enable = False
+		extract = False
+		disable = False
 		list = False
 		locallist = False
 		use_file = False
                 store = ""
+                equal=""
 			
+                if len(argv) == 0:
+                       return
 		object = argv[0]
 		option_dict=get_options()
 		if object not in option_dict.keys():
@@ -197,10 +222,14 @@ Object-specific Options (see above):
 		args = argv[1:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:i:lhmnp:s:FCDR:L:r:t:P:S:M:',
+					    '01adEe:f:i:lhmnp:s:FCDR:L:r:t:P:S:M:',
 					    ['add',
 					     'delete',
 					     'deleteall',
+					     'equal=',
+					     'enable',
+					     'extract',
+					     'disable',
 					     'ftype=',
 					     'file',
 					     'help',
@@ -225,29 +254,47 @@ Object-specific Options (see above):
 		for o, a in gopts:
 			if o not in option_dict[object]:
 				sys.stderr.write(_("%s not valid for %s objects\n") % ( o, object) );
+
+                                return
 				
 		for o,a in gopts:
 			if o == "-a" or o == "--add":
-				if modify or delete:
-                                       raise ValueError(_("%s bad option") % o)
+                                set_action(o)
 				add = True
 				
 			if o == "-d"  or o == "--delete":
-				if modify or add:
-                                       raise ValueError(_("%s bad option") % o)
+                                set_action(o)
 				delete = True
+
 			if o == "-D"  or o == "--deleteall":
-				if modify:
-                                       raise ValueError(_("%s bad option") % o)
+                                set_action(o)
 				deleteall = True
+
+			if o == "-E"  or o == "--extract":
+                                set_action(o)
+				extract = True
 			if o == "-f"  or o == "--ftype":
 				ftype=a
 
+			if o == "-e"  or o == "--equal":
+				equal = a
+
+			if o == "--enable":
+                                if disable:
+                                       raise ValueError(_("You can't disable and enable at the same time"))
+
+				enable = True
+
+			if o == "--disable":
+                                if enable:
+                                       raise ValueError(_("You can't disable and enable at the same time"))
+				disable = True
+
 			if o == "-F"  or o == "--file":
 				use_file = True
 
 			if o == "-h" or o == "--help":
-                               raise ValueError(_("%s bad option") % o)
+                               raise usage()
 
 			if o == "-n" or o == "--noheading":
 				heading = False
@@ -256,8 +303,7 @@ Object-specific Options (see above):
 				locallist = True
 
 			if o == "-m"or o == "--modify":
-				if delete or add:
-                                       raise ValueError(_("%s bad option") % o)
+                                set_action(o)
 				modify = True
 				
 			if o == "-S" or o == '--store':
@@ -292,8 +338,10 @@ Object-specific Options (see above):
 
                         if o == "--on" or o == "-1":
                                value = "on"
+                               modify = True
                         if o == "--off" or o == "-0":
                                value = "off"
+                               modify = True
 
 		if object == "login":
 			OBJECT = seobject.loginRecords(store)
@@ -315,6 +363,11 @@ Object-specific Options (see above):
 		
 		if object == "boolean":
 			OBJECT = seobject.booleanRecords(store)
+                        if use_file:
+                               modify=True
+
+		if object == "module":
+			OBJECT = seobject.moduleRecords(store)
 		
 		if object == "permissive":
 			OBJECT = seobject.permissiveRecords(store)
@@ -330,65 +383,97 @@ Object-specific Options (see above):
 			OBJECT.deleteall()
                         return
 			
+		if extract:
+                        for i in OBJECT.customized():
+                               print "%s %s" % (object, str(i))
+                        return
+			
 		if len(cmds) != 1:
-                       raise ValueError(_("%s bad option") % o)
+                       raise ValueError(_("bad option"))
                         
                 target = cmds[0]
 
-
 		if object == "dontaudit":
-			OBJECT = seobject.dontauditClass(store)
-                        OBJECT.toggle(target)
-                        return
+                       OBJECT = seobject.dontauditClass(store)
+                       OBJECT.toggle(target)
+                       return
                               
 		if add:
 			if object == "login":
 				OBJECT.add(target, seuser, serange)
+                                return
 
 			if object == "user":
 				OBJECT.add(target, roles.split(), selevel, serange, prefix)
+                                return
 
 			if object == "port":
 				OBJECT.add(target, proto, serange, setype)
+                                return
 
 			if object == "interface":
 				OBJECT.add(target, serange, setype)
+                                return
+
+			if object == "module":
+				OBJECT.add(target)
+                                return
 
 			if object == "node":
 				OBJECT.add(target, mask, proto, serange, setype)
+                                return
 
 			if object == "fcontext":
-				OBJECT.add(target, setype, ftype, serange, seuser)
+                                if equal == "":
+                                       OBJECT.add(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.add_equal(target, equal)
+                                return
 			if object == "permissive":
 				OBJECT.add(target)
+                                return
 
-                        return
-			
 		if modify:
 			if object == "boolean":
                                OBJECT.modify(target, value, use_file)
+                               return
 
 			if object == "login":
 				OBJECT.modify(target, seuser, serange)
+                                return
 
 			if object == "user":
 				rlist = roles.split()
 				OBJECT.modify(target, rlist, selevel, serange, prefix)
+                                return
+
+			if object == "module":
+                                if enable:
+                                       OBJECT.enable(target)
+                                elif disable:
+                                       OBJECT.disable(target)
+                                else:
+                                       OBJECT.modify(target)
+                                return
 
 			if object == "port":
 				OBJECT.modify(target, proto, serange, setype)
+                                return
 
 			if object == "interface":
 				OBJECT.modify(target, serange, setype)
+                                return
 
 			if object == "node":
 				OBJECT.modify(target, mask, proto, serange, setype)
+                                return
 
 			if object == "fcontext":
-				OBJECT.modify(target, setype, ftype, serange, seuser)
-
-                        return
-
+                                if equal == "":
+                                       OBJECT.modify(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.modify_equal(target, equal)
+                                return
 		if delete:
 			if object == "port":
 				OBJECT.delete(target, proto)
@@ -401,15 +486,14 @@ Object-specific Options (see above):
 
 			else:
 				OBJECT.delete(target)
-
                         return
-
-                raise ValueError(_("Invalid command") % " ".join(argv))
+                raise ValueError(_("Invalid command: semanage %s") % " ".join(argv))
 
 	#
 	# 
 	#
 	try:
+               output = None
                input = None
                store = ""
 
@@ -417,7 +501,7 @@ Object-specific Options (see above):
                       usage(_("Requires 2 or more arguments"))
                 
                gopts, cmds = getopt.getopt(sys.argv[1:],
-                                           '01adf:i:lhmnp:s:FCDR:L:r:t:T:P:S:',
+                                           '01adf:i:lhmno:p:s:FCDR:L:r:t:T:P:S:',
                                            ['add',
                                             'delete',
                                             'deleteall',
@@ -431,6 +515,7 @@ Object-specific Options (see above):
                                             'localist',
                                             'off', 
                                             'on', 
+                                            'output=',
                                             'proto=',
                                             'seuser=',
                                             'store=',
@@ -438,6 +523,7 @@ Object-specific Options (see above):
                                             'level=',
                                             'roles=',
                                             'type=',
+                                            'trans=',
                                             'prefix='
                                             ])
                for o, a in gopts:
@@ -445,6 +531,16 @@ Object-specific Options (see above):
                              store = a
                       if o == "-i" or o == '--input':
                              input = a
+                      if o == "-o" or o == '--output':
+                             output = a
+
+               if output != None:
+                      if output != "-":
+                             sys.stdout = open(output, 'w')
+                      for i in manageditems:
+                             print "%s -D" % i
+                             process_args([i, "-E"])
+                      sys.exit(0)
 
                if input != None:
                       if input == "-":
@@ -467,3 +563,5 @@ Object-specific Options (see above):
 		errorExit(_("Invalid value %s") % error.args[0])
 	except IOError, error:
 		errorExit(error.args[1])
+	except OSError, error:
+		errorExit(error.args[1])
diff --git a/policycoreutils/semanage/semanage.8 b/policycoreutils/semanage/semanage.8
index 70d1a20..fb6a79b 100644
--- a/policycoreutils/semanage/semanage.8
+++ b/policycoreutils/semanage/semanage.8
@@ -1,29 +1,69 @@
-.TH "semanage" "8" "2005111103" "" ""
+.TH "semanage" "8" "20100223" "" ""
 .SH "NAME"
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {boolean|login|user|port|interface|node|fcontext} \-{l|D} [\-n] [\-S store]
+Output local customizations
 .br
-.B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] -F boolean | boolean_file
+.B semanage [ -S store ] -o [ output_file | - ]
+
+Input local customizations
+.br
+.B semanage [ -S store ] -i [ input_file | - ]
+
+Manage booleans.  Booleans allow the administrator to modify the confinement of 
+processes based on his configuration.
+.br
+.B semanage boolean [\-S store] \-{d|m|l|n|D} \-[\-on|\-off|\1|0] -F boolean | boolean_file
+
+Manage SELinux confined users (Roles and levels for an SELinux user)
+.br
+.B semanage user [\-S store] \-{a|d|m|l|n|D} [\-LrRP] selinux_name
+
+Manage login mappings between linux users and SELinux confined users.
+.br
+.B semanage login [\-S store] \-{a|d|m|l|n|D} [\-sr] login_name | %groupname
+
+Manage policy modules.
+.br
+.B semanage module [\-S store] \-{a|d|l} [-m [--enable | --disable] ] module_name
+
+Manage network port type definitions
 .br
-.B semanage login \-{a|d|m} [\-sr] login_name | %groupname
+.B semanage port [\-S store] \-{a|d|m|l|n|D} [\-tr] [\-p proto] port | port_range
 .br
-.B semanage user \-{a|d|m} [\-LrRP] selinux_name
+
+Manage network interface type definitions
+.br
+.B semanage interface [\-S store] \-{a|d|m|l|n|D} [\-tr] interface_spec
+
+Manage network node type definitions
 .br
-.B semanage port \-{a|d|m} [\-tr] [\-p proto] port | port_range
+.B semanage node [\-S store] -{a|d|m|l|n|D} [-tr] [ -p protocol ] [-M netmask] address
 .br
-.B semanage interface \-{a|d|m} [\-tr] interface_spec
+
+Manage file context mapping definitions
+.br
+.B semanage fcontext [\-S store] \-{a|d|m|l|n|D} [\-frst] file_spec
 .br
-.B semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] address
+.B semanage fcontext [\-S store] \-{a|d|m|l|n|D} \-e replacement target
 .br
-.B semanage fcontext \-{a|d|m} [\-frst] file_spec
+
+Manage processes type enforcement mode
 .br
-.B semanage permissive \-{a|d} type
+.B semanage permissive [\-S store] \-{a|d|l|n|D} type
 .br
-.B semanage dontaudit [ on | off ]
+
+Disable/Enable dontaudit rules in policy
+.br
+.B semanage dontaudit [\-S store] [ on | off ]
 .P
 
+Execute multiple commands within a single transaction.
+.br
+.B semanage [\-S store] \-i command-file
+.br
+
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
 SELinux policy without requiring modification to or recompilation
@@ -52,6 +92,22 @@ Delete a OBJECT record NAME
 .I                \-D, \-\-deleteall
 Remove all OBJECTS local customizations
 .TP
+.I                \-\-disable
+Disable a policy module, requires -m option
+
+Currently modules only.
+.TP
+.I                \-\-enable
+Enable a disabled policy module, requires -m option
+
+Currently modules only.
+.TP
+.I                \-e, \-\-equal
+Substitute target path with sourcepath when generating default label.  This is used with
+fcontext. Requires source and target path arguments.  The context
+labeling for the target subtree is made equivalent to that
+defined for the source.
+.TP
 .I                \-f, \-\-ftype
 File Type.   This is used with fcontext.
 Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
@@ -60,6 +116,7 @@ Requires a file type as shown in the mode field by ls, e.g. use -d to match only
 Set multiple records from the input file.  When used with the \-l \-\-list, it will output the current settings to stdout in the proper format.
 
 Currently booleans only.
+
 .TP
 .I                \-h, \-\-help       
 display this message
@@ -76,6 +133,9 @@ Default SELinux Level for SELinux use, s0 Default. (MLS/MCS Systems only)
 .I                \-m, \-\-modify     
 Modify a OBJECT record NAME
 .TP
+.I                \-M, \-\-mask
+Network Mask
+.TP
 .I                \-n, \-\-noheading  
 Do not print heading when listing OBJECTS.
 .TP
@@ -99,26 +159,67 @@ Select and alternate SELinux store to manage
 .TP
 .I                \-t, \-\-type       
 SELinux Type for the object
+.TP
+.I                \-i, \-\-input
+Take a set of commands from a specified file and load them in a single
+transaction.
 
 .SH EXAMPLE
 .nf
-# View SELinux user mappings
-$ semanage user -l
-# Allow joe to login as staff_u
-$ semanage login -a -s staff_u joe
-# Allow the group clerks to login as user_u
-$ semanage login -a -s user_u %clerks
-# Add file-context for everything under /web (used by restorecon)
-$ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
-# Allow Apache to listen on port 81
-$ semanage port -a -t http_port_t -p tcp 81
-# Change apache to a permissive domain
-$ semanage permissive -a httpd_t
-# Turn off dontaudit rules
-$ semanage dontaudit off
+.B SELinux user 
+List SELinux users
+# semanage user -l
+
+.B SELinux login
+Change joe to login as staff_u
+# semanage login -a -s staff_u joe
+Change the group clerks to login as user_u
+# semanage login -a -s user_u %clerks
+
+.B File contexts
+.i remember to run restorecon after you set the file context
+Add file-context for everything under /web 
+# semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
+# restorecon -R -v /web
+
+Substitute /home1 with /home when setting file context
+# semanage fcontext -a -e /home /home1
+# restorecon -R -v /home1
+
+For home directories under top level directory, for example /disk6/home, 
+execute the following commands.  
+# semanage fcontext -a -t home_root_t "/disk6" 
+# semanage fcontext -a -e /home /disk6/home 
+# restorecon -R -v /disk6
+
+.B Port contexts
+Allow Apache to listen on tcp port 81
+# semanage port -a -t http_port_t -p tcp 81
+
+.B Change apache to a permissive domain
+# semanage permissive -a httpd_t
+
+.B Turn off dontaudit rules
+# semanage dontaudit off
+
+.B Managing multiple machines
+Multiple machines that need the same customizations.  
+Extract customizations off first machine, copy them 
+to second and import them.
+
+# semanage -o /tmp/local.selinux
+# scp /tmp/local.selinux secondmachine:/tmp
+# ssh secondmachine
+# semanage -i /tmp/local.selinux
+
+If these customizations include file context, you need to apply the 
+context using restorecon.
+
 .fi
 
 .SH "AUTHOR"
-This man page was written by Daniel Walsh <dwalsh@redhat.com> and
-Russell Coker <rcoker@redhat.com>.
+This man page was written by Daniel Walsh <dwalsh@redhat.com> 
+.br
+and Russell Coker <rcoker@redhat.com>.
+.br
 Examples by Thomas Bleher <ThomasBleher@gmx.de>.
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index b7d257b..40e57e9 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -29,47 +29,12 @@ import sepolgen.module as module
 import gettext
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
-try:
-       gettext.install(PROGNAME, localedir = "/usr/share/locale", unicode = 1)
-except IOError:
-       import __builtin__
-       __builtin__.__dict__['_'] = unicode
-
-import syslog
-
-handle = None
-
-def get_handle(store):
-       global handle
-       global is_mls_enabled
-
-       handle = semanage_handle_create()
-       if not handle:
-              raise ValueError(_("Could not create semanage handle"))
-       
-       if store != "":
-              semanage_select_store(handle, store, SEMANAGE_CON_DIRECT);
-
-       if not semanage_is_managed(handle):
-              semanage_handle_destroy(handle)
-              raise ValueError(_("SELinux policy is not managed or store cannot be accessed."))
-
-       rc = semanage_access_check(handle)
-       if rc < SEMANAGE_CAN_READ:
-              semanage_handle_destroy(handle)
-              raise ValueError(_("Cannot read policy store."))
-
-       rc = semanage_connect(handle)
-       if rc < 0:
-              semanage_handle_destroy(handle)
-              raise ValueError(_("Could not establish semanage connection"))
 
-       is_mls_enabled = semanage_mls_enabled(handle)
-       if is_mls_enabled < 0:
-              semanage_handle_destroy(handle)
-              raise ValueError(_("Could not test MLS enabled status"))
+import gettext
+translation=gettext.translation(PROGNAME, localedir = "/usr/share/locale", fallback=True)
+_=translation.ugettext
 
-       return handle
+import syslog
 
 file_types = {}
 file_types[""] = SEMANAGE_FCONTEXT_ALL;
@@ -194,45 +159,154 @@ def untranslate(trans, prepend = 1):
 		return trans
 	else:
 		return raw
-	
+
 class semanageRecords:
-	def __init__(self, store):
+        transaction = False
+        handle = None
+	store = None
+
+        def __init__(self, store):
                global handle
                       
-               if handle != None:
-                      self.sh = handle
-               else:
-                      self.sh = get_handle(store)
-               self.transaction = False
+               self.sh = self.get_handle(store)
+
+        def get_handle(self, store):
+               global is_mls_enabled
+
+               if semanageRecords.handle:
+                      return semanageRecords.handle
+
+               handle = semanage_handle_create()
+               if not handle:
+                      raise ValueError(_("Could not create semanage handle"))
+               
+               if not semanageRecords.transaction and store != "":
+                      semanage_select_store(handle, store, SEMANAGE_CON_DIRECT);
+		      semanageRecords.store = store
+                      
+               if not semanage_is_managed(handle):
+                      semanage_handle_destroy(handle)
+                      raise ValueError(_("SELinux policy is not managed or store cannot be accessed."))
+                      
+               rc = semanage_access_check(handle)
+               if rc < SEMANAGE_CAN_READ:
+                      semanage_handle_destroy(handle)
+                      raise ValueError(_("Cannot read policy store."))
+               
+               rc = semanage_connect(handle)
+               if rc < 0:
+                      semanage_handle_destroy(handle)
+                      raise ValueError(_("Could not establish semanage connection"))
+
+               is_mls_enabled = semanage_mls_enabled(handle)
+               if is_mls_enabled < 0:
+                      semanage_handle_destroy(handle)
+                      raise ValueError(_("Could not test MLS enabled status"))
+
+               semanageRecords.handle = handle
+               return semanageRecords.handle
 
         def deleteall(self):
                raise ValueError(_("Not yet implemented"))
 
         def start(self):
-               if self.transaction:
+               if semanageRecords.transaction:
                       raise ValueError(_("Semanage transaction already in progress"))
                self.begin()
-               self.transaction = True
-
+               semanageRecords.transaction = True
         def begin(self):
-               if self.transaction:
+               if semanageRecords.transaction:
                       return
                rc = semanage_begin_transaction(self.sh)
                if rc < 0:
                       raise ValueError(_("Could not start semanage transaction"))
+        def customized(self):
+               raise ValueError(_("Not yet implemented"))
+
         def commit(self):
-               if self.transaction:
+               if semanageRecords.transaction:
                       return
                rc = semanage_commit(self.sh) 
                if rc < 0:
                       raise ValueError(_("Could not commit semanage transaction"))
 
         def finish(self):
-               if not self.transaction:
+               if not semanageRecords.transaction:
                       raise ValueError(_("Semanage transaction not in progress"))
-               self.transaction = False
+               semanageRecords.transaction = False
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
+                      l.append((semanage_module_get_name(mod), semanage_module_get_version(mod), semanage_module_get_enabled(mod)))
+               return l
+
+	def list(self, heading = 1, locallist = 0):
+		if heading:
+			print "\n%-25s%-10s\n" % (_("Modules Name"), _("Version"))
+                for t in self.get_all():
+                       if t[2] == 0:
+                              disabled = _("Disabled")
+                       else:
+                              disabled = ""
+                       print "%-25s%-10s%s" % (t[0], t[1], disabled)
+
+	def add(self, file):
+               rc = semanage_module_install_file(self.sh, file);
+               if rc >= 0:
+                      self.commit()
+
+	def disable(self, module):
+               need_commit = False                      
+               for m in module.split():
+                      rc = semanage_module_disable(self.sh, m)
+                      if rc < 0 and rc != -3:
+                             raise ValueError(_("Could not disable module %s (remove failed)") % m)
+                      if rc != -3:
+                             need_commit = True 
+               if need_commit:
+                      self.commit()
+			
+	def enable(self, module):
+               need_commit = False                      
+               for m in module.split():
+                      rc = semanage_module_enable(self.sh, m)
+                      if rc < 0 and rc != -3:
+                             raise ValueError(_("Could not enable module %s (remove failed)") % m)
+                      if rc != -3:
+                             need_commit = True 
+               if need_commit:
+                      self.commit()
+
+	def modify(self, file):
+               rc = semanage_module_update_file(self.sh, file);
+               if rc >= 0:
+                      self.commit()
+
+	def delete(self, module):
+               for m in module.split():
+                      rc = semanage_module_remove(self.sh, m)
+                      if rc < 0 and rc != -2:
+                             raise ValueError(_("Could not remove module %s (remove failed)") % m)
+                      
+               self.commit()
+			
+	def deleteall(self):
+               l = self.get_all()
+               if len(l) > 0:
+                      all = " ".join(l[0])
+                      self.delete(all)
+
 class dontauditClass(semanageRecords):
 	def __init__(self, store):
                semanageRecords.__init__(self, store)
@@ -259,14 +333,23 @@ class permissiveRecords(semanageRecords):
                       name = semanage_module_get_name(mod)
                       if name and name.startswith("permissive_"):
                              l.append(name.split("permissive_")[1])
+
                return l
 
 	def list(self, heading = 1, locallist = 0):
-		if heading:
-			print "\n%-25s\n" % (_("Permissive Types"))
-                for t in self.get_all():
-                       print t
+		import setools
+		all = map(lambda y: y["name"], filter(lambda x: x["permissive"], setools.seinfo(setools.TYPE)))
 
+		if heading:
+			print "\n%-25s\n" % (_("Builtin Permissive Types"))
+		customized = self.get_all()
+                for t in all:
+			if t not in customized:
+				print t
+		if heading:
+			print "\n%-25s\n" % (_("Customized Permissive Types"))
+		for t in customized:
+			print t
 
 	def add(self, type):
                import glob
@@ -343,7 +426,9 @@ class loginRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError(_("Could not check if login mapping for %s is defined") % name)
 		if exists:
-			raise ValueError(_("Login mapping for %s is already defined") % name)
+                       semanage_seuser_key_free(k)
+                       return self.__modify(name, sename, serange)
+
                 if name[0] == '%':
                        try:
                               grp.getgrnam(name[1:])
@@ -475,6 +560,16 @@ class loginRecords(semanageRecords):
 		
 		mylog.log(1, "delete SELinux user mapping", name);
 
+	def deleteall(self):
+		(rc, ulist) = semanage_seuser_list_local(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not list login mappings"))
+
+                self.begin()
+		for u in ulist:
+			self.__delete(semanage_seuser_get_name(u))
+                self.commit()
+
 	def get_all(self, locallist = 0):
 		ddict = {}
                 if locallist:
@@ -489,6 +584,15 @@ class loginRecords(semanageRecords):
 			ddict[name] = (semanage_seuser_get_sename(u), semanage_seuser_get_mlsrange(u))
 		return ddict
 
+        def customized(self):
+                l = []
+                ddict = self.get_all(True)
+                keys = ddict.keys()
+                keys.sort()
+                for k in keys:
+                       l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
+                return l
+
 	def list(self,heading = 1, locallist = 0):
 		ddict = self.get_all(locallist)
 		keys = ddict.keys()
@@ -531,7 +635,8 @@ class seluserRecords(semanageRecords):
                 if rc < 0:
                        raise ValueError(_("Could not check if SELinux user %s is defined") % name)
                 if exists:
-                       raise ValueError(_("SELinux user %s is already defined") % name)
+                       semanage_user_key_free(k)
+                       return self.__modify(name, roles, selevel, serange, prefix)
 
                 (rc, u) = semanage_user_create(self.sh)
                 if rc < 0:
@@ -682,6 +787,16 @@ class seluserRecords(semanageRecords):
 		
 		mylog.log(1,"delete SELinux user record", name)
 
+	def deleteall(self):
+		(rc, ulist) = semanage_user_list_local(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not list login mappings"))
+
+                self.begin()
+		for u in ulist:
+			self.__delete(semanage_user_get_name(u))
+                self.commit()
+
 	def get_all(self, locallist = 0):
 		ddict = {}
                 if locallist:
@@ -702,6 +817,15 @@ class seluserRecords(semanageRecords):
 
 		return ddict
 
+        def customized(self):
+                l = []
+                ddict = self.get_all(True)
+                keys = ddict.keys()
+                keys.sort()
+                for k in keys:
+                       l.append("-a -r %s -R '%s' %s" % (ddict[k][2], ddict[k][3], k))
+                return l
+
 	def list(self, heading = 1, locallist = 0):
 		ddict = self.get_all(locallist)
 		keys = ddict.keys()
@@ -740,12 +864,16 @@ class portRecords(semanageRecords):
 			low = int(ports[0])
 			high = int(ports[1])
 
+                if high > 65536:
+                       raise ValueError(_("Invalid Port"))
+
 		(rc, k) = semanage_port_key_create(self.sh, low, high, proto_d)
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s/%s") % (proto, port))
 		return ( k, proto_d, low, high )
 
 	def __add(self, port, proto, serange, type):
+
 		if is_mls_enabled == 1:
 			if serange == "":
 				serange = "s0"
@@ -808,6 +936,7 @@ class portRecords(semanageRecords):
                 self.commit()
 
 	def __modify(self, port, proto, serange, setype):
+
 		if serange == "" and setype == "":
 			if is_mls_enabled == 1:
 				raise ValueError(_("Requires setype or serange"))
@@ -942,6 +1071,18 @@ class portRecords(semanageRecords):
 				ddict[(ctype,proto_str)].append("%d-%d" % (low, high))
 		return ddict
 
+        def customized(self):
+                l = []
+		ddict = self.get_all(True)
+		keys = ddict.keys()
+		keys.sort()
+                for k in keys:
+                       if k[0] == k[1]:
+                              l.append("-a -t %s -p %s %s" % (ddict[k][0], k[2], k[0]))
+                       else:
+                              l.append("-a -t %s -p %s %s-%s" % (ddict[k][0], k[2], k[0], k[1]))
+                return l
+
 	def list(self, heading = 1, locallist = 0):
 		if heading:
 			print "%-30s %-8s %s\n" % (_("SELinux Port Type"), _("Proto"), _("Port Number"))
@@ -958,7 +1099,8 @@ class portRecords(semanageRecords):
 class nodeRecords(semanageRecords):
        def __init__(self, store = ""):
                semanageRecords.__init__(self,store)
-
+               self.protocol = ["ipv4", "ipv6"]
+       
        def __add(self, addr, mask, proto, serange, ctype):
                if addr == "":
                        raise ValueError(_("Node Address is required"))
@@ -966,14 +1108,11 @@ class nodeRecords(semanageRecords):
                if mask == "":
                        raise ValueError(_("Node Netmask is required"))
 
-	       if proto == "ipv4":
-                       proto = 0
-               elif proto == "ipv6":
-                       proto = 1
-               else:
+               try:
+                      proto = self.protocol.index(proto)
+               except:
                       raise ValueError(_("Unknown or missing protocol"))
 
-
                if is_mls_enabled == 1:
                        if serange == "":
                                serange = "s0"
@@ -991,11 +1130,13 @@ class nodeRecords(semanageRecords):
 
                (rc, exists) = semanage_node_exists(self.sh, k)
                if exists:
-                       raise ValueError(_("Addr %s already defined") % addr)
+                       semanage_node_key_free(k)
+                       return self.__modify(addr, mask, self.protocol[proto], serange, ctype)
 
                (rc, node) = semanage_node_create(self.sh)
                if rc < 0:
                        raise ValueError(_("Could not create addr for %s") % addr)
+               semanage_node_set_proto(node, proto)
 
                rc = semanage_node_set_addr(self.sh, node, proto, addr)
                (rc, con) = semanage_context_create(self.sh)
@@ -1005,8 +1146,7 @@ class nodeRecords(semanageRecords):
                rc = semanage_node_set_mask(self.sh, node, proto, mask)
                if rc < 0:
                        raise ValueError(_("Could not set mask for %s") % addr)
-
-
+	       
                rc = semanage_context_set_user(self.sh, con, "system_u")
                if rc < 0:
                        raise ValueError(_("Could not set user in addr context for %s") % addr)
@@ -1047,13 +1187,10 @@ class nodeRecords(semanageRecords):
 
                if mask == "":
                        raise ValueError(_("Node Netmask is required"))
-               if proto == "ipv4":
-                       proto = 0
-               elif proto == "ipv6":
-                       proto = 1
-	       else:
-		      raise ValueError(_("Unknown or missing protocol"))
-
+               try:
+                      proto = self.protocol.index(proto)
+               except:
+                      raise ValueError(_("Unknown or missing protocol"))
 
                if serange == "" and setype == "":
                        raise ValueError(_("Requires setype or serange"))
@@ -1068,12 +1205,11 @@ class nodeRecords(semanageRecords):
                if not exists:
                        raise ValueError(_("Addr %s is not defined") % addr)
 
-               (rc, node) = semanage_node_query(self.sh, k)
+               (rc, node) = semanage_node_query_local(self.sh, k)
                if rc < 0:
                        raise ValueError(_("Could not query addr %s") % addr)
 
                con = semanage_node_get_con(node)
-
                if serange != "":
                        semanage_context_set_mls(self.sh, con, untranslate(serange))
                if setype != "":
@@ -1098,11 +1234,9 @@ class nodeRecords(semanageRecords):
                if mask == "":
                        raise ValueError(_("Node Netmask is required"))
 
-	       if proto == "ipv4":
-                       proto = 0
-               elif proto == "ipv6":
-                       proto = 1
-               else:
+               try:
+                      proto = self.protocol.index(proto)
+               except:
                       raise ValueError(_("Unknown or missing protocol"))
 
                (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
@@ -1132,6 +1266,16 @@ class nodeRecords(semanageRecords):
               self.__delete(addr, mask, proto)
               self.commit()
 		
+       def deleteall(self):
+              (rc, nlist) = semanage_node_list_local(self.sh)
+              if rc < 0:
+                     raise ValueError(_("Could not deleteall node mappings"))
+              
+              self.begin()
+              for node in nlist:
+                     self.__delete(semanage_node_get_addr(self.sh, node)[1], semanage_node_get_mask(self.sh, node)[1], self.protocol[semanage_node_get_proto(node)])
+              self.commit()
+
        def get_all(self, locallist = 0):
                ddict = {}
 	       if locallist :
@@ -1145,15 +1289,20 @@ class nodeRecords(semanageRecords):
                        con = semanage_node_get_con(node)
                        addr = semanage_node_get_addr(self.sh, node)
                        mask = semanage_node_get_mask(self.sh, node)
-                       proto = semanage_node_get_proto(node)
-		       if proto == 0:
-				proto = "ipv4"
-		       elif proto == 1:
-				proto = "ipv6"
+                       proto = self.protocol[semanage_node_get_proto(node)]
                        ddict[(addr[1], mask[1], proto)] = (semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
 
                return ddict
 
+       def customized(self):
+               l = []
+               ddict = self.get_all(True)
+               keys = ddict.keys()
+               keys.sort()
+               for k in keys:
+                      l.append("-a -M %s -p %s -t %s %s" % (k[1], k[2],ddict[k][2], k[0]))
+               return l
+
        def list(self, heading = 1, locallist = 0):
                if heading:
                        print "%-18s %-18s %-5s %-5s\n" % ("IP Address", "Netmask", "Protocol", "Context")
@@ -1193,7 +1342,8 @@ class interfaceRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError(_("Could not check if interface %s is defined") % interface)
 		if exists:
-			raise ValueError(_("Interface %s already defined") % interface)
+                        semanage_iface_key_free(k)
+                        return self.__modify(interface, serange, ctype)
 
 		(rc, iface) = semanage_iface_create(self.sh)
 		if rc < 0:
@@ -1307,6 +1457,16 @@ class interfaceRecords(semanageRecords):
                 self.__delete(interface)
                 self.commit()
 		
+        def deleteall(self):
+		(rc, ulist) = semanage_iface_list_local(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not delete all interface  mappings"))
+
+                self.begin()
+		for i in ulist:
+			self.__delete(semanage_iface_get_name(i))
+                self.commit()
+
 	def get_all(self, locallist = 0):
 		ddict = {}
                 if locallist:
@@ -1322,6 +1482,15 @@ class interfaceRecords(semanageRecords):
 
 		return ddict
 			
+        def customized(self):
+                l = []
+                ddict = self.get_all(True)
+                keys = ddict.keys()
+                keys.sort()
+                for k in keys:
+                       l.append("-a -t %s %s" % (ddict[k][2], k))
+                return l
+
 	def list(self, heading = 1, locallist = 0):
 		if heading:
 			print "%-30s %s\n" % (_("SELinux Interface"), _("Context"))
@@ -1338,6 +1507,48 @@ class interfaceRecords(semanageRecords):
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
@@ -1364,6 +1575,8 @@ class fcontextRecords(semanageRecords):
         def validate(self, target):
                if target == "" or target.find("\n") >= 0:
                       raise ValueError(_("Invalid file specification"))
+               if target.find(" ") != -1:
+                      raise ValueError(_("File specification can not include spaces"))
                       
 	def __add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
                 self.validate(target)
@@ -1388,7 +1601,8 @@ class fcontextRecords(semanageRecords):
                               raise ValueError(_("Could not check if file context for %s is defined") % target)
 
                 if exists:
-                       raise ValueError(_("File context for %s already defined") % target)
+                       semanage_fcontext_key_free(k)
+                       return self.__modify(target, type, ftype, serange, seuser)
 
 		(rc, fcontext) = semanage_fcontext_create(self.sh)
 		if rc < 0:
@@ -1504,9 +1718,16 @@ class fcontextRecords(semanageRecords):
                               raise ValueError(_("Could not delete the file context %s") % target)
                        semanage_fcontext_key_free(k)
 	
+                self.equiv = {}
+                self.equal_ind = True
                 self.commit()
 
 	def __delete(self, target, ftype):
+                if target in self.equiv.keys():
+                       self.equiv.pop(target)
+                       self.equal_ind = True
+                       return
+
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
@@ -1561,12 +1782,22 @@ class fcontextRecords(semanageRecords):
 
 		return ddict
 			
+        def customized(self):
+               l = []
+               fcon_dict = self.get_all(True)
+               keys = fcon_dict.keys()
+               keys.sort()
+               for k in keys:
+                      if fcon_dict[k]:
+                             l.append("-a -f '%s' -t %s '%s'" % (k[1], fcon_dict[k][2], k[0]))
+               return l
+
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
@@ -1575,6 +1806,12 @@ class fcontextRecords(semanageRecords):
 					print "%-50s %-18s %s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1],fcon_dict[k][2])
 			else:
 				print "%-50s %-18s <<None>>" % (k[0], k[1])
+                if len(self.equiv.keys()) > 0:
+                       if heading:
+                              print _("\nSELinux fcontext Equivalence \n")
+                       
+                       for src in self.equiv.keys():
+                              print "%s = %s" % (src, self.equiv[src])
 				
 class booleanRecords(semanageRecords):
 	def __init__(self, store = ""):
@@ -1587,6 +1824,18 @@ class booleanRecords(semanageRecords):
                 self.dict["1"] = 1
                 self.dict["0"] = 0
 
+		try:
+			rc, self.current_booleans = selinux.security_get_boolean_names()
+			rc, ptype = selinux.selinux_getpolicytype()
+		except:
+			self.current_booleans = []
+			ptype = None
+
+		if self.store == None or self.store == ptype:
+			self.modify_local = True
+		else:
+			self.modify_local = False
+
 	def __mod(self, name, value):
                 (rc, k) = semanage_bool_key_create(self.sh, name)
                 if rc < 0:
@@ -1606,9 +1855,10 @@ class booleanRecords(semanageRecords):
                 else:
                        raise ValueError(_("You must specify one of the following values: %s") % ", ".join(self.dict.keys()) )
                 
-                rc = semanage_bool_set_active(self.sh, k, b)
-                if rc < 0:
-                       raise ValueError(_("Could not set active value of boolean %s") % name)
+		if self.modify_local and name in self.current_booleans:
+			rc = semanage_bool_set_active(self.sh, k, b)
+			if rc < 0:
+				raise ValueError(_("Could not set active value of boolean %s") % name)
                 rc = semanage_bool_modify_local(self.sh, k, b)
                 if rc < 0:
                        raise ValueError(_("Could not modify boolean %s") % name)
@@ -1691,8 +1941,12 @@ class booleanRecords(semanageRecords):
                        value = []
                        name = semanage_bool_get_name(boolean)
                        value.append(semanage_bool_get_value(boolean))
-                       value.append(selinux.security_get_boolean_pending(name))
-                       value.append(selinux.security_get_boolean_active(name))
+		       if self.modify_local and boolean in self.current_booleans:
+			       value.append(selinux.security_get_boolean_pending(name))
+			       value.append(selinux.security_get_boolean_active(name))
+		       else:
+			       value.append(value[0])
+			       value.append(value[0])
                        ddict[name] = value
 
 		return ddict
@@ -1706,6 +1960,16 @@ class booleanRecords(semanageRecords):
                else:
                       return _("unknown")
 
+        def customized(self):
+               l = []
+               ddict = self.get_all(True)
+               keys = ddict.keys()
+               keys.sort()
+               for k in keys:
+                      if ddict[k]:
+                             l.append("-%s %s" %  (ddict[k][2], k))
+               return l
+
 	def list(self, heading = True, locallist = False, use_file = False):
                 on_off = (_("off"), _("on")) 
 		if use_file:

--------------060308040509050001080400
Content-Type: application/pgp-signature;
 name="policycoreutils-semanage.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-semanage.patch.sig"

iEYEABECAAYFAk0Hb8UACgkQrlYvE4MpobPndACfS0K3974XzYLHhPJe7PtVbv8jFIIAn1rF
ab9+HNW7wzPisAF0YJCsxiSm
--------------060308040509050001080400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
