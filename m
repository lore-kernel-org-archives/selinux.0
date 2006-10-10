Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AHLuo7022671
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 13:21:57 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AHKevk021089
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 17:20:41 GMT
Received: from smtp1.fc.hp.com (smtp-test.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 4098E3449B
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 13:21:55 -0400 (EDT)
Message-Id: <20061010171524.936739000@hp.com>
Date: Tue, 10 Oct 2006 13:15:25 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Subject: [RFC 0/2] NetLabel changes for Reference policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These two patches are my first attempt at converting the policy modules Klaus
and I have been working on for NetLabel into something that could be included
in both the Reference policy and the shipping RHEL/FC policies.  While I have
done some basic testing with these changes the usefullness of the testing is
still questionable as it is using a non-standard kernel (net-2.6 still will not
boot for me).  Once the next RHEL5/lspp.52 kernel becomes available I will
redo my testing and post an updated patchset.  In the meantime, I would
appreciate it if all of the policy experts could take a look and comment on the
changes in the patches.

Thank you.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
