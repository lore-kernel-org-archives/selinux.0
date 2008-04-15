Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3FD96bJ008518
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 09:09:06 -0400
Received: from relay1.gtri.gatech.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3FD95jo023385
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 13:09:05 GMT
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195])
	by relay1.gtri.gatech.edu (Spam Firewall) with ESMTP id AEF988FCF2
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 08:53:36 -0400 (EDT)
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195]) by relay1.gtri.gatech.edu with ESMTP id kqLYsBaaTsxysBtJ for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2008 08:53:34 -0400 (EDT)
Message-ID: <4804A54F.1020108@gtri.gatech.edu>
Date: Tue, 15 Apr 2008 08:53:35 -0400
From: Patrick Neely <patrick.neely@gtri.gatech.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [refpolicy] potential rsync patch
Content-Type: multipart/mixed;
	boundary="------------000104080008030008030908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------000104080008030008030908
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I was creating a module for a script that uses rsync.  I wanted to keep 
the program in the callers domain throughout, so I developed an 
interface for "rsync.if" that gives a domain the privileges it needs to 
execute a rsync without transitioning to the rsync domain.  Next, I 
replaced the appropriate te rules in the "rsync.te" with this interface 
which I called "can_rsync_notrans".

Finally, the transport mechanism I used for rsync was ssh, so I created 
a "can_rsync_over_ssh" interface and added that to the "rysnc.if" file.

This is my first attempt at doing something like this, so I am looking 
for feedback on how to make this more correct and more correctly 
styled.  It is my goal to get these interfaces incorporated into the 
reference policy.

Any help is greatly appreciated!

Patrick Neely

--------------000104080008030008030908
Content-Type: text/x-patch; name="rsync.if.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="rsync.if.patch"

This adds interfaces to the rsync module.

"can_rsync_notrans" allows other domains to run the rysnc command within the caller domain.
	- executing the rsync binary
	- sending and receiving packets
	- reading network state

"can_rsync_over_ssh" adds the ability to use rsync over ssh within the caller domain.
	- executing the ssh binary
	- connecting to ssh port

Additional rules are needed to enable public key authentication.

Index: policy/modules/services/rsync.te
===================================================================
--- policy/modules/services/rsync.te	(revision 2659)
+++ policy/modules/services/rsync.te	(working copy)
@@ -52,7 +52,6 @@
 # cjp: this should probably only be inetd_child_t rules?
 # search home and kerberos also.
 allow rsync_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
-allow rsync_t self:capability { setuid setgid };
 #end for identd
 
 allow rsync_t rsync_data_t:dir list_dir_perms;
@@ -66,44 +65,10 @@
 manage_files_pattern(rsync_t,rsync_var_run_t,rsync_var_run_t)
 files_pid_filetrans(rsync_t,rsync_var_run_t,file)
 
-kernel_read_kernel_sysctls(rsync_t)
-kernel_read_system_state(rsync_t)
-kernel_read_network_state(rsync_t)
-
-corenet_all_recvfrom_unlabeled(rsync_t)
-corenet_all_recvfrom_netlabel(rsync_t)
-corenet_tcp_sendrecv_all_if(rsync_t)
-corenet_udp_sendrecv_all_if(rsync_t)
-corenet_tcp_sendrecv_all_nodes(rsync_t)
-corenet_udp_sendrecv_all_nodes(rsync_t)
-corenet_tcp_sendrecv_all_ports(rsync_t)
-corenet_udp_sendrecv_all_ports(rsync_t)
-corenet_tcp_bind_all_nodes(rsync_t)
-corenet_tcp_bind_rsync_port(rsync_t)
-corenet_sendrecv_rsync_server_packets(rsync_t)
-
-dev_read_urand(rsync_t)
-
-fs_getattr_xattr_fs(rsync_t)
-
-files_read_etc_files(rsync_t)
-files_search_home(rsync_t)
-
-auth_use_nsswitch(rsync_t)
-
-libs_use_ld_so(rsync_t)
-libs_use_shared_libs(rsync_t)
-
-logging_send_syslog_msg(rsync_t)
 logging_dontaudit_search_logs(rsync_t)
 
-miscfiles_read_localization(rsync_t)
-miscfiles_read_public_files(rsync_t)
+can_rsync_notrans(rsync_t)
 
-tunable_policy(`allow_rsync_anon_write',`
-	miscfiles_manage_public_files(rsync_t)
-')
-
 optional_policy(`
 	daemontools_service_domain(rsync_t, rsync_exec_t)
 ')
Index: policy/modules/services/rsync.if
===================================================================
--- policy/modules/services/rsync.if	(revision 2659)
+++ policy/modules/services/rsync.if	(working copy)
@@ -103,3 +103,87 @@
 
 	can_exec($1,rsync_exec_t)
 ')
+
+############################################################
+## <summary>
+##	Allow calling domain to use rsync over ssh
+## </summary>
+## <desc>
+##	<p>
+##		Allows the supplied domain to execute rsync and use
+##		ssh as the underlying transport mechanism.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##		Domain allowed access
+##	</summary>
+## </param>
+#
+interface(`can_rsync_over_ssh',`
+
+	can_rsync_domain($1)
+	ssh_exec($1)
+	corenet_tcp_connect_ssh_port($1)
+
+')
+
+############################################################
+## <summary>
+##	Allow calling domain to execute rsync in calling domain
+## </summary>
+## <desc>
+##	<p>
+##		Allows the supplied domain required privileges to execute
+##		rsync without transitioning domains.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##		Domain allowed access
+##	</summary>
+## </param>
+#
+interface(`can_rsync_notrans',`
+
+	rsync_exec($1)
+	allow $1 self:capability { setuid setgid };
+
+	kernel_read_kernel_sysctls($1)
+	kernel_read_system_state($1)
+	kernel_read_network_state($1)
+
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
+	corenet_tcp_sendrecv_all_if($1)
+	corenet_udp_sendrecv_all_if($1)
+	corenet_tcp_sendrecv_all_nodes($1)
+	corenet_udp_sendrecv_all_nodes($1)
+	corenet_tcp_sendrecv_all_ports($1)
+	corenet_udp_sendrecv_all_ports($1)
+	corenet_tcp_bind_all_nodes($1)
+	corenet_tcp_bind_rsync_port($1)
+	corenet_sendrecv_rsync_server_packets($1)
+
+	dev_read_urand($1)
+	
+	fs_getattr_xattr_fs($1)
+	
+	files_read_etc_files($1)
+	files_search_home($1)
+	
+	auth_use_nsswitch($1)
+	
+	libs_use_ld_so($1)
+	libs_use_shared_libs($1)
+
+	logging_send_syslog_msg($1)
+
+	miscfiles_read_localization($1)
+	miscfiles_read_public_files($1)
+
+	tunable_policy(`allow_rsync_anon_write',`
+		miscfiles_manage_public_files($1)
+	')
+
+')

--------------000104080008030008030908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
