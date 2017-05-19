Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4JEtVMK023916
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 10:55:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id q24so344130lfb.1
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 07:55:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170518205831.25514-1-sds@tycho.nsa.gov>
References: <20170518205831.25514-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 May 2017 10:55:16 -0400
Message-ID: <CAHC9VhQ9SbEgQFWscEYW1aKQqGYdHxC9URTS4zdh04VykkDVNQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: log policy capability state when a policy is
 loaded
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 18, 2017 at 4:58 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Log the state of SELinux policy capabilities when a policy is loaded.
> For each policy capability known to the kernel, log the policy capability
> name and the value set in the policy.  For policy capabilities that are
> set in the loaded policy but unknown to the kernel, log the policy
> capability index, since this is the only information presently available
> in the policy.
>
> Sample output with a policy created with a new capability defined
> that is not known to the kernel:
> SELinux:  policy capability network_peer_controls=1
> SELinux:  policy capability open_perms=1
> SELinux:  policy capability extended_socket_class=1
> SELinux:  policy capability always_check_network=0
> SELinux:  policy capability cgroup_seclabel=0
> SELinux:  unknown policy capability 5
>
> Resolves: https://github.com/SELinuxProject/selinux-kernel/issues/32
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/include/security.h |  2 ++
>  security/selinux/selinuxfs.c        | 13 ++-----------
>  security/selinux/ss/services.c      | 23 +++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 11 deletions(-)

Applied, thanks Stephen.

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index f979c35..c4224bb 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -76,6 +76,8 @@ enum {
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>
> +extern char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
> +
>  extern int selinux_policycap_netpeer;
>  extern int selinux_policycap_openperm;
>  extern int selinux_policycap_extsockclass;
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ce71718..ea2da91 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -41,15 +41,6 @@
>  #include "objsec.h"
>  #include "conditional.h"
>
> -/* Policy capability filenames */
> -static char *policycap_names[] = {
> -       "network_peer_controls",
> -       "open_perms",
> -       "extended_socket_class",
> -       "always_check_network",
> -       "cgroup_seclabel"
> -};
> -
>  unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
>
>  static int __init checkreqprot_setup(char *str)
> @@ -1750,9 +1741,9 @@ static int sel_make_policycap(void)
>         sel_remove_entries(policycap_dir);
>
>         for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
> -               if (iter < ARRAY_SIZE(policycap_names))
> +               if (iter < ARRAY_SIZE(selinux_policycap_names))
>                         dentry = d_alloc_name(policycap_dir,
> -                                             policycap_names[iter]);
> +                                             selinux_policycap_names[iter]);
>                 else
>                         dentry = d_alloc_name(policycap_dir, "unknown");
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 60d9b02..2dccba4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -70,6 +70,15 @@
>  #include "ebitmap.h"
>  #include "audit.h"
>
> +/* Policy capability names */
> +char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
> +       "network_peer_controls",
> +       "open_perms",
> +       "extended_socket_class",
> +       "always_check_network",
> +       "cgroup_seclabel"
> +};
> +
>  int selinux_policycap_netpeer;
>  int selinux_policycap_openperm;
>  int selinux_policycap_extsockclass;
> @@ -1986,6 +1995,9 @@ static int convert_context(u32 key,
>
>  static void security_load_policycaps(void)
>  {
> +       unsigned int i;
> +       struct ebitmap_node *node;
> +
>         selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
>                                                   POLICYDB_CAPABILITY_NETPEER);
>         selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
> @@ -1997,6 +2009,17 @@ static void security_load_policycaps(void)
>         selinux_policycap_cgroupseclabel =
>                 ebitmap_get_bit(&policydb.policycaps,
>                                 POLICYDB_CAPABILITY_CGROUPSECLABEL);
> +
> +       for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
> +               pr_info("SELinux:  policy capability %s=%d\n",
> +                       selinux_policycap_names[i],
> +                       ebitmap_get_bit(&policydb.policycaps, i));
> +
> +       ebitmap_for_each_positive_bit(&policydb.policycaps, node, i) {
> +               if (i >= ARRAY_SIZE(selinux_policycap_names))
> +                       pr_info("SELinux:  unknown policy capability %u\n",
> +                               i);
> +       }
>  }
>
>  static int security_preserve_bools(struct policydb *p);
> --
> 2.9.3
>



-- 
paul moore
www.paul-moore.com
