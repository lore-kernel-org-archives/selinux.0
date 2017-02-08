Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v183TF0q029453
 for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2017 22:29:15 -0500
Received: by mail-vk0-f65.google.com with SMTP id r136so11040848vke.1
 for <selinux@tycho.nsa.gov>; Tue, 07 Feb 2017 19:29:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170202152257.30220-1-runcom@redhat.com>
References: <20170202152257.30220-1-runcom@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Feb 2017 22:29:13 -0500
Message-ID: <CAHC9VhR1yu6G4H0UYNY-4UNxs9Byg=2CMckMH+pE_HYiDf-Ugg@mail.gmail.com>
Subject: Re: [PATCH v2] security: selinux: allow changing labels for cgroupfs
To: Antonio Murdaca <amurdaca@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, vgoyal@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 2, 2017 at 10:22 AM, Antonio Murdaca <amurdaca@redhat.com> wrote:
> This patch allows changing labels for cgroup mounts. Previously, running
> chcon on cgroupfs would throw an "Operation not supported". This patch
> specifically whitelist cgroupfs.
>
> The patch could also allow containers to write only to the systemd cgroup
> for instance, while the other cgroups are kept with cgroup_t label.
>
> Signed-off-by: Antonio Murdaca <runcom@redhat.com>
> ---
> Changes in v2:
>   - whitelist cgroup2 fs type
>
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into selinux/next, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3b955c6..2789f0a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -480,6 +480,8 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>                 sbsec->behavior == SECURITY_FS_USE_NATIVE ||
>                 /* Special handling. Genfs but also in-core setxattr handler */
>                 !strcmp(sb->s_type->name, "sysfs") ||
> +               !strcmp(sb->s_type->name, "cgroup") ||
> +               !strcmp(sb->s_type->name, "cgroup2") ||
>                 !strcmp(sb->s_type->name, "pstore") ||
>                 !strcmp(sb->s_type->name, "debugfs") ||
>                 !strcmp(sb->s_type->name, "tracefs") ||
> --
> 2.9.3

-- 
paul moore
www.paul-moore.com
