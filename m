Message-ID: <470E8186.2050307@redhat.com>
Date: Thu, 11 Oct 2007 16:03:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fix semodule option handling
Content-Type: multipart/mixed;
 boundary="------------020009070609070303080901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020009070609070303080901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

semodule -B lksjdlj

will blow up.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHDoGGrlYvE4MpobMRAnWHAKCWIP/cHhbcwOjyc19RSqcvW2zAkACgscin
BYK2/vMCU9tpuZH2RB3NrJ4=
=lkqh
-----END PGP SIGNATURE-----

--------------020009070609070303080901
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semodule/semodule.c policycoreutils-2.0.29/semodule/semodule.c
--- nsapolicycoreutils/semodule/semodule.c	2007-09-26 19:37:44.000000000 -0400
+++ policycoreutils-2.0.29/semodule/semodule.c	2007-10-11 15:59:39.000000000 -0400
@@ -249,11 +249,12 @@
 		 * arguments as args. Will allow 'semodule -i *.pp' to
 		 * work as expected.
 		 */
-		if (commands[num_commands - 1].mode == INSTALL_M) {
+
+		if (commands && commands[num_commands - 1].mode == INSTALL_M) {
 			mode = INSTALL_M;
-		} else if (commands[num_commands - 1].mode == UPGRADE_M) {
+		} else if (commands && commands[num_commands - 1].mode == UPGRADE_M) {
 			mode = UPGRADE_M;
-		} else if (commands[num_commands - 1].mode == REMOVE_M) {
+		} else if (commands && commands[num_commands - 1].mode == REMOVE_M) {
 			mode = REMOVE_M;
 		} else {
 			fprintf(stderr, "unknown additional arguments:\n");

--------------020009070609070303080901
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHDoGGrlYvE4MpobMRAv21AKDk9v01So7OqSNnrptJrYpEFpCu3QCgwwuxSi7RMq4M
LVLJPGpvUPnyHNs=
--------------020009070609070303080901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
