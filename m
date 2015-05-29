Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4TLCMoP022139
 for <selinux@tycho.nsa.gov>; Fri, 29 May 2015 17:12:23 -0400
Received: by qgf2 with SMTP id 2so34179494qgf.3
 for <selinux@tycho.nsa.gov>; Fri, 29 May 2015 14:12:20 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] selinux: enable genfscon labeling for sysfs and pstore
 files
Date: Fri, 29 May 2015 17:12:18 -0400
Message-ID: <2889285.RovfmeTSFv@sifl>
In-Reply-To: <1432298027-19412-1-git-send-email-sds@tycho.nsa.gov>
References: <1432298027-19412-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, May 22, 2015 08:33:47 AM Stephen Smalley wrote:
> Support per-file labeling of sysfs and pstore files based on
> genfscon policy entries.  This is safe because the sysfs
> and pstore directory tree cannot be manipulated by userspace,
> except to unlink pstore entries.
> This provides an alternative method of assigning per-file labeling
> to sysfs or pstore files without needing to set the labels from
> userspace on each boot.  The advantages of this approach are that
> the labels are assigned as soon as the dentry is first instantiated
> and userspace does not need to walk the sysfs or pstore tree and
> set the labels on each boot.  The limitations of this approach are
> that the labels can only be assigned based on pathname prefix matching.
> You can initially assign labels using this mechanism and then change
> them at runtime via setxattr if allowed to do so by policy.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> Suggested-by: Dominick Grift <dac.override@gmail.com>
> ---
> This version adds support for pstore as well as sysfs.
> 
>  security/selinux/hooks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2c616f6..070ab05 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -727,7 +727,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  	if (strcmp(sb->s_type->name, "proc") == 0)
>  		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
> 
> -	if (strcmp(sb->s_type->name, "debugfs") == 0)
> +	if (!strcmp(sb->s_type->name, "debugfs") ||
> +	    !strcmp(sb->s_type->name, "sysfs") ||
> +	    !strcmp(sb->s_type->name, "pstore"))
>  		sbsec->flags |= SE_SBGENFS;
> 
>  	if (!sbsec->behavior) {

-- 
paul moore
www.paul-moore.com
