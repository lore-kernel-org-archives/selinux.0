Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i633T4rT017246
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 23:29:05 -0400 (EDT)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i633T3dS020668
	for <selinux@tycho.nsa.gov>; Sat, 3 Jul 2004 03:29:03 GMT
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-04.rdc-kc.rr.com (8.12.8p1/8.12.7) with ESMTP id i633QB8Z026876
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 22:26:13 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id F18284A653
	for <selinux@tycho.nsa.gov>; Fri,  2 Jul 2004 22:28:52 -0500 (CDT)
Date: Fri, 2 Jul 2004 22:28:52 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: dnsmasq policy advice
Message-ID: <20040703032852.GA23857@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mxv5cy4qt+RJ9ypb
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Anyone willing to take a look at the attached policy for dnsmasq (it's
quite short), and give me your opinion?  I've finally got to a point
where I'm happy with the beastie, and would like to verify that I
haven't overlooked anything obvious... this being my first SE-Linux
policy, and all.

Basically, I'm hoping to hear "You didn't do anything blindingly
stupid". ;-)

--wRRV7LY7NUeQGEoC
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
type dhcpd_port_t, port_type;
type dns_port_t, port_type;

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
allow dnsmasq_t var_lib_t:dir { search };
allow dnsmasq_t dnsmasq_lease_t:file create_file_perms;
type_transition dnsmasq_t var_lib_t:file dnsmasq_lease_t;

--wRRV7LY7NUeQGEoC--

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5if0grEMyr8Cx2YRAjNuAJ4qhsFPRZbUPhNk2hSSO2pa/guOGgCeNUdd
wTLY2rZKTUVRi1CsAYWfDJI=
=ayt5
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
