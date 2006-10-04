Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94NcAZg004141
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 19:38:10 -0400
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94NawuV002816
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 23:36:59 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k94NcAEa014636
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 19:38:10 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k94NcAuT329120
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 17:38:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k94Nc9QS014933
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 17:38:10 -0600
Subject: How are SAs created in Eric's kernel?
From: Joy Latten <latten@austin.ibm.com>
To: vyekkirala@TrustedCS.com
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 04 Oct 2006 18:26:10 -0500
Message-Id: <1160004370.7146.121.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am about to start a stress test for labeled ipsec and ran into a
question about change to create SAs. 

I am running labeled ipsec. If after I start racoon, I do ping, an
SA is created with context root:sysadm_r:ping_t:s0-s15:c0.c1023.
This looks right to me. But when I issue an sftp, or start my stress
test with netperf, I notice that no new SAs are created. Looks like I am
using the same one. Is this correct? I am afraid I am missing some
logic, thus my question. I thought a new SA would be created per socket
and mls level? It appears to be per flow... Oh, my ipsec spd label is
system_u:object_r:unconfined_t:s2, for no particular reason but to test.

Sorry to bombard you with so many questions. :-) I am using Eric's
kernel. 

Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
