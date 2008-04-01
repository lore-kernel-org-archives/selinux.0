Subject: Re: [PATCH 1/2] SELinux: turn mount options strings into defines
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1207070649.3556.15.camel@localhost.localdomain>
References: <1207070649.3556.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 13:28:23 -0400
Message-Id: <1207070903.5610.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-01 at 13:24 -0400, Eric Paris wrote:
> Convert the strings used for mount options into #defines rather than
> retyping the string throughout the SELinux code.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Possibly as a follow up, one could simplify or wrap the match_prefix()
interface to be a macro that only required the string to be specified
once to avoid inconsistency in the prefix and plen arguments.

> 
> ---
> 
> security/selinux/hooks.c            |   16 ++++++++--------
>  security/selinux/include/security.h |    5 +++++
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 41a049f..d6aa4a6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -324,10 +324,10 @@ enum {
>  };
>  
>  static match_table_t tokens = {
> -	{Opt_context, "context=%s"},
> -	{Opt_fscontext, "fscontext=%s"},
> -	{Opt_defcontext, "defcontext=%s"},
> -	{Opt_rootcontext, "rootcontext=%s"},
> +	{Opt_context, CONTEXT_STR "%s"},
> +	{Opt_fscontext, FSCONTEXT_STR "%s"},
> +	{Opt_defcontext, DEFCONTEXT_STR "%s"},
> +	{Opt_rootcontext, ROOTCONTEXT_STR "%s"},
>  	{Opt_error, NULL},
>  };
>  
> @@ -2232,10 +2232,10 @@ static inline int match_prefix(char *prefix, int plen, char *option, int olen)
>  
>  static inline int selinux_option(char *option, int len)
>  {
> -	return (match_prefix("context=", sizeof("context=")-1, option, len) ||
> -	        match_prefix("fscontext=", sizeof("fscontext=")-1, option, len) ||
> -	        match_prefix("defcontext=", sizeof("defcontext=")-1, option, len) ||
> -		match_prefix("rootcontext=", sizeof("rootcontext=")-1, option, len));
> +	return (match_prefix(CONTEXT_STR, sizeof(CONTEXT_STR)-1, option, len) ||
> +		match_prefix(FSCONTEXT_STR, sizeof(FSCONTEXT_STR)-1, option, len) ||
> +		match_prefix(DEFCONTEXT_STR, sizeof(DEFCONTEXT_STR)-1, option, len) ||
> +		match_prefix(ROOTCONTEXT_STR, sizeof(ROOTCONTEXT_STR)-1, option, len));
>  }
>  
>  static inline void take_option(char **to, char *from, int *first, int len)
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index f7d2f03..63e0171 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -40,6 +40,11 @@
>  #define ROOTCONTEXT_MNT	0x04
>  #define DEFCONTEXT_MNT	0x08
>  
> +#define CONTEXT_STR	"context="
> +#define FSCONTEXT_STR	"fscontext="
> +#define ROOTCONTEXT_STR	"rootcontext="
> +#define DEFCONTEXT_STR	"defcontext="
> +
>  struct netlbl_lsm_secattr;
>  
>  extern int selinux_enabled;
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
