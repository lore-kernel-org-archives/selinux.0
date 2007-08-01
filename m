Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71FPDVQ004257
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 11:25:13 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l71FPCfE012454
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 15:25:12 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070801151257.475951538@hp.com>
Date: Wed, 01 Aug 2007 11:12:57 -0400
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 0/2] Small memory-leak patchset
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While doing some other work I found some small memory leaks with the way
we are using security_secid_to_secctx() in some of the auditing code paths.
We also had a redundant NULL pointer check in the SELinux function which frees
the leaked memory.  This patchset fixes both of these issues.

This patchset is backed against Linus' tree from this morning and has been
lightly tested.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
