Message-ID: <45AFA10F.2030800@tresys.com>
Date: Thu, 18 Jan 2007 11:32:15 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC] 1/4 - Hierarchal apache policy for reference policy (te)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is an RFC for a hierarchal apache policy for reference policy. It 
is the complete .te file rather than a patch because the diff would be 
very large and there should be no functional changes, only changes to 
make the type namespace hierarchal

------------------------------------------

policy_module(apache,2.0.0)

#
# NOTES:
#  This policy will work with SUEXEC enabled as part of the Apache
#  configuration. However, the user CGI scripts will run under the
#  system_u:system_r:apache_t.$1_script domain where $1 is the domain of the
#  of the creating user.
#
#  The user CGI scripts must be labeled with the apache_t.$1_script_exec
#  type, and the directory containing the scripts should also be labeled
#  with these types. This policy allows user_r role to perform that
#  relabeling. If it is desired that only sysadm_r should be able to relabel
#  the user CGI scripts, then relabel rule for user_r should be removed.
#

########################################
#
# Declarations
#

# web content metapolicy types
attribute apache_content_policy_type;

# general apache metapolicy type
type apache_policy_t;

attribute httpdcontent;

# domains that can exec all users scripts
attribute httpd_exec_scripts;

attribute httpd_script_exec_type;

# user script domains
attribute httpd_script_domains;

type apache_t, httpd_script_exec_type;
files_type(apache_t)
files_pid_file(apache_t)
files_lock_file(apache_t)
files_tmpfs_file(apache_t)
files_tmp_file(apache_t)
logging_log_file(apache_t)
domain_type(apache_t)
corecmd_shell_entry_type(apache_t)
init_daemon_domain(apache_t,apache_t)

type apache_t.daemon alias httpd_t;
type apache_t.daemon_exec alias httpd_exec_t;
init_daemon_domain(apache_t.daemon,apache_t.daemon_exec)
role system_r types apache_t.daemon;

# apache_t.daemon_cache is the type given to the /var/cache/httpd
# directory and the files under that directory
type apache_t.daemon_cache alias httpd_cache_t;
files_type(apache_t.daemon_cache)

# apache_t.config is the type given to the configuration files
type apache_t.config alias httpd_config_t;
files_type(apache_t.config)

type apache_t.helper alias httpd_helper_t;
type apache_t.helper_exec alias httpd_helper_exec_t;
domain_type(apache_t.helper)
domain_entry_file(apache_t.helper,apache_t.helper_exec)
role system_r types apache_t.helper;

type apache_t.lock alias httpd_lock_t;
files_lock_file(apache_t.lock)

type apache_t.log alias httpd_log_t;
logging_log_file(apache_t.log)

# apache_t.daemon_modules is the type given to module files (libraries)
# that come with Apache /etc/httpd/modules and /usr/lib/apache
type apache_t.daemon_modules  alias httpd_modules_t;
files_type(apache_t.daemon_modules)

type apache_t.php alias httpd_php_t;
type apache_t.php_exec alias httpd_php_exec_t;
domain_type(apache_t.php)
domain_entry_file(apache_t.php,apache_t.php_exec)
role system_r types apache_t.php;

type apache_t.php_tmp alias httpd_php_tmp_t;
files_tmp_file(apache_t.php_tmp)

type apache_t.rotatelogs alias httpd_rotatelogs_t;
type apache_t.rotatelogs_exec alias httpd_rotatelogs_exec_t;
init_daemon_domain(apache_t.rotatelogs, apache_t.rotatelogs_exec)

type apache_t.squirrelmail alias httpd_squirrelmail_t;
files_type(apache_t.squirrelmail)

# SUEXEC runs user scripts as their own user ID
type apache_t.suexec alias httpd_suexec_t;
type apache_t.suexec_exec alias httpd_suexec_exec_t;
domain_type(apache_t.suexec)
domain_entry_file(apache_t.suexec,apache_t.suexec_exec)
role system_r types apache_t.suexec;

type apache_t.suexec_tmp alias httpd_suexec_tmp_t;
files_tmp_file(apache_t.suexec_tmp)

# setup the system domain for system CGI scripts
apache_content_template(sys)

type apache_t.tmp alias httpd_tmp_t;
files_tmp_file(apache_t.tmp)

type apache_t.tmpfs alias httpd_tmpfs_t;
files_tmpfs_file(apache_t.tmpfs)

# for apache2 memory mapped files
type apache_t.var_lib alias httpd_var_lib_t;
files_type(apache_t.var_lib)

type apache_t.var_run  alias httpd_var_run_t;
files_pid_file(apache_t.var_run)

# File Type of squirrelmail attachments
type apache_t.squirrelmail_spool alias squirrelmail_spool_t;
files_tmp_file(apache_t.squirrelmail_spool)

# Unconfined domain for apache scripts.
# Only to be used as a last resort
type apache_unconfined_script_t alias httpd_unconfined_script_t;
type apache_unconfined_script_exec_t alias 
httpd_unconfined_script_exec_t; # customizable
domain_type(apache_unconfined_script_t)
domain_entry_file(apache_unconfined_script_t,apache_unconfined_script_exec_t)
role system_r types apache_unconfined_script_t;

########################################
#
# Apache parent policy
#

allow apache_t self:capability { chown dac_override kill setgid setuid 
sys_tty_config setuid setgid };
allow apache_t self:process ~{ ptrace setcurrent setexec setfscreate 
setrlimit execmem execstack execheap };
allow apache_t self:process { setsched signal_perms };
allow apache_t self:dir manage_dir_perms;
allow apache_t self:file { exec_file_perms manage_file_perms entrypoint };
allow apache_t self:lnk_file manage_lnk_file_perms;
allow apache_t self:fifo_file manage_fifo_file_perms;
allow apache_t self:sock_file manage_sock_file_perms;
allow apache_t self:fd use;
allow apache_t self:msgq create_msgq_perms;
allow apache_t self:msg { send receive };
allow apache_t self:sem create_sem_perms;
allow apache_t self:shm create_shm_perms;
allow apache_t self:unix_dgram_socket { create_socket_perms sendto };
allow apache_t self:unix_stream_socket { create_stream_socket_perms 
connectto };
allow apache_t self:netlink_route_socket r_netlink_socket_perms;
allow apache_t self:udp_socket create_socket_perms;
allow apache_t self:tcp_socket create_stream_socket_perms;

allow apache_t httpdcontent:dir manage_dir_perms;
allow apache_t httpdcontent:file { exec_file_perms manage_file_perms 
entrypoint };
allow apache_t httpdcontent:lnk_file manage_lnk_file_perms;
domain_transition_pattern(apache_t, httpdcontent, apache_t)

domtrans_pattern(apache_t, apache_unconfined_script_exec_t, 
apache_unconfined_script_t)
allow apache_t apache_unconfined_script_t:process { signal sigkill 
sigstop };
allow apache_t apache_unconfined_script_exec_t:dir list_dir_perms;

domtrans_pattern(httpd_exec_scripts, apache_t, apache_t)

kernel_read_system_state(apache_t)
kernel_read_kernel_sysctls(apache_t)

corecmd_shell_domtrans(apache_t,apache_t)
corecmd_exec_all_executables(apache_t)
# execute perl
corecmd_exec_bin(apache_t)
corecmd_exec_sbin(apache_t)
corecmd_check_exec_shell(apache_t)

corenet_non_ipsec_sendrecv(apache_t)
corenet_tcp_sendrecv_all_if(apache_t)
corenet_udp_sendrecv_all_if(apache_t)
corenet_tcp_sendrecv_all_nodes(apache_t)
corenet_udp_sendrecv_all_nodes(apache_t)
corenet_tcp_sendrecv_all_ports(apache_t)
corenet_udp_sendrecv_all_ports(apache_t)
corenet_tcp_bind_all_nodes(apache_t)
corenet_tcp_bind_reserved_port(apache_t)
corenet_tcp_bind_portmap_port(apache_t)
corenet_tcp_bind_http_port(apache_t)
corenet_tcp_bind_http_cache_port(apache_t)
corenet_tcp_bind_ftp_port(apache_t)
corenet_tcp_connect_all_ports(apache_t)
corenet_sendrecv_http_server_packets(apache_t)
corenet_sendrecv_all_client_packets(apache_t)

dev_read_sysfs(apache_t)
dev_read_rand(apache_t)
dev_read_urand(apache_t)
dev_rw_crypto(apache_t)

domain_use_interactive_fds(apache_t)

files_exec_etc_files(apache_t)
files_read_etc_files(apache_t)
files_read_etc_runtime_files(apache_t)
files_search_home(apache_t)
files_list_mnt(apache_t)
files_read_usr_files(apache_t)
files_read_var_lib_files(apache_t)
files_read_var_lib_symlinks(apache_t)
files_search_spool(apache_t)
files_tmp_filetrans(apache_t,apache_t,{ dir file lnk_file sock_file 
fifo_file })
files_lock_filetrans(apache_t,apache_t,file)
files_pid_filetrans(apache_t,apache_t, { file sock_file })
files_var_lib_filetrans(apache_t,apache_t,file)

fs_getattr_all_fs(apache_t)
fs_search_auto_mountpoints(apache_t)
fs_exec_cifs_files(apache_t)
fs_read_cifs_files(apache_t)
fs_read_cifs_symlinks(apache_t)
fs_exec_nfs_files(apache_t)
fs_read_nfs_files(apache_t)
fs_read_nfs_symlinks(apache_t)
fs_tmpfs_filetrans(apache_t,apache_t,{ dir file lnk_file sock_file 
fifo_file })

term_dontaudit_use_console(apache_t)
term_use_controlling_term(apache_t)

auth_use_nsswitch(apache_t)

init_use_fds(apache_t)
init_use_script_ptys(apache_t)

libs_use_ld_so(apache_t)
libs_use_shared_libs(apache_t)
libs_exec_ld_so(apache_t)
libs_exec_lib_files(apache_t)

logging_send_syslog_msg(apache_t)
logging_log_filetrans(apache_t,apache_t,file)

miscfiles_read_localization(apache_t)
miscfiles_read_fonts(apache_t)
miscfiles_read_public_files(apache_t)
miscfiles_read_certs(apache_t)
miscfiles_manage_public_files(apache_t)

sysnet_read_config(apache_t)

userdom_search_all_users_home_dirs(apache_t)
userdom_use_unpriv_users_fds(apache_t)
userdom_use_sysadm_terms(apache_t)

ifdef(`targeted_policy',`
    userdom_search_generic_user_home_dirs(apache_t)
')

optional_policy(`
    calamaris_read_www_files(apache_t)
')

optional_policy(`
    clamav_domtrans_clamscan(apache_t)
')

optional_policy(`
    cron_system_entry(apache_t, apache_t)
')

optional_policy(`
    daemontools_service_domain(apache_t, apache_t)
')

optional_policy(`
    kerberos_use(apache_t)
')

optional_policy(`
    mailman_signal_cgi(apache_t)
    mailman_domtrans_cgi(apache_t)
    # should have separate types for public and private archives
    mailman_search_data(apache_t)
    mailman_read_archive(apache_t)
')

optional_policy(`
    mta_send_mail(apache_t)
')

optional_policy(`
    mysql_stream_connect(apache_t)
    mysql_rw_db_sockets(apache_t)
')

optional_policy(`
    nagios_read_config(apache_t)
    nagios_domtrans_cgi(apache_t)
')

optional_policy(`
    nis_use_ypbind_uncond(apache_t)
')

optional_policy(`
    nscd_socket_use(apache_t)
')

optional_policy(`
    openca_domtrans(apache_t)
    openca_signal(apache_t)
    openca_sigstop(apache_t)
    openca_kill(apache_t)
')

optional_policy(`
    # Allow httpd to work with postgresql
    postgresql_stream_connect(apache_t)
')

optional_policy(`
    seutil_sigchld_newrole(apache_t)
')

optional_policy(`
    udev_read_db(apache_t)
')

optional_policy(`
    yam_read_content(apache_t)
')

ifdef(`TODO',`
#
# We need optionals to be able to be within booleans to make this work
#
auth_domtrans_chk_passwd(apache_t)
')

########################################
#
# Apache server local policy
#

allow apache_t.daemon self:capability { chown dac_override kill setgid 
setuid sys_tty_config };
dontaudit apache_t.daemon self:capability { net_admin sys_tty_config };
allow apache_t.daemon self:process ~{ ptrace setcurrent setexec 
setfscreate setrlimit execmem execstack execheap };
allow apache_t.daemon self:fd use;
allow apache_t.daemon self:sock_file read_sock_file_perms;
allow apache_t.daemon self:fifo_file rw_fifo_file_perms;
allow apache_t.daemon self:shm create_shm_perms;
allow apache_t.daemon self:sem create_sem_perms;
allow apache_t.daemon self:msgq create_msgq_perms;
allow apache_t.daemon self:msg { send receive };
allow apache_t.daemon self:unix_dgram_socket { create_socket_perms sendto };
allow apache_t.daemon self:unix_stream_socket { 
create_stream_socket_perms connectto };
allow apache_t.daemon self:tcp_socket create_stream_socket_perms;
allow apache_t.daemon self:udp_socket create_socket_perms;

# Allow apache_t.daemon to put files in /var/cache/httpd etc
manage_dirs_pattern(apache_t.daemon,apache_t.daemon_cache,apache_t.daemon_cache)
manage_files_pattern(apache_t.daemon,apache_t.daemon_cache,apache_t.daemon_cache)
manage_lnk_files_pattern(apache_t.daemon,apache_t.daemon_cache,apache_t.daemon_cache)

# Allow the apache_t.daemon to read the web servers config files
list_dirs_pattern(apache_t.daemon,apache_t.config,apache_t.config)
read_files_pattern(apache_t.daemon,apache_t.config,apache_t.config)
read_lnk_files_pattern(apache_t.daemon,apache_t.config,apache_t.config)

can_exec(apache_t.daemon, apache_t.daemon_exec)

allow apache_t.daemon apache_t.lock:file manage_file_perms;
files_lock_filetrans(apache_t.daemon,apache_t.lock,file)

allow apache_t.daemon apache_t.log:dir setattr;
create_files_pattern(apache_t.daemon,apache_t.log,apache_t.log)
append_files_pattern(apache_t.daemon,apache_t.log,apache_t.log)
read_lnk_files_pattern(apache_t.daemon,apache_t.log,apache_t.log)
# cjp: need to refine create interfaces to
# cut this back to add_name only
logging_log_filetrans(apache_t.daemon,apache_t.log,file)

allow apache_t.daemon apache_t.daemon_modules:dir list_dir_perms;
mmap_files_pattern(apache_t.daemon,apache_t.daemon_modules,apache_t.daemon_modules)
read_lnk_files_pattern(apache_t.daemon,apache_t.daemon_modules,apache_t.daemon_modules)

manage_dirs_pattern(apache_t.daemon,apache_t.squirrelmail,apache_t.squirrelmail)
manage_files_pattern(apache_t.daemon,apache_t.squirrelmail,apache_t.squirrelmail)
manage_lnk_files_pattern(apache_t.daemon,apache_t.squirrelmail,apache_t.squirrelmail)

allow apache_t.daemon apache_t.suexec_exec:file { getattr read };

allow apache_t.daemon apache_t.sys_content:dir list_dir_perms;
read_files_pattern(apache_t.daemon,apache_t.sys_content,apache_t.sys_content)
read_lnk_files_pattern(apache_t.daemon,apache_t.sys_content,apache_t.sys_content)

allow apache_t.daemon apache_t.sys_content:file r_file_perms;
allow apache_t.daemon apache_t.sys_content:lnk_file r_file_perms;

manage_dirs_pattern(apache_t.daemon,apache_t.tmp,apache_t.tmp)
manage_files_pattern(apache_t.daemon,apache_t.tmp,apache_t.tmp)
files_tmp_filetrans(apache_t.daemon, apache_t.tmp, { file dir })

manage_dirs_pattern(apache_t.daemon,apache_t.tmpfs,apache_t.tmpfs)
manage_files_pattern(apache_t.daemon,apache_t.tmpfs,apache_t.tmpfs)
manage_lnk_files_pattern(apache_t.daemon,apache_t.tmpfs,apache_t.tmpfs)
manage_fifo_files_pattern(apache_t.daemon,apache_t.tmpfs,apache_t.tmpfs)
manage_sock_files_pattern(apache_t.daemon,apache_t.tmpfs,apache_t.tmpfs)
fs_tmpfs_filetrans(apache_t.daemon,apache_t.tmpfs,{ dir file lnk_file 
sock_file fifo_file })

manage_files_pattern(apache_t.daemon,apache_t.var_lib,apache_t.var_lib)
files_var_lib_filetrans(apache_t.daemon,apache_t.var_lib,file)

manage_files_pattern(apache_t.daemon,apache_t.var_run,apache_t.var_run)
manage_sock_files_pattern(apache_t.daemon,apache_t.var_run,apache_t.var_run)
files_pid_filetrans(apache_t.daemon,apache_t.var_run, { file sock_file })

manage_dirs_pattern(apache_t.daemon,apache_t.squirrelmail_spool,apache_t.squirrelmail_spool)
manage_files_pattern(apache_t.daemon,apache_t.squirrelmail_spool,apache_t.squirrelmail_spool)
manage_lnk_files_pattern(apache_t.daemon,apache_t.squirrelmail_spool,apache_t.squirrelmail_spool)

kernel_read_kernel_sysctls(apache_t.daemon)
# for modules that want to access /proc/meminfo
kernel_read_system_state(apache_t.daemon)

corenet_non_ipsec_sendrecv(apache_t.daemon)
corenet_tcp_sendrecv_all_if(apache_t.daemon)
corenet_udp_sendrecv_all_if(apache_t.daemon)
corenet_tcp_sendrecv_all_nodes(apache_t.daemon)
corenet_udp_sendrecv_all_nodes(apache_t.daemon)
corenet_tcp_sendrecv_all_ports(apache_t.daemon)
corenet_udp_sendrecv_all_ports(apache_t.daemon)
corenet_tcp_bind_all_nodes(apache_t.daemon)
corenet_tcp_bind_http_port(apache_t.daemon)
corenet_tcp_bind_http_cache_port(apache_t.daemon)
corenet_sendrecv_http_server_packets(apache_t.daemon)

dev_read_sysfs(apache_t.daemon)
dev_read_rand(apache_t.daemon)
dev_read_urand(apache_t.daemon)
dev_rw_crypto(apache_t.daemon)

fs_getattr_all_fs(apache_t.daemon)
fs_search_auto_mountpoints(apache_t.daemon)

term_dontaudit_use_console(apache_t.daemon)

auth_use_nsswitch(apache_t.daemon)

# execute perl
corecmd_exec_bin(apache_t.daemon)
corecmd_exec_sbin(apache_t.daemon)
corecmd_check_exec_shell(apache_t.daemon)

domain_use_interactive_fds(apache_t.daemon)

files_read_usr_files(apache_t.daemon)
files_list_mnt(apache_t.daemon)
files_search_spool(apache_t.daemon)
files_read_var_lib_files(apache_t.daemon)
files_search_home(apache_t.daemon)
files_getattr_home_dir(apache_t.daemon)
# for modules that want to access /etc/mtab
files_read_etc_runtime_files(apache_t.daemon)
# Allow apache_t.daemon to have access to files such as nisswitch.conf
files_read_etc_files(apache_t.daemon)
# for tomcat
files_read_var_lib_symlinks(apache_t.daemon)

init_use_fds(apache_t.daemon)
init_use_script_ptys(apache_t.daemon)

libs_use_ld_so(apache_t.daemon)
libs_use_shared_libs(apache_t.daemon)
libs_read_lib_files(apache_t.daemon)

logging_send_syslog_msg(apache_t.daemon)

miscfiles_read_localization(apache_t.daemon)
miscfiles_read_fonts(apache_t.daemon)
miscfiles_read_public_files(apache_t.daemon)
miscfiles_read_certs(apache_t.daemon)

seutil_dontaudit_search_config(apache_t.daemon)

sysnet_read_config(apache_t.daemon)

userdom_use_unpriv_users_fds(apache_t.daemon)

mta_send_mail(apache_t.daemon)

ifdef(`targeted_policy',`
    term_dontaudit_use_unallocated_ttys(apache_t.daemon)
    term_dontaudit_use_generic_ptys(apache_t.daemon)
    files_dontaudit_read_root_files(apache_t.daemon)

    tunable_policy(`httpd_enable_homedirs',`
        userdom_search_generic_user_home_dirs(apache_t.daemon)
    ')
')

tunable_policy(`allow_httpd_anon_write',`
    miscfiles_manage_public_files(apache_t.daemon)
')

ifdef(`TODO', `
#
# We need optionals to be able to be within booleans to make this work
#
tunable_policy(`allow_httpd_mod_auth_pam',`
    auth_domtrans_chk_passwd(apache_t.daemon)
')
')

tunable_policy(`httpd_can_network_connect',`
    corenet_tcp_connect_all_ports(apache_t.daemon)
')

tunable_policy(`httpd_can_network_connect_db',`
    # allow httpd to connect to mysql/posgresql
    corenet_tcp_connect_postgresql_port(apache_t.daemon)
    corenet_tcp_connect_mysqld_port(apache_t.daemon)
    corenet_sendrecv_postgresql_client_packets(apache_t.daemon)
    corenet_sendrecv_mysqld_client_packets(apache_t.daemon)
')

tunable_policy(`httpd_can_network_relay',`
    # allow httpd to work as a relay
    corenet_tcp_connect_gopher_port(apache_t.daemon)
    corenet_tcp_connect_ftp_port(apache_t.daemon)
    corenet_tcp_connect_http_port(apache_t.daemon)
    corenet_tcp_connect_http_cache_port(apache_t.daemon)
    corenet_sendrecv_gopher_client_packets(apache_t.daemon)
    corenet_sendrecv_ftp_client_packets(apache_t.daemon)
    corenet_sendrecv_http_client_packets(apache_t.daemon)
    corenet_sendrecv_http_cache_client_packets(apache_t.daemon)
')

tunable_policy(`httpd_enable_cgi',`
    domtrans_pattern(apache_t.daemon, apache_unconfined_script_exec_t, 
apache_unconfined_script_t)

    allow apache_t.daemon apache_unconfined_script_t:process { signal 
sigkill sigstop };
    allow apache_t.daemon apache_unconfined_script_exec_t:dir 
list_dir_perms;
')

tunable_policy(`httpd_enable_cgi && httpd_unified && 
httpd_builtin_scripting',`
    domtrans_pattern(apache_t.daemon, httpdcontent, apache_t.sys_script)

    manage_dirs_pattern(apache_t.daemon,httpdcontent,httpdcontent)
    manage_files_pattern(apache_t.daemon,httpdcontent,httpdcontent)
    manage_lnk_files_pattern(apache_t.daemon,httpdcontent,httpdcontent)
')

tunable_policy(`httpd_enable_ftp_server',`
    corenet_tcp_bind_ftp_port(apache_t.daemon)
')

tunable_policy(`httpd_enable_homedirs && use_nfs_home_dirs',`
    fs_read_nfs_files(apache_t.daemon)
    fs_read_nfs_symlinks(apache_t.daemon)
')

tunable_policy(`httpd_enable_homedirs && use_samba_home_dirs',`
    fs_read_cifs_files(apache_t.daemon)
    fs_read_cifs_symlinks(apache_t.daemon)
')

tunable_policy(`httpd_ssi_exec',`
    corecmd_shell_domtrans(apache_t.daemon,apache_t.sys_script)
    allow apache_t.sys_script apache_t.daemon:fd use;
    allow apache_t.sys_script apache_t.daemon:fifo_file rw_file_perms;
    allow apache_t.sys_script apache_t.daemon:process sigchld;
')

# When the admin starts the server, the server wants to access
# the TTY or PTY associated with the session. The httpd appears
# to run correctly without this permission, so the permission
# are dontaudited here.
tunable_policy(`httpd_tty_comm',`
    userdom_use_sysadm_terms(apache_t.daemon)
',`
    userdom_dontaudit_use_sysadm_terms(apache_t.daemon)
')

optional_policy(`
    prelink_object_file(apache_t.daemon_modules)
')

optional_policy(`
    calamaris_read_www_files(apache_t.daemon)
')

optional_policy(`
    cron_system_entry(apache_t.daemon, apache_t.daemon_exec)
')

optional_policy(`
    daemontools_service_domain(apache_t.daemon, apache_t.daemon_exec)
')

optional_policy(`
    kerberos_use(apache_t.daemon)
')

optional_policy(`
    mailman_signal_cgi(apache_t.daemon)
    mailman_domtrans_cgi(apache_t.daemon)
    # should have separate types for public and private archives
    mailman_search_data(apache_t.daemon)
    mailman_read_archive(apache_t.daemon)
')

optional_policy(`
    mysql_stream_connect(apache_t.daemon)
    mysql_rw_db_sockets(apache_t.daemon)
')

optional_policy(`
    nagios_read_config(apache_t.daemon)
    nagios_domtrans_cgi(apache_t.daemon)
')

optional_policy(`
    openca_domtrans(apache_t.daemon)
    openca_signal(apache_t.daemon)
    openca_sigstop(apache_t.daemon)
    openca_kill(apache_t.daemon)
')

optional_policy(`
    # Allow httpd to work with postgresql
    postgresql_stream_connect(apache_t.daemon)
')

optional_policy(`
    seutil_sigchld_newrole(apache_t.daemon)
')

optional_policy(`
    snmp_dontaudit_read_snmp_var_lib_files(apache_t.daemon)
')

optional_policy(`
    udev_read_db(apache_t.daemon)
')

optional_policy(`
    yam_read_content(apache_t.daemon)
')

########################################
#
# Apache helper local policy
#

domtrans_pattern(apache_t.daemon, apache_t.helper_exec, apache_t.helper)

allow apache_t.helper apache_t.config:file { getattr read };

allow apache_t.helper apache_t.log:file append;

libs_use_ld_so(apache_t.helper)
libs_use_shared_libs(apache_t.helper)

logging_send_syslog_msg(apache_t.helper)

tunable_policy(`httpd_tty_comm',`
    userdom_use_sysadm_terms(apache_t.helper)
')

########################################
#
# Apache PHP script local policy
#

allow apache_t.php self:process ~{ ptrace setcurrent setexec setfscreate 
setrlimit execmem execstack execheap };
allow apache_t.php self:fd use;
allow apache_t.php self:fifo_file rw_fifo_file_perms;
allow apache_t.php self:sock_file read_sock_file_perms;
allow apache_t.php self:unix_dgram_socket create_socket_perms;
allow apache_t.php self:unix_stream_socket create_stream_socket_perms;
allow apache_t.php self:unix_dgram_socket sendto;
allow apache_t.php self:unix_stream_socket connectto;
allow apache_t.php self:shm create_shm_perms;
allow apache_t.php self:sem create_sem_perms;
allow apache_t.php self:msgq create_msgq_perms;
allow apache_t.php self:msg { send receive };

domtrans_pattern(apache_t.daemon, apache_t.php_exec, apache_t.php)

# allow php to read and append to apache logfiles
allow apache_t.php apache_t.log:file { read_file_perms append_file_perms };

manage_dirs_pattern(apache_t.php,apache_t.php_tmp,apache_t.php_tmp)
manage_files_pattern(apache_t.php,apache_t.php_tmp,apache_t.php_tmp)
files_tmp_filetrans(apache_t.php, apache_t.php_tmp, { file dir })

fs_search_auto_mountpoints(apache_t.php)

libs_exec_lib_files(apache_t.php)
libs_use_ld_so(apache_t.php)
libs_use_shared_libs(apache_t.php)

userdom_use_unpriv_users_fds(apache_t.php)

optional_policy(`
    mysql_stream_connect(apache_t.php)
')

optional_policy(`
    nis_use_ypbind(apache_t.php)
')

########################################
#
# Apache suexec local policy
#

allow apache_t.suexec self:capability { setuid setgid };
allow apache_t.suexec self:process signal_perms;
allow apache_t.suexec self:unix_stream_socket create_stream_socket_perms;
allow apache_t.suexec self:netlink_route_socket r_netlink_socket_perms;

ifdef(`targeted_policy',`
    gen_tunable(httpd_suexec_disable_trans,false)
    tunable_policy(`! httpd_suexec_disable_trans',`
        domtrans_pattern(apache_t.daemon, apache_t.suexec_exec, 
apache_t.suexec)
    ')
')

create_files_pattern(apache_t.suexec,apache_t.log,apache_t.log)
append_files_pattern(apache_t.suexec,apache_t.log,apache_t.log)
allow apache_t.suexec apache_t.daemon:fifo_file getattr;

manage_dirs_pattern(apache_t.suexec,apache_t.suexec_tmp,apache_t.suexec_tmp)
manage_files_pattern(apache_t.suexec,apache_t.suexec_tmp,apache_t.suexec_tmp)
files_tmp_filetrans(apache_t.suexec, apache_t.suexec_tmp, { file dir })

kernel_read_kernel_sysctls(apache_t.suexec)
kernel_list_proc(apache_t.suexec)
kernel_read_proc_symlinks(apache_t.suexec)

dev_read_urand(apache_t.suexec)

fs_search_auto_mountpoints(apache_t.suexec)

# for shell scripts
corecmd_exec_bin(apache_t.suexec)
corecmd_exec_shell(apache_t.suexec)

files_read_etc_files(apache_t.suexec)
files_read_usr_files(apache_t.suexec)
files_dontaudit_search_pids(apache_t.suexec)
files_search_home(apache_t.suexec)

libs_use_ld_so(apache_t.suexec)
libs_use_shared_libs(apache_t.suexec)

logging_search_logs(apache_t.suexec)
logging_send_syslog_msg(apache_t.suexec)

miscfiles_read_localization(apache_t.suexec)

ifdef(`targeted_policy',`
    tunable_policy(`httpd_enable_homedirs',`
        userdom_search_generic_user_home_dirs(apache_t.suexec)
    ')
')

tunable_policy(`httpd_can_network_connect',`
    allow apache_t.suexec self:tcp_socket create_stream_socket_perms;
    allow apache_t.suexec self:udp_socket create_socket_perms;

    corenet_non_ipsec_sendrecv(apache_t.suexec)
    corenet_tcp_sendrecv_all_if(apache_t.suexec)
    corenet_udp_sendrecv_all_if(apache_t.suexec)
    corenet_tcp_sendrecv_all_nodes(apache_t.suexec)
    corenet_udp_sendrecv_all_nodes(apache_t.suexec)
    corenet_tcp_sendrecv_all_ports(apache_t.suexec)
    corenet_udp_sendrecv_all_ports(apache_t.suexec)
    corenet_tcp_connect_all_ports(apache_t.suexec)
    corenet_sendrecv_all_client_packets(apache_t.suexec)

    sysnet_read_config(apache_t.suexec)
')

tunable_policy(`httpd_enable_cgi',`
    domtrans_pattern(apache_t.suexec, apache_unconfined_script_exec_t, 
apache_unconfined_script_t)
')

tunable_policy(`httpd_enable_cgi && httpd_unified',`
    domtrans_pattern(apache_t.suexec, httpdcontent, apache_t.sys_script)
')

tunable_policy(`httpd_enable_homedirs && use_nfs_home_dirs',`
    fs_read_nfs_files(apache_t.suexec)
    fs_read_nfs_symlinks(apache_t.suexec)
    fs_exec_nfs_files(apache_t.suexec)
')

tunable_policy(`httpd_enable_homedirs && use_samba_home_dirs',`
    fs_read_cifs_files(apache_t.suexec)
    fs_read_cifs_symlinks(apache_t.suexec)
    fs_exec_cifs_files(apache_t.suexec)
')

optional_policy(`
    mailman_domtrans_cgi(apache_t.suexec)
')

optional_policy(`
    mta_stub(apache_t.suexec)

    # apache should set close-on-exec
    dontaudit apache_t.suexec apache_t.daemon:unix_stream_socket { read 
write };
')

optional_policy(`
    nagios_domtrans_cgi(apache_t.suexec)
')

optional_policy(`
    nis_use_ypbind(apache_t.suexec)
')

optional_policy(`
    nscd_socket_use(apache_t.suexec)
')

########################################
#
# Apache system script local policy
#

allow apache_t.sys_script apache_t.daemon:tcp_socket { read write };

dontaudit apache_t.sys_script apache_t.config:dir search;

allow apache_t.sys_script apache_t.squirrelmail:file { append read };

allow apache_t.sys_script apache_t.squirrelmail_spool:dir list_dir_perms;
read_files_pattern(apache_t.sys_script,apache_t.squirrelmail_spool,apache_t.squirrelmail_spool)
read_lnk_files_pattern(apache_t.sys_script,apache_t.squirrelmail_spool,apache_t.squirrelmail_spool)

kernel_read_kernel_sysctls(apache_t.sys_script)

files_search_var_lib(apache_t.sys_script)
files_search_spool(apache_t.sys_script)

# Should we add a boolean?
apache_domtrans_rotatelogs(apache_t.sys_script)

ifdef(`distro_redhat',`
    allow apache_t.sys_script apache_t.log:file { getattr append };
')

ifdef(`targeted_policy',`
    typealias apache_t.sys_content alias httpd_user_content_t;
    #alias targets can not have dots.
    #typealias apache_t.sys_script_exec alias apache_t.user_script_exec;

    tunable_policy(`httpd_enable_homedirs',`
        userdom_search_generic_user_home_dirs(apache_t.sys_script)
    ')
')

optional_policy(`
    clamav_domtrans_clamscan(apache_t.sys_script)
')

optional_policy(`
    mysql_stream_connect(apache_t.sys_script)
    mysql_rw_db_sockets(apache_t.sys_script)
')

########################################
#
# Apache unconfined script local policy
#

unconfined_domain(apache_unconfined_script_t)

optional_policy(`
    nscd_socket_use(apache_unconfined_script_t)
')

########################################
#
# httpd_rotatelogs local policy
#

kernel_read_kernel_sysctls(apache_t.rotatelogs)
kernel_dontaudit_list_proc(apache_t.rotatelogs)
kernel_dontaudit_read_proc_symlinks(apache_t.rotatelogs)

files_read_etc_files(apache_t.rotatelogs)

libs_use_ld_so(apache_t.rotatelogs)
libs_use_shared_libs(apache_t.rotatelogs)

miscfiles_read_localization(apache_t.rotatelogs)

ifdef(`targeted_policy',`
    term_dontaudit_use_generic_ptys(apache_t.rotatelogs)
    term_dontaudit_use_unallocated_ttys(apache_t.rotatelogs)
')



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
