Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VHucDo027258
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 12:56:39 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VHqVTg006258
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 17:52:36 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j2VHu2V6007849
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 12:56:02 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j2VHu2nk007848
	for selinux@tycho.nsa.gov; Thu, 31 Mar 2005 12:56:02 -0500
Message-ID: <424C1B73.6020508@redhat.com>
Date: Thu, 31 Mar 2005 10:46:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Question about customizing apache policy.
Content-Type: multipart/mixed;
 boundary="------------090602090706020609050902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090602090706020609050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There was a question yesterday in one of the fedora list, from a person 
who would like to run a special httpd script that would manage his 
passwd file, now whether or not this is a good idea, it caused me to try 
an experiment.
Currently we have a  macro apache_domain.  I thought it would be cool if 
I could start writing policy for this passwd app by adding a file to
domains/misc/apachepasswd.te.  Then having one line
apache_domain(passwd)

Which in theory would create httpd_passwd_script_exec_t, 
httpd_passwd_script_t, httpd_passwd_script_rw_t.  I could then go ahead 
and label my cgi httpd_passwd_script_exec_t and start adding the 
additional allow rules to allow this to happen.  Needless to say, we 
have added a lot of cruft to the apache_domain() macro.  So I did some 
cleanup of apache.te and apache_macro.te, see attach.
Could people review these to make sure there is no mistakes.
But this exercise also brought up the idea that this would be an 
excellent example of how we would want to use loadable modules. I think 
that this might be a fairly common problem.  People want to run a 
specialized apache cgi script that slightly extends httpd_sys_script_t.

It would be cool if they could do this without having to have policy 
installed, but a simple boiler plate for adding a new type of httpd 
script type.

Ideas?

Dan

-- 



--------------090602090706020609050902
Content-Type: text/plain;
 name="apache_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apache_macros.te"


define(`apache_domain', `

#This type is for webpages
#
type httpd_$1_content_t, file_type, httpdcontent, sysadmfile, customizable;

# This type is used for .htaccess files
#
type httpd_$1_htaccess_t, file_type, sysadmfile, customizable;
allow httpd_t httpd_$1_htaccess_t: file r_file_perms;

# This type is used for executable scripts files
#
type httpd_$1_script_exec_t, file_type, sysadmfile, customizable;

# Type that CGI scripts run as
type httpd_$1_script_t, domain, privmail, nscd_client_domain;
role system_r types httpd_$1_script_t;
uses_shlib(httpd_$1_script_t)

if (httpd_enable_cgi) {
domain_auto_trans(httpd_t, httpd_$1_script_exec_t, httpd_$1_script_t)
allow httpd_t httpd_$1_script_t:process { signal sigkill sigstop };
allow httpd_t httpd_$1_script_exec_t:dir r_dir_perms;

allow httpd_$1_script_t httpd_t:fd use;
allow httpd_$1_script_t httpd_t:process sigchld;

allow httpd_$1_script_t { usr_t lib_t }:file { getattr read ioctl };
allow httpd_$1_script_t usr_t:lnk_file { getattr read };

allow httpd_$1_script_t self:process { fork signal_perms };

allow httpd_$1_script_t devtty_t:chr_file { getattr read write };
allow httpd_$1_script_t urandom_device_t:chr_file { getattr read };
allow httpd_$1_script_t etc_runtime_t:file { getattr read };
read_locale(httpd_$1_script_t)
allow httpd_$1_script_t fs_t:filesystem getattr;
allow httpd_$1_script_t self:unix_stream_socket create_stream_socket_perms;

allow httpd_$1_script_t { self proc_t }:file { getattr read };
allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
allow httpd_$1_script_t { self proc_t }:lnk_file read;

allow httpd_$1_script_t device_t:dir { getattr search };
allow httpd_$1_script_t null_device_t:chr_file rw_file_perms;
}

if (httpd_enable_cgi && httpd_can_network_connect) {
can_network(httpd_$1_script_t)
allow httpd_$1_script_t port_type:tcp_socket name_connect;
}

ifdef(`ypbind.te', `
if (httpd_enable_cgi && allow_ypbind) {
uncond_can_ypbind(httpd_$1_script_t)
}
')
# The following are the only areas that 
# scripts can read, read/write, or append to
#
type httpd_$1_script_ro_t, file_type, httpdcontent, sysadmfile, customizable;
type httpd_$1_script_rw_t, file_type, httpdcontent, sysadmfile, customizable;
type httpd_$1_script_ra_t, file_type, httpdcontent, sysadmfile, customizable;
file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)

#########################################################
# Permissions for running child processes and scripts
##########################################################
allow httpd_suexec_t { httpd_$1_content_t httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_exec_t }:dir { getattr search };

domain_auto_trans(httpd_suexec_t, httpd_$1_script_exec_t, httpd_$1_script_t)

allow httpd_$1_script_t httpd_t:fifo_file write;

allow httpd_$1_script_t self:fifo_file rw_file_perms;

allow httpd_$1_script_t { urandom_device_t random_device_t }:chr_file r_file_perms;

# for nscd
dontaudit httpd_$1_script_t var_t:dir search;

###########################################################################
# Allow the script interpreters to run the scripts.  So
# the perl executable will be able to run a perl script
#########################################################################
can_exec_any(httpd_$1_script_t)
allow httpd_$1_script_t etc_t:file { getattr read };
dontaudit httpd_$1_script_t selinux_config_t:dir search;

############################################################################
# Allow the script process to search the cgi directory, and users directory
##############################################################################
allow httpd_$1_script_t httpd_$1_script_exec_t:dir { search getattr };
can_exec(httpd_$1_script_t, httpd_$1_script_exec_t)
allow httpd_$1_script_t home_root_t:dir { getattr search };
allow httpd_$1_script_t httpd_$1_content_t:dir { getattr search };

#############################################################################
# Allow the scripts to read, read/write, append to the specified directories
# or files
############################################################################
r_dir_file(httpd_$1_script_t, fonts_t)
r_dir_file(httpd_$1_script_t, httpd_$1_script_ro_t)
create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)

if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
create_dir_file(httpd_$1_script_t, httpdcontent)
}

#
# If a user starts a script by hand it gets the proper context
#
if (httpd_enable_cgi ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
domain_auto_trans(sysadm_t, httpd_$1_script_exec_t, httpd_$1_script_t)
}
role sysadm_r types httpd_$1_script_t;

dontaudit httpd_$1_script_t sysctl_kernel_t:dir search;
dontaudit httpd_$1_script_t sysctl_t:dir search;

############################################
# Allow scripts to append to http logs
#########################################
allow httpd_$1_script_t httpd_log_t:file { getattr append };

# apache should set close-on-exec
dontaudit  httpd_$1_script_t httpd_t:unix_stream_socket { read write };

################################################################
# Allow the web server to run scripts and serve pages
##############################################################
if (httpd_builtin_scripting) {
r_dir_file(httpd_t, httpd_$1_script_ro_t)
create_dir_file(httpd_t, httpd_$1_script_rw_t)
ra_dir_file(httpd_t, httpd_$1_script_ra_t)
r_dir_file(httpd_t, httpd_$1_content_t)
}

')
define(`apache_user_domain', `

apache_domain($1)

typeattribute httpd_$1_content_t $1_file_type;

if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
domain_auto_trans($1_t, httpdcontent, httpd_$1_script_t)
}

if (httpd_enable_cgi ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
# If a user starts a script by hand it gets the proper context
domain_auto_trans($1_t, httpd_$1_script_exec_t, httpd_$1_script_t)
}
role $1_r types httpd_$1_script_t;

#######################################
# Allow user to create or edit web content
#########################################

create_dir_file($1_t, { httpd_$1_content_t httpd_$1_script_exec_t })
allow $1_t { httpd_$1_content_t httpd_$1_script_exec_t }:{ dir file lnk_file } { relabelto relabelfrom };

######################################################################
# Allow the user to create htaccess files
#####################################################################

allow $1_t httpd_$1_htaccess_t:file { create_file_perms relabelto relabelfrom };

#########################################################################
# Allow user to create files or directories 
# that scripts are able to read, write, or append to
###########################################################################

create_dir_file($1_t, { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t })
allow $1_t { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:{ file dir lnk_file } { relabelto relabelfrom };

# allow accessing files/dirs below the users home dir
if (httpd_enable_homedirs) {
allow { httpd_t httpd_suexec_t httpd_$1_script_t } $1_home_dir_t:dir { getattr search };
ifdef(`nfs_home_dirs', `
r_dir_file(httpd_$1_script_t, nfs_t)
')dnl end if nfs_home_dirs
}
ifdef(`crond.te', `
create_dir_file($1_crond_t, httpd_$1_content_t)
')

')

--------------090602090706020609050902
Content-Type: text/plain;
 name="apache.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apache.te"

#DESC Apache - Web server
#
# X-Debian-Packages: apache2-common apache
#
###############################################################################
#
# Policy file for running the Apache web server
#
# NOTES: 
#  This policy will work with SUEXEC enabled as part of the Apache
#  configuration. However, the user CGI scripts will run under the
#  system_u:system_r:httpd_$1_script_t domain where $1 is the domain of the
#  of the creating user.
#
#  The user CGI scripts must be labeled with the httpd_$1_script_exec_t
#  type, and the directory containing the scripts should also be labeled
#  with these types. This policy allows user_r role to perform that 
#  relabeling. If it is desired that only sysadm_r should be able to relabel
#  the user CGI scripts, then relabel rule for user_r should be removed.
#
###############################################################################

define(`httpd_home_dirs', `
r_dir_file(httpd_t, $1)
r_dir_file(httpd_suexec_t, $1)
can_exec(httpd_suexec_t, $1)
')

type http_port_t, port_type, reserved_port_type;

bool httpd_unified false;

# Allow httpd to use built in scripting (usually php)
bool httpd_builtin_scripting false;

# Allow httpd cgi support
bool httpd_enable_cgi false;

# Allow httpd to read home directories
bool httpd_enable_homedirs false;

# Run SSI execs in system CGI script domain.
bool httpd_ssi_exec false;

# Allow http daemon to communicate with the TTY
bool httpd_tty_comm false;

# Allow http daemon to tcp connect 
bool httpd_can_network_connect false;

#########################################################
# Apache types
#########################################################
# httpd_config_t is the type given to the configuration
# files for apache /etc/httpd/conf
#
type httpd_config_t, file_type, sysadmfile;

append_logdir_domain(httpd)
#can read /etc/httpd/logs
allow httpd_t httpd_log_t:lnk_file read;

# For /etc/init.d/apache2 reload
can_tcp_connect(httpd_t, httpd_t)

can_tcp_connect(web_client_domain, httpd_t)

# httpd_modules_t is the type given to module files (libraries) 
# that come with Apache /etc/httpd/modules and /usr/lib/apache
#
type httpd_modules_t, file_type, sysadmfile;

# httpd_cache_t is the type given to the /var/cache/httpd
# directory and the files under that directory
#
type httpd_cache_t, file_type, sysadmfile;

# httpd_exec_t is the type give to the httpd executable.
#
daemon_domain(httpd, `, privmail')

can_exec(httpd_t, httpd_exec_t)
file_type_auto_trans(httpd_t, var_run_t, httpd_var_run_t, sock_file)

general_domain_access(httpd_t)

allow httpd_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };

read_sysctl(httpd_t)

# for modules that want to access /etc/mtab and /proc/meminfo
allow httpd_t { proc_t etc_runtime_t }:file { getattr read };

uses_shlib(httpd_t)
allow httpd_t { usr_t lib_t }:file { getattr read ioctl };
allow httpd_t usr_t:lnk_file { getattr read };

# for apache2 memory mapped files
var_lib_domain(httpd)

# for tomcat
r_dir_file(httpd_t, var_lib_t)

# execute perl
allow httpd_t { bin_t sbin_t }:dir r_dir_perms;
can_exec(httpd_t, { bin_t sbin_t })
allow httpd_t bin_t:lnk_file read;

########################################
# Set up networking
########################################

can_network_server(httpd_t)
can_kerberos(httpd_t)
can_resolve(httpd_t)
can_ypbind(httpd_t)
allow httpd_t { http_port_t http_cache_port_t }:tcp_socket name_bind;

if (httpd_can_network_connect) {
can_network_client(httpd_t)
allow httpd_t port_type:tcp_socket name_connect;
}

#########################################
# Allow httpd to search users directories
#########################################
allow httpd_t home_root_t:dir { getattr search };
dontaudit httpd_t sysadm_home_dir_t:dir getattr;

############################################################################
# Allow the httpd_t the capability to bind to a port and various other stuff
############################################################################
allow httpd_t self:capability { chown dac_override kill setgid setuid net_bind_service sys_tty_config };
dontaudit httpd_t self:capability net_admin;

#################################################
# Allow the httpd_t to read the web servers config files
###################################################
r_dir_file(httpd_t, httpd_config_t)
# allow logrotate to read the config files for restart
ifdef(`logrotate.te', `
r_dir_file(logrotate_t, httpd_config_t)
domain_auto_trans(logrotate_t, httpd_exec_t, httpd_t)
allow logrotate_t httpd_t:process signull;
')
r_dir_file(initrc_t, httpd_config_t)
##################################################

###############################
# Allow httpd_t to put files in /var/cache/httpd etc
##############################
create_dir_file(httpd_t, httpd_cache_t)

###############################
# Allow httpd_t to access the tmpfs file system
##############################
tmpfs_domain(httpd)

#####################
# Allow httpd_t to access
# libraries for its modules
###############################
allow httpd_t httpd_modules_t:file rx_file_perms;
allow httpd_t httpd_modules_t:dir r_dir_perms;
allow httpd_t httpd_modules_t:lnk_file r_file_perms;

######################################################################
# Allow initrc_t to access the Apache modules directory.
######################################################################
allow initrc_t httpd_modules_t:dir r_dir_perms;

##############################################
# Allow httpd_t to have access to files
# such as nisswitch.conf
# need ioctl for php
###############################################
allow httpd_t etc_t:file { read getattr ioctl };
allow httpd_t etc_t:lnk_file { getattr read };

# setup the system domain for system CGI scripts
apache_domain(sys)
dontaudit httpd_sys_script_t httpd_config_t:dir search;

# Run SSI execs in system CGI script domain.
if (httpd_ssi_exec) {
domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_t)
}
allow httpd_sys_script_t httpd_t:tcp_socket { read write };

##################################################
#
# PHP Directives
##################################################

type httpd_php_exec_t, file_type, sysadmfile, exec_type;
type httpd_php_t, domain;

# Transition from the user domain to this domain.
domain_auto_trans(httpd_t, httpd_php_exec_t, httpd_php_t)

# The system role is authorized for this domain.
role system_r types httpd_php_t;

general_domain_access(httpd_php_t)
uses_shlib(httpd_php_t)
can_exec(httpd_php_t, lib_t)

# allow php to read and append to apache logfiles
allow httpd_php_t httpd_log_t:file ra_file_perms;

# access to /tmp
tmp_domain(httpd)
tmp_domain(httpd_php)

# Creation of lock files for apache2
lock_domain(httpd)

# connect to mysql
ifdef(`mysqld.te', `
can_unix_connect(httpd_php_t, mysqld_t)
can_unix_connect(httpd_t, mysqld_t)
can_unix_connect(httpd_sys_script_t, mysqld_t)
allow httpd_php_t mysqld_var_run_t:dir search;
allow httpd_php_t mysqld_var_run_t:sock_file write;
allow { httpd_t httpd_sys_script_t } mysqld_db_t:dir search;
allow { httpd_t httpd_sys_script_t } mysqld_db_t:sock_file rw_file_perms;
allow { httpd_t httpd_sys_script_t } mysqld_var_run_t:sock_file rw_file_perms;
')
allow httpd_t bin_t:dir search;
allow httpd_t sbin_t:dir search;
allow httpd_t httpd_log_t:dir remove_name;
r_dir_file(httpd_t, fonts_t)

allow httpd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };

allow httpd_t autofs_t:dir { search getattr };

if (use_nfs_home_dirs && httpd_enable_homedirs) {
httpd_home_dirs(nfs_t)
}
if (use_samba_home_dirs && httpd_enable_homedirs) {
httpd_home_dirs(cifs_t)
}

#
# Allow users to mount additional directories as http_source
#
allow httpd_t mnt_t:dir r_dir_perms;

ifdef(`targeted_policy', `
typealias httpd_sys_content_t alias httpd_user_content_t;
typealias httpd_sys_script_exec_t alias httpd_user_script_exec_t;

if (httpd_enable_homedirs) {
allow httpd_sys_script_t user_home_dir_t:dir { getattr search };
allow httpd_t user_home_dir_t:dir { getattr search };
}
') dnl targeted policy

ifdef(`distro_redhat', `
#
# mod_jk2 creates /var/log/httpd/jk2.shm to communicate with tomcat
# This is a bug but it still exists in FC2
#
typealias httpd_log_t  alias httpd_runtime_t;
allow { httpd_t httpd_sys_script_t } httpd_runtime_t:file { getattr append };
dontaudit httpd_t httpd_runtime_t:file ioctl;
') dnl distro_redhat
#
# Customer reported the following
#
ifdef(`snmpd.te', `
dontaudit httpd_t snmpd_var_lib_t:dir search;
dontaudit httpd_t snmpd_var_lib_t:file { getattr write read };
', `
dontaudit httpd_t usr_t:dir write;
')

application_domain(httpd_helper)
role system_r types httpd_helper_t;
domain_auto_trans(httpd_t, httpd_helper_exec_t, httpd_helper_t)
allow httpd_helper_t httpd_config_t:file { getattr read };
allow httpd_helper_t httpd_log_t:file { append };

########################################
# When the admin starts the server, the server wants to acess
# the TTY or PTY associated with the session. The httpd appears
# to run correctly without this permission, so the permission
# are dontaudited here. 
##################################################

if (httpd_tty_comm) {
allow { httpd_t httpd_helper_t } devpts_t:dir { search };
ifdef(`targeted_policy', `
allow { httpd_helper_t httpd_t } { devtty_t devpts_t }:chr_file { read write };
')
allow { httpd_t httpd_helper_t } admin_tty_type:chr_file { read write };
} else {
dontaudit httpd_t admin_tty_type:chr_file rw_file_perms;
}

read_sysctl(httpd_sys_script_t)
allow httpd_sys_script_t var_lib_t:dir search;
dontaudit httpd_t selinux_config_t:dir search;
r_dir_file(httpd_t, cert_t)

#
# unconfined domain for apache scripts.  Only to be used as a last resort
#
type httpd_unconfined_script_exec_t, file_type, sysadmfile, customizable;
type httpd_unconfined_script_t, domain, nscd_client_domain;
role system_r types httpd_unconfined_script_t;
unconfined_domain(httpd_unconfined_script_t)

# The following are types for SUEXEC,which runs user scripts as their
# own user ID
#
daemon_sub_domain(httpd_t, httpd_suexec)
allow httpd_t httpd_suexec_exec_t:file read;

#########################################################
# Permissions for running child processes and scripts
##########################################################

allow httpd_suexec_t self:capability { setuid setgid };

dontaudit httpd_suexec_t var_run_t:dir search;
allow httpd_suexec_t { var_t var_log_t }:dir search;
allow httpd_suexec_t home_root_t:dir search;

allow httpd_suexec_t httpd_log_t:dir search;
allow httpd_suexec_t httpd_log_t:file { append getattr };
allow httpd_suexec_t httpd_t:fifo_file getattr;
allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;

allow httpd_suexec_t etc_t:file { getattr read };
read_locale(httpd_suexec_t)
read_sysctl(httpd_suexec_t)
allow httpd_suexec_t urandom_device_t:chr_file { getattr read };

# for shell scripts
allow httpd_suexec_t bin_t:dir search;
allow httpd_suexec_t bin_t:lnk_file read;
can_exec(httpd_suexec_t, { bin_t shell_exec_t })

if (httpd_can_network_connect) {
can_network(httpd_suexec_t)
allow httpd_suexec_t port_type:tcp_socket name_connect;
}

can_ypbind(httpd_suexec_t)
allow httpd_suexec_t { usr_t lib_t }:file { getattr read ioctl };

allow httpd_suexec_t autofs_t:dir { search getattr };
tmp_domain(httpd_suexec)

ifdef(`mta.te', `
# apache should set close-on-exec
dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
dontaudit { system_mail_t mta_user_agent } { httpd_t httpd_sys_script_t }:unix_stream_socket { read write };
')

if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
}
if (httpd_enable_cgi && httpd_unified && httpd_builtin_scripting ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
create_dir_file(httpd_t, httpdcontent)
can_exec(httpd_t, httpdcontent )
}
if (httpd_enable_cgi) {
domain_auto_trans(httpd_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
domain_auto_trans(httpd_suexec_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
allow httpd_t httpd_unconfined_script_t:process { signal sigkill sigstop };
allow httpd_t httpd_unconfined_script_exec_t:dir r_dir_perms;
}

#
# Types for squirrelmail
#
type httpd_squirrelmail_t, file_type, sysadmfile;
create_dir_file(httpd_t, httpd_squirrelmail_t)
allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
# File Type of squirrelmail attachments
type squirrelmail_spool_t, file_type, sysadmfile, tmpfile;
allow { httpd_t httpd_sys_script_t } var_spool_t:dir { getattr search };
create_dir_file(httpd_t, squirrelmail_spool_t)
r_dir_file(httpd_sys_script_t, squirrelmail_spool_t)

ifdef(`mta.te', `
dontaudit system_mail_t httpd_log_t:file { append getattr };
allow system_mail_t httpd_squirrelmail_t:file { append read };
dontaudit system_mail_t httpd_t:tcp_socket { read write };
')


--------------090602090706020609050902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
