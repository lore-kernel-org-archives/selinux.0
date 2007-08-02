Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Ju7rX021124
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:56:07 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Ju6OD028243
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:56:06 GMT
Date: Thu, 2 Aug 2007 15:56:02 -0400
Message-Id: <200708021956.l72Ju2S3029420@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_vmware changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fixes for vmware
--- nsaserefpolicy/policy/modules/apps/vmware.fc	2007-07-03 07:05:43.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/vmware.fc	2007-08-02 11:02:02.000000000 -0400
@@ -23,6 +23,7 @@
 /usr/bin/vmware-smbd		--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-smbpasswd	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-smbpasswd\.bin	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
+/usr/bin/vmware-vmx		--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-wizard		--	gen_context(system_u:object_r:vmware_exec_t,s0)
 /usr/bin/vmware			--	gen_context(system_u:object_r:vmware_exec_t,s0)
 
--- nsaserefpolicy/policy/modules/apps/vmware.te	2007-07-25 10:37:37.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/vmware.te	2007-08-02 11:02:02.000000000 -0400
@@ -29,7 +29,7 @@
 
 allow vmware_host_t self:capability { setuid net_raw };
 dontaudit vmware_host_t self:capability sys_tty_config;
-allow vmware_host_t self:process signal_perms;
+allow vmware_host_t self:process { execstack execmem signal_perms };
 allow vmware_host_t self:fifo_file rw_fifo_file_perms;
 allow vmware_host_t self:unix_stream_socket create_stream_socket_perms;
 allow vmware_host_t self:rawip_socket create_socket_perms;
@@ -56,6 +56,8 @@
 corenet_tcp_sendrecv_all_ports(vmware_host_t)
 corenet_udp_sendrecv_all_ports(vmware_host_t)
 corenet_raw_bind_all_nodes(vmware_host_t)
+corenet_tcp_bind_all_nodes(vmware_host_t)
+corenet_udp_bind_all_nodes(vmware_host_t)
 corenet_tcp_connect_all_ports(vmware_host_t)
 corenet_sendrecv_all_client_packets(vmware_host_t)
 corenet_sendrecv_all_server_packets(vmware_host_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
