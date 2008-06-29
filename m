Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5TCXYUB019365
	for <selinux@tycho.nsa.gov>; Sun, 29 Jun 2008 08:33:34 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5TCXX8t000809
	for <selinux@tycho.nsa.gov>; Sun, 29 Jun 2008 12:33:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5TCXX67024191
	for <selinux@tycho.nsa.gov>; Sun, 29 Jun 2008 08:33:33 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5TCXVaC004619
	for <selinux@tycho.nsa.gov>; Sun, 29 Jun 2008 08:33:33 -0400
Received: from localhost.localdomain (vpn-12-28.rdu.redhat.com [10.11.12.28])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5TCXSFQ021142
	for <selinux@tycho.nsa.gov>; Sun, 29 Jun 2008 08:33:30 -0400
Message-ID: <4867811A.9040103@redhat.com>
Date: Sun, 29 Jun 2008 08:33:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch for libselinux man page submitted by Karel Zack
Content-Type: multipart/mixed;
 boundary="------------000704040707040506050200"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000704040707040506050200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Submitted in bugzilla

https://bugzilla.redhat.com/show_bug.cgi?id=452868

--------------000704040707040506050200
Content-Type: text/plain;
 name="libselinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux.patch"

diff -up libselinux-2.0.67/man/man3/freecon.3.kzak libselinux-2.0.67/man/man3/freecon.3
--- libselinux-2.0.67/man/man3/freecon.3.kzak	2008-06-25 16:22:59.000000000 +0200
+++ libselinux-2.0.67/man/man3/freecon.3	2008-06-25 16:22:28.000000000 +0200
@@ -15,6 +15,11 @@ frees the memory allocated for a securit
 .B freeconary
 frees the memory allocated for a context array.
 
+If
+.I con
+is NULL, no operation is performed.
+
+
 .SH "SEE ALSO"
 .BR selinux "(8)"

--------------000704040707040506050200--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
