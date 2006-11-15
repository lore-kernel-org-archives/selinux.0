Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAFKwrbe004330
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 15:58:55 -0500
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAFKvGu5006847
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 20:57:16 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAFKx3uj002292
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 15:59:03 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAFKwxB6121284
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 15:58:59 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAFKww4a021891
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 15:58:58 -0500
Subject: anyway to reverse a dontaudit rule?
From: Joy Latten <latten@austin.ibm.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 15 Nov 2006 12:47:28 -0600
Message-Id: <1163616448.17737.368.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a way to reverse a dontaudit rule without having to
modify and recompile base policy? 
I need to see the audit message to help determine what permissions
are being denied for a particular application.

Regards,
Joy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
