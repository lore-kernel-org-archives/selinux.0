Message-ID: <1486064805.1887.82.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2] security: selinux: allow changing labels for cgroupfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Antonio Murdaca <amurdaca@redhat.com>, selinux@tycho.nsa.gov
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, vgoyal@redhat.com
Date: Thu, 02 Feb 2017 14:46:45 -0500
In-Reply-To: <20170202152257.30220-1-runcom@redhat.com>
References: <20170202152257.30220-1-runcom@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-02-02 at 16:22 +0100, Antonio Murdaca wrote:
> This patch allows changing labels for cgroup mounts. Previously,
> running
> chcon on cgroupfs would throw an "Operation not supported". This
> patch
> specifically whitelist cgroupfs.
> 
> The patch could also allow containers to write only to the systemd
> cgroup
> for instance, while the other cgroups are kept with cgroup_t label.
> 
> Signed-off-by: Antonio Murdaca <runcom@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> Changes in v2:
>   - whitelist cgroup2 fs type
> 
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3b955c6..2789f0a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -480,6 +480,8 @@ static int selinux_is_sblabel_mnt(struct
> super_block *sb)
>  		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
>  		/* Special handling. Genfs but also in-core setxattr
> handler */
>  		!strcmp(sb->s_type->name, "sysfs") ||
> +		!strcmp(sb->s_type->name, "cgroup") ||
> +		!strcmp(sb->s_type->name, "cgroup2") ||
>  		!strcmp(sb->s_type->name, "pstore") ||
>  		!strcmp(sb->s_type->name, "debugfs") ||
>  		!strcmp(sb->s_type->name, "tracefs") ||
