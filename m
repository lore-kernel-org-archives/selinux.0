Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8F1J1rT014507
	for <selinux@tycho.nsa.gov>; Tue, 14 Sep 2004 21:19:01 -0400 (EDT)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8F1I0Je018649
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 01:18:01 GMT
Date: Tue, 14 Sep 2004 20:18:36 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Cc: simon@thekelleys.org.uk
Subject: policy update for dnsmasq
Message-ID: <20040915011836.GA7394@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QKdGvSO+nmPlgiQ/
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've attached a small patch against the dnsmasq policy, which provides
the updates indicated below.  Thanx to Simon Kelley, author of this
wondrous beastie, for bringing the relevant enhancements to my
attention. ;-)

1) Allow binding to port 53 TCP.  Beginning with version 2.10, dnsmasq
   supports DNS queries over both TCP and UDP.

2) Allow the creation of RAWIP sockets, in order to enable ICMP echo
   requests.  This is used as a sanity-check before assigning an IP
   address via DHCP, to ensure that it isn't already in use.

I've been running with the modified policy for the past few days (while
trying to stress it appropriately), and everything appears to be
working as expected... I think it's ready to be merged into CVS.  As
always, comments are most welcome.

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dnsmasq.te.diff"
Content-Transfer-Encoding: quoted-printable

--- dnsmasq.te.orig	2004-08-02 02:28:37.000000000 -0500
+++ dnsmasq.te	2004-09-12 18:34:02.000000000 -0500
@@ -18,12 +18,13 @@
 # network-related goodies
 can_network(dnsmasq_t)
 allow dnsmasq_t self:packet_socket create_socket_perms;
+allow dnsmasq_t self:rawip_socket create_socket_perms;
 allow dnsmasq_t self:unix_dgram_socket create_socket_perms;
 allow dnsmasq_t self:unix_stream_socket create_stream_socket_perms;
=20
 # UDP ports 53 and 67
 allow dnsmasq_t dhcpd_port_t:udp_socket name_bind;
-allow dnsmasq_t dns_port_t:udp_socket name_bind;
+allow dnsmasq_t dns_port_t:{ tcp_socket udp_socket } name_bind;
=20
 # By default, dnsmasq binds to the wildcard address to listen for DNS requ=
ests.
 # Comment out the following entry if you do not want to allow this behavio=
ur.

--7JfCtLOvnd9MIVvH--

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBR5hsgrEMyr8Cx2YRAspBAKDZaUkx1X2Lg0bDySzgcdAkQMUnrwCfaWWj
DdQD74lDT46O6VVI1p4uJpQ=
=+QCq
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
