Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGrWnS001376
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:53:32 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KGsnQc018555
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 16:54:49 GMT
Message-ID: <45DB27D7.7090604@redhat.com>
Date: Tue, 20 Feb 2007 11:54:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Policy patch for hal
Content-Type: multipart/mixed;
 boundary="------------040706050806020207070401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040706050806020207070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hal now is changing the attributes of sound device and video devices so 
userswitching can happen.

It reads and writes raw memory.

It has a new cache directory where it wants to store stuff.

Needs to telinit to change runlevel.



--------------040706050806020207070401
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_hal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_hal.patch"

--- nsaserefpolicy/policy/modules/services/hal.fc	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/hal.fc	2007-02-19 16:01:52.000000000 -0500
@@ -8,4 +8,6 @@
 
 /var/lib/hal(/.*)?				gen_context(system_u:object_r:hald_var_lib_t,s0)
 
+/var/cache/hald(/.*)?				gen_context(system_u:object_r:hald_cache_t,s0)
+
 /var/run/haldaemon.pid	--	 		gen_context(system_u:object_r:hald_var_run_t,s0)
--- nsaserefpolicy/policy/modules/services/hal.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/hal.te	2007-02-20 10:26:38.000000000 -0500
@@ -16,6 +16,9 @@
 type hald_var_run_t;
 files_pid_file(hald_var_run_t)
 
+type hald_cache_t;
+files_pid_file(hald_cache_t)
+
 type hald_var_lib_t;
 files_type(hald_var_lib_t)
 
@@ -25,8 +28,8 @@
 #
 
 # execute openvt which needs setuid
-allow hald_t self:capability { chown setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
-dontaudit hald_t self:capability sys_tty_config;
+allow hald_t self:capability { chown fowner setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
+dontaudit hald_t self:capability {sys_ptrace sys_tty_config };
 allow hald_t self:process signal_perms;
 allow hald_t self:fifo_file rw_fifo_file_perms;
 allow hald_t self:unix_stream_socket { create_stream_socket_perms connectto };
@@ -51,6 +54,8 @@
 manage_files_pattern(hald_t,hald_var_run_t,hald_var_run_t)
 files_pid_filetrans(hald_t,hald_var_run_t,file)
 
+manage_files_pattern(hald_t,hald_cache_t,hald_cache_t)
+
 kernel_read_system_state(hald_t)
 kernel_read_network_state(hald_t)
 kernel_read_kernel_sysctls(hald_t)
@@ -85,9 +90,15 @@
 dev_rw_power_management(hald_t)
 # hal is now execing pm-suspend
 dev_rw_sysfs(hald_t)
+dev_read_sound(hald_t)
+dev_write_sound(hald_t)
+dev_read_raw_memory(hald_t)
+dev_write_raw_memory(hald_t)
+dev_setattr_video_dev(hald_t)
 
 domain_use_interactive_fds(hald_t)
 domain_read_all_domains_state(hald_t)
+domain_dontaudit_ptrace_all_domains(hald_t)
 
 files_exec_etc_files(hald_t)
 files_read_etc_files(hald_t)
@@ -101,6 +112,7 @@
 files_create_boot_flag(hald_t)
 files_getattr_all_dirs(hald_t)
 files_read_kernel_img(hald_t)
+files_rw_lock_dirs(hald_t)
 
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
@@ -130,10 +142,10 @@
 init_use_fds(hald_t)
 init_use_script_ptys(hald_t)
 init_domtrans_script(hald_t)
-init_write_initctl(hald_t)
 init_read_utmp(hald_t)
 #hal runs shutdown, probably need a shutdown domain
 init_rw_utmp(hald_t)
+init_telinit(hald_t)
 
 libs_use_ld_so(hald_t)
 libs_use_shared_libs(hald_t)

--------------040706050806020207070401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
