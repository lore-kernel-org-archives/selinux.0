Subject: Re: [PATCH 3/3] SELinux: special dontaudit for access checks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org, jmorris@namei.org,
        casey@schaufler-ca.com, viro@zeniv.linux.org.uk
In-Reply-To: <1272376035.25840.56.camel@moss-pluto.epoch.ncsc.mil>
References: <20100409221614.2681.64052.stgit@paris.rdu.redhat.com>
	 <20100409221629.2681.53796.stgit@paris.rdu.redhat.com>
	 <1272376035.25840.56.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 27 Apr 2010 10:40:15 -0400
Message-Id: <1272379215.25840.82.camel@moss-pluto.epoch.ncsc.mil>
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
> 
> Right?
> 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> > 
> >  security/selinux/hooks.c            |   46 ++++++++++++++++++++++++++++++-----
> >  security/selinux/include/classmap.h |    2 +-
> >  2 files changed, 40 insertions(+), 8 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 344ba62..34e9d1b 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2696,19 +2696,51 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *na
> >  	return dentry_has_perm(cred, NULL, dentry, FILE__READ);
> >  }
> >  
> > -static int selinux_inode_permission(struct inode *inode, int mask)
> > +static int selinux_inode_permission(struct inode *inode, int in_mask)
> >  {
> >  	const struct cred *cred = current_cred();
> > +	struct inode_security_struct *isec;
> > +	struct common_audit_data ad;
> > +	struct av_decision avd;
> > +	u32 sid, perms;
> > +	int rc, mask;
> >  
> > -	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
> > +	mask = in_mask & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
> >  
> > -	if (!mask) {
> > -		/* No permission to check.  Existence test. */
> > +	/* No permission to check.  Existence test. */
> > +	if (!mask)
> > +		return 0;
> > +
> > +	validate_creds(cred);
> > +
> > +	if (unlikely(IS_PRIVATE(inode)))
> >  		return 0;
> 
> This is handled by security_inode_permission().  The check inside
> inode_has_perm() stems from other code paths.
> 
> > -	}
> >  
> > -	return inode_has_perm(cred, inode,
> > -			      file_mask_to_av(inode->i_mode, mask), NULL);
> > +	sid = cred_sid(cred);
> > +	isec = inode->i_security;
> > +
> > +	COMMON_AUDIT_DATA_INIT(&ad, FS);
> > +	ad.u.fs.inode = inode;
> > +
> > +	perms = file_mask_to_av(inode->i_mode, mask);
> > +
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

e.g.
static int selinux_inode_permission(struct inode *inode, int mask)
{
        const struct cred *cred = current_cred();
	struct common_audit_data ad;
	int access;

	access = mask & MAY_ACCESS;
	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);

        if (!mask) {
                /* No permission to check.  Existence test. */
                return 0;
        }

	COMMON_AUDIT_DATA_INIT(&ad, FS);
	ad.u.fs.inode = inode;

	if (access)
		ad.selinux_audit_data.auditdeny = FILE__AUDIT_ACCESS;

        return inode_has_perm(cred, inode,
                              file_mask_to_av(inode->i_mode, mask), &ad);
}

And then test a->selinux_audit_data.auditdeny inside of avc_audit() and
use it if set.
	
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
