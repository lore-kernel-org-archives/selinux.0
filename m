Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBAMpnRb000658
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 17:51:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBAMpmRV001794
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 22:51:48 GMT
Received: from hawaii.efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
        by jazzband.ncsc.mil  with ESMTP id hBAMpkta001791 for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 22:51:47 GMT
Received: from hawaii.efficax.net (localhost [127.0.0.1])
	by hawaii.efficax.net (8.12.8/8.12.8) with ESMTP id hBAMphQd019184
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 16:51:43 -0600
Received: (from nick@localhost)
	by hawaii.efficax.net (8.12.8/8.12.8/Submit) id hBAMpgo7019182
	for selinux@tycho.nsa.gov; Wed, 10 Dec 2003 16:51:43 -0600
Subject: changing root to default to sysadm_r
From: Nick <nagray@austin.rr.com>
Reply-To: nagray@austin.rr.com
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1071096702.4060.948.camel@hawaii.efficax.net>
Mime-Version: 1.0
Date: Wed, 10 Dec 2003 16:51:42 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I thought I could do make root come up in the sysadm_r initially by
changing the users.te file

diff users .users
42c42
< user root roles { sysadm_r staff_r };
---
> user root roles { staff_r sysadm_r };

and recompiling the policy.

Apparently not, suggestions! and comments why it is not this way
already.

-- 
Nick (Nix) Gray
Senior Systems Engineer
Bruzenak Inc.
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
