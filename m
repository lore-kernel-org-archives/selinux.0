Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CBtJTb032291
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 07:55:22 -0400
Received: by mail-oi0-f46.google.com with SMTP id r203so28260681oib.3
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 04:55:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
From: Paul Moore <pmoore@redhat.com>
Date: Wed, 12 Apr 2017 07:55:16 -0400
Message-ID: <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, william.c.roberts@intel.com, serge@hallyn.com,
 james.l.morris@oracle.com, eparis@parisplace.org, sds@tycho.nsa.gov,
 paul@paul-moore.com, Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 12, 2017 at 5:06 AM, Sebastien Buisson
<sbuisson.ddn@gmail.com> wrote:
> Add selinux_is_enforced() function to give access to SELinux
> enforcement to the rest of the kernel.
>
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
>  include/linux/selinux.h             | 5 +++++
>  security/selinux/exports.c          | 6 ++++++
>  security/selinux/hooks.c            | 2 ++
>  security/selinux/include/avc.h      | 6 ------
>  security/selinux/include/security.h | 1 +
>  5 files changed, 14 insertions(+), 6 deletions(-)

As currently written this code isn't something we would want to merge
upstream for two important reasons:

* No clear user of this functionality.  There needs to be a well
defined user of this functionality in the kernel.

* No abstraction layer at the LSM interface.  The core kernel code
should not call directly into any specific LSM, all interaction should
go through the LSM hooks.

> diff --git a/include/linux/selinux.h b/include/linux/selinux.h
> index 44f4596..1007321 100644
> --- a/include/linux/selinux.h
> +++ b/include/linux/selinux.h
> @@ -24,12 +24,17 @@
>   * selinux_is_enabled - is SELinux enabled?
>   */
>  bool selinux_is_enabled(void);
> +bool selinux_is_enforced(void);
>  #else
>
>  static inline bool selinux_is_enabled(void)
>  {
>         return false;
>  }
> +static inline bool selinux_is_enforced(void)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_SECURITY_SELINUX */
>
>  #endif /* _LINUX_SELINUX_H */
> diff --git a/security/selinux/exports.c b/security/selinux/exports.c
> index e75dd94..016f1e2 100644
> --- a/security/selinux/exports.c
> +++ b/security/selinux/exports.c
> @@ -21,3 +21,9 @@ bool selinux_is_enabled(void)
>         return selinux_enabled;
>  }
>  EXPORT_SYMBOL_GPL(selinux_is_enabled);
> +
> +bool selinux_is_enforced(void)
> +{
> +       return selinux_enforcing;
> +}
> +EXPORT_SYMBOL_GPL(selinux_is_enforced);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..da2baeb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -109,6 +109,8 @@ static int __init enforcing_setup(char *str)
>         return 1;
>  }
>  __setup("enforcing=", enforcing_setup);
> +#else
> +int selinux_enforcing;
>  #endif
>
>  #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index 0999df0..ff98351 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -19,12 +19,6 @@
>  #include "av_permissions.h"
>  #include "security.h"
>
> -#ifdef CONFIG_SECURITY_SELINUX_DEVELOP
> -extern int selinux_enforcing;
> -#else
> -#define selinux_enforcing 1
> -#endif
> -
>  /*
>   * An entry in the AVC.
>   */
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index f979c35..1e67e268 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -64,6 +64,7 @@
>  struct netlbl_lsm_secattr;
>
>  extern int selinux_enabled;
> +extern int selinux_enforcing;
>
>  /* Policy capabilities */
>  enum {
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
paul moore
security @ redhat
