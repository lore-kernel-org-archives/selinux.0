Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m050Z1FQ006064
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2008 19:35:02 -0500
Received: from g5t0007.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m050YtXx025523
	for <selinux@tycho.nsa.gov>; Sat, 5 Jan 2008 00:35:00 GMT
Received: from g5t0007.atlanta.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 231F514329
	for <selinux@tycho.nsa.gov>; Sat,  5 Jan 2008 00:34:55 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 1851B14314
	for <selinux@tycho.nsa.gov>; Sat,  5 Jan 2008 00:34:55 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH] New take on the ingress/egress patch 
To: selinux@tycho.nsa.gov
Date: Fri, 04 Jan 2008 19:34:50 -0500
Message-ID: <20080105002920.28482.29256.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Changing the ingress/egress controls as described earlier turned out to be
easier than I thought so I'm throwing this patch out so people can get a
better idea of what I was talking about earlier.

Please note that I'm only sending out this single patch as the rest of the
patchset hasn't changed much (other than the removal of the new LSM hooks).
After I've had a chance to test these changes a bit more I'll repost the
full patchset.  In the meantime, I've updated the lblnet-2.6_testing git
tree with the latest bits and I can assure you that it at least boots and
passes basic network traffic ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
