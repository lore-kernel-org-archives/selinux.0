Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOJkRIi022420
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 14:46:27 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOJkUC8007731
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 19:46:30 GMT
Subject: Re: can_network patch.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41A4B54F.3070709@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
	 <41A4B54F.3070709@redhat.com>
Content-Type: text/plain
Message-Id: <1101325733.12859.37.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Nov 2004 14:48:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with some changes.

After talking with Steve, I removed can_network_server_udp and
can_network_client_udp, and just used can_network_udp.  There is no
security gained for udp in not allowing the connect if they already can
send and receive.

Also removed, for now, the mozilla_macros.te chunk that allowed mozilla
to execute userhelper and the rules giving mozilla more execute
permissions.  

I missed the userhelper stuff yesterday.  Letting mozilla run userhelper
has some serious security implications.

Isn't it possible to give the JRE the execute permisisons without giving
it to $1_mozilla_t?

On Wed, 2004-11-24 at 11:22, Daniel J Walsh wrote:
>     *   This patch includes the ugliness to get sun's jre plugin to work
>       in Mozilla.  (otherwize mozilla crashes).
>     * Removed distro_gentoo checks around proc_net since we want these also.
>     * Futzed around with userhelper so that mozilla can run it.
>     * Cleaned up stunnel.te so it should be usable for gentoo and other
>       distributions.
>     * Some cleanup of apache to allow starting of apache with ssl keys
>     * Includes modification to global_macros to extract out
>       network_macros.te
> 
> 
> network_macros.te includes
> 
> can_network - with all the current functionaility
> 
> I added
> 
> can_network_server (Has listen and accept, both udp and tcp)
> can_network_server_udp
> can_network_server_tcp
> 
> can_network_client (Has connect, both udp and tcp)
> can_network_client_tcp
> can_network_client_udp
> 
> can_network_udp  - Same as can_network but only for udp
> can_network_tcp - Same as can_network but only for tcp
> 
> 
> ______________________________________________________________________
<snip>
> diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.19.5/macros/network_macros.te
> --- nsapolicy/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
> +++ policy-1.19.5/macros/network_macros.te	2004-11-24 10:57:51.328334858 -0500
> @@ -0,0 +1,189 @@
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
> +# can_network_server_tcp(domain)
> +#
> +# Permissions for accessing a tcp network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_server_tcp',`
> +base_can_network($1, tcp, `$2')
> +allow $1 self:tcp_socket { listen accept };
> +')
> +
> +#################################
> +#
> +# can_network_server_udp(domain)
> +#
> +# Permissions for accessing a udp network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_server_udp',`
> +base_can_network($1, udp, `$2')
> +')
> +
> +#################################
> +#
> +# can_network_client_tcp(domain)
> +#
> +# Permissions for accessing a tcp network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_client_tcp',`
> +base_can_network($1, tcp, `$2')
> +allow $1 self:tcp_socket { connect };
> +')
> +
> +#################################
> +#
> +# can_network_client_udp(domain)
> +#
> +# Permissions for accessing a udp network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_client_udp',`
> +base_can_network($1, udp, `$2')
> +allow $1 self:udp_socket { connect };
> +')
> +
> +#################################
> +#
> +# can_network_tcp(domain)
> +#
> +# Permissions for accessing the network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_tcp',`
> +
> +can_network_server_tcp($1, `$2')
> +can_network_client_tcp($1, `$2')
> +
> +')
> +
> +#################################
> +#
> +# can_network_udp(domain)
> +#
> +# Permissions for accessing the network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_udp',`
> +
> +can_network_client_udp($1, `$2')
> +can_network_server_udp($1, `$2')
> +
> +')
> +
> +#################################
> +#
> +# can_network_server(domain)
> +#
> +# Permissions for accessing the network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_server',`
> +
> +can_network_server_tcp($1, `$2')
> +can_network_server_udp($1, `$2')
> +
> +')dnl end can_network_server definition
> +
> +
> +#################################
> +#
> +# can_network_client(domain)
> +#
> +# Permissions for accessing the network.
> +# See types/network.te for the network types.
> +# See net_contexts for security contexts for network entities.
> +#
> +define(`can_network_client',`
> +
> +can_network_client_tcp($1, `$2')
> +can_network_client_udp($1, `$2')
> +
> +')dnl end can_network_client definition
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
> +can_network_tcp($1, `$2')
> +can_network_udp($1, `$2')
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
> +can_network_client_udp($1, `dns_port_t')
> +')
> +
> +define(`can_ldap',`
> +can_network_client_tcp($1, `ldap_port_t')
> +')
> +

<snip>

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.5/macros/program/mozilla_macros.te
> --- nsapolicy/macros/program/mozilla_macros.te	2004-11-24 07:00:51.000000000 -0500
> +++ policy-1.19.5/macros/program/mozilla_macros.te	2004-11-24 10:57:51.332334406 -0500
> @@ -29,7 +29,8 @@
>  
>  allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
>  allow $1_mozilla_t var_lib_t:file { getattr read };
> -allow $1_mozilla_t urandom_device_t:chr_file { getattr ioctl read };
> +allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read append };
> +
>  allow $1_mozilla_t self:socket create_socket_perms;
>  allow $1_mozilla_t self:file { getattr read };
>  
> @@ -117,8 +118,20 @@
>  dontaudit $1_mozilla_t file_type:dir getattr;
>  allow $1_mozilla_t self:sem create_sem_perms;
>  
> +ifdef(`userhelper.te', `
> +domain_auto_trans($1_mozilla_t, userhelper_exec_t, $1_userhelper_t)
> +')
>  dontaudit $1_mozilla_t selinux_config_t:dir search;
>  
> +#
> +# Rules needed to run java apps
> +#
> +allow $1_mozilla_t ld_so_cache_t:file execute;
> +allow $1_mozilla_t locale_t:file execute;
> +dontaudit $1_mozilla_t *:{ chr_file file } execute;
> +dontaudit $1_t ld_so_cache_t:file execute;
> +dontaudit $1_t locale_t:file execute;
> +
>  ifdef(`xdm.te', `
>  allow $1_mozilla_t xdm_t:fifo_file { write read };
>  allow $1_mozilla_t xdm_tmp_t:dir search;

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
