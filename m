Message-ID: <4BD6FAD7.8000403@redhat.com>
Date: Tue, 27 Apr 2010 10:55:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org, jmorris@namei.org,
        casey@schaufler-ca.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/3] SELinux: special dontaudit for access checks
References: <20100409221614.2681.64052.stgit@paris.rdu.redhat.com>	 <20100409221629.2681.53796.stgit@paris.rdu.redhat.com> <1272376035.25840.56.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1272376035.25840.56.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/27/2010 09:47 AM, Stephen Smalley wrote:
> On Fri, 2010-04-09 at 18:16 -0400, Eric Paris wrote:
>> Currently there are a number of applications (nautilus being the main one) which
>> calls access() on files in order to determine how they should be displayed.  It
>> is normal and expected that nautilus will want to see if files are executable
>> or if they are really read/write-able.  access() should return the real
>> permission.  SELinux policy checks are done in access() and can result in lots
>> of AVC denials as policy denies RWX on files which DAC allows.  Currently
>> SELinux must dontaudit actual attempts to read/write/execute a file in
>> order to silence these messages (and not flood the logs.)  But dontaudit rules
>> like that can hide real attacks.  This patch addes a new common file
>> permission audit_access.  This permission is special in that it is meaningless
>> and should never show up in an allow rule.  Instead the only place this
>> permission has meaning is in a dontaudit rule like so:
>>
>> dontaudit nautilus_t sbin_t:file audit_access
>>
>> With such a rule if nautilus just checks access() we will still get denied and
>> thus userspace will still get the correct answer but we will not log the denial.
>> If nautilus attempted to actually perform one of the forbidden actions
>> (rather than just querying access(2) about it) we would still log a denial.
>> This type of dontaudit rule should be used sparingly, as it could be a
>> method for an attacker to probe the system permissions without detection.
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
>> Signed-off-by: Eric Paris <eparis@redhat.com>
>> ---
>>
>>  security/selinux/hooks.c            |   46 ++++++++++++++++++++++++++++++-----
>>  security/selinux/include/classmap.h |    2 +-
>>  2 files changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 344ba62..34e9d1b 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2696,19 +2696,51 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *na
>>  	return dentry_has_perm(cred, NULL, dentry, FILE__READ);
>>  }
>>  
>> -static int selinux_inode_permission(struct inode *inode, int mask)
>> +static int selinux_inode_permission(struct inode *inode, int in_mask)
>>  {
>>  	const struct cred *cred = current_cred();
>> +	struct inode_security_struct *isec;
>> +	struct common_audit_data ad;
>> +	struct av_decision avd;
>> +	u32 sid, perms;
>> +	int rc, mask;
>>  
>> -	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
>> +	mask = in_mask & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
>>  
>> -	if (!mask) {
>> -		/* No permission to check.  Existence test. */
>> +	/* No permission to check.  Existence test. */
>> +	if (!mask)
>> +		return 0;
>> +
>> +	validate_creds(cred);
>> +
>> +	if (unlikely(IS_PRIVATE(inode)))
>>  		return 0;
> 
> This is handled by security_inode_permission().  The check inside
> inode_has_perm() stems from other code paths.
> 
>> -	}
>>  
>> -	return inode_has_perm(cred, inode,
>> -			      file_mask_to_av(inode->i_mode, mask), NULL);
>> +	sid = cred_sid(cred);
>> +	isec = inode->i_security;
>> +
>> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>> +	ad.u.fs.inode = inode;
>> +
>> +	perms = file_mask_to_av(inode->i_mode, mask);
>> +
>> +	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
>> +	/*
>> +	 * We want to audit if this call was not from access(2).
>> +	 * We also want to audit if the call was from access(2)
>> +	 * but the magic FILE__AUDIT_ACCESS permission was in the auditdeny
>> +	 * vector.
>> +	 *
>> +	 * aka there is a not dontaudit rule for file__audit_access.  This
>> +	 * might make more sense as a test inside avc_audit, but then we would
>> +	 * have to push the MAY_ACCESS flag down to avc_audit and I think we
>> +	 * already have enough stuff down there.
>> +	 */
> 
> Why can't we just push it down through inode_has_perm -> avc_has_perm ->
> avc_audit() via a field in common_audit_data?
> 
>> +	if (!(in_mask & MAY_ACCESS) ||
>> +	    (avd.auditdeny & FILE__AUDIT_ACCESS))
>> +		avc_audit(sid, isec->sid, isec->sclass, perms, &avd, rc, &ad);
>> +
>> +	return rc;
>>  }
>>  
> 
> 
Now if we had a policy lanquage that said staff_nautilus_t == (staff_t +
audit_access)

Meaning all interface/transitions and rules apply to both domains and
self rules allow interaction between the two, we could allow this access
to only nautilus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvW+tcACgkQrlYvE4MpobN/nQCgigZZv8oW6HGzqT4YPxGK5tWj
OaMAn1yG+hhS4qUDBbo3YeNgNG0YUpfB
=dl0O
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
