Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NLja13012183
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 17:45:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2NLjYsr006097
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 21:45:34 GMT
Subject: Re: netlabel can be run in init scripts I think?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200703231623.40160.paul.moore@hp.com>
References: <46042AC3.6050006@redhat.com>
	 <200703231623.40160.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 17:46:10 -0400
Message-Id: <1174686370.28830.12.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:23 -0400, Paul Moore wrote:
> On Friday, March 23 2007 3:30:11 pm Daniel J Walsh wrote:
> > I believe this patch came from netlabel guys.
> 
> Yes it did, I believe it was posted to this list too, although I could be 
> mistaken.

Yes you sent it on March 9th; its still in my patch queue.

> That being said, I wonder if instead of init_daemon_domain() 
> init_system_domain() should be used - thoughts?

If this is actually a daemon, then the former init_daemon_domain() be
used, otherwise init_system_domain() should be used.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
