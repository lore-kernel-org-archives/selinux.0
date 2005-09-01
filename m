Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j81K47Ob013852
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2005 16:04:07 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j81K2xa1028860
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2005 20:03:00 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j81K32Ou017592
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2005 16:03:02 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j81K32AD017591
	for selinux@tycho.nsa.gov; Thu, 1 Sep 2005 16:03:02 -0400
Subject: Some policy files
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-QnUZcMD1SIL5xq7dQ5W+"
Date: Thu, 01 Sep 2005 18:31:12 +0200
Message-Id: <1125592273.13489.36.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-QnUZcMD1SIL5xq7dQ5W+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
attached are some policy files for SELinux.
Munin replaced LRRD, which is currently in the selinux "unused" folder.
But I still have one issue with munin - it creates zombies, but no audit
messages... any hints which "allow" rule could be needed to let munin
collect it's children? I already tried adding "sigchld", but that didn't
to the trick.

Heartbeat isn't yet fully tested. It seems to be able to do IP takeover
though.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.       //\
       Es gibt kein idiotensicheres Programm, weil Idioten so       V_/_
                     genial sind. -- E. Murphy

--=-QnUZcMD1SIL5xq7dQ5W+
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
daemon_domain(heartbeat, `, privlog')
etcdir_domain(heartbeat)
var_lib_domain(heartbeat)
uses_shlib(heartbeat_t)
# Heartbeat uses Shared Memory
allow heartbeat_t self:shm create_shm_perms;
tmpfs_domain(heartbeat)

# can execute all kind of stuff...
allow heartbeat_t { bin_t sbin_t }:dir r_dir_perms;
allow heartbeat_t { bin_t sbin_t }:lnk_file r_file_perms;
can_exec(heartbeat_t, { bin_t sbin_t heartbeat_exec_t shell_exec_t })
can_network(heartbeat_t)

# heartbeat needs some information
allow heartbeat_t etc_t:file r_file_perms;

allow heartbeat_t self:fifo_file rw_file_perms;
allow heartbeat_t heartbeat_var_lib_t:fifo_file create_file_perms;
allow heartbeat_t heartbeat_var_lib_t:sock_file create_file_perms;
allow heartbeat_t heartbeat_var_lib_t:dir { create_file_perms rmdir };

# heartbeat needs to run ifconfig
domain_auto_trans(heartbeat_t, ifconfig_exec_t, ifconfig_t)

# initrc needs to read config
r_dir_file(initrc_t, heartbeat_etc_t)

# and unix dgram sockets
allow heartbeat_t self:packet_socket { create_socket_perms };
allow heartbeat_t self:unix_dgram_socket { create_socket_perms listen };
allow heartbeat_t self:unix_stream_socket { create_socket_perms listen connectto accept };

# Heartbeat uses currently unnamed "reserved" ports
allow heartbeat_t reserved_port_t:udp_socket { name_bind create_socket_perms };
# to ping
allow heartbeat_t self:rawip_socket { create ioctl read write bind getopt setopt };
allow heartbeat_t netif_type:netif { rawip_send rawip_recv };
allow heartbeat_t node_type:node { rawip_send rawip_recv };

allow heartbeat_t self:capability { net_raw net_bind_service setgid setuid sys_nice ipc_lock dac_override };
allow heartbeat_t proc_t:file read;
allow heartbeat_t self:process { getsched setsched setpgid sigchld };

--=-QnUZcMD1SIL5xq7dQ5W+
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
allow munin_t self:process { getsched setsched };

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

--=-QnUZcMD1SIL5xq7dQ5W+
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

--=-QnUZcMD1SIL5xq7dQ5W+
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

--=-QnUZcMD1SIL5xq7dQ5W+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
