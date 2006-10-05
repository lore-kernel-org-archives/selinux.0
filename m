Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95KkGA3002702
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 16:46:16 -0400
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95Kj3hL021704
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 20:45:04 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k95KkGBE007702
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 16:46:16 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k95KkGZv251104
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 16:46:16 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k95KkG0A011582
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 16:46:16 -0400
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.108])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k95KkFPn011550
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 16:46:16 -0400
Message-ID: <45256F11.2000103@us.ibm.com>
Date: Thu, 05 Oct 2006 15:46:09 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [PATCH] namespace.init needs to hold on to the privilages it was
 called with
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This very simple patch permits namespace.init to retain the effective 
uid of the calling process (for pam_namespace use, particularly in newrole).

Mike

-----

--- Linux-PAM-0.99.6.2/modules/pam_namespace/namespace.init   2006-06-27 
08:07:43.000000000 -0500
+++ Linux-PAM-0.99.6.2.dev/modules/pam_namespace/namespace.init 
2006-10-05 15:42:07.000000000 -0500
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/sh -p
  # This is only a boilerplate for the instance initialization script.
  # It receives polydir path as $1 and the instance path as $2.
  #


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
