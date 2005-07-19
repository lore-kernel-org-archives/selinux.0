Subject: Re: Latest diffs
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42DD6CBE.7090506@redhat.com>
References: <42DD6CBE.7090506@redhat.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 18:16:36 -0400
Message-Id: <1121811396.11941.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> rogram/initrc.te policy-1.25.3/domains/program/initrc.te
> --- nsapolicy/domains/program/initrc.te	2005-07-06 17:15:06.000000000 -0400
> +++ policy-1.25.3/domains/program/initrc.te	2005-07-19 15:41:44.000000000 -0400
> @@ -123,7 +123,7 @@
>  allow initrc_t file_t:dir { read search getattr mounton };
>  
>  # during boot up initrc needs to do the following
> -allow initrc_t default_t:dir { read search getattr mounton };
> +allow initrc_t default_t:dir { write read search getattr mounton };

Why does it need to do that?

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.25.3/domains/program/unused/hald.te
> --- nsapolicy/domains/program/unused/hald.te	2005-07-12 08:50:43.000000000 -0400
> +++ policy-1.25.3/domains/program/unused/hald.te	2005-07-19 15:41:44.000000000 -0400
> @@ -96,3 +96,7 @@
>  allow unconfined_t hald_t:dbus send_msg;
>  allow hald_t unconfined_t:dbus send_msg;
>  ')
> +ifdef(`mount.te', `
> +domain_auto_trans(hald_t, mount_exec_t, mount_t)
> +')
> +

That doesn't allow it to mount whatever it wants?

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.25.3/domains/program/unused/hotplug.te
> --- nsapolicy/domains/program/unused/hotplug.te	2005-07-12 08:50:43.000000000 -0400
> +++ policy-1.25.3/domains/program/unused/hotplug.te	2005-07-19 15:41:44.000000000 -0400
> @@ -128,7 +128,7 @@
>  # Read /usr/lib/gconv/.*
>  allow hotplug_t lib_t:file { getattr read };
>  
> -allow hotplug_t self:capability { net_admin sys_tty_config mknod };
> +allow hotplug_t self:capability { net_admin sys_tty_config mknod sys_rawio };

Why do we keep needing that? 
Isn't this a dangerous capability?
I thought it was established that only dmidecode needs this.

> +can_network_client_tcp(pptp_t)
> +allow pptp_t { reserved_port_type port_t }:tcp_socket name_connect;

Why does it need name_connect on a reserved port?
If it's reserved, shouldn't it have a type declared for it?

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.25.3/domains/program/unused/udev.te
> --- nsapolicy/domains/program/unused/udev.te	2005-07-06 17:15:07.000000000 -0400
> +++ policy-1.25.3/domains/program/unused/udev.te	2005-07-19 15:41:44.000000000 -0400
> @@ -28,11 +28,12 @@
>  type udev_tdb_t, file_type, sysadmfile, dev_fs;
>  typealias udev_tdb_t alias udev_tbl_t;
>  file_type_auto_trans(udev_t, device_t, udev_tdb_t, file)
> -allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin sys_nice mknod net_raw net_admin };
> +allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin sys_nice mknod net_raw net_admin sys_rawio };

Also looks dangerous - rawio.

> +allow vpnc_t user_home_dir_t:dir search;
> +allow vpnc_t user_home_t:dir search;

?

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.25.3/macros/program/cdrecord_macros.te
> --- nsapolicy/macros/program/cdrecord_macros.te	2005-05-02 14:06:57.000000000 -0400
> +++ policy-1.25.3/macros/program/cdrecord_macros.te	2005-07-19 15:43:50.000000000 -0400
> @@ -47,8 +47,11 @@
>  allow $1_cdrecord_t removable_device_t:blk_file { getattr read write ioctl };
>  allow $1_cdrecord_t scsi_generic_device_t:chr_file { getattr read write ioctl };
>  
> -allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid };
> +allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid dac_override sys_rawio };
>  allow $1_cdrecord_t self:process { getsched setsched fork sigchld sigkill };
> -
> +allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
> +allow $1_cdrecord_t $1_home_t:dir search;
> +allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
> +allow $1_cdrecord_t $1_home_t:file r_file_perms;
>  ')

Same here... why is cdrecord reading the user's private documents.

> +allow $1_thunderbird_t fs_t:filesystem getattr;

Why does it need to do that?

>  # GNOME support
>  ifdef(`gnome.te', `
>  gnome_application($1_thunderbird, $1)
>  gnome_file_dialog($1_thunderbird, $1)
> +allow $1_thunderbird_t $1_gnome_settings_t:file { read write };

That needs to be labeled something other than $1_gnome_settings_t.
Which file is this? gnome_settings_t is the fallback type,
we should be moving away from that, and towards specific
labeling.

>  ')
>  
>  # Access ~/.thunderbird
> @@ -54,4 +53,7 @@
>  # RSS feeds
>  can_network_client_tcp($1_thunderbird_t, http_port_t) 
>  allow $1_thunderbird_t http_port_t:tcp_socket name_connect;
> +
> +allow $1_thunderbird_t self:process { execheap execmem execstack };
> +

Execmem is dangerous.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
