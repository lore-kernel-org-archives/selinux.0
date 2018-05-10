Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4AGFv51025106
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 12:15:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40hdcq3j1XzrKYF
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 16:15:55 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40hdcp1w2RzrKYR
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 16:15:54 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id q2-v6so3746600lfc.12
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 09:15:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <799f2558f37c5480d42c03e3465754aa8bb30e70.1525964385.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
 <799f2558f37c5480d42c03e3465754aa8bb30e70.1525964385.git.joe@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 May 2018 12:15:51 -0400
Message-ID: <CAHC9VhQb72hBo5Tv0gu-LurhdjQYyt3B=7mz6oJ1XqZfc9GZ_Q@mail.gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 15/18] security: Remove pr_fmt duplicate logging prefixes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 10, 2018 at 11:45 AM, Joe Perches <joe@perches.com> wrote:
> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
>
> Remove them.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/selinux/selinuxfs.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c0cadbc5f85c..be8f186a6256 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -515,19 +515,19 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi)
>
>         ret = sel_make_bools(fsi);
>         if (ret) {
> -               pr_err("SELinux: failed to load policy booleans\n");
> +               pr_err("failed to load policy booleans\n");
>                 return ret;
>         }
>
>         ret = sel_make_classes(fsi);
>         if (ret) {
> -               pr_err("SELinux: failed to load policy classes\n");
> +               pr_err("failed to load policy classes\n");
>                 return ret;
>         }
>
>         ret = sel_make_policycap(fsi);
>         if (ret) {
> -               pr_err("SELinux: failed to load policy capabilities\n");
> +               pr_err("failed to load policy capabilities\n");
>                 return ret;
>         }
>
> @@ -570,7 +570,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>
>         length = security_load_policy(fsi->state, data, count);
>         if (length) {
> -               pr_warn_ratelimited("SELinux: failed to load policy\n");
> +               pr_warn_ratelimited("failed to load policy\n");
>                 goto out;
>         }
>
> @@ -620,8 +620,8 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> -                       "payload max\n", __func__, len);
> +               pr_err("%s:  context size (%u) exceeds payload max\n",
> +                      __func__, len);
>                 goto out;
>         }
>
> @@ -956,8 +956,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> -                       "payload max\n", __func__, len);
> +               pr_err("%s:  context size (%u) exceeds payload max\n",
> +                      __func__, len);
>                 goto out;
>         }
>
> @@ -1147,8 +1147,8 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> -                       "payload max\n", __func__, len);
> +               pr_err("%s:  context size (%u) exceeds payload max\n",
> +                      __func__, len);
>                 goto out;
>         }
>
> @@ -1389,8 +1389,8 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
>                 ret = security_genfs_sid(fsi->state, "selinuxfs", page,
>                                          SECCLASS_FILE, &sid);
>                 if (ret) {
> -                       pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
> -                                          page);
> +                       pr_warn_ratelimited("no sid found, defaulting to security isid for %s\n",
> +                                           page);
>                         sid = SECINITSID_SECURITY;
>                 }
>
> @@ -1996,8 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>                 goto err;
>         return 0;
>  err:
> -       printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
> -               __func__);
> +       pr_err("%s:  failed while creating inodes\n", __func__);
>
>         selinux_fs_info_free(sb);
>
> @@ -2046,7 +2045,7 @@ static int __init init_sel_fs(void)
>
>         selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
>         if (IS_ERR(selinuxfs_mount)) {
> -               printk(KERN_ERR "selinuxfs:  could not mount!\n");
> +               pr_err("selinuxfs:  could not mount!\n");
>                 err = PTR_ERR(selinuxfs_mount);
>                 selinuxfs_mount = NULL;
>         }
> --
> 2.15.0
>



-- 
paul moore
www.paul-moore.com
