Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5U2T2rT023158
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 22:29:02 -0400 (EDT)
Received: from ms-smtp-02.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5U2SxAg006989
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2004 02:29:00 GMT
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-02.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i5U2Sp9W000699
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 21:28:56 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 9CAAA4A653
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 21:28:48 -0500 (CDT)
Date: Tue, 29 Jun 2004 21:28:48 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: policy help
Message-ID: <20040630022848.GA4737@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm trying to put together a policy (current draft attached) for
dnsmasq, and am having problems with the networking piece.  I expect
that I'm overlooking something obvious (this is my first such attempt),
but can't seem to wrap my mind around it.  Anyone willing to take a
look, and point me in the right direction?

Basically, dnsmasq is acting as the DNS and DHCP server for my local
network, and needs to be able to take on all comers.  To that end I'm
using the following entries, in an attempt to allow UDP connectivity to
anywhere.

   allow dnsmasq_t netif_type:netif { udp_send udp_recv };
   allow dnsmasq_t node_type:node { udp_send udp_recv };
   allow dnsmasq_t port_type:udp_socket { send_msg recv_msg };

These should allow it to service the appropriate ports (53 and 67).

   allow dnsmasq_t dhcpd_port_t:udp_socket { name_bind recv_msg send_msg };
   allow dnsmasq_t dns_port_t:udp_socket { name_bind recv_msg send_msg };

Unfortunately, I still get LOTS of errors such as the ones below. I'm
definitely overlooking something... :-(

   Jun 29 20:44:39 sasami kernel: audit(1088559879.376:0): avc:  denied
     { send_msg } for  pid=27877 exe=/usr/sbin/dnsmasq saddr=192.168.0.1
     src=67 daddr=192.168.0.129 dest=68 netif=eth1
     scontext=system_u:system_r:dnsmasq_t
     tcontext=system_u:object_r:dhcpc_port_t tclass=udp_socket
   Jun 29 20:44:47 sasami kernel: audit(1088559826.952:0): avc:  denied
     { recv_msg } for  pid=27877 exe=/usr/sbin/dnsmasq saddr=127.0.0.1
     src=53 daddr=127.0.0.1 dest=39013 netif=lo
     scontext=system_u:system_r:initrc_t
     tcontext=system_u:object_r:dns_port_t tclass=udp_socket

Suggestions (and/or pointers to the FM to R) would be most appreciated. 
Thanx!

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dnsmasq.te"

daemon_domain(dnsmasq);
type dnsmasq_lease_t, file_type, sysadmfile;
type dhcpd_port_t, port_type;
type dns_port_t, port_type;

# misc. requirements
allow dnsmasq_t self:capability { net_bind_service net_raw setgid setuid };
allow dnsmasq_t urandom_device_t:chr_file { read };

# network-related goodies
allow dnsmasq_t self:packet_socket { create write };
allow dnsmasq_t self:udp_socket create_socket_perms;
allow dnsmasq_t self:unix_dgram_socket { connect create write };
allow dnsmasq_t self:unix_stream_socket { connect create };

# The intent here is to allow UDP to/from any port... doesn't seem to be
# working.
allow dnsmasq_t netif_type:netif { udp_send udp_recv };
allow dnsmasq_t node_type:node { udp_send udp_recv };
allow dnsmasq_t port_type:udp_socket { send_msg recv_msg };

# By default, dnsmasq binds to the wildcard address to listen for DNS requests.
# Comment out the following entry if you don't want to allow this behaviour.
allow dnsmasq_t node_inaddr_any_t:udp_socket { node_bind };

# specific ports where the magic happens
allow dnsmasq_t dhcpd_port_t:udp_socket { name_bind recv_msg send_msg };
allow dnsmasq_t dns_port_t:udp_socket { name_bind recv_msg send_msg };

# allow access to dnsmasq.conf and resolv.conf
allow dnsmasq_t etc_t:file { getattr read };
allow dnsmasq_t net_conf_t:file { getattr read };

# dhcp leases
allow dnsmasq_t var_lib_t:dir { search };
allow dnsmasq_t dnsmasq_lease_t:file { append create getattr read write };
type_transition dnsmasq_t var_lib_t:file dnsmasq_lease_t;

--gKMricLos+KVdGMg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
