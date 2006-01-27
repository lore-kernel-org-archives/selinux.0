Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0RHAZXf008197
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 12:10:35 -0500 (EST)
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0RHAWC1002552
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 17:10:33 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0RHAXG4014541
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 12:10:33 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0RHCnJZ147766
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 10:12:49 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0RHAWab014185
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 10:10:32 -0700
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k0RHAWAW014165
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 10:10:32 -0700
Received: from faith.austin.ibm.com (faith.austin.ibm.com [9.53.40.35])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id k0RHAVsR032914
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 11:10:31 -0600
Received: from faith.austin.ibm.com (localhost.localdomain [127.0.0.1])
	by faith.austin.ibm.com (8.13.4/8.12.8) with ESMTP id k0RH4pZF004936
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 11:04:51 -0600
Received: (from jml@localhost)
	by faith.austin.ibm.com (8.13.4/8.13.4/Submit) id k0RH4ZdB004932
	for selinux@tycho.nsa.gov; Fri, 27 Jan 2006 11:04:35 -0600
Subject: macros in old policy?
From: Joy Latten <latten@austin.ibm.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 11:04:35 -0600
Message-Id: <1138381475.29650.20.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am converting the selinux testsuite policy to reference policy.
The old test policy used the macros, can_setcon, can_setexec,
can_setfscreate. These macros are not existent in the source for 
current refpolicy. Will these macros be included in refpolicy or
obsolete, or do I write them myself in the test module, or do they map
to something else now? Just wondering what is the correct thing to do?

Regards,
Joy Latten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
