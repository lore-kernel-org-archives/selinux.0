Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n24Kfdkt013060
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:41:40 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n24Kc330012415
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 20:38:03 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n24KfcCR011405
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:41:38 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n24KfcQW017381
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:41:38 -0500
Received: from dhcp-100-2-12.bos.redhat.com (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n24KfbnT015824
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:41:38 -0500
Message-ID: <49AEE781.5030301@redhat.com>
Date: Wed, 04 Mar 2009 15:41:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to getdefaultcon to print just the correct match and add verbose
 option
Content-Type: multipart/mixed;
 boundary="------------070402090405080707090903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070402090405080707090903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I really want to rename this to selinuxdefaultcon, which is what we ship
in Fedora.

Also exit with proper error on failure.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmu54AACgkQrlYvE4MpobNoZACdHgQDP2Hp/KDBpGCD7G08HjOX
p68An25Uu83SlOqjKyy9EG8ZgdIcuTCB
=L6UU
-----END PGP SIGNATURE-----

--------------070402090405080707090903
Content-Type: text/plain;
 name="libselinux-getdefaultcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-getdefaultcon.patch"

--- nsalibselinux/utils/getdefaultcon.c	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.78/utils/getdefaultcon.c	2009-03-04 15:23:52.000000000 -0500
@@ -22,8 +22,9 @@
 	security_context_t usercon = NULL, cur_context = NULL;
 	char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL, *dlevel=NULL;
 	int ret, opt;
+	int verbose = 0;
 
-	while ((opt = getopt(argc, argv, "l:r:")) > 0) {
+	while ((opt = getopt(argc, argv, "l:r:v")) > 0) {
 		switch (opt) {
 		case 'l':
 			level = strdup(optarg);
@@ -31,6 +32,9 @@
 		case 'r':
 			role = strdup(optarg);
 			break;
+		case 'v':
+			verbose = 1;
+			break;
 		default:
 			usage(argv[0], "invalid option", 1);
 		}
@@ -66,9 +70,13 @@
 	}
 	if (ret < 0)
 		perror(argv[0]);
-	else
-		printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context, seuser, role, level, usercon);
-
+	else {
+		if (verbose) {
+			printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context, seuser, role, level, usercon);
+		} else {
+			printf("%s", usercon);
+		}
+	}
 
 	free(role);
 	free(seuser);
@@ -76,5 +84,5 @@
 	free(dlevel);
 	free(usercon);
 
-	return 0;
+	return ret >= 0;
 }

--------------070402090405080707090903
Content-Type: application/pgp-signature;
 name="libselinux-getdefaultcon.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="libselinux-getdefaultcon.patch.sig"

iEYEABECAAYFAkmu54AACgkQrlYvE4MpobMG5ACfbpo8JV0dwOp2uS5JmVjgjdhZOk4AnR/U
+MUq9UCIGAq0sTf4DhN7RE15
--------------070402090405080707090903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
