Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8UCsWo3029273
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:54:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8UCsWOS029080
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 12:54:33 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8UCsWSb019787
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:54:32 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8UCsLbt002911
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:54:32 -0400
Received: from localhost.localdomain (vpn-10-13.bos.redhat.com [10.16.10.13])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m8UCsKte017873
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:54:20 -0400
Message-ID: <48E2217A.8040306@redhat.com>
Date: Tue, 30 Sep 2008 08:54:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: matchpathcon -V does not always work as expected.
Content-Type: multipart/mixed;
 boundary="------------030302090605020701080104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030302090605020701080104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

matchpathcon -V should be passing the mode when checking whether the
file context on a file is correct.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjiIXoACgkQrlYvE4MpobPXJwCeOgcA2Zj05Mwdmqv0NGxyl3RZ
lr8AmwYglOU6ubFXO0r9jh1Z2v6cAO9u
=wk/a
-----END PGP SIGNATURE-----

--------------030302090605020701080104
Content-Type: text/plain;
 name="libselinux-matchpathcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-matchpathcon.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/utils/matchpathcon.c libselinux-2.0.71/utils/matchpathcon.c
--- nsalibselinux/utils/matchpathcon.c	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/utils/matchpathcon.c	2008-09-26 10:21:43.000000000 -0400
@@ -106,12 +106,12 @@
 
 		if (verify) {
 			if (quiet) {
-				if (selinux_file_context_verify(argv[i], 0))
+				if (selinux_file_context_verify(argv[i], mode))
 					continue;
 				else
 					exit(1);
 			}
-			if (selinux_file_context_verify(argv[i], 0)) {
+			if (selinux_file_context_verify(argv[i], mode)) {
 				printf("%s verified.\n", argv[i]);
 			} else {
 				security_context_t con;

--------------030302090605020701080104
Content-Type: application/octet-stream;
 name="libselinux-matchpathcon.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-matchpathcon.patch.sig"

iEYEABECAAYFAkjiIXoACgkQrlYvE4MpobN9JwCbBEgq5gfHfU3zGrxOmE8yD1vSatIAn2yX
jJ274FUdYb7pyx4BSq2ZiZee
--------------030302090605020701080104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
