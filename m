Message-id: <1438335805.2081.11.camel@samsung.com>
Subject: Re: [PATCH v3 04/11] lsm: inode_pre_setxattr hook
From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Date: Fri, 31 Jul 2015 11:43:25 +0200
In-reply-to: <20150730215648.GD13589@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-5-git-send-email-l.pawelczyk@samsung.com>
 <20150730215648.GD13589@mail.hallyn.com>
Content-type: text/plain; charset=UTF-8
MIME-version: 1.0
Cc: linux-doc@vger.kernel.org, NeilBrown <neilb@suse.de>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 Jonathan Corbet <corbet@lwn.net>, havner@gmail.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jiri Slaby <jslaby@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Fabian Frederick <fabf@skynet.be>, Al Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 John Johansen <john.johansen@canonical.com>,
 Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Zefan Li <lizefan@huawei.com>, Joe Perches <joe@perches.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On czw, 2015-07-30 at 16:56 -0500, Serge E. Hallyn wrote:
> On Fri, Jul 24, 2015 at 12:04:38PM +0200, Lukasz Pawelczyk wrote:
> > Add a new LSM hook called before inode's setxattr. It is required 
> > for
> > LSM to be able to reliably replace the xattr's value to be set to
> > filesystem in __vfs_setxattr_noperm(). Useful for mapped values, 
> > like in
> > the upcoming Smack namespace patches.
> > 
> > Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
> 
> Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
> 
> Could get confusing if userspace passes in 1 char and gets ENOSPC 
> because
> the unmapped label is too long :)

I would consider such a case a bug in LSM module. If there exists a
mapping "very_very_long_label" -> "l" the module needs to know that the
very long label is possible to get written. After all it would be
written on the host directly.

Smack has a limit for max label name and importing longer label (which
also means creating a mapping with a longer label) will get refused.

At least that's my understanding, but thanks, that's an interesting
remark :-)

> 
> > ---
> >  fs/xattr.c                | 10 ++++++++++
> >  include/linux/lsm_hooks.h |  9 +++++++++
> >  include/linux/security.h  | 10 ++++++++++
> >  security/security.c       | 12 ++++++++++++
> >  4 files changed, 41 insertions(+)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 072fee1..cbc8d19 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -100,12 +100,22 @@ int __vfs_setxattr_noperm(struct dentry 
> > *dentry, const char *name,
> >  	if (issec)
> >  		inode->i_flags &= ~S_NOSEC;
> >  	if (inode->i_op->setxattr) {
> > +		bool alloc = false;
> > +
> > +		error = security_inode_pre_setxattr(dentry, name, 
> > &value,
> > +						    &size, flags, 
> > &alloc);
> > +		if (error)
> > +			return error;
> > +
> >  		error = inode->i_op->setxattr(dentry, name, value, 
> > size, flags);
> >  		if (!error) {
> >  			fsnotify_xattr(dentry);
> >  			security_inode_post_setxattr(dentry, name, 
> > value,
> >  						     size, flags);
> >  		}
> > +
> > +		if (alloc)
> > +			kfree(value);
> >  	} else if (issec) {
> >  		const char *suffix = name + 
> > XATTR_SECURITY_PREFIX_LEN;
> >  		error = security_inode_setsecurity(inode, suffix, 
> > value,
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 1751864..0aeed91 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -349,6 +349,11 @@
> >   *	Check permission before setting the extended attributes
> >   *	@value identified by @name for @dentry.
> >   *	Return 0 if permission is granted.
> > + * @inode_pre_setxattr:
> > + *	Be able to do some operation before setting the @value 
> > identified
> > + *	by @name on the filesystem. Replacing the @value and its 
> > @size is
> > + *	possible. Useful for mapped values. Set @alloc to true 
> > if @value
> > + *	needs to be kfreed afterwards.
> >   * @inode_post_setxattr:
> >   *	Update inode security field after successful setxattr 
> > operation.
> >   *	@value identified by @name for @dentry.
> > @@ -1448,6 +1453,9 @@ union security_list_options {
> >  	int (*inode_getattr)(const struct path *path);
> >  	int (*inode_setxattr)(struct dentry *dentry, const char 
> > *name,
> >  				const void *value, size_t size, 
> > int flags);
> > +	int (*inode_pre_setxattr)(struct dentry *dentry, const 
> > char *name,
> > +				  const void **value, size_t 
> > *size,
> > +				  int flags, bool *alloc);
> >  	void (*inode_post_setxattr)(struct dentry *dentry, const 
> > char *name,
> >  					const void *value, size_t 
> > size,
> >  					int flags);
> > @@ -1730,6 +1738,7 @@ struct security_hook_heads {
> >  	struct list_head inode_setattr;
> >  	struct list_head inode_getattr;
> >  	struct list_head inode_setxattr;
> > +	struct list_head inode_pre_setxattr;
> >  	struct list_head inode_post_setxattr;
> >  	struct list_head inode_getxattr;
> >  	struct list_head inode_listxattr;
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index f0d2914..24f91e0 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -263,6 +263,9 @@ int security_inode_setattr(struct dentry 
> > *dentry, struct iattr *attr);
> >  int security_inode_getattr(const struct path *path);
> >  int security_inode_setxattr(struct dentry *dentry, const char 
> > *name,
> >  			    const void *value, size_t size, int 
> > flags);
> > +int security_inode_pre_setxattr(struct dentry *dentry, const char 
> > *name,
> > +				const void **value, size_t *size, 
> > int flags,
> > +				bool *alloc);
> >  void security_inode_post_setxattr(struct dentry *dentry, const 
> > char *name,
> >  				  const void *value, size_t size, 
> > int flags);
> >  int security_inode_getxattr(struct dentry *dentry, const char 
> > *name);
> > @@ -691,6 +694,13 @@ static inline int 
> > security_inode_setxattr(struct dentry *dentry,
> >  	return cap_inode_setxattr(dentry, name, value, size, 
> > flags);
> >  }
> >  
> > +static inline int security_inode_pre_setxattr(struct dentry 
> > *dentry,
> > +				const char *name, const void 
> > **value,
> > +				size_t *size, int flags, bool 
> > *alloc)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline void security_inode_post_setxattr(struct dentry 
> > *dentry,
> >  		const char *name, const void *value, size_t size, 
> > int flags)
> >  { }
> > diff --git a/security/security.c b/security/security.c
> > index 88a3b78..e1d2c6f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -649,6 +649,16 @@ int security_inode_setxattr(struct dentry 
> > *dentry, const char *name,
> >  	return evm_inode_setxattr(dentry, name, value, size);
> >  }
> >  
> > +int security_inode_pre_setxattr(struct dentry *dentry, const char 
> > *name,
> > +				const void **value, size_t *size, 
> > int flags,
> > +				bool *alloc)
> > +{
> > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > +		return 0;
> > +	return call_int_hook(inode_pre_setxattr, 0, dentry, name, 
> > value, size,
> > +			     flags, alloc);
> > +}
> > +
> >  void security_inode_post_setxattr(struct dentry *dentry, const 
> > char *name,
> >  				  const void *value, size_t size, 
> > int flags)
> >  {
> > @@ -1666,6 +1676,8 @@ struct security_hook_heads 
> > security_hook_heads = {
> >  		LIST_HEAD_INIT(security_hook_heads.inode_getattr),
> >  	.inode_setxattr =
> >  		LIST_HEAD_INIT(security_hook_heads.inode_setxattr)
> > ,
> > +	.inode_pre_setxattr =
> > +		LIST_HEAD_INIT(security_hook_heads.inode_pre_setxa
> > ttr),
> >  	.inode_post_setxattr =
> >  		LIST_HEAD_INIT(security_hook_heads.inode_post_setx
> > attr),
> >  	.inode_getxattr =
-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics
