Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88J3gwF015560
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:42 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88J3dg7004068
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 19:03:40 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m88J3YpV013610
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:35 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m88J3XmH011437
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:33 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m88J3Xag023477
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:33 -0400
Message-ID: <48C57707.3090906@redhat.com>
Date: Mon, 08 Sep 2008 15:03:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: fixfiles fixes
Content-Type: multipart/mixed;
 boundary="------------020409080704000203050305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020409080704000203050305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Removes all files from /tmp, previous one would leave /tmp/.a and /tmp/.b

Fixed context on unlabeled_t and file_t files in /tmp and /var/tmp.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjFdwYACgkQrlYvE4MpobMZJACfRsCuVFja3fvYZYtptyW2h3lH
yAQAn0xmDAYELt+res60OIcL3UDrUFRv
=09W1
-----END PGP SIGNATURE-----

--------------020409080704000203050305
Content-Type: text/plain;
 name="policycoreutils_scripts_fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils_scripts_fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.55/scripts/fixfiles	2008-09-08 14:08:57.000000000 -0400
@@ -139,14 +139,14 @@
 LogReadOnly
 ${SETFILES} -q ${OUTFILES} ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
 rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
-find /tmp -context "*:file_t*" -exec chcon -t tmp_t {} \;
-find /var/tmp -context "*:file_t*" -exec chcon -t tmp_t {} \;
+find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
+find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
 exit $?
 }
 
 fullrelabel() {
     logit "Cleaning out /tmp"
-    rm -rf /tmp/.??* /tmp/*
+    find /tmp/ -mindepth 1 -print0 | xargs -0 /bin/rm -f
     LogReadOnly
     restore
 }


--------------020409080704000203050305
Content-Type: application/octet-stream;
 name="policycoreutils_scripts_fixfiles.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils_scripts_fixfiles.patch.sig"

iEYEABECAAYFAkjFdwYACgkQrlYvE4MpobPySwCfV5bkJWddzDeyChdUiDFiWYK6PbwAn2LX
8RRdiPbTanLVEJS0vNVUrORr
--------------020409080704000203050305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
