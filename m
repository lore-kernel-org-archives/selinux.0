Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA05112
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 11:08:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA23677
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:07:15 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA23673
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:07:15 GMT
Date: Thu, 18 Apr 2002 11:07:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy files
In-Reply-To: <20020416113842.A589C6CDB@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204181102580.5560-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 16 Apr 2002, Russell Coker wrote:

> The above is about 30% of the policy changes I've made as compared to the
> sample policy shipped on the NSA site.  It's difficult for me to send out
> anything else in a mergable form (sending a tar file of my policy directory
> probably won't be very helpful) as the rest is either too experimental, or
> has dependencies on some of the things in this message.
>
> Steve, could you please make available a patch between the released policy
> and the policy that is in your internal CVS for the next public release so I
> can follow the next development and provide suitable additions and patches?

Thanks for your work on the policy.  While I can see the importance of
merging your patches to existing elements of the example policy, I'm not
sure whether it is really optimal for us to serve as a chokepoint for all
of your new domains.  Again, it might be a good idea to start maintaining
a separate policy tree on sourceforge.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
