Subject: Re: [PATCH 3/3] SELinux: special dontaudit for access checks
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org, jmorris@namei.org,
        casey@schaufler-ca.com, viro@zeniv.linux.org.uk
In-Reply-To: <1272376035.25840.56.camel@moss-pluto.epoch.ncsc.mil>
References: <20100409221614.2681.64052.stgit@paris.rdu.redhat.com>
	 <20100409221629.2681.53796.stgit@paris.rdu.redhat.com>
	 <1272376035.25840.56.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 10:43:48 -0400
Message-ID: <1272379428.5132.9.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-04-27 at 09:47 -0400, Stephen Smalley wrote:
> On Fri, 2010-04-09 at 18:16 -0400, Eric Paris wrote:
> > Currently there are a number of applications (nautilus being the main one) which
> > calls access() on files in order to determine how they should be displayed.  It
> > is normal and expected that nautilus will want to see if files are executable
> > or if they are really read/write-able.  access() should return the real
> > permission.  SELinux policy checks are done in access() and can result in lots
> > of AVC denials as policy denies RWX on files which DAC allows.  Currently
> > SELinux must dontaudit actual attempts to read/write/execute a file in
> > order to silence these messages (and not flood the logs.)  But dontaudit rules
> > like that can hide real attacks.  This patch addes a new common file
> > permission audit_access.  This permission is special in that it is meaningless
> > and should never show up in an allow rule.  Instead the only place this
> > permission has meaning is in a dontaudit rule like so:
> > 
> > dontaudit nautilus_t sbin_t:file audit_access
> > 
> > With such a rule if nautilus just checks access() we will still get denied and
> > thus userspace will still get the correct answer but we will not log the denial.
> > If nautilus attempted to actually perform one of the forbidden actions
> > (rather than just querying access(2) about it) we would still log a denial.
> > This type of dontaudit rule should be used sparingly, as it could be a
> > method for an attacker to probe the system permissions without detection.
> 
> So let's think about how this will likely play out in practice.
> If you add this check, what rules will Dan add to the standard policy?
> nautilus doesn't run in a separate domain nor is it likely to do so
> (otherwise you have to clone all of the user's permissions to it).  So
> we'll likely end up with something like:
> 	dontaudit userdomain file_type:file audit_access;

Yes, although I think it should likely be kept out of some of them
namely:
(*_mono_t, *_java_t, *_execmem_t)


> > +	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
> > +	/*
> > +	 * We want to audit if this call was not from access(2).
> > +	 * We also want to audit if the call was from access(2)
> > +	 * but the magic FILE__AUDIT_ACCESS permission was in the auditdeny
> > +	 * vector.
> > +	 *
> > +	 * aka there is a not dontaudit rule for file__audit_access.  This
> > +	 * might make more sense as a test inside avc_audit, but then we would
> > +	 * have to push the MAY_ACCESS flag down to avc_audit and I think we
> > +	 * already have enough stuff down there.
> > +	 */
> 
> Why can't we just push it down through inode_has_perm -> avc_has_perm ->
> avc_audit() via a field in common_audit_data?

Ok, I like that idea.  I'll probably put it in a flag in the SELinux
private union in the common_audit_data but I'll figure that out when I
look at exactly what we already have where.

I'm only going to resend #3.  1 and 2 seem to make people happy as they
stand.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
