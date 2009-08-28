Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7SLDF8p027485
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 17:13:15 -0400
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7SLEREU026924
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 21:14:27 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/2] refpol: Policy for the new TUN driver access controls
To: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Date: Fri, 28 Aug 2009 17:13:12 -0400
Message-ID: <20090828211312.2821.87627.stgit@flek.lan>
In-Reply-To: <20090828211039.2821.58710.stgit@flek.lan>
References: <20090828211039.2821.58710.stgit@flek.lan>
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

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 policy/modules/admin/vpn.te         |    1 +
 policy/modules/apps/qemu.if         |    3 +++
 policy/modules/apps/uml.te          |    6 ++++++
 policy/modules/services/openvpn.te  |    1 +
 policy/modules/services/virt.if     |   19 +++++++++++++++++++
 policy/modules/services/virt.te     |    1 +
 policy/modules/system/userdomain.if |   23 +++++++++++++++++++++++
 policy/modules/system/userdomain.te |    2 ++
 8 files changed, 56 insertions(+), 0 deletions(-)

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
index d258f1d..71f2423 100644
--- a/policy/modules/apps/qemu.if
+++ b/policy/modules/apps/qemu.if
@@ -149,6 +149,7 @@ template(`qemu_domain_template',`
 	allow $1_t self:shm create_shm_perms;
 	allow $1_t self:unix_stream_socket create_stream_socket_perms;
 	allow $1_t self:tcp_socket create_stream_socket_perms;
+	allow $1_t self:tun_socket create;
 
 	manage_dirs_pattern($1_t, $1_tmp_t, $1_tmp_t)
 	manage_files_pattern($1_t, $1_tmp_t, $1_tmp_t)
@@ -190,6 +191,7 @@ template(`qemu_domain_template',`
 	sysnet_read_config($1_t)
 
 	userdom_use_user_terminals($1_t)
+	userdom_attach_admin_tun_iface($1_t)
 
 	optional_policy(`
 		samba_domtrans_smbd($1_t)
@@ -199,6 +201,7 @@ template(`qemu_domain_template',`
 		virt_manage_images($1_t)
 		virt_read_config($1_t)
 		virt_read_lib_files($1_t)
+		virt_attach_tun_iface($1_t)
 	')
 
 	optional_policy(`
diff --git a/policy/modules/apps/uml.te b/policy/modules/apps/uml.te
index 05e871c..a677710 100644
--- a/policy/modules/apps/uml.te
+++ b/policy/modules/apps/uml.te
@@ -60,6 +60,7 @@ allow uml_t self:unix_dgram_socket create_socket_perms;
 # Use the network.
 allow uml_t self:tcp_socket create_stream_socket_perms;
 allow uml_t self:udp_socket create_socket_perms;
+allow uml_t self:tun_socket create;
 # for mconsole
 allow uml_t self:unix_dgram_socket sendto;
 
@@ -135,11 +136,16 @@ seutil_use_newrole_fds(uml_t)
 sysnet_read_config(uml_t)
 
 userdom_use_user_terminals(uml_t)
+userdom_attach_admin_tun_iface(uml_t)
 
 optional_policy(`
 	nis_use_ypbind(uml_t)
 ')
 
+optional_policy(`
+	virt_attach_tun_iface(uml_t)
+')
+
 ########################################
 #
 # Local policy
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
index 8dc8acf..b24099a 100644
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
+interface(`virt_attach_tun_iface',`
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
index 49ac3fd..887c3a4 100644
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
+##	Allow domain to attach to TUN devices created by administrative users.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`userdom_attach_admin_tun_iface',`
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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
