Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i638YLrT018140
	for <selinux@tycho.nsa.gov>; Sat, 3 Jul 2004 04:34:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i638Xvwn028227
	for <selinux@tycho.nsa.gov>; Sat, 3 Jul 2004 08:34:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: dnsmasq policy advice
Date: Sat, 3 Jul 2004 18:34:02 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040703032852.GA23857@yggdrasil.localdomain>
In-Reply-To: <20040703032852.GA23857@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_69m5AFHu130a6fa"
Message-Id: <200407031834.02192.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_69m5AFHu130a6fa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 3 Jul 2004 13:28, Greg Norris <haphazard@kc.rr.com> wrote:
> Anyone willing to take a look at the attached policy for dnsmasq (it's
> quite short), and give me your opinion?  I've finally got to a point
> where I'm happy with the beastie, and would like to verify that I
> haven't overlooked anything obvious... this being my first SE-Linux
> policy, and all.
>
> Basically, I'm hoping to hear "You didn't do anything blindingly
> stupid". ;-)

I've attached a modified version of types/network.te to make the dns_port_t 
declaration more sane and modified your dnsmask.te to work with other policy 
and not multiply declare types.

Also at the end I put in a file_type_auto_trans() rule because that seems to 
map to what you want to do.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_69m5AFHu130a6fa
Content-Type: text/plain;
  charset="iso-8859-1";
  name="network.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="network.te"

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

# Modified by Reino Wallin <reino@oribium.com>
# Multi NIC, and IPSEC features

# Modified by Russell Coker
# Move port types to their respective domains, add ifdefs, other cleanups.

# generally we do not want to define port types in this file, but some things
# are insanely difficult to do elsewhere, xserver_port_t is a good example
# getting the type defined is the easy part for X, conditional code for many
# other domains (including one that starts with a) is the hard part.
ifdef(`xdm.te', `define(`use_x_ports')')
ifdef(`startx.te', `define(`use_x_ports')')
ifdef(`xauth.te', `define(`use_x_ports')')
ifdef(`xserver.te', `define(`use_x_ports')')
ifdef(`use_x_ports', `
type xserver_port_t, port_type;
')
#
# Defines used by the te files need to be defined outside of net_constraints
#
ifdef(`named.te', `define(`use_dns')')
ifdef(`nsd.te', `define(`use_dns')')
ifdef(`tinydns.te', `define(`use_dns')')
ifdef(`dnsmasq.te', `define(`use_dns')')
ifdef(`use_dns', `
type dns_port_t, port_type;
')

ifdef(`named.te', `define(`use_dns')')
ifdef(`cyrus.te', `define(`use_pop')')
ifdef(`courier.te', `define(`use_pop')')
ifdef(`perdition.te', `define(`use_pop')')
ifdef(`dovecot.te', `define(`use_pop')')
ifdef(`use_pop', `
type pop_port_t, port_type;
')
ifdef(`apache.te', `define(`use_http_cache')')
ifdef(`squid.te', `define(`use_http_cache')')

############################################
#
# Network types
#

#
# port_t is the default type of INET port numbers.
# The *_port_t types are used for specific port
# numbers in net_contexts or net_contexts.mls.
#
type port_t, port_type;

#
# netif_t is the default type of network interfaces.
# The netif_*_t types are used for specific network
# interfaces in net_contexts or net_contexts.mls.
#
type netif_t, netif_type;
type netif_eth0_t, netif_type;
type netif_eth1_t, netif_type;
type netif_eth2_t, netif_type;
type netif_lo_t, netif_type;
type netif_ippp0_t, netif_type;

type netif_ipsec0_t, netif_type;
type netif_ipsec1_t, netif_type;
type netif_ipsec2_t, netif_type;

#
# node_t is the default type of network nodes.
# The node_*_t types are used for specific network
# nodes in net_contexts or net_contexts.mls.
#
type node_t, node_type;
type node_lo_t, node_type;
type node_internal_t, node_type;
type node_inaddr_any_t, node_type;
type node_unspec_t, node_type;
type node_link_local_t, node_type;
type node_site_local_t, node_type;
type node_multicast_t, node_type;
type node_mapped_ipv4_t, node_type;
type node_compat_ipv4_t, node_type;

# Kernel-generated traffic, e.g. ICMP replies.
allow kernel_t netif_type:netif { rawip_send rawip_recv };
allow kernel_t node_type:node { rawip_send rawip_recv };

# Kernel-generated traffic, e.g. TCP resets.
allow kernel_t netif_type:netif { tcp_send tcp_recv };
allow kernel_t node_type:node { tcp_send tcp_recv };

--Boundary-00=_69m5AFHu130a6fa
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dnsmasq.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dnsmasq.te"

#DESC dnsmasq - DNS forwarder and DHCP server
#
# Author: Greg Norris <adric@debian.org>
# X-Debian-Packages: dnsmasq
#

#################################
#
# Rules for the dnsmasq_t domain.
#
daemon_domain(dnsmasq);
type dnsmasq_lease_t, file_type, sysadmfile;
ifdef(`dhcpd.te', `', `
type dhcpd_port_t, port_type;
')

# misc. requirements
allow dnsmasq_t self:capability { net_bind_service net_raw setgid setuid };
allow dnsmasq_t urandom_device_t:chr_file { read };

# network-related goodies
can_network(dnsmasq_t)
allow dnsmasq_t self:packet_socket create_socket_perms;
allow dnsmasq_t self:unix_dgram_socket create_socket_perms;
allow dnsmasq_t self:unix_stream_socket create_stream_socket_perms;

# UDP ports 53 and 67
allow dnsmasq_t dhcpd_port_t:udp_socket name_bind;
allow dnsmasq_t dns_port_t:udp_socket name_bind;

# allow access to dnsmasq.conf
allow dnsmasq_t etc_t:file r_file_perms;

# dhcp leases
file_type_auto_trans(dnsmasq_t, var_lib_t, dnsmasq_lease_t)

--Boundary-00=_69m5AFHu130a6fa--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
