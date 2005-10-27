Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510271520390.24160@excalibur.intercode>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
	 <1130439786.18805.322.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.63.0510271520390.24160@excalibur.intercode>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 16:02:18 -0400
Message-Id: <1130443338.18805.364.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-27 at 15:23 -0400, James Morris wrote:
> On Thu, 27 Oct 2005, Stephen Smalley wrote:
> 
> > Thoughts?
> 
> It may be helpful to have type aliases, but are they truly necessary?  
> 
> Seems like a lot of potential problems arise from them, including 
> confusing SELinux developers.
> 
> Perhaps type aliasing would be better implemented as a higher level policy 
> construct?

There seem to be three uses of the aliases:
1) compatibility across policy changes, e.g. when a type is removed or
renamed, an alias can be defined so that any existing processes or
objects with the type aren't rendered unlabeled upon the policy reload,
2) on-disk compatibility between policies, so that a filesystem
initially labeled for targeted policy is still fairly useable for
bootstrapping a strict policy system even though the latter has
finer-grained types,
3) sharing among policies, both at a source level (macros, .te
files, .fc files) and for binary policy modules, so that policy modules
(source or binary) can refer to types that may then be coalesced or kept
separate as appropriate for a given base policy.

#3 could be done entirely via a higher level construct, but we don't
have such a higher level construct yet and are relying on the ability to
share among policies in this manner.  #2 may not be critical.  #1 seems
to require that the kernel retain a notion of the aliases.

If #2 is not critical, then changing matchpathcon_init in the proposed
manner may be sufficient (whether using sepol or selinuxfs as the
backend).  With that change, upgraded systems that have existing uses of
alias names in on-disk xattrs won't cause spurious complaints by
setfiles/restorecon, and a clean install should yield a system with no
alias names stored in the on-disk xattrs since rpm will get canonical
names.  We could instrument the setfilecon functions in libselinux to
also canonicalize the context prior to calling setxattr.  On second
thought, it seems overkill to do it on context translations, as this is
only an issue for file contexts and is already covered for getxattr, so
we are primarily concerned with matchpathcon and setfilecon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
