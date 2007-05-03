Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43LOuxw011809
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 17:24:56 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l43LOtNE003043
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 21:24:55 GMT
Subject: Re: Patch to cleanup audit handling in policy.
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Steve G <linux_4ever@yahoo.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178194665.445.42.camel@sgc.columbia.tresys.com>
References: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>
	 <1177951993.3570.115.camel@sgc>
	 <1177980591.13269.10.camel@localhost.localdomain>
	 <1178026296.3570.144.camel@sgc>
	 <1178032864.3757.3.camel@localhost.localdomain>
	 <1178125691.445.2.camel@sgc.columbia.tresys.com>
	 <1178126283.7700.3.camel@localhost.localdomain>
	 <1178194665.445.42.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 17:16:58 -0400
Message-Id: <1178227018.14937.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-03 at 12:17 +0000, Christopher J. PeBenito wrote:
> On Wed, 2007-05-02 at 13:18 -0400, Karl MacMillan wrote:
> > On Wed, 2007-05-02 at 13:08 -0400, Christopher J. PeBenito wrote:
> > > On Tue, 2007-05-01 at 11:21 -0400, Karl MacMillan wrote:
> > > > On Tue, 2007-05-01 at 13:31 +0000, Christopher J. PeBenito wrote:
> > > > > On Mon, 2007-04-30 at 20:49 -0400, Karl MacMillan wrote:
> > > > > >  Given that and
> > > > > > my concerns over their clarity I would prefer that no more patterns be
> > > > > > introduced.
> > > > > > 
> > > > > > Can I ask why you are so against these audit interfaces and would prefer
> > > > > > patterns?
> > > > > 
> > > > > I don't agree with the assertions which means the attributes are
> > > > > dropped, so that just leaves the rules, which don't refer to any types
> > > > > in the logging module.  They only refer to resources in the current
> > > > > module (all self rules), so its not an interface, its a pattern.
> > > > > 
> > > > 
> > > > I think that distinction is not useful to a policy writer. As a policy
> > > > writer I think it would be natural to look for audit interfaces in
> > > > logging - by making these patterns they are harder to find.
> > > > 
> > > > So - why make this distinction?
> > > 
> > > Its always been the definition of an interface.
> > > 
> > 
> > Great - so why has that always been the definition
> 
> Not sure how you can ask that since interfaces providing access to a
> module's private resource is a fundamental principle.
> 

I agree that interfaces are the only way to provide access to a modules
types, but I don't think that is their only purpose. They are also for
grouping and organizing related access.

> >  and what is the
> > motivation for separating the patterns and the interfaces in this
> > circumstance. What value does this provide to the policy writer?
> 
> Indeed that is a good question, which is why I said it was compelling in
> the other thread.
> 

I would suggest that for most of the patterns they don't have any other
logical grouping - the access being allowed is private to the module.

These audit rules seem different. The access is really about allowing a
domain access to the audit subsystem. It is not simply private access
that cannot be further grouped. That the access is allowed purely via
permissions on module private types is an unimportant implementation
detail.

So, taking the broader definition of interfaces as grouping related
access, it seems natural to make these audit interfaces and put them in
logging.if.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
