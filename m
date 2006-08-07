Subject: RE: [PATCH 0/2] new and improved range_transition statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Valdis.Kletnieks@vt.edu, James Morris <jmorris@namei.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AD94@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832AD94@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 10:19:51 -0400
Message-Id: <1154960391.26697.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-07 at 08:04 -0400, Joshua Brindle wrote:
>  
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > Sent: Friday, August 04, 2006 9:20 AM
> > To: Valdis.Kletnieks@vt.edu
> > Cc: James Morris; Karl MacMillan; Darrel Goeddel; 'SELinux 
> > List'; Eric Paris; Joshua Brindle
> > Subject: Re: [PATCH 0/2] new and improved range_transition statements
> > 
> > On Mon, 2006-07-31 at 11:10 -0400, Valdis.Kletnieks@vt.edu wrote:
> > > On Mon, 31 Jul 2006 10:43:15 EDT, Stephen Smalley said:
> > > 
> > > > I agree that it is too late for 2.6.18, but just to clarify - the 
> > > > kernel patch preserves backward compatibility for older binary 
> > > > policy formats.
> > > > 
> > > > As far as compatibility is concerned, FC4 will need some kind of 
> > > > userland update when it updates to a kernel with the new policy 
> > > > format; otherwise, init will give up when it cannot find 
> > policy.21 
> > > > or policy.20 (older sysvinit selinux patch only tried n 
> > and (n-1)), 
> > > > and the policy in
> > > > FC4 was version 19.
> > > 
> > > Given that Andrew Morton is currently having a cow over the 
> > fact that
> > > 2.6.18-rc3 includes a change that breaks the udev that shipped with 
> > > FC3, we might want to make sure we have all our ducks lined up....
> > > 
> > > (To be fair, the udev change is one that breaks any udev 
> > more than 10 
> > > months or so old...)
> > 
> > After a bit of discussion (see bug 201242 in the redhat 
> > bugzilla) about updating FC4 userland, it seems that we 
> > should try to address this compatibility concern for legacy 
> > userland in the kernel.  We could first upstream the patch 
> > below, then re-base the range_transition kernel patch against 
> > it.  This patch makes the maximum policy version a kernel 
> > config option so that it can be adjusted down to accommodate 
> > legacy userland, with instructions and examples in the help 
> > text of the config option on how to determine what value to 
> > use.  The range_transition kernel patch would then adjust the 
> > "range" and "default" attributes of this new config option to 
> > reflect the new version support, while users could still 
> > build kernels to an older version.  Thoughts?
> 
> Hrm, I'd have really prefered this be handled in userspace, for example
> by having init query semanage to find out what policy version to use
> (this not only affects loading old policies but also potentially stale
> ones which we have no protection against right now)
> 
> If libsemanage wrote the latest policy name into the store an semanage
> call could give it the info whether it was policy.n, policy.n-2 or
> policy.somethingentirelydifferent.One thing to think about with this
> solution is how to handle multiple security servers though. 
> 
> However, this seems fairly imperative and your proposed way of handling
> it is fast and simple so I guess it needs to go in regardless.

Possibly we aren't communicating - the current userland (e.g. in FC5 and
later) already handles this situation correctly; libsemanage always
generates the latest policy version supported by libsepol (unless
overridden by semanage.conf), and libselinux loads the latest policy
version supported by libsepol, or the closest one to it, downgrading on
the fly if necessary via libsepol to the kernel's policyvers, and
SysVinit uses the libselinux policy loader now.  The purpose of this
kernel patch is to avoid breaking legacy userland (e.g. FC3, FC4) that
predates all of this support (libsemanage altogether, the libsepol
interfaces needed to make it work, the libselinux helper function to
fully encapsulate the policy load, and the changes to SysVinit to use
the libselinux helper function).

BTW, one way to address Darrel's concern is to leave the default value
unchanged (at 20) when we merge the range transition patch, so that the
kernel package maintainer or user has to take positive action to force
the kernel to support policy version 21.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
