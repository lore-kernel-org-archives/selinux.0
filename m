Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89CsXrT011249
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 08:54:33 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89Creo3027851
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 12:53:40 GMT
Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters
	for dbus.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <413E1DE0.9050905@redhat.com>
References: <413E1DE0.9050905@redhat.com>
Content-Type: text/plain
Message-Id: <1094734410.2895.45.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Sep 2004 08:53:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I build the policy with this patch there is a conflict with two
type transitions.

Because of the alias rule:
typealias system_dbusd_exec_t alias dbusd_exec_t;

The following type transitions conflict:
type_transition sysadm_t dbusd_exec_t:process sysadm_dbusd_t;
type_transition sysadm_t system_dbusd_exec_t:process system_dbusd_t;

The second transition is the one used when I build the policy.  I am not
sure if that is the desired transition.


Where they come from:

type_transition sysadm_t dbusd_exec_t:process sysadm_dbusd_t;
	from dbusd_macros.te, line 24:
		domain_auto_trans($1_t, dbusd_exec_t, $1_dbusd_t)
	from base_user_macros.te, line 120: dbusd_domain($1)
	from admin_macros.te, line 30: base_user_domain($1)
	from admin.te, line 19: admin_domain(sysadm)

type_transition sysadm_t system_dbusd_exec_t:process system_dbusd_t;
	from global_macros.te, line 351: 
		domain_auto_trans(sysadm_t, $1_exec_t, $1_t)
	from dbusd_macros.te, line 12: 
		daemon_domain(system_dbusd, `, userspace_objmgr')
	from dbusd.te, line 5: dbusd_domain(system)

typealias system_dbusd_exec_t alias dbusd_exec_t;
	from dbusd_macros.te, line 15	

On Tue, 2004-09-07 at 16:45, Daniel J Walsh wrote:
> Adding
> 
> restorecon /dev /dev/null
> restorecon /dev/*
> 
> and the attached policy patch seems to clear up the problems with udev 
> and tmpfs.
> 
> Dan
> 
> ______________________________________________________________________
> diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.17.10/attrib.te
> --- nsapolicy/attrib.te	2004-09-01 14:00:01.000000000 -0400
> +++ policy-1.17.10/attrib.te	2004-09-07 15:55:15.049943838 -0400
> @@ -347,9 +347,6 @@
>  # For web clients such as netscape and squid
>  attribute web_client_domain;
>  
> -# For a dbus client
> -attribute dbus_client_domain;
> -
>  # For X Window System server domains
>  attribute xserver;
>  
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/hostname.te policy-1.17.10/domains/program/hostname.te
> --- nsapolicy/domains/program/hostname.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.10/domains/program/hostname.te	2004-09-07 15:56:44.609170450 -0400
> @@ -22,3 +22,4 @@
>  
>  # for when /usr is not mounted
>  dontaudit hostname_t file_t:dir search;
> +dontaudit hostname_t tmpfs_t:chr_file { read write };
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/init.te policy-1.17.10/domains/program/init.te
> --- nsapolicy/domains/program/init.te	2004-09-02 08:03:26.000000000 -0400
> +++ policy-1.17.10/domains/program/init.te	2004-09-07 15:56:26.230974473 -0400
> @@ -49,7 +49,7 @@
>  ')
>  
>  # Create /dev/initctl.
> -file_type_auto_trans(init_t, device_t, initctl_t, fifo_file)
> +file_type_auto_trans(init_t, { device_t tmpfs_t }, initctl_t, fifo_file)
>  
>  # Create ioctl.save.
>  file_type_auto_trans(init_t, etc_t, etc_runtime_t, file)
> @@ -114,8 +114,7 @@
>  can_setbool(init_t)
>  
>  # Read and write the console and ttys.
> -allow init_t console_device_t:chr_file rw_file_perms;
> -allow init_t tty_device_t:chr_file rw_file_perms;
> +allow init_t { tmpfs_t tty_device_t console_device_t } :chr_file rw_file_perms;
>  allow init_t ttyfile:chr_file rw_file_perms;
>  allow init_t ptyfile:chr_file rw_file_perms;
>  
> @@ -140,3 +139,5 @@
>  
>  # file descriptors inherited from the rootfs.
>  dontaudit init_t root_t:{ file chr_file } { read write }; 
> +
> +rw_dir_file(init_t, tmpfs_t)
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/restorecon.te policy-1.17.10/domains/program/restorecon.te
> --- nsapolicy/domains/program/restorecon.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.10/domains/program/restorecon.te	2004-09-07 15:57:33.287384531 -0400
> @@ -41,7 +41,9 @@
>  allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfrom };
>  allow restorecon_t unlabeled_t:dir read;
>  allow restorecon_t device_type:{ chr_file blk_file } { getattr relabelfrom relabelto };
> -allow restorecon_t device_t:{ chr_file blk_file } { getattr relabelfrom };
> +allow restorecon_t { tmpfs_t device_t device_type }:{chr_file blk_file} { getattr relabelfrom relabelto };
> +allow restorecon_t tmpfs_t:{chr_file blk_file} { read write };
> +
>  allow restorecon_t ptyfile:chr_file getattr;
>  
>  allow restorecon_t fs_t:filesystem getattr;
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.17.10/domains/program/unused/bluetooth.te
> --- nsapolicy/domains/program/unused/bluetooth.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/bluetooth.te	2004-09-07 15:55:15.094939442 -0400
> @@ -8,7 +8,7 @@
>  #
>  # Rules for the bluetooth_t domain.
>  #
> -daemon_domain(bluetooth, `, dbus_client_domain')
> +daemon_domain(bluetooth)
>  
>  file_type_auto_trans(bluetooth_t, var_run_t, bluetooth_var_run_t, sock_file)
>  
> @@ -22,6 +22,7 @@
>  # Use the network.
>  can_network(bluetooth_t)
>  can_ypbind(bluetooth_t)
> +dbusd_client(system, bluetooth_t)
>  allow bluetooth_t self:socket { create setopt ioctl bind listen };
>  allow bluetooth_t self:unix_dgram_socket create_socket_perms;
>  allow bluetooth_t self:unix_stream_socket create_stream_socket_perms;
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.10/domains/program/unused/cups.te
> --- nsapolicy/domains/program/unused/cups.te	2004-08-30 09:49:15.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/cups.te	2004-09-07 15:55:15.138935145 -0400
> @@ -12,7 +12,7 @@
>  # cupsd_exec_t is the type of the cupsd executable.
>  #
>  type ipp_port_t, port_type;
> -daemon_domain(cupsd, `, auth_chkpwd, dbus_client_domain')
> +daemon_domain(cupsd, `, auth_chkpwd')
>  etcdir_domain(cupsd)
>  typealias cupsd_etc_t alias etc_cupsd_t;
>  type cupsd_rw_etc_t, file_type, sysadmfile, usercanread;
> @@ -20,6 +20,7 @@
>  
>  can_network(cupsd_t)
>  can_ypbind(cupsd_t)
> +dbusd_client(system, cupsd_t)
>  logdir_domain(cupsd)
>  
>  tmp_domain(cupsd)
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.17.10/domains/program/unused/dbusd.te
> --- nsapolicy/domains/program/unused/dbusd.te	2004-09-01 14:00:02.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/dbusd.te	2004-09-07 15:55:15.028945889 -0400
> @@ -2,34 +2,17 @@
>  #
>  # Author:  Russell Coker <russell@coker.com.au>
>  
> -daemon_domain(dbusd, `, userspace_objmgr')
> -type etc_dbusd_t, file_type, sysadmfile;
> +dbusd_domain(system)
>  
> -allow dbusd_t dbusd_var_run_t:sock_file create_file_perms;
> +allow system_dbusd_t dbusd_var_run_t:sock_file create_file_perms;
>  
>  ifdef(`pamconsole.te', `
> -r_dir_file(dbusd_t, pam_var_console_t)
> +r_dir_file(system_dbusd_t, pam_var_console_t)
>  ')
>  
> -r_dir_file(dbusd_t, etc_dbusd_t)
> -allow dbusd_t self:unix_stream_socket create_stream_socket_perms;
> -allow dbusd_t self:unix_dgram_socket create_socket_perms;
> -
> -allow dbusd_t etc_t:file { getattr read };
>  # dac_override: /var/run/dbus is owned by messagebus on Debian
> -allow dbusd_t self:capability { dac_override setgid setuid };
> -allow dbusd_t self:file { getattr read };
> -allow dbusd_t proc_t:file { read };
> -can_ypbind(dbusd_t)
> +allow system_dbusd_t self:capability { dac_override setgid setuid };
> +can_ypbind(system_dbusd_t)
>  
>  # I expect we need more than this
> -allow { dbus_client_domain userdomain } { var_run_t dbusd_var_run_t }:dir search;
> -allow { dbus_client_domain userdomain } dbusd_var_run_t:sock_file { write };
> -allow { dbus_client_domain userdomain } dbusd_t:unix_stream_socket { connectto };
> -
> -# Permissions for SE-DBus operation
> -r_dir_file(dbusd_t,selinux_config_t)
> -
> -# SE-DBus specific permissions
> -allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };
> -domain_auto_trans(userdomain, dbusd_exec_t, dbusd_t)
> +
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.10/domains/program/unused/hald.te
> --- nsapolicy/domains/program/unused/hald.te	2004-09-02 08:03:26.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/hald.te	2004-09-07 15:55:15.183930749 -0400
> @@ -10,7 +10,7 @@
>  #
>  # hald_exec_t is the type of the hald executable.
>  #
> -daemon_domain(hald, `, dbus_client_domain, fs_domain')
> +daemon_domain(hald, `, fs_domain')
>  
>  can_exec(hald_t, hald_exec_t)
>  
> @@ -18,7 +18,7 @@
>  allow hald_t self:unix_stream_socket create_stream_socket_perms;
>  allow hald_t self:unix_dgram_socket create_socket_perms;
>  
> -allow hald_t dbusd_t:dbus { acquire_svc };
> +allow hald_t system_dbusd_t:dbus { acquire_svc };
>  
>  allow hald_t { self proc_t }:file { getattr read };
>  
> @@ -31,6 +31,7 @@
>  allow hald_t self:capability { net_admin sys_admin };
>  can_network(hald_t)
>  can_ypbind(hald_t)
> +dbusd_client(system, hald_t)
>  
>  allow hald_t device_t:lnk_file read;
>  allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
> @@ -47,3 +48,5 @@
>  
>  allow hald_t usbdevfs_t:dir search;
>  allow hald_t usbdevfs_t:file { getattr read };
> +allow hald_t usbfs_t:dir search;
> +allow hald_t usbfs_t:file { getattr read };
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.10/domains/program/unused/hotplug.te
> --- nsapolicy/domains/program/unused/hotplug.te	2004-09-01 14:00:02.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/hotplug.te	2004-09-07 15:55:15.128936121 -0400
> @@ -11,7 +11,7 @@
>  # hotplug_exec_t is the type of the hotplug executable.
>  #
>  ifdef(`unlimitedUtils', `
> -daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, dbus_client_domain, unrestricted')
> +daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, unrestricted')
>  ', `
>  daemon_domain(hotplug, `, privmodule, dbus_client_domain')
>  ')
> @@ -143,6 +143,7 @@
>  
>  can_network(hotplug_t)
>  can_ypbind(hotplug_t)
> +dbusd_client(system, hotplug_t)
>  
>  # Allow hotplug (including /sbin/ifup-local) to start/stop services and # run sendmail -q
>  domain_auto_trans(hotplug_t, initrc_exec_t, initrc_t)
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.17.10/domains/program/unused/kudzu.te
> --- nsapolicy/domains/program/unused/kudzu.te	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/kudzu.te	2004-09-07 15:54:49.325454423 -0400
> @@ -29,6 +29,8 @@
>  allow kudzu_t sysctl_kernel_t:file { getattr read write };
>  allow kudzu_t usbdevfs_t:dir search;
>  allow kudzu_t usbdevfs_t:file { getattr read };
> +allow kudzu_t usbfs_t:dir search;
> +allow kudzu_t usbfs_t:file { getattr read };
>  allow kudzu_t var_t:dir search;
>  allow kudzu_t kernel_t:system { syslog_console };
>  allow kudzu_t self:udp_socket { create ioctl };
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.10/domains/program/unused/udev.te
> --- nsapolicy/domains/program/unused/udev.te	2004-09-01 14:00:02.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/udev.te	2004-09-07 16:00:22.809653212 -0400
> @@ -9,7 +9,7 @@
>  #
>  # udev_exec_t is the type of the udev executable.
>  #
> -daemon_domain(udev, `, privmodule, privmem, fs_domain, privfd, dbus_client_domain')
> +daemon_domain(udev, `, privmodule, privmem, fs_domain, privfd')
>  
>  general_domain_access(udev_t)
>  
> @@ -28,10 +28,10 @@
>  allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
>  allow udev_t self:unix_dgram_socket create_socket_perms;
>  allow udev_t self:fifo_file rw_file_perms;
> -allow udev_t device_t:blk_file create_file_perms;
> -allow udev_t device_t:chr_file create_file_perms;
> -allow udev_t device_t:sock_file create_file_perms;
> -allow udev_t device_t:lnk_file create_lnk_perms;
> +allow udev_t { tmpfs_t device_t }:blk_file create_file_perms;
> +allow udev_t { tmpfs_t device_t }:chr_file create_file_perms;
> +allow udev_t { tmpfs_t device_t }:sock_file create_file_perms;
> +allow udev_t { tmpfs_t device_t }:lnk_file create_lnk_perms;
>  allow udev_t etc_t:file { getattr read };
>  allow udev_t { bin_t sbin_t }:dir r_dir_perms;
>  allow udev_t { sbin_t bin_t }:lnk_file read;
> @@ -40,7 +40,7 @@
>  can_exec(udev_t, udev_exec_t)
>  r_dir_file(udev_t, sysfs_t)
>  allow udev_t sysadm_tty_device_t:chr_file { read write };
> -allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
> +allow udev_t { tmpfs_t device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
>  	
>  # to read the file_contexts file
>  r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
> @@ -96,3 +96,10 @@
>  ifdef(`dhcpc.te', `
>  domain_auto_trans(udev_t, dhcpc_exec_t, dhcpc_t)
>  ')
> +
> +allow udev_t tmpfs_t:dir { search };
> +rw_dir_create_file(udev_t, { device_t tmpfs_t })
> +allow udev_t udev_helper_exec_t:dir r_dir_perms;
> +
> +dbusd_client(system, udev_t)
> +
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.10/domains/program/unused/updfstab.te
> --- nsapolicy/domains/program/unused/updfstab.te	2004-09-02 08:03:26.000000000 -0400
> +++ policy-1.17.10/domains/program/unused/updfstab.te	2004-09-07 15:55:15.115937391 -0400
> @@ -3,7 +3,7 @@
>  # Author:  Russell Coker <russell@coker.com.au>
>  #
>  
> -daemon_base_domain(updfstab, `, fs_domain, etc_writer, dbus_client_domain')
> +daemon_base_domain(updfstab, `, fs_domain, etc_writer')
>  
>  rw_dir_create_file(updfstab_t, etc_t)
>  create_dir_file(updfstab_t, mnt_t)
> @@ -28,6 +28,8 @@
>  
>  read_locale(updfstab_t)
>  
> +dbusd_client(system, updfstab_t)
> +
>  # not sure what the sysctl_kernel_t file is, or why it wants to write it, so
>  # I will not allow it
>  dontaudit updfstab_t { sysctl_t sysctl_kernel_t }:dir search;
> diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/named.fc policy-1.17.10/file_contexts/program/named.fc
> --- nsapolicy/file_contexts/program/named.fc	2004-08-31 10:55:37.000000000 -0400
> +++ policy-1.17.10/file_contexts/program/named.fc	2004-09-07 15:54:49.325454423 -0400
> @@ -14,7 +14,7 @@
>  ') dnl distro_debian
>  
>  /etc/rndc.*		--	system_u:object_r:named_conf_t
> -/usr/sbin/named.*      	--	system_u:object_r:named_exec_t
> +/usr/sbin/named      	--	system_u:object_r:named_exec_t
>  /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
>  /var/run/ndc		-s	system_u:object_r:named_var_run_t
>  /var/run/bind(/.*)?		system_u:object_r:named_var_run_t
> diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.10/macros/base_user_macros.te
> --- nsapolicy/macros/base_user_macros.te	2004-09-04 07:28:25.000000000 -0400
> +++ policy-1.17.10/macros/base_user_macros.te	2004-09-07 15:55:15.195929577 -0400
> @@ -185,6 +185,10 @@
>  can_network($1_t)
>  can_ypbind($1_t)
>  
> +# Grant permissions to access the system DBus
> +dbusd_client(system, $1_t)
> +dbusd_domain($1)
> +
>  # allow port_t name binding for UDP because it is not very usable otherwise
>  allow $1_t port_t:udp_socket name_bind;
>  
> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.17.10/macros/program/dbusd_macros.te
> --- nsapolicy/macros/program/dbusd_macros.te	1969-12-31 19:00:00.000000000 -0500
> +++ policy-1.17.10/macros/program/dbusd_macros.te	2004-09-07 15:55:15.038944913 -0400
> @@ -0,0 +1,62 @@
> +#
> +# Macros for Dbus
> +#
> +# Author: Colin Walters <walters@redhat.com>
> +
> +# dbusd_domain(domain_prefix)
> +#
> +# Define a derived domain for the DBus daemon.
> +
> +define(`dbusd_domain', `
> +ifelse(`system', `$1',`
> +daemon_domain(system_dbusd, `, userspace_objmgr')
> +# For backwards compatibility
> +typealias system_dbusd_t alias dbusd_t;
> +typealias system_dbusd_exec_t alias dbusd_exec_t;
> +typealias system_dbusd_var_run_t alias dbusd_var_run_t;
> +type etc_dbusd_t, file_type, sysadmfile;
> +',`
> +ifdef(`single_userdomain', `
> +typealias $1_t alias $1_dbusd_t;
> +', `
> +type $1_dbusd_t, domain, privlog, userspace_objmgr;
> +role $1_r types $1_dbusd_t;
> +domain_auto_trans($1_t, dbusd_exec_t, $1_dbusd_t)
> +
> +')dnl end ifdef single_userdomain
> +')dnl end ifelse system
> +
> +base_file_read_access($1_dbusd_t)
> +uses_shlib($1_dbusd_t)
> +allow $1_dbusd_t etc_t:file { getattr read };
> +r_dir_file($1_dbusd_t, etc_dbusd_t)
> +
> +allow $1_dbusd_t self:unix_stream_socket create_stream_socket_perms;
> +allow $1_dbusd_t self:unix_dgram_socket create_socket_perms;
> +
> +allow $1_dbusd_t urandom_device_t:chr_file { getattr read };
> +allow $1_dbusd_t self:file { getattr read };
> +allow $1_dbusd_t proc_t:file { read };
> +
> +')dnl end dbusd_domain definition
> +
> +# dbusd_client(dbus_type, domain)
> +# Example: dbusd_client_domain(system, user_t)
> +#
> +# Grant permissions for connecting to the specified DBus type
> +# from domain.
> +define(`dbusd_client',`')
> +ifdef(`dbusd.te',`
> +undefine(`dbusd_client')
> +define(`dbusd_client',`
> +# For connecting to the bus
> +allow $2 $1_dbusd_t:unix_stream_socket { connectto };
> +ifelse(`system', `$1', `
> +allow { $2 } { var_run_t system_dbusd_var_run_t }:dir search;
> +allow { $2 } system_dbusd_var_run_t:sock_file { write };
> +',`
> +') dnl endif system
> +# SE-DBus specific permissions
> +allow $2 { $1_dbusd_t self }:dbus { send_msg };
> +') dnl endif dbusd.te
> +')
> diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.10/tunables/distro.tun
> --- nsapolicy/tunables/distro.tun	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.10/tunables/distro.tun	2004-09-07 15:54:49.326454326 -0400
> @@ -5,7 +5,7 @@
>  # appropriate ifdefs.
>  
> 
> -dnl define(`distro_redhat')
> +define(`distro_redhat')
>  
>  dnl define(`distro_suse')
>  
> diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.10/tunables/tunable.tun
> --- nsapolicy/tunables/tunable.tun	2004-08-27 14:44:11.000000000 -0400
> +++ policy-1.17.10/tunables/tunable.tun	2004-09-07 15:54:49.327454228 -0400
> @@ -5,50 +5,47 @@
>  dnl define(`user_net_control')
>  
>  # Allow users to execute the mount command
> -dnl define(`user_can_mount')
> +define(`user_can_mount')
>  
>  # Allow rpm to run unconfined.
> -dnl define(`unlimitedRPM')
> +define(`unlimitedRPM')
>  
>  # Allow privileged utilities like hotplug and insmod to run unconfined.
> -dnl define(`unlimitedUtils')
> +define(`unlimitedUtils')
>  
>  # Support NFS home directories
> -dnl define(`nfs_home_dirs')
> +define(`nfs_home_dirs')
>  
>  # Allow users to run games
> -dnl define(`use_games')
> +define(`use_games')
>  
>  # Allow ypbind to run with NIS
> -dnl define(`allow_ypbind')
> +define(`allow_ypbind')
>  
>  # Allow rc scripts to run unconfined, including any daemon
>  # started by an rc script that does not have a domain transition
>  # explicitly defined.
> -dnl define(`unlimitedRC')
> +define(`unlimitedRC')
>  
>  # Allow sysadm_t to directly start daemons
>  define(`direct_sysadm_daemon')
>  
>  # Do not audit things that we know to be broken but which
>  # are not security risks
> -dnl define(`hide_broken_symptoms')
> +define(`hide_broken_symptoms')
>  
>  # Allow sysadm_t to do almost everything
>  dnl define(`unrestricted_admin')
>  
>  # Allow the read/write/create on any NFS file system
> -dnl define(`nfs_export_all_rw')
> -
> -# Allow users to unrestricted access
> -dnl define(`unlimitedUsers')
> +define(`nfs_export_all_rw')
>  
>  # Allow the reading on any NFS file system
>  dnl define(`nfs_export_all_ro')
>  
>  # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
>  # Otherwise, only staff_r can do so.
> -dnl define(`user_canbe_sysadm')
> +define(`user_canbe_sysadm')
>  
>  # Allow xinetd to run unconfined, including any services it starts
>  # that do not have a domain transition explicitly defined.
> diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.17.10/types/file.te
> --- nsapolicy/types/file.te	2004-08-30 09:49:16.000000000 -0400
> +++ policy-1.17.10/types/file.te	2004-09-07 15:54:49.327454228 -0400
> @@ -258,6 +258,7 @@
>  # the default file system type.
>  #
>  allow { file_type device_type } fs_t:filesystem associate;
> +allow { file_type device_type } tmpfs_t:filesystem associate;
>  
>  # Allow the pty to be associated with the file system.
>  allow devpts_t devpts_t:filesystem associate;
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
