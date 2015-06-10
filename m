Date: Wed, 10 Jun 2015 09:01:50 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Roberts, William C" <william.c.roberts@intel.com>
Subject: Re: [PATCH] kernfs: hook inode initialization for LSMs
Message-ID: <20150610160150.GA31100@kroah.com>
References: <1433877101-31866-1-git-send-email-william.c.roberts@intel.com>
 <1433877101-31866-2-git-send-email-william.c.roberts@intel.com>
 <20150609210925.GB16038@kroah.com>
 <476DC76E7D1DF2438D32BFADF679FC560101BD9B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC560101BD9B@ORSMSX103.amr.corp.intel.com>
Cc: "Selinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 10, 2015 at 03:56:05PM +0000, Roberts, William C wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Tuesday, June 9, 2015 2:09 PM
> > To: Roberts, William C
> > Cc: Selinux@tycho.nsa.gov
> > Subject: Re: [PATCH] kernfs: hook inode initialization for LSMs
> > 
> > On Tue, Jun 09, 2015 at 12:11:41PM -0700, william.c.roberts@intel.com
> > wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > This corrects issues in client filesystems, like sysfs, where LSMs
> > > missed the opportunity to initialize inodes. In the case of SELinux
> > > this prevented newly created files from inheriting their parent's
> > > label. This has posed many issues on Android where transient sysfs
> > > files were defaulting to the sysfs wide label, rather than their
> > > parent, which is the normal behavior for other filesystems. Without
> > > this, access controls for these files had to be granted on the file
> > > system wide label, rather than a file specific label. The result of
> > > which over-privilege the caller but also can cause CTS failures.
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  fs/kernfs/dir.c             |  2 +-
> > >  fs/kernfs/inode.c           | 34 ++++++++++++++++++++++++++++++----
> > >  fs/kernfs/kernfs-internal.h | 26 +++++++++++++++++++++++++-
> > >  fs/kernfs/mount.c           |  2 +-
> > >  4 files changed, 57 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c index fffca95..096379e
> > > 100644
> > > --- a/fs/kernfs/dir.c
> > > +++ b/fs/kernfs/dir.c
> > > @@ -809,7 +809,7 @@ static struct dentry *kernfs_iop_lookup(struct
> > inode *dir,
> > >  	dentry->d_fsdata = kn;
> > >
> > >  	/* attach dentry and inode */
> > > -	inode = kernfs_get_inode(dir->i_sb, kn);
> > > +	inode = kernfs_get_inode(dir->i_sb, kn, dentry->d_parent);
> > >  	if (!inode) {
> > >  		ret = ERR_PTR(-ENOMEM);
> > >  		goto out_unlock;
> > > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c index
> > > 2da8493..d37b8ff 100644
> > > --- a/fs/kernfs/inode.c
> > > +++ b/fs/kernfs/inode.c
> > > @@ -281,8 +281,10 @@ int kernfs_iop_getattr(struct vfsmount *mnt,
> > struct dentry *dentry,
> > >  	return 0;
> > >  }
> > >
> > > -static void kernfs_init_inode(struct kernfs_node *kn, struct inode
> > > *inode)
> > > +static int kernfs_init_inode(struct kernfs_node *kn, struct inode *inode,
> > > +			struct dentry *parent)
> > >  {
> > > +	int error = 0;
> > >  	kernfs_get(kn);
> > >  	inode->i_private = kn;
> > >  	inode->i_mapping->a_ops = &kernfs_aops; @@ -291,6 +293,8 @@
> > static
> > > void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
> > >  	set_default_inode_attr(inode, kn->mode);
> > >  	kernfs_refresh_inode(kn, inode);
> > >
> > > +	WARN_ON(kn->parent && !parent);
> > 
> > What can a developer do about this?
> This means that the node has a parent, but you didn't pass it as its argument. Doing a lookup internally, instead
> Of passing parent, results in a recursive lookup all the way to the root node as to get the inode for
> The parent one must do a kernfs_get_inode() on it, which can call the initialization routine, which calls
> Kernfs_get_inode(). What the developer should do is forward the inode from the parent so we can
> Avoid the recursive lookup and any lookup in general. This is based on where this was getting called from, the parent
> inode was readily available. That WARN_ON is not even strict enough, read further down I mention it again. The goal is that
> We don't end up skipping LSM initialization by accident, ie kn has parent but they do not pass parent. Alternatively,
> We can move the warning (and make it proper) to right before the LSM hook and make sure that parent arg
> And kn->parent are either both specified or both unspecified ie XOR. !a != !b. Rather than litter the top level functions
> With this warning. Also, I chose warn_on because I didn't want it to be fatal, however, I am not arguing that its proper
> And am seeking alternative suggestions.

But again, what can a driver do about this?  If this shouldn't happen,
then don't test for it.  This isn't something that a driver developer
should care about, right?  If not, then is it something that the sysfs
core could be doing?  If so, then fix the sysfs core.

greg k-h
