Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6HIlXOc014520
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 14:47:33 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6HIlWf6006037
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 18:47:32 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6HIlW9k006277
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 14:47:32 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6HIlVl8010282
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 14:47:32 -0400
Received: from redsox.boston.devel.redhat.com (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m6HIlVl0006809
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 14:47:31 -0400
Message-ID: <487F93C3.1040701@redhat.com>
Date: Thu, 17 Jul 2008 14:47:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Critical bug in semanage
Content-Type: multipart/mixed;
 boundary="------------030204020402000001080202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030204020402000001080202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

homedirs in /var and /usr/local were not being matched, causing bad
context to be added.

genhomedircon port problem.

An extra / at the end of the regex was causing the problem

Geesh I love 'C'.  :^P
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh/k8IACgkQrlYvE4MpobPojgCggaXEFTVV+JdunE/jLOjhiTff
+E4AoOSIYWVPVlRJ2w7LAo7ewCmt/+KY
=xb2w
-----END PGP SIGNATURE-----

--------------030204020402000001080202
Content-Type: text/plain;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.25/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2008-06-12 23:25:16.000000000 -0400
+++ libsemanage-2.0.25/src/genhomedircon.c	2008-07-17 14:32:45.000000000 -0400
@@ -192,6 +193,11 @@
 			goto done;
 	}
 
+	if (ustr_cmp_suffix_cstr_eq(expr, "/")) {
+		if (!ustr_del(&expr, 1))
+			goto done;
+	}
+
 	/* Append pattern to eat up trailing slashes */
 	if (!ustr_add_cstr(&expr, "/*$"))
 		goto done;

--------------030204020402000001080202
Content-Type: application/octet-stream;
 name="libsemanage-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-rhat.patch.sig"

iEYEABECAAYFAkh/k8MACgkQrlYvE4MpobOAVwCgkw4/LA/cT0athHzZxKpgT1LGBa8AoNjB
XHrXZZmBbiL76exo+P9ECRa3
--------------030204020402000001080202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
