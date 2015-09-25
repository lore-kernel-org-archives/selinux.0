Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PCsSt8021783
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 08:54:28 -0400
Received: by iofb144 with SMTP id b144so109678958iof.1
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 05:54:26 -0700 (PDT)
Date: Fri, 25 Sep 2015 07:54:14 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 1/7] fs: Add user namesapace member to struct
 super_block
Message-ID: <20150925125414.GC104990@ubuntu-hedt>
References: <1443039368-55445-1-git-send-email-seth.forshee@canonical.com>
 <1443039368-55445-2-git-send-email-seth.forshee@canonical.com>
 <87vbazplja.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vbazplja.fsf@x220.int.ebiederm.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 24, 2015 at 04:14:33PM -0500, Eric W. Biederman wrote:
> Seth Forshee <seth.forshee@canonical.com> writes:
> 
> > Initially this will be used to eliminate the implicit MNT_NODEV
> > flag for mounts from user namespaces. In the future it will also
> > be used for translating ids and checking capabilities for
> > filesystems mounted from user namespaces.
> >
> > s_user_ns is initialized in alloc_super() and is generally set to
> > current_user_ns(). To avoid security and corruption issues, two
> > additional mount checks are also added:
> >
> >  - do_new_mount() gains a check that the user has CAP_SYS_ADMIN
> >    in current_user_ns().
> >
> >  - sget() will fail with EBUSY when the filesystem it's looking
> >    for is already mounted from another user namespace.
> >
> > proc requires some special handling. The user namespace of
> > current isn't appropriate when forking as a result of clone (2)
> > with CLONE_NEWPID|CLONE_NEWUSER, as it will set s_user_ns to the
> > namespace of the parent and make proc unmountable in the new user
> > namespace. Instead, the user namespace which owns the new pid
> > namespace is used. sget_userns() is allowed to allow passing in
> > a namespace other than that of current, and sget becomes a
> > wrapper around sget_userns() which passes current_user_ns().
> 
> Minor nits below.  I have fixed them up.
> 
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > ---
> >  fs/namespace.c     |  3 +++
> >  fs/proc/root.c     |  3 ++-
> >  fs/super.c         | 38 +++++++++++++++++++++++++++++++++-----
> >  include/linux/fs.h |  9 ++++++++-
> >  4 files changed, 46 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 0570729c87fd..d023a353dc63 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2381,6 +2381,9 @@ static int do_new_mount(struct path *path, const char *fstype, int flags,
> >  	struct vfsmount *mnt;
> >  	int err;
> >  
> > +	if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> >  	if (!fstype)
> >  		return -EINVAL;
> >  
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index 361ab4ee42fc..4b302cbf13f9 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -117,7 +117,8 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
> >  			return ERR_PTR(-EPERM);
> >  	}
> >  
> > -	sb = sget(fs_type, proc_test_super, proc_set_super, flags, ns);
> > +	sb = sget_userns(fs_type, proc_test_super, proc_set_super, flags,
> > +			 ns->user_ns, ns);
> >  	if (IS_ERR(sb))
> >  		return ERR_CAST(sb);
> >  
> > diff --git a/fs/super.c b/fs/super.c
> > index 954aeb80e202..42837da7d641 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/cleancache.h>
> >  #include <linux/fsnotify.h>
> >  #include <linux/lockdep.h>
> > +#include <linux/user_namespace.h>
> >  #include "internal.h"
> >  
> >  
> > @@ -163,6 +164,7 @@ static void destroy_super(struct super_block *s)
> >  {
> >  	list_lru_destroy(&s->s_dentry_lru);
> >  	list_lru_destroy(&s->s_inode_lru);
> > +	put_user_ns(s->s_user_ns);
> >  	security_sb_free(s);
> >  	WARN_ON(!list_empty(&s->s_mounts));
> >  	kfree(s->s_subtype);
> > @@ -178,7 +180,8 @@ static void destroy_super(struct super_block *s)
> >   *	Allocates and initializes a new &struct super_block.  alloc_super()
> >   *	returns a pointer new superblock or %NULL if allocation had failed.
> >   */
> > -static struct super_block *alloc_super(struct file_system_type *type, int flags)
> > +static struct super_block *alloc_super(struct file_system_type *type, int flags,
> > +				       struct user_namespace *user_ns)
> >  {
> >  	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
> >  	static const struct super_operations default_op;
> > @@ -246,6 +249,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags)
> >  	s->s_shrink.count_objects = super_cache_count;
> >  	s->s_shrink.batch = 1024;
> >  	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
> > +
> > +	s->s_user_ns = get_user_ns(user_ns);
> >  	return s;
> >  
> >  fail:
> > @@ -442,17 +447,17 @@ void generic_shutdown_super(struct super_block *sb)
> >  EXPORT_SYMBOL(generic_shutdown_super);
> >  
> >  /**
> > - *	sget	-	find or create a superblock
> > + *	sget_userns -	find or create a superblock
> >   *	@type:	filesystem type superblock should belong to
> >   *	@test:	comparison callback
> >   *	@set:	setup callback
> >   *	@flags:	mount flags
> 
> You don't mention the user namespace parameter here.  I have fixed that
> as.
> 
>   + *     @user_ns: User namespace you need CAP_SYS_ADMIN over to mount this fs.

Looks good, thanks. Seems I also missed it in alloc_super though.

Seth
