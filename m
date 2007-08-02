Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KnxKa026901
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:49:59 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KntTm008941
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:49:56 GMT
Date: Thu, 2 Aug 2007 16:49:31 -0400
Message-Id: <200708022049.l72KnVPT000397@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_networkmanager changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change wpa_supplicant to run as network manager
--- nsaserefpolicy/policy/modules/services/networkmanager.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/networkmanager.fc	2007-08-02 11:02:02.000000000 -0400
@@ -1,5 +1,6 @@
 
 /usr/(s)?bin/NetworkManager	--	gen_context(system_u:object_r:NetworkManager_exec_t,s0)
+/usr/(s)?bin/wpa_supplicant	--	gen_context(system_u:object_r:NetworkManager_exec_t,s0)
 /var/run/NetworkManager\.pid	--	gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
 /var/run/NetworkManager(/.*)?		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
 /var/run/wpa_supplicant(/.*)?		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/networkmanager.te	2007-08-02 11:02:02.000000000 -0400
@@ -41,6 +41,8 @@
 kernel_read_kernel_sysctls(NetworkManager_t)
 kernel_load_module(NetworkManager_t)
 
+can_exec(NetworkManager_t, NetworkManager_exec_t)
+
 corenet_all_recvfrom_unlabeled(NetworkManager_t)
 corenet_all_recvfrom_netlabel(NetworkManager_t)
 corenet_tcp_sendrecv_all_if(NetworkManager_t)
@@ -136,6 +138,7 @@
 	dbus_system_bus_client_template(NetworkManager,NetworkManager_t)
 	dbus_connect_system_bus(NetworkManager_t)
 	dbus_send_system_bus(NetworkManager_t)
+	userdom_dbus_chat_all_users(NetworkManager_t)
 ')
 
 optional_policy(`
@@ -152,6 +155,11 @@
 ')
 
 optional_policy(`
+	openvpn_domtrans(NetworkManager_t)
+	openvpn_signal(NetworkManager_t)
+')
+
+optional_policy(`
 	ppp_domtrans(NetworkManager_t)
 	ppp_read_pid_files(NetworkManager_t)
 	ppp_signal(NetworkManager_t)
@@ -166,6 +174,7 @@
 ')
 
 optional_policy(`
+	unconfined_rw_pipes(NetworkManager_t)
 	# Read gnome-keyring
 	unconfined_read_home_content_files(NetworkManager_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
