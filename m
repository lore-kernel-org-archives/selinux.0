Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4P94IRb016366
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 05:04:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4P91mar025481
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 09:01:48 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
	by jazzswing.ncsc.mil  with ESMTP id i4P91lQu025478
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 09:01:47 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 25 May 2004 11:04:13 +0200
Date: Tue, 25 May 2004 11:03:58 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: [patch] policy for nrpe
Message-Id: <20040525090358.GA3379@jmh.mhn.de>
References: <20040523214406.GB6147@jmh.mhn.de> <200405251248.23006.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
In-Reply-To: <200405251248.23006.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5/uDoXvLw7AC5HRs
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-05-25 06:37]:
> On Mon, 24 May 2004 07:44, Thomas Bleher <bleher@informatik.uni-muenchen.=
de>=20
> wrote:
> > The attached patch adds policy support for nrpe.
> > (nrpe stands for Nagios Remote Plugin Execution and is a client called
> > from inetd which performs checks on a client on behalf of a Nagios
> > server)
>=20
> I have made a couple of changes.  I have labeled the port as inetd_port_t=
,=20
> there seems to be no benefit in having a different type as only inetd is =
used=20
> for binding to the port.  I have added support for running directly from=
=20
> inetd without tcpd (my personal preference for such things is to run nagi=
os=20
> on the internal network and use netfilter to control access).

This looks good to me. I have attached the modified patch.

Thanks,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nrpe.patch"

diff -urN orig/domains/program/nrpe.te mod/domains/program/nrpe.te
--- orig/domains/program/nrpe.te	1970-01-01 01:00:00.000000000 +0100
+++ mod/domains/program/nrpe.te	2004-05-25 10:59:25.558086504 +0200
@@ -0,0 +1,38 @@
+# DESC nrpe - Nagios Remote Plugin Execution
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+#
+# X-Debian-Packages: nagios-nrpe-server
+#
+# This policy assumes that nrpe is called from inetd
+
+daemon_base_domain(nrpe)
+ifdef(`tcpd.te', `
+domain_auto_trans(tcpd_t, nrpe_exec_t, nrpe_t)
+')
+domain_auto_trans(inetd_t, nrpe_exec_t, nrpe_t)
+
+allow nrpe_t urandom_device_t:chr_file { getattr ioctl read };
+
+allow nrpe_t self:fifo_file rw_file_perms;
+# use sockets inherited from inetd
+allow nrpe_t inetd_t:tcp_socket { ioctl read write };
+allow nrpe_t devtty_t:chr_file { read write };
+
+allow nrpe_t self:process setpgid;
+
+etc_domain(nrpe)
+
+# permissions for the scripts executed by nrpe
+#
+# call shell programs
+can_exec(nrpe_t, { bin_t shell_exec_t ls_exec_t })
+allow nrpe_t { bin_t sbin_t }:dir search;
+# for /bin/sh
+allow nrpe_t bin_t:lnk_file read;
+
+# read /proc/meminfo, /proc/self/mounts and /etc/mtab
+allow nrpe_t { self proc_t etc_runtime_t }:file { getattr read };
+
+# you will have to add more permissions here, depending on the scripts you call!
+
diff -urN orig/file_contexts/program/nrpe.fc mod/file_contexts/program/nrpe.fc
--- orig/file_contexts/program/nrpe.fc	1970-01-01 01:00:00.000000000 +0100
+++ mod/file_contexts/program/nrpe.fc	2004-05-25 10:59:34.238766840 +0200
@@ -0,0 +1,6 @@
+# nrpe
+/usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
+/etc/nagios/nrpe.cfg	--	system_u:object_r:nrpe_etc_t
+/usr/lib/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
+/usr/lib/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
+
diff -urN orig/net_contexts mod/net_contexts
--- orig/net_contexts	2004-05-25 10:58:52.402126976 +0200
+++ mod/net_contexts	2004-05-25 10:43:06.000000000 +0200
@@ -142,6 +142,7 @@
 portcon tcp 5269 system_u:object_r:jabber_interserver_port_t
 ')
 ifdef(`postgresql.te', `portcon tcp 5432 system_u:object_r:postgresql_port_t')
+ifdef(`nrpe.te', `portcon tcp 5666 system_u:object_r:inetd_port_t')
 ifdef(`use_x_ports', `
 portcon tcp 6000  system_u:object_r:xserver_port_t
 portcon tcp 6001  system_u:object_r:xserver_port_t

--k+w/mQv8wyuph6w0--

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAswv+xWIrrrL0q+cRAu96AJ0ZPk2Ha1b/GAS6IqzO50w01TrIrwCfbNq/
rttjKM7gjmaCYIY+i9VHIhw=
=5FbK
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
