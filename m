Message-ID: <41484CFE.3050804@redhat.com>
Date: Wed, 15 Sep 2004 10:09:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: More fixes for nscd in targeted policy
References: <41475DEA.90907@redhat.com> <1095253977.28981.80.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1095253977.28981.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090606010308060907070509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090606010308060907070509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Tue, 2004-09-14 at 17:08, Daniel J Walsh wrote:
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.15/domains/program/unused/named.te
>>--- nsapolicy/domains/program/unused/named.te	2004-09-14 09:18:10.000000000 -0400
>>+++ policy-1.17.15/domains/program/unused/named.te	2004-09-14 16:59:49.090149450 -0400
>>@@ -12,10 +12,10 @@
>> #
>> type rndc_port_t, port_type;
>> 
>>-daemon_domain(named)
>>+daemon_domain(named, `, nscd_shmem_domain')
>> tmp_domain(named)
>>    
>>
Ok changed all th client_domain

>
>nscd_shmem_domain should only be given to domains that you trust to have
>access to the entire cached mapping.  Otherwise, use nscd_client_domain
>to let them use the socket interface.
>
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.15/domains/program/unused/nscd.te
>>--- nsapolicy/domains/program/unused/nscd.te	2004-09-10 16:10:36.000000000 -0400
>>+++ policy-1.17.15/domains/program/unused/nscd.te	2004-09-14 16:59:24.541807946 -0400
>>@@ -24,6 +24,7 @@
>> ifdef(`nscd_all_connect', `
>> can_unix_connect(domain, nscd_t)
>> allow domain nscd_var_run_t:sock_file rw_file_perms;
>>+allow domain nscd_var_run_t:file r_file_perms;
>>    
>>
>
>I don't think you want to allow this for clients that are using the
>socket interface, only those that are using the shmem interface (which
>should be limited to a small set).
>
>  
>
Ok then we need some dontaudit rules added, which I have attached.

>>+#
>>+# Handle winbind for samba, Might only be needed for targeted policy
>>+#
>>+dontaudit nscd_t var_run_t:sock_file rw_file_perms;
>>    
>>
>
>This doesn't make sense; nscd_t has these permissions as a consequence
>of having nscd_client_domain attribute in the policy (since it is used
>for both the client and the daemon).
>  
>
I don't believ nscd_t has access to var_run_t.  It can do this to 
nscd_var_run_t.   It is
trying to communicate with a socket created by winbind.

>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.15/domains/program/unused/ntpd.te
>>--- nsapolicy/domains/program/unused/ntpd.te	2004-09-09 15:36:13.000000000 -0400
>>+++ policy-1.17.15/domains/program/unused/ntpd.te	2004-09-14 17:01:58.987097221 -0400
>>@@ -8,7 +8,7 @@
>> #
>> # Rules for the ntpd_t domain.
>> #
>>-daemon_domain(ntpd)
>>+daemon_domain(ntpd, `, nscd_shmem_domain')
>> type ntp_drift_t, file_type, sysadmfile;
>> type ntp_port_t, port_type;
>>    
>>
>
>nscd_client_domain only, I'd say.
>  
>
done

>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.15/domains/program/unused/portmap.te
>>--- nsapolicy/domains/program/unused/portmap.te	2004-09-09 15:36:13.000000000 -0400
>>+++ policy-1.17.15/domains/program/unused/portmap.te	2004-09-14 16:59:37.482406411 -0400
>>@@ -11,7 +11,7 @@
>> #
>> # Rules for the portmap_t domain.
>> #
>>-daemon_domain(portmap)
>>+daemon_domain(portmap, `, nscd_shmem_domain')
>> 
>> can_network(portmap_t)
>> can_ypbind(portmap_t)
>>    
>>
>
>Ditto.
>
>  
>
done

--------------090606010308060907070509
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.17.16/attrib.te
--- nsapolicy/attrib.te	2004-09-14 09:18:09.000000000 -0400
+++ policy-1.17.16/attrib.te	2004-09-15 09:40:40.000000000 -0400
@@ -205,6 +205,10 @@
 # The device_type attribute identifies all types assigned to device nodes
 attribute device_type;
 
+# The proc_fs attribute identifies all types that may be assigned to
+# files under /proc.
+attribute proc_fs;
+
 # The dev_fs attribute identifies all types that may be assigned to
 # files, sockets, or pipes under /dev.
 attribute dev_fs;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.16/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-09-10 16:10:36.000000000 -0400
+++ policy-1.17.16/domains/program/unused/hald.te	2004-09-15 09:40:40.000000000 -0400
@@ -48,6 +48,7 @@
 ifdef(`udev.te', `
 domain_auto_trans(hald_t, udev_exec_t, udev_t)
 allow udev_t hald_t:unix_dgram_socket sendto;
+allow hald_t udev_tbl_t:file { getattr read };
 ')
 
 allow hald_t usbdevfs_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.16/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.16/domains/program/unused/named.te	2004-09-15 09:40:40.000000000 -0400
@@ -12,10 +12,10 @@
 #
 type rndc_port_t, port_type;
 
-daemon_domain(named)
+daemon_domain(named, `, nscd_client_domain')
 tmp_domain(named)
 
-# for /var/run/ndc used in BIND 8
+# For /var/run/ndc used in BIND 8
 file_type_auto_trans(named_t, var_run_t, named_var_run_t, sock_file)
 
 # ndc_t is the domain for the ndc program
@@ -23,6 +23,11 @@
 role sysadm_r types ndc_t;
 role system_r types ndc_t;
 
+ifdef(`targeted_policy', `
+dontaudit ndc_t root_t:file { getattr read };
+dontaudit ndc_t unlabeled_t:file { getattr read };	
+')
+
 can_exec(named_t, named_exec_t)
 allow named_t sbin_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.16/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-09-10 16:10:36.000000000 -0400
+++ policy-1.17.16/domains/program/unused/nscd.te	2004-09-15 10:05:36.390612619 -0400
@@ -26,23 +26,27 @@
 allow domain nscd_var_run_t:sock_file rw_file_perms;
 allow domain { var_run_t var_t }:dir search;
 allow domain nscd_t:nscd { getpwd getgrp gethost };
+allow domain nscd_t:fd { use };
+dontaudit domain nscd_var_run_t:file { getattr read };
 dontaudit domain nscd_t:nscd { shmempwd shmemgrp shmemhost };
 ', `
 can_unix_connect(nscd_client_domain, nscd_t)
-allow nscd_client_domain var_run_nscd_t:sock_file rw_file_perms;
+allow nscd_client_domain nscd_var_run_t:sock_file rw_file_perms;
 allow nscd_client_domain { var_run_t var_t }:dir search;
 allow nscd_client_domain nscd_t:nscd { getpwd getgrp gethost };
+allow nscd_client_domain nscd_t:fd { use };
+dontaudit nscd_client_domain nscd_var_run_t:file { getattr read };
 dontaudit nscd_client_domain nscd_t:nscd { shmempwd  shmemgrp shmemhost };
 ')dnl nscd_all_connect
 
 # Clients that are allowed to map the database via a fd obtained from nscd.
 can_unix_connect(nscd_shmem_domain, nscd_t)
-allow nscd_shmem_domain var_run_nscd_t:sock_file rw_file_perms;
+allow nscd_shmem_domain nscd_var_run_t:sock_file rw_file_perms;
 allow nscd_shmem_domain { var_run_t var_t }:dir search;
 allow nscd_shmem_domain nscd_t:nscd { shmempwd shmemgrp shmemhost };
 # Receive fd from nscd and map the backing file with read access.
 allow nscd_shmem_domain nscd_t:fd use;
-allow nscd_shmem_domain var_run_nscd_t:file read;
+allow nscd_shmem_domain nscd_var_run_t:file r_file_perms;
 
 # For client program operation, invoked from sysadm_t.
 # Transition occurs to nscd_t due to direct_sysadm_daemon. 
@@ -60,3 +64,10 @@
 allow nscd_t shadow_t:file getattr;
 
 dontaudit nscd_t sysadm_home_dir_t:dir search;
+
+#
+# Handle winbind for samba, Might only be needed for targeted policy
+#
+dontaudit nscd_t var_run_t:sock_file rw_file_perms;
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.16/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.16/domains/program/unused/ntpd.te	2004-09-15 09:40:40.000000000 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the ntpd_t domain.
 #
-daemon_domain(ntpd)
+daemon_domain(ntpd, `, nscd_client_domain')
 type ntp_drift_t, file_type, sysadmfile;
 type ntp_port_t, port_type;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.16/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.16/domains/program/unused/portmap.te	2004-09-15 09:40:40.000000000 -0400
@@ -11,7 +11,7 @@
 #
 # Rules for the portmap_t domain.
 #
-daemon_domain(portmap)
+daemon_domain(portmap, `, nscd_client_domain')
 
 can_network(portmap_t)
 can_ypbind(portmap_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.17.16/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.16/domains/program/unused/squid.te	2004-09-15 09:40:40.000000000 -0400
@@ -13,7 +13,7 @@
 can_tcp_connect(squid_t, httpd_t)
 ')
 
-daemon_domain(squid, `, web_client_domain')
+daemon_domain(squid, `, web_client_domain, nscd_client_domain')
 type squid_conf_t, file_type, sysadmfile;
 
 allow { squid_t initrc_t } squid_conf_t:file r_file_perms;
@@ -66,3 +66,4 @@
 allow squid_t { bin_t sbin_t }:dir search;
 
 dontaudit squid_t { home_root_t security_t devpts_t }:dir getattr;
+dontaudit squid_t tty_device_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.16/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.16/domains/program/unused/udev.te	2004-09-15 09:40:40.000000000 -0400
@@ -16,7 +16,7 @@
 etc_domain(udev)
 typealias udev_etc_t alias etc_udev_t;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
-can_exec(udev_t, udev_helper_exec_t)
+can_exec_any(udev_t)
 
 #
 # Rules used for udev
@@ -42,8 +42,6 @@
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
 allow udev_t bin_t:lnk_file read;
-can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
-can_exec(udev_t, udev_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 
@@ -84,11 +82,9 @@
 ')
 allow udev_t var_log_t:dir { search };
 
-ifdef(`consoletype.te', `
-can_exec(udev_t, consoletype_exec_t)
-')
 ifdef(`pamconsole.te', `
 allow udev_t pam_var_console_t:dir search;
+allow udev_t pam_var_console_t:file { getattr read };
 ')
 allow udev_t var_lock_t:dir search;
 allow udev_t var_lock_t:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.17.16/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-09-10 16:10:36.000000000 -0400
+++ policy-1.17.16/macros/global_macros.te	2004-09-15 09:40:40.000000000 -0400
@@ -217,8 +217,7 @@
 allow $1 proc_mdstat_t:file r_file_perms;
 
 # Stat /proc/kmsg and /proc/kcore.
-allow $1 proc_kmsg_t:file stat_file_perms;
-allow $1 proc_kcore_t:file stat_file_perms;
+allow $1 proc_fs:file stat_file_perms;
 
 # Read system variables in /proc/sys.
 read_sysctl($1)
@@ -552,7 +551,7 @@
 # pseudo filesystem types that are applied to both the filesystem
 # and its files.
 allow $1 { unlabeled_t fs_type }:dir_file_class_set *;
-allow $1 { proc_kmsg_t proc_kcore_t }: file *;
+allow $1 proc_fs: file *;
 
 # For /proc/pid
 r_dir_file($1,domain)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.16/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.16/macros/program/mozilla_macros.te	2004-09-15 09:40:40.000000000 -0400
@@ -71,6 +71,8 @@
 allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
 ')
 
+dontaudit $1_mozilla_t tmp_t:lnk_file read;
+
 #
 # This is another place where I sould like to allow system customization.
 # We need to allow the admin to select whether then want to allow mozilla
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ypbind_macros.te policy-1.17.16/macros/program/ypbind_macros.te
--- nsapolicy/macros/program/ypbind_macros.te	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.16/macros/program/ypbind_macros.te	2004-09-15 09:40:40.000000000 -0400
@@ -10,8 +10,8 @@
 define(`can_ypbind', `
 r_dir_file($1,var_yp_t)
 can_network($1)
+dontaudit $1 reserved_port_t:{ tcp_socket udp_socket } name_bind;
 allow $1 port_t:{ tcp_socket udp_socket } name_bind;
-allow $1 $1:capability { net_bind_service };
 ') dnl can_ypbind
 ') dnl allow_ypbind
 ') dnl ypbind.te
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.16/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.16/tunables/distro.tun	2004-09-15 09:40:40.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.16/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-15 09:15:39.000000000 -0400
+++ policy-1.17.16/tunables/tunable.tun	2004-09-15 09:40:40.000000000 -0400
@@ -1,51 +1,51 @@
 # Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
+define(`nscd_all_connect')
 
 # Allow users to control network interfaces (also needs USERCTL=true)
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
+define(`nfs_export_all_rw')
 
 # Allow the reading on any NFS file system
 dnl define(`nfs_export_all_ro')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/procfs.te policy-1.17.16/types/procfs.te
--- nsapolicy/types/procfs.te	2004-09-10 16:10:37.000000000 -0400
+++ policy-1.17.16/types/procfs.te	2004-09-15 09:40:40.000000000 -0400
@@ -11,11 +11,12 @@
 # proc_t is the type of /proc.
 # proc_kmsg_t is the type of /proc/kmsg.
 # proc_kcore_t is the type of /proc/kcore.
+# proc_mdtat_t is the type of /proc/mdstat.
 #
-type proc_t, fs_type, root_dir_type;
-type proc_kmsg_t;
-type proc_kcore_t;
-type proc_mdstat_t;
+type proc_t, fs_type, proc_fs, root_dir_type;
+type proc_kmsg_t, proc_fs;
+type proc_kcore_t, proc_fs;
+type proc_mdstat_t, proc_fs;
 
 #
 # sysctl_t is the type of /proc/sys.

--------------090606010308060907070509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
