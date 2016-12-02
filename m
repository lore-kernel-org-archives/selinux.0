Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
To: selinux@tycho.nsa.gov
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d6892b99-64b8-838e-f024-aeacb35df6e1@tycho.nsa.gov>
Date: Fri, 2 Dec 2016 12:40:15 -0500
MIME-Version: 1.0
In-Reply-To: <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/01/2016 10:57 AM, Stephen Smalley wrote:
> On 12/01/2016 10:07 AM, Stephen Smalley wrote:
>> Extend SELinux to support distinctions among all network address families
>> implemented by the kernel by defining new socket security classes
>> and mapping to them. Otherwise, many sockets are mapped to the generic
>> socket class and are indistinguishable in policy.  This has come up
>> previously with regard to selectively allowing access to bluetooth sockets,
>> and more recently with regard to selectively allowing access to AF_ALG
>> sockets.  Guido Trentalancia submitted a patch that took a similar approach
>> to add only support for distinguishing AF_ALG sockets, but this generalizes
>> his approach to handle all address families implemented by the kernel.
>> Socket security classes were not defined for AF_* values that are reserved
>> but unimplemented in the kernel, e.g. AF_NETBEUI, AF_SECURITY, AF_ECONET,
>> AF_SNA, AF_WANPIPE.
>>
>> Backward compatibility is provided by only enabling the finer-grained
>> socket classes if a new policy capability is set in the policy; older
>> policies will behave as before.  The legacy redhat1 policy capability
>> that was only ever used in testing within Fedora for ptrace_child
>> is reclaimed for this purpose; as far as I can tell, this policy
>> capability is not enabled in any supported distro policy.
>>
>> Add a pair of conditional compilation guards to detect when new AF_* values
>> are added so that we can update SELinux accordingly rather than having to
>> belatedly update it long after new address families are introduced.
> 
> A couple of notes on this change:
> 
> - To fully test (beyond just confirming that it doesn't break anything
> when the policy capability is not defined), we'll need a patched
> libsepol and policy (and unfortunately it requires patching the base
> policy; can't be done via a policy module).  Can certainly provide those
> too but figured I'd wait to see the response to the kernel patch first.
> 
> - There is a potential cost to this change when/if it is enabled in
> policy, i.e. if we blindly allowing all of these new classes where we
> previously allowed the generic socket class, we'll end up with
> significant growth in policy avtab entries and in AVC entries (although
> only if they are in fact used), since those are per-class.  However, I
> wouldn't expect to do that except possibly for the unconfined domain;
> many of these classes won't need to be allowed at all for most domains.
> 
> - There is a slight compatibility issue.  While the policy capability
> ensures that we will not use the new socket classes with old policies,
> we don't presently support a way to refresh socket security classes upon
> a policy reload.  Hence, if you boot a kernel with a policy that has the
> capability disabled, and then later load a policy that has the
> capability enabled, any existing sockets won't be automatically moved
> into the new security classes; they will continue to be treated as
> having the generic socket security class.  I view this as a minor issue
> and unlikely to cause any breakage, because refpolicy is likely to
> merely add new rules for the new socket classes without removing the old
> rules on the generic socket security class to provide backward
> compatibility with kernels that predate this change.  Eventually we may
> be able to drop those rules, but not for quite some time.  In any event,
> be aware that taking full advantage of these new classes does require a
> reboot.

I suppose a further question on this patch is whether it should also add
new classes for ICMP, IGMP, and SCTP sockets (any others that are
presently mapped to SECCLASS_RAWIP_SOCKET that ought to be given their
own class?).  In the SCTP case, this would at least allow them to be
distinguished, but we would still lack the full support added by the
separate SCTP patchset.

> 
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  security/selinux/hooks.c            | 67 +++++++++++++++++++++++++++++++++++++
>>  security/selinux/include/classmap.h | 62 ++++++++++++++++++++++++++++++++++
>>  security/selinux/include/security.h |  3 +-
>>  security/selinux/selinuxfs.c        |  2 +-
>>  security/selinux/ss/services.c      |  3 ++
>>  5 files changed, 135 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 98a2e92..1ee2172 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -1342,6 +1342,73 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
>>  		return SECCLASS_APPLETALK_SOCKET;
>>  	}
>>  
>> +	if (!selinux_policycap_extsockclass)
>> +		return SECCLASS_SOCKET;
>> +
>> +	switch (family) {
>> +	case PF_AX25:
>> +		return SECCLASS_AX25_SOCKET;
>> +	case PF_IPX:
>> +		return SECCLASS_IPX_SOCKET;
>> +	case PF_NETROM:
>> +		return SECCLASS_NETROM_SOCKET;
>> +	case PF_BRIDGE:
>> +		return SECCLASS_BRIDGE_SOCKET;
>> +	case PF_ATMPVC:
>> +		return SECCLASS_ATMPVC_SOCKET;
>> +	case PF_X25:
>> +		return SECCLASS_X25_SOCKET;
>> +	case PF_ROSE:
>> +		return SECCLASS_ROSE_SOCKET;
>> +	case PF_DECnet:
>> +		return SECCLASS_DECNET_SOCKET;
>> +	case PF_ATMSVC:
>> +		return SECCLASS_ATMSVC_SOCKET;
>> +	case PF_RDS:
>> +		return SECCLASS_RDS_SOCKET;
>> +	case PF_IRDA:
>> +		return SECCLASS_IRDA_SOCKET;
>> +	case PF_PPPOX:
>> +		return SECCLASS_PPPOX_SOCKET;
>> +	case PF_LLC:
>> +		return SECCLASS_LLC_SOCKET;
>> +	case PF_IB:
>> +		return SECCLASS_IB_SOCKET;
>> +	case PF_MPLS:
>> +		return SECCLASS_MPLS_SOCKET;
>> +	case PF_CAN:
>> +		return SECCLASS_CAN_SOCKET;
>> +	case PF_TIPC:
>> +		return SECCLASS_TIPC_SOCKET;
>> +	case PF_BLUETOOTH:
>> +		return SECCLASS_BLUETOOTH_SOCKET;
>> +	case PF_IUCV:
>> +		return SECCLASS_IUCV_SOCKET;
>> +	case PF_RXRPC:
>> +		return SECCLASS_RXRPC_SOCKET;
>> +	case PF_ISDN:
>> +		return SECCLASS_ISDN_SOCKET;
>> +	case PF_PHONET:
>> +		return SECCLASS_PHONET_SOCKET;
>> +	case PF_IEEE802154:
>> +		return SECCLASS_IEEE802154_SOCKET;
>> +	case PF_CAIF:
>> +		return SECCLASS_CAIF_SOCKET;
>> +	case PF_ALG:
>> +		return SECCLASS_ALG_SOCKET;
>> +	case PF_NFC:
>> +		return SECCLASS_NFC_SOCKET;
>> +	case PF_VSOCK:
>> +		return SECCLASS_VSOCK_SOCKET;
>> +	case PF_KCM:
>> +		return SECCLASS_KCM_SOCKET;
>> +	case PF_QIPCRTR:
>> +		return SECCLASS_QIPCRTR_SOCKET;
>> +#if PF_MAX > 43
>> +#error New address family defined, please update this function.
>> +#endif
>> +	}
>> +
>>  	return SECCLASS_SOCKET;
>>  }
>>  
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>> index e2d4ad3a..a11be76 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -169,5 +169,67 @@ struct security_class_mapping secclass_map[] = {
>>  	  { COMMON_CAP_PERMS, NULL } },
>>  	{ "cap2_userns",
>>  	  { COMMON_CAP2_PERMS, NULL } },
>> +	{ "ax25_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "ipx_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "netrom_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "bridge_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "atmpvc_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "x25_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "rose_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "decnet_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "atmsvc_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "rds_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "irda_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "pppox_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "llc_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "ib_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "mpls_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "can_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "tipc_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "bluetooth_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "iucv_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "rxrpc_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "isdn_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "phonet_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "ieee802154_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "caif_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "alg_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "nfc_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "vsock_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "kcm_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>> +	{ "qipcrtr_socket",
>> +	  { COMMON_SOCK_PERMS, NULL } },
>>  	{ NULL }
>>    };
>> +
>> +#if PF_MAX > 43
>> +#error New address family defined, please update secclass_map.
>> +#endif
>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>> index 308a286..beaa14b 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>> @@ -69,7 +69,7 @@ extern int selinux_enabled;
>>  enum {
>>  	POLICYDB_CAPABILITY_NETPEER,
>>  	POLICYDB_CAPABILITY_OPENPERM,
>> -	POLICYDB_CAPABILITY_REDHAT1,
>> +	POLICYDB_CAPABILITY_EXTSOCKCLASS,
>>  	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>  	__POLICYDB_CAPABILITY_MAX
>>  };
>> @@ -77,6 +77,7 @@ enum {
>>  
>>  extern int selinux_policycap_netpeer;
>>  extern int selinux_policycap_openperm;
>> +extern int selinux_policycap_extsockclass;
>>  extern int selinux_policycap_alwaysnetwork;
>>  
>>  /*
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index cf9293e..0aac402 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@ -45,7 +45,7 @@
>>  static char *policycap_names[] = {
>>  	"network_peer_controls",
>>  	"open_perms",
>> -	"redhat1",
>> +	"extended_socket_class",
>>  	"always_check_network"
>>  };
>>  
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 082b20c..a70fcee 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -72,6 +72,7 @@
>>  
>>  int selinux_policycap_netpeer;
>>  int selinux_policycap_openperm;
>> +int selinux_policycap_extsockclass;
>>  int selinux_policycap_alwaysnetwork;
>>  
>>  static DEFINE_RWLOCK(policy_rwlock);
>> @@ -1988,6 +1989,8 @@ static void security_load_policycaps(void)
>>  						  POLICYDB_CAPABILITY_NETPEER);
>>  	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
>>  						  POLICYDB_CAPABILITY_OPENPERM);
>> +	selinux_policycap_extsockclass = ebitmap_get_bit(&policydb.policycaps,
>> +					  POLICYDB_CAPABILITY_EXTSOCKCLASS);
>>  	selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
>>  						  POLICYDB_CAPABILITY_ALWAYSNETWORK);
>>  }
>>
> 
