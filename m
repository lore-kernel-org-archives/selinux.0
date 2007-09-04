Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84HNOEq019482
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 13:23:24 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l84HNL8X028346
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 17:23:21 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher PeBenito J." <cpebenito@tresys.com>,
        Daniel Walsh J <dwalsh@redhat.com>
Message-Id: <C4A3F81D-567F-4EE1-A64F-48191D2EB4BC@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-12-165889352
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] apcupsd request for comments
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Tue, 4 Sep 2007 19:21:26 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-12-165889352
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Attached is a apcupsd policy which works with a strict policy except  
shutdown. I used initially Daniel's policy which only works with the  
targeted policy. I added apcupsd_script_t for scripts in /etc/apcupsd  
which get executed by apcupsd_t.

Tested on a Debian (testing) system, refpolicy-20070629 and  
apcupsd-3.14.1. Access was via snmp.

Three questions left.

1) Is there an interface for /sbin/shutdown? Now apcupsd can't  
shutdown the host.

2) Apcupsd creates a file /etc/nologin and /etc/apcupsd/powerfail  
which for it needs manage_file_perms for etc_t because after power  
returns  it unlinks the /etc/nologin file. This could be a security  
problem.

3) While sending mails via /bin/mail some strange AVCs are generated  
s. TODO statement

Any suggestions?

PS: you will need the terminal.if patch (term_write_all_user_ptys) to  
compile this policy (s. one email before ;-))


--Apple-Mail-12-165889352
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apcupsd.fc
Content-Disposition: attachment;
	filename=apcupsd.fc

/usr/sbin/apcupsd		--	gen_context(system_u:object_r:apcupsd_exec_t,s0)
/sbin/apcupsd			--	gen_context(system_u:object_r:apcupsd_exec_t,s0)
/sbin/apcaccess			--	gen_context(system_u:object_r:apcupsd_apcaccess_exec_t,s0)

/etc/apcupsd/apccontrol		--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/changeme		--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/commfailure	--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/commok		--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/killpower		--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/masterconnect	--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/mastertimeout	--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/offbattery		--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/onbattery		--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)
/etc/apcupsd/ups-monitor	--	gen_context(system_u:object_r:apcupsd_script_exec_t,s0)

/var/log/apcupsd\.events.*	--	gen_context(system_u:object_r:apcupsd_log_t,s0)

/var/run/apcupsd\.pid		--	gen_context(system_u:object_r:apcupsd_var_run_t,s0)

--Apple-Mail-12-165889352
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apcupsd.if
Content-Disposition: attachment;
	filename=apcupsd.if

## <summary>APC UPS monitoring daemon</summary>

########################################
## <summary>
##      Read and write apcupsd unnamed pipes.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`apcupsd_rw_pipes',`
	gen_require(`
		type apcupsd_t;
	')

	allow $1 apcupsd_t:fifo_file rw_fifo_file_perms;
')

########################################
## <summary>
##      Inherit and use file descriptors from apcupsd.
## </summary>
## <param name="domain">
##      <summary>
##      The type of the process performing this action.
##      </summary>
## </param>
#
interface(`apcupsd_use_fds',`
	gen_require(`
		type apcupsd_t;
	')

	allow $1 apcupsd_t:fd use;
')

########################################
## <summary>
##	Execute a domain transition to run apcupsd.
## </summary>
## <param name="domain">
## <summary>
##	Domain allowed to transition.
## </summary>
## </param>
#
interface(`apcupsd_domtrans',`
	gen_require(`
		type apcupsd_t, apcupsd_exec_t;
	')

	domtrans_pattern($1,apcupsd_exec_t,apcupsd_t)
')

########################################
## <summary>
##	Read apcupsd PID files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`apcupsd_read_pid_files',`
	gen_require(`
		type apcupsd_var_run_t;
	')

	files_search_pids($1)
	allow $1 apcupsd_var_run_t:file read_file_perms;
')


########################################
## <summary>
##	Allow the specified domain to read apcupsd's log files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
## <rolecap/>
#
interface(`apcupsd_read_log',`
	gen_require(`
		type apcupsd_log_t;
	')

	logging_search_logs($1)
	allow $1 apcupsd_log_t:dir list_dir_perms;
	allow $1 apcupsd_log_t:file { read getattr lock };
')

########################################
## <summary>
##	Allow the specified domain to append
##	apcupsd log files.
## </summary>
## <param name="domain">
## 	<summary>
##	Domain allowed to transition.
## 	</summary>
## </param>
#
interface(`apcupsd_append_log',`
	gen_require(`
		type var_log_t, apcupsd_log_t;
	')

	logging_search_logs($1)
	allow $1 apcupsd_log_t:dir list_dir_perms;
	allow $1 apcupsd_log_t:file { getattr append };
')

########################################
## <summary>
##      Execute a domain transition to run apcupsd.
## </summary>
## <param name="domain">
## <summary>
##      Domain allowed to transition.
## </summary>
## </param>
#
interface(`apcupsd_apcaccess_domtrans',`
        gen_require(`
                type apcupsd_apcaccess_t, apcupsd_apcaccess_exec_t;
        ')

        domtrans_pattern($1,apcupsd_apcaccess_exec_t,apcupsd_apcaccess_t)
')

########################################
## <summary>
##      Read and write apcupsd script unnamed pipes.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`apcupsd_script_rw_pipes',`
	gen_require(`
		type apcupsd_script_t;
	')

	allow $1 apcupsd_script_t:fifo_file rw_fifo_file_perms;
')

########################################
## <summary>
##      Execute a domain transition to run apcupsd script.
## </summary>
## <param name="domain">
## <summary>
##      Domain allowed to transition.
## </summary>
## </param>
#
interface(`apcupsd_script_domtrans',`
	gen_require(`
		type apcupsd_script_t, apcupsd_script_exec_t;
	')

	domtrans_pattern($1,apcupsd_script_exec_t,apcupsd_script_t)
')

########################################
### <summary>
###      Execute apcupsd script in the caller domain.
### </summary>
### <param name="domain">
###      <summary>
###      Domain allowed access.
###      </summary>
### </param>
##
interface(`apcupsd_script_exec',`
	gen_require(`
		type apcupsd_script_exec_t;
	')

	can_exec($1,apcupsd_script_exec_t)
')

--Apple-Mail-12-165889352
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apcupsd.te
Content-Disposition: attachment;
	filename=apcupsd.te


policy_module(apcupsd,1.2.0)

########################################
#
# Declarations
#

## <desc>
## <p>
## Allow apcupsd to use /usr/bin/wall to
## write to the terminal informing the user
## e.g. that the ups is running on battery
## </p>
## </desc>
gen_tunable(allow_apcupsd_write_terminal,false)

type apcupsd_t;
type apcupsd_exec_t;
init_daemon_domain(apcupsd_t, apcupsd_exec_t)

type apcupsd_apcaccess_t;
type apcupsd_apcaccess_exec_t;
init_daemon_domain(apcupsd_apcaccess_t, apcupsd_apcaccess_exec_t)

type apcupsd_script_t;
type apcupsd_script_exec_t;
domain_type(apcupsd_script_t)
domain_entry_file(apcupsd_script_t,apcupsd_script_exec_t)
role system_r types apcupsd_script_t;

type apcupsd_script_tmp_t;
files_tmp_file(apcupsd_script_tmp_t)

type apcupsd_lock_t;
files_lock_file(apcupsd_lock_t)

type apcupsd_log_t;
logging_log_file(apcupsd_log_t)

type apcupsd_var_run_t;
files_pid_file(apcupsd_var_run_t)

########################################
#
# apcupsd local policy
#

allow apcupsd_t self:process signal;
allow apcupsd_t self:unix_stream_socket create_stream_socket_perms;
allow apcupsd_t self:tcp_socket create_stream_socket_perms;
allow apcupsd_t self:udp_socket create_socket_perms;

allow apcupsd_t apcupsd_lock_t:file manage_file_perms;
files_lock_filetrans(apcupsd_t,apcupsd_lock_t,file)

allow apcupsd_t apcupsd_log_t:dir setattr;
manage_files_pattern(apcupsd_t,apcupsd_log_t,apcupsd_log_t)
logging_log_filetrans(apcupsd_t,apcupsd_log_t,{ file dir })

manage_files_pattern(apcupsd_t,apcupsd_var_run_t,apcupsd_var_run_t)
files_pid_filetrans(apcupsd_t,apcupsd_var_run_t, file)

# on shutdown apcupsd creates two files /etc/apcupsd/powerfail and /etc/nologin
# on power resume /etc/nologin is removed
#
# apcupsd needs the rights to { create unlink write } /etc/nologin
# and on /etc/apcupsd/powerfail create
#
# how should we handle this situation?
manage_files_pattern(apcupsd_t,etc_t,etc_t)

apcupsd_rw_pipes(apcupsd_t)

corenet_all_recvfrom_unlabeled(apcupsd_t)
corenet_all_recvfrom_netlabel(apcupsd_t)
corenet_tcp_sendrecv_generic_if(apcupsd_t)
corenet_udp_sendrecv_generic_if(apcupsd_t)
corenet_tcp_sendrecv_all_nodes(apcupsd_t)
corenet_udp_sendrecv_all_nodes(apcupsd_t)
corenet_tcp_sendrecv_all_ports(apcupsd_t)
corenet_tcp_bind_all_nodes(apcupsd_t)
corenet_udp_bind_all_nodes(apcupsd_t)
corenet_tcp_bind_apcupsd_port(apcupsd_t)
corenet_udp_bind_snmp_port(apcupsd_t)
corenet_sendrecv_apcupsd_server_packets(apcupsd_t)
corenet_udp_sendrecv_snmp_port(apcupsd_t)
allow apcupsd_t apcupsd_port_t:tcp_socket name_connect;

dev_rw_generic_usb_dev(apcupsd_t)

# Init script handling
domain_use_interactive_fds(apcupsd_t)

files_read_etc_files(apcupsd_t)
files_search_locks(apcupsd_t)

libs_use_ld_so(apcupsd_t)
libs_use_shared_libs(apcupsd_t)

logging_send_syslog_msg(apcupsd_t)

miscfiles_read_localization(apcupsd_t)

mta_send_mail(apcupsd_t)

corecmd_exec_shell(apcupsd_t)

ifdef(`targeted_policy',`
	term_dontaudit_use_unallocated_ttys(apcupsd_t)
	term_dontaudit_use_generic_ptys(apcupsd_t)
')

########################################
#
# apcupsd access policy
#

apcupsd_use_fds(apcupsd_apcaccess_t)
apcupsd_apcaccess_domtrans(apcupsd_script_t)

append_files_pattern(apcupsd_apcaccess_t, apcupsd_log_t, apcupsd_log_t)
read_files_pattern(apcupsd_apcaccess_t, apcupsd_log_t, apcupsd_log_t)

files_read_etc_files(apcupsd_apcaccess_t)

libs_use_ld_so(apcupsd_apcaccess_t)
libs_use_shared_libs(apcupsd_apcaccess_t)

corenet_all_recvfrom_unlabeled(apcupsd_apcaccess_t)
corenet_all_recvfrom_netlabel(apcupsd_apcaccess_t)
corenet_tcp_sendrecv_generic_if(apcupsd_apcaccess_t)
corenet_tcp_sendrecv_all_nodes(apcupsd_apcaccess_t)
corenet_tcp_sendrecv_all_ports(apcupsd_apcaccess_t)
corenet_sendrecv_apcupsd_server_packets(apcupsd_apcaccess_t)
allow apcupsd_apcaccess_t apcupsd_port_t:tcp_socket name_connect;
allow apcupsd_apcaccess_t apcupsd_t:tcp_socket create_stream_socket_perms;
allow apcupsd_apcaccess_t apcupsd_t:udp_socket rw_socket_perms;
allow apcupsd_apcaccess_t self:tcp_socket create_stream_socket_perms;

dev_rw_generic_usb_dev(apcupsd_apcaccess_t)

########################################
#
# apcupsd script policy
#

allow apcupsd_script_t self:capability { setuid setgid };

allow apcupsd_script_t apcupsd_t:tcp_socket rw_stream_socket_perms;
allow apcupsd_script_t apcupsd_t:udp_socket rw_socket_perms;

files_tmp_filetrans(apcupsd_script_t, apcupsd_script_tmp_t, file)
manage_files_pattern(apcupsd_script_t, apcupsd_script_tmp_t, apcupsd_script_tmp_t)

append_files_pattern(apcupsd_script_t, apcupsd_log_t, apcupsd_log_t)
read_files_pattern(apcupsd_script_t, apcupsd_log_t, apcupsd_log_t)

files_read_etc_files(apcupsd_script_t)

apcupsd_script_rw_pipes(apcupsd_script_t)
apcupsd_script_domtrans(apcupsd_t)
# apcupsd scripts call themselves
apcupsd_script_exec(apcupsd_script_t)

libs_use_ld_so(apcupsd_script_t)
libs_use_shared_libs(apcupsd_script_t)

corecmd_exec_bin(apcupsd_script_t)
corecmd_exec_shell(apcupsd_script_t)

miscfiles_read_localization(apcupsd_script_t)

mta_send_mail(apcupsd_script_t)

hostname_exec(apcupsd_script_t)

userdom_dontaudit_search_sysadm_home_dirs(apcupsd_script_t)
kernel_dontaudit_read_system_state(apcupsd_script_t)

# apcupsd script executes /usr/bin/wall to allert all logged in users
if ( allow_apcupsd_write_terminal ) {
	term_search_ptys(apcupsd_script_t)
	init_dontaudit_write_utmp(apcupsd_script_t)
	init_read_utmp(apcupsd_script_t)
	term_write_all_user_ptys(apcupsd_script_t)
	term_write_all_user_ttys(apcupsd_script_t)
} else {
	init_dontaudit_rw_utmp(apcupsd_script_t)
}

# while sending mail the following AVCs are generated
# I'm not sure why the hell
ifdef(`TODO',`
	allow system_mail_t apcupsd_log_t:file { read append };
	allow system_mail_t apcupsd_script_tmp_t:file { read getattr };
	allow system_mail_t apcupsd_t:tcp_socket { read write };
	allow system_mail_t apcupsd_t:udp_socket { read write };
')

--Apple-Mail-12-165889352--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
