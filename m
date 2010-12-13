Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBDId6CJ004383
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 13:39:06 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBDId5CJ008415
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 18:39:06 GMT
Message-ID: <4D066847.4070309@redhat.com>
Date: Mon, 13 Dec 2010 13:39:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: This patch adds some output to load_policy to say which policy file
 it tries to load.
Content-Type: multipart/mixed;
 boundary="------------060907050009040900020901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060907050009040900020901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently load_policy will just fail without a decent error message.

Note:

The patch has to check if load_policy failed on a disabled machine, in
order to not report an error.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0GaEYACgkQrlYvE4MpobMxrwCg6JMdPm28IEuL2Eco++OCHThw
sYAAn2BTXe1BYCjYdzDAjnA08t0dKquQ
=N1Uu
-----END PGP SIGNATURE-----

--------------060907050009040900020901
Content-Type: text/plain;
 name="load_policy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="load_policy.patch"

diff --git a/policycoreutils/load_policy/load_policy.c b/policycoreutils/load_policy/load_policy.c
index 47d9b0f..566565f 100644
--- a/policycoreutils/load_policy/load_policy.c
+++ b/policycoreutils/load_policy/load_policy.c
@@ -1,3 +1,4 @@
+#define _GNU_SOURCE
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -23,6 +24,14 @@ void usage(char *progname)
 	exit(1);
 }
 
+char *policy_path(void) {
+	char *path=NULL;
+	if (asprintf(&path, "%s.%d", selinux_binary_policy_path(), security_policyvers()) < 0) {
+		return NULL;
+	}
+	return path;
+}
+
 int main(int argc, char **argv)
 {
 	int ret, opt, quiet = 0, nargs, init=0, enforce=0;
@@ -64,6 +73,7 @@ int main(int argc, char **argv)
 			"%s:  Warning!  Boolean file argument (%s) is no longer supported, installed booleans file is always used.  Continuing...\n",
 			argv[0], argv[optind++]);
 	}
+	errno = 0;
 	if (init) {
 		if (is_selinux_enabled() == 1) {
 			/* SELinux is already enabled, we should not do an initial load again */
@@ -76,9 +86,11 @@ int main(int argc, char **argv)
 		if (ret != 0 ) {
 			if (enforce > 0) {
 				/* SELinux in enforcing mode but load_policy failed */
+				char *path=policy_path();
 				fprintf(stderr,
-						_("%s:  Can't load policy and enforcing mode requested:  %s\n"),
-						argv[0], strerror(errno));
+						_("%s:  Can't load policy file %s and enforcing mode requested: %s\n"),
+					argv[0], path, strerror(errno));
+				free(path);
 				exit(3);
 			}
 		}
@@ -86,9 +98,16 @@ int main(int argc, char **argv)
 	else {
 		ret = selinux_mkload_policy(1);
 	}
-	if (ret < 0) {
-		fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
-			argv[0], strerror(errno));
+
+	/* selinux_init_load_policy returns -1 if it did not load_policy
+         * On SELinux disabled system it will always return -1
+         * So check errno to see if anything went wrong
+         */
+	if (ret < 0 && errno != 0) {
+		char *path=policy_path();
+		fprintf(stderr, _("%s:  Can't load policy file %s:  %s\n"),
+			argv[0], path, strerror(errno));
+		free(path);
 		exit(2);
 	}
 	exit(0);

--------------060907050009040900020901
Content-Type: application/pgp-signature;
 name="load_policy.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="load_policy.patch.sig"

iEYEABECAAYFAk0GaEcACgkQrlYvE4MpobNBkgCbBhlyKZkr8/laWUpnxwlYhxyfNeoAoJ35
Y3aTsBJY7FeJ/0Nxnnx420wX
--------------060907050009040900020901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
