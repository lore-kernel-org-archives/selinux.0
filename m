Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAKBkIi023055
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 15:11:46 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAKA8wg021280
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 20:10:08 GMT
Subject: Re: Some more fixes
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <41B87DDD.3060204@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B87DDD.3060204@redhat.com>
Content-Type: text/plain
Message-Id: <1102709645.5654.36.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 15:14:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with some changes.

On Thu, 2004-12-09 at 11:31, Daniel J Walsh wrote:
> Many fixes for initrc required by turning off unlimitedRC
> 
> Fixes for ipsec
> 
> Fixes for ifdefs of targeted policy
> 
> Added new booleans to replace tunables
> 
> allow_user_mysql_connect &  allow_user_postgresql_connect &  pppd_for_user
> 
> Fixed some can_network_* calls.
> 
> Added support for winbindd
> 
> Added a portmap_helper domain for pmap_dump and pmap_set.  Not sure if I 
> like this?  Looking for comments.
> 
> Remove user_can_mount tunable
> 
> 
> 
> ______________________________________________________________________
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.19.12/domains/program/initrc.te
> --- nsapolicy/domains/program/initrc.te	2004-12-09 10:26:08.583499181 -0500
> +++ policy-1.19.12/domains/program/initrc.te	2004-12-09 11:03:11.335553650 -0500
> @@ -217,6 +218,9 @@
>  allow initrc_t tmpfs_t:chr_file rw_file_perms;
>  allow initrc_t tmpfs_t:dir r_dir_perms;
>  
> +# Allow initrc domain to set the enforcing flag.
> +can_setenforce(initrc_t)
> +
>  #
>  # readahead asks for these
>  #

I put an ifdef(`distro_redhat' around this.

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.19.12/domains/program/ldconfig.te
> --- nsapolicy/domains/program/ldconfig.te	2004-12-09 10:26:08.603496932 -0500
> +++ policy-1.19.12/domains/program/ldconfig.te	2004-12-09 11:05:48.845841826 -0500
> @@ -44,3 +44,4 @@
>  ')
>  
>  allow ldconfig_t proc_t:file read;
> +dontaudit ldconfig_t unconfined_t:tcp_socket { read write };

As Thomas Bleher mentioned, I put a ifdef(`unconfined.te' around this.


> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.19.12/domains/program/unused/kudzu.te
> --- nsapolicy/domains/program/unused/kudzu.te	2004-12-09 10:26:09.150435429 -0500
> +++ policy-1.19.12/domains/program/unused/kudzu.te	2004-12-09 11:03:11.362550614 -0500
> @@ -16,6 +16,7 @@
>  
>  allow kudzu_t ramfs_t:dir search;
>  allow kudzu_t ramfs_t:sock_file write;
> +allow kudzu_t etc_t:file { getattr read };
>  allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
>  allow kudzu_t modules_conf_t:file { getattr read };
>  allow kudzu_t modules_object_t:dir r_dir_perms;

As Thomas Bleher mentioned, this rule is redudant.

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.19.12/macros/user_macros.te
> --- nsapolicy/macros/user_macros.te	2004-12-09 10:26:10.334302305 -0500
> +++ policy-1.19.12/macros/user_macros.te	2004-12-09 11:03:11.384548140 -0500
> @@ -134,6 +140,7 @@
>  attribute $1_file_type;
>  # Grant read/search permissions to some of /proc.
>  r_dir_file($1_t, proc_t)
> +r_dir_file($1_t, proc_net_t)
>  
>  base_file_read_access($1_t)
>  
> @@ -215,27 +222,11 @@
>  dontaudit $1_t init_t:fd use;
>  dontaudit $1_t initrc_t:fd use;
>  allow $1_t initrc_t:fifo_file write;
> -ifdef(`user_can_mount', `
> -#
> -#  Allow users to mount file systems like floppies and cdrom
> -#
> -mount_domain($1, $1_mount, `, fs_domain')
> -r_dir_file($1_t, mnt_t)
> -allow $1_mount_t device_t:lnk_file read;
> -allow $1_mount_t removable_device_t:blk_file read;
> -allow $1_mount_t iso9660_t:filesystem relabelfrom;
> -allow $1_mount_t removable_t:filesystem { mount relabelto };
> -allow $1_mount_t removable_t:dir mounton;
> -ifdef(`xdm.te', `
> -allow $1_mount_t xdm_t:fd use;
> -allow $1_mount_t xdm_t:fifo_file { read write };
> -')
> -')
>  
>  #
>  # Rules used to associate a homedir as a mountpoint
>  #
> -allow $1_home_t self:filesystem associate;
> +allow $1_home_t $1_home_t:filesystem associate;
>  allow $1_file_type $1_home_t:filesystem associate;
>  ')
>  

I didn't remove this, since there still seems to be interest in it. 
Perhaps it should be moved to a distro_tunable?

> diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.12/tunables/tunable.tun
> --- nsapolicy/tunables/tunable.tun	2004-11-09 13:35:13.000000000 -0500
> +++ policy-1.19.12/tunables/tunable.tun	2004-12-09 11:17:03.670958633 -0500
> @@ -1,29 +1,31 @@
> -# Allow users to execute the mount command
> -dnl define(`user_can_mount')
> -
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
>  # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
>  # Otherwise, only staff_r can do so.
> -dnl define(`user_canbe_sysadm')
> +define(`user_canbe_sysadm')
>  
>  # Allow xinetd to run unconfined, including any services it starts
>  # that do not have a domain transition explicitly defined.
>  dnl define(`unlimitedInetd')
>  
> +# for ndc_t to be used for restart shell scripts
> +dnl define(`ndc_shell_script')
> +
> +# To allow staff and user to share the same homedirectory file labels
> +dnl define(`single_user_file_type')

I did not remove the user_can_mount tunable.
I did not add the single_user_file_type tunable.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
