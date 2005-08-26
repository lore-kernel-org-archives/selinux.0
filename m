Subject: Re: corrected sidtab locking patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Tang <jtang@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1125077937.8692.46.camel@moss-spartans.epoch.ncsc.mil>
References: <1125074025.5306.9.camel@localhost.localdomain>
	 <430F4824.4090802@tresys.com>
	 <1125076450.5306.20.camel@localhost.localdomain>
	 <1125077937.8692.46.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 14:12:31 -0400
Message-Id: <1125079951.8692.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 13:39 -0400, Stephen Smalley wrote:
> On Fri, 2005-08-26 at 13:14 -0400, Jason Tang wrote:
> > The following patch allows a program to enable locking in
> > libsepol/sidtab.c.  By default sidtab.c does not lock the sidtab when
> > adding and removing entries; this causes problems for multi-threaded
> > programs using it.  Programs may set up function pointers to perform
> > locking as they see fit.
>   
> - Patch doesn't remove the legacy #define's for the old locking macros.
> In fact, it would be better to name the static functions differently and
> change the #define's to expand to the new functions instead of just
> directly defining the functions with those names.
> 
> - Are you sure that this is now thread-safe?  Kernel-side code was also
> relying on other aspects, e.g. use of wmb() during sidtab_insert to
> ensure that we can safely walk the lists lock-free in sidtab_search, and
> also used atomic (non-blocking) allocation when holding the lock.
> 
> - There are certainly other aspects of libsepol that are not presently
> thread-safe.  One obvious example is its copy of services.c, which lacks
> the locking present in the kernel version.  Do you allow policy reloads?

BTW, it might be simpler to just do coarse-grained locking in the
calling application around all calls to libsepol.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
