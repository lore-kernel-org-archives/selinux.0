Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4378D636.3090408@redhat.com>
References: <BF9A263D.7FFA%csellers@tresys.com>
	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>
	 <200511141041.49643.csellers@tresys.com>
	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>
	 <4378B88B.6040003@redhat.com>
	 <1131987091.5415.180.camel@moss-spartans.epoch.ncsc.mil>
	 <4378D636.3090408@redhat.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 14:32:26 -0500
Message-Id: <1131996746.5415.234.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 13:23 -0500, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > A couple of concerns about upstreaming this patch as is:
> > 1) Compatibility.  
> I don't believe anyone uses this method at present other than the 
> developers so I didn't see this as a necessity to maintain.

Ok.  Just be aware that if you ever push out an updated policycoreutils
to a prior release, you also need to update the policy package for that
release to use the new usage for genhomedircon and to include a seusers
file if you want it to continue working.

> > 2) Targeted policy specialization.  defaultrole() has a hack for
> > targeted policy to remap system_r to user_r as the default role for a
> > user when system_r is returned by semanage, and getUsers() has a
> > targeted policy-specific hack to handle the root entry in seusers when
> > not using semanage.  The latter will break anyone with strict policy
> > that isn't converted to using semanage.
> >
> >   
> I thought in strict policy this would be a bug also.  Since it should be 
> returning something like staff_r or user_r. 
> The previous patch had a problem on non libsemanaged machines.

Yes, but the current workaround doesn't generalize; it assumes root
defaults to user_r in the non-managed case, which isn't true under
strict policy.  Options would seem to be:
- Drop support for non-managed systems from genhomedircon altogether, or
- Have genhomedircon fall back to looking for system.users if the system
is not managed, and use that to determine the default role for root.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
