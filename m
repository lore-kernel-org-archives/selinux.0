Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i65GDhrT025547
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 12:13:43 -0400 (EDT)
Received: from ms-smtp-02.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i65GDfUd002268
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 16:13:41 GMT
Date: Mon, 5 Jul 2004 11:13:25 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dnsmasq policy advice
Message-ID: <20040705161325.GA7712@yggdrasil.localdomain>
References: <20040703032852.GA23857@yggdrasil.localdomain> <200407031834.02192.russell@coker.com.au> <20040703153007.GA25813@yggdrasil.localdomain> <200407041502.59456.russell@coker.com.au> <20040704124436.GA3976@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
In-Reply-To: <20040704124436.GA3976@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4jXrM3lyYWu4nBt5
Content-Type: multipart/mixed; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Based upon what you've told me, along with your network.te updates, the
attached version ought to be the "final" incarnation.  I think the
policy would be helpful to others as well, so I'd like to get it
included upstream if possible.  Can you do this?  If not, can you tell
me who I need to contact?

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dnsmasq.te"

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

# By default, dnsmasq binds to the wildcard address to listen for DNS requests.
# Comment out the following entry if you don't want to allow this behaviour.
allow dnsmasq_t node_inaddr_any_t:udp_socket { node_bind };

# allow access to dnsmasq.conf
allow dnsmasq_t etc_t:file r_file_perms;

# dhcp leases
file_type_auto_trans(dnsmasq_t, var_lib_t, dnsmasq_lease_t)

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dnsmasq.fc"

# dnsmasq
/usr/sbin/dnsmasq		--	system_u:object_r:dnsmasq_exec_t
/var/lib/misc/dnsmasq\.leases	--	system_u:object_r:dnsmasq_lease_t
/var/run/dnsmasq\.pid		--	system_u:object_r:dnsmasq_var_run_t

--gj572EiMnwbLXET9--

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6X4lgrEMyr8Cx2YRAm9TAJ4mPIVg0VkAwrf9QYgp3WZ6djocNACdH2s+
b5jqEfvXeulKwnmXlneq33I=
=6tgI
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
