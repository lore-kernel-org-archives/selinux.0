Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q62IhI0e023989
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2012 14:43:18 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q62IhFO1025439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2012 14:43:16 -0400
Message-ID: <1341254592.28275.11.camel@localhost>
Subject: Re: [RFC PATCH v1 2/2] selinux: redefine a port definition to
 include the IP address
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
Date: Mon, 02 Jul 2012 14:43:12 -0400
In-Reply-To: <20120629202941.9075.7670.stgit@sifl>
References: <20120629202934.9075.1212.stgit@sifl>
	 <20120629202941.9075.7670.stgit@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-06-29 at 16:29 -0400, Paul Moore wrote:
> [NOTE: this patch is very much a RFC patch intended to solicit
>  feedback on the approach; it will compile cleanly but I make no
>  claims about it actually producing a working kernel]
> 
> The current SELinux port definition does not include an IP address
> which makes it difficult to restrict connect() and bind() operations
> using SELinux.  As an example, how would you allow a process to
> bind() to 127.0.0.1:80 and not 0.0.0.0:80?
> 
> This patch fixes this by adding an IP address to the SELinux port
> definition via a SELinux node label.  Not only does this allow us to
> solve problems like the example above, it also brings the SELinux
> port definition in line with the actual usage of network ports;
> ports are always defined by the 3-tuple of address, protocol, and
> port.
> 
> It is important to note that this patch does bump the policy version
> number due to changes in how the network ports are defined in
> policy.  Existing policies should continue to work as they do now,
> with the network port access controls effectively ignoring the
> associated IP addresses.  An updated SELinux userspace will be
> needed to take advantage of this new functionality.
> 
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  security/selinux/hooks.c            |   11 ++-
>  security/selinux/include/netport.h  |    2 -
>  security/selinux/include/objsec.h   |    9 ++
>  security/selinux/include/security.h |    6 +-
>  security/selinux/netport.c          |   49 +++++++++++--
>  security/selinux/ss/policydb.c      |   28 ++++++--
>  security/selinux/ss/policydb.h      |    2 +
>  security/selinux/ss/services.c      |  128 ++++++++++++++++++++---------------
>  8 files changed, 155 insertions(+), 80 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 372ec65..746535d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3869,8 +3869,9 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  			inet_get_local_port_range(&low, &high);
>  
>  			if (snum < max(PROT_SOCK, low) || snum > high) {
> -				err = sel_netport_sid(sk->sk_protocol,
> -						      snum, &sid);
> +				err = sel_netport_sid(sk->sk_family, addrp,
> +						      sk->sk_protocol, snum,
> +						      &sid);
>  				if (err)
>  					goto out;
>  				ad.type = LSM_AUDIT_DATA_NET;
> @@ -3945,6 +3946,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
>  		struct lsm_network_audit net = {0,};
>  		struct sockaddr_in *addr4 = NULL;
>  		struct sockaddr_in6 *addr6 = NULL;
> +		char *addrp;
>  		unsigned short snum;
>  		u32 sid, perm;
>  
> @@ -3952,15 +3954,18 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
>  			addr4 = (struct sockaddr_in *)address;
>  			if (addrlen < sizeof(struct sockaddr_in))
>  				return -EINVAL;
> +			addrp = (char *)&addr4->sin_addr.s_addr;
>  			snum = ntohs(addr4->sin_port);
>  		} else {
>  			addr6 = (struct sockaddr_in6 *)address;
>  			if (addrlen < SIN6_LEN_RFC2133)
>  				return -EINVAL;
> +			addrp = (char *)&addr6->sin6_addr.s6_addr;
>  			snum = ntohs(addr6->sin6_port);
>  		}
>  
> -		err = sel_netport_sid(sk->sk_protocol, snum, &sid);
> +		err = sel_netport_sid(sk->sk_family, addrp,
> +				      sk->sk_protocol, snum, &sid);
>  		if (err)
>  			goto out;
>  
> diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
> index 4d965b8..26c55b1 100644
> --- a/security/selinux/include/netport.h
> +++ b/security/selinux/include/netport.h
> @@ -26,6 +26,6 @@
>  #ifndef _SELINUX_NETPORT_H
>  #define _SELINUX_NETPORT_H
>  
> -int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
> +int sel_netport_sid(u16 family, void *addrp, u8 protocol, u16 pnum, u32 *sid);
>  
>  #endif
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 26c7eee..6ca1484 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -89,9 +89,14 @@ struct netnode_security_struct {
>  };
>  
>  struct netport_security_struct {
> -	u32 sid;			/* SID for this node */
> -	u16 port;			/* port number */
> +	u16 family;
> +	union {
> +		__be32 ipv4;		/* IPv4 node address */
> +		struct in6_addr ipv6;	/* IPv6 node address */
> +	} addr;

Personally I think you need/want a netmask here.  Reasons below.

>  	u8 protocol;			/* transport protocol */
> +	u16 port;			/* port number */
> +	u32 sid;			/* SID for this port */
>  };
>  
>  struct sk_security_struct {
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 81c5838..57e7996 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -33,13 +33,14 @@
>  #define POLICYDB_VERSION_ROLETRANS	26
>  #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
>  #define POLICYDB_VERSION_DEFAULT_TYPE	28
> +#define POLICYDB_VERSION_PORTADDR	29
>  
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>  #else
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_DEFAULT_TYPE
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PORTADDR
>  #endif

You forgot to update the policydb_compat[] table.  (Yes it's dumb and
annoying and pointless and we should find a way to rip it out)

>  
>  /* Mask for just the mount related flags */
> @@ -140,7 +141,8 @@ int security_context_to_sid_force(const char *scontext, u32 scontext_len,
>  int security_get_user_sids(u32 callsid, char *username,
>  			   u32 **sids, u32 *nel);
>  
> -int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
> +int security_port_sid(u16 family, void *addrp, u8 protocol, u16 port,
> +		      u32 *out_sid);
>  
>  int security_netif_sid(char *name, u32 *if_sid);
>  
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index d353797..78c5bac 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -83,6 +83,8 @@ static unsigned int sel_netport_hashfn(u16 pnum)
>  
>  /**
>   * sel_netport_find - Search for a port record
> + * @family: address family
> + * @addrp: address pointer
>   * @protocol: protocol
>   * @port: pnum
>   *
> @@ -91,15 +93,28 @@ static unsigned int sel_netport_hashfn(u16 pnum)
>   * can not be found in the table return NULL.
>   *
>   */
> -static struct sel_netport *sel_netport_find(u8 protocol, u16 pnum)
> +static struct sel_netport *sel_netport_find(u16 family, void *addrp,
> +					    u8 protocol, u16 pnum)
>  {
>  	unsigned int idx;
>  	struct sel_netport *port;
>  
>  	idx = sel_netport_hashfn(pnum);
>  	list_for_each_entry_rcu(port, &sel_netport_hash[idx].list, list)
> -		if (port->psec.port == pnum && port->psec.protocol == protocol)
> -			return port;
> +		if (port->psec.port == pnum &&
> +		    port->psec.protocol == protocol &&
> +		    port->psec.family == family)
> +			switch (family) {
> +			case AF_INET:
> +				if (port->psec.addr.ipv4 == *(__be32 *)addrp)
> +					return port;
> +				break;
> +			case AF_INET6:
> +				if (ipv6_addr_equal(&port->psec.addr.ipv6,
> +						    addrp))
> +					return port;
> +				break;
> +			}

This is where you need the netmask.  So you don't need an entry for
every single ip address.  Explain more below.

>  
>  	return NULL;
>  }
> @@ -135,6 +150,8 @@ static void sel_netport_insert(struct sel_netport *port)
>  
>  /**
>   * sel_netport_sid_slow - Lookup the SID of a network address using the policy
> + * @family: address family
> + * @addrp: address pointer
>   * @protocol: protocol
>   * @pnum: port
>   * @sid: port SID
> @@ -145,14 +162,15 @@ static void sel_netport_insert(struct sel_netport *port)
>   * queries.  Returns zero on success, negative values on failure.
>   *
>   */
> -static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
> +static int sel_netport_sid_slow(u16 family, void *addrp, u8 protocol, u16 pnum,
> +				u32 *sid)
>  {
>  	int ret = -ENOMEM;
>  	struct sel_netport *port;
>  	struct sel_netport *new = NULL;
>  
>  	spin_lock_bh(&sel_netport_lock);
> -	port = sel_netport_find(protocol, pnum);
> +	port = sel_netport_find(family, addrp, protocol, pnum);

(assume we have a netnode of 10.1.1.1/24)  If we called once with the
address 10.1.1.1 and then next time look for 10.1.1.2 we won't have a
cache hit...

>  	if (port != NULL) {
>  		*sid = port->psec.sid;
>  		spin_unlock_bh(&sel_netport_lock);
> @@ -161,12 +179,21 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  	new = kzalloc(sizeof(*new), GFP_ATOMIC);
>  	if (new == NULL)
>  		goto out;
> -	ret = security_port_sid(protocol, pnum, sid);
> +	ret = security_port_sid(family, addrp, protocol, pnum, sid);

Here we do the lookup which ultimately ends up in security_node_ctx()
and it uses the mask, so we'll find both 10.1.1.1 and 10.1.1.2.  We need
to get that node information (addr/mask) back up the stack so we can use
it below....

>  	if (ret != 0)
>  		goto out;
>  
> -	new->psec.port = pnum;
> +	new->psec.family = family;
> +	switch (family) {
> +	case AF_INET:
> +		new->psec.addr.ipv4 = *(__be32 *)addrp;
> +		break;
> +	case AF_INET6:
> +		new->psec.addr.ipv6 = *(struct in6_addr *)addrp;
> +		break;
> +	}

Use the node addr/mask here which was somehow propogated up the stack
above, so we can find it later in the cache?

>  	new->psec.protocol = protocol;
> +	new->psec.port = pnum;
>  	new->psec.sid = *sid;
>  	sel_netport_insert(new);
>  
> @@ -183,6 +210,8 @@ out:
>  
>  /**
>   * sel_netport_sid - Lookup the SID of a network port
> + * @family: address family
> + * @addrp: address pointer
>   * @protocol: protocol
>   * @pnum: port
>   * @sid: port SID
> @@ -194,12 +223,12 @@ out:
>   * future queries.  Returns zero on success, negative values on failure.
>   *
>   */
> -int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
> +int sel_netport_sid(u16 family, void *addrp, u8 protocol, u16 pnum, u32 *sid)
>  {
>  	struct sel_netport *port;
>  
>  	rcu_read_lock();
> -	port = sel_netport_find(protocol, pnum);
> +	port = sel_netport_find(family, addrp, protocol, pnum);
>  	if (port != NULL) {
>  		*sid = port->psec.sid;
>  		rcu_read_unlock();
> @@ -207,7 +236,7 @@ int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
>  	}
>  	rcu_read_unlock();
>  
> -	return sel_netport_sid_slow(protocol, pnum, sid);
> +	return sel_netport_sid_slow(family, addrp, protocol, pnum, sid);
>  }
>  
>  /**
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 9cd9b7c..918c3bc 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2081,7 +2081,7 @@ out:
>  static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>  			 void *fp)
>  {
> -	int i, j, rc;
> +	int i, j, k, rc;
>  	u32 nel, len;
>  	__le32 buf[3];
>  	struct ocontext *l, *c;
> @@ -2147,7 +2147,19 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>  				c->u.port.protocol = le32_to_cpu(buf[0]);
>  				c->u.port.low_port = le32_to_cpu(buf[1]);
>  				c->u.port.high_port = le32_to_cpu(buf[2]);
> -				rc = context_read_and_validate(&c->context[0], p, fp);
> +				if (p->policyvers>=POLICYDB_VERSION_PORTADDR) {
> +					rc = next_entry(buf, fp, sizeof(u32));
> +					if (rc)
> +						goto out;
> +					c->u.port.node_present = 1;
> +					/* we only associate a node type with
> +					 * the port and not the full context
> +					 * so that we can define ports in
> +					 * policy modules */
> +					c->u.port.node_type=le32_to_cpu(buf[0]);
> +				}
> +				rc = context_read_and_validate(&c->context[0],
> +							       p, fp);

Please ignore 80 chars when it looks better to do so.

You are always reading a node type with the new policy version.  Fine.
But, what type is userspace supposed to set when people use the old
syntax portcon rules?  Do we need to make the node_present flag explicit
in the new policy version?  If so, we can make the node_type field
conditional to save just a tiny bit of space...

>  				if (rc)
>  					goto out;
>  				break;
> @@ -2185,9 +2197,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>  				if (rc)
>  					goto out;
>  				break;
> -			case OCON_NODE6: {
> -				int k;
> -
> +			case OCON_NODE6:
>  				rc = next_entry(nodebuf, fp, sizeof(u32) * 8);
>  				if (rc)
>  					goto out;
> @@ -2200,7 +2210,6 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>  					goto out;
>  				break;
>  			}
> -			}
>  		}
>  	}
>  	rc = 0;
> @@ -3064,6 +3073,13 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>  				rc = put_entry(buf, sizeof(u32), 3, fp);
>  				if (rc)
>  					return rc;
> +				if (p->policyvers>=POLICYDB_VERSION_PORTADDR) {
> +					/* see comments in ocontext_read() */
> +					buf[0]=cpu_to_le32(c->u.port.node_type);
> +					rc = put_entry(buf, sizeof(u32), 1, fp);
> +					if (rc)
> +						return rc;
> +				}
>  				rc = context_write(p, &c->context[0], fp);
>  				if (rc)
>  					return rc;
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index da63747..aa6da79 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -164,9 +164,11 @@ struct ocontext {
>  	union {
>  		char *name;	/* name of initial SID, fs, netif, fstype, path */
>  		struct {
> +			u8 node_present;
>  			u8 protocol;
>  			u16 low_port;
>  			u16 high_port;
> +			u32 node_type;
>  		} port;		/* TCP or UDP port information */
>  		struct {
>  			u32 addr;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e8fd07d..45932c5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1975,46 +1975,6 @@ size_t security_policydb_len(void)
>  }
>  
>  /**
> - * security_port_sid - Obtain the SID for a port.
> - * @protocol: protocol number
> - * @port: port number
> - * @out_sid: security identifier
> - */
> -int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
> -{
> -	struct ocontext *c;
> -	int rc = 0;
> -
> -	read_lock(&policy_rwlock);
> -
> -	c = policydb.ocontexts[OCON_PORT];
> -	while (c) {
> -		if (c->u.port.protocol == protocol &&
> -		    c->u.port.low_port <= port &&
> -		    c->u.port.high_port >= port)
> -			break;
> -		c = c->next;
> -	}
> -
> -	if (c) {
> -		if (!c->sid[0]) {
> -			rc = sidtab_context_to_sid(&sidtab,
> -						   &c->context[0],
> -						   &c->sid[0]);
> -			if (rc)
> -				goto out;
> -		}
> -		*out_sid = c->sid[0];
> -	} else {
> -		*out_sid = SECINITSID_PORT;
> -	}
> -
> -out:
> -	read_unlock(&policy_rwlock);
> -	return rc;
> -}
> -
> -/**
>   * security_netif_sid - Obtain the SID for a network interface.
>   * @name: interface name
>   * @if_sid: interface SID
> @@ -2069,44 +2029,100 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
>  }
>  
>  /**
> - * security_node_sid - Obtain the SID for a node (host).
> + * security_node_ctx - Obtain the context for a node (host).
>   * @family: address family
>   * @addrp: address
> - * @out_sid: security identifier
> + * 
> + * Must be called with the policy lock held.
>   */
> -int security_node_sid(u16 family, void *addrp, u32 *out_sid)
> +static struct ocontext *security_node_ctx(u16 family, void *addrp)
>  {
> -	int rc = 0;
> +	u32 addr;
>  	struct ocontext *c;
>  
> -	read_lock(&policy_rwlock);
> -
>  	switch (family) {
> -	case AF_INET: {
> -		u32 addr = *((u32 *)addrp);
> -
> +	case AF_INET:
> +		addr = *((u32 *)addrp);
>  		c = policydb.ocontexts[OCON_NODE];
>  		while (c) {
>  			if (c->u.node.addr == (addr & c->u.node.mask))
> -				break;
> +				return c;
>  			c = c->next;
>  		}
>  		break;
> -	}
> -
>  	case AF_INET6:
>  		c = policydb.ocontexts[OCON_NODE6];
>  		while (c) {
>  			if (match_ipv6_addrmask(addrp, c->u.node6.addr,
>  						c->u.node6.mask))
> -				break;
> +				return c;
>  			c = c->next;
>  		}
>  		break;
> +	}
>  
> -	default:
> +	return NULL;
> +}
> +
> +/**
> + * security_node_sid - Obtain the SID for a node (host).
> + * @family: address family
> + * @addrp: address
> + * @out_sid: security identifier
> + */
> +int security_node_sid(u16 family, void *addrp, u32 *out_sid)
> +{
> +	int rc = 0;
> +	struct ocontext *c;
> +
> +	read_lock(&policy_rwlock);
> +
> +	c = security_node_ctx(family, addrp);
> +	if (c) {
> +		if (!c->sid[0]) {
> +			rc = sidtab_context_to_sid(&sidtab,
> +						   &c->context[0],
> +						   &c->sid[0]);
> +			if (rc)
> +				goto out;
> +		}
> +		*out_sid = c->sid[0];
> +	} else
>  		*out_sid = SECINITSID_NODE;
> -		goto out;
> +
> +out:
> +	read_unlock(&policy_rwlock);
> +	return rc;
> +}
> +
> +/**
> + * security_port_sid - Obtain the SID for a port.
> + * @family : address family
> + * @addrp : address pointer
> + * @protocol: protocol number
> + * @port: port number
> + * @out_sid: security identifier
> + */
> +int security_port_sid(u16 family, void *addrp, u8 protocol, u16 port,
> +		      u32 *out_sid)
> +{
> +	int rc = 0;
> +	struct ocontext *c;
> +	struct ocontext *c_node;
> +
> +	read_lock(&policy_rwlock);
> +
> +	c_node = security_node_ctx(family, addrp);
> +	c = policydb.ocontexts[OCON_PORT];
> +	while (c) {
> +		/* see the comments in policydb.c about why we only compare
> +		 * node types and not the full context */
> +		if (c->u.port.protocol == protocol &&
> +		    c->u.port.low_port <= port && c->u.port.high_port >= port &&
> +		    (!c_node || !c->u.port.node_present ||
> +		     c->u.port.node_type == c_node->context[0].type))
> +				break;
> +		c = c->next;
>  	}
>  
>  	if (c) {
> @@ -2119,7 +2135,7 @@ int security_node_sid(u16 family, void *addrp, u32 *out_sid)
>  		}
>  		*out_sid = c->sid[0];
>  	} else
> -		*out_sid = SECINITSID_NODE;
> +		*out_sid = SECINITSID_PORT;
>  
>  out:
>  	read_unlock(&policy_rwlock);
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
