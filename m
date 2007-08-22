Subject: Re: weird mprotect error
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joe Nall <joe@nall.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1187799306.1451.389.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158818654C@exchange.columbia.tresys.com>
	 <1187380020.909.358.camel@moss-spartans.epoch.ncsc.mil>
	 <D38FAD33-E7B4-4A2A-909E-892800350EFE@nall.com>
	 <1187705925.1451.123.camel@moss-spartans.epoch.ncsc.mil>
	 <FDD03592-C4AE-4066-B866-90B830235880@nall.com>
	 <1187795197.1451.368.camel@moss-spartans.epoch.ncsc.mil>
	 <1187799306.1451.389.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 16:42:28 +0000
Message-Id: <1187800948.13874.77.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-22 at 12:15 -0400, Stephen Smalley wrote:
> On Wed, 2007-08-22 at 11:06 -0400, Stephen Smalley wrote:
> > On Wed, 2007-08-22 at 08:18 -0500, Joe Nall wrote:
> > > On Aug 21, 2007, at 9:18 AM, Stephen Smalley wrote:
> > > 
> > > > On Mon, 2007-08-20 at 21:09 -0500, Joe Nall wrote:
> > > >> Any recommendations on how to start an unprivileged non SystemLow
> > > >> daemon? This seems broken.
> > > >
> > > > Maybe I don't understand the actual problem.
> > > 
> > > We couldn't make a non SystemLow, unprivileged daemon run in  
> > > enforcing mode.
> > > 
> > > > Is it reproducible with an upstream (or Fedora) kernel?
> > > 
> > > Tried to reproduce it on F7 yesterday and ran into login issues.
> > > 
> > > > What's the exact test case?  Trying to run an /etc/init.d script that
> > > > calls that mlstest program using run_init?
> > > 
> > > chcon system_u:object_r:mlstest_exec_t mlstest
> > > run_init ./mlstest
> > > 
> > > The test case was derived from a more complicated daemon and init  
> > > script.
> > 
> > Ok, so I brought up F7 with its -mls policy in permissive to workaround
> > the broken login policy, logged in, newrole'd to sysadm_r, and switched
> > to enforcing mode.  Created the mlstest policy module and inserted it,
> > created the mlstest program, labeled it, tried the above with run_init.
> > No unexpected avc messages about ld.*so, and no obvious problems (but no
> > output, of course, since it doesn't have access to the pty).
> 
> Oops, never mind - I reproduced it.
> 
> Ok, so what is happening here is fairly simple, I think:  the kernel is
> opening the ELF interpreter (/lib/ld-2.x.so) while we are still running
> in the caller's context (hence initrc_t), so the struct file is created
> in that context, and mappings are created from it.  Then we perform the
> context transition, and when the program later tries to operate on the
> mapping, it gets the denial.
> 
> Rather than using mls_fd_use_all_levels() on mlstest_t though, I think
> you want to use mls_fd_share_all_levels() on initrc_t, like we do with
> the login domains and newrole.  Then mlstest_t isn't generally
> authorized to override MLS on fd use permission, but only on the
> initrc_t fds.
> 
> Same issue would exist under TE if you completely disallowed fd use.

What this seems to imply is that you must always be allowed to inherit
fds from the parent domain that exec()s you.  Interesting.  Makes the
fd:use check seem less useful since you can only deny inheriting fds
from your parent's parent.

So after a quick grep I see:

policy/modules/system/init.te:mls_fd_use_all_levels(init_t)

kernel_t runs at sys high, init is sys low-high, so this makes sense.
At the same time it may be ok for the kernel to share its fds, since it
can transition to more than init_t.

policy/modules/services/cups.te:mls_fd_use_all_levels(cupsd_t)
policy/modules/system/logging.te:mls_fd_use_all_levels(auditd_t)
policy/modules/system/setrans.te:mls_fd_use_all_levels(setrans_t)

initrc_t runs at sys low-high, the above run in sys high, so these will
be replaced by the initrc_t fd share.

policy/modules/services/inetd.te:mls_fd_use_all_levels(inetd_t)

Don't know why this needs it.  It can only transitioned to via initrc_t,
so I'm thinking that this probably can be dropped.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
