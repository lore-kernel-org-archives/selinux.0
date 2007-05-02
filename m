Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42H8YGr006427
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 13:08:34 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l42H8YuY027453
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 17:08:34 GMT
Subject: Re: Patch to cleanup audit handling in policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Steve G <linux_4ever@yahoo.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178032864.3757.3.camel@localhost.localdomain>
References: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>
	 <1177951993.3570.115.camel@sgc>
	 <1177980591.13269.10.camel@localhost.localdomain>
	 <1178026296.3570.144.camel@sgc>
	 <1178032864.3757.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 02 May 2007 13:08:11 -0400
Message-Id: <1178125691.445.2.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-01 at 11:21 -0400, Karl MacMillan wrote:
> On Tue, 2007-05-01 at 13:31 +0000, Christopher J. PeBenito wrote:
> > On Mon, 2007-04-30 at 20:49 -0400, Karl MacMillan wrote:
> > > On Mon, 2007-04-30 at 16:53 +0000, Christopher J. PeBenito wrote:
> > > > On Mon, 2007-04-30 at 07:59 -0700, Steve G wrote:
> > > > > The interfaces that Dan created allows the exact kind of permission to be applied
> > > > > without having to copy and paste individual permissions which is error prone.
> > > > > (There are only 4 use cases of the audit system.) Part of what makes it error
> > > > > prone is the naming convention for all the pieces. Example: "audit_write" is that
> > > > > for the capability, the netlink interface, or audit logs?
> > > > 
> > > > This is the reason policy patterns exist.
> > > > 
> > > 
> > > So far the policy patterns have been very hard to automatically generate
> > > using sepolgen. Note that this deficiency is not something that I can
> > > address - it is a problem with the patterns themselves.
> > 
> > I don't see how it could be any more complex than matching rules to an
> > interface.
> > 
> 
> http://www.nsa.gov/selinux/list-archive/0701/18939.cfm
> 
> Summary - patterns that contain unrelated types cannot be reliably
> generated. This - to me - is a major drawback. Whether that will apply
> here is not clear.

Even if they can't be generated, I don't see how that negates their
usefulness.

> > >  Given that and
> > > my concerns over their clarity I would prefer that no more patterns be
> > > introduced.
> > > 
> > > Can I ask why you are so against these audit interfaces and would prefer
> > > patterns?
> > 
> > I don't agree with the assertions which means the attributes are
> > dropped, so that just leaves the rules, which don't refer to any types
> > in the logging module.  They only refer to resources in the current
> > module (all self rules), so its not an interface, its a pattern.
> > 
> 
> I think that distinction is not useful to a policy writer. As a policy
> writer I think it would be natural to look for audit interfaces in
> logging - by making these patterns they are harder to find.
> 
> So - why make this distinction?

Its always been the definition of an interface.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
