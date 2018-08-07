Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w77LZsAq018915
 for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2018 17:35:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so81881lfe.8
 for <selinux@tycho.nsa.gov>; Tue, 07 Aug 2018 14:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180805091036.30035-1-nixiaoming@huawei.com>
In-Reply-To: <20180805091036.30035-1-nixiaoming@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Aug 2018 17:35:06 -0400
Message-ID: <CAHC9VhQKBphcPi3Oya58f4-tfK6GYkufotstduhkTaQw8NTw2Q@mail.gmail.com>
To: nixiaoming@huawei.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, serge@hallyn.com,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinuxfs: Fix the resource leak in the failed
 branch of sel_make_inode
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Aug 5, 2018 at 5:48 AM nixiaoming <nixiaoming@huawei.com> wrote:
> If the resource requested by d_alloc_name is not added to the linked
> list through d_add, then dput needs to be called to release the
> subsequent abnormal branch to avoid resource leakage.
>
> Add missing dput to selinuxfs.c
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  security/selinux/selinuxfs.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)

Thanks for the quick follow-up on this patch.  It looks okay to me,
assuming my test kernel works correctly (it's building now) I'll merge
this into selinux/next.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 79d3709..0b66d728 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1365,13 +1365,18 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
>
>                 ret = -ENOMEM;
>                 inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         goto out;
> +               }
>
>                 ret = -ENAMETOOLONG;
>                 len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
> -               if (len >= PAGE_SIZE)
> +               if (len >= PAGE_SIZE) {
> +                       dput(dentry);
> +                       iput(inode);
>                         goto out;
> +               }
>
>                 isec = (struct inode_security_struct *)inode->i_security;
>                 ret = security_genfs_sid(fsi->state, "selinuxfs", page,
> @@ -1586,8 +1591,10 @@ static int sel_make_avc_files(struct dentry *dir)
>                         return -ENOMEM;
>
>                 inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         return -ENOMEM;
> +               }
>
>                 inode->i_fop = files[i].ops;
>                 inode->i_ino = ++fsi->last_ino;
> @@ -1632,8 +1639,10 @@ static int sel_make_initcon_files(struct dentry *dir)
>                         return -ENOMEM;
>
>                 inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         return -ENOMEM;
> +               }
>
>                 inode->i_fop = &sel_initcon_ops;
>                 inode->i_ino = i|SEL_INITCON_INO_OFFSET;
> @@ -1733,8 +1742,10 @@ static int sel_make_perm_files(char *objclass, int classvalue,
>
>                 rc = -ENOMEM;
>                 inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -               if (!inode)
> +               if (!inode) {
> +                       dput(dentry);
>                         goto out;
> +               }
>
>                 inode->i_fop = &sel_perm_ops;
>                 /* i+1 since perm values are 1-indexed */
> @@ -1763,8 +1774,10 @@ static int sel_make_class_dir_entries(char *classname, int index,
>                 return -ENOMEM;
>
>         inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -       if (!inode)
> +       if (!inode) {
> +               dput(dentry);
>                 return -ENOMEM;
> +       }
>
>         inode->i_fop = &sel_class_ops;
>         inode->i_ino = sel_class_to_ino(index);
> @@ -1838,8 +1851,10 @@ static int sel_make_policycap(struct selinux_fs_info *fsi)
>                         return -ENOMEM;
>
>                 inode = sel_make_inode(fsi->sb, S_IFREG | 0444);
> -               if (inode == NULL)
> +               if (inode == NULL) {
> +                       dput(dentry);
>                         return -ENOMEM;
> +               }
>
>                 inode->i_fop = &sel_policycap_ops;
>                 inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
> @@ -1932,8 +1947,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>
>         ret = -ENOMEM;
>         inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
> -       if (!inode)
> +       if (!inode) {
> +               dput(dentry);
>                 goto err;
> +       }
>
>         inode->i_ino = ++fsi->last_ino;
>         isec = (struct inode_security_struct *)inode->i_security;
> --
> 2.10.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
paul moore
www.paul-moore.com
