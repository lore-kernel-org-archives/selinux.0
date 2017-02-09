Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v19GEUmw015501
 for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2017 11:14:30 -0500
Received: by mail-ua0-f194.google.com with SMTP id f2so718270uaf.3
 for <selinux@tycho.nsa.gov>; Thu, 09 Feb 2017 08:14:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209160242.23405-1-amurdaca@redhat.com>
References: <20170209160242.23405-1-amurdaca@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Feb 2017 11:14:05 -0500
Message-ID: <CAHC9VhRFxDuRJHYEuRs7kc4ivgaT=-SxdU-o5Lq7H-O+5JJRxQ@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for cgroupfs
To: Antonio Murdaca <amurdaca@redhat.com>
Cc: selinux@tycho.nsa.gov, Antonio Murdaca <runcom@redhat.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, vgoyal@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 9, 2017 at 11:02 AM, Antonio Murdaca <amurdaca@redhat.com> wrote:
> From: Antonio Murdaca <runcom@redhat.com>
>
> This patch allows genfscon per-file labeling for cgroupfs. For instance,
> this allows to label the "release_agent" file within each
> cgroup mount and limit writes to it.
>
> Signed-off-by: Antonio Murdaca <amurdaca@redhat.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

This was already merged ... ?

* https://marc.info/?l=selinux&m=148652458620202&w=2

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9a8f12f..5a3138e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -808,6 +808,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>
>         if (!strcmp(sb->s_type->name, "debugfs") ||
>             !strcmp(sb->s_type->name, "sysfs") ||
> +           !strcmp(sb->s_type->name, "cgroup") ||
> +           !strcmp(sb->s_type->name, "cgroup2") ||
>             !strcmp(sb->s_type->name, "pstore"))
>                 sbsec->flags |= SE_SBGENFS;
>
> --
> 2.9.3

-- 
paul moore
www.paul-moore.com
