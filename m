Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2DBv1v7021546
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 07:57:01 -0400
Received: from po-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2DBuvew010235
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 11:56:58 GMT
Received: by po-out-1718.google.com with SMTP id b23so3276908poe.4
        for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 04:56:56 -0700 (PDT)
Message-ID: <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
Date: Thu, 13 Mar 2008 07:56:54 -0400
From: "Stephen Smalley" <stephen.smalley@gmail.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: How to handle security_dentry_open when the open flags are 'special'
Cc: "Eric Paris" <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, sds@tycho.nsa.gov,
        jmorris@namei.org, casey@schaufler-ca.com
In-Reply-To: <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1205349239.2925.11.camel@localhost.localdomain>
	 <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric,

IIUC, in this situation, we are setting up a file that cannot be used
for read or write operations due to its lack of FMODE_READ or
FMODE_WRITE.  Thus, we don't actually need to check anything in
selinux_dentry_open - that check is only to avoid losing checking on
read/write revalidation altogether in the case where the policy seqno
or file label has changed since the inode_permission check.  If we can
never use this file for read/write, it isn't needed.

For the revalidation of open files on exec or transfer, if it cannot
be used for read or write, then we likewise can't (and don't need to)
revalidate it.  If/when it gets used in a ioctl call, we'll check it
via selinux_file_ioctl.

Thus, IMHO, we need to change callers of file_to_av() to check for a 0
return and skip checking in that case - it is apparently a legal case
that we didn't realize originally.

Stephen "not in the office today" Smalley


On 3/12/08, Eric Paris <eparis@parisplace.org> wrote:
> Which I think then blows up if we pass this file to another process or
> if we exec something.  Uggh....
>
> -Eric
>
>
> On 3/12/08, Eric Paris <eparis@redhat.com> wrote:
> > See LKML posting http://marc.info/?l=linux-kernel&m=120534660832189&w=2
> >
> >  according to viro a call to sys_open like: open("/dev/null", 3) is
> >  supposed to mean: check read and write but not set FMODE_READ or
> >  FMODE_WRITE.  This is exactly the security check we get through the
> >  security_inode_permission hook but not what happens through the
> >  security_dentry_open hook.  This patch actually passes the bare flags
> >  into security_dentry_open so that we can do the correct permission
> >  checking there.
> >
> >  What do people think?
> >
> >  Untested, uncompiled, just thoughts and fleshing it out....
> >
> >  -Eric
> >
> >   fs/open.c                |    2 +-
> >   include/linux/security.h |    6 +++---
> >   security/security.c      |    4 ++--
> >   security/selinux/hooks.c |   20 ++++++++++++++++++--
> >   4 files changed, 24 insertions(+), 8 deletions(-)
> >
> >  diff --git a/fs/open.c b/fs/open.c
> >  index 5419853..2560a3e 100644
> >  --- a/fs/open.c
> >  +++ b/fs/open.c
> >  @@ -754,7 +754,7 @@ static struct file *__dentry_open(struct dentry
> *dentry, struct vfsmount *mnt,
> >         f->f_op = fops_get(inode->i_fop);
> >         file_move(f, &inode->i_sb->s_files);
> >
> >  -       error = security_dentry_open(f);
> >  +       error = security_dentry_open(f, flags);
> >         if (error)
> >                 goto cleanup_all;
> >
> >  diff --git a/include/linux/security.h b/include/linux/security.h
> >  index b07357c..704a5f7 100644
> >  --- a/include/linux/security.h
> >  +++ b/include/linux/security.h
> >  @@ -1338,7 +1338,7 @@ struct security_operations {
> >         int (*file_send_sigiotask) (struct task_struct * tsk,
> >                                     struct fown_struct * fown, int sig);
> >         int (*file_receive) (struct file * file);
> >  -       int (*dentry_open)  (struct file *file);
> >  +       int (*dentry_open)  (struct file *file, int flags);
> >
> >         int (*task_create) (unsigned long clone_flags);
> >         int (*task_alloc_security) (struct task_struct * p);
> >  @@ -1594,7 +1594,7 @@ int security_file_set_fowner(struct file *file);
> >   int security_file_send_sigiotask(struct task_struct *tsk,
> >                                   struct fown_struct *fown, int sig);
> >   int security_file_receive(struct file *file);
> >  -int security_dentry_open(struct file *file);
> >  +int security_dentry_open(struct file *file, int flags);
> >   int security_task_create(unsigned long clone_flags);
> >   int security_task_alloc(struct task_struct *p);
> >   void security_task_free(struct task_struct *p);
> >  @@ -2086,7 +2086,7 @@ static inline int security_file_receive (struct
> file *file)
> >         return 0;
> >   }
> >
> >  -static inline int security_dentry_open (struct file *file)
> >  +static inline int security_dentry_open (struct file *file, int flags)
> >   {
> >         return 0;
> >   }
> >  diff --git a/security/security.c b/security/security.c
> >  index b1387a6..28a4f2a 100644
> >  --- a/security/security.c
> >  +++ b/security/security.c
> >  @@ -582,9 +582,9 @@ int security_file_receive(struct file *file)
> >         return security_ops->file_receive(file);
> >   }
> >
> >  -int security_dentry_open(struct file *file)
> >  +int security_dentry_open(struct file *file, int flags)
> >   {
> >  -       return security_ops->dentry_open(file);
> >  +       return security_ops->dentry_open(file, flags);
> >   }
> >
> >   int security_task_create(unsigned long clone_flags)
> >  diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >  index 4bf4807..1966590 100644
> >  --- a/security/selinux/hooks.c
> >  +++ b/security/selinux/hooks.c
> >  @@ -3017,11 +3017,14 @@ static int selinux_file_receive(struct file
> *file)
> >         return file_has_perm(current, file, file_to_av(file));
> >   }
> >
> >  -static int selinux_dentry_open(struct file *file)
> >  +static int selinux_dentry_open(struct file *file, int flags)
> >   {
> >         struct file_security_struct *fsec;
> >         struct inode *inode;
> >         struct inode_security_struct *isec;
> >  +       u32 av = 0;
> >  +       mode_t f_mode;
> >  +
> >         inode = file->f_path.dentry->d_inode;
> >         fsec = file->f_security;
> >         isec = inode->i_security;
> >  @@ -3034,6 +3037,19 @@ static int selinux_dentry_open(struct file *file)
> >          */
> >         fsec->isid = isec->sid;
> >         fsec->pseqno = avc_policy_seqno();
> >  +
> >  +       f_mode = flags & O_ACCMODE;
> >  +       if ((f_mode+1) & O_ACCMODE)
> >  +               f_mode++;
> >  +
> >  +       if (f_mode & FMODE_READ)
> >  +               av |= FILE__READ;
> >  +       if (f_mode & FMODE_WRITE) {
> >  +               if (file->f_flags & O_APPEND)
> >  +                       av |= FILE__APPEND;
> >  +               else
> >  +                       av |= FILE__WRITE;
> >  +       }
> >         /*
> >          * Since the inode label or policy seqno may have changed
> >          * between the selinux_inode_permission check and the saving
> >  @@ -3042,7 +3058,7 @@ static int selinux_dentry_open(struct file *file)
> >          * new inode label or new policy.
> >          * This check is not redundant - do not remove.
> >          */
> >  -       return inode_has_perm(current, inode, file_to_av(file), NULL);
> >  +       return inode_has_perm(current, inode, av, NULL);
> >   }
> >
> >   /* task security operations */
> >
> >
> >
> >  --
> >  To unsubscribe from this list: send the line "unsubscribe
> linux-security-module" in
> >  the body of a message to majordomo@vger.kernel.org
> >  More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
