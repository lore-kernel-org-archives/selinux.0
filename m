Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LFPWgt018775
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 11:25:32 -0400
Received: by qkgx75 with SMTP id x75so57449280qkg.1
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 08:25:31 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: update netlink socket classes
Date: Thu, 21 May 2015 11:25:29 -0400
Message-ID: <2037655.VryGQaUhyt@sifl>
In-Reply-To: <1432134714-7655-1-git-send-email-sds@tycho.nsa.gov>
References: <1432134714-7655-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, May 20, 2015 11:11:54 AM Stephen Smalley wrote:
> Update the set of SELinux netlink socket class definitions to match
> the set of netlink protocols implemented by the kernel.  The
> ip_queue implementation for the NETLINK_FIREWALL and NETLINK_IP6_FW
> protocols was removed in d16cf20e2f2f13411eece7f7fb72c17d141c4a84, so we
> can remove the corresponding class definitions as this is dead code.  Add
> new classes for NETLINK_ISCSI, NETLINK_FIB_LOOKUP, NETLINK_CONNECTOR,
> NETLINK_NETFILTER, NETLINK_GENERIC, NETLINK_SCSITRANSPORT, NETLINK_RDMA,
> and NETLINK_CRYPTO so that we can distinguish among sockets created
> for each of these protocols.  This change does not define the finer-grained
> nlsmsg_read/write permissions or map specific nlmsg_type values to those
> permissions in the SELinux nlmsgtab; if finer-grained control of these
> sockets is desired/required, that can be added as a follow-on change.
> We do not define a SELinux class for NETLINK_ECRYPTFS as the implementation
> was removed in 624ae5284516870657505103ada531c64dba2a9a.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c            | 20 ++++++++++++++++----
>  security/selinux/include/classmap.h | 22 ++++++++++++++++------
>  2 files changed, 32 insertions(+), 10 deletions(-)

Applied, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7dade28..9ae4a8b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1188,8 +1188,6 @@ static inline u16 socket_type_to_security_class(int
> family, int type, int protoc switch (protocol) {
>  		case NETLINK_ROUTE:
>  			return SECCLASS_NETLINK_ROUTE_SOCKET;
> -		case NETLINK_FIREWALL:
> -			return SECCLASS_NETLINK_FIREWALL_SOCKET;
>  		case NETLINK_SOCK_DIAG:
>  			return SECCLASS_NETLINK_TCPDIAG_SOCKET;
>  		case NETLINK_NFLOG:
> @@ -1198,14 +1196,28 @@ static inline u16 socket_type_to_security_class(int
> family, int type, int protoc return SECCLASS_NETLINK_XFRM_SOCKET;
>  		case NETLINK_SELINUX:
>  			return SECCLASS_NETLINK_SELINUX_SOCKET;
> +		case NETLINK_ISCSI:
> +			return SECCLASS_NETLINK_ISCSI_SOCKET;
>  		case NETLINK_AUDIT:
>  			return SECCLASS_NETLINK_AUDIT_SOCKET;
> -		case NETLINK_IP6_FW:
> -			return SECCLASS_NETLINK_IP6FW_SOCKET;
> +		case NETLINK_FIB_LOOKUP:
> +			return SECCLASS_NETLINK_FIB_LOOKUP_SOCKET;
> +		case NETLINK_CONNECTOR:
> +			return SECCLASS_NETLINK_CONNECTOR_SOCKET;
> +		case NETLINK_NETFILTER:
> +			return SECCLASS_NETLINK_NETFILTER_SOCKET;
>  		case NETLINK_DNRTMSG:
>  			return SECCLASS_NETLINK_DNRT_SOCKET;
>  		case NETLINK_KOBJECT_UEVENT:
>  			return SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET;
> +		case NETLINK_GENERIC:
> +			return SECCLASS_NETLINK_GENERIC_SOCKET;
> +		case NETLINK_SCSITRANSPORT:
> +			return SECCLASS_NETLINK_SCSITRANSPORT_SOCKET;
> +		case NETLINK_RDMA:
> +			return SECCLASS_NETLINK_RDMA_SOCKET;
> +		case NETLINK_CRYPTO:
> +			return SECCLASS_NETLINK_CRYPTO_SOCKET;
>  		default:
>  			return SECCLASS_NETLINK_SOCKET;
>  		}
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h index eccd61b..1d8b924 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -107,9 +107,6 @@ struct security_class_mapping secclass_map[] = {
>  	{ "netlink_route_socket",
>  	  { COMMON_SOCK_PERMS,
>  	    "nlmsg_read", "nlmsg_write", NULL } },
> -	{ "netlink_firewall_socket",
> -	  { COMMON_SOCK_PERMS,
> -	    "nlmsg_read", "nlmsg_write", NULL } },
>  	{ "netlink_tcpdiag_socket",
>  	  { COMMON_SOCK_PERMS,
>  	    "nlmsg_read", "nlmsg_write", NULL } },
> @@ -120,19 +117,32 @@ struct security_class_mapping secclass_map[] = {
>  	    "nlmsg_read", "nlmsg_write", NULL } },
>  	{ "netlink_selinux_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netlink_iscsi_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "netlink_audit_socket",
>  	  { COMMON_SOCK_PERMS,
>  	    "nlmsg_read", "nlmsg_write", "nlmsg_relay", "nlmsg_readpriv",
>  	    "nlmsg_tty_audit", NULL } },
> -	{ "netlink_ip6fw_socket",
> -	  { COMMON_SOCK_PERMS,
> -	    "nlmsg_read", "nlmsg_write", NULL } },
> +	{ "netlink_fib_lookup_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netlink_connector_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netlink_netfilter_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "netlink_dnrt_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "association",
>  	  { "sendto", "recvfrom", "setcontext", "polmatch", NULL } },
>  	{ "netlink_kobject_uevent_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netlink_generic_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netlink_scsitransport_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netlink_rdma_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netlink_crypto_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "appletalk_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "packet",

-- 
paul moore
www.paul-moore.com
