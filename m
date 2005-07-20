Message-ID: <42DE679D.2080909@redhat.com>
Date: Wed, 20 Jul 2005 11:02:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <42DD6CBE.7090506@redhat.com> <1121811396.11941.19.camel@localhost.localdomain>
In-Reply-To: <1121811396.11941.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>rogram/initrc.te policy-1.25.3/domains/program/initrc.te
>>--- nsapolicy/domains/program/initrc.te	2005-07-06 17:15:06.000000000 -0400
>>+++ policy-1.25.3/domains/program/initrc.te	2005-07-19 15:41:44.000000000 -0400
>>@@ -123,7 +123,7 @@
>> allow initrc_t file_t:dir { read search getattr mounton };
>> 
>> # during boot up initrc needs to do the following
>>-allow initrc_t default_t:dir { read search getattr mounton };
>>+allow initrc_t default_t:dir { write read search getattr mounton };
>>    
>>
>
>Why does it need to do that?
>
>  
>
Not sure.  Happens in strict policy.

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.25.3/domains/program/unused/hald.te
>>--- nsapolicy/domains/program/unused/hald.te	2005-07-12 08:50:43.000000000 -0400
>>+++ policy-1.25.3/domains/program/unused/hald.te	2005-07-19 15:41:44.000000000 -0400
>>@@ -96,3 +96,7 @@
>> allow unconfined_t hald_t:dbus send_msg;
>> allow hald_t unconfined_t:dbus send_msg;
>> ')
>>+ifdef(`mount.te', `
>>+domain_auto_trans(hald_t, mount_exec_t, mount_t)
>>+')
>>+
>>    
>>
>
>That doesn't allow it to mount whatever it wants?
>
>  
>
It is required to unmount removable_t

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.25.3/domains/program/unused/hotplug.te
>>--- nsapolicy/domains/program/unused/hotplug.te	2005-07-12 08:50:43.000000000 -0400
>>+++ policy-1.25.3/domains/program/unused/hotplug.te	2005-07-19 15:41:44.000000000 -0400
>>@@ -128,7 +128,7 @@
>> # Read /usr/lib/gconv/.*
>> allow hotplug_t lib_t:file { getattr read };
>> 
>>-allow hotplug_t self:capability { net_admin sys_tty_config mknod };
>>+allow hotplug_t self:capability { net_admin sys_tty_config mknod sys_rawio };
>>    
>>
>
>Why do we keep needing that? 
>Isn't this a dangerous capability?
>I thought it was established that only dmidecode needs this.
>  
>
Trying to get prism54 card at boot.

Jul 17 17:46:56 bureau kernel: audit(1121615214.230:2): avc:  denied  { search }
for  pid=1782 comm="cp" name="selinux" dev=dm-0 ino=27656630
scontext=system_u:system_r:hotplug_t tcontext=system_u:object_r:selinux_config_t
tclass=dir
Jul 17 17:46:56 bureau kernel: audit(1121615214.237:3): avc:  denied  {
sys_rawio } for  pid=1782 comm="cp" capability=17
scontext=system_u:system_r:hotplug_t tcontext=system_u:system_r:hotplug_t
tclass=capability
Jul 17 17:46:56 bureau kernel: prism54: request_firmware() failed for 'isl3890'
Jul 17 17:46:56 bureau kernel: eth0: could not upload firmware ('isl3890')
Jul 17 17:46:56 bureau kernel: eth0: islpci_reset: failure
Jul 17 17:46:56 bureau kernel: audit(1121615214.293:4): avc:  denied  {
sys_tty_config } for  pid=1779 comm="ip" capability=26
scontext=system_u:system_r:ifconfig_t tcontext=system_u:system_r:ifconfig_t
tclass=capability



>  
>
>>+can_network_client_tcp(pptp_t)
>>+allow pptp_t { reserved_port_type port_t }:tcp_socket name_connect;
>>    
>>
>
>Why does it need name_connect on a reserved port?
>If it's reserved, shouldn't it have a type declared for it?
>
>  
>
pptp can be setup to forward multiple connections.

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.25.3/domains/program/unused/udev.te
>>--- nsapolicy/domains/program/unused/udev.te	2005-07-06 17:15:07.000000000 -0400
>>+++ policy-1.25.3/domains/program/unused/udev.te	2005-07-19 15:41:44.000000000 -0400
>>@@ -28,11 +28,12 @@
>> type udev_tdb_t, file_type, sysadmfile, dev_fs;
>> typealias udev_tdb_t alias udev_tbl_t;
>> file_type_auto_trans(udev_t, device_t, udev_tdb_t, file)
>>-allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin sys_nice mknod net_raw net_admin };
>>+allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin sys_nice mknod net_raw net_admin sys_rawio };
>>    
>>
>
>Also looks dangerous - rawio.
>
>  
>
>>+allow vpnc_t user_home_dir_t:dir search;
>>+allow vpnc_t user_home_t:dir search;
>>    
>>
>
>?
>  
>
Should remove.

>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.25.3/macros/program/cdrecord_macros.te
>>--- nsapolicy/macros/program/cdrecord_macros.te	2005-05-02 14:06:57.000000000 -0400
>>+++ policy-1.25.3/macros/program/cdrecord_macros.te	2005-07-19 15:43:50.000000000 -0400
>>@@ -47,8 +47,11 @@
>> allow $1_cdrecord_t removable_device_t:blk_file { getattr read write ioctl };
>> allow $1_cdrecord_t scsi_generic_device_t:chr_file { getattr read write ioctl };
>> 
>>-allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid };
>>+allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid dac_override sys_rawio };
>> allow $1_cdrecord_t self:process { getsched setsched fork sigchld sigkill };
>>-
>>+allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
>>+allow $1_cdrecord_t $1_home_t:dir search;
>>+allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
>>+allow $1_cdrecord_t $1_home_t:file r_file_perms;
>> ')
>>    
>>
>
>Same here... why is cdrecord reading the user's private documents.
>
>  
>
Usually if you are creating a cd, it will be from your home dir.

>>+allow $1_thunderbird_t fs_t:filesystem getattr;
>>    
>>
>
>Why does it need to do that?
>  
>
Don't know.  Probably checking filesystems in mtab

>  
>
>> # GNOME support
>> ifdef(`gnome.te', `
>> gnome_application($1_thunderbird, $1)
>> gnome_file_dialog($1_thunderbird, $1)
>>+allow $1_thunderbird_t $1_gnome_settings_t:file { read write };
>>    
>>
>
>That needs to be labeled something other than $1_gnome_settings_t.
>Which file is this? gnome_settings_t is the fallback type,
>we should be moving away from that, and towards specific
>labeling.
>
>  
>
Don't know but needed to work.  You can remove it to see which file.

>> ')
>> 
>> # Access ~/.thunderbird
>>@@ -54,4 +53,7 @@
>> # RSS feeds
>> can_network_client_tcp($1_thunderbird_t, http_port_t) 
>> allow $1_thunderbird_t http_port_t:tcp_socket name_connect;
>>+
>>+allow $1_thunderbird_t self:process { execheap execmem execstack };
>>+
>>    
>>
>
>Execmem is dangerous.
>
>  
>
Maybe but thunderbird does not run without it.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
