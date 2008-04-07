Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m37NDCXO003503
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 19:13:12 -0400
Received: from QMTA10.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m37NCuZL017027
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 23:13:12 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 0/3] Some SELinux patches for 2.6.26
To: selinux@tycho.nsa.gov
Date: Mon, 07 Apr 2008 19:10:55 -0400
Message-ID: <20080407230647.8052.79603.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here are three patches I'd like to throw out for 2.6.26.  The first you have
already seen, it's the secid/secctx cleanup patch with some feedback
incorporated (and a sign-off).  The second patch is a tweak of the network
node cache that was introduced in 2.6.25 which should make cache additions
faster and less kludgy.  The third, and final, patch is the network port cache
that was suggested several months ago; it is similar to the existing network
interface and port cacheseseses.

All have gone through various levels of testing on various states of Rawhide
but I just did another simple boot/ping/ssh test on today's Rawhide without
any drama.  If they look okay to everyone please consider these for 2.6.26.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
