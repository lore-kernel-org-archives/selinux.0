Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2BGYHTF018525
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 12:34:17 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2BGYDFI002357
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 16:34:14 GMT
From: =?utf-8?q?P=C3=A4r_Aronsson?= <par.aronsson@telia.com>
To: selinux@tycho.nsa.gov, fedora-directory-users@redhat.com
Subject: SELinux policy for Fedora Directory Server 1.1.0
Date: Tue, 11 Mar 2008 17:34:09 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CSr1HVGw71+RUeR"
Message-Id: <200803111734.10289.par.aronsson@telia.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Attached is a SELinux policy for the Fedora Directory Server 1.1.0.
It is composed of three parts.
* dirsrv - directory server and setup programs
* dirsrv-admin - administration server and setup programs
* fedora-idm-console - java based console for administration

The policies were developed on a CentOS 5.1 with the following packages:
fedora-ds-base-1.1.0-3.fc6
fedora-ds-admin-1.1.1-1.fc6
fedora-ds-console-1.1.0-5.fc6
selinux-policy-2.4.6-106.el5_1.3
kernel-2.6.18-53.1.4.el5

I've succesfully tested the policies in targeted and strict mode.

The dirsrv-admin policy requires that the apache policy module is loaded.
Also run:
setsebool -P httpd_enable_cgi on

Comment out the following in /usr/sbin/start-ds-admin (line 63-65):
if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
	SELINUX_CMD=3D"runcon -t unconfined_t --"
fi

I had trouble with the replication plugin so I haven't been able to do any=
=20
testing with replication.

Any comments are welcome.

// P=C3=A4r Aronsson

--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="dirsrv-admin.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dirsrv-admin.if"

## <summary>Administration application for Fedora Directory Server, dirsrv-admin.</summary>

########################################
## <summary>
##	Execute dirsrv-admin setup programs in the dirsrvadmin_setup_t domain
##	and the system_r role. Strict policy.
## </summary>
## <param name="domain">
##	<summary>
##	Prefix of the domain performing this action.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to allow the domain.
##	</summary>
## </param>
#
interface(`dirsrvadmin_setup_domtrans_strict',`
	gen_require(`
		type dirsrvadmin_t, dirsrvadmin_setup_t, dirsrvadmin_setupexec_t;
		type $1_t, $1_devpts_t;
	')

	domain_auto_trans($1_t, dirsrvadmin_setupexec_t, dirsrvadmin_setup_t)
	allow dirsrvadmin_setup_t $1_t:fd use;
	allow dirsrvadmin_setup_t $1_t:process sigchld;
	allow dirsrvadmin_setup_t $1_devpts_t:chr_file rw_term_perms;
	role $2 types dirsrvadmin_setup_t;
	role system_r types dirsrvadmin_setup_t;
	role_transition $2 dirsrvadmin_setupexec_t system_r;
')

########################################
## <summary>
##	Execute dirsrv-admin setup programs in the dirsrvadmin_setup_t domain
##	and the system_r role. Targeted policy.
## </summary>
## <param name="domain">
##	<summary>
##	Prefix of the domain performing this action.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to allow the domain.
##	</summary>
## </param>
#
interface(`dirsrvadmin_setup_domtrans_targeted',`
	gen_require(`
		type $1, dirsrvadmin_setupexec_t, dirsrvadmin_setup_t;
	')

	domain_auto_trans($1, dirsrvadmin_setupexec_t, dirsrvadmin_setup_t)
')

########################################
## <summary>
##	Read setup log files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_read_setuplog',`
	gen_require(`
		type dirsrvadmin_setuplog_t;
	')

	files_search_tmp($1)
	allow $1 dirsrvadmin_setuplog_t:file r_file_perms;
')

########################################
## <summary>
##	Manage setup log files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_manage_setuplog',`
	gen_require(`
		type dirsrvadmin_setuplog_t;
	')

	files_search_tmp($1)
	allow $1 dirsrvadmin_setuplog_t:file manage_file_perms;
')

########################################
## <summary>
##	Extend httpd domain for dirsrv-admin.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_extend_httpd',`
	gen_require(`
		type httpd_t;
	')

	# Allow httpd domain to interact with dirsrv
	dirsrv_manage_config(httpd_t)
	dirsrv_manage_log(httpd_t)
	dirsrv_manage_var_run(httpd_t)
	dirsrvadmin_manage_setuplog(httpd_t)
	dirsrvadmin_manage_config(httpd_t)
	dirsrv_signal(httpd_t)
	dirsrv_signull(httpd_t)
	dirsrv_run_helper_exec(httpd_t)
	files_exec_usr_files(httpd_t)
	corenet_tcp_bind_generic_port(httpd_t)
	corenet_tcp_connect_generic_port(httpd_t)

	# Strict policy
	ifdef(`strict_policy',`
		userdom_dontaudit_search_sysadm_home_dirs(httpd_t)
	')
')

########################################
## <summary>
##	Extend httpd domain for dirsrv-admin cgi.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_script_extend_httpd',`
	gen_require(`
		type httpd_t, httpd_exec_t, httpd_suexec_exec_t, httpd_tmp_t, httpd_var_run_t;
	')

	allow $1 httpd_exec_t:file { read getattr execute_no_trans };
	allow $1 httpd_suexec_exec_t:file getattr;
	allow $1 httpd_tmp_t:file { read write };
	allow $1 httpd_t:udp_socket { read write };
	allow $1 httpd_t:unix_stream_socket { ioctl getattr read write };
	allow $1 httpd_t:netlink_route_socket { read write };
	allow $1 httpd_t:fifo_file { write read };
	allow $1 httpd_var_run_t:file { read getattr };
	apache_list_modules($1)
	apache_exec_modules($1)
	apache_use_fds($1)
	dirsrvadmin_run_httpd_script_exec(httpd_t)
')

########################################
## <summary>
##	Extend init domain for dirsrv-admin.
##	The initscript searches in a config file.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_extend_init',`
	gen_require(`
		type initrc_t;
	')

	allow initrc_t dirsrvadmin_config_t:file read;
')

########################################
## <summary>
##	Exec dirsrv-admin programs.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_run_exec',`
	gen_require(`
		type dirsrvadmin_exec_t;
	')

	allow $1 dirsrvadmin_exec_t:dir search_dir_perms;
	can_exec($1,dirsrvadmin_exec_t)
')

########################################
## <summary>
##	Exec cgi programs.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_run_httpd_script_exec',`
	gen_require(`
		type httpd_dirsrvadmin_script_exec_t;
	')

	allow $1 httpd_dirsrvadmin_script_exec_t:dir search_dir_perms;
	can_exec($1, httpd_dirsrvadmin_script_exec_t)
')

########################################
## <summary>
##	Manage cgi programs.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_manage_httpd_script_exec',`
	gen_require(`
		type httpd_dirsrvadmin_script_exec_t;
	')

	allow $1 httpd_dirsrvadmin_script_exec_t:dir manage_dir_perms;
	allow $1 httpd_dirsrvadmin_script_exec_t:file manage_file_perms;
')

########################################
## <summary>
##	Read tmp files created by cgi programs.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_read_httpd_script_tmpfile',`
	gen_require(`
		type httpd_dirsrvadmin_script_rw_t;
	')

	allow $1 httpd_dirsrvadmin_script_rw_t:file r_file_perms;
')

########################################
## <summary>
##	Manage tmp files created by cgi programs.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_manage_httpd_script_tmpfile',`
	gen_require(`
		type httpd_dirsrvadmin_script_rw_t;
	')

	allow $1 httpd_dirsrvadmin_script_rw_t:file manage_file_perms;
')

########################################
## <summary>
##	Read dirsrv-adminserver configuration files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_read_config',`
	gen_require(`
		type dirsrvadmin_config_t;
	')

	allow $1 dirsrvadmin_config_t:dir r_dir_perms;
	allow $1 dirsrvadmin_config_t:file r_file_perms;
')

########################################
## <summary>
##	Manage dirsrv-adminserver configuration files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_manage_config',`
	gen_require(`
		type dirsrvadmin_config_t;
	')

	allow $1 dirsrvadmin_config_t:dir manage_dir_perms;
	allow $1 dirsrvadmin_config_t:file manage_file_perms;
')

########################################
## <summary>
##  Read and write to cgi program over an unix stream socket.
## </summary>
## <param name="domain">
##  <summary>
##  Domain allowed access.
##  </summary>
## </param>
#
interface(`dirsrvadmin_script_stream_rw',`
	gen_require(`
		type httpd_dirsrvadmin_script_t;
	')

	allow $1 httpd_dirsrvadmin_script_t:unix_stream_socket { read write };
')

########################################
## <summary>
##	Read migration inf file in sysadm home dir.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrvadmin_read_inffile',`
	ifdef(`targeted_policy',`
		gen_require(`
			type user_home_t, user_home_dir_t;
		')

		userdom_list_user_home_dirs(user, $1)
		allow $1 user_home_t:file r_file_perms;
	',`
		gen_require(`
			type sysadm_home_t;
		')

		userdom_list_sysadm_home_dirs($1)
		allow $1 sysadm_home_t:file r_file_perms;
	')
')


--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="dirsrv-admin.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dirsrv-admin.fc"

# Start script for daemon (domain entry point)
/usr/sbin/start-ds-admin		--	gen_context(system_u:object_r:dirsrvadmin_exec_t,s0)
/usr/sbin/stop-ds-admin			--	gen_context(system_u:object_r:dirsrvadmin_exec_t,s0)
/usr/sbin/restart-ds-admin		--	gen_context(system_u:object_r:dirsrvadmin_exec_t,s0)
# Configuration
/etc/dirsrv/admin-serv(/.*)?		gen_context(system_u:object_r:dirsrvadmin_config_t,s0)
# Log dir
/var/log/dirsrv/admin-serv(/.*)?	gen_context(system_u:object_r:httpd_log_t,s0)
# Pid
/var/run/dirsrv/admin-serv.*		gen_context(system_u:object_r:httpd_var_run_t,s0)
# cgi
/usr/lib/dirsrv/cgi-bin(/.*)?		gen_context(system_u:object_r:httpd_dirsrvadmin_script_exec_t,s0)
# Setup applications
/usr/sbin/migrate-ds-admin.pl 	--	gen_context(system_u:object_r:dirsrvadmin_setupexec_t,s0)
/usr/sbin/setup-ds-admin.pl		--	gen_context(system_u:object_r:dirsrvadmin_setupexec_t,s0)

--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="dirsrv.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dirsrv.fc"

# Daemon (domain entry point)
/usr/sbin/ns-slapd		--	gen_context(system_u:object_r:dirsrv_exec_t,s0)
# Setup applications
/usr/sbin/migrate-ds.pl --	gen_context(system_u:object_r:dirsrv_setupexec_t,s0)
/usr/sbin/setup-ds.pl	--	gen_context(system_u:object_r:dirsrv_setupexec_t,s0)
# Helper scripts
/usr/lib/dirsrv(/slapd-.*)?	gen_context(system_u:object_r:dirsrv_helper_exec_t,s0)
# Configuration
/etc/dirsrv(/slapd-.*)?	 	gen_context(system_u:object_r:dirsrv_config_t,s0)
# Db files
/var/lib/dirsrv(/.*)?		gen_context(system_u:object_r:dirsrv_db_t,s0)
# Lock files
/var/lock/dirsrv(/.*)?		gen_context(system_u:object_r:dirsrv_lock_t,s0)
# Log files
/var/log/dirsrv(/.*)?		gen_context(system_u:object_r:dirsrv_log_t,s0)
# var_run
/var/run/dirsrv(/.*)?		gen_context(system_u:object_r:dirsrv_var_run_t,s0)

--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="dirsrv.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dirsrv.if"

## <summary>Fedora Directory server, dirsrv</summary>

########################################
## <summary>
##	Execute dirsrv programs in the dirsrv_t domain.
## </summary>
## <param name="domain">
##	<summary>
##	The type of the process performing this action.
##	</summary>
## </param>
#
interface(`dirsrv_domtrans',`
	gen_require(`
		type dirsrv_t, dirsrv_exec_t;
	')

	allow $1 dirsrv_t:process signull;
	domain_auto_trans($1, dirsrv_exec_t, dirsrv_t)
	allow dirsrv_t $1:fd use;
	allow dirsrv_t $1:fifo_file rw_file_perms;
	allow dirsrv_t $1:process sigchld;
')

########################################
## <summary>
##	Execute dirsrv setup programs in the dirsrv_setup_t domain
##	and the system_r role. Strict policy.
## </summary>
## <param name="domain">
##	<summary>
##	Prefix of the domain performing this action.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to allow the domain.
##	</summary>
## </param>
#
interface(`dirsrv_setup_domtrans_strict',`
	gen_require(`
		type dirsrv_t, dirsrv_setup_t, dirsrv_setupexec_t;
		type $1_t, $1_devpts_t;
	')

	domain_auto_trans($1_t, dirsrv_setupexec_t, dirsrv_setup_t)
	allow dirsrv_setup_t $1_t:fd use;
	allow dirsrv_setup_t $1_t:process sigchld;
	allow dirsrv_setup_t $1_devpts_t:chr_file rw_term_perms;
	role $2 types dirsrv_setup_t;
	role_transition $2 dirsrv_setupexec_t system_r;
')

########################################
## <summary>
##	Execute dirsrv setup programs in the dirsrv_setup_t domain
##	and the system_r role. Targeted policy.
## </summary>
## <param name="domain">
##	<summary>
##	Prefix of the domain performing this action.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to allow the domain.
##	</summary>
## </param>
#
interface(`dirsrv_setup_domtrans_targeted',`
	gen_require(`
		type dirsrv_setupexec_t, dirsrv_setup_t;
	')

	domain_auto_trans($1, dirsrv_setupexec_t, dirsrv_setup_t)
')

########################################
## <summary>
##	Extend httpd domain for dirsrv.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_extend_httpd',`
	gen_require(`
		type httpd_t, httpd_tmp_t;
	')

	allow $1 httpd_t:fifo_file { write read };
	allow $1 httpd_t:unix_stream_socket { ioctl getattr read write };
	allow $1 httpd_tmp_t:file { read write };
	apache_use_fds($1)
')

########################################
## <summary>
##	Read setup log files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_read_setuplog',`
	gen_require(`
		type dirsrv_setuplog_t;
	')

	files_search_tmp($1)
	allow $1 dirsrv_setuplog_t:file r_file_perms;
')

########################################
## <summary>
##	Read the contents of Directory server
##	database directories.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_list_db',`
	gen_require(`
		type dirsrv_db_t;
	')

	allow $1 dirsrv_db_t:dir r_dir_perms;
')

########################################
## <summary>
##	Manage the contents of Directory server
##	database directories.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_manage_db',`
	gen_require(`
		type dirsrv_db_t;
	')

	allow $1 dirsrv_db_t:dir manage_dir_perms;
	allow $1 dirsrv_db_t:file manage_file_perms;
')

########################################
## <summary>
##	Read Directory server configuration files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_read_config',`
	gen_require(`
		type dirsrv_config_t;
	')

	allow $1 dirsrv_config_t:dir r_dir_perms;
	allow $1 dirsrv_config_t:file r_file_perms;
')

########################################
## <summary>
##	Manage Directory server configuration files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_manage_config',`
	gen_require(`
		type dirsrv_config_t;
	')

	allow $1 dirsrv_config_t:dir manage_dir_perms;
	allow $1 dirsrv_config_t:file manage_file_perms;
')

########################################
## <summary>
##	Read Directory server log files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_list_log',`
	gen_require(`
		type dirsrv_log_t;
	')

	allow $1 dirsrv_log_t:dir r_dir_perms;
')

########################################
## <summary>
##	Manage Directory server log files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_manage_log',`
	gen_require(`
		type dirsrv_log_t;
	')

	allow $1 dirsrv_log_t:dir manage_dir_perms;
	allow $1 dirsrv_log_t:file manage_file_perms;
')

########################################
## <summary>
##	Read Directory server lock files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_list_lock',`
	gen_require(`
		type dirsrv_lock_t;
	')

	allow $1 dirsrv_lock_t:dir r_dir_perms;
')

########################################
## <summary>
##	Manage Directory server lock files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_manage_lock',`
	gen_require(`
		type dirsrv_lock_t;
	')

	allow $1 dirsrv_lock_t:dir manage_dir_perms;
	allow $1 dirsrv_lock_t:file manage_file_perms;
')

########################################
## <summary>
##	Read Directory server var_run files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_list_var_run',`
	gen_require(`
		type dirsrv_var_run_t;
	')

	allow $1 dirsrv_var_run_t:dir r_dir_perms;
')

########################################
## <summary>
##	Manage Directory server var_run files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_manage_var_run',`
	gen_require(`
		type dirsrv_var_run_t;
	')

	allow $1 dirsrv_var_run_t:dir manage_dir_perms;
	allow $1 dirsrv_var_run_t:file manage_file_perms;
	allow $1 dirsrv_var_run_t:sock_file manage_file_perms;
	# Allow creating a dir in /var/run with this type
	files_pid_filetrans($1, dirsrv_var_run_t, dir)
')

########################################
## <summary>
##	Exec Directory server helper programs.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_run_helper_exec',`
	gen_require(`
		type dirsrv_helper_exec_t;
	')

	allow $1 dirsrv_helper_exec_t:dir search_dir_perms;
	can_exec($1,dirsrv_helper_exec_t)
')

########################################
## <summary>
##	Manage Directory server helper programs.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_manage_helper_exec',`
	gen_require(`
		type dirsrv_helper_exec_t;
	')

	allow $1 dirsrv_helper_exec_t:dir manage_dir_perms;
	allow $1 dirsrv_helper_exec_t:file { manage_file_perms rw_file_perms };
')

########################################
## <summary>
##  Allow caller to signal dirsrv.
## </summary>
## <param name="domain">
##	<summary>
##	Domain to not audit.
##	</summary>
## </param>
#
interface(`dirsrv_signal',`
	gen_require(`
		type dirsrv_t;
	')

	allow $1 dirsrv_t:process signal;
')


########################################
## <summary>
##	Send a null signal to dirsrv.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`dirsrv_signull',`
	gen_require(`
		type dirsrv_t;
	')

	allow $1 dirsrv_t:process signull;
')

--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="dirsrv.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dirsrv.te"

policy_module(dirsrv,1.0.0) 

########################################
#
# Declarations for daemon
#

## Create domain for daemon
type dirsrv_t;
domain_type(dirsrv_t)

## Type for the daemon
type dirsrv_exec_t;
files_type(dirsrv_exec_t)
# Start from initrc
init_domain(dirsrv_t, dirsrv_exec_t)
init_daemon_domain(dirsrv_t, dirsrv_exec_t)
role system_r types dirsrv_t;

## Type for helper programs
type dirsrv_helper_exec_t;
files_type(dirsrv_helper_exec_t);

## Type for configuration files
type dirsrv_config_t;
files_config_file(dirsrv_config_t)

## Type for db files
type dirsrv_db_t;
files_type(dirsrv_db_t)

## Type for lock files
type dirsrv_lock_t;
files_lock_file(dirsrv_lock_t)
files_lock_filetrans(dirsrv_t, dirsrv_lock_t, {file dir})

## Type for log files
type dirsrv_log_t;
logging_log_file(dirsrv_log_t)

## Type for var_run file
type dirsrv_var_run_t;
files_pid_file(dirsrv_var_run_t)
files_pid_filetrans(dirsrv_t, dirsrv_var_run_t, {file dir})

########################################
#
# Declarations for setup programs
#

## Domain for setup program
type dirsrv_setup_t;
domain_type(dirsrv_setup_t)
role sysadm_r types dirsrv_setup_t;

## Type for setup program
type dirsrv_setupexec_t;
files_type(dirsrv_setupexec_t)
domain_entry_file(dirsrv_setup_t, dirsrv_setupexec_t)

## Type for tmp files setup creates
type dirsrv_setuplog_t;
files_tmp_file(dirsrv_setuplog_t)
files_tmp_filetrans(dirsrv_setup_t, dirsrv_setuplog_t, file)
files_tmp_filetrans(dirsrv_t, dirsrv_setuplog_t, file)

########################################
#
# Local policy for the daemon
#

## Executable
allow dirsrv_t self:capability { chown dac_override fowner setuid sys_nice setgid };
allow dirsrv_t self:process { setsched getsched signull };
allow dirsrv_t self:fifo_file { write read };
allow dirsrv_t self:sem { create getattr associate unix_read unix_write };
## Config
allow dirsrv_t dirsrv_config_t:file { getattr read create_file_perms };
allow dirsrv_t dirsrv_config_t:dir create_dir_perms;
## Database files
allow dirsrv_t dirsrv_db_t:dir manage_dir_perms;
allow dirsrv_t dirsrv_db_t:file manage_file_perms;
# Allow search in /var/lib
files_list_var_lib(dirsrv_t)
## Manage locks
allow dirsrv_t dirsrv_lock_t:dir manage_dir_perms;
allow dirsrv_t dirsrv_lock_t:file manage_file_perms;
## Logging
allow dirsrv_t dirsrv_log_t:file { create rename setattr manage_file_perms };
allow dirsrv_t dirsrv_log_t:dir { setattr rw_dir_perms };
allow dirsrv_t self:unix_dgram_socket create_socket_perms;
# Allow search in /var/log
logging_search_logs(dirsrv_t)
## var_run
allow dirsrv_t dirsrv_var_run_t:file manage_file_perms;
allow dirsrv_t dirsrv_var_run_t:dir rw_dir_perms;
## Helper programs
dirsrv_run_helper_exec(dirsrv_t)
## Setup log
dirsrv_read_setuplog(dirsrv_t)
dirsrvadmin_read_setuplog(dirsrv_t)
## Files in /tmp, created by setup app
allow dirsrv_t dirsrv_setuplog_t:file manage_file_perms;

## When restarted from cgi script the dirsrv need to communicate back
dirsrvadmin_script_stream_rw(dirsrv_t)
# dirsrv need some permissions that has no interface in the apache policy
dirsrv_extend_httpd(dirsrv_t)
dirsrvadmin_manage_httpd_script_tmpfile(dirsrv_t)

## Allow networking
corenet_tcp_bind_ldap_port(dirsrv_t)
corenet_tcp_sendrecv_ldap_port(dirsrv_t)
corenet_sendrecv_ldap_server_packets(dirsrv_t)
corenet_tcp_bind_unspec_node(dirsrv_t)
corenet_tcp_bind_inaddr_any_node(dirsrv_t)
kernel_sendrecv_unlabeled_packets(dirsrv_t)
allow dirsrv_t self:tcp_socket create_stream_socket_perms;
allow dirsrv_t self:udp_socket create_socket_perms;

## Misc interfaces			
# Access to shared libraries
libs_use_ld_so(dirsrv_t)
libs_use_shared_libs(dirsrv_t)
files_exec_usr_files(dirsrv_t)
# Read locale
miscfiles_read_localization(dirsrv_t)
# Read etc
files_read_etc_files(dirsrv_t)
sysnet_read_config(dirsrv_t)
# Allow using syslog
logging_send_syslog_msg(dirsrv_t)
# Search sbin
corecmd_search_sbin(dirsrv_t)
# Allow read urandom
dev_read_urand(dirsrv_t)
# Allow listing /tmp
files_list_tmp(dirsrv_t)
# Allow read /usr/tmp
files_read_usr_symlinks(dirsrv_t)
# Allow stat file system
fs_getattr_xattr_fs(dirsrv_t)
# Allow read proc
kernel_read_system_state(dirsrv_t)

# Strict policy
ifdef(`strict_policy',`
	# Daemon search for plugins in cwd
	userdom_dontaudit_search_sysadm_home_dirs(dirsrv_t)
')

# In targeted policy 
ifdef(`targeted_policy',`
	files_read_generic_tmp_files(dirsrv_t)
	userdom_dontaudit_search_generic_user_home_dirs(dirsrv_t)
')

########################################
#
# Local policy for setup programs
#

## Transtion into dirsrv domain when running setup
# Should be in userdomain
ifdef(`strict_policy',`
	dirsrv_setup_domtrans_strict(sysadm, sysadm_r)
')
# A similar policy should be in unconfined
ifdef(`targeted_policy',`
	dirsrv_setup_domtrans_targeted(unconfined_t)
')
seutil_use_newrole_fds(dirsrv_setup_t)

## Executable
allow dirsrv_setup_t self:capability { sys_nice chown fsetid fowner kill net_bind_service dac_override };
allow dirsrv_setup_t self:fifo_file { read write getattr ioctl };
allow dirsrv_setup_t self:process { setsched getsched };
allow dirsrv_setup_t self:tcp_socket { bind create ioctl };

# Start daemon from setup program
dirsrv_domtrans(dirsrv_setup_t)
## Manage db dir
dirsrv_manage_db(dirsrv_setup_t)
## Manage configuration
dirsrv_manage_config(dirsrv_setup_t)
## Manage log dir
dirsrv_manage_log(dirsrv_setup_t)
## Manage lock dir
dirsrv_manage_lock(dirsrv_setup_t)
## Manage var_run files
dirsrv_manage_var_run(dirsrv_setup_t)
## Manage helper programs
dirsrv_manage_helper_exec(dirsrv_setup_t)
dirsrv_run_helper_exec(dirsrv_setup_t)
## Files in /tmp
allow dirsrv_setup_t dirsrv_setuplog_t:file manage_file_perms;

## Networking
# Connect server using ldap
corenet_tcp_bind_inaddr_any_node(dirsrv_setup_t)
corenet_tcp_bind_ldap_port(dirsrv_setup_t)

## Misc interfaces			
# Access to shared libraries
libs_use_ld_so(dirsrv_setup_t)
libs_use_shared_libs(dirsrv_setup_t)
# Read locale
miscfiles_read_localization(dirsrv_setup_t)
# mtab
files_dontaudit_read_etc_runtime_files(dirsrv_setup_t)
# Execute 
corecmd_exec_bin(dirsrv_setup_t)
corecmd_exec_sbin(dirsrv_setup_t)
corecmd_exec_shell(dirsrv_setup_t)
# Read /usr/share
files_read_usr_files(dirsrv_setup_t)
# Allow read urandom
dev_read_urand(dirsrv_setup_t)
# Read proc
kernel_read_net_sysctls(dirsrv_setup_t)
kernel_read_sysctl(dirsrv_setup_t)
kernel_read_system_state(dirsrv_setup_t)
kernel_search_network_sysctl(dirsrv_setup_t)
# Stat shadow
auth_read_shadow(dirsrv_setup_t)
# Exec nsswitch.conf
files_exec_etc_files(dirsrv_setup_t)
# Find dirsrv dirs
files_search_locks(dirsrv_setup_t)
files_search_var_lib(dirsrv_setup_t)
logging_search_logs(dirsrv_setup_t)
# Allow stat file system
fs_getattr_xattr_fs(dirsrv_setup_t)
sysnet_read_config(dirsrv_setup_t)
term_search_ptys(dirsrv_setup_t)

optional_policy(`
	nscd_read_pid(dirsrv_setup_t)
')

# Strict policy
ifdef(`strict_policy',`
	# Read cwd (/root)
	userdom_list_sysadm_home_dirs(dirsrv_setup_t)
')

# In targeted policy 
ifdef(`targeted_policy',`
	term_use_generic_ptys(dirsrv_setup_t)
	# Read cwd (/root)
	userdom_list_user_home_dirs(user,dirsrv_setup_t)
	userdom_search_generic_user_home_dirs(dirsrv_setup_t)
')

--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/x-java;
  charset="utf-8";
  name="dirsrv-admin.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dirsrv-admin.te"

policy_module(dirsrv-admin,1.0.0) 

########################################
#
# Declarations for the daemon
#

type dirsrvadmin_t;
domain_type(dirsrvadmin_t)

## Create a dirsrvadmin_exec_t domain to transition to httpd_t.
type dirsrvadmin_exec_t;
files_type(dirsrvadmin_exec_t)
# Start from initrc
init_domain(dirsrvadmin_t, dirsrvadmin_exec_t)
init_daemon_domain(dirsrvadmin_t, dirsrvadmin_exec_t)
role system_r types dirsrvadmin_t;

## Keep configuration files in a private domain
type dirsrvadmin_config_t;
files_type(dirsrvadmin_config_t)

########################################
#
# Declarations for setup programs
#

## Domain for setup program
type dirsrvadmin_setup_t;
domain_type(dirsrvadmin_setup_t)
role sysadm_r types dirsrvadmin_setup_t;

## Entry file type for setup program
type dirsrvadmin_setupexec_t;
files_type(dirsrvadmin_setupexec_t)
domain_entry_file(dirsrvadmin_setup_t, dirsrvadmin_setupexec_t)

## Type for tmp files setup creates
type dirsrvadmin_setuplog_t;
files_tmp_file(dirsrvadmin_setuplog_t)
files_tmp_filetrans(dirsrvadmin_setup_t, dirsrvadmin_setuplog_t, file)
files_tmp_filetrans(dirsrvadmin_t, dirsrvadmin_setuplog_t, file)

########################################
#
# Local policy for the daemon
#

## Start httpd in httpd_t domain
# Transition to httpd domain
apache_domtrans(dirsrvadmin_t)
# disrv-admin require some interfaces that doesn't exist in httpd_t
dirsrvadmin_extend_httpd(dirsrvadmin_t)
# The initscript for dirsrv-admin searches in a private conf file.
# Extend the init domain to allow the search.
dirsrvadmin_extend_init(dirsrvadmin_t)

## Before transition to httpd domain
allow dirsrvadmin_t self:fifo_file { write read getattr };
allow dirsrvadmin_t self:capability { dac_read_search dac_override sys_tty_config };
logging_search_logs(dirsrvadmin_t)
corecmd_exec_bin(dirsrvadmin_t)
libs_exec_ld_so(dirsrvadmin_t)
corecmd_read_bin_symlinks(dirsrvadmin_t)
corecmd_search_bin(dirsrvadmin_t)
corecmd_shell_entry_type(dirsrvadmin_t)
files_exec_etc_files(dirsrvadmin_t)
kernel_read_system_state(dirsrvadmin_t)
# Access to shared libraries
libs_use_ld_so(dirsrvadmin_t)
libs_use_shared_libs(dirsrvadmin_t)
# Read locale
miscfiles_read_localization(dirsrvadmin_t)
# In strict policy
ifdef(`strict_policy',`
	# Read cwd (/root)
	userdom_dontaudit_search_sysadm_home_dirs(dirsrvadmin_t)
')
# In targeted policy 
ifdef(`targeted_policy',`
	# Read cwd (/root)
	userdom_dontaudit_search_generic_user_home_dirs(dirsrvadmin_t)
')

## cgi content (setsebool -P httpd_enable_cgi on)
# Create a domain for the cgi scripts
apache_content_template(dirsrvadmin)
# Cgi scripts require some interfaces that doesn't exist in httpd_t
dirsrvadmin_script_extend_httpd(httpd_dirsrvadmin_script_t)
allow httpd_dirsrvadmin_script_t self:process { getsched getpgid };
allow httpd_dirsrvadmin_script_t self:capability { sys_nice kill dac_read_search dac_override };
allow httpd_dirsrvadmin_script_t self:tcp_socket { write getopt create read connect };
allow httpd_dirsrvadmin_script_t self:udp_socket { write read create connect getattr };
# The cgi scripts must be able to manage dirsrv-admin
dirsrvadmin_run_exec(httpd_dirsrvadmin_script_t)
# The cgi scripts must be able to manage the dirsrv
dirsrv_manage_log(httpd_dirsrvadmin_script_t)
dirsrv_run_helper_exec(httpd_dirsrvadmin_script_t)
dirsrv_manage_var_run(httpd_dirsrvadmin_script_t)
dirsrv_signal(httpd_dirsrvadmin_script_t)
dirsrv_signull(httpd_dirsrvadmin_script_t)
apache_signal(httpd_dirsrvadmin_script_t)
apache_read_log(httpd_dirsrvadmin_script_t)
# dirsrv-admin may run on any port
corenet_sendrecv_unlabeled_packets(httpd_dirsrvadmin_script_t)
corenet_tcp_connect_generic_port(httpd_dirsrvadmin_script_t)
corenet_tcp_connect_ldap_port(httpd_dirsrvadmin_script_t)
sysnet_read_config(httpd_dirsrvadmin_script_t)

# When run from idm-console
allow httpd_dirsrvadmin_script_t self:capability { setuid net_bind_service setgid chown };
allow httpd_dirsrvadmin_script_t self:tcp_socket { bind getattr setopt accept listen shutdown };
allow httpd_dirsrvadmin_script_t self:unix_dgram_socket { write create connect };
allow httpd_dirsrvadmin_script_t self:netlink_route_socket { write getattr read bind create nlmsg_read };
allow httpd_dirsrvadmin_script_t self:sem { write destroy create unix_write setattr };
dirsrv_domtrans(httpd_dirsrvadmin_script_t)
dirsrv_manage_config(httpd_dirsrvadmin_script_t)
dirsrv_manage_db(httpd_dirsrvadmin_script_t)
dirsrvadmin_manage_config(httpd_dirsrvadmin_script_t)
# read magic file
apache_read_config(httpd_dirsrvadmin_script_t)
# Transition to httpd domain when running restart
apache_domtrans(httpd_dirsrvadmin_script_t)
files_search_var_lib(httpd_dirsrvadmin_script_t)
files_search_var_lib(httpd_dirsrvadmin_script_t)
# dirsrv-admin may run on any port
corenet_tcp_bind_generic_port(httpd_dirsrvadmin_script_t)
corenet_tcp_bind_inaddr_any_node(httpd_dirsrvadmin_script_t)
kernel_read_kernel_sysctls(httpd_dirsrvadmin_script_t)

########################################
#
# Local policy for setup programs
# setup-ds-admin.pl will configure both dirsrv and dirsrv-admin
#

## Transtion into dirsrv domain when running setup in strict
# Should be in userdomain
ifdef(`strict_policy',`
	dirsrvadmin_setup_domtrans_strict(sysadm, sysadm_r)
')
# A similar policy should be in unconfined
ifdef(`targeted_policy',`
	dirsrvadmin_setup_domtrans_targeted(unconfined_t)
')
seutil_use_newrole_fds(dirsrvadmin_setup_t)

allow dirsrvadmin_setup_t self:capability { net_bind_service dac_override kill sys_nice chown fsetid fowner };
allow dirsrvadmin_setup_t self:fifo_file { read write ioctl getattr };
allow dirsrvadmin_setup_t self:process { setsched setexec getsched };
allow dirsrvadmin_setup_t self:tcp_socket { ioctl write connect getopt read bind create };
allow dirsrvadmin_setup_t self:udp_socket { write read create connect getattr };

# Run cgi
dirsrvadmin_run_httpd_script_exec(dirsrvadmin_setup_t)

# Start httpd from setup program, in http_t domain
apache_domtrans(dirsrvadmin_setup_t)
dirsrvadmin_run_exec(dirsrvadmin_setup_t)
# Start dirsrv daemon from setup program
dirsrv_domtrans(dirsrvadmin_setup_t)
# Manage db dir for dirsrv
dirsrv_manage_db(dirsrvadmin_setup_t)
# Manage configuration for dirsrv
dirsrv_manage_config(dirsrvadmin_setup_t)
# Manage configuration for dirsrv-admin
dirsrvadmin_manage_config(dirsrvadmin_setup_t)
# Manage log dir for dirsrv
dirsrv_manage_log(dirsrvadmin_setup_t)
# Manage lock dir for dirsrv
dirsrv_manage_lock(dirsrvadmin_setup_t)
# Manage var_run files for dirsrv
dirsrv_manage_var_run(dirsrvadmin_setup_t)
# Manage helper programs for dirsrv
dirsrv_manage_helper_exec(dirsrvadmin_setup_t)
dirsrv_run_helper_exec(dirsrvadmin_setup_t)
# Files in /tmp
allow dirsrvadmin_setup_t dirsrvadmin_setuplog_t:file manage_file_perms;
# Read inffile i sysadm home dir
dirsrvadmin_read_inffile(dirsrvadmin_setup_t)

## Networking
# Connect ldapserver
corenet_sendrecv_unlabeled_packets(dirsrvadmin_setup_t)
corenet_tcp_bind_inaddr_any_node(dirsrvadmin_setup_t)
corenet_tcp_connect_ldap_port(dirsrvadmin_setup_t)
corenet_tcp_bind_ldap_port(dirsrvadmin_setup_t)
corenet_tcp_bind_generic_port(dirsrvadmin_setup_t)
corenet_tcp_connect_generic_port(dirsrvadmin_setup_t)

## Misc interfaces			
# Access to shared libraries
libs_use_ld_so(dirsrvadmin_setup_t)
libs_exec_ld_so(dirsrvadmin_setup_t)
libs_use_shared_libs(dirsrvadmin_setup_t)
# Read locale
miscfiles_read_localization(dirsrvadmin_setup_t)
# migrate-ds-admin.pl read in /opt
files_read_usr_files(dirsrvadmin_setup_t)
# Read proc
kernel_read_system_state(dirsrvadmin_setup_t)
kernel_read_net_sysctls(dirsrvadmin_setup_t)
kernel_read_sysctl(dirsrvadmin_setup_t)
kernel_search_network_sysctl(dirsrvadmin_setup_t)
# Execute 
corecmd_exec_bin(dirsrvadmin_setup_t)
corecmd_exec_sbin(dirsrvadmin_setup_t)
corecmd_exec_shell(dirsrvadmin_setup_t)
corecmd_read_bin_symlinks(dirsrvadmin_setup_t)
corecmd_search_bin(dirsrvadmin_setup_t)
corecmd_search_sbin(dirsrvadmin_setup_t)
# Allow read urandom
dev_read_urand(dirsrvadmin_setup_t)
# Exec nsswitch.conf
files_exec_etc_files(dirsrvadmin_setup_t)
# Exec cgi-scripts
libs_exec_lib_files(dirsrvadmin_setup_t)
# Find dirsrv dirs
files_search_locks(dirsrvadmin_setup_t)
files_search_var_lib(dirsrvadmin_setup_t)
# Find dirsrv log dir
logging_search_logs(dirsrvadmin_setup_t)
sysnet_read_config(dirsrvadmin_setup_t)
term_search_ptys(dirsrvadmin_setup_t)
# Read /etc/shadow !?
auth_read_shadow(dirsrvadmin_setup_t)
files_read_etc_runtime_files(dirsrvadmin_setup_t)
fs_getattr_xattr_fs(dirsrvadmin_setup_t)

optional_policy(`
	nscd_read_pid(dirsrvadmin_setup_t)
')

# In targeted policy 
ifdef(`targeted_policy',`
	files_read_generic_tmp_files(dirsrvadmin_setup_t)
	term_use_generic_ptys(dirsrvadmin_setup_t)
')


--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="fedora-idm-console.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fedora-idm-console.fc"



--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="fedora-idm-console.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fedora-idm-console.te"

policy_module(fedora-idm-console,1.0.0) 

########################################
#
# Declarations
#

type fedora-idm-console_t;
domain_type(fedora-idm-console_t)

########################################
#
# Local policy
#

# In strict policy we need to extend the java domain
ifdef(`strict_policy',`
	fedoraidmconsole_extend_java(user)
	## Misc interfaces			
	# Access to shared libraries
	libs_use_ld_so(fedora-idm-console_t)
	libs_use_shared_libs(fedora-idm-console_t)
	# Read locale
	miscfiles_read_localization(fedora-idm-console_t)
')

--Boundary-00=_CSr1HVGw71+RUeR
Content-Type: text/plain;
  charset="utf-8";
  name="fedora-idm-console.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fedora-idm-console.if"

## <summary>Java based fedora-idm-console</summary>

########################################
## <summary>
##	Extend java domain for fedora-idm-console.
## </summary>
## <param name="domain">
##	<summary>
##	Prefix of domain allowed access.
##	</summary>
## </param>
#
interface(`fedoraidmconsole_extend_java',`
	gen_require(`
		type $1_javaplugin_t;
		type $1_t, $1_xserver_tmp_t, $1_gconf_home_t, $1_home_ssh_t, $1_mozilla_home_t;
	')

	allow $1_javaplugin_t $1_t:process sigchld;
	allow $1_t $1_javaplugin_t:process { signal ptrace };
	allow $1_javaplugin_t self:netlink_route_socket { write getattr read bind create nlmsg_read };
	allow $1_javaplugin_t self:tcp_socket { accept listen };
	allow $1_javaplugin_t $1_xserver_tmp_t:dir search;
	allow $1_javaplugin_t $1_xserver_tmp_t:sock_file write;
	dirsrv_list_db($1_javaplugin_t)
	corecmd_exec_bin($1_javaplugin_t)
	corenet_tcp_bind_inaddr_any_node($1_javaplugin_t)
	files_read_var_files($1_javaplugin_t)

	# Sun java check out some dirs, there is probably more than this
	dontaudit $1_javaplugin_t $1_gconf_home_t:dir getattr;
	dontaudit $1_javaplugin_t $1_home_ssh_t:dir getattr;
	dontaudit $1_javaplugin_t $1_mozilla_home_t:dir getattr;
')

--Boundary-00=_CSr1HVGw71+RUeR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
