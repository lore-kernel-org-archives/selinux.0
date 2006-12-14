Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBEJTsZ9002490
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 14:29:54 -0500
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBEJUPKl027366
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 19:30:25 GMT
Message-Id: <20061214192904.201581000@hp.com>
References: <20061214192414.551708000@hp.com>
Date: Thu, 14 Dec 2006 14:24:16 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/4] Policy patches to add NetLabel support for Raw IP sockets
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

Add interfaces for NetLabel Raw IP support and give access to domains that
require Raw IP support.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/admin/amanda.te            |    1 
 policy/modules/admin/backup.te            |    1 
 policy/modules/admin/dpkg.te              |    2 
 policy/modules/admin/netutils.te          |    1 
 policy/modules/admin/portage.if           |    1 
 policy/modules/admin/rpm.te               |    1 
 policy/modules/apps/evolution.if          |    2 
 policy/modules/apps/gpg.if                |    1 
 policy/modules/apps/mozilla.if            |    1 
 policy/modules/apps/vmware.te             |    1 
 policy/modules/kernel/corenetwork.if.in   |   29 ++++++++++++++
 policy/modules/kernel/kernel.if           |   61 ++++++++++++++++++++++++++++++
 policy/modules/services/arpwatch.te       |    1 
 policy/modules/services/bluetooth.te      |    1 
 policy/modules/services/cups.te           |    2 
 policy/modules/services/dictd.te          |    1 
 policy/modules/services/dnsmasq.te        |    1 
 policy/modules/services/mailman.if        |    1 
 policy/modules/services/nessus.te         |    1 
 policy/modules/services/networkmanager.te |    1 
 policy/modules/services/ntop.te           |    1 
 policy/modules/services/portmap.te        |    1 
 policy/modules/services/ppp.te            |    2 
 policy/modules/services/radvd.te          |    1 
 policy/modules/services/razor.if          |    1 
 policy/modules/services/razor.te          |    1 
 policy/modules/services/rdisc.te          |    1 
 policy/modules/services/roundup.te        |    1 
 policy/modules/services/samba.te          |    5 ++
 policy/modules/services/snort.te          |    1 
 policy/modules/services/ssh.if            |    1 
 policy/modules/services/zebra.te          |    1 
 policy/modules/system/lvm.te              |    1 
 policy/modules/system/mount.te            |    1 
 34 files changed, 130 insertions(+)

Index: refpolicy/policy/modules/admin/amanda.te
===================================================================
--- refpolicy.orig/policy/modules/admin/amanda.te
+++ refpolicy/policy/modules/admin/amanda.te
@@ -128,6 +128,7 @@ corenet_tcp_bind_all_rpc_ports(amanda_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(amanda_t)
 	corenet_udp_recv_netlabel(amanda_t)
+	corenet_raw_recv_netlabel(amanda_t)
 ')
 
 dev_getattr_all_blk_files(amanda_t)
Index: refpolicy/policy/modules/admin/backup.te
===================================================================
--- refpolicy.orig/policy/modules/admin/backup.te
+++ refpolicy/policy/modules/admin/backup.te
@@ -50,6 +50,7 @@ corenet_sendrecv_all_client_packets(back
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(backup_t)
 	corenet_udp_recv_netlabel(backup_t)
+	corenet_raw_recv_netlabel(backup_t)
 ')
 
 dev_getattr_all_blk_files(backup_t)
Index: refpolicy/policy/modules/admin/dpkg.te
===================================================================
--- refpolicy.orig/policy/modules/admin/dpkg.te
+++ refpolicy/policy/modules/admin/dpkg.te
@@ -104,6 +104,8 @@ corenet_sendrecv_all_client_packets(dpkg
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(dpkg_t)
 	corenet_udp_recv_netlabel(dpkg_t)
+	corenet_raw_recv_netlabel(dpkg_t)
+	corenet_raw_recv_netlabel(dpkg_t)
 ')
 
 dev_list_sysfs(dpkg_t)
Index: refpolicy/policy/modules/admin/netutils.te
===================================================================
--- refpolicy.orig/policy/modules/admin/netutils.te
+++ refpolicy/policy/modules/admin/netutils.te
@@ -58,6 +58,7 @@ corenet_udp_bind_generic_node(netutils_t
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(netutils_t)
 	corenet_udp_recv_netlabel(netutils_t)
+	corenet_raw_recv_netlabel(netutils_t)
 ')
 
 fs_getattr_xattr_fs(netutils_t)
Index: refpolicy/policy/modules/admin/portage.if
===================================================================
--- refpolicy.orig/policy/modules/admin/portage.if
+++ refpolicy/policy/modules/admin/portage.if
@@ -166,6 +166,7 @@ interface(`portage_compile_domain',`
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel($1)
 		corenet_udp_recv_netlabel($1)
+		corenet_raw_recv_netlabel($1)
 	')
 
 	dev_read_sysfs($1)
Index: refpolicy/policy/modules/admin/rpm.te
===================================================================
--- refpolicy.orig/policy/modules/admin/rpm.te
+++ refpolicy/policy/modules/admin/rpm.te
@@ -105,6 +105,7 @@ corenet_sendrecv_all_client_packets(rpm_
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(rpm_t)
 	corenet_udp_recv_netlabel(rpm_t)
+	corenet_raw_recv_netlabel(rpm_t)
 ')
 
 dev_list_sysfs(rpm_t)
Index: refpolicy/policy/modules/apps/evolution.if
===================================================================
--- refpolicy.orig/policy/modules/apps/evolution.if
+++ refpolicy/policy/modules/apps/evolution.if
@@ -212,6 +212,7 @@ template(`evolution_per_role_template',`
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel($1_evolution_t)
 		corenet_udp_recv_netlabel($1_evolution_t)
+		corenet_raw_recv_netlabel($1_evolution_t)
 	')
 	# not sure about this bind
 	corenet_udp_bind_all_nodes($1_evolution_t)
@@ -728,6 +729,7 @@ template(`evolution_per_role_template',`
 	corenet_sendrecv_http_cache_client_packets($1_evolution_webcal_t)
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel($1_evolution_webcal_t)
+		corenet_raw_recv_netlabel($1_evolution_webcal_t)
 	')
 
 	# Networking capability - connect to website and handle ics link
Index: refpolicy/policy/modules/apps/gpg.if
===================================================================
--- refpolicy.orig/policy/modules/apps/gpg.if
+++ refpolicy/policy/modules/apps/gpg.if
@@ -178,6 +178,7 @@ template(`gpg_per_role_template',`
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel($1_gpg_helper_t)
 		corenet_udp_recv_netlabel($1_gpg_helper_t)
+		corenet_raw_recv_netlabel($1_gpg_helper_t)
 	')
 
 	dev_read_urand($1_gpg_helper_t)
Index: refpolicy/policy/modules/apps/mozilla.if
===================================================================
--- refpolicy.orig/policy/modules/apps/mozilla.if
+++ refpolicy/policy/modules/apps/mozilla.if
@@ -144,6 +144,7 @@ template(`mozilla_per_role_template',`
 	corenet_sendrecv_generic_client_packets($1_mozilla_t)
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel($1_mozilla_t)
+		corenet_raw_recv_netlabel($1_mozilla_t)
 	')
 	# Should not need other ports
 	corenet_dontaudit_tcp_sendrecv_generic_port($1_mozilla_t)
Index: refpolicy/policy/modules/apps/vmware.te
===================================================================
--- refpolicy.orig/policy/modules/apps/vmware.te
+++ refpolicy/policy/modules/apps/vmware.te
@@ -61,6 +61,7 @@ corenet_sendrecv_all_server_packets(vmwa
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(vmware_host_t)
 	corenet_udp_recv_netlabel(vmware_host_t)
+	corenet_raw_recv_netlabel(vmware_host_t)
 ')
 
 dev_read_sysfs(vmware_host_t)
Index: refpolicy/policy/modules/kernel/corenetwork.if.in
===================================================================
--- refpolicy.orig/policy/modules/kernel/corenetwork.if.in
+++ refpolicy/policy/modules/kernel/corenetwork.if.in
@@ -1512,6 +1512,35 @@ interface(`corenet_dontaudit_udp_recv_ne
 
 ########################################
 ## <summary>
+##      Receive Raw IP packets from a NetLabel connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corenet_raw_recv_netlabel',`
+	kernel_raw_recvfrom_unlabeled($1)
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive Raw IP packets from a NetLabel
+##      connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`corenet_dontaudit_raw_recv_netlabel',`
+	kernel_dontaudit_raw_recvfrom_unlabeled($1)
+')
+
+########################################
+## <summary>
 ##	Send generic client packets.
 ## </summary>
 ## <param name="domain">
Index: refpolicy/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy.orig/policy/modules/kernel/kernel.if
+++ refpolicy/policy/modules/kernel/kernel.if
@@ -2302,6 +2302,67 @@ interface(`kernel_dontaudit_udp_recvfrom
 
 ########################################
 ## <summary>
+##      Receive Raw IP packets from a NetLabel connection.
+## </summary>
+## <desc>
+##	<p>
+##      Receive Raw IP packets from a NetLabel connection, NetLabel is an
+##      explicit packet labeling framework which implements CIPSO and
+##      similar protocols.
+##      </p>
+##	<p>
+##	The corenetwork interface
+##	corenet_raw_recv_netlabel() should
+##	be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_raw_recvfrom_unlabeled',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	allow $1 unlabeled_t:rawip_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive Raw IP packets from a NetLabel
+##      connection.
+## </summary>
+## <desc>
+##	<p>
+##      Do not audit attempts to receive Raw IP packets from a NetLabel
+##      connection.  NetLabel is an explicit packet labeling framework
+##      which implements CIPSO and similar protocols.
+##      </p>
+##	<p>
+##	The corenetwork interface
+##	corenet_dontaudit_raw_recv_netlabel() should
+##	be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_raw_recvfrom_unlabeled',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	dontaudit $1 unlabeled_t:rawip_socket recvfrom;
+')
+
+########################################
+## <summary>
 ##	Send and receive unlabeled packets.
 ## </summary>
 ## <desc>
Index: refpolicy/policy/modules/services/arpwatch.te
===================================================================
--- refpolicy.orig/policy/modules/services/arpwatch.te
+++ refpolicy/policy/modules/services/arpwatch.te
@@ -60,6 +60,7 @@ corenet_udp_sendrecv_all_ports(arpwatch_
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(arpwatch_t)
 	corenet_udp_recv_netlabel(arpwatch_t)
+	corenet_raw_recv_netlabel(arpwatch_t)
 ')
 
 dev_read_sysfs(arpwatch_t)
Index: refpolicy/policy/modules/services/bluetooth.te
===================================================================
--- refpolicy.orig/policy/modules/services/bluetooth.te
+++ refpolicy/policy/modules/services/bluetooth.te
@@ -93,6 +93,7 @@ corenet_udp_sendrecv_all_ports(bluetooth
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(bluetooth_t)
 	corenet_udp_recv_netlabel(bluetooth_t)
+	corenet_raw_recv_netlabel(bluetooth_t)
 ')
 
 dev_read_sysfs(bluetooth_t)
Index: refpolicy/policy/modules/services/cups.te
===================================================================
--- refpolicy.orig/policy/modules/services/cups.te
+++ refpolicy/policy/modules/services/cups.te
@@ -159,6 +159,7 @@ corenet_sendrecv_ipp_server_packets(cups
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(cupsd_t)
 	corenet_udp_recv_netlabel(cupsd_t)
+	corenet_raw_recv_netlabel(cupsd_t)
 ')
 
 dev_rw_printer(cupsd_t)
@@ -603,6 +604,7 @@ corenet_receive_hplip_server_packets(hpl
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(hplip_t)
 	corenet_udp_recv_netlabel(hplip_t)
+	corenet_raw_recv_netlabel(hplip_t)
 ')
 
 dev_read_sysfs(hplip_t)
Index: refpolicy/policy/modules/services/dictd.te
===================================================================
--- refpolicy.orig/policy/modules/services/dictd.te
+++ refpolicy/policy/modules/services/dictd.te
@@ -52,6 +52,7 @@ corenet_sendrecv_dict_server_packets(dic
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(dictd_t)
 	corenet_udp_recv_netlabel(dictd_t)
+	corenet_raw_recv_netlabel(dictd_t)
 ')
 
 dev_read_sysfs(dictd_t)
Index: refpolicy/policy/modules/services/dnsmasq.te
===================================================================
--- refpolicy.orig/policy/modules/services/dnsmasq.te
+++ refpolicy/policy/modules/services/dnsmasq.te
@@ -61,6 +61,7 @@ corenet_sendrecv_dhcpd_server_packets(dn
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(dnsmasq_t)
 	corenet_udp_recv_netlabel(dnsmasq_t)
+	corenet_raw_recv_netlabel(dnsmasq_t)
 ')
 
 dev_read_sysfs(dnsmasq_t)
Index: refpolicy/policy/modules/services/mailman.if
===================================================================
--- refpolicy.orig/policy/modules/services/mailman.if
+++ refpolicy/policy/modules/services/mailman.if
@@ -64,6 +64,7 @@ template(`mailman_domain_template', `
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel(mailman_$1_t)
 		corenet_udp_recv_netlabel(mailman_$1_t)
+		corenet_raw_recv_netlabel(mailman_$1_t)
 	')
 
 	fs_getattr_xattr_fs(mailman_$1_t)
Index: refpolicy/policy/modules/services/nessus.te
===================================================================
--- refpolicy.orig/policy/modules/services/nessus.te
+++ refpolicy/policy/modules/services/nessus.te
@@ -74,6 +74,7 @@ corenet_sendrecv_nessus_server_packets(n
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(nessusd_t)
 	corenet_udp_recv_netlabel(nessusd_t)
+	corenet_raw_recv_netlabel(nessusd_t)
 ')
 
 dev_read_sysfs(nessusd_t)
Index: refpolicy/policy/modules/services/networkmanager.te
===================================================================
--- refpolicy.orig/policy/modules/services/networkmanager.te
+++ refpolicy/policy/modules/services/networkmanager.te
@@ -60,6 +60,7 @@ corenet_sendrecv_all_client_packets(Netw
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(NetworkManager_t)
 	corenet_udp_recv_netlabel(NetworkManager_t)
+	corenet_raw_recv_netlabel(NetworkManager_t)
 ')
 
 dev_read_sysfs(NetworkManager_t)
Index: refpolicy/policy/modules/services/ntop.te
===================================================================
--- refpolicy.orig/policy/modules/services/ntop.te
+++ refpolicy/policy/modules/services/ntop.te
@@ -73,6 +73,7 @@ corenet_udp_sendrecv_all_ports(ntop_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(ntop_t)
 	corenet_udp_recv_netlabel(ntop_t)
+	corenet_raw_recv_netlabel(ntop_t)
 ')
 
 dev_read_sysfs(ntop_t)
Index: refpolicy/policy/modules/services/portmap.te
===================================================================
--- refpolicy.orig/policy/modules/services/portmap.te
+++ refpolicy/policy/modules/services/portmap.te
@@ -151,6 +151,7 @@ corenet_tcp_connect_all_ports(portmap_he
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(portmap_helper_t)
 	corenet_udp_recv_netlabel(portmap_helper_t)
+	corenet_raw_recv_netlabel(portmap_helper_t)
 ')
 
 domain_dontaudit_use_interactive_fds(portmap_helper_t)
Index: refpolicy/policy/modules/services/ppp.te
===================================================================
--- refpolicy.orig/policy/modules/services/ppp.te
+++ refpolicy/policy/modules/services/ppp.te
@@ -122,6 +122,7 @@ corenet_udp_sendrecv_all_ports(pppd_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(pppd_t)
 	corenet_udp_recv_netlabel(pppd_t)
+	corenet_raw_recv_netlabel(pppd_t)
 ')
 # Access /dev/ppp.
 corenet_rw_ppp_dev(pppd_t)
@@ -276,6 +277,7 @@ corenet_tcp_connect_all_reserved_ports(p
 corenet_sendrecv_generic_client_packets(pptp_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(pptp_t)
+	corenet_raw_recv_netlabel(pptp_t)
 ')
 
 fs_getattr_all_fs(pptp_t)
Index: refpolicy/policy/modules/services/radvd.te
===================================================================
--- refpolicy.orig/policy/modules/services/radvd.te
+++ refpolicy/policy/modules/services/radvd.te
@@ -50,6 +50,7 @@ corenet_udp_sendrecv_all_ports(radvd_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(radvd_t)
 	corenet_udp_recv_netlabel(radvd_t)
+	corenet_raw_recv_netlabel(radvd_t)
 ')
 
 dev_read_sysfs(radvd_t)
Index: refpolicy/policy/modules/services/razor.if
===================================================================
--- refpolicy.orig/policy/modules/services/razor.if
+++ refpolicy/policy/modules/services/razor.if
@@ -72,6 +72,7 @@ template(`razor_common_domain_template',
 	corenet_tcp_sendrecv_razor_port($1_t)
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel($1_t)
+		corenet_raw_recv_netlabel($1_t)
 	')
 
 	# mktemp and other randoms
Index: refpolicy/policy/modules/services/razor.te
===================================================================
--- refpolicy.orig/policy/modules/services/razor.te
+++ refpolicy/policy/modules/services/razor.te
@@ -50,6 +50,7 @@ corenet_tcp_connect_razor_port(razor_t)
 corenet_sendrecv_razor_client_packets(razor_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(razor_t)
+	corenet_raw_recv_netlabel(razor_t)
 ')
 
 sysnet_read_config(razor_t)
Index: refpolicy/policy/modules/services/rdisc.te
===================================================================
--- refpolicy.orig/policy/modules/services/rdisc.te
+++ refpolicy/policy/modules/services/rdisc.te
@@ -34,6 +34,7 @@ corenet_raw_sendrecv_all_nodes(rdisc_t)
 corenet_udp_sendrecv_all_ports(rdisc_t)
 ifdef(`enable_mls',`
 	corenet_udp_recv_netlabel(rdisc_t)
+	corenet_raw_recv_netlabel(rdisc_t)
 ')
 
 dev_read_sysfs(rdisc_t)
Index: refpolicy/policy/modules/services/roundup.te
===================================================================
--- refpolicy.orig/policy/modules/services/roundup.te
+++ refpolicy/policy/modules/services/roundup.te
@@ -60,6 +60,7 @@ corenet_sendrecv_smtp_client_packets(rou
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(roundup_t)
 	corenet_udp_recv_netlabel(roundup_t)
+	corenet_raw_recv_netlabel(roundup_t)
 ')
 
 # /usr/share/mysql/charsets/Index.xml
Index: refpolicy/policy/modules/services/samba.te
===================================================================
--- refpolicy.orig/policy/modules/services/samba.te
+++ refpolicy/policy/modules/services/samba.te
@@ -126,6 +126,7 @@ corenet_tcp_connect_smbd_port(samba_net_
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(samba_net_t)
 	corenet_udp_recv_netlabel(samba_net_t)
+	corenet_raw_recv_netlabel(samba_net_t)
 ')
 
 dev_read_urand(samba_net_t)
@@ -240,6 +241,7 @@ corenet_tcp_connect_smbd_port(smbd_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(smbd_t)
 	corenet_udp_recv_netlabel(smbd_t)
+	corenet_raw_recv_netlabel(smbd_t)
 ')
 
 dev_read_sysfs(smbd_t)
@@ -477,6 +479,7 @@ corenet_tcp_connect_all_ports(smbmount_t
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(smbmount_t)
 	corenet_udp_recv_netlabel(smbmount_t)
+	corenet_raw_recv_netlabel(smbmount_t)
 ')
 
 fs_getattr_cifs(smbmount_t)
@@ -585,6 +588,7 @@ corenet_sendrecv_ipp_client_packets(swat
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(swat_t)
 	corenet_udp_recv_netlabel(swat_t)
+	corenet_raw_recv_netlabel(swat_t)
 ')
 
 dev_read_urand(swat_t)
@@ -685,6 +689,7 @@ corenet_tcp_connect_smbd_port(winbind_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(winbind_t)
 	corenet_udp_recv_netlabel(winbind_t)
+	corenet_raw_recv_netlabel(winbind_t)
 ')
 
 dev_read_sysfs(winbind_t)
Index: refpolicy/policy/modules/services/snort.te
===================================================================
--- refpolicy.orig/policy/modules/services/snort.te
+++ refpolicy/policy/modules/services/snort.te
@@ -67,6 +67,7 @@ corenet_udp_sendrecv_all_ports(snort_t)
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(snort_t)
 	corenet_udp_recv_netlabel(snort_t)
+	corenet_raw_recv_netlabel(snort_t)
 ')
 
 dev_read_sysfs(snort_t)
Index: refpolicy/policy/modules/services/ssh.if
===================================================================
--- refpolicy.orig/policy/modules/services/ssh.if
+++ refpolicy/policy/modules/services/ssh.if
@@ -489,6 +489,7 @@ template(`ssh_server_template', `
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel($1_t)
 		corenet_udp_recv_netlabel($1_t)
+		corenet_raw_recv_netlabel($1_t)
 	')
 
 	fs_dontaudit_getattr_all_fs($1_t)
Index: refpolicy/policy/modules/services/zebra.te
===================================================================
--- refpolicy.orig/policy/modules/services/zebra.te
+++ refpolicy/policy/modules/services/zebra.te
@@ -79,6 +79,7 @@ corenet_sendrecv_router_server_packets(z
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(zebra_t)
 	corenet_udp_recv_netlabel(zebra_t)
+	corenet_raw_recv_netlabel(zebra_t)
 ')
 
 dev_associate_usbfs(zebra_var_run_t)
Index: refpolicy/policy/modules/system/lvm.te
===================================================================
--- refpolicy.orig/policy/modules/system/lvm.te
+++ refpolicy/policy/modules/system/lvm.te
@@ -83,6 +83,7 @@ corenet_sendrecv_generic_server_packets(
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(clvmd_t)
 	corenet_udp_recv_netlabel(clvmd_t)
+	corenet_raw_recv_netlabel(clvmd_t)
 ')
 
 
Index: refpolicy/policy/modules/system/mount.te
===================================================================
--- refpolicy.orig/policy/modules/system/mount.te
+++ refpolicy/policy/modules/system/mount.te
@@ -154,6 +154,7 @@ optional_policy(`
 	ifdef(`enable_mls',`
 		corenet_tcp_recv_netlabel(mount_t)
 		corenet_udp_recv_netlabel(mount_t)
+		corenet_raw_recv_netlabel(mount_t)
 	')
 
 	fs_search_rpc(mount_t)

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
