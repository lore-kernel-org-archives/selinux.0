Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2CJLMfu024977
	for <selinux@tycho.nsa.gov>; Wed, 12 Mar 2008 15:21:22 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2CJLL8s018106
	for <selinux@tycho.nsa.gov>; Wed, 12 Mar 2008 19:21:21 GMT
Received: by ug-out-1314.google.com with SMTP id 30so305485ugs.15
        for <selinux@tycho.nsa.gov>; Wed, 12 Mar 2008 12:20:54 -0700 (PDT)
Message-ID: <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
Date: Wed, 12 Mar 2008 15:20:53 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Eric Paris" <eparis@redhat.com>
Subject: Re: How to handle security_dentry_open when the open flags are 'special'
Cc: selinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
        sds@tycho.nsa.gov, jmorris@namei.org, casey@schaufler-ca.com
In-Reply-To: <1205349239.2925.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1205349239.2925.11.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Which I think then blows up if we pass this file to another process or
if we exec something.  Uggh....

-Eric


On 3/12/08, Eric Paris <eparis@redhat.com> wrote:
> See LKML posting http://marc.info/?l=linux-kernel&m=120534660832189&w=2
>
>  according to viro a call to sys_open like: open("/dev/null", 3) is
>  supposed to mean: check read and write but not set FMODE_READ or
>  FMODE_WRITE.  This is exactly the security check we get through the
>  security_inode_permission hook but not what happens through the
>  security_dentry_open hook.  This patch actually passes the bare flags
>  into security_dentry_open so that we can do the correct permission
>  checking there.
>
>  What do people think?
>
>  Untested, uncompiled, just thoughts and fleshing it out....
>
>  -Eric
>
>   fs/open.c                |    2 +-
>   include/linux/security.h |    6 +++---
>   security/security.c      |    4 ++--
>   security/selinux/hooks.c |   20 ++++++++++++++++++--
>   4 files changed, 24 insertions(+), 8 deletions(-)
>
>  diff --git a/fs/open.c b/fs/open.c
>  index 5419853..2560a3e 100644
>  --- a/fs/open.c
>  +++ b/fs/open.c
>  @@ -754,7 +754,7 @@ static struct file *__dentry_open(struct dentry *dentry, struct vfsmount *mnt,
>         f->f_op = fops_get(inode->i_fop);
>         file_move(f, &inode->i_sb->s_files);
>
>  -       error = security_dentry_open(f);
>  +       error = security_dentry_open(f, flags);
>         if (error)
>                 goto cleanup_all;
>
>  diff --git a/include/linux/security.h b/include/linux/security.h
>  index b07357c..704a5f7 100644
>  --- a/include/linux/security.h
>  +++ b/include/linux/security.h
>  @@ -1338,7 +1338,7 @@ struct security_operations {
>         int (*file_send_sigiotask) (struct task_struct * tsk,
>                                     struct fown_struct * fown, int sig);
>         int (*file_receive) (struct file * file);
>  -       int (*dentry_open)  (struct file *file);
>  +       int (*dentry_open)  (struct file *file, int flags);
>
>         int (*task_create) (unsigned long clone_flags);
>         int (*task_alloc_security) (struct task_struct * p);
>  @@ -1594,7 +1594,7 @@ int security_file_set_fowner(struct file *file);
>   int security_file_send_sigiotask(struct task_struct *tsk,
>                                   struct fown_struct *fown, int sig);
>   int security_file_receive(struct file *file);
>  -int security_dentry_open(struct file *file);
>  +int security_dentry_open(struct file *file, int flags);
>   int security_task_create(unsigned long clone_flags);
>   int security_task_alloc(struct task_struct *p);
>   void security_task_free(struct task_struct *p);
>  @@ -2086,7 +2086,7 @@ static inline int security_file_receive (struct file *file)
>         return 0;
>   }
>
>  -static inline int security_dentry_open (struct file *file)
>  +static inline int security_dentry_open (struct file *file, int flags)
>   {
>         return 0;
>   }
>  diff --git a/security/security.c b/security/security.c
>  index b1387a6..28a4f2a 100644
>  --- a/security/security.c
>  +++ b/security/security.c
>  @@ -582,9 +582,9 @@ int security_file_receive(struct file *file)
>         return security_ops->file_receive(file);
>   }
>
>  -int security_dentry_open(struct file *file)
>  +int security_dentry_open(struct file *file, int flags)
>   {
>  -       return security_ops->dentry_open(file);
>  +       return security_ops->dentry_open(file, flags);
>   }
>
>   int security_task_create(unsigned long clone_flags)
>  diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>  index 4bf4807..1966590 100644
>  --- a/security/selinux/hooks.c
>  +++ b/security/selinux/hooks.c
>  @@ -3017,11 +3017,14 @@ static int selinux_file_receive(struct file *file)
>         return file_has_perm(current, file, file_to_av(file));
>   }
>
>  -static int selinux_dentry_open(struct file *file)
>  +static int selinux_dentry_open(struct file *file, int flags)
>   {
>         struct file_security_struct *fsec;
>         struct inode *inode;
>         struct inode_security_struct *isec;
>  +       u32 av = 0;
>  +       mode_t f_mode;
>  +
>         inode = file->f_path.dentry->d_inode;
>         fsec = file->f_security;
>         isec = inode->i_security;
>  @@ -3034,6 +3037,19 @@ static int selinux_dentry_open(struct file *file)
>          */
>         fsec->isid = isec->sid;
>         fsec->pseqno = avc_policy_seqno();
>  +
>  +       f_mode = flags & O_ACCMODE;
>  +       if ((f_mode+1) & O_ACCMODE)
>  +               f_mode++;
>  +
>  +       if (f_mode & FMODE_READ)
>  +               av |= FILE__READ;
>  +       if (f_mode & FMODE_WRITE) {
>  +               if (file->f_flags & O_APPEND)
>  +                       av |= FILE__APPEND;
>  +               else
>  +                       av |= FILE__WRITE;
>  +       }
>         /*
>          * Since the inode label or policy seqno may have changed
>          * between the selinux_inode_permission check and the saving
>  @@ -3042,7 +3058,7 @@ static int selinux_dentry_open(struct file *file)
>          * new inode label or new policy.
>          * This check is not redundant - do not remove.
>          */
>  -       return inode_has_perm(current, inode, file_to_av(file), NULL);
>  +       return inode_has_perm(current, inode, av, NULL);
>   }
>
>   /* task security operations */
>
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
