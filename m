Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06155
	for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2003 07:00:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA28858
	for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2003 11:57:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA28854
	for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2003 11:57:18 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id ED33592569
	for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2003 23:00:07 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5CDE28D6
	for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2003 13:00:00 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Apache policy
Date: Tue, 18 Feb 2003 12:59:59 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/AiU+nlxfzt29dK"
Message-Id: <200302181259.59668.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_/AiU+nlxfzt29dK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been working on re-writing the Apache policy.

My new version is macro based, supports multiple user roles, and removes a lot 
of the cruft that had accumulated in the Apache policy.

I've attached all the Apache files (the changes are to big for a diff to be of 
much use) and the user_macros.te file which also has a minor change.

This one needs some testing, there's lots of significant changes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_/AiU+nlxfzt29dK
Content-Type: text/plain;
  charset="us-ascii";
  name="apache.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apache.fc"

# apache
/var/www/html(/.*)?		system_u:object_r:httpd_sys_content_t
/var/www/mrtg(/.*)?		system_u:object_r:httpd_sys_content_t
/var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
/usr/lib/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
/var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_exec_t
/var/www/icons(/.*)?		system_u:object_r:httpd_sys_content_t
/var/cache/httpd(/.*)?		system_u:object_r:httpd_cache_t
/etc/httpd			system_u:object_r:httpd_config_t
/etc/httpd/conf(/.*)?		system_u:object_r:httpd_config_t
/etc/httpd/logs			system_u:object_r:httpd_log_t
/etc/httpd/modules		system_u:object_r:httpd_modules_t
/etc/apache(2)?(/.*)?		system_u:object_r:httpd_config_t
/etc/vhosts			system_u:object_r:httpd_config_t
/usr/lib/apache(/.*)?		system_u:object_r:httpd_modules_t
/usr/lib/apache2/modules(/.*)?	system_u:object_r:httpd_modules_t
/usr/sbin/httpd			system_u:object_r:httpd_exec_t
/usr/sbin/apache(2)?		system_u:object_r:httpd_exec_t
/usr/sbin/suexec		system_u:object_r:httpd_suexec_exec_t
/usr/lib/cgi-bin/(nph-)?cgiwrap(d)? system_u:object_r:httpd_suexec_exec_t
/usr/lib/apache(2)?/suexec(2)?	system_u:object_r:httpd_suexec_exec_t
/var/log/httpd(/.*)?		system_u:object_r:httpd_log_t
/var/log/apache(2)?(/.*)?	system_u:object_r:httpd_log_t
/var/log/cgiwrap.log.*		system_u:object_r:httpd_log_t
/var/cache/ssl.*\.sem		system_u:object_r:httpd_cache_t
/var/run/apache(2)?.pid.*	system_u:object_r:var_run_httpd_t

--Boundary-00=_/AiU+nlxfzt29dK
Content-Type: text/plain;
  charset="us-ascii";
  name="apache.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apache.te"

#DESC Apache - Web server
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
type http_port_t, port_type;
type http_cache_port_t, port_type;

#########################################################
# Apache types
#########################################################
# httpd_config_t is the type given to the configuration
# files for apache /etc/httpd/conf
#
type httpd_config_t, file_type, sysadmfile;

log_domain(httpd)

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
daemon_domain(httpd)

general_domain_access(httpd_t)

# setup the system domain for system CGI scripts
apache_domain(sys)

#every_domain(httpd_t)

#
# A type for tmpfs file system
#
type httpd_tmpfs_t, file_type, sysadmfile;

# The following are types for SUEXEC,which runs user scripts as their
# own user ID
#
daemon_sub_domain(httpd_t, httpd_suexec)

#########################################################
# Permissions for running child processes and scripts
##########################################################

allow httpd_suexec_t httpd_suexec_t:capability { setuid setgid };

allow httpd_suexec_t httpd_log_t:dir search;
allow httpd_suexec_t httpd_log_t:file { append getattr };

allow httpd_suexec_t httpd_t:fifo_file {getattr} ;

ifdef(`mta.te', `
# apache should set close-on-exec
dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
dontaudit { system_mail_t mta_user_agent } httpd_t:unix_stream_socket { read write };
')

uses_shlib(httpd_t)

# execute perl
can_exec(httpd_t, bin_t)

can_network(httpd_t)

###################
# Allow httpd to search users diretories
######################
allow httpd_t home_root_t:dir { getattr search };
dontaudit httpd_t sysadm_home_dir_t:dir getattr;

############################################################################
# Allow the httpd_t the capability to bind to a port and various other stuff
############################################################################
allow httpd_t httpd_t:capability {chown net_bind_service setgid setuid kill dac_override dac_read_search };

#################################################
# Allow the httpd_t to read the web servers config files
###################################################
r_dir_file(httpd_t, httpd_config_t)
# allow logrotate to read the config files for restart
ifdef(`logrotate.te', `
r_dir_file(logrotate_t, httpd_config_t)
')
r_dir_file(initrc_t, httpd_config_t)
##################################################

########################################
# Allow httpd_t to bind to the HTTP port
########################################
allow httpd_t { http_port_t http_cache_port_t }:tcp_socket name_bind;

###############################
# Allow httpd_t to put files in /var/cache/httpd etc
##############################
create_dir_file(httpd_t, httpd_cache_t)

###############################
# Allow httpd_t to access the tmpfs file system
##############################
file_type_auto_trans(httpd_t, tmpfs_t, httpd_tmpfs_t)
allow httpd_tmpfs_t tmpfs_t:filesystem associate;

#####################
# Allow httpd_t to access
# libraries for its modules
###############################
can_exec(httpd_t, httpd_modules_t)
allow httpd_t httpd_modules_t:dir r_dir_perms;
allow httpd_t httpd_modules_t:lnk_file r_file_perms;

######################################################################
# Allow initrc_t to access the Apache modules directory.
######################################################################
allow initrc_t httpd_modules_t:dir r_dir_perms;

##############################################
# Allow httpd_t to have access to files
# such as nisswitch.conf
###############################################
allow httpd_t { etc_t resolv_conf_t }:file { read getattr };
allow httpd_t etc_t:lnk_file read;

# Several options for handling SSI exec cmd elements:
# Option #1:  Don't support them at all.  This is the default, since
# httpd_t is not permitted to execute shell_exec_t.
# Option #2:  Run SSI exec's in the same domain as system CGI scripts.
# Uncomment the following line to enable:
#domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_t)
# Option #3:  Run SSI exec's directly in the httpd_t domain.  This means
# that they have the same permissions as the daemon.  Probably not a good idea.
# Uncomment the following line to enable:
#can_exec(httpd_t, shell_exec_t)

##################################################
#
# PHP Directives
##################################################

type httpd_php_exec_t, file_type, exec_type;
type httpd_php_t, domain;

# Transition from the user domain to this domain.
domain_auto_trans(httpd_t, httpd_php_exec_t, httpd_php_t)

# The system role is authorized for this domain.
role system_r types httpd_php_t;

general_domain_access(httpd_php_t)
general_file_read_access(httpd_php_t)
uses_shlib(httpd_php_t)
can_exec(httpd_php_t, lib_t)

# allow php to read and append to apache logfiles
allow httpd_php_t httpd_log_t:file ra_file_perms;

# access to /tmp
tmp_domain(httpd_php);

# Creation of lock files for apache2
lock_domain(httpd)

# connect to mysql
ifdef(`mysqld.te', `
can_unix_connect(httpd_php_t, mysqld_t)
allow httpd_php_t var_run_mysqld_t:dir { search };
allow httpd_php_t var_run_mysqld_t:sock_file { write };
')


--Boundary-00=_/AiU+nlxfzt29dK
Content-Type: text/plain;
  charset="us-ascii";
  name="apache_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apache_macros.te"


define(`apache_domain', `

#This type is for webpages
#
type httpd_$1_content_t, file_type, sysadmfile;

# This type is used for .htaccess files
#
type httpd_$1_htaccess_t, file_type, sysadmfile;

# Type that CGI scripts run as
#
daemon_sub_domain(httpd_t, httpd_$1_script)

# The following are the only areas that 
# scripts can read, read/write, or append to
#
type httpd_$1_script_ro_t, file_type, sysadmfile;
type httpd_$1_script_rw_t, file_type, sysadmfile;
file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
type httpd_$1_script_ra_t, file_type, sysadmfile;

#########################################################
# Permissions for running child processes and scripts
##########################################################
domain_auto_trans(httpd_suexec_t, httpd_$1_script_exec_t, httpd_$1_script_t)

allow httpd_suexec_t httpd_$1_script_exec_t:dir { search getattr };
allow httpd_suexec_t httpd_$1_script_exec_t:file { execute entrypoint };

allow httpd_$1_script_t httpd_t:fifo_file { write };

allow httpd_$1_script_t random_device_t:chr_file r_file_perms;

###########################################################################
# Allow the script interpreters to run the scripts.  So
# the perl executable will be able to run a perl script
#########################################################################
can_exec(httpd_$1_script_t, bin_t)

############################################################################
# Allow the script process to search the cgi directory, and users directory
##############################################################################
allow httpd_$1_script_t httpd_$1_script_exec_t:dir {search add_name};
allow httpd_$1_script_t home_root_t:dir { getattr search };
allow httpd_$1_script_t httpd_$1_content_t:dir {search};

#############################################################################
# Allow the scripts to read, read/write, append to the specified directories
# or files
############################################################################
r_dir_file(httpd_$1_script_t, httpd_$1_script_ro_t)
create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)

ifelse($1, sys, `
#
# If a user starts a script by hand it gets the proper context
#
domain_auto_trans(sysadm_t, httpd_$1_script_t, httpd_$1_script_t)
role sysadm_r types httpd_$1_script_t;
', `
#
# If a user starts a script by hand it gets the proper context
#
domain_auto_trans($1_t, httpd_$1_script_t, httpd_$1_script_t)
role $1_r types httpd_$1_script_t;

#######################################
# Allow user to create or edit web content
#########################################

create_dir_file($1_t, { httpd_$1_content_t httpd_$1_script_t })
allow $1_t { httpd_$1_content_t httpd_$1_script_t }:{ dir file lnk_file } { relabelto relabelfrom };

######################################################################
# Allow the user to create htaccess files
#####################################################################

allow $1_t httpd_$1_htaccess_t:{ file lnk_file } { create_file_perms relabelto relabelfrom };

#########################################################################
# Allow user to create files or directories 
# that scripts are able to read, write, or append to
###########################################################################

create_dir_file($1_t, { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t })
allow $1_t { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:{ file dir lnk_file } { relabelto relabelfrom };

# allow accessing files/dirs below the users home dir
allow httpd_$1_script_t $1_home_dir_t:dir {getattr search};
allow httpd_t $1_home_dir_t:dir { getattr search };
')

################################################################
# Allow the web server to run scripts and serve pages
##############################################################
allow httpd_t httpd_$1_content_t:file r_file_perms;
allow httpd_t httpd_$1_content_t:dir r_dir_perms;

allow httpd_t httpd_$1_htaccess_t: file r_file_perms;

allow httpd_t httpd_$1_script_exec_t:file {execute getattr read};
allow httpd_t httpd_$1_script_t:process {signal sigkill sigstop};
allow httpd_t httpd_$1_script_t:process {transition};
allow httpd_t httpd_$1_script_exec_t:dir r_dir_perms;

allow httpd_t httpd_$1_script_rw_t:file r_file_perms;
allow httpd_t httpd_$1_script_rw_t:dir r_dir_perms;

############################################
# Allow scripts to append to http logs
#########################################
allow httpd_$1_script_t httpd_log_t:file append;

')

--Boundary-00=_/AiU+nlxfzt29dK
Content-Type: text/plain;
  charset="us-ascii";
  name="user_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="user_macros.te"

#
# Macros for all user login domains.
#

#
# user_domain(domain_prefix)
#
# Define derived types and rules for an ordinary user domain.
#
# The type declaration and role authorization for the domain must be
# provided separately.  Likewise, domain transitions into this domain
# must be specified separately.  If the every_domain() rules are desired,
# then these rules must also be specified separately.
#
undefine(`user_domain')
define(`user_domain',`
# Use capabilities
allow $1_t self:capability { setgid chown fowner };
dontaudit $1_t self:capability { sys_nice fsetid };

# Type for home directory.
ifelse($1, sysadm, `
type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
type $1_home_t, file_type, sysadmfile, home_type;
tmp_domain($1)
', `
type $1_home_dir_t, file_type, sysadmfile, home_dir_type, user_home_dir_type, home_type, user_home_type;
type $1_home_t, file_type, sysadmfile, home_type, user_home_type;
# do not allow privhome access to sysadm_home_dir_t
file_type_auto_trans(privhome, $1_home_dir_t, $1_home_t)
tmp_domain($1, `, user_tmpfile')
')

# Create, access, and remove files in home directory.
file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
allow $1_t $1_home_t:dir_file_class_set { relabelfrom relabelto };

# Bind to a Unix domain socket in /tmp.
allow $1_t $1_tmp_t:unix_stream_socket name_bind;

# Type for tty devices.
type $1_tty_device_t, file_type, sysadmfile, ttyfile;
# Access ttys.
allow $1_t $1_tty_device_t:chr_file { setattr rw_file_perms };
# Use the type when relabeling terminal devices.
type_change $1_t tty_device_t:chr_file $1_tty_device_t;
ifdef(`dpkg.te', `
# Debian login is from shadow utils and does not allow resetting the perms.
# have to fix this!
type_change $1_t ttyfile:chr_file $1_tty_device_t;
')

# Type and access for pty devices.
ifelse(`$1', `sysadm', `
can_create_pty($1)
', `
can_create_pty($1, `, userpty_type')
')

# Use the type when relabeling pty devices.
ifdef(`rlogind.te',
`type_change $1_t rlogind_devpts_t:chr_file $1_devpts_t;')
ifdef(`ssh.te', `
type_change $1_t sshd_devpts_t:chr_file $1_devpts_t;

# Access /tmp/ssh files.
allow $1_t sshd_tmp_t:dir rw_dir_perms;
allow $1_t sshd_tmp_t:file create_file_perms;

# Connect to sshd.
can_tcp_connect($1_t, sshd_t)

# Connect to ssh proxy.
can_tcp_connect($1_t, $1_ssh_t)

allow $1_t sshd_t:fd use;
allow $1_t sshd_t:tcp_socket rw_stream_socket_perms;
# Use a Unix stream socket inherited from sshd.
allow $1_t sshd_t:unix_stream_socket rw_stream_socket_perms;
')dnl end of ssh section

# Type for tmpfs/shm files.
type $1_tmpfs_t, file_type, sysadmfile, tmpfsfile;
# Use the type when creating files in tmpfs.
file_type_auto_trans($1_t, tmpfs_t, $1_tmpfs_t)
allow $1_tmpfs_t tmpfs_t:filesystem associate;

# Read and write /var/catman.
allow $1_t catman_t:dir rw_dir_perms;
allow $1_t catman_t:notdevfile_class_set create_file_perms;

# Modify mail spool file.
allow $1_t mail_spool_t:dir r_dir_perms;
allow $1_t mail_spool_t:file rw_file_perms;
allow $1_t mail_spool_t:lnk_file read;

#
# Allow the query of filesystem quotas
#
allow $1_t fs_type:filesystem quotaget;

# Run helper programs.
can_exec_any($1_t)
# Run programs developed by other users in the same domain.
can_exec($1_t, $1_home_t)
can_exec($1_t, $1_tmp_t)

# Run user programs that require different permissions in their own domain.
# These rules were moved into the individual program domains.

# Instantiate derived domains for a number of programs.
# These derived domains encode both information about the calling
# user domain and the program, and allow us to maintain separation
# between different instances of the program being run by different
# user domains.
ifdef(`gnome-pty-helper.te', `gph_domain($1)')
ifdef(`su.te', `su_domain($1)')
ifdef(`chkpwd.te', `chkpwd_domain($1)')
ifdef(`screen.te', `screen_domain($1)')
ifdef(`netscape.te', `netscape_domain($1)')
ifdef(`games.te', `
x_client_domain($1, games)
rw_dir_create_file($1_games_t, games_data_t)
')
ifdef(`gpg.te', `gpg_domain($1)')
ifdef(`xauth.te', `xauth_domain($1)')
ifdef(`xserver.te', `xserver_domain($1)')
ifdef(`lpr.te', `lpr_domain($1)')
ifdef(`mta.te', `mail_domain($1)')
ifdef(`sendmail.te', `sendmail_user_domain($1)')
ifdef(`crontab.te', `crontab_domain($1)')
ifdef(`ssh.te', `ssh_domain($1)')
ifdef(`irc.te', `irc_domain($1)')
ifdef(`uml.te', `uml_domain($1)')
ifdef(`clamav.te', `user_clamscan_domain($1)')
ifdef(`fingerd.te', `fingerd_macro($1)')

# Instantiate a derived domain for user cron jobs.
ifdef(`crond.te', `crond_domain($1)')

ifdef(`vmware.te', `
# probably should have a separate domain for each user
file_type_auto_trans(vmware_user_t, $1_home_dir_t, vmware_user_file_t)
')

# Read the mouse.
allow $1_t mouse_device_t:chr_file r_file_perms;
# Access other miscellaneous devices.
allow $1_t misc_device_t:file_class_set rw_file_perms;

ifdef(`apache.te', `
ifelse(`$1', `sysadm', `', `
apache_domain($1)
')
')

# Use the network.
can_network($1_t)

#
# connect_secure and sendmsg_secure calls with a 
# peer or destination socket SID can be enforced
# when using the loopback interface.  Enforcement
# for real network interfaces will be possible when
# a packet labeling mechanism is integrated.
#
allow $1_t node_lo_t:node enforce_dest;

# Communicate within the domain.
can_udp_send($1_t, $1_t)
can_tcp_connect($1_t, $1_t)

# Connect to inetd.
ifdef(`inetd.te', `can_tcp_connect($1_t,inetd_t)')

ifdef(`rshd.te',
`# Connect second port to rshd.
can_tcp_connect(rshd_t, $1_t)')

# Connect data port to ftpd.
ifdef(`ftpd.te', `can_tcp_connect(ftpd_t, $1_t)')

# Connect to portmap.
ifdef(`portmap.te', `can_tcp_connect($1_t, portmap_t)')

# Inherit and use sockets from inetd
ifdef(`inetd.te',
`allow $1_t inetd_t:fd use;
allow $1_t inetd_t:tcp_socket rw_stream_socket_perms;')

# Allow system log read
#allow $1_t kernel_t:system syslog_read;
# else do not log it
dontaudit $1_t kernel_t:system syslog_read;

# Very permissive allowing every domain to see every type.
allow $1_t kernel_t:system { ipc_info };

# When the user domain runs ps, there will be a number of access
# denials when ps tries to search /proc.  Do not audit these denials.
dontaudit $1_t domain:dir r_dir_perms;
dontaudit $1_t domain:notdevfile_class_set r_file_perms;

# Some shells ask for w access to utmp, but will operate
# correctly without it.  Do not audit write denials to utmp.
dontaudit $1_t initrc_var_run_t:file { read write };

# do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
dontaudit $1_t tmpfile:dir_file_class_set getattr;

ifdef(`xdm.te', `
# Connect to the X server run by the X Display Manager.
can_unix_connect($1_t, xdm_t)
allow $1_t xdm_tmp_t:sock_file rw_file_perms;
allow $1_t xdm_tmp_t:dir r_dir_perms;
allow $1_t xdm_xserver_tmp_t:sock_file { read write };
allow $1_t xdm_xserver_tmp_t:dir search;

ifelse(`$1', sysadm, `', `
file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_xauth_t, file)
')dnl end ifelse sysadm
')dnl end ifdef xdm.te

# Access the sound device.
allow $1_t sound_device_t:chr_file { getattr read write ioctl };

# Allow reading dpkg origins file
ifdef(`dpkg.te', `
r_dir_file($1_t, etc_dpkg_t)
')

ifdef(`ftpd.te', `
# uncomment the following for FTP access to all home directories
# or you can just enable FTP access for certain user domains in the ftpd.te
# file
#file_type_auto_trans(ftpd_t, $1_home_dir_t, $1_home_t)
')

')


###########################################################################
#
# Domains for ordinary users.
#
undefine(`full_user_role')
define(`full_user_role', `

# user_t/$1_t is an unprivileged users domain.
type $1_t, domain, userdomain, unpriv_userdomain;

# $1_r is authorized for $1_t for the initial login domain.
role $1_r types $1_t;
allow system_r $1_r;

# user domains are granted the permissions common to most domains.
every_domain($1_t)
# $1_t is also granted permissions specific to user domains.
user_domain($1)

# When an ordinary user domain runs su, su may try to
# update the /root/.Xauthority file, and the user shell may
# try to update the shell history. This isnt allowed, but 
# we dont need to audit it.
ifdef(`su.te', `
dontaudit $1_su_t sysadm_home_t:dir  { read getattr search write add_name remove_name };
dontaudit $1_su_t sysadm_home_t:file { read getattr create write link unlink };')
dontaudit $1_t    sysadm_home_t:dir { read search getattr };
dontaudit $1_t    sysadm_home_t:file { read getattr append };

ifdef(`syslogd.te', `
# Some programs that are left in $1_t will try to connect
# to syslogd, but we do not want to let them generate log messages.
# Do not audit.
dontaudit $1_t devlog_t:sock_file { read write };
dontaudit $1_t syslogd_t:unix_dgram_socket sendto;
')

# stop warnings about "ls -l" on directories with unlabelled files
dontaudit $1_t file_t:{ dir file lnk_file } getattr;
')

undefine(`in_user_role')
define(`in_user_role', `
role user_r types $1;
#role staff_r types $1;
')


--Boundary-00=_/AiU+nlxfzt29dK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
