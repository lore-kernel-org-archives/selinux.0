Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBMJiSF5004670
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2010 14:44:28 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBMJiRC3003099
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2010 19:44:27 GMT
Message-ID: <4D125518.8030405@redhat.com>
Date: Wed, 22 Dec 2010 14:44:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Checkpolicy patch to allow version of single digit.
Content-Type: multipart/mixed;
 boundary="------------010700050606000109050001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010700050606000109050001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently policy will not build if I define a module as 1

policy_module(dan,1) Fails


policy_module(dan,1.0) works

The attached patch makes the first one work.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0SVRMACgkQrlYvE4MpobPxtwCgl8LkinM6WrJdz1UIqMmJJHlE
URoAnA1iXReaVdA8Tjk9PRoZjK+CZn96
=Pamv
-----END PGP SIGNATURE-----

--------------010700050606000109050001
Content-Type: text/plain;
 name="checkpolicy-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="checkpolicy-rhat.patch"

diff --exclude-from=exclude -N -u -r nsacheckpolicy/policy_parse.y checkpolicy-2.0.22/policy_parse.y
--- nsacheckpolicy/policy_parse.y	2010-05-19 14:45:51.000000000 -0400
+++ checkpolicy-2.0.22/policy_parse.y	2010-06-16 08:08:37.000000000 -0400
@@ -755,6 +755,8 @@
                         ;
 version_identifier      : VERSION_IDENTIFIER
                         { if (insert_id(yytext,0)) return -1; }
+			| number
+                        { if (insert_id(yytext,0)) return -1; }
                         | ipv4_addr_def /* version can look like ipv4 address */
                         ;
 avrules_block           : avrule_decls avrule_user_defs

--------------010700050606000109050001
Content-Type: application/pgp-signature;
 name="checkpolicy-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="checkpolicy-rhat.patch.sig"

iEYEABECAAYFAk0SVRgACgkQrlYvE4MpobNFAwCgmWiiidzpT9R43+VHolUyWJMA30sAn2aT
Drf9SJLM0WsYjL6huoczf2/q
--------------010700050606000109050001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
