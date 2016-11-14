Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEMMOZG030804
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 17:22:26 -0500
Received: by mail-ua0-f195.google.com with SMTP id 12so7416148uas.3
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 14:22:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478812710-17190-5-git-send-email-agruenba@redhat.com>
References: <1478812710-17190-1-git-send-email-agruenba@redhat.com>
 <1478812710-17190-5-git-send-email-agruenba@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Nov 2016 17:22:24 -0500
Message-ID: <CAHC9VhSrDfGOBrw+hV8xfZ-COOjHpW_73sz7VYLMnem-szWRWA@mail.gmail.com>
Subject: Re: [PATCH 4/4] selinux: Convert isec->lock into a spinlock
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 10, 2016 at 4:18 PM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> Convert isec->lock from a mutex into a spinlock.  Instead of holding the
> lock while sleeping in inode_doinit_with_dentry, set isec->initialized
> to LABEL_PENDING and release the lock.  Then, when the sid has been
> determined, re-acquire the lock.  If isec->initialized is still set to
> LABEL_PENDING, set isec->sid; otherwise, the sid has been set by another
> task (LABEL_INITIALIZED) or invalidated (LABEL_INVALID) in the meantime.
>
> This fixes a deadlock on gfs2 where
>
>  * one task is in inode_doinit_with_dentry -> gfs2_getxattr, holds
>    isec->lock, and tries to acquire the inode's glock, and
>
>  * another task is in do_xmote -> inode_go_inval ->
>    selinux_inode_invalidate_secctx, holds the inode's glock, and tries
>    to acquire isec->lock.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  security/selinux/hooks.c          | 108 ++++++++++++++++++++++++--------------
>  security/selinux/include/objsec.h |   5 +-
>  2 files changed, 72 insertions(+), 41 deletions(-)

We shouldn't need the spinlocks on the socket_post_create() and the
socket_accept() hooks as the callers should still have exclusive
access to the socket/inode at that point.

I didn't check all the callers of the inode_init_security(), but it
looks like the same idea applies.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index cf5067e..4af31f1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -231,7 +231,7 @@ static int inode_alloc_security(struct inode *inode)
>         if (!isec)
>                 return -ENOMEM;
>
> -       mutex_init(&isec->lock);
> +       spin_lock_init(&isec->lock);
>         INIT_LIST_HEAD(&isec->list);
>         isec->inode = inode;
>         isec->sid = SECINITSID_UNLABELED;
> @@ -1381,7 +1381,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  {
>         struct superblock_security_struct *sbsec = NULL;
>         struct inode_security_struct *isec = inode->i_security;
> -       u32 sid;
> +       u32 task_sid, sid = 0;
> +       u16 sclass;
>         struct dentry *dentry;
>  #define INITCONTEXTLEN 255
>         char *context = NULL;
> @@ -1391,7 +1392,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>         if (isec->initialized == LABEL_INITIALIZED)
>                 return 0;
>
> -       mutex_lock(&isec->lock);
> +       spin_lock(&isec->lock);
>         if (isec->initialized == LABEL_INITIALIZED)
>                 goto out_unlock;
>
> @@ -1410,12 +1411,18 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                 goto out_unlock;
>         }
>
> +       sclass = isec->sclass;
> +       task_sid = isec->task_sid;
> +       sid = isec->sid;
> +       isec->initialized = LABEL_PENDING;
> +       spin_unlock(&isec->lock);
> +
>         switch (sbsec->behavior) {
>         case SECURITY_FS_USE_NATIVE:
>                 break;
>         case SECURITY_FS_USE_XATTR:
>                 if (!(inode->i_opflags & IOP_XATTR)) {
> -                       isec->sid = sbsec->def_sid;
> +                       sid = sbsec->def_sid;
>                         break;
>                 }
>                 /* Need a dentry, since the xattr API requires one.
> @@ -1437,7 +1444,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                          * inode_doinit with a dentry, before these inodes could
>                          * be used again by userspace.
>                          */
> -                       goto out_unlock;
> +                       goto out;
>                 }
>
>                 len = INITCONTEXTLEN;
> @@ -1445,7 +1452,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                 if (!context) {
>                         rc = -ENOMEM;
>                         dput(dentry);
> -                       goto out_unlock;
> +                       goto out;
>                 }
>                 context[len] = '\0';
>                 rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> @@ -1456,14 +1463,14 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                         rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
>                         if (rc < 0) {
>                                 dput(dentry);
> -                               goto out_unlock;
> +                               goto out;
>                         }
>                         len = rc;
>                         context = kmalloc(len+1, GFP_NOFS);
>                         if (!context) {
>                                 rc = -ENOMEM;
>                                 dput(dentry);
> -                               goto out_unlock;
> +                               goto out;
>                         }
>                         context[len] = '\0';
>                         rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> @@ -1475,7 +1482,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                                        "%d for dev=%s ino=%ld\n", __func__,
>                                        -rc, inode->i_sb->s_id, inode->i_ino);
>                                 kfree(context);
> -                               goto out_unlock;
> +                               goto out;
>                         }
>                         /* Map ENODATA to the default file SID */
>                         sid = sbsec->def_sid;
> @@ -1505,28 +1512,25 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                         }
>                 }
>                 kfree(context);
> -               isec->sid = sid;
>                 break;
>         case SECURITY_FS_USE_TASK:
> -               isec->sid = isec->task_sid;
> +               sid = task_sid;
>                 break;
>         case SECURITY_FS_USE_TRANS:
>                 /* Default to the fs SID. */
> -               isec->sid = sbsec->sid;
> +               sid = sbsec->sid;
>
>                 /* Try to obtain a transition SID. */
> -               rc = security_transition_sid(isec->task_sid, sbsec->sid,
> -                                            isec->sclass, NULL, &sid);
> +               rc = security_transition_sid(task_sid, sid, sclass, NULL, &sid);
>                 if (rc)
> -                       goto out_unlock;
> -               isec->sid = sid;
> +                       goto out;
>                 break;
>         case SECURITY_FS_USE_MNTPOINT:
> -               isec->sid = sbsec->mntpoint_sid;
> +               sid = sbsec->mntpoint_sid;
>                 break;
>         default:
>                 /* Default to the fs superblock SID. */
> -               isec->sid = sbsec->sid;
> +               sid = sbsec->sid;
>
>                 if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode)) {
>                         /* We must have a dentry to determine the label on
> @@ -1549,21 +1553,29 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                          * could be used again by userspace.
>                          */
>                         if (!dentry)
> -                               goto out_unlock;
> -                       rc = selinux_genfs_get_sid(dentry, isec->sclass,
> -                                                  sbsec->flags, &sid);
> +                               goto out;
> +                       rc = selinux_genfs_get_sid(dentry, sclass, sbsec->flags, &sid);
>                         dput(dentry);
>                         if (rc)
> -                               goto out_unlock;
> -                       isec->sid = sid;
> +                               goto out;
>                 }
>                 break;
>         }
>
> -       isec->initialized = LABEL_INITIALIZED;
> +out:
> +       spin_lock(&isec->lock);
> +       if (isec->initialized == LABEL_PENDING) {
> +               if (!sid || rc) {
> +                       isec->initialized = LABEL_INVALID;
> +                       goto out_unlock;
> +               }
> +
> +               isec->initialized = LABEL_INITIALIZED;
> +               isec->sid = sid;
> +       }
>
>  out_unlock:
> -       mutex_unlock(&isec->lock);
> +       spin_unlock(&isec->lock);
>         return rc;
>  }
>
> @@ -2889,9 +2901,11 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>         /* Possibly defer initialization to selinux_complete_init. */
>         if (sbsec->flags & SE_SBINITIALIZED) {
>                 struct inode_security_struct *isec = inode->i_security;
> +               spin_lock(&isec->lock);
>                 isec->sclass = inode_mode_to_security_class(inode->i_mode);
>                 isec->sid = newsid;
>                 isec->initialized = LABEL_INITIALIZED;
> +               spin_unlock(&isec->lock);
>         }
>
>         if (!ss_initialized || !(sbsec->flags & SBLABEL_MNT))
> @@ -3194,9 +3208,11 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>         }
>
>         isec = backing_inode_security(dentry);
> +       spin_lock(&isec->lock);
>         isec->sclass = inode_mode_to_security_class(inode->i_mode);
>         isec->sid = newsid;
>         isec->initialized = LABEL_INITIALIZED;
> +       spin_unlock(&isec->lock);
>
>         return;
>  }
> @@ -3289,9 +3305,11 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>         if (rc)
>                 return rc;
>
> +       spin_lock(&isec->lock);
>         isec->sclass = inode_mode_to_security_class(inode->i_mode);
>         isec->sid = newsid;
>         isec->initialized = LABEL_INITIALIZED;
> +       spin_unlock(&isec->lock);
>         return 0;
>  }
>
> @@ -3952,9 +3970,11 @@ static void selinux_task_to_inode(struct task_struct *p,
>         struct inode_security_struct *isec = inode->i_security;
>         u32 sid = task_sid(p);
>
> +       spin_lock(&isec->lock);
>         isec->sclass = inode_mode_to_security_class(inode->i_mode);
>         isec->sid = sid;
>         isec->initialized = LABEL_INITIALIZED;
> +       spin_unlock(&isec->lock);
>  }
>
>  /* Returns error only if unable to parse addresses */
> @@ -4273,24 +4293,26 @@ static int selinux_socket_post_create(struct socket *sock, int family,
>         const struct task_security_struct *tsec = current_security();
>         struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
>         struct sk_security_struct *sksec;
> +       u16 sclass = socket_type_to_security_class(family, type, protocol);
> +       u32 sid = SECINITSID_KERNEL;
>         int err = 0;
>
> -       isec->sclass = socket_type_to_security_class(family, type, protocol);
> -
> -       if (kern)
> -               isec->sid = SECINITSID_KERNEL;
> -       else {
> -               err = socket_sockcreate_sid(tsec, isec->sclass, &(isec->sid));
> +       if (!kern) {
> +               err = socket_sockcreate_sid(tsec, sclass, &sid);
>                 if (err)
>                         return err;
>         }
>
> +       spin_lock(&isec->lock);
> +       isec->sclass = sclass;
> +       isec->sid = sid;
>         isec->initialized = LABEL_INITIALIZED;
> +       spin_unlock(&isec->lock);
>
>         if (sock->sk) {
>                 sksec = sock->sk->sk_security;
> -               sksec->sid = isec->sid;
> -               sksec->sclass = isec->sclass;
> +               sksec->sclass = sclass;
> +               sksec->sid = sid;
>                 err = selinux_netlbl_socket_post_create(sock->sk, family);
>         }
>
> @@ -4466,17 +4488,25 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
>         int err;
>         struct inode_security_struct *isec;
>         struct inode_security_struct *newisec;
> +       u16 sclass;
> +       u32 sid;
>
>         err = sock_has_perm(current, sock->sk, SOCKET__ACCEPT);
>         if (err)
>                 return err;
>
> -       newisec = inode_security_novalidate(SOCK_INODE(newsock));
> -
>         isec = inode_security_novalidate(SOCK_INODE(sock));
> -       newisec->sclass = isec->sclass;
> -       newisec->sid = isec->sid;
> +       spin_lock(&isec->lock);
> +       sclass = isec->sclass;
> +       sid = isec->sid;
> +       spin_unlock(&isec->lock);
> +
> +       newisec = inode_security_novalidate(SOCK_INODE(newsock));
> +       spin_lock(&newisec->lock);
> +       newisec->sclass = sclass;
> +       newisec->sid = sid;
>         newisec->initialized = LABEL_INITIALIZED;
> +       spin_unlock(&newisec->lock);
>
>         return 0;
>  }
> @@ -5978,9 +6008,9 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>  {
>         struct inode_security_struct *isec = inode->i_security;
>
> -       mutex_lock(&isec->lock);
> +       spin_lock(&isec->lock);
>         isec->initialized = LABEL_INVALID;
> -       mutex_unlock(&isec->lock);
> +       spin_unlock(&isec->lock);
>  }
>
>  /*
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index c21e135..7e770e9 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -39,7 +39,8 @@ struct task_security_struct {
>
>  enum label_initialized {
>         LABEL_INVALID,          /* invalid or not initialized */
> -       LABEL_INITIALIZED       /* initialized */
> +       LABEL_INITIALIZED,      /* initialized */
> +       LABEL_PENDING
>  };
>
>  struct inode_security_struct {
> @@ -52,7 +53,7 @@ struct inode_security_struct {
>         u32 sid;                /* SID of this object */
>         u16 sclass;             /* security class of this object */
>         unsigned char initialized;      /* initialization flag */
> -       struct mutex lock;
> +       struct spinlock lock;
>  };
>
>  struct file_security_struct {
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
