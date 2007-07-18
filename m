Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        Joshua Brindle <method@manicmethod.com>, sailer@us.ibm.com
In-Reply-To: <1184683948.17338.139.camel@moss-spartans.epoch.ncsc.mil>
References: <1184594240.5860.5.camel@localhost.localdomain>
	 <1184683948.17338.139.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 17:43:02 -0400
Message-Id: <1184794982.10771.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-17 at 10:52 -0400, Stephen Smalley wrote: 
> On Mon, 2007-07-16 at 09:57 -0400, Mimi Zohar wrote:
> > This is a first attempt to verify and measure file integrity, by
> > adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> > We are planning on posting the corresponding LIM and IMA patches to
> > LKML, but would like comments/suggestions here first, particularly
> > in regards to the policy checking code in selinux_measure() called 
> > from selinux_inode_permission().
> > 
> > SELINUX_ENFORCE_INTEGRITY can be configured to either verify and
> > enforce integrity or to just log integrity failures. The default
> > is to just log integrity failures.
> 
> Wrong place, if you want permissive vs. enforcing modes for your
> integrity checks, put them into your integrity module and let that
> determine the result it returns to the caller.

The LIM provider returns the integrity status of file metadata/data.
What is done with this information should be left up to the LSM 
module as it is responsible for all access control decisions, 
including how to handle integrity errors.  

The SELINUX_ENFORCE_INTEGRITY option is meant for testing and
development of basing access control decisions on a new criteria
integrity.

> > The integrity of the SELinux metadata is verified when the xattr
> > is initially retrieved.  On an integrity failure, assuming that
> > integrity verification is enforced, normal error processing occurs.
> > 
> > By default, all executables and all files that are mmap'ed executable
> > are measured. This patch extends the file class with 'measure'.
> 
> As others have said, it would be better to let policy fully control what
> is measured to avoid unnecessary measurements.

Ok.

> > Additional files can be measured in selinux_inode_permission()
> > based on a FILE__MEASURE policy. (As the policy call is causing too
> > many files to be measured, it is commented out.) For example, to
> > measure kernel modules add:
> > 	module ima 1.0;
> > 
> > 	require {
> > 		type insmod_t;
> > 		type modules_object_t;
> > 		class file measure;
> > 	}
> > 
> > 	#============= insmod_t ==============
> > 	allow insmod_t modules_object_t:file measure;
> 
> Seems like the wrong granularity.
> You just want a selector based on file type, right?

Initially I thought that was the case, but perhaps the 
only times kernel modules should be measured is when they're
actually being insmod/modprobe.

> > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> > ---
> > Index: linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > ===================================================================
> > --- linux-2.6.22-rc6-mm1.orig/security/selinux/hooks.c
> > +++ linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > @@ -70,6 +70,7 @@
> >  #include <linux/audit.h>
> >  #include <linux/string.h>
> >  #include <linux/selinux.h>
> > +#include <linux/integrity.h>
> >  #include <linux/mutex.h>
> >  
> >  #include "avc.h"
> > @@ -109,6 +110,12 @@ __setup("selinux=", selinux_enabled_setu
> >  int selinux_enabled = 1;
> >  #endif
> >  
> > +#ifdef CONFIG_SECURITY_SELINUX_ENFORCE_INTEGRITY
> > +static int integrity_enforce = 1;
> > +#else
> > +static int integrity_enforce;
> > +#endif
> 
> Belongs as part of your integrity module, not here.

Discussed above.

> >  /* Original (dummy) security module. */
> >  static struct security_operations *original_ops = NULL;
> >  
> > @@ -847,6 +854,7 @@ static int inode_doinit_with_dentry(stru
> >  	char *context = NULL;
> >  	unsigned len = 0;
> >  	int rc = 0;
> > +	int status;
> >  
> >  	if (isec->initialized)
> >  		goto out;
> > @@ -890,35 +898,12 @@ static int inode_doinit_with_dentry(stru
> >  			goto out_unlock;
> >  		}
> >  
> > -		len = INITCONTEXTLEN;
> > -		context = kmalloc(len, GFP_KERNEL);
> > -		if (!context) {
> > -			rc = -ENOMEM;
> > +		rc = integrity_verify_metadata(dentry, XATTR_NAME_SELINUX,
> > +				       &context, &len, &status);
> > +		if (rc == -ENOMEM) {
> 
> Digging out your other integrity patches, I see that
> dummy_verify_metadata is not equivalent to our code in a couple of
> important respects:
> - you always call getxattr twice to probe for the length, whereas we
> only do it twice if our default length isn't sufficient.  That will have
> a performance impact as well as make the system more prone to error
> (example:  interleaving of setxattr with those two getxattr calls may
> cause the length to change between them, causing the latter call to
> still fail).

Ok, I will look into changing this behavior.

> - you call vfs_getxattr rather than directly calling i_op->getxattr, but
> the VFS code has additional processing that we specifically do not want
> here (e.g. permission checking, fallback to the security module to
> supply the canonical value).  We only want to fetch the value from the
> filesystem here for SELinux-internal use, not apply permission checking
> based on the current process or loop back into SELinux again to ask for
> the in-core value.

The current version of the dummy integrity provider, which has not been
posted, does not use vfs_getxattr.  Will post the current version here.

> > @@ -932,6 +917,19 @@ static int inode_doinit_with_dentry(stru
> >  			sid = sbsec->def_sid;
> >  			rc = 0;
> >  		} else {
> > +			/* Log integrity failures, if integrity enforced
> > +			 * behave like for any other failure.
> > +			 */
> > +			if (status == INTEGRITY_FAIL) {
> > +				printk(KERN_WARNING "%s: verify_metadata "
> > +				       "failed for dev=%s ino=%ld\n",
> > +					__FUNCTION__,
> > +					inode->i_sb->s_id, inode->i_ino);
> > +				if (integrity_enforce) {
> > +					kfree(context);
> > +					goto out_unlock;
> > +				}
> > +			}
> 
> Belongs in your integrity module, and should use audit rather than
> printk.

Discussed above.  Will look into using the audit commands as Paul Moore
and Steve Grubb suggested.

> > @@ -1701,9 +1699,109 @@ static int selinux_bprm_set_security(str
> >  	return 0;
> >  }
> >  
> > -static int selinux_bprm_check_security (struct linux_binprm *bprm)
> > +static inline int is_kernel_thread(struct task_struct *tsk)
> > +{
> > +	return (!tsk->mm) ? 1 : 0;
> > +}
> 
> Rationale for this special case, and argument that this test is a sound
> way for catching all such cases?

When based on a policy, this and other code, will be unnecessary.

> > +static int selinux_verify_metadata(struct dentry *dentry)
> > +{
> > +	int rc, status;
> > +
> > +	if (!dentry)
> > +		return 0;
> 
> Under what conditions can dentry be NULL here, and if it can be, why it
> is "safe" to fail open by returning 0?
> 
> > +
> > +	rc = integrity_verify_metadata(dentry, NULL, NULL, NULL, &status);
> > +	if (rc == -EOPNOTSUPP)
> > +		return 0;
> 
> What are you verifying here?

The EOPNOTSUPP is for those filesystems that do not support extended 
attributes.  The call verifies the integrity of the metadata in general,
not a specific extended xattr.

> > +static int selinux_verify_and_measure(struct dentry *dentry,
> > +					struct file *file,
> > +					char *filename, int mask)
> > +{
> > +	int rc, status;
> > +
> > +	if (!dentry && !file)
> > +		return 0;
> > +
> > +	rc = integrity_verify_data(dentry, file, &status);
> 
> What are we verifying here?

The actual file data.

> > +	if (rc < 0) {
> > +		printk(KERN_INFO "%s: %s verify_data failed "
> > +		       "(rc: %d - status: %d)\n", __FUNCTION__,
> > +			filename, rc, status);
> > +		if (!integrity_enforce)
> > +			rc = 0;
> > +		goto out;
> > +	}
> > +
> > +	if (status != INTEGRITY_PASS) {
> > +		if (!is_kernel_thread(current)) {
> > +			printk(KERN_INFO "%s: verify_data %s "
> > +			       "(Integrity status: FAIL)\n",
> > +				__FUNCTION__, filename);
> > +			if (integrity_enforce) {
> > +				rc = -EACCES;
> > +				goto out;
> > +			}
> > +		}
> > +	}
> > +
> > +	/* Only measure files that passed integrity verification. */
> > +	integrity_measure(dentry, file, filename, mask);
> 
> Are we measuring the same thing we verified?  Can it change in between?
> Can it change after being verified and measured before use?  What good
> is it?

The OS itself protects against an executable file open for execute from
being modified.  As for other files, you are correct, the file could be
modified before being read.  The current source forge version of IMA
tracks possible violations. This is on my todo list. 

> > @@ -2252,6 +2350,30 @@ static int selinux_inode_follow_link(str
> >  	return dentry_has_perm(current, NULL, dentry, FILE__READ);
> >  }
> >  
> > +/*
> > + * Measure based on a policy
> > + */
> > +static int selinux_measure(struct inode *inode, struct dentry *dentry)
> > +{
> > +	int rc = 1;
> > +#if 0
> > +	struct inode_security_struct *isec = inode->i_security;
> > +	struct task_security_struct *tsec = current->security;
> > +	struct av_decision avd;
> > +	struct avc_audit_data ad;
> > +
> > +	/* This initial attempt to base on policy measures too much. */
> > +	rc = avc_has_perm_noaudit(tsec->sid, isec->sid, SECCLASS_FILE,
> > +				  FILE__MEASURE, AVC_STRICT, &avd);
> > +	AVC_AUDIT_DATA_INIT(&ad,FS);
> > +	ad.u.fs.mnt = NULL;
> > +	ad.u.fs.dentry = dentry;
> > +	avc_audit(tsec->sid, isec->sid, SECCLASS_FILE, FILE__MEASURE,
> > +		  &avd, rc, &ad);
> 
> You certainly don't want to audit these denials, since you don't want
> audit2allow to ever generate them.  So no call to avc_audit() at all.

Correct, I certainly don't want to audit the denials. If I did I would
have used avc_has_perm().  The audit call is only here to help 
understand what is being measured.

> Unfortunately for you, policy uses "*" in allow rules for unconfined
> domains, and this means that your new permission is actually allowed by
> existing policies (because the policy compiler is just turning "*" into
> ~0UL and likewise turning "~{ a b c}" into the complement of that set,
> so the access vectors can have the bits turned on even if the permission
> wasn't defined yet.

Thank you for the explanation.  At OLS, there was a suggestion to use
avc_has_perm_noaudit().  As this is not measuring the appropriate files,
do you, or anyone else, have any other recommendations?

> Function name is confusing as it suggests that it actually does the
> measurement, not just deciding whether or not to do it.

Ok.

> > @@ -2265,9 +2387,26 @@ static int selinux_inode_permission(stru
> >  		/* No permission to check.  Existence test. */
> >  		return 0;
> >  	}
> > -
> > -	return inode_has_perm(current, inode,
> > +	rc = inode_has_perm(current, inode,
> >  			       file_mask_to_av(inode->i_mode, mask), NULL);
> > +	if (rc != 0)
> > +		return rc;
> > +
> > +	if (S_ISREG(inode->i_mode) && (mask & MAY_READ)) {
> > +		struct dentry *dentry;
> > +
> > +		dentry = (!nd || !nd->dentry) ?
> > +				d_find_alias(inode) : nd->dentry;
> 
> NAK.  Either you truly need the dentry (in which case this is the wrong
> place for it) or you don't (in which case you shouldn't depend on it).

Wouldn't it depend on how you are using the dentry?  In this case,
the dentry is used to get a file handle in order to measure the file.

> > +
> > +		if (dentry) {
> > +			if (selinux_measure(inode, dentry) == 0)
> > +				integrity_measure(dentry, NULL,
> > +					(char *)dentry->d_name.name, mask);
> > +			if (!nd || !nd->dentry)
> > +				dput(dentry);
> > +		}
> 
> So we measure the data at permission check time, but it changes before
> it gets read by the actual data consumer (kernel or userland).  What do
> we gain?

Discussed above.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
