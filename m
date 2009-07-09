Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n69KBEbr029046
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:11:14 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n69KBsHS015025
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 20:11:54 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n69KBDW8009793
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:11:13 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n69KBC63031932
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:11:12 -0400
Received: from localhost.localdomain (vpn-12-24.rdu.redhat.com [10.11.12.24])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n69KBBTQ023525
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:11:12 -0400
Message-ID: <4A564ED7.2020206@redhat.com>
Date: Thu, 09 Jul 2009 16:11:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to semanage
Content-Type: multipart/mixed;
 boundary="------------030901050706040708070402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030901050706040708070402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Allows semanage to use equivalence.

Also adds better support for booleans and modules, add support for setting dontaudit rules.

--------------030901050706040708070402
Content-Type: text/plain;
 name="policycoreutils-semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-semanage.patch"

--- nsapolicycoreutils/semanage/semanage	2009-05-18 13:53:14.000000000 -0400
+++ policycoreutils-2.0.67/semanage/semanage	2009-07-07 16:47:35.000000000 -0400
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
+        -e, --equil      Make target equil to this paths labeling
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")
@@ -115,11 +118,14 @@
 		valid_option["node"] = []
 		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol']
 		valid_option["fcontext"] = []
-		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
+		valid_option["fcontext"] += valid_everyone + [ '-e', '--equil', '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
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
+                equil=""
 			
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
+					     'equil=',
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
+			if o == "-e"  or o == "--equil":
+				equil = a
 
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
+                                if equil == "":
+                                       OBJECT.add(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.add_equil(target, equil)
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
+                                if equil == "":
+                                       OBJECT.modify(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.modify_equil(target, equil)
 
                         return
 
@@ -405,7 +446,7 @@
 				OBJECT.delete(target, proto)
 
 			elif object == "fcontext":
-				OBJECT.delete(target, ftype)
+                                OBJECT.delete(target, ftype)
 
 			elif object == "node":
 				OBJECT.delete(target, mask, proto)

--------------030901050706040708070402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
