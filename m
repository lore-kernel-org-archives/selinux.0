Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n58JE7j4003720
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:14:07 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n58JESeX005640
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 19:14:28 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n58JE6WW026330
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:14:06 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n58JE5ME026419
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:14:05 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n58JE5dY030479
	for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2009 15:14:05 -0400
Message-ID: <4A2D62FA.9030505@redhat.com>
Date: Mon, 08 Jun 2009 15:14:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: libsemanage spelling mistake in error code.
Content-Type: multipart/mixed;
 boundary="------------040905070500060903090600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040905070500060903090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040905070500060903090600
Content-Type: text/plain;
 name="libsemanage-handle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-handle.patch"

--- nsalibsemanage/src/handle.c	2008-11-14 17:10:15.000000000 -0500
+++ libsemanage-2.0.31/src/handle.c	2009-06-02 14:54:20.000000000 -0400
@@ -264,7 +264,7 @@
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);

--------------040905070500060903090600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
