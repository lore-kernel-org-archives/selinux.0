Message-ID: <46115278.4020401@redhat.com>
Date: Mon, 02 Apr 2007 14:59:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: restorecon single fs patch]
Content-Type: multipart/mixed;
 boundary="------------090208060508060001000005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090208060508060001000005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch to tell restorecon to only do one file system.

-------- Original Message --------
Subject: 	restorecon single fs patch
Date: 	Mon, 02 Apr 2007 14:54:36 -0400
From: 	Jeremy Katz <katzj@redhat.com>
To: 	dwalsh@redhat.com



Attached.  And from a quick test, works quite nicely

Jeremy



--------------090208060508060001000005
Content-Type: text/x-patch;
 name="policycoreutils-restorecon-onefsys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-restorecon-onefsys.patch"

--- policycoreutils-2.0.7/restorecon/restorecon.c.onefs	2007-04-02 14:35:37.000000000 -0400
+++ policycoreutils-2.0.7/restorecon/restorecon.c	2007-04-02 14:48:05.000000000 -0400
@@ -16,6 +16,7 @@
  * -v	Show changes in file labels.  
  * -o	filename save list of files with incorrect context
  * -F	Force reset of context to match file_context for customizable files
+ * -l   Limit directory tree walk to a single filesystem
  *
  * pathname...	The file(s) to label 
  *
@@ -50,6 +51,7 @@
 static int recurse = 0;
 static int file_exist = 1;
 static int force = 0;
+static int onefs = 0;
 #define STAT_BLOCK_SIZE 1
 static int pipe_fds[2] = { -1, -1 };
 static unsigned long long count = 0;
@@ -326,13 +328,15 @@
 			rc = fork();
 		if (rc == 0) {
 			close(pipe_fds[0]);
-			nftw(buf, pre_stat, 1024, FTW_PHYS);
+			nftw(buf, pre_stat, 1024, 
+                             FTW_PHYS | (onefs ? FTW_MOUNT : 0));
 			exit(1);
 		}
 		if (rc > 0)
 			close(pipe_fds[1]);
 		if (rc == -1 || rc > 0) {
-			if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
+			if (nftw(buf, apply_spec, 1024, 
+                                 FTW_PHYS | (onefs ? FTW_MOUNT : 0))) {
 				if (!file_exist && errno == ENOENT)
 					return;
 				fprintf(stderr,
@@ -367,11 +371,14 @@
 
 	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 
-	while ((opt = getopt(argc, argv, "ipFrRnvf:o:e:")) > 0) {
+	while ((opt = getopt(argc, argv, "ipFrRnvfl:o:e:")) > 0) {
 		switch (opt) {
 		case 'n':
 			change = 0;
 			break;
+                case 'l':
+                    onefs = 1;
+                    break;
 		case 'i':
 			file_exist = 0;
 			break;


--------------090208060508060001000005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
