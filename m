Message-ID: <43F1B708.3030205@cornell.edu>
Date: Tue, 14 Feb 2006 05:55:04 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
Subject: [SEMANAGE/utility] Improve usage()
Content-Type: multipart/mixed;
 boundary="------------030508000905010909080004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030508000905010909080004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Maybe it's just me, but the semanage usage() is still not making sense...
Please apply if you consider this an improvement.

1) Document arguments to -ftype
2) Give example of a list of multiple roles (space separated, quoted)
3) Specify which protocols are allowed for ports
4) Abandon alphabetical ordering for more logical ordering.
Specifically, group primary options (-a/d/m/l) together, and then have a 
section for object-specific options below.



--------------030508000905010909080004
Content-Type: text/x-patch;
 name="semanage.usage_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.usage_patch.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2006-01-27 10:00:54.000000000 -0500
+++ new/policycoreutils/semanage/semanage	2006-02-14 05:29:20.000000000 -0500
@@ -33,21 +33,36 @@ semanage user -{a|d|m} [-LrR] selinux_na
 semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
 semanage interface -{a|d|m} [-tr] interface_spec\n\
 semanage fcontext -{a|d|m} [-frst] file_spec\n\
-semanage translation -{a|d|m} [-T] level\n\
+semanage translation -{a|d|m} [-T] level\n\n\
+\
+Primary Options:\n\
+\
 	-a, --add        Add a OBJECT record NAME\n\
 	-d, --delete     Delete a OBJECT record NAME\n\
+	-m, --modify     Modify a OBJECT record NAME\n\
+	-l, --list       List the OBJECTS\n\n\
+	-h, --help       Display this message\n\
+	-n, --noheading  Do not print heading when listing OBJECTS\n\n\
+\
+Object-specific Options (see above):\n\
 	-f, --ftype      File Type of OBJECT \n\
-	-h, --help       display this message\n\
-	-l, --list       List the OBJECTS\n\
+		"" (all files) \n\
+		-- (regular file) \n\
+		-d (directory) \n\
+		-c (character device) \n\
+		-b (block device) \n\
+		-d (directory) \n\
+		-s (socket) \n\
+		-p (named pipe) \n\n\
+\
+	-p, --proto      Port protocol (tcp or udp)\n\
 	-L, --level      Default SELinux Level\n\
-	-m, --modify     Modify a OBJECT record NAME\n\
-	-n, --noheading  Do not print heading when listing OBJECTS\n\
-	-p, --proto      Port protocol\n\
-	-r, --range      MLS/MCS Security Range\n\
-	-R, --roles      SELinux Roles (Separate by spaces)\n\
-	-s, --seuser     SELinux user name\n\
+	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")\n\
+	-T, --trans      SELinux Level Translation\n\n\
+\
+	-s, --seuser     SELinux User Name\n\
 	-t, --type       SELinux Type for the object\n\
-	-T, --trans      SELinux Level Translation\n\
+	-r, --range      MLS/MCS Security Range\n\
 '
 		print message
 		sys.exit(1)

--------------030508000905010909080004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
