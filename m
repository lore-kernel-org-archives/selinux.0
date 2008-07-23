Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6N9nJeH015134
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 05:49:19 -0400
Received: from ik-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6N9nIow002800
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 09:49:18 GMT
Received: by ik-out-1112.google.com with SMTP id c21so1676647ika.2
        for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 02:49:17 -0700 (PDT)
Subject: [refpolicy patch] add frozen-bubble-server module.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oX45fbfEG6AjQIM7GOMM"
Date: Wed, 23 Jul 2008 11:49:15 +0200
Message-Id: <1216806555.1185.3.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-oX45fbfEG6AjQIM7GOMM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch aims to add frozen-bubble-server.

Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/kernel/corene=
twork.te.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/kernel/corenetwo=
rk.te.in	(revision 2758)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/kernel/corenetwo=
rk.te.in	(working copy)
@@ -90,6 +90,7 @@
 network_port(dict, tcp,2628,s0)
 network_port(distccd, tcp,3632,s0)
 network_port(dns, udp,53,s0, tcp,53,s0)
+network_port(fb_server, tcp,1511,s0, udp,1511,s0)
 network_port(fingerd, tcp,79,s0)
 network_port(ftp_data, tcp,20,s0)
 network_port(ftp, tcp,21,s0)

Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/froz=
en_bubble_server.if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/frozen_=
bubble_server.if	(revision 0)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/frozen_=
bubble_server.if	(revision 0)
@@ -0,0 +1,7 @@
+## <summary>SELinux policy for Frozen Bubble server</summary>
+## <desc>
+##	<p>
+##		Applies SELinux security to the Frozen Bubble server
+##	</p>
+## </desc>
+
Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/froz=
en_bubble_server.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/frozen_=
bubble_server.te	(revision 0)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/frozen_=
bubble_server.te	(revision 0)
@@ -0,0 +1,52 @@
+
+policy_module(frozen_bubble_server, 1.0.0)=20
+
+########################################
+#
+# fb-server private declarations
+#
+
+type fb_server_t;
+type fb_server_exec_t;
+init_daemon_domain(fb_server_t, fb_server_exec_t)
+
+type fb_server_etc_t;
+files_config_file(fb_server_etc_t)
+
+# Why does refpolicy not use init_script_type.
+ifdef(`distro_redhat', `
+type fb_server_script_exec_t;
+init_script_type(fb_server_script_exec_t)
+')
+
+########################################
+#
+# fb-server private policy
+#
+
+allow fb_server_t self:tcp_socket { bind connect write read accept
create setopt listen };
+allow fb_server_t self:udp_socket { bind create getattr read write
connect};
+allow fb_server_t self:unix_dgram_socket { write create connect };
+
+read_files_pattern(fb_server_t, fb_server_etc_t, fb_server_etc_t)
+
+corenet_tcp_bind_fb_server_port(fb_server_t)
+corenet_udp_bind_fb_server_port(fb_server_t)
+corenet_all_recvfrom_netlabel(fb_server_t)
+corenet_all_recvfrom_unlabeled(fb_server_t)
+corenet_tcp_sendrecv_all_if(fb_server_t)
+corenet_tcp_sendrecv_all_nodes(fb_server_t)
+corenet_tcp_bind_all_nodes(fb_server_t)
+corenet_udp_bind_all_nodes(fb_server_t)
+corenet_tcp_connect_http_port(fb_server_t)
+
+files_read_etc_files(fb_server_t)
+
+libs_use_ld_so(fb_server_t)
+libs_use_shared_libs(fb_server_t)
+
+logging_send_syslog_msg(fb_server_t)
+
+miscfiles_read_localization(fb_server_t)
+
+sysnet_read_config(fb_server_t)
Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/froz=
en_bubble_server.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/frozen_=
bubble_server.fc	(revision 0)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/services/frozen_=
bubble_server.fc	(revision 0)
@@ -0,0 +1,9 @@
+
+/etc/fb-server\.conf		--
gen_context(system_u:object_r:fb_server_etc_t,s0)
+
+ifdef(`distro_redhat', `
+/etc/rc\.d/init\.d/fb-server		--
gen_context(system_u:object_r:fb_server_script_exec_t,s0)
+')
+
+/usr/bin/fb-server		--
gen_context(system_u:object_r:fb_server_exec_t,s0)
+
--=20
Dominick Grift <domg472@gmail.com>


--=-oX45fbfEG6AjQIM7GOMM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiG/pAACgkQL00QnzrVtlx+9wCfUjD4iqLB8HDd8OT0WKtoUt0p
AAcAnirNENWDHOCCBVK5CxxhrQnP/z16
=CFmI
-----END PGP SIGNATURE-----

--=-oX45fbfEG6AjQIM7GOMM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
