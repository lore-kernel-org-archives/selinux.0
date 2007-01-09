Message-ID: <45A3B064.1090103@redhat.com>
Date: Tue, 09 Jan 2007 10:10:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: newrole patch
Content-Type: multipart/mixed;
 boundary="------------010106040706050502070104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010106040706050502070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Only uses file descriptor = 0

Reads securetty_context file for matches

--------------010106040706050502070104
Content-Type: text/x-patch;
 name="policycoreutils-newrole.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-newrole.patch"

--- nsapolicycoreutils/newrole/newrole.c	2007-01-04 17:01:41.000000000 -0500
+++ policycoreutils-1.33.10/newrole/newrole.c	2007-01-09 10:09:19.000000000 -0500
@@ -741,6 +741,7 @@
 	char *level_s = NULL;	/* level spec'd by user in argv[] */
 	char *range_ptr = NULL;
 	security_context_t new_con = NULL;
+	security_context_t tty_con = NULL;
 	context_t context = NULL; /* manipulatable form of new_context */
 	const struct option long_options[] = {
 		{"role", 1, 0, 'r'},
@@ -793,6 +794,15 @@
 					"specified\n"));
 				return -1;
 			}
+			if (fgetfilecon(0,&tty_con) >= 0) {
+				if (selinux_check_securetty_context(tty_con) != 1) {
+					fprintf(stderr, "Error: you are not allowed to change levels on a non secure terminal\n");
+					freecon(tty_con);
+					return -1;
+				}
+				freecon(tty_con);
+			}
+
 			level_s = optarg;
 			break;
 		default:

--------------010106040706050502070104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
