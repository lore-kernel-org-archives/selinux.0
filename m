Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QELiAG007519
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 10:21:44 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2QELg81001310
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 14:21:43 GMT
Subject: Re: Hal changes.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F0267B.9040508@redhat.com>
References: <45F0267B.9040508@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 10:22:17 -0400
Message-Id: <1174918938.28830.21.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:06 -0500, Daniel J Walsh wrote:
> Beginning to break out hal policy into it's helper apps.  So hald_mac is 
> the only  domain that needs to write to  /dev/shm and hald_acl  needs 
> dac overrides.

Well this is a welcome sight.  How much testing has this received?  I'm
hoping that the read of /dev/mem thats still in hald_t can be split out
too.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (nsaserefpolicy_policy_modules_services_hal.patch)
> 
> --- nsaserefpolicy/policy/modules/services/hal.fc       2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/hal.fc    2007-03-08 08:42:37.000000000 -0500
> @@ -8,4 +8,10 @@
>  
>  /var/lib/hal(/.*)?                             gen_context(system_u:object_r:hald_var_lib_t,s0)
>  
> +/var/cache/hald(/.*)?                          gen_context(system_u:object_r:hald_cache_t,s0)
> +
>  /var/run/haldaemon.pid --                      gen_context(system_u:object_r:hald_var_run_t,s0)
> +
> +/usr/libexec/hal-acl-tool              --      gen_context(system_u:object_r:hald_acl_exec_t,s0)
> +
> +/usr/libexec/hald-addon-macbookpro-backlight --        gen_context(system_u:object_r:hald_mac_exec_t,s0)
> --- nsaserefpolicy/policy/modules/services/hal.te       2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/hal.te    2007-03-08 08:42:37.000000000 -0500
> @@ -16,9 +16,24 @@
>  type hald_var_run_t;
>  files_pid_file(hald_var_run_t)
>  
> +type hald_cache_t;
> +files_pid_file(hald_cache_t)
> +
>  type hald_var_lib_t;
>  files_type(hald_var_lib_t)
>  
> +type hald_acl_t;
> +type hald_acl_exec_t;
> +domain_type(hald_acl_t)
> +domain_entry_file(hald_acl_t,hald_acl_exec_t)
> +role system_r types hald_acl_t;
> +
> +type hald_mac_t;
> +type hald_mac_exec_t;
> +domain_type(hald_mac_t)
> +domain_entry_file(hald_mac_t,hald_mac_exec_t)
> +role system_r types hald_mac_t;
> +
>  ########################################
>  #
>  # Local policy
> @@ -26,7 +41,7 @@
>  
>  # execute openvt which needs setuid
>  allow hald_t self:capability { chown setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
> -dontaudit hald_t self:capability sys_tty_config;
> +dontaudit hald_t self:capability {sys_ptrace sys_tty_config };
>  allow hald_t self:process signal_perms;
>  allow hald_t self:fifo_file rw_fifo_file_perms;
>  allow hald_t self:unix_stream_socket { create_stream_socket_perms connectto };
> @@ -51,11 +66,13 @@
>  manage_files_pattern(hald_t,hald_var_run_t,hald_var_run_t)
>  files_pid_filetrans(hald_t,hald_var_run_t,file)
>  
> +manage_files_pattern(hald_t,hald_cache_t,hald_cache_t)
> +
>  kernel_read_system_state(hald_t)
>  kernel_read_network_state(hald_t)
>  kernel_read_kernel_sysctls(hald_t)
>  kernel_read_fs_sysctls(hald_t)
> -kernel_read_irq_sysctls(hald_t)
> +kernel_rw_irq_sysctls(hald_t)
>  kernel_rw_vm_sysctls(hald_t)
>  kernel_write_proc_files(hald_t)
>  
> @@ -85,9 +102,13 @@
>  dev_rw_power_management(hald_t)
>  # hal is now execing pm-suspend
>  dev_rw_sysfs(hald_t)
> +dev_read_sound(hald_t)
> +dev_write_sound(hald_t)
> +dev_read_raw_memory(hald_t)
>  
>  domain_use_interactive_fds(hald_t)
>  domain_read_all_domains_state(hald_t)
> +domain_dontaudit_ptrace_all_domains(hald_t)
>  
>  files_exec_etc_files(hald_t)
>  files_read_etc_files(hald_t)
> @@ -101,6 +122,7 @@
>  files_create_boot_flag(hald_t)
>  files_getattr_all_dirs(hald_t)
>  files_read_kernel_img(hald_t)
> +files_rw_lock_dirs(hald_t)
>  
>  fs_getattr_all_fs(hald_t)
>  fs_search_all(hald_t)
> @@ -130,10 +152,10 @@
>  init_use_fds(hald_t)
>  init_use_script_ptys(hald_t)
>  init_domtrans_script(hald_t)
> -init_write_initctl(hald_t)
>  init_read_utmp(hald_t)
>  #hal runs shutdown, probably need a shutdown domain
>  init_rw_utmp(hald_t)
> +init_telinit(hald_t)
>  
>  libs_use_ld_so(hald_t)
>  libs_use_shared_libs(hald_t)
> @@ -248,3 +270,68 @@
>  optional_policy(`
>         vbetool_domtrans(hald_t)
>  ')
> +
> +########################################
> +#
> +# Local hald acl policy
> +#
> +
> +allow hald_acl_t self:capability { dac_override fowner };
> +allow hald_acl_t self : fifo_file read_fifo_file_perms;
> +
> +domtrans_pattern(hald_t, hald_acl_exec_t, hald_acl_t)
> +allow hald_t hald_acl_t : process signal;
> +allow hald_acl_t hald_t : unix_stream_socket connectto;
> +manage_dirs_pattern(hald_acl_t,hald_var_lib_t,hald_var_lib_t)
> +manage_files_pattern(hald_acl_t,hald_var_lib_t,hald_var_lib_t)
> +
> +corecmd_exec_bin(hald_acl_t)
> +corecmd_search_sbin(hald_acl_t)
> +
> +dev_setattr_video_dev(hald_acl_t)
> +dev_getattr_sound_dev(hald_acl_t)
> +dev_setattr_sound_dev(hald_acl_t)
> +
> +libs_use_ld_so(hald_acl_t)
> +libs_use_shared_libs(hald_acl_t)
> +
> +files_search_var_lib(hald_acl_t)
> +files_read_usr_files(hald_acl_t)
> +files_read_etc_files(hald_acl_t)
> +
> +storage_getattr_removable_dev(hald_acl_t)
> +storage_setattr_removable_dev(hald_acl_t)
> +
> +miscfiles_read_localization(hald_acl_t)
> +
> +ifdef(`targeted_policy',`
> +       term_dontaudit_use_console(hald_acl_t)
> +       term_dontaudit_use_generic_ptys(hald_acl_t)
> +')
> +
> +########################################
> +#
> +# Local hald mac policy
> +#
> +
> +domtrans_pattern(hald_t, hald_mac_exec_t, hald_mac_t)
> +allow hald_t hald_mac_t : process signal;
> +allow hald_mac_t hald_t : unix_stream_socket connectto;
> +
> +files_search_var_lib(hald_mac_t)
> +manage_dirs_pattern(hald_mac_t,hald_var_lib_t,hald_var_lib_t)
> +manage_files_pattern(hald_mac_t,hald_var_lib_t,hald_var_lib_t)
> +
> +libs_use_ld_so(hald_mac_t)
> +libs_use_shared_libs(hald_mac_t)
> +
> +files_read_usr_files(hald_mac_t)
> +
> +dev_write_raw_memory(hald_mac_t)
> +
> +miscfiles_read_localization(hald_mac_t)
> +
> +ifdef(`targeted_policy',`
> +       term_dontaudit_use_console(hald_mac_t)
> +       term_dontaudit_use_generic_ptys(hald_mac_t)
> +') 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
