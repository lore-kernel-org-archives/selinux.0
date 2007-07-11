Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6BFuTKj021530
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2007 11:56:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6BFuS0O009065
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2007 15:56:28 GMT
Message-ID: <4694FDA6.3060603@redhat.com>
Date: Wed, 11 Jul 2007 11:56:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Additional permission checks for nscd
Content-Type: multipart/mixed;
 boundary="------------000101050701040206040009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000101050701040206040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000101050701040206040009
Content-Type: text/x-patch;
 name="flask.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flask.diff"

--- nsaserefpolicy/policy/flask/access_vectors	2007-06-19 16:23:34.000000000 -0400
+++ serefpolicy-3.0.2/policy/flask/access_vectors	2007-07-11 10:06:28.000000000 -0400
@@ -598,6 +598,8 @@
 	shmempwd
 	shmemgrp
 	shmemhost
+	getserv
+	shmemserv
 }
 
 # Define the access vector interpretation for controlling

--------------000101050701040206040009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
