Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2AK17BO029776
 for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2017 15:01:07 -0500
Received: by mail-ua0-f196.google.com with SMTP id 72so15442319uaf.1
 for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2017 12:01:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209155823.22148-1-runcom@redhat.com>
References: <20170209155823.22148-1-runcom@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Mar 2017 15:01:04 -0500
Message-ID: <CAHC9VhSL3ZS3R2r39+qzYmvU1=8-jC2nzqkXNQ0Yk3+okKd7jw@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for cgroupfs
To: Antonio Murdaca <amurdaca@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, vgoyal@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 9, 2017 at 10:58 AM, Antonio Murdaca <amurdaca@redhat.com> wrote:
> This patch allows genfscon per-file labeling for cgroupfs. For instance,
> this allows to label the "release_agent" file within each
> cgroup mount and limit writes to it.
>
> Signed-off-by: Antonio Murdaca <runcom@redhat.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

Now that the merge window is behind us, let's get this merged, but
could you update it to use the selinux_policycap_cgroupseclabel policy
capability?  See 2651225b5ebcdde ("selinux: wrap cgroup seclabel
support with its own policy capability") for more information.

Also, how goes the testing?

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
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

-- 
paul moore
www.paul-moore.com
