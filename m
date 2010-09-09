Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o89GUI5V012675
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2010 12:30:18 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o89GUGdm012853
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2010 16:30:16 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o89GToZX015670
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2010 12:29:51 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o89GTo1w015668
	for selinux@tycho.nsa.gov; Thu, 9 Sep 2010 12:29:50 -0400
Message-ID: <4C88F6BC.6080605@tycho.ncsc.mil>
Date: Thu, 09 Sep 2010 11:01:16 -0400
From: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: gscoker@alpha.ncsc.mil, Steve Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] refpolicy: hadoop
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  Added policy for the hadoop stack to refpolicy.  All major components 
of hadoop have been separated and confined (namenode, datanode, 
jobtracker, tasktracker, secondarynamenode, zookeeper).  Since many of 
the domains use the same executable to transfer into their domain, the 
init scripts were labelled with a custom initrc domain.   From there a 
domain transfer can occur using the same executable.  Since the domains 
share the same directory for logging and data files, type transfers were 
only done on files not directories.  JMX and the rest of hadoop can 
continue to run without a problem.  The policy was tested against 
Cloudera's version of hadoop CDH2 and CDH3.  An unconfined role 
transition was also needed to get hadoop in the correct domain.  Not 
sure if we want to add the zookeeper and namenode ports to refpolicy or 
use semanage.  I added them to refpolicy.

Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>

---
  policy/modules/apps/hadoop.fc                       |   10
  policy/modules/apps/hadoop.if                       |  211 
++++++++++++++++++++
  policy/modules/apps/hadoop.te                       |   91 ++++++++
  policy/modules/kernel/corenetwork.te.in             |    4
  policy/modules/services/hadoop_datanode.fc          |    5
  policy/modules/services/hadoop_datanode.if          |   19 +
  policy/modules/services/hadoop_datanode.te          |  118 +++++++++++
  policy/modules/services/hadoop_jobtracker.fc        |    5
  policy/modules/services/hadoop_jobtracker.if        |   18 +
  policy/modules/services/hadoop_jobtracker.te        |  119 +++++++++++
  policy/modules/services/hadoop_namenode.fc          |    6
  policy/modules/services/hadoop_namenode.if          |   18 +
  policy/modules/services/hadoop_namenode.te          |  117 +++++++++++
  policy/modules/services/hadoop_secondarynamenode.fc |    6
  policy/modules/services/hadoop_secondarynamenode.if |   19 +
  policy/modules/services/hadoop_secondarynamenode.te |  117 +++++++++++
  policy/modules/services/hadoop_tasktracker.fc       |    6
  policy/modules/services/hadoop_tasktracker.if       |   18 +
  policy/modules/services/hadoop_tasktracker.te       |  120 +++++++++++
  policy/modules/services/hadoop_zookeeper.fc         |   11 +
  policy/modules/services/hadoop_zookeeper.if         |   18 +
  policy/modules/services/hadoop_zookeeper.te         |  115 ++++++++++
  policy/modules/system/unconfined.if                 |   25 ++
  23 files changed, 1196 insertions(+)

diff --git a/policy/modules/system/unconfined.if 
b/policy/modules/system/unconfined.if
index 416e668..3364eb3 100644
--- a/policy/modules/system/unconfined.if
+++ b/policy/modules/system/unconfined.if
@@ -279,6 +279,31 @@ interface(`unconfined_domtrans_to',`

  ########################################
  ## <summary>
+##    Allow a program to enter the specified domain through the
+##     unconfined role.
+## </summary>
+## <desc>
+## <p>
+##    Allow unconfined role to execute the specified program in
+##    the specified domain.
+## </p>
+## </desc>
+## <param name="domain">
+## <summary>
+##    Domain to execute in.
+## </summary>
+## </param>
+#
+interface(`unconfined_roletrans',`
+    gen_require(`
+        role unconfined_r;
+    ')
+
+    role unconfined_r types $1;
+')
+
+########################################
+## <summary>
  ##    Allow unconfined to execute the specified program in
  ##    the specified domain.  Allow the specified domain the
  ##    unconfined role and use of unconfined user terminals.
diff --git a/policy/modules/kernel/corenetwork.te.in 
b/policy/modules/kernel/corenetwork.te.in
index 2ecdde8..549763c 100644
--- a/policy/modules/kernel/corenetwork.te.in
+++ b/policy/modules/kernel/corenetwork.te.in
@@ -105,6 +105,7 @@ network_port(giftd, tcp,1213,s0)
  network_port(git, tcp,9418,s0, udp,9418,s0)
  network_port(gopher, tcp,70,s0, udp,70,s0)
  network_port(gpsd, tcp,2947,s0)
+network_port(hadoop_namenode, tcp, 8020,s0)
  network_port(hddtemp, tcp,7634,s0)
  network_port(howl, tcp,5335,s0, udp,5353,s0)
  network_port(hplip, tcp,1782,s0, tcp,2207,s0, tcp,2208,s0, tcp, 
8290,s0, tcp,50000,s0, tcp,50002,s0, tcp,8292,s0, tcp,9100,s0, 
tcp,9101,s0, tcp,9102,s0, tcp,9220,s0, tcp,9221,s0, tcp,9222,s0, 
tcp,9280,s0, tcp,9281,s0, tcp,9282,s0, tcp,9290,s0, tcp,9291,s0, 
tcp,9292,s0)
diff --git a/policy/modules/services/hadoop_namenode.fc 
b/policy/modules/services/hadoop_namenode.fc
new file mode 100644
index 0000000..e1f9174
--- /dev/null
+++ b/policy/modules/services/hadoop_namenode.fc
@@ -0,0 +1,6 @@
+/etc/rc\.d/init\.d/hadoop-(.*)?-namenode    --    
gen_context(system_u:object_r:hadoop_namenode_initrc_exec_t, s0)
+
+/var/log/hadoop(.*)?/hadoop-hadoop-namenode-(.*)?    
gen_context(system_u:object_r:hadoop_namenode_log_t, s0)
+
+/var/lib/hadoop(.*)?/cache/hadoop/dfs/name(/.*)?    
gen_context(system_u:object_r:hadoop_namenode_data_t, s0)
+
diff --git a/policy/modules/services/hadoop_namenode.if 
b/policy/modules/services/hadoop_namenode.if
new file mode 100644
index 0000000..504a588
--- /dev/null
+++ b/policy/modules/services/hadoop_namenode.if
@@ -0,0 +1,18 @@
+## <summary>Hadoop Namenode Policy</summary>
+########################################
+## <summary>
+##  Give permission to a domain to signull hadoop_namenode_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_namenode_signull', `
+    gen_require(`
+        type hadoop_namenode_t;
+    ')
+
+    allow $1 hadoop_namenode_t:process { signull };
+')
diff --git a/policy/modules/services/hadoop_namenode.te 
b/policy/modules/services/hadoop_namenode.te
new file mode 100644
index 0000000..0c294ab
--- /dev/null
+++ b/policy/modules/services/hadoop_namenode.te
@@ -0,0 +1,117 @@
+policy_module(hadoop_namenode,1.0.0)
+
+attribute hadoop_namenode_domain;
+
+type hadoop_namenode_initrc_t;
+domain_type(hadoop_namenode_initrc_t)
+typeattribute hadoop_namenode_initrc_t hadoop_namenode_domain;
+
+type hadoop_namenode_initrc_exec_t;
+files_type(hadoop_namenode_initrc_exec_t)
+
+init_daemon_domain(hadoop_namenode_initrc_t, hadoop_namenode_initrc_exec_t)
+unconfined_domtrans_to(hadoop_namenode_initrc_t, 
hadoop_namenode_initrc_exec_t)
+allow hadoop_namenode_initrc_t self:capability { setuid setgid 
sys_tty_config};
+corecmd_exec_all_executables(hadoop_namenode_initrc_t)
+files_manage_generic_locks(hadoop_namenode_initrc_t)
+init_read_utmp(hadoop_namenode_initrc_t)
+init_write_utmp(hadoop_namenode_initrc_t)
+kernel_read_kernel_sysctls(hadoop_namenode_initrc_t)
+kernel_read_sysctl(hadoop_namenode_initrc_t)
+logging_send_syslog_msg(hadoop_namenode_initrc_t)
+logging_send_audit_msgs(hadoop_namenode_initrc_t)
+term_use_all_terms(hadoop_namenode_initrc_t)
+hadoop_manage_run(hadoop_namenode_initrc_t)
+allow hadoop_namenode_initrc_t hadoop_namenode_t:process { signull 
signal };
+
+type hadoop_namenode_t;
+typeattribute hadoop_namenode_t hadoop_namenode_domain;
+hadoop_runas(hadoop_namenode_initrc_t, hadoop_namenode_t)
+role system_r types hadoop_namenode_t;
+unconfined_roletrans(hadoop_namenode_t)
+unconfined_roletrans(hadoop_namenode_initrc_t)
+domain_type(hadoop_namenode_t)
+
+libs_use_ld_so(hadoop_namenode_domain)
+libs_use_shared_libs(hadoop_namenode_domain)
+miscfiles_read_localization(hadoop_namenode_domain)
+dev_read_urand(hadoop_namenode_domain)
+kernel_read_network_state(hadoop_namenode_domain)
+files_read_etc_files(hadoop_namenode_domain)
+files_read_usr_files(hadoop_namenode_domain)
+kernel_read_system_state(hadoop_namenode_domain)
+nscd_socket_use(hadoop_namenode_domain)
+java_exec(hadoop_namenode_domain)
+hadoop_rx_etc(hadoop_namenode_domain)
+hadoop_manage_log_dir(hadoop_namenode_domain)
+files_manage_generic_tmp_files(hadoop_namenode_domain)
+files_manage_generic_tmp_dirs(hadoop_namenode_domain)
+fs_getattr_xattr_fs(hadoop_namenode_domain)
+allow hadoop_namenode_domain self:process { execmem getsched setsched 
signal setrlimit };
+allow hadoop_namenode_domain self:fifo_file { read write getattr ioctl };
+allow hadoop_namenode_domain self:capability sys_resource;
+allow hadoop_namenode_domain self:key write;
+nis_use_ypbind(hadoop_namenode_domain)
+corenet_tcp_connect_portmap_port(hadoop_namenode_domain)
+userdom_dontaudit_search_user_home_dirs(hadoop_namenode_domain)
+files_dontaudit_search_spool(hadoop_namenode_domain)
+
+
+type hadoop_namenode_pid_t;
+files_pid_file(hadoop_namenode_pid_t)
+allow hadoop_namenode_domain hadoop_namenode_pid_t:file manage_file_perms;
+allow hadoop_namenode_domain hadoop_namenode_pid_t:dir rw_dir_perms;
+files_pid_filetrans(hadoop_namenode_domain,hadoop_namenode_pid_t,file)
+hadoop_transition_run_file(hadoop_namenode_initrc_t, hadoop_namenode_pid_t)
+
+type hadoop_namenode_log_t;
+logging_log_file(hadoop_namenode_log_t)
+allow hadoop_namenode_domain hadoop_namenode_log_t:file manage_file_perms;
+allow hadoop_namenode_domain hadoop_namenode_log_t:dir { setattr 
rw_dir_perms };
+logging_log_filetrans(hadoop_namenode_domain,hadoop_namenode_log_t,{file dir})
+hadoop_transition_log_file(hadoop_namenode_t, hadoop_namenode_log_t)
+hadoop_transition_log_file(hadoop_namenode_initrc_t, hadoop_namenode_log_t)
+
+type hadoop_namenode_data_t;
+files_type(hadoop_namenode_data_t)
+allow hadoop_namenode_t hadoop_namenode_data_t:file manage_file_perms;
+allow hadoop_namenode_t hadoop_namenode_data_t:dir manage_dir_perms;
+type_transition hadoop_namenode_t hadoop_data_t:file 
hadoop_namenode_data_t;
+
+type hadoop_namenode_tmp_t;
+files_tmp_file(hadoop_namenode_tmp_t)
+allow hadoop_namenode_t hadoop_namenode_tmp_t:file manage_file_perms;
+files_tmp_filetrans(hadoop_namenode_t, hadoop_namenode_tmp_t, file)
+
+corecmd_exec_bin(hadoop_namenode_t)
+corecmd_exec_shell(hadoop_namenode_t)
+dev_read_rand(hadoop_namenode_t)
+dev_read_sysfs(hadoop_namenode_t)
+files_read_var_lib_files(hadoop_namenode_t)
+hadoop_manage_data_dir(hadoop_namenode_t)
+hadoop_getattr_run_dir(hadoop_namenode_t)
+dontaudit hadoop_namenode_t self:netlink_route_socket { create ioctl 
read getattr write setattr append bind connect getopt setopt shutdown 
nlmsg_read nlmsg_write };
+
+allow hadoop_namenode_t self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_generic_if(hadoop_namenode_t)
+corenet_tcp_sendrecv_all_nodes(hadoop_namenode_t)
+corenet_all_recvfrom_unlabeled(hadoop_namenode_t)
+corenet_tcp_bind_all_nodes(hadoop_namenode_t)
+sysnet_read_config(hadoop_namenode_t)
+corenet_tcp_sendrecv_all_ports(hadoop_namenode_t)
+corenet_tcp_bind_all_ports(hadoop_namenode_t)
+corenet_tcp_connect_generic_port(hadoop_namenode_t)
+
+allow hadoop_namenode_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_generic_if(hadoop_namenode_t)
+corenet_udp_sendrecv_all_nodes(hadoop_namenode_t)
+corenet_udp_bind_all_nodes(hadoop_namenode_t)
+corenet_udp_bind_all_ports(hadoop_namenode_t)
+
+corenet_tcp_bind_hadoop_namenode_port(hadoop_namenode_t)
+corenet_tcp_connect_hadoop_namenode_port(hadoop_namenode_t)
+
+hadoop_datanode_signull(hadoop_namenode_t)
+hadoop_jobtracker_signull(hadoop_namenode_t)
+hadoop_secondarynamenode_signull(hadoop_namenode_t)
+hadoop_tasktracker_signull(hadoop_namenode_t)
diff --git a/policy/modules/apps/hadoop.fc b/policy/modules/apps/hadoop.fc
new file mode 100644
index 0000000..2fdd339
--- /dev/null
+++ b/policy/modules/apps/hadoop.fc
@@ -0,0 +1,10 @@
+/usr/bin/hadoop(.*)?         --    
gen_context(system_u:object_r:hadoop_exec_t,s0)
+
+/etc/hadoop(/.*)?            gen_context(system_u:object_r:hadoop_etc_t,s0)
+/etc/hadoop-0.20(/.*)?            
gen_context(system_u:object_r:hadoop_etc_t,s0)
+
+/var/lib/hadoop(.*)?            
gen_context(system_u:object_r:hadoop_data_t,s0)
+
+/var/log/hadoop(.*)?            
gen_context(system_u:object_r:hadoop_log_t,s0)
+
+/var/run/hadoop(.*)?            
gen_context(system_u:object_r:hadoop_run_t,s0)
diff --git a/policy/modules/apps/hadoop.if b/policy/modules/apps/hadoop.if
new file mode 100644
index 0000000..f2d7f20
--- /dev/null
+++ b/policy/modules/apps/hadoop.if
@@ -0,0 +1,211 @@
+## <summary> Hadoop client </summary>
+
+########################################
+## <summary>
+##  Create a domain that can transition with hadoop_exec_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Initial domain
+## </summary>
+## </param>
+## <param name="domain">
+## <summary>
+##  Domain to transfer to with hadoop_exec_t
+## </summary>
+## </param>
+#
+interface(`hadoop_runas', `
+    gen_require(`
+        type hadoop_exec_t;
+    ')
+
+    domtrans_pattern($1, hadoop_exec_t, $2)
+    domain_entry_file($2, hadoop_exec_t)
+')
+
+########################################
+## <summary>
+##  Give permission to a domain to access hadoop_etc_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing read and execute permission
+## </summary>
+## </param>
+#
+interface(`hadoop_rx_etc', `
+    gen_require(`
+        type hadoop_etc_t;
+    ')
+
+    allow $1 hadoop_etc_t:dir search_dir_perms;
+    allow $1 hadoop_etc_t:lnk_file { read getattr };
+    allow $1 hadoop_etc_t:file { read_file_perms execute execute_no_trans};
+')
+
+########################################
+## <summary>
+##  Transition from hadoop_log_t to desired log file type
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain that transfers file domains
+## </summary>
+## </param>
+## <param name="type">
+## <summary>
+##  Log file type
+## </summary>
+## </param>
+#
+interface(`hadoop_transition_log_file', `
+    gen_require(`
+        type hadoop_log_t;
+    ')
+
+    type_transition $1 hadoop_log_t:{ dir file } $2;
+')
+
+########################################
+## <summary>
+##  Transition from hadoop_tmp_t to desired log file type
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain that transfers file domains
+## </summary>
+## </param>
+## <param name="type">
+## <summary>
+##  Log file type
+## </summary>
+## </param>
+#
+interface(`hadoop_transition_tmp_file', `
+    gen_require(`
+        type hadoop_tmp_t;
+    ')
+
+    type_transition $1 hadoop_tmp_t:file $2;
+')
+
+########################################
+## <summary>
+##  Transition from hadoop_run_t to desired log file type
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain that transfers file domains
+## </summary>
+## </param>
+## <param name="type">
+## <summary>
+##  Run file type
+## </summary>
+## </param>
+#
+interface(`hadoop_transition_run_file', `
+    gen_require(`
+        type hadoop_run_t;
+    ')
+
+    type_transition $1 hadoop_run_t:file $2;
+')
+
+########################################
+## <summary>
+##  Transition from hadoop_data_t to desired data file type
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain that transfers file domains
+## </summary>
+## </param>
+## <param name="type">
+## <summary>
+##  Run file type
+## </summary>
+## </param>
+#
+interface(`hadoop_transition_data_file', `
+    gen_require(`
+        type hadoop_data_t;
+    ')
+
+    type_transition $1 hadoop_data_t:{ dir file } $2;
+')
+
+########################################
+## <summary>
+##  Give permission to a domain to access hadoop_data_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_manage_data_dir', `
+    gen_require(`
+        type hadoop_data_t;
+    ')
+
+    manage_dirs_pattern($1, hadoop_data_t, hadoop_data_t)
+')
+
+########################################
+## <summary>
+##  Give permission to a domain to access hadoop_log_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_manage_log_dir', `
+    gen_require(`
+        type hadoop_log_t;
+    ')
+
+    manage_dirs_pattern($1, hadoop_log_t, hadoop_log_t)
+')
+
+########################################
+## <summary>
+##  Give permission to a domain to manage hadoop_run_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_manage_run', `
+    gen_require(`
+        type hadoop_run_t;
+    ')
+
+    manage_dirs_pattern($1, hadoop_run_t, hadoop_run_t)
+    manage_files_pattern($1, hadoop_run_t, hadoop_run_t)
+')
+
+########################################
+## <summary>
+##  Give permission to a domain to getattr hadoop_run_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_getattr_run_dir', `
+    gen_require(`
+        type hadoop_run_t;
+    ')
+
+    allow $1 hadoop_run_t:dir getattr;
+')
+
diff --git a/policy/modules/apps/hadoop.te b/policy/modules/apps/hadoop.te
new file mode 100644
index 0000000..dbb7189
--- /dev/null
+++ b/policy/modules/apps/hadoop.te
@@ -0,0 +1,91 @@
+policy_module(hadoop,1.0.0)
+
+type hadoop_t;
+domain_type(hadoop_t)
+
+type hadoop_exec_t;
+unconfined_domtrans_to(hadoop_t, hadoop_exec_t)
+allow hadoop_t hadoop_exec_t:file { read_file_perms entrypoint execute 
execute_no_trans };
+allow hadoop_t hadoop_exec_t:lnk_file { read };
+unconfined_roletrans(hadoop_t)
+
+type hadoop_etc_t;
+files_type(hadoop_etc_t)
+
+type hadoop_data_t;
+files_type(hadoop_data_t)
+manage_files_pattern(hadoop_t, hadoop_data_t, hadoop_data_t)
+hadoop_manage_data_dir(hadoop_t)
+
+type hadoop_log_t;
+files_type(hadoop_log_t)
+
+type hadoop_run_t;
+files_type(hadoop_run_t)
+
+type hadoop_tmp_t;
+files_tmp_file(hadoop_tmp_t)
+allow hadoop_t hadoop_tmp_t:dir manage_dir_perms;
+allow hadoop_t hadoop_tmp_t:file manage_file_perms;
+
+libs_use_ld_so(hadoop_t)
+libs_use_shared_libs(hadoop_t)
+corecmd_exec_bin(hadoop_t)
+corecmd_exec_shell(hadoop_t)
+miscfiles_read_localization(hadoop_t)
+dev_read_urand(hadoop_t)
+kernel_read_network_state(hadoop_t)
+kernel_read_system_state(hadoop_t)
+files_read_etc_files(hadoop_t)
+files_manage_generic_tmp_files(hadoop_t)
+files_manage_generic_tmp_dirs(hadoop_t)
+fs_getattr_xattr_fs(hadoop_t)
+allow hadoop_t self:process { execmem getsched setsched signal setrlimit };
+allow hadoop_t self:fifo_file { read write getattr ioctl };
+allow hadoop_t self:capability sys_resource;
+allow hadoop_t self:key write;
+nis_use_ypbind(hadoop_t)
+nscd_socket_use(hadoop_t)
+corenet_tcp_connect_portmap_port(hadoop_t)
+userdom_dontaudit_search_user_home_dirs(hadoop_t)
+files_dontaudit_search_spool(hadoop_t)
+java_exec(hadoop_t)
+hadoop_rx_etc(hadoop_t)
+hadoop_manage_log_dir(hadoop_t)
+
+dev_read_rand(hadoop_t)
+dev_read_sysfs(hadoop_t)
+files_read_var_lib_files(hadoop_t)
+hadoop_manage_data_dir(hadoop_t)
+hadoop_getattr_run_dir(hadoop_t)
+dontaudit hadoop_t self:netlink_route_socket { create ioctl read 
getattr write setattr append bind connect getopt setopt shutdown 
nlmsg_read nlmsg_write };
+
+allow hadoop_t self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_generic_if(hadoop_t)
+corenet_tcp_sendrecv_all_nodes(hadoop_t)
+corenet_all_recvfrom_unlabeled(hadoop_t)
+corenet_tcp_bind_all_nodes(hadoop_t)
+sysnet_read_config(hadoop_t)
+corenet_tcp_sendrecv_all_ports(hadoop_t)
+corenet_tcp_bind_all_ports(hadoop_t)
+corenet_tcp_connect_generic_port(hadoop_t)
+
+allow hadoop_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_generic_if(hadoop_t)
+corenet_udp_sendrecv_all_nodes(hadoop_t)
+corenet_udp_bind_all_nodes(hadoop_t)
+corenet_udp_bind_all_ports(hadoop_t)
+
+files_read_usr_files(hadoop_t)
+files_read_all_files(hadoop_t)
+term_use_all_terms(hadoop_t)
+
+corenet_tcp_connect_zope_port(hadoop_t)
+corenet_tcp_connect_hadoop_namenode_port(hadoop_t)
+
+hadoop_namenode_signull(hadoop_t)
+hadoop_datanode_signull(hadoop_t)
+hadoop_jobtracker_signull(hadoop_t)
+hadoop_secondarynamenode_signull(hadoop_t)
+hadoop_tasktracker_signull(hadoop_t)
+
diff --git a/policy/modules/services/hadoop_datanode.fc 
b/policy/modules/services/hadoop_datanode.fc
new file mode 100644
index 0000000..9bb7ebe
--- /dev/null
+++ b/policy/modules/services/hadoop_datanode.fc
@@ -0,0 +1,5 @@
+/etc/rc\.d/init\.d/hadoop-(.*)?-datanode    --   
gen_context(system_u:object_r:hadoop_datanode_initrc_exec_t, s0)
+
+/var/log/hadoop(.*)?/hadoop-hadoop-datanode-(.*)?    
gen_context(system_u:object_r:hadoop_datanode_log_t, s0)
+
+/var/lib/hadoop(.*)?/cache/hadoop/dfs/data(/.*)?     
gen_context(system_u:object_r:hadoop_datanode_data_t, s0)
diff --git a/policy/modules/services/hadoop_datanode.if 
b/policy/modules/services/hadoop_datanode.if
new file mode 100644
index 0000000..c1569eb
--- /dev/null
+++ b/policy/modules/services/hadoop_datanode.if
@@ -0,0 +1,19 @@
+## <summary>Hadoop DataNode</summary>
+
+########################################
+## <summary>
+##  Give permission to a domain to signull hadoop_datanode_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_datanode_signull', `
+    gen_require(`
+        type hadoop_datanode_t;
+    ')
+
+    allow $1 hadoop_datanode_t:process { signull };
+')
diff --git a/policy/modules/services/hadoop_datanode.te 
b/policy/modules/services/hadoop_datanode.te
new file mode 100644
index 0000000..2b148d2
--- /dev/null
+++ b/policy/modules/services/hadoop_datanode.te
@@ -0,0 +1,118 @@
+policy_module(hadoop_datanode,1.0.0)
+
+attribute hadoop_datanode_domain;
+
+type hadoop_datanode_initrc_t;
+domain_type(hadoop_datanode_initrc_t)
+typeattribute hadoop_datanode_initrc_t hadoop_datanode_domain;
+
+type hadoop_datanode_initrc_exec_t;
+files_type(hadoop_datanode_initrc_exec_t)
+
+init_daemon_domain(hadoop_datanode_initrc_t, hadoop_datanode_initrc_exec_t)
+unconfined_domtrans_to(hadoop_datanode_initrc_t, 
hadoop_datanode_initrc_exec_t)
+allow hadoop_datanode_initrc_t self:capability { setuid setgid 
sys_tty_config};
+corecmd_exec_all_executables(hadoop_datanode_initrc_t)
+files_manage_generic_locks(hadoop_datanode_initrc_t)
+init_read_utmp(hadoop_datanode_initrc_t)
+init_write_utmp(hadoop_datanode_initrc_t)
+kernel_read_kernel_sysctls(hadoop_datanode_initrc_t)
+kernel_read_sysctl(hadoop_datanode_initrc_t)
+logging_send_syslog_msg(hadoop_datanode_initrc_t)
+logging_send_audit_msgs(hadoop_datanode_initrc_t)
+term_use_all_terms(hadoop_datanode_initrc_t)
+hadoop_manage_run(hadoop_datanode_initrc_t)
+allow hadoop_datanode_initrc_t hadoop_datanode_t:process { signull 
signal };
+
+type hadoop_datanode_t;
+typeattribute hadoop_datanode_t hadoop_datanode_domain;
+hadoop_runas(hadoop_datanode_initrc_t, hadoop_datanode_t)
+role system_r types hadoop_datanode_t;
+unconfined_roletrans(hadoop_datanode_t)
+unconfined_roletrans(hadoop_datanode_initrc_t)
+domain_type(hadoop_datanode_t)
+
+libs_use_ld_so(hadoop_datanode_domain)
+libs_use_shared_libs(hadoop_datanode_domain)
+miscfiles_read_localization(hadoop_datanode_domain)
+dev_read_urand(hadoop_datanode_domain)
+kernel_read_network_state(hadoop_datanode_domain)
+files_read_etc_files(hadoop_datanode_domain)
+files_read_usr_files(hadoop_datanode_domain)
+kernel_read_system_state(hadoop_datanode_domain)
+nscd_socket_use(hadoop_datanode_domain)
+java_exec(hadoop_datanode_domain)
+hadoop_rx_etc(hadoop_datanode_domain)
+hadoop_manage_log_dir(hadoop_datanode_domain)
+files_manage_generic_tmp_files(hadoop_datanode_domain)
+files_manage_generic_tmp_dirs(hadoop_datanode_domain)
+fs_getattr_xattr_fs(hadoop_datanode_domain)
+allow hadoop_datanode_domain self:process { execmem getsched setsched 
signal setrlimit };
+allow hadoop_datanode_domain self:fifo_file { read write getattr ioctl };
+allow hadoop_datanode_domain self:capability sys_resource;
+allow hadoop_datanode_domain self:key write;
+nis_use_ypbind(hadoop_datanode_domain)
+corenet_tcp_connect_portmap_port(hadoop_datanode_domain)
+userdom_dontaudit_search_user_home_dirs(hadoop_datanode_domain)
+files_dontaudit_search_spool(hadoop_datanode_domain)
+
+
+type hadoop_datanode_pid_t;
+files_pid_file(hadoop_datanode_pid_t)
+allow hadoop_datanode_domain hadoop_datanode_pid_t:file manage_file_perms;
+allow hadoop_datanode_domain hadoop_datanode_pid_t:dir rw_dir_perms;
+files_pid_filetrans(hadoop_datanode_domain,hadoop_datanode_pid_t,file)
+hadoop_transition_run_file(hadoop_datanode_initrc_t, hadoop_datanode_pid_t)
+
+type hadoop_datanode_log_t;
+logging_log_file(hadoop_datanode_log_t)
+allow hadoop_datanode_domain hadoop_datanode_log_t:file manage_file_perms;
+allow hadoop_datanode_domain hadoop_datanode_log_t:dir { setattr 
rw_dir_perms };
+logging_log_filetrans(hadoop_datanode_domain,hadoop_datanode_log_t,{file dir})
+hadoop_transition_log_file(hadoop_datanode_t, hadoop_datanode_log_t)
+hadoop_transition_log_file(hadoop_datanode_initrc_t, hadoop_datanode_log_t)
+
+type hadoop_datanode_data_t;
+files_type(hadoop_datanode_data_t)
+allow hadoop_datanode_t hadoop_datanode_data_t:file manage_file_perms;
+allow hadoop_datanode_t hadoop_datanode_data_t:dir manage_dir_perms;
+type_transition hadoop_datanode_t hadoop_data_t:file 
hadoop_datanode_data_t;
+
+type hadoop_datanode_tmp_t;
+files_tmp_file(hadoop_datanode_tmp_t)
+allow hadoop_datanode_t hadoop_datanode_tmp_t:file manage_file_perms;
+files_tmp_filetrans(hadoop_datanode_t, hadoop_datanode_tmp_t, file)
+
+corecmd_exec_bin(hadoop_datanode_t)
+corecmd_exec_shell(hadoop_datanode_t)
+dev_read_rand(hadoop_datanode_t)
+dev_read_sysfs(hadoop_datanode_t)
+files_read_var_lib_files(hadoop_datanode_t)
+hadoop_manage_data_dir(hadoop_datanode_t)
+hadoop_getattr_run_dir(hadoop_datanode_t)
+dontaudit hadoop_datanode_t self:netlink_route_socket { create ioctl 
read getattr write setattr append bind connect getopt setopt shutdown 
nlmsg_read nlmsg_write };
+
+allow hadoop_datanode_t self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_generic_if(hadoop_datanode_t)
+corenet_tcp_sendrecv_all_nodes(hadoop_datanode_t)
+corenet_all_recvfrom_unlabeled(hadoop_datanode_t)
+corenet_tcp_bind_all_nodes(hadoop_datanode_t)
+sysnet_read_config(hadoop_datanode_t)
+corenet_tcp_sendrecv_all_ports(hadoop_datanode_t)
+corenet_tcp_bind_all_ports(hadoop_datanode_t)
+corenet_tcp_connect_generic_port(hadoop_datanode_t)
+
+allow hadoop_datanode_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_generic_if(hadoop_datanode_t)
+corenet_udp_sendrecv_all_nodes(hadoop_datanode_t)
+corenet_udp_bind_all_nodes(hadoop_datanode_t)
+corenet_udp_bind_all_ports(hadoop_datanode_t)
+
+fs_getattr_xattr_fs(hadoop_datanode_t)
+corenet_tcp_connect_hadoop_namenode_port(hadoop_datanode_t)
+
+hadoop_namenode_signull(hadoop_datanode_t)
+hadoop_jobtracker_signull(hadoop_datanode_t)
+hadoop_secondarynamenode_signull(hadoop_datanode_t)
+hadoop_tasktracker_signull(hadoop_datanode_t)
+
diff --git a/policy/modules/services/hadoop_jobtracker.fc 
b/policy/modules/services/hadoop_jobtracker.fc
new file mode 100644
index 0000000..17dcef7
--- /dev/null
+++ b/policy/modules/services/hadoop_jobtracker.fc
@@ -0,0 +1,5 @@
+/etc/rc\.d/init\.d/hadoop-(.*)?-jobtracker            --    
gen_context(system_u:object_r:hadoop_jobtracker_initrc_exec_t, s0)
+
+/var/log/hadoop(.*)?/hadoop-hadoop-jobtracker-(.*)?            
gen_context(system_u:object_r:hadoop_jobtracker_log_t, s0)
+
+/var/lib/hadoop(.*)?/cache/hadoop/mapred/local/jobTracker(/.*)?       
gen_context(system_u:object_r:hadoop_jobtracker_data_t, s0)
diff --git a/policy/modules/services/hadoop_jobtracker.if 
b/policy/modules/services/hadoop_jobtracker.if
new file mode 100644
index 0000000..028072f
--- /dev/null
+++ b/policy/modules/services/hadoop_jobtracker.if
@@ -0,0 +1,18 @@
+## <summary>Hadoop JobTracker</summary>
+########################################
+## <summary>
+##  Give permission to a domain to signull hadoop_jobtracker_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_jobtracker_signull', `
+    gen_require(`
+        type hadoop_jobtracker_t;
+    ')
+
+    allow $1 hadoop_jobtracker_t:process { signull };
+')
diff --git a/policy/modules/services/hadoop_jobtracker.te 
b/policy/modules/services/hadoop_jobtracker.te
new file mode 100644
index 0000000..6e15d2f
--- /dev/null
+++ b/policy/modules/services/hadoop_jobtracker.te
@@ -0,0 +1,119 @@
+policy_module(hadoop_jobtracker,1.0.0)
+
+attribute hadoop_jobtracker_domain;
+
+type hadoop_jobtracker_initrc_t;
+domain_type(hadoop_jobtracker_initrc_t)
+typeattribute hadoop_jobtracker_initrc_t hadoop_jobtracker_domain;
+
+type hadoop_jobtracker_initrc_exec_t;
+files_type(hadoop_jobtracker_initrc_exec_t)
+
+init_daemon_domain(hadoop_jobtracker_initrc_t, 
hadoop_jobtracker_initrc_exec_t)
+unconfined_domtrans_to(hadoop_jobtracker_initrc_t, 
hadoop_jobtracker_initrc_exec_t)
+allow hadoop_jobtracker_initrc_t self:capability { setuid setgid 
sys_tty_config};
+corecmd_exec_all_executables(hadoop_jobtracker_initrc_t)
+files_manage_generic_locks(hadoop_jobtracker_initrc_t)
+init_read_utmp(hadoop_jobtracker_initrc_t)
+init_write_utmp(hadoop_jobtracker_initrc_t)
+kernel_read_kernel_sysctls(hadoop_jobtracker_initrc_t)
+kernel_read_sysctl(hadoop_jobtracker_initrc_t)
+logging_send_syslog_msg(hadoop_jobtracker_initrc_t)
+logging_send_audit_msgs(hadoop_jobtracker_initrc_t)
+term_use_all_terms(hadoop_jobtracker_initrc_t)
+hadoop_manage_run(hadoop_jobtracker_initrc_t)
+allow hadoop_jobtracker_initrc_t hadoop_jobtracker_t:process { signull 
signal };
+
+type hadoop_jobtracker_t;
+typeattribute hadoop_jobtracker_t hadoop_jobtracker_domain;
+hadoop_runas(hadoop_jobtracker_initrc_t, hadoop_jobtracker_t)
+role system_r types hadoop_jobtracker_t;
+unconfined_roletrans(hadoop_jobtracker_t)
+unconfined_roletrans(hadoop_jobtracker_initrc_t)
+domain_type(hadoop_jobtracker_t)
+
+libs_use_ld_so(hadoop_jobtracker_domain)
+libs_use_shared_libs(hadoop_jobtracker_domain)
+miscfiles_read_localization(hadoop_jobtracker_domain)
+dev_read_urand(hadoop_jobtracker_domain)
+kernel_read_network_state(hadoop_jobtracker_domain)
+files_read_etc_files(hadoop_jobtracker_domain)
+files_read_usr_files(hadoop_jobtracker_domain)
+kernel_read_system_state(hadoop_jobtracker_domain)
+nscd_socket_use(hadoop_jobtracker_domain)
+java_exec(hadoop_jobtracker_domain)
+hadoop_rx_etc(hadoop_jobtracker_domain)
+hadoop_manage_log_dir(hadoop_jobtracker_domain)
+files_manage_generic_tmp_files(hadoop_jobtracker_domain)
+files_manage_generic_tmp_dirs(hadoop_jobtracker_domain)
+fs_getattr_xattr_fs(hadoop_jobtracker_domain)
+allow hadoop_jobtracker_domain self:process { execmem getsched setsched 
signal setrlimit };
+allow hadoop_jobtracker_domain self:fifo_file { read write getattr ioctl };
+allow hadoop_jobtracker_domain self:capability sys_resource;
+allow hadoop_jobtracker_domain self:key write;
+nis_use_ypbind(hadoop_jobtracker_domain)
+corenet_tcp_connect_portmap_port(hadoop_jobtracker_domain)
+userdom_dontaudit_search_user_home_dirs(hadoop_jobtracker_domain)
+files_dontaudit_search_spool(hadoop_jobtracker_domain)
+
+
+type hadoop_jobtracker_pid_t;
+files_pid_file(hadoop_jobtracker_pid_t)
+allow hadoop_jobtracker_domain hadoop_jobtracker_pid_t:file 
manage_file_perms;
+allow hadoop_jobtracker_domain hadoop_jobtracker_pid_t:dir rw_dir_perms;
+files_pid_filetrans(hadoop_jobtracker_domain,hadoop_jobtracker_pid_t,file)
+hadoop_transition_run_file(hadoop_jobtracker_initrc_t, 
hadoop_jobtracker_pid_t)
+
+type hadoop_jobtracker_log_t;
+logging_log_file(hadoop_jobtracker_log_t)
+allow hadoop_jobtracker_domain hadoop_jobtracker_log_t:file 
manage_file_perms;
+allow hadoop_jobtracker_domain hadoop_jobtracker_log_t:dir { setattr 
rw_dir_perms };
+logging_log_filetrans(hadoop_jobtracker_domain,hadoop_jobtracker_log_t,{file 
dir})
+hadoop_transition_log_file(hadoop_jobtracker_t, hadoop_jobtracker_log_t)
+hadoop_transition_log_file(hadoop_jobtracker_initrc_t, 
hadoop_jobtracker_log_t)
+
+type hadoop_jobtracker_data_t;
+files_type(hadoop_jobtracker_data_t)
+allow hadoop_jobtracker_t hadoop_jobtracker_data_t:file manage_file_perms;
+allow hadoop_jobtracker_t hadoop_jobtracker_data_t:dir manage_dir_perms;
+type_transition hadoop_jobtracker_t hadoop_data_t:file 
hadoop_jobtracker_data_t;
+
+type hadoop_jobtracker_tmp_t;
+files_tmp_file(hadoop_jobtracker_tmp_t)
+allow hadoop_jobtracker_t hadoop_jobtracker_tmp_t:file manage_file_perms;
+files_tmp_filetrans(hadoop_jobtracker_t, hadoop_jobtracker_tmp_t, file)
+
+corecmd_exec_bin(hadoop_jobtracker_t)
+corecmd_exec_shell(hadoop_jobtracker_t)
+dev_read_rand(hadoop_jobtracker_t)
+dev_read_sysfs(hadoop_jobtracker_t)
+files_read_var_lib_files(hadoop_jobtracker_t)
+hadoop_manage_data_dir(hadoop_jobtracker_t)
+hadoop_getattr_run_dir(hadoop_jobtracker_t)
+dontaudit hadoop_jobtracker_t self:netlink_route_socket { create ioctl 
read getattr write setattr append bind connect getopt setopt shutdown 
nlmsg_read nlmsg_write };
+
+allow hadoop_jobtracker_t self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_generic_if(hadoop_jobtracker_t)
+corenet_tcp_sendrecv_all_nodes(hadoop_jobtracker_t)
+corenet_all_recvfrom_unlabeled(hadoop_jobtracker_t)
+corenet_tcp_bind_all_nodes(hadoop_jobtracker_t)
+sysnet_read_config(hadoop_jobtracker_t)
+corenet_tcp_sendrecv_all_ports(hadoop_jobtracker_t)
+corenet_tcp_bind_all_ports(hadoop_jobtracker_t)
+corenet_tcp_connect_generic_port(hadoop_jobtracker_t)
+
+allow hadoop_jobtracker_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_generic_if(hadoop_jobtracker_t)
+corenet_udp_sendrecv_all_nodes(hadoop_jobtracker_t)
+corenet_udp_bind_all_nodes(hadoop_jobtracker_t)
+corenet_udp_bind_all_ports(hadoop_jobtracker_t)
+
+nscd_dontaudit_search_pid(hadoop_jobtracker_t)
+corenet_tcp_bind_zope_port(hadoop_jobtracker_t)
+corenet_tcp_connect_hadoop_namenode_port(hadoop_jobtracker_t)
+
+hadoop_datanode_signull(hadoop_jobtracker_t)
+hadoop_namenode_signull(hadoop_jobtracker_t)
+hadoop_secondarynamenode_signull(hadoop_jobtracker_t)
+hadoop_tasktracker_signull(hadoop_jobtracker_t)
+
diff --git a/policy/modules/services/hadoop_secondarynamenode.fc 
b/policy/modules/services/hadoop_secondarynamenode.fc
new file mode 100644
index 0000000..f1b200c
--- /dev/null
+++ b/policy/modules/services/hadoop_secondarynamenode.fc
@@ -0,0 +1,6 @@
+/etc/rc\.d/init\.d/hadoop-(.*)?-secondarynamenode    --    
gen_context(system_u:object_r:hadoop_secondarynamenode_initrc_exec_t, s0)
+
+/var/log/hadoop(.*)?/hadoop-hadoop-secondarynamenode-(.*)?    
gen_context(system_u:object_r:hadoop_secondarynamenode_log_t, s0)
+
+/var/lib/hadoop(.*)?/cache/hadoop/dfs/namesecondary(/.*)?    
gen_context(system_u:object_r:hadoop_secondarynamenode_data_t, s0)
+
diff --git a/policy/modules/services/hadoop_secondarynamenode.if 
b/policy/modules/services/hadoop_secondarynamenode.if
new file mode 100644
index 0000000..17c10e9
--- /dev/null
+++ b/policy/modules/services/hadoop_secondarynamenode.if
@@ -0,0 +1,19 @@
+## <summary>Hadoop Secondary Namenode</summary>
+
+########################################
+## <summary>
+##  Give permission to a domain to signull hadoop_secondarynamenode_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_secondarynamenode_signull', `
+    gen_require(`
+        type hadoop_secondarynamenode_t;
+    ')
+
+    allow $1 hadoop_secondarynamenode_t:process { signull };
+')
diff --git a/policy/modules/services/hadoop_secondarynamenode.te 
b/policy/modules/services/hadoop_secondarynamenode.te
new file mode 100644
index 0000000..9288bfe
--- /dev/null
+++ b/policy/modules/services/hadoop_secondarynamenode.te
@@ -0,0 +1,117 @@
+policy_module(hadoop_secondarynamenode,1.0.0)
+
+attribute hadoop_secondarynamenode_domain;
+
+type hadoop_secondarynamenode_initrc_t;
+domain_type(hadoop_secondarynamenode_initrc_t)
+typeattribute hadoop_secondarynamenode_initrc_t 
hadoop_secondarynamenode_domain;
+
+type hadoop_secondarynamenode_initrc_exec_t;
+files_type(hadoop_secondarynamenode_initrc_exec_t)
+
+init_daemon_domain(hadoop_secondarynamenode_initrc_t, 
hadoop_secondarynamenode_initrc_exec_t)
+unconfined_domtrans_to(hadoop_secondarynamenode_initrc_t, 
hadoop_secondarynamenode_initrc_exec_t)
+allow hadoop_secondarynamenode_initrc_t self:capability { setuid setgid 
sys_tty_config};
+corecmd_exec_all_executables(hadoop_secondarynamenode_initrc_t)
+files_manage_generic_locks(hadoop_secondarynamenode_initrc_t)
+init_read_utmp(hadoop_secondarynamenode_initrc_t)
+init_write_utmp(hadoop_secondarynamenode_initrc_t)
+kernel_read_kernel_sysctls(hadoop_secondarynamenode_initrc_t)
+kernel_read_sysctl(hadoop_secondarynamenode_initrc_t)
+logging_send_syslog_msg(hadoop_secondarynamenode_initrc_t)
+logging_send_audit_msgs(hadoop_secondarynamenode_initrc_t)
+term_use_all_terms(hadoop_secondarynamenode_initrc_t)
+hadoop_manage_run(hadoop_secondarynamenode_initrc_t)
+allow hadoop_secondarynamenode_initrc_t 
hadoop_secondarynamenode_t:process { signull signal };
+
+type hadoop_secondarynamenode_t;
+typeattribute hadoop_secondarynamenode_t hadoop_secondarynamenode_domain;
+hadoop_runas(hadoop_secondarynamenode_initrc_t, hadoop_secondarynamenode_t)
+role system_r types hadoop_secondarynamenode_t;
+unconfined_roletrans(hadoop_secondarynamenode_t)
+unconfined_roletrans(hadoop_secondarynamenode_initrc_t)
+domain_type(hadoop_secondarynamenode_t)
+
+libs_use_ld_so(hadoop_secondarynamenode_domain)
+libs_use_shared_libs(hadoop_secondarynamenode_domain)
+miscfiles_read_localization(hadoop_secondarynamenode_domain)
+dev_read_urand(hadoop_secondarynamenode_domain)
+kernel_read_network_state(hadoop_secondarynamenode_domain)
+files_read_etc_files(hadoop_secondarynamenode_domain)
+files_read_usr_files(hadoop_secondarynamenode_domain)
+kernel_read_system_state(hadoop_secondarynamenode_domain)
+nscd_socket_use(hadoop_secondarynamenode_domain)
+java_exec(hadoop_secondarynamenode_domain)
+hadoop_rx_etc(hadoop_secondarynamenode_domain)
+hadoop_manage_log_dir(hadoop_secondarynamenode_domain)
+files_manage_generic_tmp_files(hadoop_secondarynamenode_domain)
+files_manage_generic_tmp_dirs(hadoop_secondarynamenode_domain)
+fs_getattr_xattr_fs(hadoop_secondarynamenode_domain)
+allow hadoop_secondarynamenode_domain self:process { execmem getsched 
setsched signal setrlimit };
+allow hadoop_secondarynamenode_domain self:fifo_file { read write 
getattr ioctl };
+allow hadoop_secondarynamenode_domain self:capability sys_resource;
+allow hadoop_secondarynamenode_domain self:key write;
+nis_use_ypbind(hadoop_secondarynamenode_domain)
+corenet_tcp_connect_portmap_port(hadoop_secondarynamenode_domain)
+userdom_dontaudit_search_user_home_dirs(hadoop_secondarynamenode_domain)
+files_dontaudit_search_spool(hadoop_secondarynamenode_domain)
+
+
+type hadoop_secondarynamenode_pid_t;
+files_pid_file(hadoop_secondarynamenode_pid_t)
+allow hadoop_secondarynamenode_domain 
hadoop_secondarynamenode_pid_t:file manage_file_perms;
+allow hadoop_secondarynamenode_domain 
hadoop_secondarynamenode_pid_t:dir rw_dir_perms;
+files_pid_filetrans(hadoop_secondarynamenode_domain,hadoop_secondarynamenode_pid_t,file)
+hadoop_transition_run_file(hadoop_secondarynamenode_initrc_t, 
hadoop_secondarynamenode_pid_t)
+
+type hadoop_secondarynamenode_log_t;
+logging_log_file(hadoop_secondarynamenode_log_t)
+allow hadoop_secondarynamenode_domain 
hadoop_secondarynamenode_log_t:file manage_file_perms;
+allow hadoop_secondarynamenode_domain 
hadoop_secondarynamenode_log_t:dir { setattr rw_dir_perms };
+logging_log_filetrans(hadoop_secondarynamenode_domain,hadoop_secondarynamenode_log_t,{file 
dir})
+hadoop_transition_log_file(hadoop_secondarynamenode_t, 
hadoop_secondarynamenode_log_t)
+hadoop_transition_log_file(hadoop_secondarynamenode_initrc_t, 
hadoop_secondarynamenode_log_t)
+
+type hadoop_secondarynamenode_data_t;
+files_type(hadoop_secondarynamenode_data_t)
+allow hadoop_secondarynamenode_t hadoop_secondarynamenode_data_t:file 
manage_file_perms;
+allow hadoop_secondarynamenode_t hadoop_secondarynamenode_data_t:dir 
manage_dir_perms;
+type_transition hadoop_secondarynamenode_t hadoop_data_t:file 
hadoop_secondarynamenode_data_t;
+
+type hadoop_secondarynamenode_tmp_t;
+files_tmp_file(hadoop_secondarynamenode_tmp_t)
+allow hadoop_secondarynamenode_t hadoop_secondarynamenode_tmp_t:file 
manage_file_perms;
+files_tmp_filetrans(hadoop_secondarynamenode_t, 
hadoop_secondarynamenode_tmp_t, file)
+
+corecmd_exec_bin(hadoop_secondarynamenode_t)
+corecmd_exec_shell(hadoop_secondarynamenode_t)
+dev_read_rand(hadoop_secondarynamenode_t)
+dev_read_sysfs(hadoop_secondarynamenode_t)
+files_read_var_lib_files(hadoop_secondarynamenode_t)
+hadoop_manage_data_dir(hadoop_secondarynamenode_t)
+hadoop_getattr_run_dir(hadoop_secondarynamenode_t)
+dontaudit hadoop_secondarynamenode_t self:netlink_route_socket { create 
ioctl read getattr write setattr append bind connect getopt setopt 
shutdown nlmsg_read nlmsg_write };
+
+allow hadoop_secondarynamenode_t self:tcp_socket 
create_stream_socket_perms;
+corenet_tcp_sendrecv_generic_if(hadoop_secondarynamenode_t)
+corenet_tcp_sendrecv_all_nodes(hadoop_secondarynamenode_t)
+corenet_all_recvfrom_unlabeled(hadoop_secondarynamenode_t)
+corenet_tcp_bind_all_nodes(hadoop_secondarynamenode_t)
+sysnet_read_config(hadoop_secondarynamenode_t)
+corenet_tcp_sendrecv_all_ports(hadoop_secondarynamenode_t)
+corenet_tcp_bind_all_ports(hadoop_secondarynamenode_t)
+corenet_tcp_connect_generic_port(hadoop_secondarynamenode_t)
+
+allow hadoop_secondarynamenode_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_generic_if(hadoop_secondarynamenode_t)
+corenet_udp_sendrecv_all_nodes(hadoop_secondarynamenode_t)
+corenet_udp_bind_all_nodes(hadoop_secondarynamenode_t)
+corenet_udp_bind_all_ports(hadoop_secondarynamenode_t)
+
+corenet_tcp_connect_hadoop_namenode_port(hadoop_secondarynamenode_t)
+
+hadoop_datanode_signull(hadoop_secondarynamenode_t)
+hadoop_jobtracker_signull(hadoop_secondarynamenode_t)
+hadoop_namenode_signull(hadoop_secondarynamenode_t)
+hadoop_tasktracker_signull(hadoop_secondarynamenode_t)
+
diff --git a/policy/modules/services/hadoop_tasktracker.fc 
b/policy/modules/services/hadoop_tasktracker.fc
new file mode 100644
index 0000000..1c48ac4
--- /dev/null
+++ b/policy/modules/services/hadoop_tasktracker.fc
@@ -0,0 +1,6 @@
+/etc/rc\.d/init\.d/hadoop-(.*)?-tasktracker            --    
gen_context(system_u:object_r:hadoop_tasktracker_initrc_exec_t, s0)
+
+/var/log/hadoop(.*)?/hadoop-hadoop-tasktracker-(.*)?            
gen_context(system_u:object_r:hadoop_tasktracker_log_t, s0)
+
+/var/lib/hadoop(.*)?/cache/hadoop/mapred/local/taskTracker(/.*)?     
gen_context(system_u:object_r:hadoop_tasktracker_data_t, s0)
+
diff --git a/policy/modules/services/hadoop_tasktracker.if 
b/policy/modules/services/hadoop_tasktracker.if
new file mode 100644
index 0000000..b6e9d40
--- /dev/null
+++ b/policy/modules/services/hadoop_tasktracker.if
@@ -0,0 +1,18 @@
+## <summary>Hadoop TaskTracker</summary>
+########################################
+## <summary>
+##  Give permission to a domain to signull hadoop_tasktracker_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`hadoop_tasktracker_signull', `
+    gen_require(`
+        type hadoop_tasktracker_t;
+    ')
+
+    allow $1 hadoop_tasktracker_t:process { signull };
+')
diff --git a/policy/modules/services/hadoop_tasktracker.te 
b/policy/modules/services/hadoop_tasktracker.te
new file mode 100644
index 0000000..ce95d96
--- /dev/null
+++ b/policy/modules/services/hadoop_tasktracker.te
@@ -0,0 +1,120 @@
+policy_module(hadoop_tasktracker,1.0.0)
+
+attribute hadoop_tasktracker_domain;
+
+type hadoop_tasktracker_initrc_t;
+domain_type(hadoop_tasktracker_initrc_t)
+typeattribute hadoop_tasktracker_initrc_t hadoop_tasktracker_domain;
+
+type hadoop_tasktracker_initrc_exec_t;
+files_type(hadoop_tasktracker_initrc_exec_t)
+
+init_daemon_domain(hadoop_tasktracker_initrc_t, 
hadoop_tasktracker_initrc_exec_t)
+unconfined_domtrans_to(hadoop_tasktracker_initrc_t, 
hadoop_tasktracker_initrc_exec_t)
+allow hadoop_tasktracker_initrc_t self:capability { setuid setgid 
sys_tty_config};
+corecmd_exec_all_executables(hadoop_tasktracker_initrc_t)
+files_manage_generic_locks(hadoop_tasktracker_initrc_t)
+init_read_utmp(hadoop_tasktracker_initrc_t)
+init_write_utmp(hadoop_tasktracker_initrc_t)
+kernel_read_kernel_sysctls(hadoop_tasktracker_initrc_t)
+kernel_read_sysctl(hadoop_tasktracker_initrc_t)
+logging_send_syslog_msg(hadoop_tasktracker_initrc_t)
+logging_send_audit_msgs(hadoop_tasktracker_initrc_t)
+term_use_all_terms(hadoop_tasktracker_initrc_t)
+hadoop_manage_run(hadoop_tasktracker_initrc_t)
+allow hadoop_tasktracker_initrc_t hadoop_tasktracker_t:process { 
signull signal };
+
+type hadoop_tasktracker_t;
+typeattribute hadoop_tasktracker_t hadoop_tasktracker_domain;
+hadoop_runas(hadoop_tasktracker_initrc_t, hadoop_tasktracker_t)
+role system_r types hadoop_tasktracker_t;
+unconfined_roletrans(hadoop_tasktracker_t)
+unconfined_roletrans(hadoop_tasktracker_initrc_t)
+domain_type(hadoop_tasktracker_t)
+
+libs_use_ld_so(hadoop_tasktracker_domain)
+libs_use_shared_libs(hadoop_tasktracker_domain)
+miscfiles_read_localization(hadoop_tasktracker_domain)
+dev_read_urand(hadoop_tasktracker_domain)
+kernel_read_network_state(hadoop_tasktracker_domain)
+files_read_etc_files(hadoop_tasktracker_domain)
+files_read_usr_files(hadoop_tasktracker_domain)
+kernel_read_system_state(hadoop_tasktracker_domain)
+nscd_socket_use(hadoop_tasktracker_domain)
+java_exec(hadoop_tasktracker_domain)
+hadoop_rx_etc(hadoop_tasktracker_domain)
+hadoop_manage_log_dir(hadoop_tasktracker_domain)
+files_manage_generic_tmp_files(hadoop_tasktracker_domain)
+files_manage_generic_tmp_dirs(hadoop_tasktracker_domain)
+fs_getattr_xattr_fs(hadoop_tasktracker_domain)
+allow hadoop_tasktracker_domain self:process { execmem getsched 
setsched signal setrlimit };
+allow hadoop_tasktracker_domain self:fifo_file { read write getattr 
ioctl };
+allow hadoop_tasktracker_domain self:capability sys_resource;
+allow hadoop_tasktracker_domain self:key write;
+nis_use_ypbind(hadoop_tasktracker_domain)
+corenet_tcp_connect_portmap_port(hadoop_tasktracker_domain)
+userdom_dontaudit_search_user_home_dirs(hadoop_tasktracker_domain)
+files_dontaudit_search_spool(hadoop_tasktracker_domain)
+
+
+type hadoop_tasktracker_pid_t;
+files_pid_file(hadoop_tasktracker_pid_t)
+allow hadoop_tasktracker_domain hadoop_tasktracker_pid_t:file 
manage_file_perms;
+allow hadoop_tasktracker_domain hadoop_tasktracker_pid_t:dir rw_dir_perms;
+files_pid_filetrans(hadoop_tasktracker_domain,hadoop_tasktracker_pid_t,file)
+hadoop_transition_run_file(hadoop_tasktracker_initrc_t, 
hadoop_tasktracker_pid_t)
+
+type hadoop_tasktracker_log_t;
+logging_log_file(hadoop_tasktracker_log_t)
+allow hadoop_tasktracker_domain hadoop_tasktracker_log_t:file 
manage_file_perms;
+allow hadoop_tasktracker_domain hadoop_tasktracker_log_t:dir { setattr 
rw_dir_perms };
+logging_log_filetrans(hadoop_tasktracker_domain,hadoop_tasktracker_log_t,{file 
dir})
+hadoop_transition_log_file(hadoop_tasktracker_t, hadoop_tasktracker_log_t)
+hadoop_transition_log_file(hadoop_tasktracker_initrc_t, 
hadoop_tasktracker_log_t)
+
+type hadoop_tasktracker_data_t;
+files_type(hadoop_tasktracker_data_t)
+allow hadoop_tasktracker_t hadoop_tasktracker_data_t:file 
manage_file_perms;
+allow hadoop_tasktracker_t hadoop_tasktracker_data_t:dir manage_dir_perms;
+type_transition hadoop_tasktracker_t hadoop_data_t:file 
hadoop_tasktracker_data_t;
+
+type hadoop_tasktracker_tmp_t;
+files_tmp_file(hadoop_tasktracker_tmp_t)
+allow hadoop_tasktracker_t hadoop_tasktracker_tmp_t:file manage_file_perms;
+files_tmp_filetrans(hadoop_tasktracker_t, hadoop_tasktracker_tmp_t, file)
+
+corecmd_exec_bin(hadoop_tasktracker_t)
+corecmd_exec_shell(hadoop_tasktracker_t)
+dev_read_rand(hadoop_tasktracker_t)
+dev_read_sysfs(hadoop_tasktracker_t)
+files_read_var_lib_files(hadoop_tasktracker_t)
+hadoop_manage_data_dir(hadoop_tasktracker_t)
+hadoop_getattr_run_dir(hadoop_tasktracker_t)
+dontaudit hadoop_tasktracker_t self:netlink_route_socket { create ioctl 
read getattr write setattr append bind connect getopt setopt shutdown 
nlmsg_read nlmsg_write };
+
+allow hadoop_tasktracker_t self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_generic_if(hadoop_tasktracker_t)
+corenet_tcp_sendrecv_all_nodes(hadoop_tasktracker_t)
+corenet_all_recvfrom_unlabeled(hadoop_tasktracker_t)
+corenet_tcp_bind_all_nodes(hadoop_tasktracker_t)
+sysnet_read_config(hadoop_tasktracker_t)
+corenet_tcp_sendrecv_all_ports(hadoop_tasktracker_t)
+corenet_tcp_bind_all_ports(hadoop_tasktracker_t)
+corenet_tcp_connect_generic_port(hadoop_tasktracker_t)
+
+allow hadoop_tasktracker_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_generic_if(hadoop_tasktracker_t)
+corenet_udp_sendrecv_all_nodes(hadoop_tasktracker_t)
+corenet_udp_bind_all_nodes(hadoop_tasktracker_t)
+corenet_udp_bind_all_ports(hadoop_tasktracker_t)
+
+fs_associate(hadoop_tasktracker_t)
+fs_getattr_xattr_fs(hadoop_tasktracker_t)
+corenet_tcp_connect_zope_port(hadoop_tasktracker_t)
+corenet_tcp_connect_hadoop_namenode_port(hadoop_tasktracker_t)
+
+hadoop_datanode_signull(hadoop_tasktracker_t)
+hadoop_jobtracker_signull(hadoop_tasktracker_t)
+hadoop_secondarynamenode_signull(hadoop_tasktracker_t)
+hadoop_namenode_signull(hadoop_tasktracker_t)
+
diff --git a/policy/modules/kernel/corenetwork.te.in 
b/policy/modules/kernel/corenetwork.te.in
index 549763c..2d566e4 100644
--- a/policy/modules/kernel/corenetwork.te.in
+++ b/policy/modules/kernel/corenetwork.te.in
@@ -211,6 +211,9 @@ network_port(whois, tcp,43,s0, udp,43,s0, tcp, 4321, 
s0 , udp, 4321, s0 )
  network_port(xdmcp, udp,177,s0, tcp,177,s0)
  network_port(xen, tcp,8002,s0)
  network_port(xfs, tcp,7100,s0)
+network_port(zookeeper_client, tcp, 2181,s0)
+network_port(zookeeper_election, tcp, 3888,s0)
+network_port(zookeeper_leader, tcp, 2888,s0)
  network_port(xserver, tcp,6000-6020,s0)
  network_port(zebra, tcp,2600-2604,s0, tcp,2606,s0, udp,2600-2604,s0, 
udp,2606,s0)
  network_port(zope, tcp,8021,s0)
diff --git a/policy/modules/services/hadoop_zookeeper.fc 
b/policy/modules/services/hadoop_zookeeper.fc
new file mode 100644
index 0000000..3db357e
--- /dev/null
+++ b/policy/modules/services/hadoop_zookeeper.fc
@@ -0,0 +1,11 @@
+/usr/bin/zookeeper-server     --     
gen_context(system_u:object_r:zookeeper_server_exec_t, s0)
+
+/usr/bin/zookeeper-client        --     
gen_context(system_u:object_r:zookeeper_exec_t, s0)
+
+/var/log/zookeeper(/.*)?                
gen_context(system_u:object_r:zookeeper_log_t, s0)
+
+/var/zookeeper(/.*)?                    
gen_context(system_u:object_r:zookeeper_server_data_t, s0)
+
+/etc/zookeeper(/.*)?                    
gen_context(system_u:object_r:zookeeper_etc_t, s0)
+/etc/zookeeper.dist(/.*)?               
gen_context(system_u:object_r:zookeeper_etc_t, s0)
+
diff --git a/policy/modules/services/hadoop_zookeeper.if 
b/policy/modules/services/hadoop_zookeeper.if
new file mode 100644
index 0000000..dd4d9b3
--- /dev/null
+++ b/policy/modules/services/hadoop_zookeeper.if
@@ -0,0 +1,18 @@
+## <summary>Hadoop Zookeeper Server</summary>
+########################################
+## <summary>
+##  Give permission to a domain to signull zookeeper_server_t
+## </summary>
+## <param name="domain">
+## <summary>
+##  Domain needing permission
+## </summary>
+## </param>
+#
+interface(`zookeeper_server_signull', `
+    gen_require(`
+        type zookeeper_server_t;
+    ')
+
+    allow $1 zookeeper_server_t:process signull;
+')
diff --git a/policy/modules/services/hadoop_zookeeper.te 
b/policy/modules/services/hadoop_zookeeper.te
new file mode 100644
index 0000000..657c07f
--- /dev/null
+++ b/policy/modules/services/hadoop_zookeeper.te
@@ -0,0 +1,115 @@
+policy_module(zookeeper_server,1.0.0)
+
+attribute zookeeper_domain;
+typeattribute zookeeper_server_t zookeeper_domain;
+typeattribute zookeeper_t zookeeper_domain;
+
+type zookeeper_server_t;
+domain_type(zookeeper_server_t)
+type zookeeper_t;
+domain_type(zookeeper_t)
+
+type zookeeper_server_exec_t;
+files_type(zookeeper_server_exec_t)
+domain_entry_file(zookeeper_server_t, zookeeper_server_exec_t)
+
+type zookeeper_exec_t;
+files_type(zookeeper_exec_t)
+domain_entry_file(zookeeper_t, zookeeper_exec_t)
+
+unconfined_roletrans(zookeeper_t)
+unconfined_roletrans(zookeeper_server_t)
+unconfined_domtrans_to(zookeeper_server_t, zookeeper_server_exec_t)
+unconfined_domtrans_to(zookeeper_t, zookeeper_exec_t)
+
+libs_use_ld_so(zookeeper_domain)
+libs_use_shared_libs(zookeeper_domain)
+miscfiles_read_localization(zookeeper_domain)
+dev_read_urand(zookeeper_domain)
+dev_read_rand(zookeeper_domain)
+
+type zookeeper_etc_t;
+files_config_file(zookeeper_etc_t)
+allow zookeeper_domain zookeeper_etc_t:file { getattr read_file_perms };
+allow zookeeper_domain zookeeper_etc_t:dir { search list_dir_perms };
+allow zookeeper_domain zookeeper_etc_t:lnk_file { read getattr };
+
+type zookeeper_server_pid_t;
+files_pid_file(zookeeper_server_pid_t)
+allow zookeeper_server_t zookeeper_server_pid_t:file manage_file_perms;
+allow zookeeper_server_t zookeeper_server_pid_t:dir rw_dir_perms;
+files_pid_filetrans(zookeeper_server_t,zookeeper_server_pid_t,file)
+
+files_manage_generic_tmp_files(zookeeper_domain)
+files_manage_generic_tmp_dirs(zookeeper_domain)
+
+type zookeeper_tmp_t;
+files_tmp_file(zookeeper_tmp_t)
+allow zookeeper_t zookeeper_tmp_t:file manage_file_perms;
+files_tmp_filetrans(zookeeper_t, zookeeper_tmp_t, file)
+
+type zookeeper_server_tmp_t;
+files_tmp_file(zookeeper_server_tmp_t)
+allow zookeeper_server_t zookeeper_server_tmp_t:file manage_file_perms;
+files_tmp_filetrans(zookeeper_server_t, zookeeper_server_tmp_t, file)
+
+type zookeeper_log_t;
+logging_log_file(zookeeper_log_t)
+allow zookeeper_domain zookeeper_log_t:file {create manage_file_perms};
+allow zookeeper_domain zookeeper_log_t:dir {setattr rw_dir_perms};
+logging_log_filetrans(zookeeper_domain,zookeeper_log_t,{file dir})
+
+type zookeeper_server_data_t;
+files_type(zookeeper_server_data_t)
+allow zookeeper_server_t zookeeper_server_data_t:file manage_file_perms;
+allow zookeeper_server_t zookeeper_server_data_t:dir manage_dir_perms;
+files_var_filetrans(zookeeper_server_t, zookeeper_server_data_t, dir)
+
+allow zookeeper_domain self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_generic_if(zookeeper_domain)
+corenet_tcp_sendrecv_all_nodes(zookeeper_domain)
+corenet_tcp_sendrecv_all_ports(zookeeper_domain)
+corenet_all_recvfrom_unlabeled(zookeeper_domain)
+sysnet_read_config(zookeeper_domain)
+corenet_tcp_connect_generic_port(zookeeper_domain)
+corenet_tcp_bind_all_nodes(zookeeper_domain)
+
+allow zookeeper_domain self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_generic_if(zookeeper_domain)
+corenet_udp_sendrecv_all_nodes(zookeeper_domain)
+corenet_udp_sendrecv_all_ports(zookeeper_domain)
+corenet_udp_bind_all_nodes(zookeeper_domain)
+corenet_udp_bind_all_ports(zookeeper_domain)
+
+corecmd_exec_bin(zookeeper_domain)
+corecmd_exec_shell(zookeeper_domain)
+kernel_read_system_state(zookeeper_domain)
+kernel_read_network_state(zookeeper_domain)
+files_read_etc_files(zookeeper_domain)
+files_read_usr_files(zookeeper_domain)
+dev_read_sysfs(zookeeper_domain)
+java_exec(zookeeper_domain)
+allow zookeeper_domain self:fifo_file rw_file_perms;
+allow zookeeper_domain self:process { getsched execmem sigkill signal 
signull };
+
+logging_send_syslog_msg(zookeeper_server_t)
+init_daemon_domain(zookeeper_server_t, zookeeper_server_exec_t)
+files_read_usr_files(zookeeper_server_t)
+fs_getattr_xattr_fs(zookeeper_server_t)
+allow zookeeper_server_t self:netlink_route_socket { 
rw_netlink_socket_perms };
+corenet_tcp_bind_zookeeper_client_port(zookeeper_server_t)
+corenet_tcp_bind_zookeeper_election_port(zookeeper_server_t)
+corenet_tcp_bind_zookeeper_leader_port(zookeeper_server_t)
+corenet_tcp_connect_zookeeper_election_port(zookeeper_server_t)
+corenet_tcp_connect_zookeeper_leader_port(zookeeper_server_t)
+allow zookeeper_server_t zookeeper_server_exec_t:file execute_no_trans;
+allow zookeeper_server_t self:capability kill;
+
+nscd_socket_use(zookeeper_t)
+term_use_all_terms(zookeeper_t)
+logging_search_logs(zookeeper_t)
+userdom_dontaudit_search_user_home_dirs(zookeeper_t)
+allow zookeeper_t zookeeper_exec_t:file execute_no_trans;
+allow zookeeper_t zookeeper_server_t:process signull;
+corenet_tcp_connect_zookeeper_client_port(zookeeper_t)
+


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
