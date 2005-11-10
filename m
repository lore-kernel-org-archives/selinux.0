Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Chad Sellers <csellers@tresys.com>, James Morris <jmorris@namei.org>,
   selinux@tycho.nsa.gov, SELinux-dev@tresys.com
In-Reply-To: <1131625910.20591.607.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
	 <Pine.LNX.4.63.0510271520390.24160@excalibur.intercode>
	 <1130443338.18805.364.camel@moss-spartans.epoch.ncsc.mil>
	 <200511091630.53757.csellers@tresys.com>  <43727C4D.1070100@redhat.com>
	 <1131625910.20591.607.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 07:45:07 -0500
Message-Id: <1131626707.20591.615.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 07:31 -0500, Stephen Smalley wrote:
> On Wed, 2005-11-09 at 17:46 -0500, Daniel J Walsh wrote:
> > We are supposed to be patching restorecon/chcon/setfiles to make these 
> > go away or at most warn.  These tools should be asking the kernel for 
> > the correct context for a file  IE shlib_t -> lib_t in targeted policy 
> > and then says it is ok.
> 
> I already took care of restorecon (via the modified matchpathcon logic)
> and setfiles (which has its own callback).  But they need a kernel that
> has the new support for canonicalizing the contexts, and that only just
> showed up in 2.6.14-git13.  Not in rawhide yet AFAIK.

BTW, in addition to altering matchpatchcon for this purpose, I added
security_canonicalize_context interfaces to libselinux to allow other
applications to also obtain canonical contexts.  So chcon could call
that interface to get the canonical context and compare the result with
the user-supplied context.  The implementation provides a fallback for
kernels that do not yet support the new functionality, simply returning
the provided context in that case, so that nothing breaks (you just
don't get the benefit of the canonicalization until the kernel includes
the patch).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
