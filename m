Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0EJo5Bu016175
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 14:50:05 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so9030171qcy.7
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 11:50:03 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH 5/5] pstore: selinux: add security in-core xattr support
 for pstore and debugfs
Date: Wed, 14 Jan 2015 14:50:01 -0500
Message-ID: <4175437.ksvLooJb8o@sifl>
In-Reply-To: <1421188410-2006-1-git-send-email-salyzyn@android.com>
References: <1421188410-2006-1-git-send-email-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, January 13, 2015 02:33:18 PM Mark Salyzyn wrote:
> - add "pstore" and "debugfs" to list of in-core exceptions
> - change fstype checks to boolean equation
> - change from strncmp to strcmp for checking
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> ---
>  security/selinux/hooks.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)

Not a huge fan of the coding style, but merged into the next branch 
regardless.

Thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6da7532..789a7e1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -401,23 +401,14 @@ static int selinux_is_sblabel_mnt(struct super_block
> *sb) {
>  	struct superblock_security_struct *sbsec = sb->s_security;
> 
> -	if (sbsec->behavior == SECURITY_FS_USE_XATTR ||
> -	    sbsec->behavior == SECURITY_FS_USE_TRANS ||
> -	    sbsec->behavior == SECURITY_FS_USE_TASK)
> -		return 1;
> -
> -	/* Special handling for sysfs. Is genfs but also has setxattr handler*/
> -	if (strncmp(sb->s_type->name, "sysfs", sizeof("sysfs")) == 0)
> -		return 1;
> -
> -	/*
> -	 * Special handling for rootfs. Is genfs but supports
> -	 * setting SELinux context on in-core inodes.
> -	 */
> -	if (strncmp(sb->s_type->name, "rootfs", sizeof("rootfs")) == 0)
> -		return 1;
> -
> -	return 0;
> +	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
> +		sbsec->behavior == SECURITY_FS_USE_TRANS ||
> +		sbsec->behavior == SECURITY_FS_USE_TASK ||
> +		/* Special handling. Genfs but also in-core setxattr handler */
> +		!strcmp(sb->s_type->name, "sysfs") ||
> +		!strcmp(sb->s_type->name, "pstore") ||
> +		!strcmp(sb->s_type->name, "debugfs") ||
> +		!strcmp(sb->s_type->name, "rootfs");
>  }
> 
>  static int sb_finish_set_opts(struct super_block *sb)

-- 
paul moore
www.paul-moore.com
