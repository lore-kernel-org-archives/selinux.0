Subject: diffs + additions to NSA cvs policy
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-Sxbsx4r/v7VzBqHxRrLe"
Date: Wed, 21 Dec 2005 03:36:19 +0100
Message-Id: <1135132579.5408.33.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Sxbsx4r/v7VzBqHxRrLe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
attached are some diffs to NSA cvs policy (I'm not using refpolicy, and
if you really want to win my for a new policy, make one without M4...)

Reasons / Changes:
- Debian slapd actually is in /usr/lib, not /usr/sbin
  (there is a symlink in /usr/sbin only)
- I don't use NetworkManager, so I'd like it to be ifdef'd
- Some updates to the asterisk policy I was possibly the only user of
  (e.g. to add external audio sources and timer support)
- removal of that really weird "dhcpc_t locale_t:file write"
- debian dpkg needs get_security
- debian ntp has a cronjob to rotate its logs

I also attached some new policy files:
- tor: The onion router (tor.eff.org)
- heartbeat (Version 1, can enable arp_proxy and add/remove IPs)
- nsupdate (from bind, dynamic dns updates via dns protocol)
- munin (successor of LRRD, load graphing)

Btw, I think the tor policy is rather simple, so people might want to
look at it as an example for policy writing.

I still have some changes in my policy not included here, for example I
was lacking this to login as "root" on the console:
  allow sysadm_t getty_t:fd use;
my "strict" dir is a symlink:
  allow checkpolicy_t selinux_config_t:lnk_file read;
and I use iptables-save/iptables-restore, they try to acces /etc/mtab
  allow iptables_t etc_runtime_t:file { getattr read };

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     You know we all became mathematicians for the same reason:      //\
                  we were lazy. --- Max Rosenlicht                   V_/_
  Wer keine Zeit mehr mit echten Freunden verbringt, der wird bald
          sein Gleichgewicht verlieren. --- Michael Levine

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=diff-2005122101.diff
Content-Type: text/x-patch; name=diff-2005122101.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -ur nsa-cvs-policy/domains/program/unused/asterisk.te selinux-policy/domains/program/asterisk.te
--- nsa-cvs-policy/domains/program/unused/asterisk.te	2005-07-05 21:25:46.000000000 +0200
+++ selinux-policy/domains/program/asterisk.te	2005-09-18 03:56:20.000000000 +0200
@@ -21,6 +21,10 @@
 logdir_domain(asterisk)
 var_lib_domain(asterisk)
 
+ifdef(`crond.te', `
+allow asterisk_t crond_t:fifo_file { read };
+')
+
 allow asterisk_t asterisk_port_t:{ udp_socket tcp_socket } name_bind;
 
 # for VOIP voice channels.
@@ -29,6 +33,10 @@
 allow asterisk_t device_t:lnk_file read;
 allow asterisk_t sound_device_t:chr_file rw_file_perms;
 
+# timer source
+type asterisk_device_t, device_type, dev_fs;
+allow asterisk_t asterisk_device_t:chr_file rw_file_perms;
+
 type asterisk_spool_t, file_type, sysadmfile;
 create_dir_file(asterisk_t, asterisk_spool_t)
 allow asterisk_t var_spool_t:dir search;
@@ -52,5 +60,18 @@
 # for shutdown
 dontaudit asterisk_t self:capability sys_tty_config;
 
+# restart
+can_exec(asterisk_t, asterisk_exec_t)
+# helper - for example music player
+allow asterisk_t { bin_t sbin_t }:dir search;
+allow asterisk_t { bin_t sbin_t }:lnk_file read;
+can_exec(asterisk_t, { bin_t lib_t shell_exec_t })
+
+# for /var/run/asterisk
+allow asterisk_t self:capability dac_override;
+
+# error messages
+allow asterisk_t sysadm_devpts_t:chr_file { read write };
+
 tmpfs_domain(asterisk)
 tmp_domain(asterisk)
diff -ur nsa-cvs-policy/domains/program/unused/dhcpc.te selinux-policy/domains/program/dhcpc.te
--- nsa-cvs-policy/domains/program/unused/dhcpc.te	2005-11-25 23:48:04.000000000 +0100
+++ selinux-policy/domains/program/dhcpc.te	2005-11-27 16:28:09.000000000 +0100
@@ -158,12 +158,14 @@
 domain_auto_trans(system_dbusd_t, dhcpc_exec_t, dhcpc_t)
 allow dhcpc_t system_dbusd_t:dbus { acquire_svc send_msg };
 allow dhcpc_t self:dbus send_msg;
+ifdef(`NetworkManager.te', `
 allow { NetworkManager_t initrc_t } dhcpc_t:dbus send_msg;
 allow dhcpc_t { NetworkManager_t initrc_t }:dbus send_msg;
+')dnl end if NetworkManager.te
 ifdef(`unconfined.te', `
 allow unconfined_t dhcpc_t:dbus send_msg;
 allow dhcpc_t unconfined_t:dbus send_msg;
 ')dnl end ifdef unconfined.te
-')
+')dnl end if dbusd.te
 ifdef(`netutils.te', `domain_auto_trans(dhcpc_t, netutils_exec_t, netutils_t)')
-allow dhcpc_t locale_t:file write;
+
diff -ur nsa-cvs-policy/domains/program/unused/dpkg.te selinux-policy/domains/program/dpkg.te
--- nsa-cvs-policy/domains/program/unused/dpkg.te	2005-11-03 12:58:51.000000000 +0100
+++ selinux-policy/domains/program/dpkg.te	2005-12-21 02:42:40.000000000 +0100
@@ -17,6 +17,7 @@
 
 tmp_domain(dpkg)
 can_setfscreate(dpkg_t)
+can_getsecurity(dpkg_t)
 can_exec(dpkg_t, { dpkg_exec_t bin_t shell_exec_t dpkg_tmp_t ls_exec_t dpkg_var_lib_t dpkg_etc_t sbin_t lib_t fsadm_exec_t })
 
 ifdef(`load_policy.te', `
diff -ur nsa-cvs-policy/domains/program/unused/named.te selinux-policy/domains/program/named.te
--- nsa-cvs-policy/domains/program/unused/named.te	2005-11-25 23:48:04.000000000 +0100
+++ selinux-policy/domains/program/named.te	2005-11-27 16:28:09.000000000 +0100
@@ -107,8 +107,10 @@
 domain_auto_trans(system_dbusd_t, named_exec_t, named_t)
 allow named_t system_dbusd_t:dbus { acquire_svc send_msg };
 allow named_t self:dbus send_msg;
+ifdef(`NetworkManager.te', `
 allow { NetworkManager_t dhcpc_t initrc_t } named_t:dbus send_msg;
 allow named_t { NetworkManager_t dhcpc_t initrc_t }:dbus send_msg;
+')
 ifdef(`unconfined.te', `
 allow unconfined_t named_t:dbus send_msg;
 allow named_t unconfined_t:dbus send_msg;
diff -ur nsa-cvs-policy/file_contexts/program/asterisk.fc selinux-policy/file_contexts/program/asterisk.fc
--- nsa-cvs-policy/file_contexts/program/asterisk.fc	2004-08-06 14:23:52.000000000 +0200
+++ selinux-policy/file_contexts/program/asterisk.fc	2005-08-22 18:53:34.000000000 +0200
@@ -5,3 +5,4 @@
 /var/log/asterisk(/.*)?		system_u:object_r:asterisk_log_t
 /var/lib/asterisk(/.*)?		system_u:object_r:asterisk_var_lib_t
 /var/spool/asterisk(/.*)?	system_u:object_r:asterisk_spool_t
+/dev/zap/pseudo		-c	system_u:object_r:asterisk_device_t
diff -ur nsa-cvs-policy/file_contexts/program/slapd.fc selinux-policy/file_contexts/program/slapd.fc
--- nsa-cvs-policy/file_contexts/program/slapd.fc	2005-11-25 23:48:04.000000000 +0100
+++ selinux-policy/file_contexts/program/slapd.fc	2005-12-21 02:56:55.000000000 +0100
@@ -1,11 +1,15 @@
 # slapd - ldap server
 /usr/sbin/slapd		--	system_u:object_r:slapd_exec_t
+ifdef(`distro_debian', `
+/usr/lib/slapd		--	system_u:object_r:slapd_exec_t
+')
 /var/lib/ldap(/.*)?		system_u:object_r:slapd_db_t
 /var/lib/ldap/replog(/.*)?	system_u:object_r:slapd_replog_t
 /var/run/slapd\.args	--	system_u:object_r:slapd_var_run_t
 /etc/ldap/slapd\.conf	--	system_u:object_r:slapd_etc_t
 /var/run/slapd\.pid	--	system_u:object_r:slapd_var_run_t
 /var/run/ldapi		-s	system_u:object_r:slapd_var_run_t
+ifdef(`distro_redhat', `
 /opt/(fedora|redhat)-ds(/.*)?/bin/slapd/server/ns-slapd   --	system_u:object_r:slapd_exec_t
 /opt/(fedora|redhat)-ds/slapd-[^/]+/logs(/.*)? 	system_u:object_r:slapd_var_run_t
 /opt/(fedora|redhat)-ds/slapd-[^/]+/locks(/.*)?	system_u:object_r:slapd_lock_t
@@ -17,3 +21,4 @@
 /opt/(fedora|redhat)-ds/slapd-[^/]+/stop-slapd system_u:object_r:initrc_exec_t
 /opt/(fedora|redhat)-ds/alias(/.*)? system_u:object_r:slapd_cert_t
 /opt/(fedora|redhat)-ds/alias/[^/]+so.* system_u:object_r:shlib_t
+')

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=heartbeat.te
Content-Type: text/plain; name=heartbeat.te; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#DESC HEARTBEAT - high availability failover
#
# Author:  Erich Schubert <erich@debian.org>
# X-Debian-Packages: heartbeat
#

#################################
#
# Rules for the heartbeat_t domain.
#
# heartbeat_exec_t is the type of the heartbeat executable.
#
daemon_domain(heartbeat, `, privlog, sysctl_net_writer')
etcdir_domain(heartbeat)
var_lib_domain(heartbeat)
uses_shlib(heartbeat_t)
# Heartbeat uses Shared Memory
allow heartbeat_t self:shm create_shm_perms;
tmp_domain(heartbeat)

# can execute all kind of stuff...
allow heartbeat_t { bin_t sbin_t }:dir r_dir_perms;
allow heartbeat_t { bin_t sbin_t }:lnk_file r_file_perms;
can_exec(heartbeat_t, { bin_t sbin_t heartbeat_exec_t shell_exec_t })
can_network(heartbeat_t)

# heartbeat needs some information
allow heartbeat_t { etc_t etc_runtime_t }:file r_file_perms;

allow heartbeat_t self:fifo_file rw_file_perms;
allow heartbeat_t heartbeat_var_lib_t:fifo_file create_file_perms;
allow heartbeat_t heartbeat_var_lib_t:sock_file create_file_perms;
allow heartbeat_t heartbeat_var_lib_t:dir { create_file_perms rmdir };

# heartbeat needs to run ifconfig
domain_auto_trans(heartbeat_t, ifconfig_exec_t, ifconfig_t)
# heartbeat can run ndc
ifdef(`named.te',`
domain_auto_trans(heartbeat_t, ndc_exec_t, ndc_t)
can_exec(heartbeat_t, initrc_exec_t)
')
# to switch proxy_arp on/off
rw_dir_file( heartbeat_t, sysctl_net_t);

# initrc needs to read config
r_dir_file(initrc_t, heartbeat_etc_t)

# and unix dgram sockets
allow heartbeat_t self:packet_socket { create_socket_perms };
allow heartbeat_t self:unix_dgram_socket { create_socket_perms listen };
allow heartbeat_t self:unix_stream_socket { create_socket_perms listen connectto accept };

# Heartbeat uses currently unnamed "reserved" ports
allow heartbeat_t reserved_port_t:udp_socket { name_bind create_socket_perms };
# to ping
allow heartbeat_t self:rawip_socket { bind create_socket_perms };
allow heartbeat_t netif_type:netif { rawip_send rawip_recv };
allow heartbeat_t node_type:node { rawip_send rawip_recv };

allow heartbeat_t self:capability { net_raw net_bind_service setgid setuid sys_nice ipc_lock dac_override };
allow heartbeat_t proc_t:file { read getattr };
allow heartbeat_t self:process { getsched setsched setpgid sigchld };

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=munin.te
Content-Type: text/plain; name=munin.te; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#DESC MUNIN - network-wide load graphing
#
# Author:  Erich Schubert <erich@debian.org>
# X-Debian-Packages: munin, munin-node
#

#################################
#
# Rules for the munin_t domain.
#
# munin_exec_t is the type of the munin executable.
#
daemon_domain(munin, `, privmail')

allow munin_t munin_var_run_t:sock_file create_file_perms;

etcdir_domain(munin)
type munin_port_t, port_type;

log_domain(munin)
tmp_domain(munin)
var_lib_domain(munin)

# perl
allow munin_t { sbin_t bin_t }:dir { search getattr };
allow munin_t { bin_t }:lnk_file read;

# for helper apps
can_exec_any(munin_t)
read_locale(munin_t)

# has cron jobs
system_crond_entry(munin_exec_t, munin_t)
allow crond_t munin_var_lib_t:dir search;

# init script
allow initrc_t munin_log_t:file { write append setattr ioctl };

# allow to drop privileges and renice
allow munin_t self:capability { setgid setuid dac_override dac_read_search };
allow munin_t self:process { getsched setsched sigchld };

allow munin_t urandom_device_t:chr_file { getattr read };
allow munin_t usr_t:file { read ioctl };

can_exec(munin_t, munin_exec_t)
can_exec(munin_t, bin_t)
allow munin_t bin_t:dir { search };
allow munin_t usr_t:lnk_file { read };
allow munin_t self:fifo_file rw_file_perms;

# Allow access to the munin databases
create_dir_file(munin_t, munin_var_lib_t)
allow munin_t var_lib_t:dir search;

# write log files
allow munin_t munin_log_t:dir rw_dir_perms;
allow munin_t munin_log_t:file create_file_perms;

# read config files
r_dir_file(initrc_t, munin_etc_t)
allow munin_t { etc_t etc_runtime_t }:{ file lnk_file } { read getattr };
# for accessing the output directory
#ifdef(`apache.te', `
allow munin_t httpd_sys_content_t:dir { search };
#')

allow munin_t etc_t:dir search;

can_unix_connect(sysadm_t, munin_t)
can_unix_connect(munin_t, munin_t)
can_unix_send(munin_t, munin_t)
can_network_server(munin_t)
allow munin_t munin_t:tcp_socket connect;
allow munin_t munin_port_t:tcp_socket { name_connect name_bind };

allow munin_t self:unix_stream_socket { create_socket_perms listen accept ioctl };

ifdef(`logrotate.te', `
r_dir_file(logrotate_t, munin_etc_t)
allow logrotate_t munin_var_lib_t:dir search;
allow logrotate_t munin_var_run_t:dir search;
allow logrotate_t munin_var_run_t:sock_file write;
can_unix_connect(logrotate_t, munin_t)
')

ifdef(`fnord-tcpsvd.te',`
# web server may read output files
allow http_request_t munin_var_lib_t:dir r_dir_perms;
allow http_request_t { munin_var_lib_t munin_etc_t }:file r_file_perms;
')

# get info from /proc
allow munin_t { proc_t proc_net_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:dir r_dir_perms;
allow munin_t { proc_t proc_net_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:file { read getattr };
allow munin_t { proc_t proc_net_t sysctl_t }:file ioctl;

allow munin_t { var_spool_t postfix_spool_t postfix_spool_maildrop_t }:dir r_dir_perms;
allow munin_t { var_spool_t postfix_spool_t postfix_spool_maildrop_t }:file { getattr };

# get info from self (WHY?)
allow munin_t self:file { read ioctl };

# let it check the mail logs
r_dir_file(munin_t, var_log_t)

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=nsupdate.te
Content-Type: text/plain; name=nsupdate.te; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#DESC NSUPDATE - dynamic zone updates for bind
#
# Authors:  Erich Schubert
# X-Debian-Packages: bind bind9
# 

application_domain(nsupdate)

# to access keys stored there
allow nsupdate_t named_zone_t:dir { search };
allow nsupdate_t named_zone_t:file r_file_perms;

can_network(nsupdate_t)
allow nsupdate_t self:netlink_route_socket { create_socket_perms nlmsg_read write };
# allow UDP transfer to/from any program
can_udp_send(named_t, nsupdate_t)
can_udp_send(nsupdate_t, named_t)
can_tcp_connect(nsupdate_t, named_t)

read_locale(nsupdate_t)

# read basic config files
allow nsupdate_t etc_t:file { getattr read };

allow nsupdate_t self:process { fork signal };
allow nsupdate_t self:capability { net_admin };
allow nsupdate_t self:fifo_file rw_file_perms;

# allow a _local_ named to write its zone files
ifdef(`named.te',`
rw_dir_create_file(named_t, named_zone_t)
')

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=heartbeat.fc
Content-Type: text/plain; name=heartbeat.fc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

# heartbeat
/usr/lib/heartbeat/.*		--	system_u:object_r:heartbeat_exec_t
/usr/bin/cl_status		--	system_u:object_r:heartbeat_exec_t
/var/lib/heartbeat(/.*)?		system_u:object_r:heartbeat_var_lib_t
/var/run/heartbeat.*		--	system_u:object_r:heartbeat_var_run_t
/etc/ha.d(/.*)?				system_u:object_r:heartbeat_etc_t
/etc/ha.d/resource.d/.*		--	system_u:object_r:heartbeat_exec_t
/etc/ha.d/rc.d/.*		--	system_u:object_r:heartbeat_exec_t
/etc/ha.d/harc			--	system_u:object_r:heartbeat_exec_t

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=munin.fc
Content-Type: text/plain; name=munin.fc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

# munin
/usr/bin/munin-.*		--	system_u:object_r:munin_exec_t
/usr/sbin/munin-.*		--	system_u:object_r:munin_exec_t
/usr/share/munin/munin-.*	--	system_u:object_r:munin_exec_t
/usr/share/munin/plugins/.*	--	system_u:object_r:munin_exec_t
/var/run/munin(/.*)?			system_u:object_r:munin_var_run_t
/var/log/munin(/.*)?			system_u:object_r:munin_log_t
/var/lib/munin(/.*)?			system_u:object_r:munin_var_lib_t
/var/www/munin(/.*)?			system_u:object_r:munin_var_lib_t
/etc/munin(/.*)?			system_u:object_r:munin_etc_t

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=nsupdate.fc
Content-Type: text/plain; name=nsupdate.fc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/usr/bin/nsupdate      	--	system_u:object_r:nsupdate_exec_t

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=tor.fc
Content-Type: text/plain; name=tor.fc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/var/lib/tor(/.*)?			system_u:object_r:tor_var_lib_t
/var/log/tor(/.*)?			system_u:object_r:tor_log_t
/etc/tor(/.*)?				system_u:object_r:tor_etc_t
/var/run/tor(/.*)?			system_u:object_r:tor_var_run_t
/usr/sbin/tor				system_u:object_r:tor_exec_t

--=-Sxbsx4r/v7VzBqHxRrLe
Content-Disposition: attachment; filename=tor.te
Content-Type: text/plain; name=tor.te; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#DESC tor - the onion router
#
# Authors:  Erich Schubert <erich@debian.org>
#
# X-Debian-Packages: tor
#

# The onion router
daemon_domain(tor)
var_lib_domain(tor)
log_domain(tor)
etc_domain(tor)
can_network(tor_t)

# read config
r_dir_file(tor_t, tor_etc_t)
# write logs
create_dir_file(tor_t, tor_log_t)

# internal communication
allow tor_t self:fifo_file { read write };

# can get random numbers for crypto
allow tor_t urandom_device_t:chr_file { getattr read };

# can bind to regular ports
allow tor_t port_t:tcp_socket name_bind;
# connect to just about any, because some people run tor on 443 etc.
allow tor_t port_type:tcp_socket name_connect;
# network communication
allow tor_t self:unix_stream_socket create_stream_socket_perms;

--=-Sxbsx4r/v7VzBqHxRrLe--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
