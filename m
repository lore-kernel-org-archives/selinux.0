Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GF6e5n009465
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 10:06:40 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0GF7Xbl021866
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 15:07:33 GMT
Message-ID: <45ACEA2C.50908@redhat.com>
Date: Tue, 16 Jan 2007 10:07:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
CC: Ulrich Drepper <drepper@redhat.com>
Subject: I have been asked to add the following perms for NSCD.
Content-Type: multipart/mixed;
 boundary="------------080501020500050803030800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080501020500050803030800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

--------------080501020500050803030800
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

--- nsaserefpolicy/policy/flask/access_vectors	2006-11-16 17:15:00.000000000 -0500
+++ serefpolicy-2.5.1/policy/flask/access_vectors	2007-01-16 10:03:32.000000000 -0500
@@ -594,6 +594,8 @@
 	shmempwd
 	shmemgrp
 	shmemhost
+	getserv
+	shmemserv
 }
 
 # Define the access vector interpretation for controlling

--------------080501020500050803030800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
