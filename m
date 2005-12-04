Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB4AbgMA000994
	for <selinux@tycho.nsa.gov>; Sun, 4 Dec 2005 05:37:43 -0500 (EST)
Received: from sunspire.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id jB4AVXsh011945
	for <selinux@tycho.nsa.gov>; Sun, 4 Dec 2005 10:31:34 GMT
Date: Sun, 4 Dec 2005 12:32:07 +0200
From: Petre Rodan <kaiowas@gentoo.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Gentoo diffs
Message-ID: <20051204103207.GB15895@peter.sunspire.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--RpqchZ26BWispMcB
Content-Type: multipart/mixed; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

Attached you'll find the latest diffs between the sample policy and the cur=
rent Gentoo policy.

ChangeLog

daemontools.te: added support to supervise ftpd, openvpn
ftpd.fc: added support for PureFTPd
openvpn.te openvpn.fc: added log_domain and var_lib_domain
publicfile.te: minor fix
saslauthd.fc: added gentoo path
slapd.te slapd.fc: added gentoo paths and support for openldap-2.2.28
spamd.te spamd.fc: added var_lib_domain and new capabilities needed by spam=
assassin 3.1.0

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="daemontools.te.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/domains/program/unused/daemontools.te	2005=
-05-25 13:04:36.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/daemontools.te	2005-11=
-26 19:49:40.000000000 +0200
@@ -150,17 +150,27 @@
 ')
=20
 ifdef(`clockspeed.te', `
-domain_auto_trans( svc_run_t, clockspeed_exec_t, clockspeed_t)
+domain_auto_trans(svc_run_t, clockspeed_exec_t, clockspeed_t)
 svc_ipc_domain(clockspeed_t)
 r_dir_file(svc_run_t, clockspeed_var_lib_t)
 allow svc_run_t clockspeed_var_lib_t:fifo_file { rw_file_perms setattr };
 ')
=20
 ifdef(`dante.te', `
-domain_auto_trans( svc_run_t, dante_exec_t, dante_t);
+domain_auto_trans(svc_run_t, dante_exec_t, dante_t);
 svc_ipc_domain(dante_t)
 ')
=20
+ifdef(`ftpd.te', `
+domain_auto_trans(svc_run_t, ftpd_exec_t, ftpd_t);
+svc_ipc_domain(ftpd_t)
+')
+
+ifdef(`openvpn.te', `
+domain_auto_trans(svc_run_t, openvpn_exec_t, openvpn_t);
+svc_ipc_domain(openvpn_t)
+')
+
 ifdef(`publicfile.te', `
 svc_ipc_domain(publicfile_t)
 ')

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ftpd.fc.diff"

--- /root/public_html/policy/nsa/file_contexts/program/ftpd.fc	2005-11-18 13:29:41.000000000 +0200
+++ /etc/security/selinux/src/policy/file_contexts/program/ftpd.fc	2005-11-18 15:41:55.000000000 +0200
@@ -5,6 +5,7 @@
 /usr/sbin/ftpwho	--	system_u:object_r:ftpd_exec_t
 /usr/kerberos/sbin/ftpd	--	system_u:object_r:ftpd_exec_t
 /usr/sbin/vsftpd	--	system_u:object_r:ftpd_exec_t
+/usr/sbin/pure-ftpd	--	system_u:object_r:ftpd_exec_t
 /etc/proftpd\.conf	--	system_u:object_r:ftpd_etc_t
 /var/run/proftpd/proftpd-inetd -- system_u:object_r:ftpd_var_run_t
 /var/run/proftpd/proftpd\.scoreboard -- system_u:object_r:ftpd_var_run_t

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.fc.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/file_contexts/program/openvpn.fc	2005-04-1=
7 00:36:17.000000000 +0300
+++ /etc/security/selinux/src/policy/file_contexts/program/openvpn.fc	2005-=
06-18 10:40:06.000000000 +0300
@@ -2,3 +2,6 @@
=20
 /etc/openvpn/.*	--	system_u:object_r:openvpn_etc_t
 /usr/sbin/openvpn	--	system_u:object_r:openvpn_exec_t
+/var/log/openvpn-status\.log    -- system_u:object_r:openvpn_log_t
+/var/lib/openvpn(/.*)?	system_u:object_r:openvpn_var_lib_t
+

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.te.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/domains/program/unused/openvpn.te	2005-07-=
06 22:58:17.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/openvpn.te	2005-06-18 =
10:40:15.000000000 +0300
@@ -7,6 +7,10 @@
=20
 daemon_domain(openvpn)
 etcdir_domain(openvpn)
+log_domain(openvpn)
+var_lib_domain(openvpn)
=20
 allow openvpn_t { etc_t etc_runtime_t }:{ file lnk_file } r_file_perms;
=20
@@ -14,6 +18,7 @@
 allow openvpn_t devpts_t:dir { search getattr };
 allow openvpn_t tun_tap_device_t:chr_file rw_file_perms;
 allow openvpn_t proc_t:file { getattr read };
+r_dir_file(openvpn_t, proc_net_t)
=20
 allow openvpn_t self:unix_dgram_socket create_socket_perms;
 allow openvpn_t self:unix_stream_socket create_stream_socket_perms;

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="publicfile.te.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/domains/program/unused/publicfile.te	2005-=
04-21 15:53:02.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/publicfile.te	2005-11-=
24 11:42:33.000000000 +0200
@@ -6,13 +6,24 @@
 # this policy depends on ucspi-tcp
 #
=20
 daemon_domain(publicfile)
 type publicfile_content_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, publicfile_exec_t, publicfile_t)
=20
 ifdef(`ucspi-tcp.te', `
 domain_auto_trans(utcpserver_t, publicfile_exec_t, publicfile_t)
-allow publicfile_t utcpserver_t:tcp_socket { read write };
+allow publicfile_t utcpserver_t:tcp_socket { read write shutdown };
 allow utcpserver_t { ftp_data_port_t ftp_port_t http_port_t }:tcp_socket n=
ame_bind;
 ')
=20

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="saslauth.fc.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/file_contexts/program/saslauthd.fc	2004-09=
-23 05:08:21.000000000 +0300
+++ /etc/security/selinux/src/policy/file_contexts/program/saslauthd.fc	200=
5-02-27 19:25:37.000000000 +0200
@@ -1,3 +1,6 @@
 # saslauthd=20
 /usr/sbin/saslauthd		--	system_u:object_r:saslauthd_exec_t
 /var/run/saslauthd(/.*)?		system_u:object_r:saslauthd_var_run_t
+
+/var/lib/sasl2(/.*)?			system_u:object_r:saslauthd_var_run_t
+

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="slapd.fc.diff"

--- /root/public_html/policy/nsa/file_contexts/program/slapd.fc	2005-11-18 13:29:41.000000000 +0200
+++ /etc/security/selinux/src/policy/file_contexts/program/slapd.fc	2005-11-18 15:50:29.000000000 +0200
@@ -17,3 +17,14 @@
 /opt/(fedora|redhat)-ds/slapd-[^/]+/stop-slapd system_u:object_r:initrc_exec_t
 /opt/(fedora|redhat)-ds/alias(/.*)? system_u:object_r:slapd_cert_t
 /opt/(fedora|redhat)-ds/alias/[^/]+so.* system_u:object_r:shlib_t
+
+# gentoo file locations
+/usr/lib/openldap/slapd --	system_u:object_r:slapd_exec_t
+/etc/openldap/slapd\.conf -- system_u:object_r:slapd_etc_t
+/etc/openldap/ssl/.*		-- system_u:object_r:slapd_cert_t
+/var/run/openldap(/.*)?		system_u:object_r:slapd_var_run_t
+/var/lib/openldap-data(/.*)?	system_u:object_r:slapd_db_t
+/var/lib/openldap-ldbm(/.*)?	system_u:object_r:slapd_db_t
+/var/lib/openldap-slurp(/.*)?	system_u:object_r:slapd_db_t
+
+

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="slapd.te.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/domains/program/unused/slapd.te	2005-11-18=
 13:29:41.000000000 +0200
+++ /etc/security/selinux/src/policy/domains/program/slapd.te	2005-11-18 15=
:48:27.000000000 +0200
@@ -61,18 +62,22 @@
 allow slapd_t self:netlink_route_socket r_netlink_socket_perms;
 r_dir_file(slapd_t, cert_t)
=20
+# gentoo related
+#allow slapd_t slapd_t:capability dac_override;
+allow slapd_t slapd_t:unix_stream_socket listen;
+allow slapd_t slapd_var_run_t:sock_file { create setattr unlink };
=20

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="spamd.fc.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/file_contexts/program/spamd.fc	2004-02-02 =
18:58:19.000000000 +0200
+++ /etc/security/selinux/src/policy/file_contexts/program/spamd.fc	2005-05=
-02 11:01:38.000000000 +0300
@@ -1,3 +1,7 @@
 /usr/sbin/spamd		--	system_u:object_r:spamd_exec_t
 /usr/bin/spamd		--	system_u:object_r:spamd_exec_t
 /usr/bin/sa-learn	--	system_u:object_r:spamd_exec_t
+
+/var/run/spamd(/.*)?	system_u:object_r:spamd_var_run_t	=09
+/var/lib/spamd(/.*)?	system_u:object_r:spamd_var_lib_t	=09
+

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="spamd.te.diff"
Content-Transfer-Encoding: quoted-printable

--- /root/public_html/policy/nsa/domains/program/unused/spamd.te	2005-11-18=
 13:29:41.000000000 +0200
+++ /etc/security/selinux/src/policy/domains/program/spamd.te	2005-11-24 11=
:43:54.000000000 +0200
@@ -9,9 +9,14 @@
=20
 tmp_domain(spamd)
=20
 general_domain_access(spamd_t)
 uses_shlib(spamd_t)
 read_sysctl(spamd_t)
+var_lib_domain(spamd)
=20
 # Various Perl bits
 allow spamd_t lib_t:file rx_file_perms;
@@ -32,10 +37,12 @@
 # Spamassassin, when run as root and using per-user config files,
 # setuids to the user running spamc.  Comment this if you are not
 # using this ability.
-allow spamd_t self:capability { setuid setgid dac_override sys_tty_config =
};
+allow spamd_t self:capability { setuid setgid chown fowner dac_override ki=
ll sys_tty_config };
=20
 allow spamd_t { bin_t sbin_t }:dir { getattr search };
 can_exec(spamd_t, bin_t)
+allow spamd_t bin_t:lnk_file read;
+allow spamd_t spamd_var_run_t:sock_file create_file_perms;
=20
 ifdef(`sendmail.te', `
 allow spamd_t etc_mail_t:dir { getattr read search };

--ieNMXl1Fr3cevapt--

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iD8DBQFDksWnGSBEIeh4AEYRAu2FAJ9GlfFhE+N9r2CnaKq0V4kfVfntYwCdEiR2
9HsThq5sqP8LHay3xFcjTl4=
=ulZl
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
