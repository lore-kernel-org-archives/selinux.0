Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1EE1OXf025054
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2006 09:01:24 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1EE023j021711
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2006 14:00:02 GMT
Message-ID: <43F1E2AC.40603@redhat.com>
Date: Tue, 14 Feb 2006 09:01:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <43EB8C6D.7060809@redhat.com> <1139868484.13925.134.camel@sgc>
In-Reply-To: <1139868484.13925.134.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------010807080200000805010805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010807080200000805010805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Thu, 2006-02-09 at 13:39 -0500, Daniel J Walsh wrote:
>   
>> Update build.conf to match what I believe should be the defaults.
>>     
>
> I don't see a compelling need to make MCS default for the upstream
> policy.  As for the MONOLITHIC=n, I'd prefer to wait until FC5 comes out
> so that there is a final release with loadable modules.
>   
I was looking to make these changes, back when I thought this was the 
Makefile for users to build reference policy.  I have made some changes 
to Makefile.devel instead.
>   
>> Add some of Russell's mcs changes
>>     
>
> I dropped the mcs file change.  We can't have hard-coded types.
>   
Added a typealias mlskillall.  Does this look better?
>   
>> hal continuously wants more privs...
>>     
>
> Do we really want to make the insmod transition unconditional?
>   
Removed unconditional
>   
>> mta/sendmail wants to read postfix config and spools.
>>     
>
> I don't understand why this change is needed for mta_send_mail().  It
> makes sendmail_exec_t an entrypoint for the domain that wants to send
> mail:
>
>   
Ok, where should I move it.
> @@ -434,6 +434,7 @@
>   
>>  
>>  	allow $1 sendmail_exec_t:lnk_file r_file_perms;
>>  	domain_auto_trans($1, sendmail_exec_t, system_mail_t)
>> +	domain_entry_file($1,sendmail_exec_t)
>>  
>>  	allow $1 system_mail_t:fd use;
>>  	allow system_mail_t $1:fd use;
>>     
>   
>> auditctl needs to output to  terminals.
>>     
>
> I merged this, but I'm curious why this is needed.
>   
Getting denials when running auditctl in targeted and MLS policy.


Latest diff

bluetooth wants to rw new usb_device_t.

mlskillall mentioned above

newalias wants dav_override

NetworkManager needs to sendto for wpa_subplicant

More fixes for postfix.

spamd needs ldap

prelink needs to unlink lib_t lnk_files when managing them.

Added semodule policy.  This still needs work.  semodule now wants to 
create lock files in /etc/selinux/TYPE/modules sub directory.  I would 
like to label this policy_config_t, problem is that all tools (setfiles, 
restorecon ...) need write access in order
to create the lock file.  This is a serious problem.  I think we also 
need to label /usr/share/selinux/TYPE/*.pp files as policy_config_t.

Need to take this conversation out of this thread though.

We have serious problems with execstack. since it is needed for libflash 
to work correctly.  We can think about labeling web browsers with 
unconfined_ with execstack privs or for now I am just turning on avc's 
for denials.  So users might have an
idea of what to look for when the flash windows don't work.  (Looking at 
automobile web sites reveals this problem :^))

More privs for secadm

Added ability for Rules.modular to build with user_extras.  Probably 
need something similar for Rules.monolithic.







--------------010807080200000805010805
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/mcs serefpolicy-2.2.15/policy/mcs
--- nsaserefpolicy/policy/mcs	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.2.15/policy/mcs	2006-02-14 08:04:17.000000000 -0500
@@ -137,15 +137,24 @@
 # Only files are constrained by MCS at this stage.
 #
 mlsconstrain file { write setattr append unlink link rename
-		    create ioctl lock execute } (h1 dom h2);
+		    ioctl lock execute relabelfrom } (h1 dom h2);
+
+mlsconstrain file { create relabelto } ((h1 dom h2) and (l2 eq h2));
 
 mlsconstrain file { read } ((h1 dom h2) or 
 			    ( t1 == mlsfileread ));
 
 
 # new file labels must be dominated by the relabeling subject clearance
-mlsconstrain { dir file lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom relabelto }
+mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom }
 	( h1 dom h2 );
+mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { create relabelto }
+	(( h1 dom h2 ) and ( l2 eq h2 ));
+
+mlsconstrain process { ptrace } ( h1 dom h2 );
+
+mlsconstrain process { sigkill sigstop } ( h1 dom h2 ) or
+		( t1 == mlskillall );
 
 define(`nogetattr_file_perms', `{ create ioctl read lock write setattr append 
 link unlink rename relabelfrom relabelto }')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.15/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-02-10 21:34:12.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/kernel/devices.if	2006-02-14 08:04:17.000000000 -0500
@@ -2656,3 +2656,22 @@
 	typeattribute $1 memory_raw_write, memory_raw_read;
 ')
 
+
+########################################
+## <summary>
+##	Read and write the USB device.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dev_rw_usb',`
+	gen_require(`
+		type usb_device_t;
+	')
+
+	allow $1 device_t:dir r_dir_perms;
+	allow $1 usb_device_t:chr_file { read write };
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.if serefpolicy-2.2.15/policy/modules/kernel/mls.if
--- nsaserefpolicy/policy/modules/kernel/mls.if	2006-02-10 21:34:12.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/kernel/mls.if	2006-02-14 08:04:17.000000000 -0500
@@ -214,3 +214,22 @@
 
 	typeattribute $1 mlstrustedobject;
 ')
+
+########################################
+## <summary>
+##	This domain is allowed to sigkill and sigstop 
+##	all domains regardless of sensitivity level
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain target for user exemption.
+##	</summary>
+## </param>
+#
+interface(`mls_killall',`
+	gen_require(`
+		attribute mlskillall;
+	')
+
+	typeattribute $1 mlskillall;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.15/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/kernel/mls.te	2006-02-14 08:04:17.000000000 -0500
@@ -46,6 +46,7 @@
 
 attribute privrangetrans;
 attribute mlsrangetrans;
+attribute mlskillall;
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.2.15/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-02-03 08:55:53.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/services/bluetooth.te	2006-02-14 08:04:17.000000000 -0500
@@ -101,6 +101,7 @@
 
 dev_read_sysfs(bluetooth_t)
 dev_rw_usbfs(bluetooth_t)
+dev_rw_usb(bluetooth_t)
 dev_read_urand(bluetooth_t)
 
 fs_getattr_all_fs(bluetooth_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.15/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-02-14 07:20:26.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/services/hal.te	2006-02-14 08:05:36.000000000 -0500
@@ -97,6 +97,8 @@
 
 mls_file_read_up(hald_t)
 
+modutils_domtrans_insmod(hald_t)
+
 selinux_get_fs_mount(hald_t)
 selinux_validate_context(hald_t)
 selinux_compute_access_vector(hald_t)
@@ -128,6 +130,7 @@
 libs_exec_lib_files(hald_t)
 
 logging_send_syslog_msg(hald_t)
+logging_search_logs(hald_t)
 
 miscfiles_read_localization(hald_t)
 miscfiles_read_hwdata(hald_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.if serefpolicy-2.2.15/policy/modules/services/mta.if
--- nsaserefpolicy/policy/modules/services/mta.if	2006-02-10 21:34:14.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/services/mta.if	2006-02-14 08:04:17.000000000 -0500
@@ -458,6 +458,7 @@
 
 	allow $1 sendmail_exec_t:lnk_file r_file_perms;
 	domain_auto_trans($1, sendmail_exec_t, system_mail_t)
+	domain_entry_file($1,sendmail_exec_t)
 
 	allow $1 system_mail_t:fd use;
 	allow system_mail_t $1:fd use;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.2.15/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2006-02-14 07:20:26.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/services/mta.te	2006-02-14 08:04:17.000000000 -0500
@@ -30,6 +30,9 @@
 
 mta_base_mail_template(system)
 role system_r types system_mail_t;
+# newalias required this, not sure if it is needed in 'if' file
+allow system_mail_t self:capability { dac_override };
+
 
 # cjp: need to resolve this, but require{}
 # does not work in the else part of the optional
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.2.15/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2006-02-14 07:20:26.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/services/networkmanager.te	2006-02-14 08:04:17.000000000 -0500
@@ -22,7 +22,7 @@
 dontaudit NetworkManager_t self:capability sys_tty_config;
 allow NetworkManager_t self:process { setcap getsched signal_perms };
 allow NetworkManager_t self:fifo_file rw_file_perms;
-allow NetworkManager_t self:unix_dgram_socket create_socket_perms;
+allow NetworkManager_t self:unix_dgram_socket { sendto create_socket_perms };
 allow NetworkManager_t self:unix_stream_socket create_stream_socket_perms;
 allow NetworkManager_t self:netlink_route_socket create_netlink_socket_perms;
 allow NetworkManager_t self:tcp_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.2.15/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-02-14 07:20:26.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/services/postfix.te	2006-02-14 08:04:17.000000000 -0500
@@ -273,6 +273,8 @@
 corecmd_exec_shell(postfix_local_t)
 corecmd_exec_bin(postfix_local_t)
 
+files_read_etc_files(postfix_local_t)
+
 mta_read_aliases(postfix_local_t)
 mta_delete_spool(postfix_local_t)
 # For reading spamassasin
@@ -394,6 +396,7 @@
 
 allow postfix_pipe_t postfix_private_t:dir search;
 allow postfix_pipe_t postfix_private_t:sock_file write;
+allow postfix_pipe_t postfix_public_t:fifo_file { getattr write };
 
 allow postfix_pipe_t postfix_spool_t:dir search;
 allow postfix_pipe_t postfix_spool_t:file rw_file_perms;
@@ -425,6 +428,7 @@
 term_dontaudit_use_all_user_ttys(postfix_postdrop_t)
 
 sysnet_dns_name_resolve(postfix_postdrop_t)
+sysnet_dontaudit_read_config(postfix_postdrop_t)
 
 mta_rw_user_mail_stream_sockets(postfix_postdrop_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.2.15/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-02-14 07:20:28.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/services/spamassassin.te	2006-02-14 08:04:17.000000000 -0500
@@ -78,6 +78,7 @@
 # random ports >= 1024.
 corenet_udp_bind_generic_port(spamd_t)
 corenet_tcp_connect_razor_port(spamd_t)
+sysnet_use_ldap(spamd_t)
 
 dev_read_sysfs(spamd_t)
 dev_read_urand(spamd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.fc serefpolicy-2.2.15/policy/modules/system/init.fc
--- nsaserefpolicy/policy/modules/system/init.fc	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/init.fc	2006-02-14 08:04:17.000000000 -0500
@@ -22,7 +22,8 @@
 #
 # /sbin
 #
-/sbin/init		--	gen_context(system_u:object_r:init_exec_t,s0)
+/sbin/init(ng)?		--	gen_context(system_u:object_r:init_exec_t,s0)
+
 
 ifdef(`distro_gentoo', `
 /sbin/rc			--	gen_context(system_u:object_r:initrc_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.15/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-02-08 10:03:08.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/init.te	2006-02-14 08:04:17.000000000 -0500
@@ -157,6 +157,7 @@
 
 mls_file_read_up(init_t)
 mls_file_write_down(init_t)
+mls_killall(init_t)
 mls_rangetrans_target(init_t)
 
 seutil_read_config(init_t)
@@ -362,6 +363,7 @@
 
 mls_file_read_up(initrc_t)
 mls_file_write_down(initrc_t)
+mls_killall(initrc_t)
 mls_process_read_up(initrc_t)
 mls_process_write_down(initrc_t)
 mls_rangetrans_source(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.if serefpolicy-2.2.15/policy/modules/system/libraries.if
--- nsaserefpolicy/policy/modules/system/libraries.if	2006-02-10 21:34:15.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/libraries.if	2006-02-14 08:04:17.000000000 -0500
@@ -283,6 +283,7 @@
 
 	allow $1 lib_t:dir search_dir_perms;
 	allow $1 lib_t:file manage_file_perms;
+	allow $1 lib_t:lnk_file unlink;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.fc serefpolicy-2.2.15/policy/modules/system/selinuxutil.fc
--- nsaserefpolicy/policy/modules/system/selinuxutil.fc	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/selinuxutil.fc	2006-02-14 08:04:17.000000000 -0500
@@ -10,6 +10,7 @@
 /etc/selinux/([^/]*/)?contexts/files(/.*)? gen_context(system_u:object_r:file_context_t,s0)
 
 /etc/selinux/([^/]*/)?policy(/.*)?	gen_context(system_u:object_r:policy_config_t,s15:c0.c255)
+/etc/selinux/([^/]*/)?modules(/.*)?	gen_context(system_u:object_r:policy_config_t,s15:c0.c255)
 /etc/selinux/([^/]*/)?seusers	--	gen_context(system_u:object_r:selinux_config_t,s15:c0.c255)
 /etc/selinux/([^/]*/)?users(/.*)?	--	gen_context(system_u:object_r:selinux_config_t,s15:c0.c255)
 
@@ -39,3 +40,5 @@
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?		gen_context(system_u:object_r:policy_src_t,s0)
 ')
+
+/usr/sbin/semodule		--	gen_context(system_u:object_r:semodule_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.if serefpolicy-2.2.15/policy/modules/system/selinuxutil.if
--- nsaserefpolicy/policy/modules/system/selinuxutil.if	2006-02-10 21:34:15.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/selinuxutil.if	2006-02-14 08:04:17.000000000 -0500
@@ -587,6 +587,22 @@
 
 ########################################
 #
+# seutil_rw_file_contexts(domain)
+#
+interface(`seutil_rw_file_contexts',`
+	gen_require(`
+		type selinux_config_t, file_context_t;
+	')
+
+	files_search_etc($1)
+	allow $1 selinux_config_t:dir search;
+	allow $1 file_context_t:dir r_dir_perms;
+	allow $1 file_context_t:file rw_file_perms;
+	allow $1 file_context_t:lnk_file { getattr read };
+')
+
+########################################
+#
 # seutil_read_bin_policy(domain)
 #
 interface(`seutil_read_bin_policy',`
@@ -649,7 +665,7 @@
 
 	files_search_etc($1)
 	allow $1 selinux_config_t:dir search;
-	allow $1 policy_config_t:dir rw_dir_perms;
+	allow $1 policy_config_t:dir create_dir_perms;
 	allow $1 policy_config_t:file create_file_perms;
 	typeattribute $1 can_write_binary_policy;
 ')
@@ -684,3 +700,27 @@
 	allow $1 policy_src_t:file create_file_perms;
 ')
 
+########################################
+## <summary>
+##	Execute a domain transition to run semodule.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`semodule_domtrans',`
+	gen_require(`
+		type semodule_t, semodule_exec_t;
+	')
+	files_search_usr($1)
+	corecmd_search_bin($1)
+
+	domain_auto_trans($1,semodule_exec_t,semodule_t)
+
+	allow $1 semodule_t:fd use;
+	allow semodule_t $1:fd use;
+	allow semodule_t $1:fifo_file rw_file_perms;
+	allow semodule_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.15/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-02-14 07:20:31.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/selinuxutil.te	2006-02-14 08:04:17.000000000 -0500
@@ -535,3 +535,53 @@
 # scripts will put things in a state such that setfiles can not be run!
 allow setfiles_t lib_t:file { read execute };
 ') dnl endif TODO
+
+########################################
+#
+# Declarations
+#
+
+type semodule_t;
+domain_type(semodule_t)
+type semodule_exec_t;
+domain_entry_file(semodule_t, semodule_exec_t)
+role system_r types semodule_t;
+
+term_use_all_terms(semodule_t)
+allow semodule_t policy_config_t:file { read write };
+
+########################################
+#
+# semodule local policy
+#
+corecmd_exec_bin(semodule_t)
+corecmd_exec_sbin(semodule_t)
+
+files_read_etc_files(semodule_t)
+files_search_etc(semodule_t)
+files_list_usr(semodule_t)
+files_list_pids(semodule_t)
+files_read_usr_files(semodule_t)
+
+kernel_read_system_state(semodule_t)
+kernel_read_kernel_sysctls(semodule_t)
+
+libs_use_ld_so(semodule_t)
+libs_use_shared_libs(semodule_t)
+libs_use_lib_files(semodule_t)
+
+mls_rangetrans_target(semodule_t)
+
+optional_policy(`selinux', `
+	selinux_get_enforce_mode(semodule_t)
+')
+
+seutil_search_default_contexts(semodule_t)
+seutil_rw_file_contexts(semodule_t)
+seutil_domtrans_setfiles(semodule_t)
+seutil_domtrans_loadpolicy(semodule_t)
+seutil_read_config(semodule_t)
+seutil_manage_bin_policy(semodule_t)
+seutil_use_newrole_fd(semodule_t)
+
+allow semodule_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.15/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-02-14 07:20:31.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/unconfined.if	2006-02-14 08:04:17.000000000 -0500
@@ -55,10 +55,11 @@
 	tunable_policy(`allow_execmem && allow_execstack',`
 		# Allow making the stack executable via mprotect.
 		allow $1 self:process execstack;
+		auditallow $1 self:process execstack;
 	', `
 		# These are fairly common but seem to be harmless
 		# caused by using shared libraries built with old tool chains
-		dontaudit $1 self:process execstack;
+		#dontaudit $1 self:process execstack;
 	')
 
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.15/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-02-14 07:20:31.000000000 -0500
+++ serefpolicy-2.2.15/policy/modules/system/userdomain.te	2006-02-14 08:04:17.000000000 -0500
@@ -168,7 +168,11 @@
 		logging_read_audit_log(secadm_t)
 		logging_domtrans_auditctl(secadm_t)
 		mls_process_read_up(secadm_t)
+		mls_file_write_down(secadm_t)
+		mls_file_upgrade(secadm_t)
+		mls_file_downgrade(secadm_t)
 		userdom_dontaudit_append_staff_home_files(secadm_t)
+		corecmd_exec_shell(sysadm_t)
 	', `
 		logging_domtrans_auditctl(sysadm_t)
 		logging_read_audit_log(sysadm_t)
@@ -354,6 +358,9 @@
 			seutil_run_checkpolicy(secadm_t,secadm_r,admin_terminal)
 			seutil_run_loadpolicy(secadm_t,secadm_r,admin_terminal)
 			seutil_run_setfiles(secadm_t,secadm_r,admin_terminal)
+			semodule_domtrans(secadm_t)
+			role secadm_r types semodule_t;
+			seutil_run_restorecon(secadm_t,secadm_r,admin_terminal)
 		', `
 			selinux_set_enforce_mode(sysadm_t)
 			selinux_set_boolean(sysadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/Rules.modular serefpolicy-2.2.15/Rules.modular
--- nsaserefpolicy/Rules.modular	2006-02-14 07:20:18.000000000 -0500
+++ serefpolicy-2.2.15/Rules.modular	2006-02-14 08:04:17.000000000 -0500
@@ -83,7 +83,7 @@
 #
 $(BASE_PKG): tmp/base.mod $(BASE_FC)
 	@echo "Creating $(NAME) base module package"
-	$(verbose) $(SEMOD_PKG) -o $@ -m tmp/base.mod -f $(BASE_FC)
+	$(verbose) $(SEMOD_PKG) $(USER_EXTRAS) -o $@ -m tmp/base.mod -f $(BASE_FC)
 
 tmp/base.mod: base.conf
 	@echo "Compiling $(NAME) base module"
diff --exclude-from=exclude -N -u -r nsaserefpolicy/support/Makefile.devel serefpolicy-2.2.15/support/Makefile.devel
--- nsaserefpolicy/support/Makefile.devel	2006-02-10 17:05:19.000000000 -0500
+++ serefpolicy-2.2.15/support/Makefile.devel	2006-02-14 08:41:26.000000000 -0500
@@ -1,3 +1,6 @@
+# installation paths
+SHAREDIR := $(PREFIX)/share/selinux
+HEADERDIR := $(SHAREDIR)/refpolicy/include
 
 include $(HEADERDIR)/build.conf
 
@@ -19,8 +22,13 @@
 PYTHON ?= python
 
 # set default build options if missing
-TYPE ?= strict
-NAME ?= $(TYPE)
+NAME ?= $(shell . /etc/selinux/config; echo $$SELINUXTYPE)
+MLSENABLED := $(shell cat /selinux/mls)
+ifeq ($(MLSENABLED),1)
+MCSFLAG=-mcs
+endif
+
+TYPE ?= $(NAME)${MCSFLAG}
 DIRECT_INITRC ?= n
 POLY ?= n
 QUIET ?= y

--------------010807080200000805010805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
