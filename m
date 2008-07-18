Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IHG2kI027900
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:16:02 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IHG1oF007296
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 17:16:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6IHG161016236
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:16:01 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6IHG1uB022680
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:16:01 -0400
Received: from redsox.boston.devel.redhat.com (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m6IHG041008387
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:16:00 -0400
Message-ID: <4880CFD1.1040102@redhat.com>
Date: Fri, 18 Jul 2008 13:16:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to make libselinux shut up when SELinux is disabled.
Content-Type: multipart/mixed;
 boundary="------------010705040100060008070301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010705040100060008070301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

SELinux complains about things like restorecon or rpm when conflicts
exist in file_context file even when SELinux is disabled.

It should just shut up....

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiAz9AACgkQrlYvE4MpobMO6wCdGC7kvnHsss5gBkQGy1s10MzS
WgIAn2Ryd93w9zfVihfDKyGa8M78E21W
=hwEi
-----END PGP SIGNATURE-----

--------------010705040100060008070301
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/callbacks.c libselinux-2.0.67/src/callbacks.c
--- nsalibselinux/src/callbacks.c	2008-06-12 23:25:14.000000000 -0400
+++ libselinux-2.0.67/src/callbacks.c	2008-07-18 11:15:56.000000000 -0400
@@ -16,6 +16,7 @@
 {
 	int rc;
 	va_list ap;
+	if (is_selinux_enabled() == 0) return 0;
 	va_start(ap, fmt);
 	rc = vfprintf(stderr, fmt, ap);
 	va_end(ap);

--------------010705040100060008070301
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkiAz9EACgkQrlYvE4MpobNtnQCgynDgPRWFEpFBkPb5AxMN6qp+9TsAoKWm
Ie1NTKByR39+TvX5phimRPDF
--------------010705040100060008070301--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
