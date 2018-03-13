Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2DJHKL7028709
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 15:17:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 4014Np6RRKz22T2f
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 19:17:14 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 4014Np5ChRz22T2k
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 19:17:14 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id p74-v6so1114743lfd.3
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 12:17:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180305164756.7878-1-sds@tycho.nsa.gov>
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Mar 2018 15:17:11 -0400
Message-ID: <CAHC9VhRmA8YcyH+YzKQUaOR4Go_c09WCQMOXHmvar2UQQv_eeA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, peter.enderborg@sony.com,
 James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/2] selinux: wrap selinuxfs state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 5, 2018 at 11:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Move global selinuxfs state to a per-instance structure (selinux_fs_info),
> and include a pointer to the selinux_state in this structure.
> Pass this selinux_state to all security server operations, thereby
> ensuring that each selinuxfs instance presents a view of and acts
> as an interface to a particular selinux_state instance.
>
> This change should have no effect on SELinux behavior or APIs
> (userspace or LSM).  It merely wraps the selinuxfs global state,
> links it to a particular selinux_state (currently always the single
> global selinux_state) and uses that state for all operations.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/selinuxfs.c   | 472 +++++++++++++++++++++++++----------------
>  security/selinux/ss/services.c |  13 ++
>  2 files changed, 307 insertions(+), 178 deletions(-)

...

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 0dbd5fd6a396..1a32e93ba7b9 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -94,11 +122,13 @@ static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
>  static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
>                                 size_t count, loff_t *ppos)
>  {
> +       struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
> +       struct selinux_state *state = fsi->state;
>         char tmpbuf[TMPBUFLEN];
>         ssize_t length;
>
>         length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
> -                          enforcing_enabled(&selinux_state));
> +                          enforcing_enabled(state));

Since we only use state once, it seems like we could just use
fsi->state without problem.

> @@ -186,7 +218,9 @@ static const struct file_operations sel_handle_unknown_ops = {
>
>  static int sel_open_handle_status(struct inode *inode, struct file *filp)
>  {
> -       struct page    *status = selinux_kernel_status_page(&selinux_state);
> +       struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
> +       struct selinux_state *state = fsi->state;
> +       struct page    *status = selinux_kernel_status_page(state);

Once again, why do we need state instead of fsi->state?

>         if (!status)
>                 return -ENOMEM;
> @@ -242,6 +276,8 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>                                  size_t count, loff_t *ppos)
>
>  {
> +       struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
> +       struct selinux_state *state = fsi->state;
>         char *page;
>         ssize_t length;
>         int new_value;
> @@ -262,7 +298,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>                 goto out;
>
>         if (new_value) {
> -               length = selinux_disable(&selinux_state);
> +               length = selinux_disable(state);

Same as above.

I think if we end up having to reference it more than once, go ahead
and add another variable to the stack, otherwise just stick with
fsi->state.  Go ahead and apply this logic to the rest of this patch.

> @@ -1808,8 +1872,11 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
>         return dentry;
>  }
>
> +#define NULL_FILE_NAME "null"
> +
>  static int sel_fill_super(struct super_block *sb, void *data, int silent)
>  {
> +       struct selinux_fs_info *fsi;
>         int ret;
>         struct dentry *dentry;
>         struct inode *inode;
> @@ -1837,14 +1904,20 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>                                         S_IWUGO},
>                 /* last one */ {""}
>         };
> +
> +       ret = selinux_fs_info_create(sb);
> +       if (ret)
> +               goto err;
> +
>         ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
>         if (ret)
>                 goto err;
>
> -       bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &sel_last_ino);
> -       if (IS_ERR(bool_dir)) {
> -               ret = PTR_ERR(bool_dir);
> -               bool_dir = NULL;
> +       fsi = sb->s_fs_info;
> +       fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
> +       if (IS_ERR(fsi->bool_dir)) {
> +               ret = PTR_ERR(fsi->bool_dir);
> +               fsi->bool_dir = NULL;
>                 goto err;
>         }
>
> @@ -1858,7 +1931,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>         if (!inode)
>                 goto err;
>
> -       inode->i_ino = ++sel_last_ino;
> +       inode->i_ino = ++fsi->last_ino;
>         isec = (struct inode_security_struct *)inode->i_security;
>         isec->sid = SECINITSID_DEVNULL;
>         isec->sclass = SECCLASS_CHR_FILE;
> @@ -1866,9 +1939,8 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>
>         init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
>         d_add(dentry, inode);
> -       selinux_null.dentry = dentry;
>
> -       dentry = sel_make_dir(sb->s_root, "avc", &sel_last_ino);
> +       dentry = sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
>         if (IS_ERR(dentry)) {
>                 ret = PTR_ERR(dentry);
>                 goto err;
> @@ -1878,7 +1950,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>         if (ret)
>                 goto err;
>
> -       dentry = sel_make_dir(sb->s_root, "initial_contexts", &sel_last_ino);
> +       dentry = sel_make_dir(sb->s_root, "initial_contexts", &fsi->last_ino);
>         if (IS_ERR(dentry)) {
>                 ret = PTR_ERR(dentry);
>                 goto err;
> @@ -1888,42 +1960,79 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>         if (ret)
>                 goto err;
>
> -       class_dir = sel_make_dir(sb->s_root, "class", &sel_last_ino);
> -       if (IS_ERR(class_dir)) {
> -               ret = PTR_ERR(class_dir);
> -               class_dir = NULL;
> +       fsi->class_dir = sel_make_dir(sb->s_root, "class", &fsi->last_ino);
> +       if (IS_ERR(fsi->class_dir)) {
> +               ret = PTR_ERR(fsi->class_dir);
> +               fsi->class_dir = NULL;
>                 goto err;
>         }
>
> -       policycap_dir = sel_make_dir(sb->s_root, "policy_capabilities", &sel_last_ino);
> -       if (IS_ERR(policycap_dir)) {
> -               ret = PTR_ERR(policycap_dir);
> -               policycap_dir = NULL;
> +       fsi->policycap_dir = sel_make_dir(sb->s_root, "policy_capabilities",
> +                                         &fsi->last_ino);
> +       if (IS_ERR(fsi->policycap_dir)) {
> +               ret = PTR_ERR(fsi->policycap_dir);
> +               fsi->policycap_dir = NULL;
>                 goto err;
>         }
> +
> +       ret = sel_make_policy_nodes(fsi);
> +       if (ret)
> +               goto err;
>         return 0;
>  err:
>         printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
>                 __func__);
> +

Do we want to cleanup fsi/sb->s_fs_info in case of error?

>         return ret;
>  }
>
> +static int selinuxfs_compare(struct super_block *sb, void *p)
> +{
> +       struct selinux_fs_info *fsi = sb->s_fs_info;
> +
> +       return (&selinux_state == fsi->state);
> +}
> +
>  static struct dentry *sel_mount(struct file_system_type *fs_type,
>                       int flags, const char *dev_name, void *data)
>  {
> -       return mount_single(fs_type, flags, data, sel_fill_super);
> +       int (*fill_super)(struct super_block *, void *, int) = sel_fill_super;
> +       struct super_block *s;
> +       int error;
> +
> +       s = sget(fs_type, selinuxfs_compare, set_anon_super, flags, NULL);
> +       if (IS_ERR(s))
> +               return ERR_CAST(s);
> +       if (!s->s_root) {
> +               error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
> +               if (error) {
> +                       deactivate_locked_super(s);
> +                       return ERR_PTR(error);
> +               }
> +               s->s_flags |= MS_ACTIVE;
> +       }
> +       return dget(s->s_root);
> +}

Why is mount_single() no longer desirable here?  The only difference I
can see is the call to do_remount_sb().  If the do_remount_sb() call
is problematic we should handle that in a separate patch and not bury
it here.

> +static void sel_kill_sb(struct super_block *sb)
> +{
> +       selinux_fs_info_free(sb);
> +       kill_litter_super(sb);
>  }
>
>  static struct file_system_type sel_fs_type = {
>         .name           = "selinuxfs",
>         .mount          = sel_mount,
> -       .kill_sb        = kill_litter_super,
> +       .kill_sb        = sel_kill_sb,
>  };
>
>  struct vfsmount *selinuxfs_mount;
> +struct path selinux_null;
>
>  static int __init init_sel_fs(void)
>  {
> +       struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
> +                                         sizeof(NULL_FILE_NAME)-1);
>         int err;
>
>         if (!selinux_enabled)
> @@ -1945,6 +2054,13 @@ static int __init init_sel_fs(void)
>                 err = PTR_ERR(selinuxfs_mount);
>                 selinuxfs_mount = NULL;
>         }
> +       selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
> +                                               &null_name);
> +       if (IS_ERR(selinux_null.dentry)) {
> +               pr_err("selinuxfs:  could not lookup null!\n");
> +               err = PTR_ERR(selinux_null.dentry);
> +               selinux_null.dentry = NULL;
> +       }

I'm getting a very strong feeling that I'm missing something important
here, but on quick inspection it doesn't appear we ever use the value
stored in selinux_null, and I'm really lost as to why we ever make it
available in include/security.h ... can we simply get rid of it?

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 4785ca552d51..ccfa65f6bc17 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2811,6 +2811,13 @@ int security_get_bools(struct selinux_state *state,
>         struct policydb *policydb;
>         int i, rc;
>
> +       if (!state->initialized) {
> +               *len = 0;
> +               *names = NULL;
> +               *values = NULL;
> +               return 0;
> +       }
> +
>         read_lock(&state->ss->policy_rwlock);
>
>         policydb = &state->ss->policydb;
> @@ -3141,6 +3148,12 @@ int security_get_classes(struct selinux_state *state,
>         struct policydb *policydb = &state->ss->policydb;
>         int rc;
>
> +       if (!state->initialized) {
> +               *nclasses = 0;
> +               *classes = NULL;
> +               return 0;
> +       }
> +
>         read_lock(&state->ss->policy_rwlock);
>
>         rc = -ENOMEM;

Both changes in ss/services.c seem like something that should be done
independently of this change, no?

-- 
paul moore
www.paul-moore.com
