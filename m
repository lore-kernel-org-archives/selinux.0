Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v12F1cmW030144
 for <selinux@tycho.nsa.gov>; Thu, 2 Feb 2017 10:01:39 -0500
Date: Thu, 2 Feb 2017 15:01:18 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Cc: amurdaca@redhat.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 vgoyal@redhat.com
Subject: Re: [PATCH] security: selinux: allow changing labels for cgroupfs
Message-ID: <20170202150118.GA6441@localhost.localdomain>
References: <20170202144228.24454-1-runcom@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170202144228.24454-1-runcom@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 02, 2017 at 03:42:28PM +0100, Antonio Murdaca wrote:
> This patch allows changing labels for cgroup mounts. Previously, running
> chcon on cgroupfs would throw an "Operation not supported". This patch
> specifically whitelist cgroupfs.
> 
> The patch could also allow containers to write only to the systemd cgroup
> for instance, while the other cgroups are kept with cgroup_t label.
> 
> Signed-off-by: Antonio Murdaca <runcom@redhat.com>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3b955c6..4e84211 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -480,6 +480,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>  		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
>  		/* Special handling. Genfs but also in-core setxattr handler */
>  		!strcmp(sb->s_type->name, "sysfs") ||
> +		!strcmp(sb->s_type->name, "cgroup") ||

Should we also include "cgroup2" here, since they are defined as 2
distinct filesystems? https://github.com/SELinuxProject/selinux-kernel/blob/master/kernel/cgroup.c#L2314-L2326

>  		!strcmp(sb->s_type->name, "pstore") ||
>  		!strcmp(sb->s_type->name, "debugfs") ||
>  		!strcmp(sb->s_type->name, "tracefs") ||
> -- 
> 2.9.3
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
