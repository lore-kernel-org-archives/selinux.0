Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l85Hn5rD015668
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 13:49:05 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l85Hn2PH019730
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 17:49:02 GMT
Subject: Re: [PATCH] refpolicy: system_udev changes including brctl policy.
	 Mostly xen related
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021816.l72IGxVT022810@redsox.boston.devel.redhat.com>
References: <200708021816.l72IGxVT022810@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 13:47:43 -0400
Message-Id: <1189014463.30065.34.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.  Moved brctl to admin layer.

On Thu, 2007-08-02 at 14:16 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/system/udev.te        2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/udev.te     2007-08-02
> 11:02:02.000000000 -0400
> @@ -68,8 +68,9 @@
>  allow udev_t udev_tbl_t:file manage_file_perms;
>  dev_filetrans(udev_t,udev_tbl_t,file)
> 
> +manage_dirs_pattern(udev_t,udev_var_run_t,udev_var_run_t)
>  manage_files_pacttern(udev_t,udev_var_run_t,udev_var_run_t)
> -files_pid_filetrans(udev_t,udev_var_run_t,file)
> +files_pid_filetrans(udev_t,udev_var_run_t,{ file dir })
> 
>  kernel_read_system_state(udev_t)
>  kernel_getattr_core_if(udev_t)
> @@ -83,16 +84,23 @@
>  kernel_dgram_send(udev_t)
>  kernel_signal(udev_t)
> 
> +#https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=235182
> +kernel_rw_net_sysctls(udev_t)
> +kernel_read_network_state(udev_t)
> +
>  corecmd_exec_all_executables(udev_t)
> 
>  dev_rw_sysfs(udev_t)
>  dev_manage_all_dev_nodes(udev_t)
>  dev_rw_generic_files(udev_t)
>  dev_delete_generic_files(udev_t)
> +dev_search_usbfs_dirs(udev_t)
> +dev_relabel_all_dev_nodes(udev_t)
> 
>  domain_read_all_domains_state(udev_t)
>  domain_dontaudit_ptrace_all_domains(udev_t) #pidof triggers these
> 
> +files_read_usr_files(udev_t)
>  files_read_etc_runtime_files(udev_t)
>  files_read_etc_files(udev_t)
>  files_exec_etc_files(udev_t)
> @@ -142,9 +150,16 @@
>  seutil_read_file_contexts(udev_t)
>  seutil_domtrans_setfiles(udev_t)
> 
> +sysnet_read_dhcpc_pid(udev_t)
> +sysnet_rw_dhcp_config(udev_t)
> +sysnet_delete_dhcpc_pid(udev_t)
>  sysnet_domtrans_ifconfig(udev_t)
>  sysnet_domtrans_dhcpc(udev_t)
> +sysnet_signal_dhcpc(udev_t)
> +sysnet_etc_filetrans_config(udev_t)
> +sysnet_manage_config(udev_t)
> 
> +userdom_use_sysadm_ttys(udev_t)
>  userdom_dontaudit_search_all_users_home_content(udev_t)
> 
>  ifdef(`distro_gentoo',`
> @@ -170,6 +185,10 @@
>  ')
> 
>  optional_policy(`
> +       brctl_domtrans(udev_t)
> +')
> +
> +optional_policy(`
>         consoletype_exec(udev_t)
>  ')
> 
> @@ -178,6 +197,10 @@
>  ')
> 
>  optional_policy(`
> +       fstools_domtrans(udev_t)
> +')
> +
> +optional_policy(`
>         hal_dgram_send(udev_t)
>  ')
> 
> @@ -188,5 +211,24 @@
>  ')
> 
>  optional_policy(`
> +       openct_read_pid_files(udev_t)
> +       openct_domtrans(udev_t)
> +')
> +
> +optional_policy(`
> +       pcscd_read_pub_files(udev_t)
> +       pcscd_domtrans(udev_t)
> +')
> +
> +optional_policy(`
> +       xen_manage_log(udev_t)
> +       kernel_write_xen_state(udev_t)
> +       kernel_read_xen_state(udev_t)
> +       xen_read_image_files(udev_t)
> +')
> +
> +optional_policy(`
>         xserver_read_xdm_pid(udev_t)
>  ')
> +
> +
> --- nsaserefpolicy/policy/modules/system/brctl.fc       1969-12-31
> 19:00:00.000000000 -0500
> +++ serefpolicy-3.0.5/policy/modules/system/brctl.fc    2007-08-02
> 11:02:02.000000000 -0400
> @@ -0,0 +1,2 @@
> +
> +/usr/sbin/brctl                --
> gen_context(system_u:object_r:brctl_exec_t,s0)
> --- nsaserefpolicy/policy/modules/system/brctl.if       1969-12-31
> 19:00:00.000000000 -0500
> +++ serefpolicy-3.0.5/policy/modules/system/brctl.if    2007-08-02
> 11:02:02.000000000 -0400
> @@ -0,0 +1,25 @@
> +
> +## <summary>Utilities for configuring the linux ethernet
> bridge</summary>
> +
> +
> +########################################
> +## <summary>
> +##     Execute a domain transition to run brctl.
> +## </summary>
> +## <param name="domain">
> +## <summary>
> +##     Domain allowed to transition.
> +## </summary>
> +## </param>
> +#
> +interface(`brctl_domtrans',`
> +       gen_require(`
> +               type brctl_t, brctl_exec_t;
> +       ')
> +
> +       domain_auto_trans($1,brctl_exec_t,brctl_t)
> +
> +       allow brctl_t $1:fd use;
> +       allow brctl_t $1:fifo_file rw_file_perms;
> +       allow brctl_t $1:process sigchld;
> +')
> --- nsaserefpolicy/policy/modules/system/brctl.te       1969-12-31
> 19:00:00.000000000 -0500
> +++ serefpolicy-3.0.5/policy/modules/system/brctl.te    2007-08-02
> 11:02:02.000000000 -0400
> @@ -0,0 +1,50 @@
> +policy_module(brctl,1.0.0)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +type brctl_t;
> +type brctl_exec_t;
> +domain_type(brctl_t)
> +init_daemon_domain(brctl_t, brctl_exec_t)
> +
> +########################################
> +#
> +# brctl local policy
> +#
> +
> +allow brctl_t self:capability net_admin;
> +
> +allow brctl_t self:tcp_socket create_socket_perms;
> +allow brctl_t self:unix_dgram_socket create_socket_perms;
> +
> +dev_rw_sysfs(brctl_t)
> +
> +# Init script handling
> +domain_use_interactive_fds(brctl_t)
> +
> +kernel_load_module(brctl_t)
> +kernel_read_network_state(brctl_t)
> +kernel_read_sysctl(brctl_t)
> +
> +## internal communication is often done using fifo and unix sockets.
> +allow brctl_t self:fifo_file rw_file_perms;
> +allow brctl_t self:unix_stream_socket create_stream_socket_perms;
> +
> +files_read_etc_files(brctl_t)
> +
> +libs_use_ld_so(brctl_t)
> +libs_use_shared_libs(brctl_t)
> +
> +miscfiles_read_localization(brctl_t)
> +
> +ifdef(`targeted_policy',`
> +       term_dontaudit_use_unallocated_ttys(brctl_t)
> +       term_dontaudit_use_generic_ptys(brctl_t)
> +')
> +
> +optional_policy(`
> +       xen_append_log(brctl_t)
> +')
> From:  dwalsh@redhat.com
> To: cpebenito@tresys.com
> CC: selinux@tycho.nsa.gov
> Subject: [PATCH] refpolicy: kernel_devices changes
> --text follows this line--
> --- nsaserefpolicy/policy/modules/kernel/devices.fc     2007-06-15
> 14:54:30.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/kernel/devices.fc  2007-08-02
> 11:02:02.000000000 -0400
> @@ -12,6 +12,7 @@
>  /dev/atibm             -c
> gen_context(system_u:object_r:mouse_device_t,s0)
>  /dev/audio.*           -c
> gen_context(system_u:object_r:sound_device_t,s0)
>  /dev/beep              -c
> gen_context(system_u:object_r:sound_device_t,s0)
> +/dev/dmfm              -c
> gen_context(system_u:object_r:sound_device_t,s0)
>  /dev/dsp.*             -c
> gen_context(system_u:object_r:sound_device_t,s0)
>  /dev/efirtc            -c
> gen_context(system_u:object_r:clock_device_t,s0)
>  /dev/em8300.*          -c
> gen_context(system_u:object_r:v4l_device_t,s0)
> @@ -19,6 +20,7 @@
>  /dev/evtchn            -c
> gen_context(system_u:object_r:xen_device_t,s0)
>  /dev/fb[0-9]*          -c
> gen_context(system_u:object_r:framebuf_device_t,s0)
>  /dev/full              -c
> gen_context(system_u:object_r:null_device_t,s0)
> +/dev/[0-9].*           -c
> gen_context(system_u:object_r:usb_device_t,s0)
>  /dev/fw.*              -c
> gen_context(system_u:object_r:usb_device_t,s0)
>  /dev/hiddev.*          -c
> gen_context(system_u:object_r:usb_device_t,s0)
>  /dev/hpet              -c
> gen_context(system_u:object_r:clock_device_t,s0)
> @@ -53,7 +55,7 @@
>  /dev/radio.*           -c
> gen_context(system_u:object_r:v4l_device_t,s0)
>  /dev/random            -c
> gen_context(system_u:object_r:random_device_t,s0)
>  /dev/raw1394.*         -c
> gen_context(system_u:object_r:v4l_device_t,s0)
> -/dev/(misc/)?rtc       -c
> gen_context(system_u:object_r:clock_device_t,s0)
> +/dev/(misc/)?rtc[0-9]* -c
> gen_context(system_u:object_r:clock_device_t,s0)
>  /dev/sequencer         -c
> gen_context(system_u:object_r:sound_device_t,s0)
>  /dev/sequencer2                -c
> gen_context(system_u:object_r:sound_device_t,s0)
>  /dev/smpte.*           -c
> gen_context(system_u:object_r:sound_device_t,s0)
> @@ -64,7 +66,9 @@
>  /dev/sonypi            -c
> gen_context(system_u:object_r:v4l_device_t,s0)
>  /dev/tlk[0-3]          -c
> gen_context(system_u:object_r:v4l_device_t,s0)
>  /dev/urandom           -c
> gen_context(system_u:object_r:urandom_device_t,s0)
> +/dev/usbmon[0-9]+      -c
> gen_context(system_u:object_r:usb_device_t,s0)
>  /dev/usbdev.*          -c
> gen_context(system_u:object_r:usb_device_t,s0)
> +/dev/usb[0-9]+         -c
> gen_context(system_u:object_r:usb_device_t,s0)
>  /dev/usblp.*           -c
> gen_context(system_u:object_r:printer_device_t,s0)
>  ifdef(`distro_suse', `
>  /dev/usbscanner                -c
> gen_context(system_u:object_r:scanner_device_t,s0)
> @@ -127,3 +131,7 @@
>  /var/named/chroot/dev/random -c
> gen_context(system_u:object_r:random_device_t,s0)
>  /var/named/chroot/dev/zero -c
> gen_context(system_u:object_r:zero_device_t,s0)
>  ')
> +
> +/etc/udev/devices -d   gen_context(system_u:object_r:device_t,s0)
> +/lib/udev/devices -d   gen_context(system_u:object_r:device_t,s0)
> +
> --- nsaserefpolicy/policy/modules/kernel/devices.if     2007-06-15
> 14:54:30.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/kernel/devices.if  2007-08-02
> 11:02:02.000000000 -0400
> @@ -2803,6 +2803,24 @@
> 
>  ########################################
>  ## <summary>
> +##     Get the attributes of a directory in the usb filesystem.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`dev_search_usbfs_dirs',`
> +       gen_require(`
> +               type usbfs_t;
> +       ')
> +
> +       allow $1 usbfs_t:dir search_dir_perms;
> +')
> +
> +########################################
> +## <summary>
>  ##     Do not audit attempts to get the attributes
>  ##     of a directory in the usb filesystem.
>  ## </summary>
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
