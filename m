Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i42HKnRb001355
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 13:20:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i42HIYZx009496
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 17:18:34 GMT
Received: from dns1.outlandz.net (dns1.outlandz.net [66.132.132.24])
	by jazzswing.ncsc.mil  with ESMTP id i42HIXJv009493
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 17:18:33 GMT
Subject: Daemontools Policy Files
From: "Matthew J. Fanto" <mattjf@uncompiled.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-Re93zPg/LA67O2qnDkwf"
Message-Id: <1083518456.543.15.camel@ares>
Mime-Version: 1.0
Date: Sun, 02 May 2004 13:20:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Re93zPg/LA67O2qnDkwf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here are policy files for daemontools (required for djbdns). This was
based off the Gentoo daemontools policy file, but heavily modified to
work with Debian. 

-Matthew J. Fanto

--=-Re93zPg/LA67O2qnDkwf
Content-Disposition: attachment; filename=daemontools.fc
Content-Type: text/plain; name=daemontools.fc; charset=us-ascii
Content-Transfer-Encoding: 7bit

# Original author Petre Rodan <petre.rodan@ravantivirus.com>
#
# Updated for use in Debian by Matthew J. Fanto <mattjf@uncompiled.com>
#

/service/.*			system_u:object_r:svc_svc_t
/var/lib/svscan(/.*)?		system_u:object_r:svc_start_t

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
/usr/bin/svstat		--	system_u:object_r:svc_start_exec_t
/usr/bin/supervise	--	system_u:object_r:svc_start_exec_t

# programs that impose a given environment to daemons
/usr/bin/softlimit	--	system_u:object_r:svc_run_exec_t
/usr/bin/setuidgid	--	system_u:object_r:svc_run_exec_t
/usr/bin/envuidgid	--	system_u:object_r:svc_run_exec_t
/usr/bin/envdir		--	system_u:object_r:svc_run_exec_t
/usr/bin/setlock	--	system_u:object_r:svc_run_exec_t

# helper programs
/usr/bin/fghack		--	system_u:object_r:svc_run_exec_t
/usr/bin/pgrphack	--	system_u:object_r:svc_run_exec_t

# daemontools logger # writes to service/*/log/main/ and /var/log/*/
/usr/bin/multilog	--	system_u:object_r:svc_multilog_exec_t

# dnscache 
/etc/dnscache/log		system_u:object_r:svc_log_t
/etc/dnscache/log/main(/.*)?	system_u:object_r:svc_log_t
/etc/dnscache/log/status	system_u:object_r:svc_log_t
/etc/dnscache/log/supervise(/.*)? system_u:object_r:svc_log_t
/etc/dnscache/supervise(/.*)?	system_u:object_r:svc_log_t
# tinydns
/etc/tinydns/log		system_u:object_r:svc_log_t
/etc/tinydns/log/main(/.*)?	system_u:object_r:svc_log_t
/etc/tinydns/log/status		system_u:object_r:svc_log_t
/etc/tinydns/log/supervise(/.*)? system_u:object_r:svc_log_t
/etc/tinydns/supervise(/.*)?	system_u:object_r:svc_log_t

/var/log/svscan(/.*)?		system_u:object_r:svc_log_t

--=-Re93zPg/LA67O2qnDkwf
Content-Disposition: attachment; filename=daemontools.te
Content-Type: text/plain; name=daemontools.te; charset=us-ascii
Content-Transfer-Encoding: 7bit

#DESC Daemontools - Tools for managing UNIX services
#
# Author Matthew J. Fanto <mattjf@uncompiled.com>
#
# Based on the daemontools gentoo policy file written by
#	Petre Rodan <petre.rodan@ravantivirus.com>
#	with the help of Chris PeBenito, Russell Coker 
#	and Tad Glines
# 
# selinux policy for daemontools
# http://cr.yp.to/daemontools.html
#

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
allow initrc_t svc_log_t:dir { read write add_name remove_name };
allow initrc_t svc_log_t:file { append lock setattr link rename create unlink };

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
allow svc_start_t self:capability { kill };

allow svc_start_t { bin_t sbin_t etc_t }:dir r_dir_perms;
allow svc_start_t { bin_t sbin_t etc_t }:lnk_file r_file_perms;
can_exec(svc_start_t, shell_exec_t)
allow svc_start_t svc_start_exec_t:file { rx_file_perms execute_no_trans };
allow svc_start_t svc_run_t:process { signal };
allow svc_start_t svc_log_t:dir rw_dir_perms;
allow svc_start_t svc_log_t:file create_file_perms;
allow svc_start_t var_t:dir { search };
allow svc_start_t var_lib_t:dir { search };
allow svc_start_t svc_log_t:fifo_file rw_file_perms;

# svc_run_t
allow svc_run_t self:capability { setgid setuid chown fsetid };
allow svc_run_t self:fifo_file rw_file_perms;
allow svc_run_t self:file r_file_perms;
allow svc_run_t self:process { fork };
allow svc_run_t svc_svc_t:dir r_dir_perms;
allow svc_run_t svc_svc_t:file r_file_perms;
allow svc_run_t svc_run_exec_t:file { rx_file_perms execute_no_trans };
allow svc_run_t { bin_t sbin_t etc_t }:dir r_dir_perms;
allow svc_run_t { bin_t sbin_t etc_t }:lnk_file r_file_perms;
can_exec(svc_run_t, etc_t)
can_exec(svc_run_t, lib_t)
can_exec(svc_run_t, bin_t)
can_exec(svc_run_t, sbin_t)
can_exec(svc_run_t, ls_exec_t)
can_exec(svc_run_t, shell_exec_t)
allow svc_run_t devtty_t:chr_file rw_file_perms;
allow svc_run_t etc_runtime_t:file r_file_perms;
allow svc_run_t exec_type:{ file lnk_file } getattr;
allow svc_run_t init_t:fd { use };
allow svc_run_t initrc_t:fd { use };
allow svc_run_t initrc_t:fifo_file rw_file_perms;
allow svc_run_t proc_t:file r_file_perms;
allow svc_run_t sysctl_kernel_t:dir r_dir_perms;
allow svc_run_t sysctl_kernel_t:file r_file_perms;
allow svc_run_t var_lib_t:dir r_dir_perms;
allow svc_run_t var_t:dir { search };
allow svc_run_t var_run_t:dir { search };

# multilog creates /service/*/log/status
can_exec(svc_multilog_t, svc_multilog_exec_t)
allow svc_multilog_t svc_log_t:file { rename link }; 
allow svc_multilog_t svc_svc_t:dir { read search };
allow svc_multilog_t svc_svc_t:file { append write };
# writes to /var/log/*/*
allow svc_multilog_t var_log_t:dir create_dir_perms;
allow svc_multilog_t var_log_t:file create_file_perms;
# misc
allow svc_multilog_t init_t:fd { use };
allow svc_multilog_t initrc_t:fd { use };
allow svc_multilog_t initrc_t:fifo_file rw_file_perms;
allow svc_start_t svc_multilog_t:process { signal };
allow svc_multilog_t svc_log_t:file ra_file_perms;
svc_ipc_domain(svc_multilog_t)


# run_init can control svc_script_t and svc_start_t domains
domain_auto_trans(run_init_t, svc_script_exec_t, svc_script_t)
domain_auto_trans(run_init_t, svc_start_exec_t, svc_start_t)
allow initrc_t { svc_script_exec_t svc_start_exec_t }:file { entrypoint };
svc_filedir_domain(initrc_t)

allow svc_script_t self:capability { sys_admin };
allow svc_script_t self:fifo_file { getattr read write };
allow svc_script_t bin_t:dir r_dir_perms;
allow svc_script_t bin_t:lnk_file r_file_perms;
can_exec(svc_script_t, bin_t)
can_exec(svc_script_t, shell_exec_t)
allow svc_script_t proc_t:file r_file_perms;
allow svc_script_t shell_exec_t:file rx_file_perms;
allow svc_script_t devtty_t:chr_file rw_file_perms;
allow svc_script_t etc_runtime_t:file r_file_perms;
allow svc_script_t svc_run_exec_t:file r_file_perms;
allow svc_script_t svc_script_exec_t:file { execute_no_trans };
# sleep
allow svc_script_t sysctl_kernel_t:dir r_dir_perms;
allow svc_script_t sysctl_kernel_t:file r_file_perms;
allow svc_script_t var_t:dir r_dir_perms;


################################################################
# scripts that can be started by daemontools

ifdef(`ucspi-tcp.te', `
domain_auto_trans(svc_run_t, utcpserver_exec_t, utcpserver_t)
allow svc_run_t utcpserver_t:process { signal };
allow svc_start_t utcpserver_t:process { signal };
svc_ipc_domain(utcpserver_t)
')

ifdef(`ssh.te', `
domain_auto_trans(svc_run_t, sshd_exec_t, sshd_t)
svc_ipc_domain(sshd_t)
')

ifdef(`qmail.te', `
allow svc_run_t qmail_start_exec_t:file rx_file_perms;
domain_auto_trans(svc_run_t, qmail_start_exec_t, qmail_start_t)
# r qmail configs from /var/qmail/control/*
allow svc_run_t etc_qmail_t:dir r_dir_perms;
allow svc_run_t etc_qmail_t:file r_file_perms;

allow svc_start_t qmail_send_t:process { signal };
svc_ipc_domain(qmail_send_t)
svc_ipc_domain(qmail_start_t)
svc_ipc_domain(qmail_queue_t)
svc_ipc_domain(qmail_smtpd_t)
')

ifdef(`dnscache.te', `
allow svc_run_t dnscache_exec_t:file rx_file_perms;
domain_auto_trans(svc_run_t, dnscache_exec_t, dnscache_t)
allow svc_run_t dnscache_conf_t:dir r_dir_perms;
allow svc_run_t dnscache_conf_t:file r_file_perms;
')

ifdef(`tinydns.te', `
allow svc_run_t tinydns_exec_t:file rx_file_perms;
allow svc_start_t tinydns_exec_t:file rx_file_perms;
can_exec(svc_run_t, tinydns_exec_t)
can_exec(svc_start_t, tinydns_exec_t)
domain_auto_trans(svc_run_t, tinydns_exec_t, tinydns_t)
domain_auto_trans(svc_start_t, tinydns_exec_t, tinydns_t)
allow svc_run_t tinydns_conf_t:dir r_dir_perms;
allow svc_run_t tinydns_conf_t:file r_file_perms;
allow svc_start_t tinydns_conf_t:dir { getattr search };
allow svc_start_t tinydns_conf_t:file { append lock };
allow svc_start_t tinydns_t:process { signal };
')

ifdef(`publicfile.te', `
svc_ipc_domain(publicfile_t)
')
##############################################################



--=-Re93zPg/LA67O2qnDkwf
Content-Disposition: attachment; filename=daemontools.fc
Content-Type: text/plain; name=daemontools.fc; charset=us-ascii
Content-Transfer-Encoding: 7bit

# Original author Petre Rodan <petre.rodan@ravantivirus.com>
#
# Updated for use in Debian by Matthew J. Fanto <mattjf@uncompiled.com>
#

/service/.*			system_u:object_r:svc_svc_t
/var/lib/svscan(/.*)?		system_u:object_r:svc_start_t

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
/usr/bin/svstat		--	system_u:object_r:svc_start_exec_t
/usr/bin/supervise	--	system_u:object_r:svc_start_exec_t

# programs that impose a given environment to daemons
/usr/bin/softlimit	--	system_u:object_r:svc_run_exec_t
/usr/bin/setuidgid	--	system_u:object_r:svc_run_exec_t
/usr/bin/envuidgid	--	system_u:object_r:svc_run_exec_t
/usr/bin/envdir		--	system_u:object_r:svc_run_exec_t
/usr/bin/setlock	--	system_u:object_r:svc_run_exec_t

# helper programs
/usr/bin/fghack		--	system_u:object_r:svc_run_exec_t
/usr/bin/pgrphack	--	system_u:object_r:svc_run_exec_t

# daemontools logger # writes to service/*/log/main/ and /var/log/*/
/usr/bin/multilog	--	system_u:object_r:svc_multilog_exec_t

# dnscache 
/etc/dnscache/log		system_u:object_r:svc_log_t
/etc/dnscache/log/main(/.*)?	system_u:object_r:svc_log_t
/etc/dnscache/log/status	system_u:object_r:svc_log_t
/etc/dnscache/log/supervise(/.*)? system_u:object_r:svc_log_t
/etc/dnscache/supervise(/.*)?	system_u:object_r:svc_log_t
# tinydns
/etc/tinydns/log		system_u:object_r:svc_log_t
/etc/tinydns/log/main(/.*)?	system_u:object_r:svc_log_t
/etc/tinydns/log/status		system_u:object_r:svc_log_t
/etc/tinydns/log/supervise(/.*)? system_u:object_r:svc_log_t
/etc/tinydns/supervise(/.*)?	system_u:object_r:svc_log_t

/var/log/svscan(/.*)?		system_u:object_r:svc_log_t

--=-Re93zPg/LA67O2qnDkwf
Content-Disposition: attachment; filename=daemontools.te
Content-Type: text/plain; name=daemontools.te; charset=us-ascii
Content-Transfer-Encoding: 7bit

#DESC Daemontools - Tools for managing UNIX services
#
# Author Matthew J. Fanto <mattjf@uncompiled.com>
#
# Based on the daemontools gentoo policy file written by
#	Petre Rodan <petre.rodan@ravantivirus.com>
#	with the help of Chris PeBenito, Russell Coker 
#	and Tad Glines
# 
# selinux policy for daemontools
# http://cr.yp.to/daemontools.html
#

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
allow initrc_t svc_log_t:dir { read write add_name remove_name };
allow initrc_t svc_log_t:file { append lock setattr link rename create unlink };

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
allow svc_start_t self:capability { kill };

allow svc_start_t { bin_t sbin_t etc_t }:dir r_dir_perms;
allow svc_start_t { bin_t sbin_t etc_t }:lnk_file r_file_perms;
can_exec(svc_start_t, shell_exec_t)
allow svc_start_t svc_start_exec_t:file { rx_file_perms execute_no_trans };
allow svc_start_t svc_run_t:process { signal };
allow svc_start_t svc_log_t:dir rw_dir_perms;
allow svc_start_t svc_log_t:file create_file_perms;
allow svc_start_t var_t:dir { search };
allow svc_start_t var_lib_t:dir { search };
allow svc_start_t svc_log_t:fifo_file rw_file_perms;

# svc_run_t
allow svc_run_t self:capability { setgid setuid chown fsetid };
allow svc_run_t self:fifo_file rw_file_perms;
allow svc_run_t self:file r_file_perms;
allow svc_run_t self:process { fork };
allow svc_run_t svc_svc_t:dir r_dir_perms;
allow svc_run_t svc_svc_t:file r_file_perms;
allow svc_run_t svc_run_exec_t:file { rx_file_perms execute_no_trans };
allow svc_run_t { bin_t sbin_t etc_t }:dir r_dir_perms;
allow svc_run_t { bin_t sbin_t etc_t }:lnk_file r_file_perms;
can_exec(svc_run_t, etc_t)
can_exec(svc_run_t, lib_t)
can_exec(svc_run_t, bin_t)
can_exec(svc_run_t, sbin_t)
can_exec(svc_run_t, ls_exec_t)
can_exec(svc_run_t, shell_exec_t)
allow svc_run_t devtty_t:chr_file rw_file_perms;
allow svc_run_t etc_runtime_t:file r_file_perms;
allow svc_run_t exec_type:{ file lnk_file } getattr;
allow svc_run_t init_t:fd { use };
allow svc_run_t initrc_t:fd { use };
allow svc_run_t initrc_t:fifo_file rw_file_perms;
allow svc_run_t proc_t:file r_file_perms;
allow svc_run_t sysctl_kernel_t:dir r_dir_perms;
allow svc_run_t sysctl_kernel_t:file r_file_perms;
allow svc_run_t var_lib_t:dir r_dir_perms;
allow svc_run_t var_t:dir { search };
allow svc_run_t var_run_t:dir { search };

# multilog creates /service/*/log/status
can_exec(svc_multilog_t, svc_multilog_exec_t)
allow svc_multilog_t svc_log_t:file { rename link }; 
allow svc_multilog_t svc_svc_t:dir { read search };
allow svc_multilog_t svc_svc_t:file { append write };
# writes to /var/log/*/*
allow svc_multilog_t var_log_t:dir create_dir_perms;
allow svc_multilog_t var_log_t:file create_file_perms;
# misc
allow svc_multilog_t init_t:fd { use };
allow svc_multilog_t initrc_t:fd { use };
allow svc_multilog_t initrc_t:fifo_file rw_file_perms;
allow svc_start_t svc_multilog_t:process { signal };
allow svc_multilog_t svc_log_t:file ra_file_perms;
svc_ipc_domain(svc_multilog_t)


# run_init can control svc_script_t and svc_start_t domains
domain_auto_trans(run_init_t, svc_script_exec_t, svc_script_t)
domain_auto_trans(run_init_t, svc_start_exec_t, svc_start_t)
allow initrc_t { svc_script_exec_t svc_start_exec_t }:file { entrypoint };
svc_filedir_domain(initrc_t)

allow svc_script_t self:capability { sys_admin };
allow svc_script_t self:fifo_file { getattr read write };
allow svc_script_t bin_t:dir r_dir_perms;
allow svc_script_t bin_t:lnk_file r_file_perms;
can_exec(svc_script_t, bin_t)
can_exec(svc_script_t, shell_exec_t)
allow svc_script_t proc_t:file r_file_perms;
allow svc_script_t shell_exec_t:file rx_file_perms;
allow svc_script_t devtty_t:chr_file rw_file_perms;
allow svc_script_t etc_runtime_t:file r_file_perms;
allow svc_script_t svc_run_exec_t:file r_file_perms;
allow svc_script_t svc_script_exec_t:file { execute_no_trans };
# sleep
allow svc_script_t sysctl_kernel_t:dir r_dir_perms;
allow svc_script_t sysctl_kernel_t:file r_file_perms;
allow svc_script_t var_t:dir r_dir_perms;


################################################################
# scripts that can be started by daemontools

ifdef(`ucspi-tcp.te', `
domain_auto_trans(svc_run_t, utcpserver_exec_t, utcpserver_t)
allow svc_run_t utcpserver_t:process { signal };
allow svc_start_t utcpserver_t:process { signal };
svc_ipc_domain(utcpserver_t)
')

ifdef(`ssh.te', `
domain_auto_trans(svc_run_t, sshd_exec_t, sshd_t)
svc_ipc_domain(sshd_t)
')

ifdef(`qmail.te', `
allow svc_run_t qmail_start_exec_t:file rx_file_perms;
domain_auto_trans(svc_run_t, qmail_start_exec_t, qmail_start_t)
# r qmail configs from /var/qmail/control/*
allow svc_run_t etc_qmail_t:dir r_dir_perms;
allow svc_run_t etc_qmail_t:file r_file_perms;

allow svc_start_t qmail_send_t:process { signal };
svc_ipc_domain(qmail_send_t)
svc_ipc_domain(qmail_start_t)
svc_ipc_domain(qmail_queue_t)
svc_ipc_domain(qmail_smtpd_t)
')

ifdef(`dnscache.te', `
allow svc_run_t dnscache_exec_t:file rx_file_perms;
domain_auto_trans(svc_run_t, dnscache_exec_t, dnscache_t)
allow svc_run_t dnscache_conf_t:dir r_dir_perms;
allow svc_run_t dnscache_conf_t:file r_file_perms;
')

ifdef(`tinydns.te', `
allow svc_run_t tinydns_exec_t:file rx_file_perms;
allow svc_start_t tinydns_exec_t:file rx_file_perms;
can_exec(svc_run_t, tinydns_exec_t)
can_exec(svc_start_t, tinydns_exec_t)
domain_auto_trans(svc_run_t, tinydns_exec_t, tinydns_t)
domain_auto_trans(svc_start_t, tinydns_exec_t, tinydns_t)
allow svc_run_t tinydns_conf_t:dir r_dir_perms;
allow svc_run_t tinydns_conf_t:file r_file_perms;
allow svc_start_t tinydns_conf_t:dir { getattr search };
allow svc_start_t tinydns_conf_t:file { append lock };
allow svc_start_t tinydns_t:process { signal };
')

ifdef(`publicfile.te', `
svc_ipc_domain(publicfile_t)
')
##############################################################



--=-Re93zPg/LA67O2qnDkwf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
