From: "Roberts, William C" <william.c.roberts@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] kernfs: hook inode initialization for LSMs
Date: Wed, 10 Jun 2015 15:56:05 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560101BD9B@ORSMSX103.amr.corp.intel.com>
References: <1433877101-31866-1-git-send-email-william.c.roberts@intel.com>
 <1433877101-31866-2-git-send-email-william.c.roberts@intel.com>
 <20150609210925.GB16038@kroah.com>
In-Reply-To: <20150609210925.GB16038@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Selinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, June 9, 2015 2:09 PM
> To: Roberts, William C
> Cc: Selinux@tycho.nsa.gov
> Subject: Re: [PATCH] kernfs: hook inode initialization for LSMs
> 
> On Tue, Jun 09, 2015 at 12:11:41PM -0700, william.c.roberts@intel.com
> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > This corrects issues in client filesystems, like sysfs, where LSMs
> > missed the opportunity to initialize inodes. In the case of SELinux
> > this prevented newly created files from inheriting their parent's
> > label. This has posed many issues on Android where transient sysfs
> > files were defaulting to the sysfs wide label, rather than their
> > parent, which is the normal behavior for other filesystems. Without
> > this, access controls for these files had to be granted on the file
> > system wide label, rather than a file specific label. The result of
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
> What can a developer do about this?
This means that the node has a parent, but you didn't pass it as its argument. Doing a lookup internally, instead
Of passing parent, results in a recursive lookup all the way to the root node as to get the inode for
The parent one must do a kernfs_get_inode() on it, which can call the initialization routine, which calls
Kernfs_get_inode(). What the developer should do is forward the inode from the parent so we can
Avoid the recursive lookup and any lookup in general. This is based on where this was getting called from, the parent
inode was readily available. That WARN_ON is not even strict enough, read further down I mention it again. The goal is that
We don't end up skipping LSM initialization by accident, ie kn has parent but they do not pass parent. Alternatively,
We can move the warning (and make it proper) to right before the LSM hook and make sure that parent arg
And kn->parent are either both specified or both unspecified ie XOR. !a != !b. Rather than litter the top level functions
With this warning. Also, I chose warn_on because I didn't want it to be fatal, however, I am not arguing that its proper
And am seeking alternative suggestions.

> 
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
> 
> What can we do about this?
Forward the parent along if it has one

> 
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
> 
> trailing whitespace :(

Ok, strange checked this which checkpatch a few times... not sure where I introduced it....

> 
> > +			 */
> > +			kernfs_evict_inode(inode);
> > +			return NULL;
> 
> I don't know what to do here, it's a mess, this is really too deep it seems to
> properly unwind.

I initially had this as non-fatal. If the inode is released uninitialized by the LSM (SELinux in particular) it defaults to the "fs wide label"
or whatever that LSM (not sure what others do) does. However, there really should be NO error, perhaps we can make this a BUG_ON()
or something fatal. We can do printk and ignore, or just ignore. My take on it is, the lsm shouldn't really miss the boat on initializing the inode,
and if they wanted to, they could make the initialization failure an oops or something. If the LSM isn't working how would the system
reasonably carry on?

> 
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
> 
> Why warn?  What can we do about this?

If it has a parent, you're not getting the root inode, which is what this helper should
Be used for ie mount.c usage. 

Kernfs_get_inode() should be used to retrieve either the root (!kn->parent && !parent) or
Non-root (kn->parent && parent) cases. Perhaps my warn on in the first routine is not strong enough.
We really wanted XOR.

> 
> thanks,
> 
> greg k-h
