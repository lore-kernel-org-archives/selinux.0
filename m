Subject: Re: [PATCH] setfiles fails to relabel if selinux not enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeff Johnson <n3npq@mac.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Caleb Case <ccase@tresys.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <D095955D-66A2-4A9E-854A-5A5AF0C92EF3@mac.com>
References: <1253042418-28141-1-git-send-email-ccase@tresys.com>
	 <1253043181.18198.62.camel@moss-pluto.epoch.ncsc.mil>
	 <06A6610D4F464D4EBEAFBF2C5F86911E014CEA9F@exchange2.columbia.tresys.com>
	 <1253109741.18198.93.camel@moss-pluto.epoch.ncsc.mil>
	 <D095955D-66A2-4A9E-854A-5A5AF0C92EF3@mac.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 10:36:49 -0400
Message-Id: <1253111809.18198.104.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-16 at 10:16 -0400, Jeff Johnson wrote:
> On Sep 16, 2009, at 10:02 AM, Stephen Smalley wrote:
> 
> >>
> >> What is the best we can do? Should we always attempt to relabel if
> >> selinux is disabled or not?
> >
> > The patch is the best we can do - we shouldn't exclude any mounts  
> > based
> > on the absence of seclabel in /proc/mounts if SELinux is disabled.
> > Historically setfiles has always supported relabeling filesystems even
> > if SELinux was disabled in the host.
> 
> There's a fundamental confusion between the act (of labelling) and the  
> use of selinux labels.
> 
> The issue shows up when there are multiple (and possibly incompatible)
> sets of labels, such as in chroot's, or creating an image for a  
> different
> installation.
> 
> One can choose to not install labels condition on whether  
> is_selinux_enabled()
> consistently and methodically.
> 
> Perhaps a simpple example to illustrate:
> 
> 	Should cp(1) always copy security labels or only if is_selinux_enabled 
> ()?
> 
> What I'm hearing is "No. cp(1) should copy labels iff  
> is_selinux_senabled() is TRUE."

That's a different issue.  Here we are talking about a recent change to
setfiles that was preventing it from relabeling filesystems if SELinux
was disabled (because then no filesystems were reporting the seclabel
option in /proc/mounts).  As we want setfiles to support relabeling of
filesystems even if SELinux is disabled, we want to skip the seclabel
option processing in that case as the kernel won't report seclabel
information when SELinux is disabled (seclabel means more than just
"filesystem has an xattr handler").

As far as cp goes, I believe you are correct - it will only preserve
security contexts if SELinux is enabled, and even then, only if the
caller specified -a or -c.  And in the -a case, it has to be able to
gracefully fall back to not preserving the context if not permitted by
policy, as not all callers will be able to do so for the security
context even if they can do so for the DAC attributes.

Note that preserving security contexts may be using SELinux-specific
interfaces (e.g. setfscreatecon(3)) to create the copy directly in the
desired security context rather than creating the file and then
relabeling it after creation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
