From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [SEMANAGE] Further bugfixes
Date: Sat, 21 Jan 2006 01:39:42 +1100
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   Stephen Smalley <sds@tycho.nsa.gov>
References: <43D0383C.8010404@cornell.edu> <43D0D8E2.2020304@cornell.edu> <43D0EDA1.5070002@redhat.com>
In-Reply-To: <43D0EDA1.5070002@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5YP0DkNQG6cQVFS"
Message-Id: <200601210139.53555.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_5YP0DkNQG6cQVFS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 21 January 2006 01:03, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -R "user_r sysadm_t secadm_r"
>
> works or at least should work.

The attached patch does everything my last patch does but also adds support 
for multiple -R options.

A more sensible (IMHO) and more script-friendly way of doing this is to 
support -R user_r -R sysadm_r -R secadm_r.  Naturally my patch doesn't break 
the existing functionality, just allows doing it either way.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_5YP0DkNQG6cQVFS
Content-Type: text/x-diff;
  charset="utf-8";
  name="semanage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="semanage.diff"

--- semanage.orig	2006-01-21 00:21:18.000000000 +1100
+++ semanage	2006-01-21 01:29:35.000000000 +1100
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
@@ -145,7 +170,7 @@
 				proto = a
 
 			if o == "-R" or o == '--roles':
-				roles = a
+				roles = roles + " " + a
 
 			if o == "-s" or o == "--seuser":
 				seuser = a
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
 

--Boundary-00=_5YP0DkNQG6cQVFS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
