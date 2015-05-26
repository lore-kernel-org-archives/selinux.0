From: "Roberts, William C" <william.c.roberts@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] [RFC] kernfs: hook inode initialization for LSMs
Date: Tue, 26 May 2015 18:41:07 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560101855C@ORSMSX103.amr.corp.intel.com>
References: <1432319136-160378-1-git-send-email-william.c.roberts@intel.com>
 <1432319136-160378-2-git-send-email-william.c.roberts@intel.com>
 <20150523151505.GD11783@kroah.com>
In-Reply-To: <20150523151505.GD11783@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Saturday, May 23, 2015 8:15 AM
> To: Roberts, William C
> Cc: selinux@tycho.nsa.gov; linux-security-module@vger.kernel.org;
> sds@tycho.nsa.gov
> Subject: Re: [PATCH] [RFC] kernfs: hook inode initialization for LSMs
> 
> On Fri, May 22, 2015 at 11:25:36AM -0700, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > This corrects issues in client filesystems, like sysfs, where LSMs
> > missed the opportunity to initialize inodes. In the case of SELinux
> > this prevented newly created files from inheriting their parent's
> > label. This has posed many issues on Android where transient sysfs
> > files were defaulting to the sysfs wide label, rather than their
> > parent, which is the normal behavior for other filesystems. Without
> > this, access controls for these files had to be granted on the file
> > system wide label, rather then a file specific label. The result of

Just noticed this "then --> than" grammar issue. I will fix in  a finalized patch
after addressing any concerns/comments.

> > which over-privilege the caller but also can cause CTS failures.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  fs/kernfs/dir.c             |  2 +-
> >  fs/kernfs/inode.c           | 34 ++++++++++++++++++++++++++++++----
> >  fs/kernfs/kernfs-internal.h | 26 +++++++++++++++++++++++++-
> >  fs/kernfs/mount.c           |  2 +-
> >  4 files changed, 57 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c index fffca95..096379e
> > 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -809,7 +809,7 @@ static struct dentry *kernfs_iop_lookup(struct
> inode *dir,
> >  	dentry->d_fsdata = kn;
> >
> >  	/* attach dentry and inode */
> > -	inode = kernfs_get_inode(dir->i_sb, kn);
> > +	inode = kernfs_get_inode(dir->i_sb, kn, dentry->d_parent);
> >  	if (!inode) {
> >  		ret = ERR_PTR(-ENOMEM);
> >  		goto out_unlock;
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c index
> > 2da8493..d37b8ff 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -281,8 +281,10 @@ int kernfs_iop_getattr(struct vfsmount *mnt,
> struct dentry *dentry,
> >  	return 0;
> >  }
> >
> > -static void kernfs_init_inode(struct kernfs_node *kn, struct inode
> > *inode)
> > +static int kernfs_init_inode(struct kernfs_node *kn, struct inode *inode,
> > +			struct dentry *parent)
> >  {
> > +	int error = 0;
> >  	kernfs_get(kn);
> >  	inode->i_private = kn;
> >  	inode->i_mapping->a_ops = &kernfs_aops; @@ -291,6 +293,8 @@
> static
> > void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
> >  	set_default_inode_attr(inode, kn->mode);
> >  	kernfs_refresh_inode(kn, inode);
> >
> > +	WARN_ON(kn->parent && !parent);
> 
> Why?  What is this going to tell us, or anyone else if it triggers?

It was to catch the case when you think you're passing the root
node, and there is no parent, but you're actually passing something
further down that has a parent. The LSM's initialize the root node in a
separate hook, and this routine was used to get both the root node and
sub-nodes. We don't want callers to specify a NULL parent, when one
truly exists, and bypass the LSM inode initialization.

In a previous version of the patch, I attempted to look up the kernfs_node's
parent. However, it can result in sysfs-level deep recursion when you look up
the parent but It's a cache miss, and thus you need to initialize a node, which
then results in another lookup. The goal with this design was to minimize lookup
overhead since the caller had the parent inode in-hand.

> 
> > +
> >  	/* initialize inode according to type */
> >  	switch (kernfs_type(kn)) {
> >  	case KERNFS_DIR:
> > @@ -308,31 +312,53 @@ static void kernfs_init_inode(struct kernfs_node
> *kn, struct inode *inode)
> >  		BUG();
> >  	}
> >
> > +	if (parent)
> > +		error = security_inode_init_security(inode, parent-
> >d_inode,
> > +				&parent->d_name, NULL, NULL);
> > +
> >  	unlock_new_inode(inode);
> > +	return error;
> >  }
> >
> >  /**
> >   *	kernfs_get_inode - get inode for kernfs_node
> >   *	@sb: super block
> >   *	@kn: kernfs_node to allocate inode for
> > + *	@parent:The parent dentry or NULL if root node
> >   *
> >   *	Get inode for @kn.  If such inode doesn't exist, a new inode is
> >   *	allocated and basics are initialized.  New inode is returned
> >   *	locked.
> >   *
> > + *	WARN: If parent is null but @kn is not the root node.
> > + *
> >   *	LOCKING:
> >   *	Kernel thread context (may sleep).
> >   *
> >   *	RETURNS:
> >   *	Pointer to allocated inode on success, NULL on failure.
> >   */
> > -struct inode *kernfs_get_inode(struct super_block *sb, struct
> > kernfs_node *kn)
> > +struct inode *kernfs_get_inode(struct super_block *sb, struct
> kernfs_node *kn,
> > +			struct dentry *parent)
> >  {
> > +	int error;
> >  	struct inode *inode;
> >
> >  	inode = iget_locked(sb, kn->ino);
> > -	if (inode && (inode->i_state & I_NEW))
> > -		kernfs_init_inode(kn, inode);
> > +	if (inode && (inode->i_state & I_NEW)) {
> > +		error = kernfs_init_inode(kn, inode, parent);
> > +		if (unlikely(error)) {
> > +			/*
> > +			 * XXX
> > +			 * What is the proper error sequence here?
> > +			 * Should we kernfs_put() and iput() or
> > +			 * just run the kernfs_evict_inode()
> > +			 * routine.
> > +			 */
> 
> How can kernfs_init_inode now fail?  What does LSM expect us to do with
> that information, was it just a failure in the LSM, or something that we now
> are supposed to not allow to have happen within the filesystem?

No it's really just a failure in the LSM. I initially left this as a non-fatal failure, however,
changed it during code review. My original thought was in the case of failure the node is created
with the default sysfs file label, and policy will not allow access to it, however for other
creations of policy, perhaps you don't want the node to exist if the LSM cannot label it.
So because of that reason, if the LSM fails, we wouldn't the node to appear in sysfs.

> 
> > +			kernfs_evict_inode(inode);
> > +			return NULL;
> > +		}
> > +	}
> >
> >  	return inode;
> >  }
> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> > index af9fa74..b2ead66 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > @@ -76,7 +76,8 @@ extern struct kmem_cache *kernfs_node_cache;
> >  /*
> >   * inode.c
> >   */
> > -struct inode *kernfs_get_inode(struct super_block *sb, struct
> > kernfs_node *kn);
> > +struct inode *kernfs_get_inode(struct super_block *sb, struct
> kernfs_node *kn,
> > +			       struct dentry *parent);
> >  void kernfs_evict_inode(struct inode *inode);  int
> > kernfs_iop_permission(struct inode *inode, int mask);  int
> > kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr); @@
> > -89,6 +90,29 @@ ssize_t kernfs_iop_getxattr(struct dentry *dentry, const
> char *name, void *buf,
> >  			    size_t size);
> >  ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t
> > size);
> >
> > +/**
> > + *	kernfs_get_root_inode - get root inode for kernfs_node
> > + *	@sb: super block
> > + *	@kn: kernfs_node to allocate inode for
> > + *
> > + *	SEE: kernfs_get_inode() for more details
> > + *
> > + *	WARN: if @kn is not the root node, ie has a parent.
> > + *
> > + *	LOCKING:
> > + *	Kernel thread context (may sleep).
> > + *
> > + *	RETURNS:
> > + *	Pointer to allocated inode on success, NULL on failure.
> > + */
> > +static inline struct inode *kernfs_get_root_inode(struct super_block *sb,
> > +					struct kernfs_node *kn)
> > +{
> > +	WARN_ON(kn->parent);
> > +	return kernfs_get_inode(sb, kn, NULL);
> 
> Why is this whole function even needed?

It's not, but a comment during review stated that passing NULL as the 3rd argument in the mount.c
case was awkward, which I could see. But I am not attached to this change.

> 
> thanks,
> 
> greg k-h
