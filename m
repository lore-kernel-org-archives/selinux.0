Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5EJkjKn023385
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2013 15:46:45 -0400
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com
Subject: Deprecating policy capabilities (was: Clarification of labeled IPsec checks)
Date: Fri, 14 Jun 2013 15:46:19 -0400
Message-ID: <5219244.VNyImXJjQb@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, May 07, 2013 09:05:30 AM Paul Moore wrote:
> On Monday, May 06, 2013 09:50:04 AM Christopher J. PeBenito wrote:
> > On 05/03/13 15:20, Paul Moore wrote:
> > > It has been a while since we introduced the netpeer policy capability so
> > > I imagine we could start a process of deprecating policies that don't
> > > enable it. We could dump a warning message if someone loads a policy
> > > with the netpeer capability disabled and then after a few releases (how
> > > many?) we could remove the legacy bits from the kernel and reject
> > > policies which don't have the netpeer capability set.
> > 
> > The common case obviously is no labeling, and in that case, there wouldn't
> > be checks.  So I suspect this wouldn't have any real problems.  My guess
> > is systems that use this wouldn't be changing their OS very often, and
> > when they do, it would be major jumps (e.g. RHEL6 to RHEL7), so they'd be
> > anticipating changes like this.
> 
> Yeah, I agree.  I'll throw together a deprecation patch and toss it out so
> we can have a bit more of a discussion on this.

I just took a closer look at this and as much as I would like to require 
policies to enable the netpeer capability so we could remove a bunch of old 
code, I don't think we can do this anytime soon.

The problem is that the kernel still supports old policy versions, back to 
v15, and the policy capability support wasn't added until policy v22.  For 
obvious reasons, we can't really deprecate a policy capability (at least not 
the netpeer capability) until our minimum supported policy version is v22 or 
higher.  I'm not sure that is something we can really do at this point - 
thoughts?

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
