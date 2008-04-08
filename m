Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m38E04KF029480
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 10:00:04 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m38E03BF016232
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 14:00:03 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m38DwnH9003609
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 09:58:49 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m38DwnGX016551
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 09:58:49 -0400
Received: from localhost.localdomain (dhcp-10-12-34-104.boston.devel.redhat.com [10.12.34.104])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m38DwmiA006484
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 09:58:49 -0400
Message-ID: <47FB7A26.6020604@redhat.com>
Date: Tue, 08 Apr 2008 09:59:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: semanage man page updated for booleans
Content-Type: multipart/mixed;
 boundary="------------020507010407090701010306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020507010407090701010306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------020507010407090701010306
Content-Type: text/plain;
 name="diff.part003"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.part003"

--- nsapolicycoreutils/semanage/semanage.8	2008-04-08 09:37:21.000000000 -0400
+++ policycoreutils-2.0.46/semanage/semanage.8	2008-04-08 09:35:46.000000000 -0400
@@ -3,7 +3,9 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {login|user|port|interface|fcontext|translation} \-l [\-n]
+.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] 
+.br
+.B semanage boolean \-{d|m} [\-T] boolean
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
@@ -43,6 +45,9 @@
 .I                \-d, \-\-delete     
 Delete a OBJECT record NAME
 .TP
+.I                \-D, \-\-deleteall
+Remove all OBJECTS local customizations
+.TP
 .I                \-f, \-\-ftype
 File Type.   This is used with fcontext.
 Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.

--------------020507010407090701010306
Content-Type: application/pgp-signature;
 name="diff.part003.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff.part003.sig"

iEYEABECAAYFAkf7eh8ACgkQrlYvE4MpobOW9gCfWe0Y/mr1MxYyWNOFTh0hpExHWzgAn0Jt
yFz7258Hpv/A7Re6XB4rrVSo
--------------020507010407090701010306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
