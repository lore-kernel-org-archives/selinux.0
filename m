Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB1GpSrn006576
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 11:51:28 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB1GpR3d007367
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 16:51:28 GMT
Message-ID: <49341607.7010709@redhat.com>
Date: Mon, 01 Dec 2008 11:51:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
Subject: Problem in sepolgen
Content-Type: multipart/mixed;
 boundary="------------070400060808050004040403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070400060808050004040403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

self.roles does not exist, need to return length of dictionary.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkk0FgYACgkQrlYvE4MpobP5HwCeNgjPTSPoqBQTXa14ZA9Jc0ww
yycAoNWJhg78BXm4L5Vg9cNAdNa7ggfD
=Uz8t
-----END PGP SIGNATURE-----

--------------070400060808050004040403
Content-Type: text/plain;
 name="diffsepol"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diffsepol"

diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/access.py policycoreutils-2.0.60/sepolgen-1.0.13/src/sepolgen/access.py
--- nsasepolgen/src/sepolgen/access.py	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.60/sepolgen-1.0.13/src/sepolgen/access.py	2008-12-01 11:41:09.000000000 -0500
@@ -313,7 +313,7 @@
 
     def __len__(self):
         """Return the unique number of role allow statements."""
-        return len(self.roles)
+        return len(self.role_type.keys())
 
     def add(self, role, type):
         if self.role_types.has_key(role):

--------------070400060808050004040403
Content-Type: application/octet-stream;
 name="diffsepol.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diffsepol.sig"

iEYEABECAAYFAkk0FgYACgkQrlYvE4MpobM6IwCeKEOU9bSCTUm4Pc3RO4kQ7DijjoQAnjLg
9jb5XBZuh6CY7oQeDmJQhrL6
--------------070400060808050004040403--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
