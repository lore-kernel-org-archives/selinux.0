Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2DNgiNR011684
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:42:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2DNgf3k028926
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 23:42:41 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2DNgen8008568
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:42:40 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2DNgd2F017155
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:42:39 -0400
Received: from localhost.localdomain (dhcp-10-12-34-104.boston.devel.redhat.com [10.12.34.104])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m2DNgdjU020693
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 19:42:39 -0400
Message-ID: <47D9BBEE.5090105@redhat.com>
Date: Thu, 13 Mar 2008 19:42:38 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux/matchpathcon has a memory leak
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com>
In-Reply-To: <47D9B8BB.2080402@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060406060406010406040804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060406060406010406040804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The attached patch fixes the leaks.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfZu+0ACgkQrlYvE4MpobPbRQCeOFM6HzBGz2N3l56z+yvHEGwl
/7sAnjiJkOYsJFZcR8yXrVCdOl3iRFT5
=+kwB
-----END PGP SIGNATURE-----

--------------060406060406010406040804
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/label.c libselinux-2.0.59/src/label.c
--- nsalibselinux/src/label.c	2007-07-16 14:20:46.000000000 -0400
+++ libselinux-2.0.59/src/label.c	2008-03-13 19:40:24.000000000 -0400
@@ -95,7 +95,7 @@
 	if (compat_validate(rec, lr, "file_contexts", 0))
 		return NULL;
 
-	if (translating &&
+	if (translating && (! lr->ctx_trans) &&
 	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
 		return NULL;
 
@@ -131,6 +131,7 @@
 void selabel_close(struct selabel_handle *rec)
 {
 	rec->func_close(rec);
+	free(rec->data);
 	free(rec);
 }
 

--------------060406060406010406040804
Content-Type: application/pgp-signature;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff.sig"

iEYEABECAAYFAkfZu+4ACgkQrlYvE4MpobOjhwCcDT2JDOZnHxyjGPo9IWsiFVnL+ykAoI5r
H3QPBrhfZPklWNMqZpgWrqK+
--------------060406060406010406040804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
