Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KA10m4014350
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 05:01:00 -0500
Received: from atlantic.devin.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KA0xd5003511
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 10:00:59 GMT
Received: from aqua by atlantic.devin.com with local (Exim 4.63)
	(envelope-from <aqua@atlantic.devin.com>)
	id 1JRll4-0001TF-L2
	for selinux@tycho.nsa.gov; Wed, 20 Feb 2008 02:00:58 -0800
Date: Wed, 20 Feb 2008 02:00:58 -0800
From: Devin Carraway <selinux-list@devin.com>
To: selinux@tycho.nsa.gov
Subject: [patch] refpolicy: exim policy fixes
Message-ID: <20080220100058.GG5439@atlantic.devin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Q8BnQc91gJZX4vDc
Content-Type: multipart/mixed; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here are a handful of localized fixes to the Exim policy, based on SVN head
refpolicy and Debian Sid:

=2Efc:

- Debian uses a version-numbered naming scheme for exim binaries and
  directories; tolerate a trailing digit, e.g. "/var/lib/exim4".
- var_run_t labels a PID file if it's there, but not a directory.

=2Ete:

- add missing fowner/chown perms by exim_t on itself
- grant readonly access to var_lib_t, to read runtime-generated conf
- grant read on /dev/{u,}random; Exim may use either depending on the conte=
xt
  and how it was built
- dontaudit on reads to /proc/stat (read but not used, probably indirectly =
via
  a libc call)
- grant missing TCP send/recv to the SMTP & identd ports; grant missing SMTP
  connect (identd was already there)
- grant connect/sendrecv to LDAP, where the local mail accounts are often
  defined

--=20
Devin  \ aqua(at)devin.com, IRC:Requiem; http://www.devin.com
Carraway \ 1024D/E9ABFCD2: 13E7 199E DD1E 65F0 8905 2E43 5395 CA0D E9AB FCD2

--hxkXGo8AKqTJ+9QI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="exim-refpolicy-fixes-20080220.patch"
Content-Transfer-Encoding: quoted-printable

Index: exim.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- exim.te	(revision 2617)
+++ exim.te	(working copy)
@@ -42,7 +42,7 @@
 # exim local policy
 #
=20
-allow exim_t self:capability { dac_override dac_read_search setuid setgid =
};
+allow exim_t self:capability { dac_override dac_read_search setuid setgid =
fowner chown };
 allow exim_t self:fifo_file rw_fifo_file_perms;
 allow exim_t self:unix_stream_socket create_stream_socket_perms;
 allow exim_t self:tcp_socket create_stream_socket_perms;
@@ -65,18 +65,30 @@
 manage_files_pattern(exim_t, exim_var_run_t, exim_var_run_t)
 files_pid_filetrans(exim_t, exim_var_run_t, { file dir })
=20
+files_read_var_lib_files(exim_t)
+
+dev_read_rand(exim_t)
+dev_read_urand(exim_t)
+
 kernel_read_kernel_sysctls(exim_t)
=20
+kernel_dontaudit_read_system_state(exim_t)
+
 corecmd_search_bin(exim_t)
=20
 corenet_all_recvfrom_unlabeled(exim_t)
 corenet_tcp_sendrecv_all_if(exim_t)
 corenet_tcp_sendrecv_all_nodes(exim_t)
 corenet_tcp_sendrecv_all_ports(exim_t)
+corenet_tcp_sendrecv_smtp_port(exim_t)
+corenet_tcp_sendrecv_auth_port(exim_t)
+corenet_tcp_sendrecv_ldap_port(exim_t)
 corenet_tcp_bind_all_nodes(exim_t)
 corenet_tcp_bind_smtp_port(exim_t)
 corenet_tcp_bind_amavisd_send_port(exim_t)
 corenet_tcp_connect_auth_port(exim_t)
+corenet_tcp_connect_smtp_port(exim_t)
+corenet_tcp_connect_ldap_port(exim_t)
 corenet_tcp_connect_inetd_child_port(exim_t)
=20
 # Init script handling
Index: exim.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- exim.fc	(revision 2617)
+++ exim.fc	(working copy)
@@ -1,4 +1,5 @@
-/usr/sbin/exim		--	gen_context(system_u:object_r:exim_exec_t,s0)
-/var/log/exim(/.*)?		gen_context(system_u:object_r:exim_log_t,s0)
-/var/run/exim.pid	--	gen_context(system_u:object_r:exim_var_run_t,s0)
-/var/spool/exim(/.*)?		gen_context(system_u:object_r:exim_spool_t,s0)
+/usr/sbin/exim[0-9]?		--	gen_context(system_u:object_r:exim_exec_t,s0)
+/var/log/exim[0-9]?(/.*)?		gen_context(system_u:object_r:exim_log_t,s0)
+/var/run/exim[0-9]?\.pid	--	gen_context(system_u:object_r:exim_var_run_t,s=
0)
+/var/run/exim[0-9]?(/.*)?	  	gen_context(system_u:object_r:exim_var_run_t,=
s0)
+/var/spool/exim[0-9]?(/.*)?		gen_context(system_u:object_r:exim_spool_t,s0)

--hxkXGo8AKqTJ+9QI--

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHu/paU5XKDemr/NIRAtJwAKCN7lzVJqdyAo9Kf54O7rkCB2jJlwCfX81X
KfIpfyZuU+ErW6iCtzQ+suo=
=IU3f
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
