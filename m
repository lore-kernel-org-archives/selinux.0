Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB1H4Yt0007157
 for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2016 12:04:36 -0500
Message-ID: <1480611867.4558.18.camel@trentalancia.net>
Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
From: Guido Trentalancia <guido@trentalancia.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Thu, 01 Dec 2016 18:04:27 +0100
In-Reply-To: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello Stephen.

Glad to hear that this is making its way into the kernel !

On Thu, 01/12/2016 at 10.07 -0500, Stephen Smalley wrote:
> Extend SELinux to support distinctions among all network address
> families
> implemented by the kernel by defining new socket security classes
> and mapping to them. Otherwise, many sockets are mapped to the
> generic
> socket class and are indistinguishable in policy.  This has come up
> previously with regard to selectively allowing access to bluetooth
> sockets,
> and more recently with regard to selectively allowing access to
> AF_ALG
> sockets.  Guido Trentalancia submitted a patch that took a similar
> approach
> to add only support for distinguishing AF_ALG sockets, but this
> generalizes
> his approach to handle all address families implemented by the
> kernel.
> Socket security classes were not defined for AF_* values that are
> reserved
> but unimplemented in the kernel, e.g. AF_NETBEUI, AF_SECURITY,
> AF_ECONET,
> AF_SNA, AF_WANPIPE.
> 
> Backward compatibility is provided by only enabling the finer-grained
> socket classes if a new policy capability is set in the policy; older
> policies will behave as before.  The legacy redhat1 policy capability
> that was only ever used in testing within Fedora for ptrace_child
> is reclaimed for this purpose; as far as I can tell, this policy
> capability is not enabled in any supported distro policy.
> 
> Add a pair of conditional compilation guards to detect when new AF_*
> values
> are added so that we can update SELinux accordingly rather than
> having to
> belatedly update it long after new address families are introduced.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c            | 67
> +++++++++++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h | 62
> ++++++++++++++++++++++++++++++++++
>  security/selinux/include/security.h |  3 +-
>  security/selinux/selinuxfs.c        |  2 +-
>  security/selinux/ss/services.c      |  3 ++
>  5 files changed, 135 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 98a2e92..1ee2172 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1342,6 +1342,73 @@ static inline u16
> socket_type_to_security_class(int family, int type, int protoc
>  		return SECCLASS_APPLETALK_SOCKET;
>  	}
>  
> +	if (!selinux_policycap_extsockclass)
> +		return SECCLASS_SOCKET;
> +

The only suggestion I have to make is that, in my opinion, it might
read better and it might be easier to maintain in the future, if the
above is rewritten as follows:

if (selinux_policycap_extsockclass) {
	switch (family) {
		...
	}
}

and the return statement at the end of the function is retained.

That way, it is possible to easily add other similar policy
capabilities in the future, by just plugging in similar if statements !

Other than that, it looks fine to me and I have no other suggestions to
make about this patch.

> +	switch (family) {
> +	case PF_AX25:
> +		return SECCLASS_AX25_SOCKET;
> +	case PF_IPX:
> +		return SECCLASS_IPX_SOCKET;
> +	case PF_NETROM:
> +		return SECCLASS_NETROM_SOCKET;
> +	case PF_BRIDGE:
> +		return SECCLASS_BRIDGE_SOCKET;
> +	case PF_ATMPVC:
> +		return SECCLASS_ATMPVC_SOCKET;
> +	case PF_X25:
> +		return SECCLASS_X25_SOCKET;
> +	case PF_ROSE:
> +		return SECCLASS_ROSE_SOCKET;
> +	case PF_DECnet:
> +		return SECCLASS_DECNET_SOCKET;
> +	case PF_ATMSVC:
> +		return SECCLASS_ATMSVC_SOCKET;
> +	case PF_RDS:
> +		return SECCLASS_RDS_SOCKET;
> +	case PF_IRDA:
> +		return SECCLASS_IRDA_SOCKET;
> +	case PF_PPPOX:
> +		return SECCLASS_PPPOX_SOCKET;
> +	case PF_LLC:
> +		return SECCLASS_LLC_SOCKET;
> +	case PF_IB:
> +		return SECCLASS_IB_SOCKET;
> +	case PF_MPLS:
> +		return SECCLASS_MPLS_SOCKET;
> +	case PF_CAN:
> +		return SECCLASS_CAN_SOCKET;
> +	case PF_TIPC:
> +		return SECCLASS_TIPC_SOCKET;
> +	case PF_BLUETOOTH:
> +		return SECCLASS_BLUETOOTH_SOCKET;
> +	case PF_IUCV:
> +		return SECCLASS_IUCV_SOCKET;
> +	case PF_RXRPC:
> +		return SECCLASS_RXRPC_SOCKET;
> +	case PF_ISDN:
> +		return SECCLASS_ISDN_SOCKET;
> +	case PF_PHONET:
> +		return SECCLASS_PHONET_SOCKET;
> +	case PF_IEEE802154:
> +		return SECCLASS_IEEE802154_SOCKET;
> +	case PF_CAIF:
> +		return SECCLASS_CAIF_SOCKET;
> +	case PF_ALG:
> +		return SECCLASS_ALG_SOCKET;
> +	case PF_NFC:
> +		return SECCLASS_NFC_SOCKET;
> +	case PF_VSOCK:
> +		return SECCLASS_VSOCK_SOCKET;
> +	case PF_KCM:
> +		return SECCLASS_KCM_SOCKET;
> +	case PF_QIPCRTR:
> +		return SECCLASS_QIPCRTR_SOCKET;
> +#if PF_MAX > 43
> +#error New address family defined, please update this function.
> +#endif
> +	}
> +
>  	return SECCLASS_SOCKET;
>  }
>  
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h
> index e2d4ad3a..a11be76 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -169,5 +169,67 @@ struct security_class_mapping secclass_map[] = {
>  	  { COMMON_CAP_PERMS, NULL } },
>  	{ "cap2_userns",
>  	  { COMMON_CAP2_PERMS, NULL } },
> +	{ "ax25_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "ipx_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "netrom_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "bridge_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "atmpvc_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "x25_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "rose_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "decnet_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "atmsvc_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "rds_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "irda_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "pppox_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "llc_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "ib_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "mpls_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "can_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "tipc_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "bluetooth_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "iucv_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "rxrpc_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "isdn_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "phonet_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "ieee802154_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "caif_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "alg_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "nfc_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "vsock_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "kcm_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "qipcrtr_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
>  	{ NULL }
>    };
> +
> +#if PF_MAX > 43
> +#error New address family defined, please update secclass_map.
> +#endif
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h
> index 308a286..beaa14b 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -69,7 +69,7 @@ extern int selinux_enabled;
>  enum {
>  	POLICYDB_CAPABILITY_NETPEER,
>  	POLICYDB_CAPABILITY_OPENPERM,
> -	POLICYDB_CAPABILITY_REDHAT1,
> +	POLICYDB_CAPABILITY_EXTSOCKCLASS,
>  	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>  	__POLICYDB_CAPABILITY_MAX
>  };
> @@ -77,6 +77,7 @@ enum {
>  
>  extern int selinux_policycap_netpeer;
>  extern int selinux_policycap_openperm;
> +extern int selinux_policycap_extsockclass;
>  extern int selinux_policycap_alwaysnetwork;
>  
>  /*
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index cf9293e..0aac402 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -45,7 +45,7 @@
>  static char *policycap_names[] = {
>  	"network_peer_controls",
>  	"open_perms",
> -	"redhat1",
> +	"extended_socket_class",
>  	"always_check_network"
>  };
>  
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 082b20c..a70fcee 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -72,6 +72,7 @@
>  
>  int selinux_policycap_netpeer;
>  int selinux_policycap_openperm;
> +int selinux_policycap_extsockclass;
>  int selinux_policycap_alwaysnetwork;
>  
>  static DEFINE_RWLOCK(policy_rwlock);
> @@ -1988,6 +1989,8 @@ static void security_load_policycaps(void)
>  						  POLICYDB_CAPABILIT
> Y_NETPEER);
>  	selinux_policycap_openperm =
> ebitmap_get_bit(&policydb.policycaps,
>  						  POLICYDB_CAPABILIT
> Y_OPENPERM);
> +	selinux_policycap_extsockclass =
> ebitmap_get_bit(&policydb.policycaps,
> +					  POLICYDB_CAPABILITY_EXTSOC
> KCLASS);
>  	selinux_policycap_alwaysnetwork =
> ebitmap_get_bit(&policydb.policycaps,
>  						  POLICYDB_CAPABILIT
> Y_ALWAYSNETWORK);
>  }

With kind regards,

Guido
