Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB3DcIIi008372
	for <selinux@tycho.nsa.gov>; Fri, 3 Dec 2004 08:38:18 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB3DaiND011396
	for <selinux@tycho.nsa.gov>; Fri, 3 Dec 2004 13:36:44 GMT
Subject: Re: Latest patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41AF6C93.8040109@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
	 <41A4B54F.3070709@redhat.com>
	 <1101325733.12859.37.camel@moss-lions.epoch.ncsc.mil>
	 <41ACE3E6.5030801@redhat.com>
	 <1101995669.8032.20.camel@moss-lions.epoch.ncsc.mil>
	 <41AF23B0.4020100@redhat.com>
	 <1102009880.8372.6.camel@moss-lions.epoch.ncsc.mil>
	 <41AF6C93.8040109@redhat.com>
Content-Type: text/plain
Message-Id: <1102081248.15627.3.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 03 Dec 2004 08:40:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-12-02 at 14:27, Daniel J Walsh wrote:
> Allow booloader to run exec_type, so it can pick up consoletype.
> 
> Allow initrc to cleanup ptal runtime files in init scripts
> 
> Add file contexts for bin_t files in the /usr partition.
> 
> Fix policy so htdig will work
> 
> Make changes so ipx_interface and friends will run( ALthough I need help 
> on this stuff since I don't have access to IPX network, nor do
> I want too :*)
> 
> Fix console and jave labeling
> 
> ______________________________________________________________________
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.8/domains/program/unused/apache.te
> --- nsapolicy/domains/program/unused/apache.te	2004-11-29 10:24:17.000000000 -0500
> +++ policy-1.19.8/domains/program/unused/apache.te	2004-11-30 16:54:39.000000000 -0500
> @@ -332,3 +332,6 @@
>  ')
>  allow { httpd_t httpd_helper_t } admin_tty_type:chr_file { read write };
>  }
> +
> +read_sysctl(httpd_sys_script_t)
> +allow httpd_sys_script_t var_lib_t:dir search;
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bootloader.te policy-1.19.8/domains/program/unused/bootloader.te
> --- nsapolicy/domains/program/unused/bootloader.te	2004-11-05 23:24:16.000000000 -0500
> +++ policy-1.19.8/domains/program/unused/bootloader.te	2004-12-01 10:54:10.000000000 -0500
> @@ -58,7 +58,7 @@
>  # uncomment the following line if you use "lilo -p"
>  #file_type_auto_trans(bootloader_t, etc_t, bootloader_etc_t, file);
>  
> -can_exec(bootloader_t, { bootloader_exec_t shell_exec_t ls_exec_t bin_t sbin_t })
> +can_exec_any(bootloader_t)
>  allow bootloader_t shell_exec_t:lnk_file read;
>  allow bootloader_t { bin_t sbin_t }:dir search;
>  allow bootloader_t { bin_t sbin_t }:lnk_file read;
> @@ -131,14 +131,6 @@
>  allow bootloader_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
>  allow bootloader_t initrc_t:fifo_file { read write };
>  
> -ifdef(`distro_debian', `
> -# for making an initrd
> -can_exec(bootloader_t, mount_exec_t)
> -ifdef(`chroot.te', `
> -can_exec(bootloader_t, chroot_exec_t)
> -')dnl end chroot.te
> -')dnl end distro_debian
> -
>  # for reading BIOS data
>  allow bootloader_t memory_device_t:chr_file r_file_perms;
>  
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.19.8/domains/program/unused/cups.te
> --- nsapolicy/domains/program/unused/cups.te	2004-12-02 14:11:41.692784006 -0500
> +++ policy-1.19.8/domains/program/unused/cups.te	2004-12-02 13:44:06.204217215 -0500
> @@ -157,6 +157,9 @@
>  allow cupsd_t ptal_var_run_t:dir search;
>  dontaudit ptal_t { sysadm_home_dir_t staff_home_dir_t }:dir { getattr search };
>  
> +allow initrc_t ptal_var_run_t:dir rmdir;
> +allow initrc_t ptal_var_run_t:fifo_file unlink;
> +
>  dontaudit cupsd_t selinux_config_t:dir search;
>  dontaudit cupsd_t selinux_config_t:file { getattr read };
>  
> diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.19.8/file_contexts/distros.fc
> --- nsapolicy/file_contexts/distros.fc	2004-11-20 22:29:09.000000000 -0500
> +++ policy-1.19.8/file_contexts/distros.fc	2004-12-01 16:26:58.000000000 -0500
> @@ -31,6 +31,9 @@
>  /usr/share/pydict/pydict\.py	--	system_u:object_r:bin_t
>  /usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
>  /usr/share/pwlib/make/ptlib-config --	system_u:object_r:bin_t
> +/usr/share/texmf/web2c/mktexdir	--	system_u:object_r:bin_t
> +/usr/share/texmf/web2c/mktexnam	--	system_u:object_r:bin_t
> +/usr/share/texmf/web2c/mktexupd	--	system_u:object_r:bin_t
>  ')
>  
>  ifdef(`distro_suse', `
> diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.19.8/file_contexts/program/apache.fc
> --- nsapolicy/file_contexts/program/apache.fc	2004-11-20 22:29:09.000000000 -0500
> +++ policy-1.19.8/file_contexts/program/apache.fc	2004-11-30 16:49:58.000000000 -0500
> @@ -40,3 +40,6 @@
>  ')
>  /var/lib/squirrelmail/prefs(/.*)?	system_u:object_r:httpd_squirrelmail_t
>  /usr/bin/htsslpass --	system_u:object_r:httpd_helper_exec_t
> +/usr/share/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
> +/var/lib/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
> +/etc/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
> diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ifconfig.fc policy-1.19.8/file_contexts/program/ifconfig.fc
> --- nsapolicy/file_contexts/program/ifconfig.fc	2004-11-19 11:20:43.000000000 -0500
> +++ policy-1.19.8/file_contexts/program/ifconfig.fc	2004-12-01 09:01:45.000000000 -0500
> @@ -7,3 +7,6 @@
>  /bin/ip			--	system_u:object_r:ifconfig_exec_t
>  /sbin/ethtool		--	system_u:object_r:ifconfig_exec_t
>  /sbin/mii-tool		--	system_u:object_r:ifconfig_exec_t
> +/sbin/ipx_interface	--	system_u:object_r:ifconfig_exec_t
> +/sbin/ipx_configure	--	system_u:object_r:ifconfig_exec_t
> +/sbin/ipx_internal_net	--	system_u:object_r:ifconfig_exec_t
> diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.19.8/file_contexts/types.fc
> --- nsapolicy/file_contexts/types.fc	2004-12-02 14:11:43.377594270 -0500
> +++ policy-1.19.8/file_contexts/types.fc	2004-12-02 13:27:20.530471384 -0500
> @@ -139,6 +139,9 @@
>  /u?dev/cu.*		-c	system_u:object_r:tty_device_t
>  /u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
>  /u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
> +/u?dev/hvc.*		-c	system_u:object_r:tty_device_t
> +/u?dev/hvsi.*		-c	system_u:object_r:tty_device_t
> +/u?dev/ttySG.*		-c	system_u:object_r:tty_device_t
>  /u?dev/tty		-c	system_u:object_r:devtty_t
>  /dev/lp.*		-c	system_u:object_r:printer_device_t
>  /dev/par.*		-c	system_u:object_r:printer_device_t
> @@ -334,6 +337,9 @@
>  /usr(/.*)?			system_u:object_r:usr_t
>  /usr(/.*)?/lib(64)?(/.*)?	system_u:object_r:lib_t
>  /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
> +/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
> +/usr(/.*)?/java/.*\.jar	--	system_u:object_r:shlib_t
> +/usr(/.*)?/java/.*\.jsa	--	system_u:object_r:shlib_t
>  /usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
>  /usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
>  /usr(/.*)?/Bin(/.*)?		system_u:object_r:bin_t
> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.8/macros/program/mozilla_macros.te
> --- nsapolicy/macros/program/mozilla_macros.te	2004-12-02 14:11:43.625566345 -0500
> +++ policy-1.19.8/macros/program/mozilla_macros.te	2004-12-02 13:39:30.762236174 -0500
> @@ -98,6 +98,7 @@
>  dontaudit $1_mozilla_t boot_t:dir getattr;
>  ifdef(`cups.te', `
>  allow $1_mozilla_t cupsd_etc_t:dir search;
> +allow $1_mozilla_t cupsd_rw_etc_t:file { getattr read };
>  ')
>  allow $1_mozilla_t $1_t:tcp_socket { read write };
>  
> diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.19.8/tunables/distro.tun
> --- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
> +++ policy-1.19.8/tunables/distro.tun	2004-11-30 16:17:10.000000000 -0500
> @@ -5,7 +5,7 @@
>  # appropriate ifdefs.
>  
> 
> -dnl define(`distro_redhat')
> +define(`distro_redhat')
>  
>  dnl define(`distro_suse')
>  
> diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.8/tunables/tunable.tun
> --- nsapolicy/tunables/tunable.tun	2004-11-09 13:35:13.000000000 -0500
> +++ policy-1.19.8/tunables/tunable.tun	2004-11-30 16:17:10.000000000 -0500
> @@ -2,10 +2,10 @@
>  dnl define(`user_can_mount')
>  
>  # Allow rpm to run unconfined.
> -dnl define(`unlimitedRPM')
> +define(`unlimitedRPM')
>  
>  # Allow privileged utilities like hotplug and insmod to run unconfined.
> -dnl define(`unlimitedUtils')
> +define(`unlimitedUtils')
>  
>  # Allow rc scripts to run unconfined, including any daemon
>  # started by an rc script that does not have a domain transition
> @@ -17,11 +17,11 @@
>  
>  # Do not audit things that we know to be broken but which
>  # are not security risks
> -dnl define(`hide_broken_symptoms')
> +define(`hide_broken_symptoms')
>  
>  # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
>  # Otherwise, only staff_r can do so.
> -dnl define(`user_canbe_sysadm')
> +define(`user_canbe_sysadm')
>  
>  # Allow xinetd to run unconfined, including any services it starts
>  # that do not have a domain transition explicitly defined.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
