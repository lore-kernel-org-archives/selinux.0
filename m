Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2ULmAjv005505
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 17:48:10 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2ULm9nf020398
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 21:48:09 GMT
Subject: Re: secmark integration
From: Eric Paris <eparis@parisplace.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1175286967.3602.31.camel@localhost.localdomain>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <1175286967.3602.31.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 17:47:20 -0400
Message-Id: <1175291240.20396.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 16:36 -0400, Karl MacMillan wrote:
> On Fri, 2007-03-30 at 16:25 -0400, Eric Paris wrote:
> > On Fri, 2007-03-30 at 15:47 -0400, Karl MacMillan wrote:
> > > On Mon, 2007-03-19 at 10:57 -0400, James Morris wrote:
> > > > Following some discussion of secmark integration at the developer summit, 
> > > > one of the ideas proposed by Joshua (IIRC) was that it would be desirable 
> > > > to have a separate table for managing the secmark rules.
> > > > 
[snip]
> > > > Is there a consensus, particularly from distro folk, that having a 
> > > > separate table would be of great benefit ?  I can post a rudimentary patch 
> > > > soon, if needed.
> > > > 
> > > 
> > > Is this really needed as long as the distro provides a way to customize
> > > the iptables rules?
> > 
> > It's not just that.  The reason a new table was proposed was because
> > people may want to iptables -F and flush their rules.  If the secmark
> > stuff is on the main tables (filter and nat) that people use it will get
> > blown away and there will be no automation of a boolean setting you talk
> > about later.
> > 
> 
> If we add the custom table won't we need a way to flush that? 

Sure it would still be flushable, just not how people normally go about
turning off iptables rules.  Now to flush rules users would

iptables -F
iptables -F -t nat

to get the secmark stuff they would also have to do
iptables -F -t secmark

> If so,
> would we add an iptables --no-really-flush command? If we want to
> preserve the iptables with no rules means all traffic is allowed
> semantic we need to somehow coordinate rule removal with the policy.

I agree that coordination between rule removal and policy unlabeled_t
boolean flipping is a good thing, but having the labeling rules on their
own table would allow people and tools to deal with the firewall as they
always have and not 'accidentally' mess up the secmark rules.  If
iptables people are already used to having to explicitly work on the nat
table i don't see why they would have have a problem working explicitly
on the secmark table for local network labeling.

> Options I see:
> 
> 1) Change iptables to flip a boolean. This sucks because we need some
> way for iptables to know which boolean to flip.

something tells me this is not upstreamable.  Would need to be a tool on
top of iptables, which then some people wouldn't want to use...

> 
> 2) Have the kernel mechanism stop enforcement of rules that rely on
> secmark when the tables are empty / flushed.

this one isn't so easy.  i don't like the idea of selective enforcement
although it does maintain the notion of 'allow when off' that users
expect from iptables.  Probably would be better as 'deny unlabeled_t if
some other label may exist.'  That would also have the implication that
setting up labeling of some sort of one domain would then disable the
unlabeled for every other domain.  Nothing in the secmark table is going
to say that httpd_packet_t is only used by the httpd_t and squid_t
domain.  How can the kernel know that it shouldn't enforce things for
autofs_t but should for those 2.  No no, i'm liking selective
enforcement in kernel less and less.

> 
> 3) Tell people to not do this - instead use distro scripts with
> integration. This seems unlikely to work.

oh yeah, tell people to only use system-config-network instead of being
like me and writing my own huge scripts.  you're right, that'll happen
</sarcasm>.

4) Find some guy who works in userspace and get him to write a tool that
will allow you to fill in some blanks and it will create the policy,
iptables labeling rule, and boolean settings for you.  If someone does
go back and explicitly break the secmark table its their own fault and
they get to hold the pieces.  If they use this new tool that someone
*cough*karl*cough* writes then everything works.  When they flush the
secmark rules in this tool it cleans up the policy, the custom table,
and sets the booleans.  

****

Getting secmark to work properly is a 3 step process right?  Define a
new type and allow the domain in question to use that type in a policy
module.  Disable the boolean in policy that already lets that domain use
the unlabeled_t type.  Create a secmark rule to label network traffic
with the type you defined in part1.

Maybe at some point we can ship labeling rules by default (and i don't
know if these belong with the other 'normal' firewall rules as opposed
to a seperate init script which just sets the secmark rules) which match
little other than we already match in the name_{bind,connect} checks and
can eliminate the boolean step.  But for now it seems that making it so
that a user won't accidentally shoot themselves in the foot and products
like 'webmin' can't hurt anything would be a good step....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
