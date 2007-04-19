Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JErPmS026023
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 10:53:25 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JErM9K003961
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 14:53:22 GMT
Message-ID: <46278259.9080509@redhat.com>
Date: Thu, 19 Apr 2007 10:53:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Additional fixes for consolekit.
Content-Type: multipart/mixed;
 boundary="------------060402010809080505070105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060402010809080505070105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Consolekit when started via startx needs additional privs.

Consolekit read users terminals to see who is logged in.

It also reads the .Xauthority file.

--------------060402010809080505070105
Content-Type: text/x-patch;
 name="consolekit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consolekit.patch"

--- nsaserefpolicy/policy/modules/services/consolekit.te	2007-04-11 16:04:02.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/consolekit.te	2007-04-18 15:27:17.000000000 -0400
@@ -19,14 +19,13 @@
 # consolekit local policy
 #
 
-allow consolekit_t self:capability { sys_tty_config dac_override sys_nice sys_ptrace };
+allow consolekit_t self:capability { setuid setgid sys_tty_config dac_override sys_nice sys_ptrace };
 allow consolekit_t self:process { getsched signal };
 allow consolekit_t self:fifo_file rw_fifo_file_perms;
 allow consolekit_t self:unix_stream_socket create_stream_socket_perms;
+allow consolekit_t self:unix_dgram_socket create_socket_perms;
 
-# pid file
-manage_files_pattern(consolekit_t,consolekit_var_run_t,consolekit_var_run_t)
-files_pid_filetrans(consolekit_t,consolekit_var_run_t, file)
+corecmd_exec_bin(consolekit_t)
 
 dev_read_urand(consolekit_t)
 dev_read_sysfs(consolekit_t)
@@ -38,18 +37,32 @@
 # needs to read /var/lib/dbus/machine-id
 files_read_var_lib_files(consolekit_t)
 
-term_use_console(consolekit_t)
+fs_list_inotifyfs(consolekit_t)
+
+kernel_read_system_state(consolekit_t)
 
 libs_use_ld_so(consolekit_t)
 libs_use_shared_libs(consolekit_t)
 
 miscfiles_read_localization(consolekit_t)
 
+term_use_all_terms(consolekit_t)
+
+manage_files_pattern(consolekit_t,consolekit_var_run_t,consolekit_var_run_t)
+files_pid_filetrans(consolekit_t,consolekit_var_run_t, file)
+
 ifdef(`targeted_policy',`
-	term_dontaudit_use_unallocated_ttys(consolekit_t)
-	term_dontaudit_use_generic_ptys(consolekit_t)
+	term_use_unallocated_ttys(consolekit_t)
+	term_use_generic_ptys(consolekit_t)
+	#reading .Xauthity
+	userdom_read_generic_user_home_content_files(consolekit_t)
 ')
 
+# Init script handling
+
+domain_ptrace_all_domains(consolekit_t)
+mcs_ptrace_all(consolekit_t)
+
 optional_policy(`
 	dbus_system_bus_client_template(consolekit, consolekit_t)
 	dbus_send_system_bus(consolekit_t)
@@ -61,3 +74,7 @@
 		unconfined_dbus_chat(consolekit_t)
 	')
 ')
+
+optional_policy(`
+	xserver_stream_connect_xdm_xserver(consolekit_t)
+')
--- nsaserefpolicy/policy/modules/system/locallogin.te	2007-03-26 10:39:07.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/locallogin.te	2007-04-11 17:07:34.000000000 -0400
@@ -162,6 +165,10 @@
 ')
 
 optional_policy(`
+	consolekit_dbus_chat(local_login_t)
+')
+
+optional_policy(`
 	gpm_getattr_gpmctl(local_login_t)
 	gpm_setattr_gpmctl(local_login_t)
 ')

--------------060402010809080505070105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
