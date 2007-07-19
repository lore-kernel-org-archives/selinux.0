Subject: Re: [RFC]integrity: SELinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        Joshua Brindle <method@manicmethod.com>, sailer@us.ibm.com,
        James Morris <jmorris@namei.org>
In-Reply-To: <1184794982.10771.15.camel@localhost.localdomain>
References: <1184594240.5860.5.camel@localhost.localdomain>
	 <1184683948.17338.139.camel@moss-spartans.epoch.ncsc.mil>
	 <1184794982.10771.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 09:08:32 -0400
Message-Id: <1184850512.17338.462.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-07-18 at 17:43 -0400, Mimi Zohar wrote:
> On Tue, 2007-07-17 at 10:52 -0400, Stephen Smalley wrote: 
> > On Mon, 2007-07-16 at 09:57 -0400, Mimi Zohar wrote:
> > > This is a first attempt to verify and measure file integrity, by
> > > adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> > > We are planning on posting the corresponding LIM and IMA patches to
> > > LKML, but would like comments/suggestions here first, particularly
> > > in regards to the policy checking code in selinux_measure() called 
> > > from selinux_inode_permission().
> > > 
> > > SELINUX_ENFORCE_INTEGRITY can be configured to either verify and
> > > enforce integrity or to just log integrity failures. The default
> > > is to just log integrity failures.
> > 
> > Wrong place, if you want permissive vs. enforcing modes for your
> > integrity checks, put them into your integrity module and let that
> > determine the result it returns to the caller.
> 
> The LIM provider returns the integrity status of file metadata/data.
> What is done with this information should be left up to the LSM 
> module as it is responsible for all access control decisions, 
> including how to handle integrity errors.  
> 
> The SELINUX_ENFORCE_INTEGRITY option is meant for testing and
> development of basing access control decisions on a new criteria
> integrity.

There is nothing you are doing with it that can't be done transparently
by the integrity module itself, thereby simplifying the callers.  It is
a global permissive vs. enforcing mode for integrity, nothing
selinux-specific.

> > > Additional files can be measured in selinux_inode_permission()
> > > based on a FILE__MEASURE policy. (As the policy call is causing too
> > > many files to be measured, it is commented out.) For example, to
> > > measure kernel modules add:
> > > 	module ima 1.0;
> > > 
> > > 	require {
> > > 		type insmod_t;
> > > 		type modules_object_t;
> > > 		class file measure;
> > > 	}
> > > 
> > > 	#============= insmod_t ==============
> > > 	allow insmod_t modules_object_t:file measure;
> > 
> > Seems like the wrong granularity.
> > You just want a selector based on file type, right?
> 
> Initially I thought that was the case, but perhaps the 
> only times kernel modules should be measured is when they're
> actually being insmod/modprobe.

For that particular case, I think you'd do it via a new hook in the
kernel module loading code, making sure that you are verifying/measuring
the same data that gets used.  More along the lines of the MODSIGN
patches posted a while ago on lkml and used in Red Hat kernels.

> > > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> > > ---
> > > Index: linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > > ===================================================================
> > > --- linux-2.6.22-rc6-mm1.orig/security/selinux/hooks.c
> > > +++ linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> > > @@ -70,6 +70,7 @@
> > >  #include <linux/audit.h>
> > >  #include <linux/string.h>
> > >  #include <linux/selinux.h>
> > > +#include <linux/integrity.h>
> > >  #include <linux/mutex.h>
> > >  
> > >  #include "avc.h"
> > > @@ -109,6 +110,12 @@ __setup("selinux=", selinux_enabled_setu
> > >  int selinux_enabled = 1;
> > >  #endif
> > >  
> > > +#ifdef CONFIG_SECURITY_SELINUX_ENFORCE_INTEGRITY
> > > +static int integrity_enforce = 1;
> > > +#else
> > > +static int integrity_enforce;
> > > +#endif
> > 
> > Belongs as part of your integrity module, not here.
> 
> Discussed above.

But I still don't agree.  I don't want multiple permissive vs. enforcing
modes defined by selinux itself, particularly for something that it
isn't computing anyway.

> > - you call vfs_getxattr rather than directly calling i_op->getxattr, but
> > the VFS code has additional processing that we specifically do not want
> > here (e.g. permission checking, fallback to the security module to
> > supply the canonical value).  We only want to fetch the value from the
> > filesystem here for SELinux-internal use, not apply permission checking
> > based on the current process or loop back into SELinux again to ask for
> > the in-core value.
> 
> The current version of the dummy integrity provider, which has not been
> posted, does not use vfs_getxattr.  Will post the current version here.

Ok, but you should update the comment to note that it isn't about the
vfs layer being available (not sure what you mean there), but rather
about avoiding extraneous processing that should only be applied upon
userspace access to the xattr (like permission checking based on the
current process' credentials and giving the security module a chance to
provide or canonicalize the result) and not upon a kernel-internal
request for it.

> > Are we measuring the same thing we verified?  Can it change in between?
> > Can it change after being verified and measured before use?  What good
> > is it?
> 
> The OS itself protects against an executable file open for execute from
> being modified.  As for other files, you are correct, the file could be
> modified before being read.  The current source forge version of IMA
> tracks possible violations. This is on my todo list. 

So you are assuming that your measurement and verification calls are
happening after deny_write_access() has occurred; should be noted.
For other files, should be handled by putting the verify+measure at the
same point where the data is being loaded, acting on the same copy of
the data in memory rather than done just upon open-time permission
checking.

> > You certainly don't want to audit these denials, since you don't want
> > audit2allow to ever generate them.  So no call to avc_audit() at all.
> 
> Correct, I certainly don't want to audit the denials. If I did I would
> have used avc_has_perm().  The audit call is only here to help 
> understand what is being measured.

There is no difference between calling avc_has_perm() vs.
avc_has_perm_noaudit()+avc_audit(), so by doing both, you are
effectively doing the former.  I guess you mean you'll drop the
avc_audit() call for real use.

> > Unfortunately for you, policy uses "*" in allow rules for unconfined
> > domains, and this means that your new permission is actually allowed by
> > existing policies (because the policy compiler is just turning "*" into
> > ~0UL and likewise turning "~{ a b c}" into the complement of that set,
> > so the access vectors can have the bits turned on even if the permission
> > wasn't defined yet.
> 
> Thank you for the explanation.  At OLS, there was a suggestion to use
> avc_has_perm_noaudit().  As this is not measuring the appropriate files,
> do you, or anyone else, have any other recommendations?

Defining a new class for this purpose will free you from having any
legacy policies implicitly granting the permission.

> > > +	rc = inode_has_perm(current, inode,
> > >  			       file_mask_to_av(inode->i_mode, mask), NULL);
> > > +	if (rc != 0)
> > > +		return rc;
> > > +
> > > +	if (S_ISREG(inode->i_mode) && (mask & MAY_READ)) {
> > > +		struct dentry *dentry;
> > > +
> > > +		dentry = (!nd || !nd->dentry) ?
> > > +				d_find_alias(inode) : nd->dentry;
> > 
> > NAK.  Either you truly need the dentry (in which case this is the wrong
> > place for it) or you don't (in which case you shouldn't depend on it).
> 
> Wouldn't it depend on how you are using the dentry?  In this case,
> the dentry is used to get a file handle in order to measure the file.

You don't want your code to sometimes succeed in measuring and sometimes
not depending on whether you happen to have a dentry available for the
inode.

> > > +
> > > +		if (dentry) {
> > > +			if (selinux_measure(inode, dentry) == 0)
> > > +				integrity_measure(dentry, NULL,
> > > +					(char *)dentry->d_name.name, mask);
> > > +			if (!nd || !nd->dentry)
> > > +				dput(dentry);
> > > +		}
> > 
> > So we measure the data at permission check time, but it changes before
> > it gets read by the actual data consumer (kernel or userland).  What do
> > we gain?
> 
> Discussed above.

In general, I'm not sure that you are doing measurement and verification
at the right points, or that the LSM hooks fit well for placement.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
