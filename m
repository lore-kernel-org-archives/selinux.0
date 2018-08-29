Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7TGIlRo017413
 for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2018 12:18:47 -0400
To: Micah Morton <mortonm@chromium.org>, linux-security-module@vger.kernel.org
References: <20180828213217.67080-1-mortonm@chromium.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <797d811d-e7a1-aca8-2d8f-a1cf9def66fb@schaufler-ca.com>
Date: Wed, 29 Aug 2018 09:14:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180828213217.67080-1-mortonm@chromium.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] SELinux: allow other LSMs to use custom mount
 args
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/28/2018 2:32 PM, Micah Morton wrote:
> The security_sb_copy_data LSM hook allows LSMs to copy custom string
> name/value args passed to mount_fs() into a temporary buffer (called
> "secdata") that will be accessible to LSM code during the
> security_sb_kern_mount hook further down in mount_fs(). Currently,
> SELinux effectively prevents any other LSMs from copying custom mount
> args into the temporary buffer (and being able to access them during
> security_sb_kern_mount), as it will fail with -EINVAL and print
> "SELinux:  unknown mount option" to the kernel message buffer if args it
> doesn't recognize are present in the temporary buffer when
> selinux_sb_kern_mount is called. This change adds an arg to the list of
> those accepted by SELinux during security_sb_kern_mount. SELinux won't
> do anything with this arg besides allow the name/value pair to be passed
> along to any other LSM that is stacked after SELinux.
>
> Developed on v4.18.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

This needs to be generalized. Whatever security module you're
working on won't stack with any other module that uses mount
options, Smack in particular. Have you looked at the patch I've
been proposing as part of the general stacking work?

> ---
>  security/selinux/hooks.c            |  7 ++++++-
>  security/selinux/include/security.h | 11 ++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2b5ee5fbd652..e70ccc701eb8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -445,6 +445,7 @@ enum {
>  	Opt_rootcontext = 4,
>  	Opt_labelsupport = 5,
>  	Opt_nextmntopt = 6,
> +	Opt_lsm_custom_arg = 7,
>  };
>  
>  #define NUM_SEL_MNT_OPTS	(Opt_nextmntopt - 1)
> @@ -455,6 +456,7 @@ static const match_table_t tokens = {
>  	{Opt_defcontext, DEFCONTEXT_STR "%s"},
>  	{Opt_rootcontext, ROOTCONTEXT_STR "%s"},
>  	{Opt_labelsupport, LABELSUPP_STR},
> +	{Opt_lsm_custom_arg, LSM_CUSTOM_ARG_STR "%s"},
>  	{Opt_error, NULL},
>  };
>  
> @@ -1156,6 +1158,8 @@ static int selinux_parse_opts_str(char *options,
>  			break;
>  		case Opt_labelsupport:
>  			break;
> +		case Opt_lsm_custom_arg:
> +			break;
>  		default:
>  			rc = -EINVAL;
>  			printk(KERN_WARNING "SELinux:  unknown mount option\n");
> @@ -2758,7 +2762,8 @@ static inline int selinux_option(char *option, int len)
>  		match_prefix(FSCONTEXT_STR, sizeof(FSCONTEXT_STR)-1, option, len) ||
>  		match_prefix(DEFCONTEXT_STR, sizeof(DEFCONTEXT_STR)-1, option, len) ||
>  		match_prefix(ROOTCONTEXT_STR, sizeof(ROOTCONTEXT_STR)-1, option, len) ||
> -		match_prefix(LABELSUPP_STR, sizeof(LABELSUPP_STR)-1, option, len));
> +		match_prefix(LABELSUPP_STR, sizeof(LABELSUPP_STR)-1, option, len) ||
> +		match_prefix(LSM_CUSTOM_ARG_STR, sizeof(LSM_CUSTOM_ARG_STR)-1, option, len));
>  }
>  
>  static inline void take_option(char **to, char *from, int *first, int len)
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 23e762d529fa..0ead836a0625 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -59,11 +59,12 @@
>  #define SE_SBPROC		0x0200
>  #define SE_SBGENFS		0x0400
>  
> -#define CONTEXT_STR	"context="
> -#define FSCONTEXT_STR	"fscontext="
> -#define ROOTCONTEXT_STR	"rootcontext="
> -#define DEFCONTEXT_STR	"defcontext="
> -#define LABELSUPP_STR "seclabel"
> +#define CONTEXT_STR         "context="
> +#define FSCONTEXT_STR       "fscontext="
> +#define ROOTCONTEXT_STR     "rootcontext="
> +#define DEFCONTEXT_STR      "defcontext="
> +#define LABELSUPP_STR       "seclabel"
> +#define LSM_CUSTOM_ARG_STR  "lsm_custom_arg="
>  
>  struct netlbl_lsm_secattr;
>  
