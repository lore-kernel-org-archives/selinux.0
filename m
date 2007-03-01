Subject: Re: [RFC] SELinux: move security_skb_extlbl_sid() out of the
	security server
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20070301173459.128882191@hp.com>
References: <20070301173459.128882191@hp.com>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 13:44:09 -0500
Message-Id: <1172774649.19041.582.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-01 at 12:34 -0500, Paul Moore wrote:
> plain text document attachment (selinux-skbextlbl_move)
> As suggested, move the security_skb_extlbl_sid() function out of the security
> server and into the SELinux hooks file.

Thanks, but one minor change suggested - rename the function, as
security_ prefix in selinux means security server (which in turn is
confusing since LSM also uses that prefix, but we had it first!).  Since
it is static, you don't even need distinct namespace for it, so even
skb_extlbl_sid() is fine.

> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  security/selinux/hooks.c            |   28 ++++++++++++++++++++++++++++
>  security/selinux/include/security.h |    3 ---
>  security/selinux/ss/services.c      |   27 ---------------------------
>  3 files changed, 28 insertions(+), 30 deletions(-)
> 
> Index: net-2.6_future_2/security/selinux/hooks.c
> ===================================================================
> --- net-2.6_future_2.orig/security/selinux/hooks.c
> +++ net-2.6_future_2/security/selinux/hooks.c
> @@ -3123,6 +3123,34 @@ static int selinux_parse_skb(struct sk_b
>  	return ret;
>  }
>  
> +/**
> + * security_skb_extlbl_sid - Determine the external label of a packet
> + * @skb: the packet
> + * @base_sid: the SELinux SID to use as a context for MLS only external labels
> + * @sid: the packet's SID
> + *
> + * Description:
> + * Check the various different forms of external packet labeling and determine
> + * the external SID for the packet.
> + *
> + */
> +static void security_skb_extlbl_sid(struct sk_buff *skb,
> +				    u32 base_sid,
> +				    u32 *sid)
> +{
> +	u32 xfrm_sid;
> +	u32 nlbl_sid;
> +
> +	selinux_skb_xfrm_sid(skb, &xfrm_sid);
> +	if (selinux_netlbl_skbuff_getsid(skb,
> +					 (xfrm_sid == SECSID_NULL ?
> +					  base_sid : xfrm_sid),
> +					 &nlbl_sid) != 0)
> +		nlbl_sid = SECSID_NULL;
> +
> +	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
> +}
> +
>  /* socket security operations */
>  static int socket_has_perm(struct task_struct *task, struct socket *sock,
>  			   u32 perms)
> Index: net-2.6_future_2/security/selinux/include/security.h
> ===================================================================
> --- net-2.6_future_2.orig/security/selinux/include/security.h
> +++ net-2.6_future_2/security/selinux/include/security.h
> @@ -34,7 +34,6 @@
>  #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
>  #endif
>  
> -struct sk_buff;
>  struct netlbl_lsm_secattr;
>  
>  extern int selinux_enabled;
> @@ -83,8 +82,6 @@ int security_netif_sid(char *name, u32 *
>  int security_node_sid(u16 domain, void *addr, u32 addrlen,
>  	u32 *out_sid);
>  
> -void security_skb_extlbl_sid(struct sk_buff *skb, u32 base_sid, u32 *sid);
> -
>  int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>                                   u16 tclass);
>  
> Index: net-2.6_future_2/security/selinux/ss/services.c
> ===================================================================
> --- net-2.6_future_2.orig/security/selinux/ss/services.c
> +++ net-2.6_future_2/security/selinux/ss/services.c
> @@ -39,7 +39,6 @@
>  #include <linux/sched.h>
>  #include <linux/audit.h>
>  #include <linux/mutex.h>
> -#include <net/sock.h>
>  #include <net/netlabel.h>
>  
>  #include "flask.h"
> @@ -2198,32 +2197,6 @@ void selinux_audit_set_callback(int (*ca
>  	aurule_callback = callback;
>  }
>  
> -/**
> - * security_skb_extlbl_sid - Determine the external label of a packet
> - * @skb: the packet
> - * @base_sid: the SELinux SID to use as a context for MLS only external labels
> - * @sid: the packet's SID
> - *
> - * Description:
> - * Check the various different forms of external packet labeling and determine
> - * the external SID for the packet.
> - *
> - */
> -void security_skb_extlbl_sid(struct sk_buff *skb, u32 base_sid, u32 *sid)
> -{
> -	u32 xfrm_sid;
> -	u32 nlbl_sid;
> -
> -	selinux_skb_xfrm_sid(skb, &xfrm_sid);
> -	if (selinux_netlbl_skbuff_getsid(skb,
> -					 (xfrm_sid == SECSID_NULL ?
> -					  base_sid : xfrm_sid),
> -					 &nlbl_sid) != 0)
> -		nlbl_sid = SECSID_NULL;
> -
> -	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
> -}
> -
>  #ifdef CONFIG_NETLABEL
>  /*
>   * NetLabel cache structure
> 
> --
> paul moore
> linux security @ hp
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
