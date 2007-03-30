Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UKcRnC002780
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 16:38:27 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UKcQQO027189
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 20:38:26 GMT
Subject: Re: secmark integration
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eric Paris <eparis@parisplace.org>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1175286309.20396.13.camel@localhost.localdomain>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 16:36:07 -0400
Message-Id: <1175286967.3602.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 16:25 -0400, Eric Paris wrote:
> On Fri, 2007-03-30 at 15:47 -0400, Karl MacMillan wrote:
> > On Mon, 2007-03-19 at 10:57 -0400, James Morris wrote:
> > > Following some discussion of secmark integration at the developer summit, 
> > > one of the ideas proposed by Joshua (IIRC) was that it would be desirable 
> > > to have a separate table for managing the secmark rules.
> > > 
> > > This is technically possible (and we could also look at adding hooks for 
> > > the load_policy permission to be called for manipulating rules in this 
> > > table), but probably difficult to justify upstream: you should only do 
> > > something in the kernel if it can't be done in userspace.
> > > 
> > > I think we can make a good argument, though, based on it being for MAC 
> > > rules rather than DAC, in that the _type_ of security being managed is 
> > > fundamentally different, and that the table is likely being managed in 
> > > conjunction with SELinux policy.
> > > 
> > > Is there a consensus, particularly from distro folk, that having a 
> > > separate table would be of great benefit ?  I can post a rudimentary patch 
> > > soon, if needed.
> > > 
> > 
> > Is this really needed as long as the distro provides a way to customize
> > the iptables rules?
> 
> It's not just that.  The reason a new table was proposed was because
> people may want to iptables -F and flush their rules.  If the secmark
> stuff is on the main tables (filter and nat) that people use it will get
> blown away and there will be no automation of a boolean setting you talk
> about later.
> 

If we add the custom table won't we need a way to flush that? If so,
would we add an iptables --no-really-flush command? If we want to
preserve the iptables with no rules means all traffic is allowed
semantic we need to somehow coordinate rule removal with the policy.
Options I see:

1) Change iptables to flip a boolean. This sucks because we need some
way for iptables to know which boolean to flip.

2) Have the kernel mechanism stop enforcement of rules that rely on
secmark when the tables are empty / flushed.

3) Tell people to not do this - instead use distro scripts with
integration. This seems unlikely to work.

So, what about 2?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
