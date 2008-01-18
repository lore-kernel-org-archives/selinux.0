Subject: Re: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
In-Reply-To: <200801180911.05879.paul.moore@hp.com>
References: <20080117172246.341834342@hp.com>
	 <1200598421.7025.73.camel@moss-spartans.epoch.ncsc.mil>
	 <1200663127.4595.23.camel@gorn>  <200801180911.05879.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 18 Jan 2008 09:38:50 -0500
Message-Id: <1200667130.4595.45.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-01-18 at 09:11 -0500, Paul Moore wrote:
> On Friday 18 January 2008 8:32:07 am Christopher J. PeBenito wrote:
> > On Thu, 2008-01-17 at 14:33 -0500, Stephen Smalley wrote:
> > > The situation is this:
> > > - policy shipped in Fedora 6 and later had these flow_in/flow_out
> > > permissions defined in their base modules and in their gen_requires.
> > > - Paul Moore is adding new permissions to that class in his labeled
> > > networking tree that is included in -mm and queued for 2.6.25,
> > > - when you try to load those policies into the resulting kernel, the
> > > class validation logic rejects the policies,
> > > - any policy modules built by any third parties also have these perms
> > > defined in their requires and will fail if we remove them from base,
> > > - we can't make any changes to the kernel that break existing userspace
> > > and policy (which is why handle_unknown is largely useless to us until
> > > all legacy distros that predate it are sufficiently dead and gone).
> > >
> > > This all came up because akpm reported the failure on his FC6 test box
> > > with latest -mm.
> > >
> > > I suggested just using flow_in/flow_out instead of
> > > forward_in/forward_out for Paul's new controls so that we don't have any
> > > unused permissions, but Paul and Eric want the more precise names.
> >
> > I strongly agree with Stephen's suggestion.
> 
> So, does the "strongly agree" position mean you won't accept the patch adding 
> both "flow" and "forward" permissions to the packet class?

No, if I meant that, I would have said that.

>   I'll reiterate my 
> belief that using "flow" instead of "forward" for the new permission checks 
> is a mistake which will cause more confusion in the long run than the 
> addition of two unused permissions.  However, you hold the key to the policy 
> and if changing the permissions to use "flow" is the only way for us to 
> enable the new network access controls then I have little choice.

I'm not completely unreasonable :) Also that would be an abuse of power.

> > Do we have a strategy for eventually reclaiming these permissions if we
> > don't reuse them right now?
> 
> I'm not aware of one, but it is always possible that future work might find a 
> use for the packet "flow" permissions.  It's also highly doubtful from where 
> I sit now that we'll come even remotely close to hitting the 32 permission 
> limit in the packet class.

I just don't like these rogue permissions filtering up to upstream.  One
thing that I'm also looking ahead to is that explicit require blocks
will be ignored by policyrep (requirements will be implicit).  So the
hack that I had to add that requires all of the kernel object classes
will also be going away, and only classes/perms actually being used will
be required.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
