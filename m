Message-ID: <52790D3E.4080701@redhat.com>
Date: Tue, 05 Nov 2013 10:22:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Patch to remove default encoding patch.
Content-Type: multipart/mixed;
 boundary="------------020401010607080103000607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020401010607080103000607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The default encoding patch, was never upstreamed.  default_encoding module
switched python2 to always use unicode.  Potentially in some languages
semanage will blow up when errors are reported.

The need for this patch is going away in python3, which should be the default
in Fedora 21/22.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ5DT4ACgkQrlYvE4MpobMvrgCfcEvZY4q7F17q9dbYJrHJXpae
Ut8AoM2TP99Ca0/lJAjoMTGsqr50P35/
=BHTe
-----END PGP SIGNATURE-----

--------------020401010607080103000607
Content-Type: text/x-patch;
 name="semanage_default_encoding.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="semanage_default_encoding.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index bd6c526..36b41cd 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -23,7 +23,6 @@
 #
 #
 
-import policycoreutils.default_encoding_utf8
 import argparse
 import seobject
 import sys

--------------020401010607080103000607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
