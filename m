Subject: Re: weird mprotect error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Joe Nall <joe@nall.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <1187800948.13874.77.camel@gorn>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158818654C@exchange.columbia.tresys.com>
	 <1187380020.909.358.camel@moss-spartans.epoch.ncsc.mil>
	 <D38FAD33-E7B4-4A2A-909E-892800350EFE@nall.com>
	 <1187705925.1451.123.camel@moss-spartans.epoch.ncsc.mil>
	 <FDD03592-C4AE-4066-B866-90B830235880@nall.com>
	 <1187795197.1451.368.camel@moss-spartans.epoch.ncsc.mil>
	 <1187799306.1451.389.camel@moss-spartans.epoch.ncsc.mil>
	 <1187800948.13874.77.camel@gorn>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:00:24 -0400
Message-Id: <1187809224.1451.451.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-22 at 16:42 +0000, Christopher J. PeBenito wrote:
> On Wed, 2007-08-22 at 12:15 -0400, Stephen Smalley wrote:
> > Ok, so what is happening here is fairly simple, I think:  the kernel is
> > opening the ELF interpreter (/lib/ld-2.x.so) while we are still running
> > in the caller's context (hence initrc_t), so the struct file is created
> > in that context, and mappings are created from it.  Then we perform the
> > context transition, and when the program later tries to operate on the
> > mapping, it gets the denial.
> > 
> > Rather than using mls_fd_use_all_levels() on mlstest_t though, I think
> > you want to use mls_fd_share_all_levels() on initrc_t, like we do with
> > the login domains and newrole.  Then mlstest_t isn't generally
> > authorized to override MLS on fd use permission, but only on the
> > initrc_t fds.
> > 
> > Same issue would exist under TE if you completely disallowed fd use.
> 
> What this seems to imply is that you must always be allowed to inherit
> fds from the parent domain that exec()s you.  Interesting.  Makes the
> fd:use check seem less useful since you can only deny inheriting fds
> from your parent's parent.

That along with denying receiving fds from an unrelated process via
local IPC.

This is another example of how the point at which we perform context
transitions in the kernel (just hooking into compute_creds and
paralleling the setuid/setgid transition) may not be optimal.  We've
seen that previously as well with e.g. the mmap permission checking of
the executable image occurring in the caller's context rather than the
new context (e.g. for execmem).

So at some point we may want to explore alternatives there.
 
> So after a quick grep I see:
> 
> policy/modules/system/init.te:mls_fd_use_all_levels(init_t)
> 
> kernel_t runs at sys high, init is sys low-high, so this makes sense.
> At the same time it may be ok for the kernel to share its fds, since it
> can transition to more than init_t.
> 
> policy/modules/services/cups.te:mls_fd_use_all_levels(cupsd_t)
> policy/modules/system/logging.te:mls_fd_use_all_levels(auditd_t)
> policy/modules/system/setrans.te:mls_fd_use_all_levels(setrans_t)
> 
> initrc_t runs at sys low-high, the above run in sys high, so these will
> be replaced by the initrc_t fd share.
> 
> policy/modules/services/inetd.te:mls_fd_use_all_levels(inetd_t)
> 
> Don't know why this needs it.  It can only transitioned to via initrc_t,
> so I'm thinking that this probably can be dropped.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
