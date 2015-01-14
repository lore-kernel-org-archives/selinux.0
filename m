MIME-Version: 1.0
In-Reply-To: <1421188410-2006-1-git-send-email-salyzyn@android.com>
References: <1421188410-2006-1-git-send-email-salyzyn@android.com>
Date: Wed, 14 Jan 2015 10:49:45 -0500
Message-ID: <CAB9W1A05SJ2kMsFcq3jNfkp1uOpkHDhv0E8gLjhvHnVsgGhnjA@mail.gmail.com>
Subject: Re: [PATCH 5/5] pstore: selinux: add security in-core xattr support
 for pstore and debugfs
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Mark Salyzyn <salyzyn@android.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 13, 2015 at 5:33 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> - add "pstore" and "debugfs" to list of in-core exceptions
> - change fstype checks to boolean equation
> - change from strncmp to strcmp for checking
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/hooks.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6da7532..789a7e1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -401,23 +401,14 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>  {
>         struct superblock_security_struct *sbsec = sb->s_security;
>
> -       if (sbsec->behavior == SECURITY_FS_USE_XATTR ||
> -           sbsec->behavior == SECURITY_FS_USE_TRANS ||
> -           sbsec->behavior == SECURITY_FS_USE_TASK)
> -               return 1;
> -
> -       /* Special handling for sysfs. Is genfs but also has setxattr handler*/
> -       if (strncmp(sb->s_type->name, "sysfs", sizeof("sysfs")) == 0)
> -               return 1;
> -
> -       /*
> -        * Special handling for rootfs. Is genfs but supports
> -        * setting SELinux context on in-core inodes.
> -        */
> -       if (strncmp(sb->s_type->name, "rootfs", sizeof("rootfs")) == 0)
> -               return 1;
> -
> -       return 0;
> +       return sbsec->behavior == SECURITY_FS_USE_XATTR ||
> +               sbsec->behavior == SECURITY_FS_USE_TRANS ||
> +               sbsec->behavior == SECURITY_FS_USE_TASK ||
> +               /* Special handling. Genfs but also in-core setxattr handler */
> +               !strcmp(sb->s_type->name, "sysfs") ||
> +               !strcmp(sb->s_type->name, "pstore") ||
> +               !strcmp(sb->s_type->name, "debugfs") ||
> +               !strcmp(sb->s_type->name, "rootfs");
>  }
>
>  static int sb_finish_set_opts(struct super_block *sb)
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
