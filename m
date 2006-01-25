Message-ID: <43D7A46C.7020605@redhat.com>
Date: Wed, 25 Jan 2006 11:16:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils 1.29.10
References: <1138044857.20815.142.camel@moss-spartans.epoch.ncsc.mil> <1138193526.20815.309.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138193526.20815.309.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090207020004040403050300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090207020004040403050300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Mon, 2006-01-23 at 14:34 -0500, Stephen Smalley wrote:
>   
>> I committed policycoreutils 1.29.10 on Friday, but looks like rawhide
>> still has 1.29.9?  It has the patches from Ivan and Russell for
>> semanage, and your patches for chcat.8 and genhomedircon merged.
>>     
>
> Ping?
>
>   
I just built 1.29.11.  I was waiting for some mods to libsemanage to 
handle semanage_user_set_roles

but I build it anyways.  Modify of users does not work, until this 
swigify is fixed.

Dan

Here is my latest diff also, mainly  adding translation support to 
semanage and cleaning up some of the error reporting.



--------------090207020004040403050300
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-1.29.10/scripts/chcat
--- nsapolicycoreutils/scripts/chcat	2006-01-19 16:00:44.000000000 -0500
+++ policycoreutils-1.29.10/scripts/chcat	2006-01-20 17:17:02.000000000 -0500
@@ -356,7 +356,7 @@
 
         if list_ind==0 and len(cmds) < 1:
             usage()
-    except:
+    except ValueError, e:
         usage()
 
     if delete_ind:
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-1.29.10/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2006-01-20 10:37:37.000000000 -0500
+++ policycoreutils-1.29.10/semanage/semanage	2006-01-20 15:17:56.000000000 -0500
@@ -30,28 +30,27 @@
 
 	def usage(message = ""):
 		print '\
-semanage {login|user|port|interface|fcontext} -l\n\
+semanage {login|user|port|interface|fcontext|translation} -l [-n] \n\
 semanage login -{a|d|m} [-sr] login_name\n\
 semanage user -{a|d|m} [-LrR] selinux_name\n\
-semanage port -{a|d|m} -p protocol [-t] port_number\n\
+semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
 semanage interface -{a|d|m} [-tr] interface_spec\n\
-semanage translation -{a|d|m} [-T] level\n\
 semanage fcontext -{a|d|m} [-frst] file_spec\n\
+semanage translation -{a|d|m} [-T] level\n\
 	-a, --add        Add a OBJECT record NAME\n\
 	-d, --delete     Delete a OBJECT record NAME\n\
 	-f, --ftype      File Type of OBJECT \n\
 	-h, --help       display this message\n\
 	-l, --list       List the OBJECTS\n\
 	-L, --level      Default SELinux Level\n\
-	-n, --noheading  Do not print heading when listing OBJECTS\n\
 	-m, --modify     Modify a OBJECT record NAME\n\
-	-P, --proto      Port protocol\n\
+	-n, --noheading  Do not print heading when listing OBJECTS\n\
+	-p, --proto      Port protocol\n\
 	-r, --range      MLS/MCS Security Range\n\
 	-R, --roles      SELinux Roles (Separate by spaces)\n\
 	-s, --seuser     SELinux user name\n\
 	-t, --type       SELinux Type for the object\n\
 	-T, --trans      SELinux Level Translation\n\
-	-v, --verbose    verbose output\n\
 '
 		print message
 		sys.exit(1)
@@ -62,35 +61,29 @@
 		sys.stderr.flush()
 		sys.exit(1)
 
-	def unwanted_ftype():
-		if ftype != "":
-			sys.stderr.write("ftype not used\n");
-	def unwanted_selevel():
-		if selevel != "":
-			sys.stderr.write("level not used\n");
-	def unwanted_proto():
-		if proto != "":
-			sys.stderr.write("proto not used\n");
-	def unwanted_roles():
-		if roles != "":
-			sys.stderr.write("role not used\n");
-	def unwanted_serange():
-		if serange != "":
-			sys.stderr.write("range not used\n");
-	def unwanted_seuser():
-		if seuser != "":
-			sys.stderr.write("seuser not used\n");
-	def unwanted_setype():
-		if setype != "":
-			sys.stderr.write("type not used\n");
-	def unwanted_setrans():
-		if setrans != "":
-			sys.stderr.write("trans not used\n");
+	def get_options():
+		valid_option={}
+		valid_everyone=[ '-a', '--add', '-d', '--delete', '-m', '--modify', '-l', '--list', '-h', '--help', '-n', '--noheading' ]
+		valid_option["login"] = []
+		valid_option["login"] += valid_everyone + [ '-s', '--seuser', '-r', '--range']
+		valid_option["user"] = []
+		valid_option["user"] += valid_everyone + [ '-L', '--level', '-r', '--range', '-R', '--roles' ] 
+		valid_option["port"] = []
+		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
+		valid_option["port"] = []
+		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--protocol' ] 
+		valid_option["interface"] = []
+		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
+		valid_option["fcontext"] = []
+		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
+		valid_option["translation"] = []
+		valid_option["fcontext"] += valid_everyone + [ '-T', '--trans' ] 
+		return valid_option
+
 	#
 	# 
 	#
 	try:
-		objectlist = ("login", "user", "port", "interface", "fcontext", "translation")
 		input = sys.stdin
 		output = sys.stdout
 		serange = ""
@@ -112,12 +105,14 @@
 			usage("Requires 2 or more arguments")
 			
 		object = sys.argv[1]
-		if object not in objectlist:
+		option_dict=get_options()
+		if object not in option_dict.keys():
 			usage("%s not defined" % object)
 			
 		args = sys.argv[2:]
+
 		gopts, cmds = getopt.getopt(args,
-					    'adf:lhmnp:P:s:R:L:r:t:vT:',
+					    'adf:lhmnp:s:R:L:r:t:vT:',
 					    ['add',
 					     'delete',
 					     'ftype=',
@@ -125,16 +120,18 @@
 					     'list', 
 					     'modify',
 					     'noheading',
-					     'port=',
 					     'proto=',
 					     'seuser=',
 					     'range=',
 					     'level=',
 					     'roles=',
 					     'type=',
-					     'trans=',
-					     'verbose'
+					     'trans='
 					     ])
+		for o, a in gopts:
+			if o not in option_dict[object]:
+				sys.stderr.write("%s not valid for %s objects\n" % ( o, object) );
+				
 		for o,a in gopts:
 			if o == "-a" or o == "--add":
 				if modify or delete:
@@ -167,11 +164,11 @@
 			if o == "-L" or o == '--level':
 				selevel = a
 
-			if o == "-P" or o == '--proto':
+			if o == "-p" or o == '--proto':
 				proto = a
 
 			if o == "-R" or o == '--roles':
-				roles = roles + " " + a
+				roles = a
 
 			if o == "-s" or o == "--seuser":
 				seuser = a
@@ -185,91 +182,25 @@
 			if o == "-v" or o == "--verbose":
 				verbose = 1
 
-# Note in this section I intentionally leave the unwanted_*() functions for
-# variabled which are wanted commented out and don't delete those lines.  This
-# will make it easier to modify the code when the list of wanted variables
-# changes.
 		if object == "login":
-			if not delete:
-				unwanted_ftype()
-				unwanted_selevel()
-				unwanted_proto()
-				unwanted_roles()
-#				unwanted_serange()
-#				unwanted_seuser()
-				unwanted_setype()
-				unwanted_setrans()
 			OBJECT = seobject.loginRecords()
 
 		if object == "user":
-			if not delete:
-				unwanted_ftype()
-#				unwanted_selevel()
-				unwanted_proto()
-#				unwanted_roles()
-#				unwanted_serange()
-				unwanted_seuser()
-				unwanted_setype()
-				unwanted_setrans()
 			OBJECT = seobject.seluserRecords()
 
 		if object == "port":
-			if not delete:
-				unwanted_ftype()
-				unwanted_selevel()
-#				unwanted_proto()
-				unwanted_roles()
-				unwanted_serange()
-				unwanted_seuser()
-#				unwanted_setype()
-				unwanted_setrans()
 			OBJECT = seobject.portRecords()
 		
 		if object == "interface":
-			if not delete:
-				unwanted_ftype()
-				unwanted_selevel()
-				unwanted_proto()
-				unwanted_roles()
-#				unwanted_serange()
-				unwanted_seuser()
-#				unwanted_setype()
-				unwanted_setrans()
 			OBJECT = seobject.interfaceRecords()
 		
 		if object == "fcontext":
-			if not delete:
-#				unwanted_ftype()
-				unwanted_selevel()
-				unwanted_proto()
-				unwanted_roles()
-#				unwanted_serange()
-#				unwanted_seuser()
-#				unwanted_setype()
-				unwanted_setrans()
 			OBJECT = seobject.fcontextRecords()
 		
 		if object == "translation":
-			if not delete:
-				unwanted_ftype()
-				unwanted_selevel()
-				unwanted_proto()
-				unwanted_roles()
-				unwanted_serange()
-				unwanted_seuser()
-				unwanted_setype()
-#				unwanted_setrans()
 			OBJECT = seobject.setransRecords()
 		
 		if list:
-			unwanted_ftype()
-			unwanted_selevel()
-			unwanted_proto()
-			unwanted_roles()
-			unwanted_serange()
-			unwanted_seuser()
-			unwanted_setype()
-			unwanted_setrans()
 			OBJECT.list(heading)
 			sys.exit(0);
 			
@@ -324,16 +255,6 @@
 			sys.exit(0);
 
 		if delete:
-			if object != "fcontext":
-				unwanted_ftype()
-			unwanted_selevel()
-			if object == "port":
-				unwanted_proto()
-			unwanted_roles()
-			unwanted_serange()
-			unwanted_seuser()
-			unwanted_setype()
-			unwanted_setrans()
 			if object == "port":
 				OBJECT.delete(target, proto)
 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.29.10/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2006-01-20 10:37:37.000000000 -0500
+++ policycoreutils-1.29.10/semanage/semanage.8	2006-01-20 15:10:15.000000000 -0500
@@ -3,19 +3,19 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {login|user|port|interface|fcontext} \-l [\-n]
+.B semanage {login|user|port|interface|fcontext|translation} \-l [\-n]
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
 .B semanage user \-{a|d|m} [\-LrR] selinux_name
 .br
-.B semanage port \-{a|d|m} \-p protocol [\-t] port_number
+.B semanage port \-{a|d|m} [\-tr] [\-p protocol] port | port_range
 .br
 .B semanage interface \-{a|d|m} [\-tr] interface_spec
 .br
-.B semanage translation \-{a|d|m} [\-T] level
-.br
 .B semanage fcontext \-{a|d|m} [\-frst] file_spec
+.br
+.B semanage translation \-{a|d|m} [\-T] level
 .P
 
 This tool is used to configure SELinux policy
@@ -35,34 +35,34 @@
 .I                \-d, \-\-delete     
 Delete a OBJECT record NAME
 .TP
-.I                \-h, \-\-help       
-display this message
-.TP
 .I                \-f, \-\-ftype
 File Type.   This is used with fcontext.
 Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
 .TP
+.I                \-h, \-\-help       
+display this message
+.TP
 .I                \-l, \-\-list       
 List the OBJECTS
 .TP
-.I                \-n, \-\-noheading       
-Do not print heading when listing OBJECTS
-.TP
 .I                \-L, \-\-level
 Default SELinux Level for SELinux use. (s0)
 .TP
 .I                \-m, \-\-modify     
 Modify a OBJECT record NAME
 .TP
+.I                \-n, \-\-noheading  
+Do not print heading when listing OBJECTS.
+.TP
 .I                \-p, \-\-proto
 Protocol for the specified port (tcp|udp).
 .TP
-.I                \-R, \-\-role
-SELinux Roles (Separate by spaces)
-.TP
 .I                \-r, \-\-range      
 MLS/MCS Security Range
 .TP
+.I                \-R, \-\-role
+SELinux Roles.  You must inclose multiple roles within quotes, separate by spaces.
+.TP
 .I                \-s, \-\-seuser     
 SELinux user name
 .TP

--------------090207020004040403050300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
