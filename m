Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB7NcqZZ007750
 for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2016 18:38:52 -0500
Received: by mail-ua0-f193.google.com with SMTP id 50so41029991uae.2
 for <selinux@tycho.nsa.gov>; Wed, 07 Dec 2016 15:38:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481048848-21107-1-git-send-email-william.c.roberts@intel.com>
References: <1481048848-21107-1-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Dec 2016 18:38:19 -0500
Message-ID: <CAHC9VhSWLpVB76ZEtjF1rMmmMxyLPNQWA0o-TqOEeC4isBgmbA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: add security in-core xattr support for tracefs
To: william.c.roberts@intel.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, nnk@google.com, selinux@tycho.nsa.gov,
 Yongqin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 6, 2016 at 1:27 PM,  <william.c.roberts@intel.com> wrote:
> From: Yongqin Liu <yongqin.liu@linaro.org>
>
> Since kernel 4.1 ftrace is supported as a new separate filesystem. It
> gets automatically mounted by the kernel under the old path
> /sys/kernel/debug/tracing. Because it lives now on a separate filesystem
> SELinux needs to be updated to also support setting SELinux labels
> on tracefs inodes.  This is required for compatibility in Android
> when moving to Linux 4.1 or newer.
>
> Signed-off-by: Yongqin Liu <yongqin.liu@linaro.org>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)

Merged for v4.11, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 09fd610..24bd84d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -491,6 +491,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>                 !strcmp(sb->s_type->name, "sysfs") ||
>                 !strcmp(sb->s_type->name, "pstore") ||
>                 !strcmp(sb->s_type->name, "debugfs") ||
> +               !strcmp(sb->s_type->name, "tracefs") ||
>                 !strcmp(sb->s_type->name, "rootfs");
>  }
>
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
