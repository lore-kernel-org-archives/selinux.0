Message-ID: <47583B35.9060002@redhat.com>
Date: Thu, 06 Dec 2007 13:11:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Man page fix for matchpatchcon
Content-Type: multipart/mixed;
 boundary="------------010703040400020501000009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010703040400020501000009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHWDs1rlYvE4MpobMRAmDBAKC3EnBRz81RxtgLKcMSHnUvMqNJkwCcCyx+
QgfQjemToY0sD9lksoYX/wo=
=7auR
-----END PGP SIGNATURE-----

--------------010703040400020501000009
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/matchpathcon.8 libselinux-2.0.45/man/man8/matchpathcon.8
--- nsalibselinux/man/man8/matchpathcon.8	2007-08-03 16:02:56.000000000 -0400
+++ libselinux-2.0.45/man/man8/matchpathcon.8	2007-12-06 11:22:40.000000000 -0500
@@ -6,7 +6,12 @@
 .B matchpathcon [-V] [-N] [-n] [-f file_contexts_file ] [-p prefix ] filepath...
 .SH "DESCRIPTION"
 .B matchpathcon
-Prints the file path and the default security context associated with it.
+Queries the system and prints the default security context associated with the filepath.
+
+Note: Identical paths can have different security contexts, depending on the file type. (regular file, directory, link file, char file ...)
+
+matchpathcon will check the system default context using the file type if the file exists.  If the file does not exist, it will get the context of a regular file.
+
 .SH OPTIONS
 .B \-n
 Do not display path.


--------------010703040400020501000009
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHWDs1rlYvE4MpobMRAj26AJ4ulI7x7RnoWXKMmmA26UrJvamUjwCfdKvy/Tc/+l/6
847Ez/8pDqgw30k=
--------------010703040400020501000009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
