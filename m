Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j38MU3tA009181
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2005 18:30:04 -0400 (EDT)
Received: from cunningham.myip.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j38MRFUH011542
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2005 22:27:16 GMT
Subject: getfattr works, but getfilecon doesn't
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1112999252.3261.5.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Date: Sat, 09 Apr 2005 08:27:33 +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

Thanks for the responses to my email the other day.

I've made further progress, such that I now know that the labels are
properly stored and accessible through the getfattr command, but not
through getfilecon.

I added printks to the kernel, and see them activated in the case of
getfattr, but not for getfilecon. The return code that getfilecon
received back from its getxattr call is -1.

I can keep working through this myself, but if someone knows the answer
offhand, I'd really appreciate hearing it.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
