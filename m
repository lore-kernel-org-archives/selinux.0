Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA26051
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 11:54:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA21352
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 16:54:30 GMT
Received: from listproc.corp.loudcloud.com (olly.loudcloud.com [208.50.142.100])
	by jazzband.ncsc.mil  with ESMTP id QAA21348
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 16:54:30 GMT
Received: from loudcloud.com (goat.maude.corp.loudcloud.com [192.168.29.242])
	by listproc.corp.loudcloud.com (8.10.1/8.10.1) with ESMTP id f19GsVE11259
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 08:54:31 -0800 (PST)
Message-ID: <3A842131.56C5210@loudcloud.com>
Date: Fri, 09 Feb 2001 08:56:17 -0800
From: Daniel Harrison <danielh@loudcloud.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Cature the flag (was Re: Selinux kernel patches)
References: <200102091033.AA740426066@bladestorm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

In case some people haven't seen it, there has been a thread on the Vuln-Dev list hosted by securityfocus.com talking about the right and wrong way to do this. Some vendors have been participating in the discussion. I would definitely suggest checking out the archives of that list.

-dan

paul wrote:

> I have always felt that the best way to test a piece of software is the same way that any scientist would test a hypothesis.  The hypothesis here is that the software is secure.  So in order to test that hypothesis you have to have people that test that software for security holes.
>
> In my opinion, finishing a piece of software and then inviting the whole planet to try and "hack" it for $200 and a free shirt is just not the best way to approach this.  You will end up with people from all over the planet not only attacking the system but also the network, including other systems on the same wire that are gathering packets, routers, and perhaps even the upstream provider.  Sure, you can say that all these are off limits, but people will simply not care as has been shown by these kind of "tests" over and over and over.
>
> What we intend to do at Bladestorm is to integrate all the efforts here into our distribution and conduct a controlled test, where the software is tested by security professionals.  It will be probed and tested thoroughly, we would report our findings, patch, reprobe, and then after that cycle is done we will do a beta.  And the beta would be to put the distribution into environments where the software can be tested.  This way, we can eliminate variables such as routers going down and so forth and really be able to pinpoint holes.
>
> Public stunts like this is more like handing 2,000 people a can opener and telling them all to try to be the first to open a can.  You end up with a mess, and a lot of spilled tomato soup.  It's just not worth it from my vantage point.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
