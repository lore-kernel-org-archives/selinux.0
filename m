Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BHWJpb002483
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:32:19 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BHWGGQ006827
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:32:17 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Wed, 11 Apr 2007 13:32:04 -0400
Cc: vyekkirala@TrustedCS.com, John Wan <J.Wan@mbs.edu>, selinux@tycho.nsa.gov
References: <000301c77c4b$83b18870$cc0a010a@tcssec.com> <461D1464.7070607@manicmethod.com>
In-Reply-To: <461D1464.7070607@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704111332.04613.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, April 11 2007 1:01:24 pm Joshua Brindle wrote:
> Venkat Yekkirala wrote:
> > Just FYI-I did propose filtering in the filter table in the past,
> > and this has been on my todo list.
> >
> > "Implementation issues aside, lately I have been wondering about doing
> > something in the filter table using something we could call secfilter
> > or so.
> >
> > You would still use secmark to label the packets, but they (along with
> > any external labels) could get filtered in the secfilter module. This
> > way we could control what external labels could come thru from what
> > peers. For internal labels it would be more of an assurance thing. This
> > would also automatically take care of forwarding controls."
> >
> > More at: http://marc.info/?l=selinux&m=116232831800159&w=2
>
> so from what I gather the secfilter module would be querying the selinux
> policy to determine whether or not to drop something, that would mean a
> change in iptables changes the enforcement policy (not just the labeling
> policy as is the case now) which is a little disconcerting.

It a tradeoff: we gain the flexibility of the iptables packet/connection 
matching rules but we rely on the rules to be present.  It's very similar in 
principal to the discussions that have been going on with SECMARK; I suspect 
we can solve this problem in a similar manner.

> How does this work into the idea we had during the summit about SELinux
> having its own table? The table would presumably be a mangle table for
> labeling but could it also be a filter table? I'm not clear on what is
> possible in netfilter.

I'm not a netfilter expert myself, although I'm learning more and more about 
it each day.  I don't see how this couldn't fit into the proposed 
LSM/SELinux/security table in fact I think I mentioned something like this at 
one point (although, maybe it was just to myself).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
