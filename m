Message-ID: <4787DC7A.9010408@redhat.com>
Date: Fri, 11 Jan 2008 16:15:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patch 
Content-Type: multipart/mixed;
 boundary="------------060201060402090204090207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060201060402090204090207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Make sepolgen-ifgen return errors.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeH3HkACgkQrlYvE4MpobNe3ACeN095D7eEMgV1K6YlWMtXX1ck
6JoAniapk+chTq3cOQ3kqWZbvYhwEAAf
=Eslh
-----END PGP SIGNATURE-----

--------------060201060402090204090207
Content-Type: text/plain;
 name="policycoreutils-sepolgen.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-sepolgen.patch"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2allow/sepolgen-ifgen policycoreutils-2.0.35/audit2allow/sepolgen-ifgen
--- nsapolicycoreutils/audit2allow/sepolgen-ifgen	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.35/audit2allow/sepolgen-ifgen	2008-01-11 11:17:46.000000000 -0500
@@ -80,7 +80,10 @@
     if_set.to_file(f)
     f.close()
 
-    return 0
+    if refparser.success:
+        return 0
+    else:
+        return 1
     
 if __name__ == "__main__":
     sys.exit(main())

--------------060201060402090204090207
Content-Type: application/octet-stream;
 name="policycoreutils-sepolgen.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-sepolgen.patch.sig"

iEYEABECAAYFAkeH3HoACgkQrlYvE4MpobNJSgCgjV9IeXQqjxTc04VpwROdjFW6qW0An35F
wMWnbwfnnr5A94xQhJT4ZxDY
--------------060201060402090204090207--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
