From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: apache-ssl mods for Debian
Date: Mon, 12 Apr 2004 16:29:46 +1000
Cc: "SELinux" <SELinux@tycho.nsa.gov>
References: <20040411140514.B157F3A4054@abyss.simplyaquatics.com>
In-Reply-To: <20040411140514.B157F3A4054@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_adjeA4ex8jRGgL8"
Message-Id: <200404121629.46537.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_adjeA4ex8jRGgL8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 12 Apr 2004 00:05, "Ed Street" <edstreet@street-tek.com> wrote:
> I have included 2 patches I needed to get apache-ssl working under SID.

+#needed to read /var/www
+r_dir_file(httpd_t, var_t)

This should not be needed, see the following in apache.fc:
/var/www                -d      system_u:object_r:httpd_sys_content_t

+allow httpd_t httpd_exec_t:dir { search };

I think it would be best to use the "--" type specifier on the httpd_exec_t 
lines so that we don't have a directory with that type, see the attached 
apache.fc.

For exec'ing httpd_exec_t and for creating the sock_file I added the 
following:
can_exec(httpd_t, httpd_exec_t)
file_type_auto_trans(httpd_t, var_run_t, httpd_var_run_t, sock_file)

I've attached my new Apache policy to this message, try it out and let me know 
how it goes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_adjeA4ex8jRGgL8
Content-Type: text/plain;
  charset="iso-8859-1";
  name="apache.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="apache.fc"

# apache
HOME_DIR/((www)|(web)|(public_html))(/.+)? system_u:object_r:httpd_ROLE_content_t
/var/www		-d	system_u:object_r:httpd_sys_content_t
/var/www/html(/.*)?		system_u:object_r:httpd_sys_content_t
/var/www/mrtg(/.*)?		system_u:object_r:httpd_sys_content_t
/var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
/usr/lib(64)?/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
/var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_exec_t
/var/www/icons(/.*)?		system_u:object_r:httpd_sys_content_t
/var/cache/httpd(/.*)?		system_u:object_r:httpd_cache_t
/etc/httpd		-d	system_u:object_r:httpd_config_t
/etc/httpd/conf.*		system_u:object_r:httpd_config_t
/etc/httpd/logs			system_u:object_r:httpd_log_t
/etc/httpd/modules		system_u:object_r:httpd_modules_t
/etc/apache(2)?(/.*)?		system_u:object_r:httpd_config_t
/etc/vhosts		--	system_u:object_r:httpd_config_t
/usr/lib(64)?/apache(/.*)?		system_u:object_r:httpd_modules_t
/usr/lib(64)?/apache2/modules(/.*)?	system_u:object_r:httpd_modules_t
/usr/lib(64)?/httpd(/.*)?		system_u:object_r:httpd_modules_t
/usr/sbin/httpd		--	system_u:object_r:httpd_exec_t
/usr/sbin/apache(2)?	--	system_u:object_r:httpd_exec_t
/usr/sbin/suexec	--	system_u:object_r:httpd_suexec_exec_t
/usr/lib(64)?/cgi-bin/(nph-)?cgiwrap(d)? -- system_u:object_r:httpd_suexec_exec_t
/usr/lib(64)?/apache(2)?/suexec(2)? -- system_u:object_r:httpd_suexec_exec_t
/var/log/httpd(/.*)?		system_u:object_r:httpd_log_t
/var/log/apache(2)?(/.*)?	system_u:object_r:httpd_log_t
/var/log/cgiwrap.log.*	--	system_u:object_r:httpd_log_t
/var/cache/ssl.*\.sem	--	system_u:object_r:httpd_cache_t
/var/cache/mod_ssl(/.*)?	system_u:object_r:httpd_cache_t
/var/run/apache(2)?.pid.* --	system_u:object_r:httpd_var_run_t
/etc/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_config_t
/usr/lib/apache-ssl(/.*)? --	system_u:object_r:httpd_exec_t
/usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
/var/log/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_log_t
/var/run/apache-ssl(2)?.pid.* -- system_u:object_r:httpd_var_run_t
/var/run/gcache_port	--	system_u:object_r:httpd_exec_t

--Boundary-00=_adjeA4ex8jRGgL8
Content-Type: text/plain;
  charset="iso-8859-1";
  name="apache.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
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
type http_port_t, port_type;
type http_cache_port_t, port_type;

#########################################################
# Apache types
#########################################################
# httpd_config_t is the type given to the configuration
# files for apache /etc/httpd/conf
#
type httpd_config_t, file_type, sysadmfile;

append_logdir_domain(httpd)
#can read /etc/httpd/logs
allow httpd_t httpd_log_t:lnk_file { read };

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

allow httpd_t sysctl_kernel_t:dir search;
allow httpd_t sysctl_kernel_t:file read;

# for modules that want to access /etc/mtab and /proc/meminfo
allow httpd_t { proc_t etc_runtime_t }:file { getattr read };

# setup the system domain for system CGI scripts
apache_domain(sys)

# The following are types for SUEXEC,which runs user scripts as their
# own user ID
#
daemon_sub_domain(httpd_t, httpd_suexec)
allow httpd_t httpd_suexec_exec_t:file read;

#########################################################
# Permissions for running child processes and scripts
##########################################################

allow httpd_suexec_t self:capability { setuid setgid };

allow httpd_suexec_t httpd_log_t:dir search;

allow httpd_suexec_t var_log_t:dir search;
allow httpd_suexec_t home_root_t:dir search;
allow httpd_suexec_t httpd_log_t:file { append getattr };
allow httpd_suexec_t httpd_t:fifo_file getattr;
allow httpd_suexec_t self:unix_stream_socket create_socket_perms;

allow httpd_suexec_t etc_t:file { getattr read };
read_locale(httpd_suexec_t)

# for shell scripts
allow httpd_suexec_t bin_t:dir search;
allow httpd_suexec_t bin_t:lnk_file read;
can_exec(httpd_suexec_t, { bin_t shell_exec_t })

ifdef(`mta.te', `
# apache should set close-on-exec
dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
dontaudit { system_mail_t mta_user_agent } httpd_t:unix_stream_socket { read write };
')

uses_shlib(httpd_t)
allow httpd_t { usr_t lib_t }:file { getattr read ioctl };
allow httpd_t usr_t:lnk_file read;

# for tomcat
r_dir_file(httpd_t, var_lib_t)

# execute perl
allow httpd_t { bin_t sbin_t }:dir search;
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
allow httpd_t self:capability { chown dac_override kill setgid setuid net_bind_service sys_tty_config };

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
allow httpd_t etc_t:lnk_file read;

# Several options for handling SSI exec cmd elements:
# Option #1:  Do not support them at all.  This is the default, since
# httpd_t is not permitted to execute shell_exec_t.
# Option #2:  Run SSI executables in the same domain as system CGI scripts.
# Uncomment the following line to enable:
#domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_t)
# Option #3:  Run SSI executables directly in the httpd_t domain.  This means
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
allow httpd_php_t mysqld_var_run_t:dir { search };
allow httpd_php_t mysqld_var_run_t:sock_file { write };
')

--Boundary-00=_adjeA4ex8jRGgL8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
