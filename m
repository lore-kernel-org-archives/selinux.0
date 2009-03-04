Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n24KdYFp012898
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:39:34 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n24KdXtr026226
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 20:39:33 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n24KdXdb010749
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:39:33 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n24KdXPW016616
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:39:33 -0500
Received: from dhcp-100-2-12.bos.redhat.com (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n24KdW3E015341
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:39:32 -0500
Message-ID: <49AEE703.306@redhat.com>
Date: Wed, 04 Mar 2009 15:39:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch matchpathcon to eliminate file "/" 
Content-Type: multipart/mixed;
 boundary="------------030204030603020908020509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030204030603020908020509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So

matchpathcon /etc/
Will work the same as
matchpathcon /etc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmu5wMACgkQrlYvE4MpobNK4gCgiVeXXEZcCMsJKXM7jqh6r1u3
OScAoLcmXBIR63gpvA8RS3g07pcPC6IF
=e+Re
-----END PGP SIGNATURE-----

--------------030204030603020908020509
Content-Type: text/plain;
 name="libselinux-matchpathcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-matchpathcon.patch"

--- nsalibselinux/utils/matchpathcon.c	2008-10-28 10:06:51.000000000 -0400
+++ libselinux-2.0.78/utils/matchpathcon.c	2009-03-04 15:23:52.000000000 -0500
@@ -101,6 +101,11 @@
 	for (i = optind; i < argc; i++) {
 		int mode = 0;
 		struct stat buf;
+		int len = strlen(argv[i]);
+		if (len > 1  && argv[i][len - 1 ] == '/') {
+			argv[i][len - 1 ] = '\0';
+		}
+
 		if (lstat(argv[i], &buf) == 0)
 			mode = buf.st_mode;
 

--------------030204030603020908020509
Content-Type: application/pgp-signature;
 name="libselinux-matchpathcon.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="libselinux-matchpathcon.patch.sig"

iEYEABECAAYFAkmu5wMACgkQrlYvE4MpobM81gCffRgQiOsSB684/9Duj6GABKVTDScAnA0d
lg8kxal+yaAeyLGohO4hywq+
--------------030204030603020908020509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
