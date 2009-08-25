Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7PLCgmA017988
	for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2009 17:12:42 -0400
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7PLDpDB026046
	for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2009 21:13:52 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v1 2/2] refpol: Policy for the new TUN driver access
	controls
To: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Date: Tue, 25 Aug 2009 17:12:39 -0400
Message-ID: <20090825211238.6250.38852.stgit@flek.lan>
In-Reply-To: <20090825210647.6250.56266.stgit@flek.lan>
References: <20090825210647.6250.56266.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add policy for the new TUN driver access controls which allow policy to
control which domains have the ability to create and attach to TUN/TAP
devices.  The policy rules for creating and attaching to a device are as
shown below:

  # create a new device
  allow domain_t self:tun_socket { create };

  # attach to a persistent device (created by tunlbl_t)
  allow domain_t tunlbl_t:tun_socket { relabelfrom };
  allow domain_t self:tun_socket { relabelto };

Further discussion can be found on this thread:

 * http://marc.info/?t=125080850900002&r=1&w=2
---

 policy/modules/admin/vpn.te         |    1 +
 policy/modules/apps/qemu.if         |    3 +++
 policy/modules/apps/uml.te          |    3 +++
 policy/modules/services/openvpn.te  |    1 +
 policy/modules/services/virt.if     |   19 +++++++++++++++++++
 policy/modules/services/virt.te     |    1 +
 policy/modules/system/userdomain.if |   23 +++++++++++++++++++++++
 policy/modules/system/userdomain.te |    2 ++
 policy/modules/system/xen.te        |    1 +
 9 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/policy/modules/admin/vpn.te b/policy/modules/admin/vpn.te
index 11c2dcc..52cf380 100644
--- a/policy/modules/admin/vpn.te
+++ b/policy/modules/admin/vpn.te
@@ -31,6 +31,7 @@ allow vpnc_t self:udp_socket create_socket_perms;
 allow vpnc_t self:rawip_socket create_socket_perms;
 allow vpnc_t self:unix_dgram_socket create_socket_perms;
 allow vpnc_t self:unix_stream_socket create_socket_perms;
+allow vpnc_t self:tun_socket create;
 # cjp: this needs to be fixed
 allow vpnc_t self:socket create_socket_perms;
 
diff --git a/policy/modules/apps/qemu.if b/policy/modules/apps/qemu.if
index d258f1d..ee7e214 100644
--- a/policy/modules/apps/qemu.if
+++ b/policy/modules/apps/qemu.if
@@ -149,6 +149,7 @@ template(`qemu_domain_template',`
 	allow $1_t self:shm create_shm_perms;
 	allow $1_t self:unix_stream_socket create_stream_socket_perms;
 	allow $1_t self:tcp_socket create_stream_socket_perms;
+	allow $1_t self:tun_socket create;
 
 	manage_dirs_pattern($1_t, $1_tmp_t, $1_tmp_t)
 	manage_files_pattern($1_t, $1_tmp_t, $1_tmp_t)
@@ -164,6 +165,8 @@ template(`qemu_domain_template',`
 	corenet_tcp_bind_generic_node($1_t)
 	corenet_tcp_bind_vnc_port($1_t)
 	corenet_rw_tun_tap_dev($1_t)
+	virt_tun_attach($1_t)
+	userdom_tun_attach($1_t)
 
 #	dev_rw_kvm($1_t)
 
diff --git a/policy/modules/apps/uml.te b/policy/modules/apps/uml.te
index 05e871c..902c226 100644
--- a/policy/modules/apps/uml.te
+++ b/policy/modules/apps/uml.te
@@ -60,6 +60,7 @@ allow uml_t self:unix_dgram_socket create_socket_perms;
 # Use the network.
 allow uml_t self:tcp_socket create_stream_socket_perms;
 allow uml_t self:udp_socket create_socket_perms;
+allow uml_t self:tun_socket create;
 # for mconsole
 allow uml_t self:unix_dgram_socket sendto;
 
@@ -111,6 +112,8 @@ corenet_udp_sendrecv_all_ports(uml_t)
 corenet_tcp_connect_all_ports(uml_t)
 corenet_sendrecv_all_client_packets(uml_t)
 corenet_rw_tun_tap_dev(uml_t)
+virt_tun_attach(uml_t)
+userdom_tun_attach(uml_t)
 
 domain_use_interactive_fds(uml_t)
 
diff --git a/policy/modules/services/openvpn.te b/policy/modules/services/openvpn.te
index a4e2db2..99149f0 100644
--- a/policy/modules/services/openvpn.te
+++ b/policy/modules/services/openvpn.te
@@ -49,6 +49,7 @@ allow openvpn_t self:unix_dgram_socket { create_socket_perms sendto };
 allow openvpn_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow openvpn_t self:udp_socket create_socket_perms;
 allow openvpn_t self:tcp_socket server_stream_socket_perms;
+allow openvpn_t self:tun_socket create;
 allow openvpn_t self:netlink_route_socket rw_netlink_socket_perms;
 
 can_exec(openvpn_t, openvpn_etc_t)
diff --git a/policy/modules/services/virt.if b/policy/modules/services/virt.if
index 8dc8acf..77c3651 100644
--- a/policy/modules/services/virt.if
+++ b/policy/modules/services/virt.if
@@ -327,3 +327,22 @@ interface(`virt_admin',`
 
 	virt_manage_log($1)
 ')
+
+########################################
+## <summary>
+##	Allow domain to attach to virt TUN devices
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`virt_tun_attach',`
+	gen_require(`
+		type virtd_t;
+	')
+
+	allow $1 virtd_t:tun_socket relabelfrom;
+	allow $1 self:tun_socket relabelto;
+')
diff --git a/policy/modules/services/virt.te b/policy/modules/services/virt.te
index b2fd700..a51755e 100644
--- a/policy/modules/services/virt.te
+++ b/policy/modules/services/virt.te
@@ -58,6 +58,7 @@ allow virtd_t self:process { getsched sigkill signal execmem };
 allow virtd_t self:fifo_file rw_file_perms;
 allow virtd_t self:unix_stream_socket create_stream_socket_perms;
 allow virtd_t self:tcp_socket create_stream_socket_perms;
+allow virtd_t self:tun_socket create;
 
 read_files_pattern(virtd_t, virt_etc_t, virt_etc_t)
 read_lnk_files_pattern(virtd_t, virt_etc_t, virt_etc_t)
diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
index 49ac3fd..22a952c 100644
--- a/policy/modules/system/userdomain.if
+++ b/policy/modules/system/userdomain.if
@@ -1042,6 +1042,7 @@ template(`userdom_unpriv_user_template', `
 #
 template(`userdom_admin_user_template',`
 	gen_require(`
+		attribute admin_tun_type;
 		class passwd { passwd chfn chsh rootok };
 	')
 
@@ -1077,6 +1078,9 @@ template(`userdom_admin_user_template',`
 
 	allow $1_t self:netlink_audit_socket nlmsg_readpriv;
 
+	allow $1_t self:tun_socket create;
+	typeattribute $1_t admin_tun_type;
+
 	kernel_read_software_raid_state($1_t)
 	kernel_getattr_core_if($1_t)
 	kernel_getattr_message_if($1_t)
@@ -3027,3 +3031,22 @@ interface(`userdom_dbus_send_all_users',`
 
 	allow $1 userdomain:dbus send_msg;
 ')
+
+########################################
+## <summary>
+##	Allow domain to attach to admin created TUN devices
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`userdom_tun_attach',`
+	gen_require(`
+		attribute admin_tun_type;
+	')
+
+	allow $1 admin_tun_type:tun_socket relabelfrom;
+	allow $1 self:tun_socket relabelto;
+')
diff --git a/policy/modules/system/userdomain.te b/policy/modules/system/userdomain.te
index 48e9070..aff080b 100644
--- a/policy/modules/system/userdomain.te
+++ b/policy/modules/system/userdomain.te
@@ -58,6 +58,8 @@ attribute unpriv_userdomain;
 attribute untrusted_content_type;
 attribute untrusted_content_tmp_type;
 
+attribute admin_tun_type;
+
 type user_home_dir_t alias { staff_home_dir_t sysadm_home_dir_t secadm_home_dir_t auditadm_home_dir_t unconfined_home_dir_t };
 fs_associate_tmpfs(user_home_dir_t)
 files_type(user_home_dir_t)
diff --git a/policy/modules/system/xen.te b/policy/modules/system/xen.te
index 40410a7..6c4b06d 100644
--- a/policy/modules/system/xen.te
+++ b/policy/modules/system/xen.te
@@ -88,6 +88,7 @@ allow xend_t self:unix_dgram_socket create_socket_perms;
 allow xend_t self:netlink_route_socket r_netlink_socket_perms;
 allow xend_t self:tcp_socket create_stream_socket_perms;
 allow xend_t self:packet_socket create_socket_perms;
+allow xend_t self:tun_socket create;
 
 allow xend_t xen_image_t:dir list_dir_perms;
 manage_dirs_pattern(xend_t, xen_image_t, xen_image_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
