Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1SLmmLN009272
 for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2017 16:48:49 -0500
Received: by mail-ua0-f196.google.com with SMTP id j56so3526564uaa.3
 for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2017 13:48:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488296156-2169-1-git-send-email-sds@tycho.nsa.gov>
References: <1488296156-2169-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Feb 2017 16:48:46 -0500
Message-ID: <CAHC9VhSyr18-dOvSR0U6kszb14TJmYx9fBx+CL9a6+BGkdt1ow@mail.gmail.com>
Subject: Re: [PATCH] selinux: wrap cgroup seclabel support with its own policy
 capability
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: nnk@google.com, john.stultz@linaro.org, jeffv@google.com,
 amurdaca@redhat.com, selinux@tycho.nsa.gov, kernel-team@android.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Feb 28, 2017 at 10:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit 1ea0ce40690dff38935538e8dab7b12683ded0d3 ("selinux: allow
> changing labels for cgroupfs") broke the Android init program,
> which looks up security contexts whenever creating directories
> and attempts to assign them via setfscreatecon().
> When creating subdirectories in cgroup mounts, this would previously
> be ignored since cgroup did not support userspace setting of security
> contexts.  However, after the commit, SELinux would attempt to honor
> the requested context on cgroup directories and fail due to permission
> denial.  Avoid breaking existing userspace/policy by wrapping this change
> with a conditional on a new cgroup_seclabel policy capability.  This
> preserves existing behavior until/unless a new policy explicitly enables
> this capability.
>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c            | 7 ++++---
>  security/selinux/include/security.h | 2 ++
>  security/selinux/selinuxfs.c        | 3 ++-
>  security/selinux/ss/services.c      | 4 ++++
>  4 files changed, 12 insertions(+), 4 deletions(-)

Thanks for putting this together.

It all looks good to me, I've merged this into selinux/stable-4.11.
I'm building a test kernel right now, assuming all goes well I'll send
this up to James for v4.11.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9bc12bc..7163fed 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -480,12 +480,13 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>                 sbsec->behavior == SECURITY_FS_USE_NATIVE ||
>                 /* Special handling. Genfs but also in-core setxattr handler */
>                 !strcmp(sb->s_type->name, "sysfs") ||
> -               !strcmp(sb->s_type->name, "cgroup") ||
> -               !strcmp(sb->s_type->name, "cgroup2") ||
>                 !strcmp(sb->s_type->name, "pstore") ||
>                 !strcmp(sb->s_type->name, "debugfs") ||
>                 !strcmp(sb->s_type->name, "tracefs") ||
> -               !strcmp(sb->s_type->name, "rootfs");
> +               !strcmp(sb->s_type->name, "rootfs") ||
> +               (selinux_policycap_cgroupseclabel &&
> +                (!strcmp(sb->s_type->name, "cgroup") ||
> +                 !strcmp(sb->s_type->name, "cgroup2")));
>  }
>
>  static int sb_finish_set_opts(struct super_block *sb)
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index beaa14b..f979c35 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -71,6 +71,7 @@ enum {
>         POLICYDB_CAPABILITY_OPENPERM,
>         POLICYDB_CAPABILITY_EXTSOCKCLASS,
>         POLICYDB_CAPABILITY_ALWAYSNETWORK,
> +       POLICYDB_CAPABILITY_CGROUPSECLABEL,
>         __POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -79,6 +80,7 @@ extern int selinux_policycap_netpeer;
>  extern int selinux_policycap_openperm;
>  extern int selinux_policycap_extsockclass;
>  extern int selinux_policycap_alwaysnetwork;
> +extern int selinux_policycap_cgroupseclabel;
>
>  /*
>   * type_datum properties
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c354807..d850c76 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -46,7 +46,8 @@ static char *policycap_names[] = {
>         "network_peer_controls",
>         "open_perms",
>         "extended_socket_class",
> -       "always_check_network"
> +       "always_check_network",
> +       "cgroup_seclabel"
>  };
>
>  unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a70fcee..b4aa491 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -74,6 +74,7 @@ int selinux_policycap_netpeer;
>  int selinux_policycap_openperm;
>  int selinux_policycap_extsockclass;
>  int selinux_policycap_alwaysnetwork;
> +int selinux_policycap_cgroupseclabel;
>
>  static DEFINE_RWLOCK(policy_rwlock);
>
> @@ -1993,6 +1994,9 @@ static void security_load_policycaps(void)
>                                           POLICYDB_CAPABILITY_EXTSOCKCLASS);
>         selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
>                                                   POLICYDB_CAPABILITY_ALWAYSNETWORK);
> +       selinux_policycap_cgroupseclabel =
> +               ebitmap_get_bit(&policydb.policycaps,
> +                               POLICYDB_CAPABILITY_CGROUPSECLABEL);
>  }
>
>  static int security_preserve_bools(struct policydb *p);
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
