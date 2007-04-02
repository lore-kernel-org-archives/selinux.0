Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32HPsYK015873
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 13:25:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32HPoft001794
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 17:25:51 GMT
Subject: Re: secmark integration
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eric Paris <eparis@parisplace.org>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1175291240.20396.36.camel@localhost.localdomain>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <1175286967.3602.31.camel@localhost.localdomain>
	 <1175291240.20396.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 13:23:07 -0400
Message-Id: <1175534587.5433.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 17:47 -0400, Eric Paris wrote:
> On Fri, 2007-03-30 at 16:36 -0400, Karl MacMillan wrote:
> > On Fri, 2007-03-30 at 16:25 -0400, Eric Paris wrote:
> > > On Fri, 2007-03-30 at 15:47 -0400, Karl MacMillan wrote:
> > > > On Mon, 2007-03-19 at 10:57 -0400, James Morris wrote:
> > > > > Following some discussion of secmark integration at the developer summit, 
> > > > > one of the ideas proposed by Joshua (IIRC) was that it would be desirable 
> > > > > to have a separate table for managing the secmark rules.
> > > > > 
> [snip]
> > > > > Is there a consensus, particularly from distro folk, that having a 
> > > > > separate table would be of great benefit ?  I can post a rudimentary patch 
> > > > > soon, if needed.
> > > > > 
> > > > 
> > > > Is this really needed as long as the distro provides a way to customize
> > > > the iptables rules?
> > > 
> > > It's not just that.  The reason a new table was proposed was because
> > > people may want to iptables -F and flush their rules.  If the secmark
> > > stuff is on the main tables (filter and nat) that people use it will get
> > > blown away and there will be no automation of a boolean setting you talk
> > > about later.
> > > 
> > 
> > If we add the custom table won't we need a way to flush that? 
> 
> Sure it would still be flushable, just not how people normally go about
> turning off iptables rules.  Now to flush rules users would
> 
> iptables -F
> iptables -F -t nat
> 
> to get the secmark stuff they would also have to do
> iptables -F -t secmark
> 

That sounds fine to me, but James mentioned that the upstream acceptance
might be hard. So how do we experiment in the short term? Just don't
worry about rules getting flushed?


<snip>

> 
> 4) Find some guy who works in userspace and get him to write a tool that
> will allow you to fill in some blanks and it will create the policy,
> iptables labeling rule, and boolean settings for you.

I don't think this is a good idea for the initial rollout of secmark.
Again, the whole idea is to use the power of iptables for labeling. If
you hide that behind higher-level abstractions I think that people will
just be frustrated because they won't be able to accomplish what they
want.

Writing iptables rules is *not* the problem for acceptance. Just having
a clear way to use secmark is enough initially.
After that, we can get a good idea of what types of things people want
out of secmark and can put some tools on top.

<snip>

> 
> Maybe at some point we can ship labeling rules by default (and i don't
> know if these belong with the other 'normal' firewall rules as opposed
> to a seperate init script which just sets the secmark rules) which match
> little other than we already match in the name_{bind,connect} checks and
> can eliminate the boolean step.

Why would we? The name_* checks are effective at what they do and are
easily managed by semanage. I would rather push secmark towards things
that are currently hard to enforce (like separating traffic from two
nics).

>   But for now it seems that making it so
> that a user won't accidentally shoot themselves in the foot and products
> like 'webmin' can't hurt anything would be a good step....

Not certain that I agree. Let's make it usable for knowledgeable
sysadmins first and then try to wrap higher-level tools around this. If
it solves peoples problems they will use it with or without a gui.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
