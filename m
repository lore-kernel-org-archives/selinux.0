Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MJf1gA009132
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:41:01 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MJZPKk007365
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 19:35:25 GMT
Subject: Dropping unused booleans
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 15:38:16 -0400
Message-Id: <1122061096.13068.152.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While testing reference policy, I realized that there are booleans that
weren't being used -- they were declared but not actually used in an
if() statement.  In my case, I was testing a targeted policy, and all of
the policies that did use the booleans were excluded.  It seems that
this is a bad thing.  Since conditional policy is used as a
configuration for setting, it provides the system operator/admin with an
option which has no effect, and thus is extremely misleading.  It seems
especially important to not have useless options showing up since this
affects operators, which may know nothing about the policy.

I think the best place to happen would be in checkpolicy/libsepol, since
it has the complete policy's true and false lists for each bool.  It
would drop the boolean and throw a non-fatal warning message.  Thoughts?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
