Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3KHXQ7V031371
	for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2006 13:33:28 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3KHXPOt016998
	for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2006 17:33:25 GMT
Subject: razor
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 13:34:22 -0400
Message-Id: <1145554462.18861.8.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was converting the razor policy to refpolicy, and I noticed that the
razor_t domain is not reachable.  Looking at the razor_access() macro,
it seems as if what really should be done is to transition to razor_t
and give the other access given in that macro to razor_t.  Any thoughts?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
