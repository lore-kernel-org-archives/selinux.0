MIME-Version: 1.0
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
 <CAHC9VhRmA8YcyH+YzKQUaOR4Go_c09WCQMOXHmvar2UQQv_eeA@mail.gmail.com>
In-Reply-To: <CAHC9VhRmA8YcyH+YzKQUaOR4Go_c09WCQMOXHmvar2UQQv_eeA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Wed, 14 Mar 2018 15:44:47 +0000
Message-ID: <CAB9W1A2tqo7LoYAh_C_2uS6r_btpZH=PG4KpVCvP5=XDCtEXhA@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Stephen D. Smalley" <sds@tycho.nsa.gov>, peter.enderborg@sony.com,
 selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="001a1141d07edcfd63056761415a"
Subject: Re: [PATCH 1/2] selinux: wrap selinuxfs state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1141d07edcfd63056761415a
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 13, 2018, 12:18 PM Paul Moore <paul@paul-moore.com> wrote:

> On Mon, Mar 5, 2018 at 11:47 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > Move global selinuxfs state to a per-instance structure
> (selinux_fs_info),
> > and include a pointer to the selinux_state in this structure.
> > Pass this selinux_state to all security server operations, thereby
> > ensuring that each selinuxfs instance presents a view of and acts
> > as an interface to a particular selinux_state instance.
> >
> > This change should have no effect on SELinux behavior or APIs
> > (userspace or LSM).  It merely wraps the selinuxfs global state,
> > links it to a particular selinux_state (currently always the single
> > global selinux_state) and uses that state for all operations.
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/selinuxfs.c   | 472
> +++++++++++++++++++++++++----------------
> >  security/selinux/ss/services.c |  13 ++
> >  2 files changed, 307 insertions(+), 178 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 0dbd5fd6a396..1a32e93ba7b9 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -94,11 +122,13 @@ static unsigned long sel_last_ino = SEL_INO_NEXT -
> 1;
> >  static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
> >                                 size_t count, loff_t *ppos)
> >  {
> > +       struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
> > +       struct selinux_state *state = fsi->state;
> >         char tmpbuf[TMPBUFLEN];
> >         ssize_t length;
> >
> >         length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
> > -                          enforcing_enabled(&selinux_state));
> > +                          enforcing_enabled(state));
>
> Since we only use state once, it seems like we could just use
> fsi->state without problem.
>
> > @@ -186,7 +218,9 @@ static const struct file_operations
> sel_handle_unknown_ops = {
> >
> >  static int sel_open_handle_status(struct inode *inode, struct file
> *filp)
> >  {
> > -       struct page    *status =
> selinux_kernel_status_page(&selinux_state);
> > +       struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
> > +       struct selinux_state *state = fsi->state;
> > +       struct page    *status = selinux_kernel_status_page(state);
>
> Once again, why do we need state instead of fsi->state?
>
> >         if (!status)
> >                 return -ENOMEM;
> > @@ -242,6 +276,8 @@ static ssize_t sel_write_disable(struct file *file,
> const char __user *buf,
> >                                  size_t count, loff_t *ppos)
> >
> >  {
> > +       struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
> > +       struct selinux_state *state = fsi->state;
> >         char *page;
> >         ssize_t length;
> >         int new_value;
> > @@ -262,7 +298,7 @@ static ssize_t sel_write_disable(struct file *file,
> const char __user *buf,
> >                 goto out;
> >
> >         if (new_value) {
> > -               length = selinux_disable(&selinux_state);
> > +               length = selinux_disable(state);
>
> Same as above.
>
> I think if we end up having to reference it more than once, go ahead
> and add another variable to the stack, otherwise just stick with
> fsi->state.  Go ahead and apply this logic to the rest of this patch.
>
> > @@ -1808,8 +1872,11 @@ static struct dentry *sel_make_dir(struct dentry
> *dir, const char *name,
> >         return dentry;
> >  }
> >
> > +#define NULL_FILE_NAME "null"
> > +
> >  static int sel_fill_super(struct super_block *sb, void *data, int
> silent)
> >  {
> > +       struct selinux_fs_info *fsi;
> >         int ret;
> >         struct dentry *dentry;
> >         struct inode *inode;
> > @@ -1837,14 +1904,20 @@ static int sel_fill_super(struct super_block
> *sb, void *data, int silent)
> >                                         S_IWUGO},
> >                 /* last one */ {""}
> >         };
> > +
> > +       ret = selinux_fs_info_create(sb);
> > +       if (ret)
> > +               goto err;
> > +
> >         ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
> >         if (ret)
> >                 goto err;
> >
> > -       bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME,
> &sel_last_ino);
> > -       if (IS_ERR(bool_dir)) {
> > -               ret = PTR_ERR(bool_dir);
> > -               bool_dir = NULL;
> > +       fsi = sb->s_fs_info;
> > +       fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME,
> &fsi->last_ino);
> > +       if (IS_ERR(fsi->bool_dir)) {
> > +               ret = PTR_ERR(fsi->bool_dir);
> > +               fsi->bool_dir = NULL;
> >                 goto err;
> >         }
> >
> > @@ -1858,7 +1931,7 @@ static int sel_fill_super(struct super_block *sb,
> void *data, int silent)
> >         if (!inode)
> >                 goto err;
> >
> > -       inode->i_ino = ++sel_last_ino;
> > +       inode->i_ino = ++fsi->last_ino;
> >         isec = (struct inode_security_struct *)inode->i_security;
> >         isec->sid = SECINITSID_DEVNULL;
> >         isec->sclass = SECCLASS_CHR_FILE;
> > @@ -1866,9 +1939,8 @@ static int sel_fill_super(struct super_block *sb,
> void *data, int silent)
> >
> >         init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
> MKDEV(MEM_MAJOR, 3));
> >         d_add(dentry, inode);
> > -       selinux_null.dentry = dentry;
> >
> > -       dentry = sel_make_dir(sb->s_root, "avc", &sel_last_ino);
> > +       dentry = sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
> >         if (IS_ERR(dentry)) {
> >                 ret = PTR_ERR(dentry);
> >                 goto err;
> > @@ -1878,7 +1950,7 @@ static int sel_fill_super(struct super_block *sb,
> void *data, int silent)
> >         if (ret)
> >                 goto err;
> >
> > -       dentry = sel_make_dir(sb->s_root, "initial_contexts",
> &sel_last_ino);
> > +       dentry = sel_make_dir(sb->s_root, "initial_contexts",
> &fsi->last_ino);
> >         if (IS_ERR(dentry)) {
> >                 ret = PTR_ERR(dentry);
> >                 goto err;
> > @@ -1888,42 +1960,79 @@ static int sel_fill_super(struct super_block
> *sb, void *data, int silent)
> >         if (ret)
> >                 goto err;
> >
> > -       class_dir = sel_make_dir(sb->s_root, "class", &sel_last_ino);
> > -       if (IS_ERR(class_dir)) {
> > -               ret = PTR_ERR(class_dir);
> > -               class_dir = NULL;
> > +       fsi->class_dir = sel_make_dir(sb->s_root, "class",
> &fsi->last_ino);
> > +       if (IS_ERR(fsi->class_dir)) {
> > +               ret = PTR_ERR(fsi->class_dir);
> > +               fsi->class_dir = NULL;
> >                 goto err;
> >         }
> >
> > -       policycap_dir = sel_make_dir(sb->s_root, "policy_capabilities",
> &sel_last_ino);
> > -       if (IS_ERR(policycap_dir)) {
> > -               ret = PTR_ERR(policycap_dir);
> > -               policycap_dir = NULL;
> > +       fsi->policycap_dir = sel_make_dir(sb->s_root,
> "policy_capabilities",
> > +                                         &fsi->last_ino);
> > +       if (IS_ERR(fsi->policycap_dir)) {
> > +               ret = PTR_ERR(fsi->policycap_dir);
> > +               fsi->policycap_dir = NULL;
> >                 goto err;
> >         }
> > +
> > +       ret = sel_make_policy_nodes(fsi);
> > +       if (ret)
> > +               goto err;
> >         return 0;
> >  err:
> >         printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
> >                 __func__);
> > +
>
> Do we want to cleanup fsi/sb->s_fs_info in case of error?
>
> >         return ret;
> >  }
> >
> > +static int selinuxfs_compare(struct super_block *sb, void *p)
> > +{
> > +       struct selinux_fs_info *fsi = sb->s_fs_info;
> > +
> > +       return (&selinux_state == fsi->state);
> > +}
> > +
> >  static struct dentry *sel_mount(struct file_system_type *fs_type,
> >                       int flags, const char *dev_name, void *data)
> >  {
> > -       return mount_single(fs_type, flags, data, sel_fill_super);
> > +       int (*fill_super)(struct super_block *, void *, int) =
> sel_fill_super;
> > +       struct super_block *s;
> > +       int error;
> > +
> > +       s = sget(fs_type, selinuxfs_compare, set_anon_super, flags,
> NULL);
> > +       if (IS_ERR(s))
> > +               return ERR_CAST(s);
> > +       if (!s->s_root) {
> > +               error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
> > +               if (error) {
> > +                       deactivate_locked_super(s);
> > +                       return ERR_PTR(error);
> > +               }
> > +               s->s_flags |= MS_ACTIVE;
> > +       }
> > +       return dget(s->s_root);
> > +}
>
> Why is mount_single() no longer desirable here?  The only difference I
> can see is the call to do_remount_sb().  If the do_remount_sb() call
> is problematic we should handle that in a separate patch and not bury
> it here.
>

This is laying the groundwork for supporting multiple distinct selinux fs
super blocks. That said, we could likely defer this part of the patch until
namespaces are introduced.


> > +static void sel_kill_sb(struct super_block *sb)
> > +{
> > +       selinux_fs_info_free(sb);
> > +       kill_litter_super(sb);
> >  }
> >
> >  static struct file_system_type sel_fs_type = {
> >         .name           = "selinuxfs",
> >         .mount          = sel_mount,
> > -       .kill_sb        = kill_litter_super,
> > +       .kill_sb        = sel_kill_sb,
> >  };
> >
> >  struct vfsmount *selinuxfs_mount;
> > +struct path selinux_null;
> >
> >  static int __init init_sel_fs(void)
> >  {
> > +       struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
> > +                                         sizeof(NULL_FILE_NAME)-1);
> >         int err;
> >
> >         if (!selinux_enabled)
> > @@ -1945,6 +2054,13 @@ static int __init init_sel_fs(void)
> >                 err = PTR_ERR(selinuxfs_mount);
> >                 selinuxfs_mount = NULL;
> >         }
> > +       selinux_null.dentry =
> d_hash_and_lookup(selinux_null.mnt->mnt_root,
> > +                                               &null_name);
> > +       if (IS_ERR(selinux_null.dentry)) {
> > +               pr_err("selinuxfs:  could not lookup null!\n");
> > +               err = PTR_ERR(selinux_null.dentry);
> > +               selinux_null.dentry = NULL;
> > +       }
>
> I'm getting a very strong feeling that I'm missing something important
> here, but on quick inspection it doesn't appear we ever use the value
> stored in selinux_null, and I'm really lost as to why we ever make it
> available in include/security.h ... can we simply get rid of it?
>

It is used by flush_unauthorized_files() in hooks.c.


> > diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> > index 4785ca552d51..ccfa65f6bc17 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2811,6 +2811,13 @@ int security_get_bools(struct selinux_state
> *state,
> >         struct policydb *policydb;
> >         int i, rc;
> >
> > +       if (!state->initialized) {
> > +               *len = 0;
> > +               *names = NULL;
> > +               *values = NULL;
> > +               return 0;
> > +       }
> > +
> >         read_lock(&state->ss->policy_rwlock);
> >
> >         policydb = &state->ss->policydb;
> > @@ -3141,6 +3148,12 @@ int security_get_classes(struct selinux_state
> *state,
> >         struct policydb *policydb = &state->ss->policydb;
> >         int rc;
> >
> > +       if (!state->initialized) {
> > +               *nclasses = 0;
> > +               *classes = NULL;
> > +               return 0;
> > +       }
> > +
> >         read_lock(&state->ss->policy_rwlock);
> >
> >         rc = -ENOMEM;
>
> Both changes in ss/services.c seem like something that should be done
> independently of this change, no?
>

--001a1141d07edcfd63056761415a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, =
Mar 13, 2018, 12:18 PM Paul Moore &lt;<a href=3D"mailto:paul@paul-moore.com=
">paul@paul-moore.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">On Mon, Mar 5, 2018 at 11:47 AM, Stephen Smalley &lt;<a href=3D"mailto:sd=
s@tycho.nsa.gov" target=3D"_blank" rel=3D"noreferrer">sds@tycho.nsa.gov</a>=
&gt; wrote:<br>
&gt; Move global selinuxfs state to a per-instance structure (selinux_fs_in=
fo),<br>
&gt; and include a pointer to the selinux_state in this structure.<br>
&gt; Pass this selinux_state to all security server operations, thereby<br>
&gt; ensuring that each selinuxfs instance presents a view of and acts<br>
&gt; as an interface to a particular selinux_state instance.<br>
&gt;<br>
&gt; This change should have no effect on SELinux behavior or APIs<br>
&gt; (userspace or LSM).=C2=A0 It merely wraps the selinuxfs global state,<=
br>
&gt; links it to a particular selinux_state (currently always the single<br=
>
&gt; global selinux_state) and uses that state for all operations.<br>
&gt;<br>
&gt; Signed-off-by: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov=
" target=3D"_blank" rel=3D"noreferrer">sds@tycho.nsa.gov</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 security/selinux/selinuxfs.c=C2=A0 =C2=A0| 472 +++++++++++++++++=
++++++++----------------<br>
&gt;=C2=A0 security/selinux/ss/services.c |=C2=A0 13 ++<br>
&gt;=C2=A0 2 files changed, 307 insertions(+), 178 deletions(-)<br>
<br>
...<br>
<br>
&gt; diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs=
.c<br>
&gt; index 0dbd5fd6a396..1a32e93ba7b9 100644<br>
&gt; --- a/security/selinux/selinuxfs.c<br>
&gt; +++ b/security/selinux/selinuxfs.c<br>
&gt; @@ -94,11 +122,13 @@ static unsigned long sel_last_ino =3D SEL_INO_NEX=
T - 1;<br>
&gt;=C2=A0 static ssize_t sel_read_enforce(struct file *filp, char __user *=
buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t count, loff_t *ppos)=
<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_fs_info *fsi =3D file_inode=
(filp)-&gt;i_sb-&gt;s_fs_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_state *state =3D fsi-&gt;st=
ate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char tmpbuf[TMPBUFLEN];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t length;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0length =3D scnprintf(tmpbuf, TMPBUFLE=
N, &quot;%d&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 enforcing_enabled(&amp;selinux_state));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 enforcing_enabled(state));<br>
<br>
Since we only use state once, it seems like we could just use<br>
fsi-&gt;state without problem.<br>
<br>
&gt; @@ -186,7 +218,9 @@ static const struct file_operations sel_handle_unk=
nown_ops =3D {<br>
&gt;<br>
&gt;=C2=A0 static int sel_open_handle_status(struct inode *inode, struct fi=
le *filp)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct page=C2=A0 =C2=A0 *status =3D selin=
ux_kernel_status_page(&amp;selinux_state);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_fs_info *fsi =3D file_inode=
(filp)-&gt;i_sb-&gt;s_fs_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_state *state =3D fsi-&gt;st=
ate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct page=C2=A0 =C2=A0 *status =3D selin=
ux_kernel_status_page(state);<br>
<br>
Once again, why do we need state instead of fsi-&gt;state?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
NOMEM;<br>
&gt; @@ -242,6 +276,8 @@ static ssize_t sel_write_disable(struct file *file=
, const char __user *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t count, loff_t *ppos=
)<br>
&gt;<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_fs_info *fsi =3D file_inode=
(file)-&gt;i_sb-&gt;s_fs_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_state *state =3D fsi-&gt;st=
ate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *page;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int new_value;<br>
&gt; @@ -262,7 +298,7 @@ static ssize_t sel_write_disable(struct file *file=
, const char __user *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (new_value) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0length =3D sel=
inux_disable(&amp;selinux_state);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0length =3D sel=
inux_disable(state);<br>
<br>
Same as above.<br>
<br>
I think if we end up having to reference it more than once, go ahead<br>
and add another variable to the stack, otherwise just stick with<br>
fsi-&gt;state.=C2=A0 Go ahead and apply this logic to the rest of this patc=
h.<br>
<br>
&gt; @@ -1808,8 +1872,11 @@ static struct dentry *sel_make_dir(struct dentr=
y *dir, const char *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dentry;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +#define NULL_FILE_NAME &quot;null&quot;<br>
&gt; +<br>
&gt;=C2=A0 static int sel_fill_super(struct super_block *sb, void *data, in=
t silent)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_fs_info *fsi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode;<br>
&gt; @@ -1837,14 +1904,20 @@ static int sel_fill_super(struct super_block *=
sb, void *data, int silent)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0S_IWUGO},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* last o=
ne */ {&quot;&quot;}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D selinux_fs_info_create(sb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D simple_fill_super(sb, SELINUX=
_MAGIC, selinux_files);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0bool_dir =3D sel_make_dir(sb-&gt;s_root, B=
OOL_DIR_NAME, &amp;sel_last_ino);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(bool_dir)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ER=
R(bool_dir);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool_dir =3D N=
ULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fsi =3D sb-&gt;s_fs_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fsi-&gt;bool_dir =3D sel_make_dir(sb-&gt;s=
_root, BOOL_DIR_NAME, &amp;fsi-&gt;last_ino);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(fsi-&gt;bool_dir)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ER=
R(fsi-&gt;bool_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsi-&gt;bool_d=
ir =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; @@ -1858,7 +1931,7 @@ static int sel_fill_super(struct super_block *sb=
, void *data, int silent)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;i_ino =3D ++sel_last_ino;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;i_ino =3D ++fsi-&gt;last_ino;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isec =3D (struct inode_security_struc=
t *)inode-&gt;i_security;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isec-&gt;sid =3D SECINITSID_DEVNULL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isec-&gt;sclass =3D SECCLASS_CHR_FILE=
;<br>
&gt; @@ -1866,9 +1939,8 @@ static int sel_fill_super(struct super_block *sb=
, void *data, int silent)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_special_inode(inode, S_IFCHR | S=
_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d_add(dentry, inode);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_null.dentry =3D dentry;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0dentry =3D sel_make_dir(sb-&gt;s_root, &qu=
ot;avc&quot;, &amp;sel_last_ino);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0dentry =3D sel_make_dir(sb-&gt;s_root, &qu=
ot;avc&quot;, &amp;fsi-&gt;last_ino);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(dentry)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D P=
TR_ERR(dentry);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt; @@ -1878,7 +1950,7 @@ static int sel_fill_super(struct super_block *sb=
, void *data, int silent)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0dentry =3D sel_make_dir(sb-&gt;s_root, &qu=
ot;initial_contexts&quot;, &amp;sel_last_ino);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0dentry =3D sel_make_dir(sb-&gt;s_root, &qu=
ot;initial_contexts&quot;, &amp;fsi-&gt;last_ino);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(dentry)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D P=
TR_ERR(dentry);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt; @@ -1888,42 +1960,79 @@ static int sel_fill_super(struct super_block *=
sb, void *data, int silent)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0class_dir =3D sel_make_dir(sb-&gt;s_root, =
&quot;class&quot;, &amp;sel_last_ino);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(class_dir)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ER=
R(class_dir);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0class_dir =3D =
NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fsi-&gt;class_dir =3D sel_make_dir(sb-&gt;=
s_root, &quot;class&quot;, &amp;fsi-&gt;last_ino);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(fsi-&gt;class_dir)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ER=
R(fsi-&gt;class_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsi-&gt;class_=
dir =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0policycap_dir =3D sel_make_dir(sb-&gt;s_ro=
ot, &quot;policy_capabilities&quot;, &amp;sel_last_ino);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(policycap_dir)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ER=
R(policycap_dir);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0policycap_dir =
=3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fsi-&gt;policycap_dir =3D sel_make_dir(sb-=
&gt;s_root, &quot;policy_capabilities&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;fsi-&gt;last_ino);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(fsi-&gt;policycap_dir)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ER=
R(fsi-&gt;policycap_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsi-&gt;policy=
cap_dir =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sel_make_policy_nodes(fsi);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 err:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR &quot;SELinux: %s:=C2=
=A0 failed while creating inodes\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__)=
;<br>
&gt; +<br>
<br>
Do we want to cleanup fsi/sb-&gt;s_fs_info in case of error?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static int selinuxfs_compare(struct super_block *sb, void *p)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selinux_fs_info *fsi =3D sb-&gt;s_f=
s_info;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return (&amp;selinux_state =3D=3D fsi-&gt;=
state);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static struct dentry *sel_mount(struct file_system_type *fs_type=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int flags, const char *dev_name, void *data)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return mount_single(fs_type, flags, data, =
sel_fill_super);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*fill_super)(struct super_block *, vo=
id *, int) =3D sel_fill_super;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct super_block *s;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int error;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0s =3D sget(fs_type, selinuxfs_compare, set=
_anon_super, flags, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(s))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_CAS=
T(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;s_root) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D fill=
_super(s, data, flags &amp; MS_SILENT ? 1 : 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0deactivate_locked_super(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return ERR_PTR(error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;s_flags =
|=3D MS_ACTIVE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return dget(s-&gt;s_root);<br>
&gt; +}<br>
<br>
Why is mount_single() no longer desirable here?=C2=A0 The only difference I=
<br>
can see is the call to do_remount_sb().=C2=A0 If the do_remount_sb() call<b=
r>
is problematic we should handle that in a separate patch and not bury<br>
it here.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">This is laying the groundwork for supporting multiple distinct se=
linux fs super blocks. That said, we could likely defer this part of the pa=
tch until namespaces are introduced.=C2=A0</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<br>
&gt; +static void sel_kill_sb(struct super_block *sb)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_fs_info_free(sb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0kill_litter_super(sb);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static struct file_system_type sel_fs_type =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D &quot;selinuxfs&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D sel_mount,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0.kill_sb=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D ki=
ll_litter_super,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.kill_sb=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D se=
l_kill_sb,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct vfsmount *selinuxfs_mount;<br>
&gt; +struct path selinux_null;<br>
&gt;<br>
&gt;=C2=A0 static int __init init_sel_fs(void)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct qstr null_name =3D QSTR_INIT(NULL_F=
ILE_NAME,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sizeof(NULL_FILE_NAME)-1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!selinux_enabled)<br>
&gt; @@ -1945,6 +2054,13 @@ static int __init init_sel_fs(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D P=
TR_ERR(selinuxfs_mount);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selinuxfs=
_mount =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_null.dentry =3D d_hash_and_lookup(=
selinux_null.mnt-&gt;mnt_root,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;null_name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(selinux_null.dentry)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;s=
elinuxfs:=C2=A0 could not lookup null!\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D PTR_ER=
R(selinux_null.dentry);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_null.d=
entry =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
I&#39;m getting a very strong feeling that I&#39;m missing something import=
ant<br>
here, but on quick inspection it doesn&#39;t appear we ever use the value<b=
r>
stored in selinux_null, and I&#39;m really lost as to why we ever make it<b=
r>
available in include/security.h ... can we simply get rid of it?<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It is used =
by flush_unauthorized_files() in hooks.c.=C2=A0</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
&gt; diff --git a/security/selinux/ss/services.c b/security/selinux/ss/serv=
ices.c<br>
&gt; index 4785ca552d51..ccfa65f6bc17 100644<br>
&gt; --- a/security/selinux/ss/services.c<br>
&gt; +++ b/security/selinux/ss/services.c<br>
&gt; @@ -2811,6 +2811,13 @@ int security_get_bools(struct selinux_state *st=
ate,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct policydb *policydb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, rc;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!state-&gt;initialized) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*len =3D 0;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*names =3D NUL=
L;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*values =3D NU=
LL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_lock(&amp;state-&gt;ss-&gt;polic=
y_rwlock);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0policydb =3D &amp;state-&gt;ss-&gt;po=
licydb;<br>
&gt; @@ -3141,6 +3148,12 @@ int security_get_classes(struct selinux_state *=
state,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct policydb *policydb =3D &amp;st=
ate-&gt;ss-&gt;policydb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!state-&gt;initialized) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*nclasses =3D =
0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*classes =3D N=
ULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_lock(&amp;state-&gt;ss-&gt;polic=
y_rwlock);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -ENOMEM;<br>
<br>
Both changes in ss/services.c seem like something that should be done<br>
independently of this change, no?<br>
</blockquote></div></div></div>

--001a1141d07edcfd63056761415a--
