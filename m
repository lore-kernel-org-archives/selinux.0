Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA19444
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 13:00:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04204
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 18:00:04 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA04193
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 18:00:03 GMT
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA09040
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 09:59:12 -0800 (PST)
	mail_from (casey@sgi.com)
Received: from sgi.com (sgigate.sgi.com [198.29.75.75])
	by cthulhu.engr.sgi.com (SGI-8.9.3/8.9.3) with ESMTP id KAA49925
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 10:00:16 -0800 (PST)
Message-ID: <3A9A99B1.D4DADBB8@sgi.com>
Date: Mon, 26 Feb 2001 10:00:17 -0800
From: Casey Schaufler <casey@sgi.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: questions...
References: <200102232049.PAA11442@coalstack.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Pete Loscocco wrote:

> If the modifications to SELinux to allow selective override of DAC (or
> any other capability that Linux currently has) that were suggested were
> made, what you get is a system that:
> 
> - still has the current DAC policy. SELinux doesn't change the existing
>   DAC mechanism. That is not being proposed here.

Yes it is. The proposed policy changes the DAC behavior
of the system. If you had a good set of regression tests
they would indicate a failure.

> - enforces a MAC policy which can allow certain processes, depending on
>   security attributes of the process, to override the DAC mechanism to
>   access files, depending on the security attributes of the file.

At which point you have introduced interactions between the
MAC, DAC, and Privilege mechanisms. At this point you no longer
have seperate policies.

>   This is just a refinement ...

I don't see it as a refinement. I see the argument
presented as a rationalization.

> I would say that this is good. If what SELinux has now supports a
> [DM]AC policy, what is being proposed still does, only in an even more
> useful way. If what SELinux does is not supporting a [DM]AC policy, the
> goal of a [DM]AC policy perhaps should be questioned.

OKay. Seperate MAC, and DAC policies can be bad, and
integrated policies can be good.

Don't mind me. I just spent a dozen years trying to
get people to accept MAC on it's own, and it's been tough.
Go ahead, have MAC whomp all over the permission bits
that the populous has finaly figured out how to use.
No sweat off my nose, really.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 888.220.0607

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
