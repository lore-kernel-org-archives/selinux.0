From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ivan Gyurdiev <ivg2@cornell.edu>
Subject: Re: [SEMANAGE] Further bugfixes
Date: Sat, 21 Jan 2006 01:22:50 +1100
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
References: <43D0383C.8010404@cornell.edu> <200601202321.07517.russell@coker.com.au> <43D0D8E2.2020304@cornell.edu>
In-Reply-To: <43D0D8E2.2020304@cornell.edu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EJP0DRPbUDfOqey"
Message-Id: <200601210123.00315.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_EJP0DRPbUDfOqey
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 20 January 2006 23:34, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > The convention is that anything within [] is optional, however it is not
> > optional to have one of 'a', 'd', or 'm', it is required to have exactly
> > one of them.
>
> Technically -p is required for ports, since it is part of the port key.
> Also, there's required parameters on add that you must enter (but I
> guess this is better left out of the manpage).

It's best that nothing is left out of the man page!  I've attached a patch for 
that as well as documenting the -n option.

> > I would offer a patch for this, but I think we have enough unmerged
> > patches for the semanage utility floating around at the moment.  Once we
> > get the current patches sorted out I'll be happy to write a patch for
> > this.
>
> I think most of them have been merged, but I'm not sure which ones
> you're referring to.

I have just realised that they were merged without anyone mentioning it.  I've 
become used to a notification of patches accepted for merging - or more 
recently notification of my patches being too buggy for merging.  :-#

I've attached a patch to semanage to make the usage() function display the 
same stuff as the man page (a good plan for the future would be to have an 
automatically generated man page such as used in coreutils).

Also I've made it warn when you set a flag that's not appropriate for the 
action you are performing.  Note that the actual warning messages are 
extremely terse (I wasn't feeling inspired for creative writing) but the code 
that calls them is unlikely to need improvement.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_EJP0DRPbUDfOqey
Content-Type: text/x-diff;
  charset="utf-8";
  name="semanage.8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="semanage.8.diff"

--- semanage.8.orig	2006-01-21 00:11:46.000000000 +1100
+++ semanage.8	2006-01-21 00:24:34.000000000 +1100
@@ -3,13 +3,13 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {login|user|port|interface|fcontext} \-l
+.B semanage {login|user|port|interface|fcontext} \-l [\-n]
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
 .B semanage user \-{a|d|m} [\-LrR] selinux_name
 .br
-.B semanage port \-{a|d|m} [\-tp] port_number
+.B semanage port \-{a|d|m} \-p protocol [\-t] port_number
 .br
 .B semanage interface \-{a|d|m} [\-tr] interface_spec
 .br
@@ -45,6 +45,9 @@
 .I                \-l, \-\-list       
 List the OBJECTS
 .TP
+.I                \-n, \-\-noheading       
+Do not print heading when listing OBJECTS
+.TP
 .I                \-L, \-\-level
 Default SELinux Level for SELinux use. (s0)
 .TP

--Boundary-00=_EJP0DRPbUDfOqey
Content-Type: text/x-diff;
  charset="utf-8";
  name="semanage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="semanage.diff"

--- semanage.orig	2006-01-21 00:21:18.000000000 +1100
+++ semanage	2006-01-21 01:20:47.000000000 +1100
@@ -30,12 +30,13 @@
 
 	def usage(message = ""):
 		print '\
-semanage fcontext [-admhfrst] INTERFACE\n\
-semanage interface [-admtr] INTERFACE\n\
-semanage login [-admsr] LOGIN_NAME\n\
-semanage port [-admtpr] PORT | PORTRANGE\n\
-semanage translation [-adm] LEVEL\n\
-semanage user [-admLRr] SELINUX_USER\n\
+semanage {login|user|port|interface|fcontext} -l\n\
+semanage login -{a|d|m} [-sr] login_name\n\
+semanage user -{a|d|m} [-LrR] selinux_name\n\
+semanage port -{a|d|m} -p protocol [-t] port_number\n\
+semanage interface -{a|d|m} [-tr] interface_spec\n\
+semanage translation -{a|d|m} [-T] level\n\
+semanage fcontext -{a|d|m} [-frst] file_spec\n\
 	-a, --add        Add a OBJECT record NAME\n\
 	-d, --delete     Delete a OBJECT record NAME\n\
 	-f, --ftype      File Type of OBJECT \n\
@@ -60,6 +61,30 @@
 		sys.stderr.flush()
 		sys.exit(1)
 
+	def unwanted_ftype():
+		if ftype != "":
+			sys.stderr.write("ftype not used\n");
+	def unwanted_selevel():
+		if selevel != "":
+			sys.stderr.write("level not used\n");
+	def unwanted_proto():
+		if proto != "":
+			sys.stderr.write("proto not used\n");
+	def unwanted_roles():
+		if roles != "":
+			sys.stderr.write("role not used\n");
+	def unwanted_serange():
+		if serange != "":
+			sys.stderr.write("range not used\n");
+	def unwanted_seuser():
+		if seuser != "":
+			sys.stderr.write("seuser not used\n");
+	def unwanted_setype():
+		if setype != "":
+			sys.stderr.write("type not used\n");
+	def unwanted_setrans():
+		if setrans != "":
+			sys.stderr.write("trans not used\n");
 	#
 	# 
 	#
@@ -124,7 +149,7 @@
 			if o == "-h" or o == "--help":
 				usage()
 
-			if o == "-n" or o == "--nohead":
+			if o == "-n" or o == "--noheading":
 				heading=0
 
 			if o == "-m"or o == "--modify":
@@ -159,25 +184,91 @@
 			if o == "-v" or o == "--verbose":
 				verbose = 1
 
+# Note in this section I intentionally leave the unwanted_*() functions for
+# variabled which are wanted commented out and don't delete those lines.  This
+# will make it easier to modify the code when the list of wanted variables
+# changes.
 		if object == "login":
+			if not delete:
+				unwanted_ftype()
+				unwanted_selevel()
+				unwanted_proto()
+				unwanted_roles()
+#				unwanted_serange()
+#				unwanted_seuser()
+				unwanted_setype()
+				unwanted_setrans()
 			OBJECT = seobject.loginRecords()
 
 		if object == "user":
+			if not delete:
+				unwanted_ftype()
+#				unwanted_selevel()
+				unwanted_proto()
+#				unwanted_roles()
+#				unwanted_serange()
+				unwanted_seuser()
+				unwanted_setype()
+				unwanted_setrans()
 			OBJECT = seobject.seluserRecords()
 
 		if object == "port":
+			if not delete:
+				unwanted_ftype()
+				unwanted_selevel()
+#				unwanted_proto()
+				unwanted_roles()
+				unwanted_serange()
+				unwanted_seuser()
+#				unwanted_setype()
+				unwanted_setrans()
 			OBJECT = seobject.portRecords()
 		
 		if object == "interface":
+			if not delete:
+				unwanted_ftype()
+				unwanted_selevel()
+				unwanted_proto()
+				unwanted_roles()
+#				unwanted_serange()
+				unwanted_seuser()
+#				unwanted_setype()
+				unwanted_setrans()
 			OBJECT = seobject.interfaceRecords()
 		
 		if object == "fcontext":
+			if not delete:
+#				unwanted_ftype()
+				unwanted_selevel()
+				unwanted_proto()
+				unwanted_roles()
+#				unwanted_serange()
+#				unwanted_seuser()
+#				unwanted_setype()
+				unwanted_setrans()
 			OBJECT = seobject.fcontextRecords()
 		
 		if object == "translation":
+			if not delete:
+				unwanted_ftype()
+				unwanted_selevel()
+				unwanted_proto()
+				unwanted_roles()
+				unwanted_serange()
+				unwanted_seuser()
+				unwanted_setype()
+#				unwanted_setrans()
 			OBJECT = seobject.setransRecords()
 		
 		if list:
+			unwanted_ftype()
+			unwanted_selevel()
+			unwanted_proto()
+			unwanted_roles()
+			unwanted_serange()
+			unwanted_seuser()
+			unwanted_setype()
+			unwanted_setrans()
 			OBJECT.list(heading)
 			sys.exit(0);
 			
@@ -232,6 +323,16 @@
 			sys.exit(0);
 
 		if delete:
+			if object != "fcontext":
+				unwanted_ftype()
+			unwanted_selevel()
+			if object == "port":
+				unwanted_proto()
+			unwanted_roles()
+			unwanted_serange()
+			unwanted_seuser()
+			unwanted_setype()
+			unwanted_setrans()
 			if object == "port":
 				OBJECT.delete(target, proto)
 

--Boundary-00=_EJP0DRPbUDfOqey--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
