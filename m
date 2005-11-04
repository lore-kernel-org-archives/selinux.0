Message-ID: <36282A1733C57546BE392885C0618592D97706@chaos.tcs.tcs-sec.com>
From: Jonathan Kim <jkim@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [PATCH] libselinux
Date: Fri, 4 Nov 2005 11:40:12 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Taking your guidance into consideration and examining the big picture of the
architecture, we will take back the proposed patch and will be sending out a
new MLS policy patch.
Thanks for the responses!

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, November 03, 2005 2:48 PM
> To: Jonathan Kim
> Cc: SELinux@tycho.nsa.gov; Chad Hanson
> Subject: Re: [PATCH] libselinux
> 
> 
> On Thu, 2005-11-03 at 15:33 -0500, Stephen Smalley wrote:
> > Just to note:  I'm not opposed to the patch per se 
> (although it might be
> > better to treat this as an error condition rather than 
> falling through
> > to the base user definitions, as they may give wider access then you
> > want since multiple Linux users may be mapped to a single 
> SELinux user),
> > but I'm unclear about why one would use an empty level in 
> this manner in
> > seusers versus just omitting the entry for the user 
> altogether if you
> > want the fallback behavior.
> 
> The other point to keep in mind here is that there are plans to create
> management utilities for seusers (via libsemanage) and that those
> utilities are going to be instrumented for audit as part of the
> LSPP/RBAC effort, whereas local.users is largely unused except by
> SELinux developers even now and is even less likely to be used going
> forward now that seusers exists.  The expectation is that the base
> policy (module) will contain the base set of SELinux user identities
> (which will correspond to distinct role sets defined in the policy and
> typically be authorized for the full range), and seusers will handle
> mapping each Linux user to a role set (aka SELinux user 
> identity) and to
> an authorized range.  The user ranges in the SELinux policy 
> will then be
> largely unused (typically just the full range), as seusers 
> will be what
> governs the clearance/high assigned to the user session based on the
> Linux user.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
