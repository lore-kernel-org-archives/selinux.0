Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21820
	for <selinux@tycho.nsa.gov>; Wed, 15 May 2002 08:49:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA13731
	for <selinux@tycho.nsa.gov>; Wed, 15 May 2002 12:48:08 GMT
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com [194.25.134.80])
        by jazzband.ncsc.mil  with ESMTP id MAA13727 for <selinux@tycho.nsa.gov>; Wed, 15 May 2002 12:48:07 GMT
Message-ID: <3CE25B66.8712FEC4@dr-baldeweg.de>
Date: Wed, 15 May 2002 14:58:14 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: avtab: out of memory
References: <Pine.GSO.4.33.0205141211560.25712-100000@raven>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Stephen Smalley schrieb:

> The security server uses atomic allocation, so it will fail if the
> allocation would sleep.  We could permit blocking allocation in the case
> of a policy reload by a userspace process, which might help.  Was your
> machine under heavy load?

No. It's only a small cvs server, without load at this time.
 
> I've loaded policies twice that size via make load without any problem,
> and switched back and forth repeatedly.  If you can reproduce the problem
> reliably and you're willing to send me the policy that triggers the
> behavior, I can also try it here.

Today I can not reproduce this error. It was not the first time and all
other times the problem disappeared after the second or third repeat. I
will send you the policy if I get this problem next time. OK?

Carsten

PS: I use the actuell package 2002050211.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
