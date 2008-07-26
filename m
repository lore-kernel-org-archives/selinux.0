Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6QD7tWX017601
	for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2008 09:07:55 -0400
Received: from hu-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6QD7rut005411
	for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2008 13:07:54 GMT
Received: by hu-out-0506.google.com with SMTP id 22so691645hug.4
        for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2008 06:07:53 -0700 (PDT)
Subject: [REFPOLICY PATCH] Added policy module for the oident daemon.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OkfX0ZbtEcsXNbfx2XrF"
Date: Sat, 26 Jul 2008 15:07:49 +0200
Message-Id: <1217077669.8496.2.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OkfX0ZbtEcsXNbfx2XrF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Dominick Grift <domg472@gmail.com>
---
 policy/modules/services/oidentd.fc |    9 +++++
 policy/modules/services/oidentd.if |    7 ++++
 policy/modules/services/oidentd.te |   68
++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 policy/modules/services/oidentd.fc
 create mode 100644 policy/modules/services/oidentd.if
 create mode 100644 policy/modules/services/oidentd.te

diff --git a/policy/modules/services/oidentd.fc
b/policy/modules/services/oidentd.fc
new file mode 100644
index 0000000..a9209dc
--- /dev/null
+++ b/policy/modules/services/oidentd.fc
@@ -0,0 +1,9 @@
+
+/etc/oidentd.conf		--
gen_context(system_u:object_r:oidentd_config_t,s0)
+/etc/oidentd_masq.conf	--
gen_context(system_u:object_r:oidentd_config_t,s0)
+
+ifdef(`distro_redhat', `
+/etc/rc\.d/init\.d/oidentd		--
gen_context(system_u:object_r:oidentd_script_exec_t,s0)
+')
+
+/usr/sbin/oidentd		--	gen_context(system_u:object_r:oidentd_exec_t,s0)
diff --git a/policy/modules/services/oidentd.if
b/policy/modules/services/oidentd.if
new file mode 100644
index 0000000..a745861
--- /dev/null
+++ b/policy/modules/services/oidentd.if
@@ -0,0 +1,7 @@
+## <summary>SELinux policy for the oident daemon.</summary>
+## <desc>
+##	<p>
+##	Applies SELinux security to the oident daemon.
+##	</p>
+## </desc>
+
diff --git a/policy/modules/services/oidentd.te
b/policy/modules/services/oidentd.te
new file mode 100644
index 0000000..1b770cf
--- /dev/null
+++ b/policy/modules/services/oidentd.te
@@ -0,0 +1,68 @@
+
+policy_module(oidentd, 0.0.1)=20
+
+########################################
+#
+# oidentd private declarations
+#
+
+## <desc>
+## <p>
+## Allow the oident daemon to read
+## unprivileged user home content files.
+## </p>
+## </desc>
+gen_tunable(oidentd_read_unprivileged_user_home_content_files, false)
+
+type oidentd_t;
+type oidentd_exec_t;
+init_daemon_domain(oidentd_t, oidentd_exec_t)
+
+ifdef(`distro_redhat', `
+type oidentd_script_exec_t;
+init_script_type(oidentd_script_exec_t)
+')
+
+type oidentd_config_t;
+files_config_file(oidentd_config_t)
+
+########################################
+#
+# oidentd private policy
+#
+allow oidentd_t self:capability { setuid setgid };
+allow oidentd_t self:netlink_route_socket { write getattr read bind
create nlmsg_read };
+allow oidentd_t self:netlink_tcpdiag_socket { write read create
nlmsg_read };
+allow oidentd_t self:tcp_socket { setopt read bind create accept write
getattr listen };
+allow oidentd_t self:udp_socket { write read create connect getattr };
+allow oidentd_t self:unix_dgram_socket { create connect };
+
+allow oidentd_t oidentd_config_t:file read_file_perms;
+
+corenet_all_recvfrom_unlabeled(oidentd_t)
+corenet_all_recvfrom_netlabel(oidentd_t)
+corenet_tcp_sendrecv_all_if(oidentd_t)
+corenet_tcp_sendrecv_all_nodes(oidentd_t)
+corenet_tcp_bind_all_nodes(oidentd_t)
+corenet_tcp_bind_auth_port(oidentd_t);
+
+files_read_etc_files(oidentd_t)
+
+kernel_read_kernel_sysctls(oidentd_t)
+kernel_read_network_state(oidentd_t)
+kernel_read_network_state_symlinks(oidentd_t)
+kernel_read_sysctl(oidentd_t)
+
+libs_use_ld_so(oidentd_t)
+libs_use_shared_libs(oidentd_t)
+
+logging_send_syslog_msg(oidentd_t)
+
+miscfiles_read_localization(oidentd_t)
+
+sysnet_read_config(oidentd_t)
+
+tunable_policy(`oidentd_read_unprivileged_user_home_content_files', `
+	# ~/.oidentd.conf
+	userdom_read_unpriv_users_home_content_files(oidentd_t)
+')
--=20
1.5.5.2

--=20
Dominick Grift <domg472@gmail.com>

--=-OkfX0ZbtEcsXNbfx2XrF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiLIZsACgkQL00QnzrVtly0gACgpQDDvejswnUoy8QNY7I3Vokb
vrcAn0aw+91gU/gvxOETD/0NP7Oqt4E+
=Ppb3
-----END PGP SIGNATURE-----

--=-OkfX0ZbtEcsXNbfx2XrF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
