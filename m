Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iALBIPIi000211
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 06:18:25 -0500 (EST)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iALBIQq6018099
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 11:18:27 GMT
Message-ID: <41A07D3C.4070300@gentoo.org>
Date: Sun, 21 Nov 2004 13:34:20 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: gentoo policies for daemontools, ucspi-tcp, publicfile, djbdns, clockspeed
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2395D64DADBA51440534CB41"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2395D64DADBA51440534CB41
Content-Type: multipart/mixed;
 boundary="------------030101050400010807090708"

This is a multi-part message in MIME format.
--------------030101050400010807090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

This is a collection of policies that I've been using and maintaining for more than an year now.

[1] http://cr.yp.to/daemontools.html
[2] http://cr.yp.to/ucspi-tcp.html
[3] http://cr.yp.to/publicfile.html
[4] http://cr.yp.to/djbdns.html
[5] http://cr.yp.to/clockspeed.html

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------030101050400010807090708
Content-Type: text/plain;
 name="clockspeed.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clockspeed.fc"

/usr/bin/clockspeed	--	system_u:object_r:clockspeed_exec_t
/usr/bin/clockadd	--	system_u:object_r:clockspeed_exec_t
/usr/bin/clockview	--	system_u:object_r:clockspeed_exec_t
/usr/bin/sntpclock	--	system_u:object_r:clockspeed_exec_t
/usr/bin/taiclock	--	system_u:object_r:clockspeed_exec_t
/usr/bin/taiclockd	--	system_u:object_r:clockspeed_exec_t
/usr/sbin/ntpclockset	--	system_u:object_r:clockspeed_exec_t

/var/lib/clockspeed(/.*)?	system_u:object_r:clockspeed_var_lib_t


--------------030101050400010807090708
Content-Type: text/plain;
 name="clockspeed.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clockspeed.te"

#DESC clockspeed - Simple network time protocol client
#
# Author Petre Rodan <kaiowas@gentoo.org>
#

type clockspeed_port_t, port_type;

daemon_base_domain(clockspeed)
var_lib_domain(clockspeed)
can_network(clockspeed_t)
read_locale(clockspeed_t)

allow clockspeed_t self:capability { sys_time net_bind_service };
allow clockspeed_t self:unix_dgram_socket create_socket_perms;
allow clockspeed_t self:unix_stream_socket create_socket_perms;
allow clockspeed_t clockspeed_port_t:udp_socket name_bind;
allow clockspeed_t domain:packet_socket recvfrom;

allow clockspeed_t var_t:dir search;
allow clockspeed_t clockspeed_var_lib_t:file create_file_perms;
allow clockspeed_t clockspeed_var_lib_t:fifo_file create_file_perms;

# sysadm can play with clockspeed
role sysadm_r types clockspeed_t;
domain_auto_trans( sysadm_t, clockspeed_exec_t, clockspeed_t)


--------------030101050400010807090708
Content-Type: text/plain;
 name="daemontools.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="daemontools.fc"


/var/service/.*			system_u:object_r:svc_svc_t

# symlinks to /var/service/*
/service(/.*)?			system_u:object_r:svc_svc_t

# supervise scripts
/usr/bin/svc-add	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-isdown	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-isup	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-remove	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-start	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-status	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-stop	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-waitdown	--	system_u:object_r:svc_script_exec_t
/usr/bin/svc-waitup	--	system_u:object_r:svc_script_exec_t

# supervise init binaries
# these programs read/write to /service/*/supervise/* and /service/*/log/supervise/*
/usr/bin/svc		--	system_u:object_r:svc_start_exec_t
/usr/bin/svscan		--	system_u:object_r:svc_start_exec_t
/usr/bin/svscanboot	--	system_u:object_r:svc_start_exec_t
/usr/bin/svok		--	system_u:object_r:svc_start_exec_t
#/usr/bin/svstat		--	system_u:object_r:svc_start_exec_t
/usr/bin/supervise	--	system_u:object_r:svc_start_exec_t

# starting scripts
/var/service/.*/run.*		system_u:object_r:svc_run_exec_t
/var/service/.*/log/run		system_u:object_r:svc_run_exec_t

# configurations
/var/service/.*/env(/.*)?   system_u:object_r:svc_conf_t

# log
/var/service/.*/log/main(/.*)?  system_u:object_r:svc_log_t

# programs that impose a given environment to daemons
/usr/bin/softlimit	--	system_u:object_r:svc_run_exec_t
/usr/bin/setuidgid	--	system_u:object_r:svc_run_exec_t
/usr/bin/envuidgid	--	system_u:object_r:svc_run_exec_t
/usr/bin/envdir		--	system_u:object_r:svc_run_exec_t
/usr/bin/setlock	--	system_u:object_r:svc_run_exec_t

# helper programs
/usr/bin/fghack		--	system_u:object_r:svc_run_exec_t
/usr/bin/pgrphack	--	system_u:object_r:svc_run_exec_t

/var/run/svscan\.pid	--	system_u:object_r:initrc_var_run_t
# daemontools logger # writes to service/*/log/main/ and /var/log/*/
/usr/bin/multilog	--	system_u:object_r:svc_multilog_exec_t

/sbin/svcinit       --  system_u:object_r:initrc_exec_t
/sbin/runsvcscript\.sh	--	system_u:object_r:initrc_exec_t


--------------030101050400010807090708
Content-Type: text/plain;
 name="daemontools.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="daemontools.te"

#DESC Daemontools - Tools for managing UNIX services
#
# Author:  Petre Rodan <kaiowas@gentoo.org>
# with the help of Chris PeBenito, Russell Coker and Tad Glines
# 

#
# selinux policy for daemontools
# http://cr.yp.to/daemontools.html
#
# thanks for D. J. Bernstein and the NSA team for the great software
# they provide
#

##############################################################
# type definitions

type svc_conf_t, file_type, sysadmfile;
type svc_log_t, file_type, sysadmfile;
type svc_svc_t, file_type, sysadmfile;


##############################################################
# the domains

define(`svc_sub_domain', `
daemon_sub_domain(svc_t, svc_$1)
')

define(`svc_filedir_domain', `
create_dir_file($1, svc_svc_t)
file_type_auto_trans($1, svc_svc_t, svc_svc_t);
')

define(`svc_confdir_domain', `
r_dir_file($1, svc_conf_t)
')

daemon_base_domain(svc_script)
svc_filedir_domain(svc_script_t)

# part started by initrc_t
daemon_base_domain(svc_start)
svc_filedir_domain(svc_start_t)

# also get here from svc_script_t
domain_auto_trans(svc_script_t, svc_start_exec_t, svc_start_t)

# the domain for /service/*/run and /service/*/log/run
daemon_sub_domain(svc_start_t, svc_run)
svc_confdir_domain(svc_run_t)

# the logger
daemon_sub_domain(svc_run_t, svc_multilog)
file_type_auto_trans(svc_multilog_t, svc_log_t, svc_log_t, file);

######
# rules for all those domains

# svc_start_t
allow svc_start_t self:fifo_file rw_file_perms;
allow svc_start_t self:capability kill;

allow svc_start_t { bin_t sbin_t etc_t }:dir r_dir_perms;
allow svc_start_t { bin_t sbin_t etc_t }:lnk_file r_file_perms;
allow svc_start_t { var_t var_run_t }:dir search;
can_exec(svc_start_t, shell_exec_t)
allow svc_start_t svc_start_exec_t:file { rx_file_perms execute_no_trans };
allow svc_start_t svc_run_t:process signal;

# svc_run_t
allow svc_run_t self:capability { setgid setuid chown fsetid };
allow svc_run_t self:fifo_file rw_file_perms;
allow svc_run_t self:file r_file_perms;
allow svc_run_t self:process { fork setrlimit };
allow svc_run_t self:unix_stream_socket create_stream_socket_perms;
allow svc_run_t svc_svc_t:dir r_dir_perms;
allow svc_run_t svc_svc_t:file r_file_perms;
allow svc_run_t svc_run_exec_t:file { rx_file_perms execute_no_trans };
allow svc_run_t { bin_t sbin_t etc_t }:dir r_dir_perms;
allow svc_run_t { bin_t sbin_t etc_t }:lnk_file r_file_perms;
allow svc_run_t { var_t var_run_t }:dir search;
can_exec(svc_run_t, etc_t)
can_exec(svc_run_t, lib_t)
can_exec(svc_run_t, bin_t)
can_exec(svc_run_t, sbin_t)
can_exec(svc_run_t, ls_exec_t)
can_exec(svc_run_t, shell_exec_t)
allow svc_run_t devtty_t:chr_file rw_file_perms;
allow svc_run_t etc_runtime_t:file r_file_perms;
allow svc_run_t exec_type:{ file lnk_file } getattr;
allow svc_run_t init_t:fd use;
allow svc_run_t initrc_t:fd use;
allow svc_run_t proc_t:file r_file_perms;
allow svc_run_t sysctl_t:dir search;
allow svc_run_t sysctl_kernel_t:dir r_dir_perms;
allow svc_run_t sysctl_kernel_t:file r_file_perms;
allow svc_run_t var_lib_t:dir r_dir_perms;


# multilog creates /service/*/log/status
allow svc_multilog_t svc_svc_t:dir { read search };
allow svc_multilog_t svc_svc_t:file { append write };
# writes to /var/log/*/*
allow svc_multilog_t var_t:dir search;
allow svc_multilog_t var_log_t:dir create_dir_perms;
allow svc_multilog_t var_log_t:file create_file_perms;
# misc
allow svc_multilog_t init_t:fd use;
allow svc_start_t svc_multilog_t:process signal;
svc_ipc_domain(svc_multilog_t)


# run_init can control svc_script_t and svc_start_t domains
domain_auto_trans(run_init_t, svc_script_exec_t, svc_script_t)
domain_auto_trans(run_init_t, svc_start_exec_t, svc_start_t)
allow initrc_t { svc_script_exec_t svc_start_exec_t }:file entrypoint;
svc_filedir_domain(initrc_t)

allow svc_script_t self:capability sys_admin;
allow svc_script_t self:fifo_file { getattr read write };
allow svc_script_t self:file r_file_perms;
allow svc_script_t { bin_t sbin_t var_t }:dir r_dir_perms;
allow svc_script_t bin_t:lnk_file r_file_perms;
can_exec(svc_script_t, bin_t)
can_exec(svc_script_t, shell_exec_t)
allow svc_script_t proc_t:file r_file_perms;
allow svc_script_t shell_exec_t:file rx_file_perms;
allow svc_script_t devtty_t:chr_file rw_file_perms;
allow svc_script_t etc_runtime_t:file r_file_perms;
allow svc_script_t svc_run_exec_t:file r_file_perms;
allow svc_script_t svc_script_exec_t:file execute_no_trans;
allow svc_script_t sysctl_kernel_t:dir r_dir_perms;
allow svc_script_t sysctl_kernel_t:file r_file_perms;

# sysadm can tweak svc_run_exec_t files
allow sysadm_t svc_run_exec_t:file create_file_perms;

################################################################
# scripts that can be started by daemontools
# keep it sorted please.

ifdef(`apache.te', `
domain_auto_trans(svc_run_t, httpd_exec_t, httpd_t)
svc_ipc_domain(httpd_t)
dontaudit httpd_t svc_svc_t:dir { search };
')

ifdef(`clockspeed.te', `
domain_auto_trans( svc_run_t, clockspeed_exec_t, clockspeed_t)
svc_ipc_domain(clockspeed_t)
r_dir_file(svc_run_t, clockspeed_var_lib_t)
allow svc_run_t clockspeed_var_lib_t:fifo_file { rw_file_perms setattr };
')

ifdef(`dante.te', `
domain_auto_trans( svc_run_t, dante_exec_t, dante_t);
svc_ipc_domain(dante_t)
')

ifdef(`publicfile.te', `
svc_ipc_domain(publicfile_t)
')

ifdef(`qmail.te', `
allow svc_run_t qmail_start_exec_t:file rx_file_perms;
domain_auto_trans(svc_run_t, qmail_start_exec_t, qmail_start_t)
r_dir_file(svc_run_t, qmail_etc_t)
svc_ipc_domain(qmail_send_t)
svc_ipc_domain(qmail_start_t)
svc_ipc_domain(qmail_queue_t)
svc_ipc_domain(qmail_smtpd_t)
')

ifdef(`rsyncd.te', `
domain_auto_trans(svc_run_t, rsyncd_exec_t, rsyncd_t)
svc_ipc_domain(rsyncd_t)
')

ifdef(`ssh.te', `
domain_auto_trans(svc_run_t, sshd_exec_t, sshd_t)
svc_ipc_domain(sshd_t)
')

ifdef(`stunnel.te', `
domain_auto_trans( svc_run_t, stunnel_exec_t, stunnel_t)
svc_ipc_domain(stunnel_t)
')

ifdef(`ucspi-tcp.te', `
domain_auto_trans(svc_run_t, utcpserver_exec_t, utcpserver_t)
allow svc_run_t utcpserver_t:process { signal };
svc_ipc_domain(utcpserver_t)
')


--------------030101050400010807090708
Content-Type: text/plain;
 name="daemontools_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="daemontools_macros.te"


define(`svc_ipc_domain',`
allow $1 svc_start_t:process { sigchld };
allow $1 svc_start_t:fd { use };
allow $1 svc_start_t:fifo_file { read write };
allow svc_start_t $1:process { signal }; 
')


--------------030101050400010807090708
Content-Type: text/plain;
 name="djbdns.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="djbdns.fc"


/usr/bin/dnscache               -- system_u:object_r:djbdns_dnscache_exec_t
/usr/bin/tinydns                -- system_u:object_r:djbdns_tinydns_exec_t
/usr/bin/axfrdns                -- system_u:object_r:djbdns_axfrdns_exec_t

/var/dnscache[a-z]?(/.*)?          system_u:object_r:svc_svc_t
/var/dnscache[a-z]?/run        --  system_u:object_r:svc_run_exec_t
/var/dnscache[a-z]?/log/run    --  system_u:object_r:svc_run_exec_t
/var/dnscache[a-z]?/env(/.*)?      system_u:object_r:svc_conf_t
/var/dnscache[a-z]?/root(/.*)?     system_u:object_r:djbdns_dnscache_conf_t
/var/dnscache[a-z]?/log/main(/.*)? system_u:object_r:var_log_t

/var/tinydns(/.*)?                 system_u:object_r:svc_svc_t
/var/tinydns/run               --  system_u:object_r:svc_run_exec_t
/var/tinydns/log/run           --  system_u:object_r:svc_run_exec_t
/var/tinydns/env(/.*)?             system_u:object_r:svc_conf_t
/var/tinydns/root(/.*)?            system_u:object_r:djbdns_tinydns_conf_t
/var/tinydns/log/main(/.*)?        system_u:object_r:var_log_t

/var/axfrdns(/.*)?                 system_u:object_r:svc_svc_t
/var/axfrdns/run               --  system_u:object_r:svc_run_exec_t
/var/axfrdns/log/run           --  system_u:object_r:svc_run_exec_t
/var/axfrdns/env(/.*)?             system_u:object_r:svc_conf_t
/var/axfrdns/root(/.*)?            system_u:object_r:djbdns_axfrdns_conf_t
/var/axfrdns/log/main(/.*)?        system_u:object_r:var_log_t


--------------030101050400010807090708
Content-Type: text/plain;
 name="djbdns.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="djbdns.te"

# DESC selinux policy for djbdns
# http://cr.yp.to/djbdns.html
#
# Author:  petre rodan <kaiowas@gentoo.org>
#
# this policy depends on ucspi-tcp and daemontools policies
#

define(`djbdns_daemon_domain', `
type djbdns_$1_conf_t, file_type, sysadmfile;
daemon_domain(djbdns_$1)
domain_auto_trans( svc_run_t, djbdns_$1_exec_t, djbdns_$1_t)
svc_ipc_domain(djbdns_$1_t)
can_network(djbdns_$1_t)
allow djbdns_$1_t dns_port_t:{ udp_socket tcp_socket } name_bind;
allow djbdns_$1_t port_t:udp_socket name_bind;
r_dir_file(djbdns_$1_t, djbdns_$1_conf_t)
allow djbdns_$1_t self:capability { net_bind_service setgid setuid sys_chroot };
allow djbdns_$1_t svc_svc_t:dir r_dir_perms;
')


define(`djbdns_tcpserver_domain', `
type djbdns_$1_conf_t, file_type, sysadmfile;
daemon_domain(djbdns_$1)
domain_auto_trans(utcpserver_t, djbdns_$1_exec_t, djbdns_$1_t)
svc_ipc_domain(djbdns_$1_t)
allow utcpserver_t dns_port_t:{ udp_socket tcp_socket } name_bind;
r_dir_file(djbdns_$1_t, djbdns_$1_conf_t)
allow djbdns_$1_t utcpserver_t:tcp_socket { read write };
')


djbdns_daemon_domain(dnscache)
# read 'seed' file
allow djbdns_dnscache_t svc_svc_t:file r_file_perms;

djbdns_daemon_domain(tinydns)

djbdns_tcpserver_domain(axfrdns)
r_dir_file(djbdns_axfrdns_t, djbdns_tinydns_t)


--------------030101050400010807090708
Content-Type: text/plain;
 name="ucspi-tcp.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ucspi-tcp.fc"


/usr/bin/tcpserver	--	system_u:object_r:utcpserver_exec_t

--------------030101050400010807090708
Content-Type: text/plain;
 name="ucspi-tcp.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ucspi-tcp.te"

#DESC ucspi-tcp - TCP Server and Client Tools
#
# Author Petre Rodan <kaiowas@gentoo.org>
#

# http://cr.yp.to/ucspi-tcp.html

type utcpserver_port_t, port_type;

daemon_base_domain(utcpserver)
can_network(utcpserver_t)

#reads /etc/nsswitch.conf and resolv.conf
allow utcpserver_t etc_t:file { getattr read };
allow utcpserver_t resolv_conf_t:file { read };

allow utcpserver_t { bin_t var_t }:dir { search };

allow utcpserver_t self:capability { net_bind_service setgid setuid };
allow utcpserver_t self:fifo_file { read write };
allow utcpserver_t self:process { fork sigchld };

ifdef(`qmail.te', `
domain_auto_trans(utcpserver_t, qmail_smtpd_exec_t, qmail_smtpd_t)
allow utcpserver_t smtp_port_t:tcp_socket name_bind;
allow qmail_smtpd_t utcpserver_t:tcp_socket { read write getattr };
allow utcpserver_t etc_qmail_t:dir r_dir_perms;
allow utcpserver_t etc_qmail_t:file r_file_perms;
')


--------------030101050400010807090708
Content-Type: text/plain;
 name="net_types.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net_types.diff"

Index: net_contexts
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/net_contexts,v
retrieving revision 1.22
diff -u -B -r1.22 net_contexts
--- net_contexts	8 Nov 2004 20:57:03 -0000	1.22
+++ net_contexts	21 Nov 2004 11:12:56 -0000
@@ -38,7 +38,7 @@
 portcon udp 892 system_u:object_r:inetd_child_port_t
 portcon tcp 2105 system_u:object_r:inetd_child_port_t
 ')
-ifdef(`ftpd.te', `
+ifdef(`use_ftpd', `
 portcon tcp 20 system_u:object_r:ftp_data_port_t
 portcon tcp 21 system_u:object_r:ftp_port_t
 ')
@@ -57,7 +57,7 @@
 ifdef(`dhcpc.te', `portcon udp 68  system_u:object_r:dhcpc_port_t')
 ifdef(`tftpd.te', `portcon udp 69  system_u:object_r:tftp_port_t')
 ifdef(`fingerd.te', `portcon tcp 79  system_u:object_r:fingerd_port_t')
-ifdef(`apache.te', `
+ifdef(`use_http', `
 portcon tcp 80  system_u:object_r:http_port_t
 portcon tcp 443  system_u:object_r:http_port_t
 ')
@@ -215,6 +215,7 @@
 portcon tcp 8080  system_u:object_r:http_cache_port_t
 portcon udp 3130  system_u:object_r:http_cache_port_t
 ')
+ifdef(`clockspeed.te', `portcon udp 4041 system_u:object_r:clockspeed_port_t')
 ifdef(`transproxy.te', `portcon tcp 8081 system_u:object_r:transproxy_port_t')
 ifdef(`amanda.te', `
 portcon udp 10080 system_u:object_r:amanda_port_t
Index: types/network.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/types/network.te,v
retrieving revision 1.13
diff -u -B -r1.13 network.te
--- types/network.te	8 Nov 2004 20:57:08 -0000	1.13
+++ types/network.te	21 Nov 2004 11:12:57 -0000
@@ -26,6 +26,7 @@
 ifdef(`nsd.te', `define(`use_dns')')
 ifdef(`tinydns.te', `define(`use_dns')')
 ifdef(`dnsmasq.te', `define(`use_dns')')
+ifdef(`djbdns.te', `define(`use_dns')')
 ifdef(`use_dns', `
 type dns_port_t, port_type;
 ')
@@ -44,7 +45,17 @@
 ifdef(`use_pop', `
 type pop_port_t, port_type, reserved_port_type;
 ')
-ifdef(`apache.te', `define(`use_http_cache')')
+ifdef(`apache.te', `
+define(`use_http_cache')
+define(`use_http')
+')
+ifdef(`ftpd.te', `
+define(`use_ftpd')
+')
+ifdef(`publicfile.te', `
+define(`use_http')
+define(`use_ftpd')
+')
 ifdef(`squid.te', `define(`use_http_cache')')
 ifdef(`use_http_cache', `
 type http_cache_port_t, port_type;

--------------030101050400010807090708--

--------------enig2395D64DADBA51440534CB41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBoH1AGSBEIeh4AEYRAnTgAJ43eYyhUnsWYr3h4P6rgeOftGiilwCeLA5B
aBXS8q29yeMMdxhHDdqcM8M=
=B4SP
-----END PGP SIGNATURE-----

--------------enig2395D64DADBA51440534CB41--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
