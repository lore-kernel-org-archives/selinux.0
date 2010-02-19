Message-ID: <4B7F0114.9000300@gmail.com>
Date: Fri, 19 Feb 2010 13:22:28 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>	 <4B7C47DB.40602@gmail.com>	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>	 <4B7DB3B4.2070409@gmail.com> <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil> <4B7EDC9A.40801@gmail.com> <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/19/2010 01:08 PM, Alan Rouse wrote:
> Ok, in case this might be useful to someone else, here's my recipe for an OpenSuse 11.2 system booting to the desktop using SELinux in permissive mode.  (Next step for me is to fix a few pages of AVC denied messages...)
>
> 1.  Default install of OpenSuse 11.2 (used Gnome desktop)
> 2.  Boot normally to desktop, open terminal, su -
> 3.  Do this:
>
> zypper install selinux-tools selinux-policy libselinux* libsemanage* policycoreutils checkpolicy   setools-console make m4 gcc findutils-locate git
>
> vi /boot/grub/menu.lst
>   -- and add to the Desktop kernel boot line: "security=selinux selinux=1 enforcing=0"
>
> cd /etc/selinux
> cp -R refpolicy-standard targeted
> usermod -s /sbin/nologin nobody
> reboot<should boot to desktop>
> ===============
> Get policy src:
> ===============
> -- launch firefox, go to http://software.opensuse.org/search/
> -- search for selinux-policy, download src
> -- install src rpm
> cp /usr/src/packages/SOURCES/refpolicy-2.20081210.tar.bz2 /tmp
> cd /tmp
> bunzip2 refpolicy-2.20081210.tar.bz2
> tar xvf refpolicy-2.20081210.tar
> cd refpolicy
> vi build.conf   (set NAME = refpolicy-standard; set DISTRO = suse; set MONOLITHIC = n)
> make clean; make conf; make; make install; make load; make install-src
> cd /etc/selinux/refpolicy-standard/src/policy
> make clean; make conf; make; make install; make load
> cd /etc/selinux
> rsync -avz refpolicy-standard/ targeted
> reboot
> =============================
> End of getting policy source:
> =============================
> setsebool -P init_upstart=on
> setsebool -P xdm_sysadm_login=on
> setsebool -P xserver_object_manager=on
> fixfiles relabel
> -- put SETLOCALDEFS=0 in /etc/selinux/config
> reboot
>
> And we're now in the desktop with a relabeled system and selinux in permissive mode.
> ================================================================================
>
> Here's what "audit2allow -al" shows now...
>
> #============= avahi_t ==============
> allow avahi_t tmpfs_t:dir search;
> allow avahi_t tmpfs_t:sock_file write;
> allow avahi_t xdm_t:dbus send_msg;
>
> #============= crond_t ==============
> allow crond_t tmpfs_t:dir search;
> allow crond_t tmpfs_t:sock_file write;
>
> #============= cupsd_t ==============
> allow cupsd_t self:process { execstack execmem };
> allow cupsd_t tmpfs_t:dir search;
>
> #============= dhcpc_t ==============
> allow dhcpc_t nmbd_exec_t:file { read getattr execute };
> allow dhcpc_t samba_etc_t:dir search;
> allow dhcpc_t samba_etc_t:file { read write getattr open append };
> allow dhcpc_t tmpfs_t:dir search;
> allow dhcpc_t tmpfs_t:sock_file write;
> allow dhcpc_t var_t:dir { write remove_name add_name };
> allow dhcpc_t var_t:file { write ioctl read create unlink open getattr };
>
> #============= fsdaemon_t ==============
> allow fsdaemon_t tmpfs_t:dir { read search open };
> allow fsdaemon_t tmpfs_t:sock_file write;
> allow fsdaemon_t usr_t:file { read getattr open };
>
> #============= getty_t ==============
> allow getty_t anon_inodefs_t:file getattr;
> allow getty_t apmd_log_t:file getattr;
> allow getty_t audisp_t:dir { read search open };
> allow getty_t audisp_t:file { read getattr open };
> allow getty_t audisp_t:lnk_file read;
> allow getty_t audisp_t:unix_dgram_socket getattr;
> allow getty_t audisp_t:unix_stream_socket getattr;
> allow getty_t auditd_log_t:file getattr;
> allow getty_t auditd_t:dir { read search open };
> allow getty_t auditd_t:fifo_file getattr;
> allow getty_t auditd_t:file { read getattr open };
> allow getty_t auditd_t:lnk_file read;
> allow getty_t auditd_t:netlink_audit_socket getattr;
> allow getty_t auditd_t:unix_dgram_socket getattr;
> allow getty_t auditd_t:unix_stream_socket getattr;
> allow getty_t avahi_t:dir { read search open };
> allow getty_t avahi_t:fifo_file getattr;
> allow getty_t avahi_t:file { read getattr open };
> allow getty_t avahi_t:lnk_file read;
> allow getty_t avahi_t:netlink_route_socket getattr;
> allow getty_t avahi_t:udp_socket getattr;
> allow getty_t avahi_t:unix_dgram_socket getattr;
> allow getty_t avahi_t:unix_stream_socket getattr;
> allow getty_t bin_t:file getattr;
> allow getty_t crond_t:dir { read search open };
> allow getty_t crond_t:file { read getattr open };
> allow getty_t crond_t:lnk_file read;
> allow getty_t crond_t:unix_dgram_socket getattr;
> allow getty_t crond_var_run_t:file getattr;
> allow getty_t cupsd_log_t:file getattr;
> allow getty_t cupsd_t:dir { read search open };
> allow getty_t cupsd_t:fifo_file getattr;
> allow getty_t cupsd_t:file { read getattr open };
> allow getty_t cupsd_t:lnk_file read;
> allow getty_t cupsd_t:tcp_socket getattr;
> allow getty_t cupsd_t:udp_socket getattr;
> allow getty_t cupsd_t:unix_stream_socket getattr;
> allow getty_t debugfs_t:file getattr;
> allow getty_t device_t:chr_file getattr;
> allow getty_t dhcpc_t:dir { read search open };
> allow getty_t dhcpc_t:fifo_file getattr;
> allow getty_t dhcpc_t:file { read getattr open };
> allow getty_t dhcpc_t:lnk_file read;
> allow getty_t dhcpc_t:unix_dgram_socket getattr;
> allow getty_t dhcpc_var_run_t:file getattr;
> allow getty_t event_device_t:chr_file getattr;
> allow getty_t file_t:file getattr;
> allow getty_t fuse_device_t:chr_file getattr;
> allow getty_t hald_t:dir { read search open };
> allow getty_t hald_t:fifo_file getattr;
> allow getty_t hald_t:file { read getattr open };
> allow getty_t hald_t:lnk_file read;
> allow getty_t hald_t:unix_dgram_socket getattr;
> allow getty_t hald_t:unix_stream_socket getattr;
> allow getty_t initrc_t:dir { read search open getattr };
> allow getty_t initrc_t:file { read getattr open };
> allow getty_t initrc_t:lnk_file read;
> allow getty_t initrc_t:unix_dgram_socket getattr;
> allow getty_t initrc_t:unix_stream_socket getattr;
> allow getty_t innd_log_t:file getattr;
> allow getty_t inotifyfs_t:dir getattr;
> allow getty_t kernel_t:dir { read search open };
> allow getty_t kernel_t:file { read getattr open };
> allow getty_t mtrr_device_t:file getattr;
> allow getty_t nscd_log_t:file getattr;
> allow getty_t nscd_t:dir { read search open };
> allow getty_t nscd_t:file { read getattr open };
> allow getty_t nscd_t:lnk_file read;
> allow getty_t nscd_t:unix_stream_socket getattr;
> allow getty_t postfix_data_t:file getattr;
> allow getty_t postfix_etc_t:file getattr;
> allow getty_t postfix_master_t:dir { read search open };
> allow getty_t postfix_master_t:fifo_file getattr;
> allow getty_t postfix_master_t:file { read getattr open };
> allow getty_t postfix_master_t:lnk_file read;
> allow getty_t postfix_master_t:tcp_socket getattr;
> allow getty_t postfix_master_t:unix_dgram_socket getattr;
> allow getty_t postfix_master_t:unix_stream_socket getattr;
> allow getty_t postfix_pickup_t:dir { read search open };
> allow getty_t postfix_pickup_t:file { read getattr open };
> allow getty_t postfix_pickup_t:lnk_file read;
> allow getty_t postfix_pickup_t:unix_dgram_socket getattr;
> allow getty_t postfix_public_t:fifo_file getattr;
> allow getty_t postfix_qmgr_t:dir { read search open };
> allow getty_t postfix_qmgr_t:file { read getattr open };
> allow getty_t postfix_qmgr_t:lnk_file read;
> allow getty_t postfix_qmgr_t:unix_dgram_socket getattr;
> allow getty_t postfix_var_run_t:file getattr;
> allow getty_t proc_kmsg_t:file getattr;
> allow getty_t proc_mdstat_t:file getattr;
> allow getty_t proc_t:file getattr;
> allow getty_t ptmx_t:chr_file getattr;
> allow getty_t rpcbind_t:dir { read search open };
> allow getty_t rpcbind_t:file { read getattr open };
> allow getty_t rpcbind_t:lnk_file read;
> allow getty_t rpcbind_t:tcp_socket getattr;
> allow getty_t rpcbind_t:udp_socket getattr;
> allow getty_t rpcbind_t:unix_stream_socket getattr;
> allow getty_t rpcbind_var_run_t:file getattr;
> allow getty_t self:capability sys_ptrace;
> allow getty_t sendmail_log_t:file getattr;
> allow getty_t syslogd_t:dir { read search open };
> allow getty_t syslogd_t:file { read getattr open };
> allow getty_t syslogd_t:lnk_file read;
> allow getty_t syslogd_t:unix_dgram_socket getattr;
> allow getty_t system_dbusd_t:dir { read search open getattr };
> allow getty_t system_dbusd_t:fifo_file getattr;
> allow getty_t system_dbusd_t:file { read getattr open };
> allow getty_t system_dbusd_t:lnk_file read;
> allow getty_t system_dbusd_t:netlink_kobject_uevent_socket getattr;
> allow getty_t system_dbusd_t:netlink_selinux_socket getattr;
> allow getty_t system_dbusd_t:unix_dgram_socket getattr;
> allow getty_t system_dbusd_t:unix_stream_socket getattr;
> allow getty_t tmpfs_t:dir search;
> allow getty_t tmpfs_t:fifo_file getattr;
> allow getty_t tmpfs_t:file getattr;
> allow getty_t udev_t:dir { read search open };
> allow getty_t udev_t:file { read getattr open };
> allow getty_t udev_t:lnk_file read;
> allow getty_t udev_t:netlink_kobject_uevent_socket getattr;
> allow getty_t udev_t:unix_dgram_socket getattr;
> allow getty_t urandom_device_t:chr_file getattr;
> allow getty_t user_home_t:file getattr;
> allow getty_t usr_t:file getattr;
> allow getty_t var_lib_t:dir getattr;
> allow getty_t var_lib_t:file getattr;
> allow getty_t var_log_t:file getattr;
> allow getty_t xauth_home_t:file getattr;
> allow getty_t xdm_t:dir { read search open getattr };
> allow getty_t xdm_t:file { read getattr open };
> allow getty_t xdm_t:lnk_file read;
> allow getty_t xdm_t:netlink_kobject_uevent_socket getattr;
> allow getty_t xdm_t:netlink_selinux_socket getattr;
> allow getty_t xdm_t:unix_dgram_socket getattr;
> allow getty_t xdm_t:unix_stream_socket getattr;
> allow getty_t xdm_tmp_t:file getattr;
> allow getty_t xdm_var_run_t:file getattr;
> allow getty_t xserver_log_t:file getattr;
> allow getty_t xserver_t:dir { read search open getattr };
> allow getty_t xserver_t:file { read getattr open };
> allow getty_t xserver_t:lnk_file read;
> allow getty_t xserver_t:unix_stream_socket getattr;
>
> #============= hald_t ==============
> allow hald_t xdm_t:dbus send_msg;
>
> #============= initrc_t ==============
> allow initrc_t self:process { execstack execmem };
>
> #============= insmod_t ==============
> allow insmod_t initrc_tmp_t:file write;
>
> #============= kernel_t ==============
> allow kernel_t self:process { execstack execmem };
>
> #============= loadkeys_t ==============
> allow loadkeys_t tmpfs_t:dir search;
> allow loadkeys_t usr_t:file { read getattr open ioctl };
> allow loadkeys_t usr_t:lnk_file read;
>
> #============= nscd_t ==============
> allow nscd_t bin_t:dir search;
> allow nscd_t nscd_exec_t:file execute_no_trans;
> allow nscd_t self:fifo_file write;
> allow nscd_t tmpfs_t:dir search;
>
> #============= postfix_master_t ==============
> allow postfix_master_t tmpfs_t:dir search;
> allow postfix_master_t tmpfs_t:sock_file write;
>
> #============= postfix_pickup_t ==============
> allow postfix_pickup_t tmpfs_t:dir search;
> allow postfix_pickup_t tmpfs_t:sock_file write;
>
> #============= postfix_postqueue_t ==============
> allow postfix_postqueue_t tmpfs_t:dir search;
> allow postfix_postqueue_t tmpfs_t:sock_file write;
>
> #============= postfix_qmgr_t ==============
> allow postfix_qmgr_t tmpfs_t:dir search;
> allow postfix_qmgr_t tmpfs_t:sock_file write;
>
> #============= rpcbind_t ==============
> allow rpcbind_t tmpfs_t:dir search;
>
> #============= syslogd_t ==============
> allow syslogd_t apmd_log_t:file { ioctl open append };
> allow syslogd_t sendmail_log_t:file append;
> allow syslogd_t tmpfs_t:dir search;
> allow syslogd_t tmpfs_t:fifo_file { write read ioctl open };
>
> #============= system_dbusd_t ==============
> allow system_dbusd_t anon_inodefs_t:file { read write };
> allow system_dbusd_t avahi_t:dir search;
> allow system_dbusd_t avahi_t:file { read open };
> allow system_dbusd_t debugfs_t:dir { read search open getattr };
> allow system_dbusd_t debugfs_t:file getattr;
> allow system_dbusd_t etc_runtime_t:file { read write getattr open append };
> allow system_dbusd_t etc_t:dir { write remove_name add_name };
> allow system_dbusd_t etc_t:file { write create unlink link };
> allow system_dbusd_t file_t:dir rmdir;
> allow system_dbusd_t fixed_disk_device_t:blk_file getattr;
> allow system_dbusd_t fusefs_t:dir { read getattr open search };
> allow system_dbusd_t fusefs_t:file getattr;
> allow system_dbusd_t gpg_exec_t:file { read execute open execute_no_trans };
> allow system_dbusd_t hald_t:dbus send_msg;
> allow system_dbusd_t hald_t:dir search;
> allow system_dbusd_t hald_t:file { read open };
> allow system_dbusd_t initrc_t:dir search;
> allow system_dbusd_t initrc_t:file { read open };
> allow system_dbusd_t inotifyfs_t:dir { read getattr ioctl };
> allow system_dbusd_t iso9660_t:filesystem mount;
> allow system_dbusd_t lib_t:file execute_no_trans;
> allow system_dbusd_t mnt_t:dir { write search remove_name create add_name mounton };
> allow system_dbusd_t mount_exec_t:file { read execute open execute_no_trans };
> allow system_dbusd_t proc_mdstat_t:file { read getattr open };
> allow system_dbusd_t proc_net_t:file { read getattr open };
> allow system_dbusd_t removable_device_t:blk_file { read getattr open setattr };
> allow system_dbusd_t rpm_var_lib_t:dir { write search getattr };
> allow system_dbusd_t rpm_var_lib_t:file { read lock getattr open };
> allow system_dbusd_t self:capability { sys_nice sys_ptrace ipc_lock sys_chroot };
> allow system_dbusd_t self:netlink_kobject_uevent_socket { bind create setopt getattr };
> allow system_dbusd_t self:process { execmem getcap getsched execstack setsched setrlimit };
> allow system_dbusd_t shell_exec_t:file { read execute open };
> allow system_dbusd_t system_dbusd_var_run_t:dir { create rmdir };
> allow system_dbusd_t tmpfs_t:dir { search getattr };
> allow system_dbusd_t tmpfs_t:sock_file write;
> allow system_dbusd_t tty_device_t:chr_file getattr;
> allow system_dbusd_t var_lib_t:dir { write remove_name add_name };
> allow system_dbusd_t var_lib_t:file { rename read lock create write getattr unlink open };
> allow system_dbusd_t var_log_t:dir { search getattr };
> allow system_dbusd_t var_log_t:file { read getattr open append setattr };
> allow system_dbusd_t var_t:file { read getattr open };
> allow system_dbusd_t xdm_t:dbus send_msg;
> allow system_dbusd_t xdm_t:dir { getattr search };
> allow system_dbusd_t xdm_t:file { read getattr open };
> allow system_dbusd_t xdm_t:process getsched;
> allow system_dbusd_t xdm_var_run_t:dir search;
> allow system_dbusd_t xdm_var_run_t:file { read getattr open };
> allow system_dbusd_t xserver_t:dir search;
> allow system_dbusd_t xserver_t:file { read getattr open };
> allow system_dbusd_t xserver_t:unix_stream_socket connectto;
>
> #============= udev_t ==============
> allow udev_t anon_inodefs_t:file read;
> allow udev_t tmpfs_t:dir { write search getattr add_name };
> allow udev_t tmpfs_t:file { rename write getattr read create unlink open };
>
> #============= unlabeled_t ==============
> allow unlabeled_t self:filesystem associate;
>
> #============= xdm_t ==============
> allow xdm_t avahi_t:dbus send_msg;
> allow xdm_t hald_t:dbus send_msg;
> allow xdm_t self:process execstack;
>


what's id -Z?

I posted the contents of /etc/pam.d/*
which should get your login context correct.

mine is name:user_r:user_t

fedora(I think)is staff_t:unconfined_r:unconfined_t
(or something like that).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
