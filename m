Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANIoNIi013717
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 13:50:23 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANIoPFP028252
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 18:50:26 GMT
Subject: Re: can_network patch.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <419CB2A8.7020504@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
Content-Type: text/plain
Message-Id: <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 23 Nov 2004 13:52:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am OK with what the changes do, but I would rather see a new macro
then to just remove the connect permission from can_network().

On the other hand, it looks like there is 119 uses of can_network() and
Dan is only adding 32 lines with connect permissions, so only 25% seem
to need the connect permisison.

Would anyone be upset if the functionality of can_network() changes?

Any comments?

On Thu, 2004-11-18 at 09:33, Daniel J Walsh wrote:
<snip>
> diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/global_macros.te policy-1.19.2.good/macros/global_macros.te
> --- policy-1.19.2/macros/global_macros.te	2004-11-18 08:14:45.000000000 -0500
> +++ policy-1.19.2.good/macros/global_macros.te	2004-11-18 08:35:53.865768738 -0500
> @@ -118,64 +118,6 @@
>  
>  #################################
>  #
> -# can_network(domain)
> -#
> -# Permissions for accessing the network.
> -# See types/network.te for the network types.
> -# See net_contexts for security contexts for network entities.
> -#
> -define(`can_network',`
> -#
> -# Allow the domain to create and use UDP and TCP sockets.
> -# Other kinds of sockets must be separately authorized for use.
> -allow $1 self:udp_socket create_socket_perms;
> -allow $1 self:tcp_socket create_stream_socket_perms;
> -
> -#
> -# Allow the domain to send or receive using any network interface.
> -# netif_type is a type attribute for all network interface types.
> -#
> -allow $1 netif_type:netif { tcp_send udp_send rawip_send };
> -allow $1 netif_type:netif { tcp_recv udp_recv rawip_recv };
> -
> -#
> -# Allow the domain to send to or receive from any node.
> -# node_type is a type attribute for all node types.
> -#
> -allow $1 node_type:node { tcp_send udp_send rawip_send };
> -allow $1 node_type:node { tcp_recv udp_recv rawip_recv };
> -
> -#
> -# Allow the domain to send to or receive from any port.
> -# port_type is a type attribute for all port types.
> -#
> -allow $1 port_type:{ tcp_socket udp_socket } { send_msg recv_msg };
> -
> -#
> -# Allow the domain to send NFS client requests via the socket
> -# created by mount.
> -#
> -allow $1 mount_t:udp_socket rw_socket_perms;
> -
> -#
> -# Bind to the default port type.
> -# Other port types must be separately authorized.
> -#
> -#allow $1 port_t:udp_socket name_bind;
> -#allow $1 port_t:tcp_socket name_bind;
> -
> -# XXX Allow binding to any node type.  Remove once
> -# individual rules have been added to all domains that 
> -# bind sockets. 
> -allow $1 node_type: { tcp_socket udp_socket } node_bind;
> -#
> -# Allow access to network files including /etc/resolv.conf
> -#
> -allow $1 net_conf_t:file r_file_perms;
> -')dnl end can_network definition
> -
> -#################################
> -#
>  # can_sysctl(domain)
>  #
>  # Permissions for modifying sysctl parameters.
> diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/network_macros.te policy-1.19.2.good/macros/network_macros.te
> --- policy-1.19.2/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
> +++ policy-1.19.2.good/macros/network_macros.te	2004-11-18 08:35:53.865768738 -0500
> @@ -0,0 +1,103 @@
> +#################################
> +#
> +# can_network(domain)
> +#
> +# Permissions for accessing the network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`base_can_network',`
> +#
> +# Allow the domain to create and use $2 sockets.
> +# Other kinds of sockets must be separately authorized for use.
> +allow $1 self:$2_socket connected_socket_perms;
> +
> +#
> +# Allow the domain to send or receive using any network interface.
> +# netif_type is a type attribute for all network interface types.
> +#
> +allow $1 netif_type:netif { $2_send rawip_send };
> +allow $1 netif_type:netif { $2_recv rawip_recv };
> +
> +#
> +# Allow the domain to send to or receive from any node.
> +# node_type is a type attribute for all node types.
> +#
> +allow $1 node_type:node { $2_send rawip_send };
> +allow $1 node_type:node { $2_recv rawip_recv };
> +
> +#
> +# Allow the domain to send to or receive from any port.
> +# port_type is a type attribute for all port types.
> +#
> +ifelse($3, `', `
> +allow $1 port_type:$2_socket { send_msg recv_msg };
> +', `
> +allow $1 $3:$2_socket { send_msg recv_msg };
> +')
> +
> +# XXX Allow binding to any node type.  Remove once
> +# individual rules have been added to all domains that 
> +# bind sockets. 
> +allow $1 node_type:$2_socket node_bind;
> +#
> +# Allow access to network files including /etc/resolv.conf
> +#
> +allow $1 net_conf_t:file r_file_perms;
> +')dnl end can_network definition
> +
> +#################################
> +#
> +# can_tcp_network(domain)
> +#
> +# Permissions for accessing a tcp network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_tcp_network',`
> +base_can_network($1, tcp, `$2')
> +allow $1 self:tcp_socket { listen accept };
> +')
> +
> +#################################
> +#
> +# can_udp_network(domain)
> +#
> +# Permissions for accessing a udp network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_udp_network',`
> +base_can_network($1, udp, `$2')
> +')
> +
> +#################################
> +#
> +# can_network(domain)
> +#
> +# Permissions for accessing the network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network',`
> +
> +can_tcp_network($1, `$2')
> +can_udp_network($1, `$2')
> +
> +#
> +# Allow the domain to send NFS client requests via the socket
> +# created by mount.
> +#
> +allow $1 mount_t:udp_socket rw_socket_perms;
> +
> +')dnl end can_network definition
> +
> +define(`can_resolve',`
> +can_udp_network($1, `dns_port_t')
> +allow $1 self:udp_socket connect;
> +')
> +define(`can_ldap',`
> +can_tcp_network($1, `ldap_port_t')
> +allow $1 self:tcp_socket connect;
> +')
> +
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
