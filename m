Message-ID: <1495131376.5475.23.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: do not check open permission on sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 18 May 2017 14:16:16 -0400
In-Reply-To: <1495125922.5475.20.camel@tycho.nsa.gov>
References: <20170512164124.16981-1-sds@tycho.nsa.gov>
 <CAHC9VhQa01JcPQTJ2LzJdCZH7WmmxUgp-d_gk0SHn9OqMHQZAQ@mail.gmail.com>
 <1495125922.5475.20.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-18 at 12:45 -0400, Stephen Smalley wrote:
> On Thu, 2017-05-18 at 12:04 -0400, Paul Moore wrote:
> > On Fri, May 12, 2017 at 12:41 PM, Stephen Smalley <sds@tycho.nsa.go
> > v>
> > wrote:
> > > open permission is currently only defined for files in the kernel
> > > (COMMON_FILE_PERMS rather than COMMON_FILE_SOCK_PERMS).
> > > Construction of
> > > an artificial test case that tries to open a socket via
> > > /proc/pid/fd will
> > > generate a recvfrom avc denial because recvfrom and open happen
> > > to
> > > map to
> > > the same permission bit in socket vs file classes.
> > > 
> > > open of a socket via /proc/pid/fd is not supported by the kernel
> > > regardless
> > > and will ultimately return ENXIO. But we hit the permission check
> > > first and
> > > can thus produce these odd/misleading denials.  Omit the open
> > > check
> > > when
> > > operating on a socket.
> > > 
> > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > ---
> > >  security/selinux/hooks.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index e67a526..dd356ed 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -2063,8 +2063,9 @@ static inline u32 file_to_av(struct file
> > > *file)
> > >  static inline u32 open_file_to_av(struct file *file)
> > >  {
> > >         u32 av = file_to_av(file);
> > > +       struct inode *inode = file_inode(file);
> > > 
> > > -       if (selinux_policycap_openperm)
> > > +       if (selinux_policycap_openperm && inode->i_sb->s_magic !=
> > > SOCKFS_MAGIC)
> > >                 av |= FILE__OPEN;
> > 
> > No real objection to this patch, I'm just wondering if we are
> > better
> > served by only adding the open permission on a specific whitelist
> > of
> > object classes?  From a practical point of view it probably has
> > little
> > impact either way and one check to rule out sockets is arguably
> > faster
> > than checking a handful of object classes, but I wonder how likely
> > it
> > would be that we would ever see someone trying to open other non-
> > file
> > objects and hitting this code?
> 
> We only ever assign either file or socket classes to inode security
> blobs.  There are 7 distinct file classes, so we'd have to compare
> against 7 values (unless we use a range check, which would be two
> comparisons, and if we want 100% accuracy, would require tweaking the
> classmap to ensure they are all contiguous since "fd" is presently
> intermingled).  Also, we initialize isec->sclass to SECCLASS_FILE in
> inode_alloc_security() for all inodes (for some inodes, we never get
> another chance to initialize it);

Sorry, the parenthetical statement above isn't accurate; we always have
to initialize it somewhere else or we'd be left with the unlabeled SID.
 We have seen that in the past with buggy filesystems; it was
convenient to at least have the class initialized to file so that the
permissions would be displayed correctly on denials.  I suppose we
could adjust inode_alloc_security() to initialize the class to
SECCLASS_SOCKET if inode->i_sb->s_magic == SOCKFS_MAGIC so that sockets
would at least start in the generic socket class and later be refined
to a more specific class in selinux_socket_post_create().  That would
be a separate change and would require some testing to ensure it
doesn't cause side effects.  Regardless, I think the case for testing
SOCKFS_MAGIC for open is still valid.

>  sockets are later switched to their
> appropriate class in selinux_socket_post_create().  Testing for
> SOCKFS_MAGIC seems simpler, more efficient, and less prone to error. 
> Up to you, but I'm not sure we gain anything by switching to a class-
> based test.
> 
> > Also, as an aside, it seems rather odd that we don't have a macro
> > somewhere to check if an inode is a socket.  Oh well.
> 
> Smack uses this test as well in various place to see if an inode
> represents a socket.  I suspect the vfs folks would view it as a
> layering violation, but we do need to tell at times...
> 
> > 
> > >         return av;
> > > @@ -3059,6 +3060,7 @@ static int selinux_inode_permission(struct
> > > inode *inode, int mask)
> > >  static int selinux_inode_setattr(struct dentry *dentry, struct
> > > iattr *iattr)
> > >  {
> > >         const struct cred *cred = current_cred();
> > > +       struct inode *inode = d_backing_inode(dentry);
> > >         unsigned int ia_valid = iattr->ia_valid;
> > >         __u32 av = FILE__WRITE;
> > > 
> > > @@ -3074,8 +3076,10 @@ static int selinux_inode_setattr(struct
> > > dentry *dentry, struct iattr *iattr)
> > >                         ATTR_ATIME_SET | ATTR_MTIME_SET |
> > > ATTR_TIMES_SET))
> > >                 return dentry_has_perm(cred, dentry,
> > > FILE__SETATTR);
> > > 
> > > -       if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE)
> > > -                       && !(ia_valid & ATTR_FILE))
> > > +       if (selinux_policycap_openperm &&
> > > +           inode->i_sb->s_magic != SOCKFS_MAGIC &&
> > > +           (ia_valid & ATTR_SIZE) &&
> > > +           !(ia_valid & ATTR_FILE))
> > >                 av |= FILE__OPEN;
> > > 
> > >         return dentry_has_perm(cred, dentry, av);
> > > --
> > > 2.9.3
> > > 
> > 
> > 
