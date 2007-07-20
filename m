Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        Joshua Brindle <method@manicmethod.com>, sailer@us.ibm.com,
        James Morris <jmorris@namei.org>
In-Reply-To: <1184850512.17338.462.camel@moss-spartans.epoch.ncsc.mil>
References: <1184594240.5860.5.camel@localhost.localdomain>
	 <1184683948.17338.139.camel@moss-spartans.epoch.ncsc.mil>
	 <1184794982.10771.15.camel@localhost.localdomain>
	 <1184850512.17338.462.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 14:57:46 -0400
Message-Id: <1184957867.11290.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-07-19 at 09:08 -0400, Stephen Smalley wrote:
> On Wed, 2007-07-18 at 17:43 -0400, Mimi Zohar wrote:
> > On Tue, 2007-07-17 at 10:52 -0400, Stephen Smalley wrote: 
> > > On Mon, 2007-07-16 at 09:57 -0400, Mimi Zohar wrote:
> > > > This is a first attempt to verify and measure file integrity, by
> > > > adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> > > > We are planning on posting the corresponding LIM and IMA patches to
> > > > LKML, but would like comments/suggestions here first, particularly
> > > > in regards to the policy checking code in selinux_measure() called 
> > > > from selinux_inode_permission().
> > > > 
> > > > SELINUX_ENFORCE_INTEGRITY can be configured to either verify and
> > > > enforce integrity or to just log integrity failures. The default
> > > > is to just log integrity failures.
> > > 
> > > Wrong place, if you want permissive vs. enforcing modes for your
> > > integrity checks, put them into your integrity module and let that
> > > determine the result it returns to the caller.
> > 
> > The LIM provider returns the integrity status of file metadata/data.
> > What is done with this information should be left up to the LSM 
> > module as it is responsible for all access control decisions, 
> > including how to handle integrity errors.  
> > 
> > The SELINUX_ENFORCE_INTEGRITY option is meant for testing and
> > development of basing access control decisions on a new criteria
> > integrity.
> 
> There is nothing you are doing with it that can't be done transparently
> by the integrity module itself, thereby simplifying the callers.  It is
> a global permissive vs. enforcing mode for integrity, nothing
> selinux-specific.

The difference between having the option in the LSM module vs. the
integrity provider is the completeness of the error message reported. 
I have no problem moving the option into the integrity module, but as
the integrity provider doesn't implement access control, the name
enforce_integrity obviously would be inappropriate, perhaps
integrity_logmode.  Other LSM modules would still have the option to
implement an integrity_enforce option.

> > > - you call vfs_getxattr rather than directly calling i_op->getxattr, but
> > > the VFS code has additional processing that we specifically do not want
> > > here (e.g. permission checking, fallback to the security module to
> > > supply the canonical value).  We only want to fetch the value from the
> > > filesystem here for SELinux-internal use, not apply permission checking
> > > based on the current process or loop back into SELinux again to ask for
> > > the in-core value.
> > 
> > The current version of the dummy integrity provider, which has not been
> > posted, does not use vfs_getxattr.  Will post the current version here.
> 
> Ok, but you should update the comment to note that it isn't about the
> vfs layer being available (not sure what you mean there), but rather
> about avoiding extraneous processing that should only be applied upon
> userspace access to the xattr (like permission checking based on the
> current process' credentials and giving the security module a chance to
> provide or canonicalize the result) and not upon a kernel-internal
> request for it.

Ok

> > > Are we measuring the same thing we verified?  Can it change in between?
> > > Can it change after being verified and measured before use?  What good
> > > is it?
> > 
> > The OS itself protects against an executable file open for execute from
> > being modified.  As for other files, you are correct, the file could be
> > modified before being read.  The current source forge version of IMA
> > tracks possible violations. This is on my todo list. 
> 
> So you are assuming that your measurement and verification calls are
> happening after deny_write_access() has occurred; should be noted.

Will do.

> For other files, should be handled by putting the verify+measure at the
> same point where the data is being loaded, acting on the same copy of
> the data in memory rather than done just upon open-time permission
> checking.

Today, if the LSM module wants to know that the file has unequivocally
changed, then yes we would need to do as you suggested. But as we are 
not attempting to prevent the file from actually being changed, we 
will note it, with a violation and in the PCR, that the file has
definitively changed or could have possibly been changed.  When
the mtime bug is fixed, all of the reported violations will be
definitive in that the file changed.  This will not imply anything
as to when the change took place(before, during, or after being
read).

> > > > +	rc = inode_has_perm(current, inode,
> > > >  			       file_mask_to_av(inode->i_mode, mask), NULL);
> > > > +	if (rc != 0)
> > > > +		return rc;
> > > > +
> > > > +	if (S_ISREG(inode->i_mode) && (mask & MAY_READ)) {
> > > > +		struct dentry *dentry;
> > > > +
> > > > +		dentry = (!nd || !nd->dentry) ?
> > > > +				d_find_alias(inode) : nd->dentry;
> > > 
> > > NAK.  Either you truly need the dentry (in which case this is the wrong
> > > place for it) or you don't (in which case you shouldn't depend on it).
> > 
> > Wouldn't it depend on how you are using the dentry?  In this case,
> > the dentry is used to get a file handle in order to measure the file.
> 
> You don't want your code to sometimes succeed in measuring and sometimes
> not depending on whether you happen to have a dentry available for the
> inode.

The call to integrity_measure() is in the correct place. Just that it
should be possible to call integrity_measure() with an inode, as well as
with a dentry or file when available.

> > > > +
> > > > +		if (dentry) {
> > > > +			if (selinux_measure(inode, dentry) == 0)
> > > > +				integrity_measure(dentry, NULL,
> > > > +					(char *)dentry->d_name.name, mask);
> > > > +			if (!nd || !nd->dentry)
> > > > +				dput(dentry);
> > > > +		}
> > > 
> > > So we measure the data at permission check time, but it changes before
> > > it gets read by the actual data consumer (kernel or userland).  What do
> > > we gain?
> > 
> > Discussed above.
> 
> In general, I'm not sure that you are doing measurement and verification
> at the right points, or that the LSM hooks fit well for placement.

The integrity subsystem provides a framework for an integrity provider
to maintain the data/metadata file integrity status, which an LSM module
can request when and as desired. The LSM module can then use the results
as another criteria on which to base access control decisions.  It is left
up to the LSM module to decide when it wants to call integrity_measure.
As you suggested there might be additional places from which an LSM module
would want to verify and measure the data, but the current LSM hooks 
provide a good starting point.

Mimi Zohar


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
