Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UKPM6M002331
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 16:25:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UKPMnf007563
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 20:25:22 GMT
Subject: Re: secmark integration
From: Eric Paris <eparis@parisplace.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1175284031.3602.24.camel@localhost.localdomain>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 16:25:09 -0400
Message-Id: <1175286309.20396.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 15:47 -0400, Karl MacMillan wrote:
> On Mon, 2007-03-19 at 10:57 -0400, James Morris wrote:
> > Following some discussion of secmark integration at the developer summit, 
> > one of the ideas proposed by Joshua (IIRC) was that it would be desirable 
> > to have a separate table for managing the secmark rules.
> > 
> > This is technically possible (and we could also look at adding hooks for 
> > the load_policy permission to be called for manipulating rules in this 
> > table), but probably difficult to justify upstream: you should only do 
> > something in the kernel if it can't be done in userspace.
> > 
> > I think we can make a good argument, though, based on it being for MAC 
> > rules rather than DAC, in that the _type_ of security being managed is 
> > fundamentally different, and that the table is likely being managed in 
> > conjunction with SELinux policy.
> > 
> > Is there a consensus, particularly from distro folk, that having a 
> > separate table would be of great benefit ?  I can post a rudimentary patch 
> > soon, if needed.
> > 
> 
> Is this really needed as long as the distro provides a way to customize
> the iptables rules?

It's not just that.  The reason a new table was proposed was because
people may want to iptables -F and flush their rules.  If the secmark
stuff is on the main tables (filter and nat) that people use it will get
blown away and there will be no automation of a boolean setting you talk
about later.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
