Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8UCr1eI028901
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:53:01 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8UCpwP9015942
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 12:51:58 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8UCr0FU019545
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:53:00 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8UCr0T2002498
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:53:00 -0400
Received: from localhost.localdomain (vpn-10-13.bos.redhat.com [10.16.10.13])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m8UCr0gi017624
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 08:53:00 -0400
Message-ID: <48E2212A.3020004@redhat.com>
Date: Tue, 30 Sep 2008 08:52:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Yet another man page patch
Content-Type: multipart/mixed;
 boundary="------------050402030903010107070405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050402030903010107070405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

int selinux_file_context_cmp(const security_context_t a,
+                                    const security_context_t b);"
+
+.BI "int selinux_file_context_verify(const char *path, mode_t mode);"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjiISoACgkQrlYvE4MpobPV9gCg0KZ+rsxGsIalBS1qvbObK7bA
0H8Anj8FnGzOnSjnOfbk+5R4Bf2OyxW+
=nJ7k
-----END PGP SIGNATURE-----

--------------050402030903010107070405
Content-Type: text/plain;
 name="libselinux_man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux_man.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/matchpathcon.3 libselinux-2.0.71/man/man3/matchpathcon.3
--- nsalibselinux/man/man3/matchpathcon.3	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/man/man3/matchpathcon.3	2008-09-26 10:21:43.000000000 -0400
@@ -18,6 +18,11 @@
 
 .BI "void set_matchpathcon_flags(unsigned int " flags ");"
 
+.BI "int selinux_file_context_cmp(const security_context_t a,
+				     const security_context_t b);"
+
+.BI "int selinux_file_context_verify(const char *path, mode_t mode);"
+
 .SH "DESCRIPTION"
 .B matchpathcon_init
 loads the file contexts configuration specified by
@@ -111,6 +116,12 @@
 .B MATCHPATHCON_BASEONLY
 flag is set, then only the base file contexts configuration file
 will be processed, not any dynamically generated entries or local customizations.
+.sp
+.B selinux_file_context_cmp
+compares two file contexts to see if their differences are "significant", the function runs the strcmp function ignoring the user componant of the file context.  
+.sp
+.B selinux_file_context_verify
+compares the file context on disk to the system default.
 
 .sp
 .SH "RETURN VALUE"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_file_context_cmp.3 libselinux-2.0.71/man/man3/selinux_file_context_cmp.3
--- nsalibselinux/man/man3/selinux_file_context_cmp.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_file_context_cmp.3	2008-09-26 10:21:43.000000000 -0400
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_file_context_verify.3 libselinux-2.0.71/man/man3/selinux_file_context_verify.3
--- nsalibselinux/man/man3/selinux_file_context_verify.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/selinux_file_context_verify.3	2008-09-26 10:21:43.000000000 -0400
@@ -0,0 +1 @@
+.so man3/matchpathcon.3

--------------050402030903010107070405
Content-Type: application/octet-stream;
 name="libselinux_man.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux_man.patch.sig"

iEYEABECAAYFAkjiISoACgkQrlYvE4MpobOvsQCffcb7a4agTVVB5Mx8TVMTcAjfBBQAn3Qv
fMaJbaPmimHDMmukTLH/LXae
--------------050402030903010107070405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
