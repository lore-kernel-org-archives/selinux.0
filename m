Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8P0wBrT021693
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 20:58:11 -0400 (EDT)
Date: Fri, 24 Sep 2004 19:58:03 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: [patch] policy update for dnsmasq
Message-ID: <20040925005803.GA23849@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--eqp4TxRxnD4KrmFZ
Content-Type: multipart/mixed; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please apply the attached dnsmasq policy patch.  It's needed in order to
support version 2.10 and later (see below for details).

Let me know if I can provide any additional information.  Thanx!

----- Forwarded message from Greg Norris <haphazard@kc.rr.com> -----

Date: Tue, 14 Sep 2004 20:18:36 -0500
=46rom: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Cc: simon@thekelleys.org.uk
Subject: policy update for dnsmasq
X-Mailing-List: selinux-tycho.nsa.gov

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

--+nBD6E3TurpgldQp
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

--+nBD6E3TurpgldQp--

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBVMKbgrEMyr8Cx2YRAhJsAJ9CrR2Zf2QB1VS4mJUkqlR7NJj+lwCgoQeN
iNG8dMwPACsX0qfQLCBkWQc=
=AhnI
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
