From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: apache 2 patch
Date: Thu, 24 Oct 2002 12:21:22 +0200
References: <20021024115304.A31446@lemuria.org>
In-Reply-To: <20021024115304.A31446@lemuria.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_M3EHIIMBKZJYNGCWUX0V"
Message-Id: <200210241221.22217.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_M3EHIIMBKZJYNGCWUX0V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2002 11:53, Tom wrote:
> The attached patch fixes the apache policy so that apache 2 works fine
> in enforcing mode.

I've changed my policy tree to allow httpd_t to read symlinks with the config 
type.  I've attached the new policy file.

I don't know why you put in the line about sysadm_devpts_t as admin_tty_type 
covers that.

> However, I am very unhappy with the read/write permissions on the
> sysadm terminals. Here are some ideas I had to fix that, and I'd like
> to hear comments on them:
>
> a) try to fix the problem in the apache source.

No, there are hundreds of daemons that operate the same way and it's not 
practical to fix them all.

> b) write a wrapper that relabels the current (active) pts/tty and allow
>    permission to that label only

That will work as long as the current tty is not labelled back too soon.  A 
daemon generally expects to be able to fork, have it's parent exit, and still 
be able to write messages to the console.

My idea is to have run_init run a wrapper process (in the 
system_u:system_r:initrc_t context) that will open a new pseudo-tty.  
initrc_t is allowed to write to the sysadm terminal, and then we allow all 
daemons to write to the initrc_devpts_t.  Thus the daemon and all 
sub-processes it spawns can write to the pseudo-tty which is just a pipe back 
to the real terminal, so if you have 10 administrator logins and use one of 
them to start a daemon the daemon can not access the other 9 sessions in any 
way.  Also for daemons that demand read, getattr, and ioctl access to their 
terminal this can be granted too, read will never return anything, ioctl does 
nothing that impacts the administrator, and getattr really doesn't matter.

Now when a well behaved daemon finishes initialising itself to the stage where 
it can at least log things properly to syslog it will close file handles 0, 
1, and 2.  At that time the wrapper would exit.  If after a certain period of 
time (maybe a default of 2 seconds but would be a command line parameter) the 
daemon hadn't closed the file handles then the wrapper would display a 
warning message and exit.

I should get to work on this soon, my policy tree has a lot of statements 
allowing daemons access to the administrator tty devices.  This is a 
potential security issue and a difference between my tree and the NSA tree 
that I don't want, however until I write such a wrapper it's necessary.  For 
Debian when given a choice between 100% security and 50% usability or 99% 
security and 90% usability I have to choose the latter.


PS  Please use the Unified mode of diff (IE the "-u" option).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_M3EHIIMBKZJYNGCWUX0V
Content-Type: text/plain;
  charset="iso-8859-1";
  name="apache.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apache.te"

#DESC APACHE web server
#
###############################################################################
#
# Policy file for running the Apache web server
#
# NOTES: 
#  This policy will work with SUEXEC enabled as part of the Apache
#  configuration. However, the user CGI scripts will run under the
#  system_u:system_r:httpd_user_script_process_t domain.
#
#  The user CGI scripts must be labeled with the httpd_user_script_t
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

# httpd_log_files_t is the type that is given to the log files
# that httpd generates.  /var/log/httpd

type httpd_log_files_t, file_type, sysadmfile, logfile;

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
type httpd_exec_t, file_type, sysadmfile, exec_type;

# httpd_t is the type that httpd process runs as
#
type httpd_t, domain, privlog;
role system_r types httpd_t;
every_domain(httpd_t)
allow httpd_t console_device_t:chr_file { read write };
domain_auto_trans(initrc_t, httpd_exec_t, httpd_t)
type_transition init_t httpd_exec_t:process httpd_t;

# for php
tmp_domain(httpd)

#
# A type for files in /var/run specific to httpd
#
type httpd_var_run_t, file_type, sysadmfile, pidfile;

#
# A type for tmpfs file system
#
type httpd_tmpfs_t, file_type, sysadmfile;

#This type is for system webpages
#
type httpd_sys_content_t, file_type, sysadmfile;

#This type is for user webpages
#
type httpd_user_content_t, file_type, sysadmfile;

# This type is used for system .htaccess files
#
type httpd_sys_htaccess_t, file_type, sysadmfile;

#This type is used for user .htaccess files
#
type httpd_user_htaccess_t, file_type, sysadmfile;

# Type that system CGI scripts run as
#
type httpd_sys_script_process_t, domain;
role system_r types httpd_sys_script_process_t;
every_domain(httpd_sys_script_process_t)

# Type that user CGI scripts run as
#
type httpd_user_script_process_t, domain;
role system_r types httpd_user_script_process_t;
in_user_role(httpd_user_script_process_t)
every_domain(httpd_user_script_process_t)

# Types that system CGI scripts on the disk are 
# labeled with
#
type httpd_sys_script_t, file_type, sysadmfile;

# Types that user CGI scripts on disk are
# labeled with
#
type httpd_user_script_t, file_type, sysadmfile;

# The following are the only areas that 
# system scripts can read, read/write, or 
# append to
#
type httpd_sys_script_r_t, file_type, sysadmfile;
type httpd_sys_script_rw_t, file_type, sysadmfile;
file_type_auto_trans(httpd_sys_script_process_t, tmp_t, httpd_sys_script_rw_t)
type httpd_sys_script_a_t, file_type, sysadmfile;

# The following are the only areas that 
# user scripts can read, read/write, or 
# append to
#
type httpd_user_script_r_t, file_type, sysadmfile;
type httpd_user_script_rw_t, file_type, sysadmfile;
file_type_auto_trans(httpd_user_script_process_t, tmp_t, httpd_user_script_rw_t)
type httpd_user_script_a_t, file_type, sysadmfile;

# The following are types for SUEXEC,which runs user scripts as their
# own user ID
#
type httpd_suexec_process_t, domain;
role system_r types httpd_suexec_process_t;
every_domain(httpd_suexec_process_t)
type httpd_suexec_exec_t, file_type, exec_type, sysadmfile;
#

#########################################################
# Permissions for running child processes and scripts
##########################################################
domain_auto_trans(httpd_t, httpd_suexec_exec_t, httpd_suexec_process_t)
domain_auto_trans(httpd_suexec_process_t, httpd_user_script_t, httpd_user_script_process_t)

allow httpd_suexec_process_t httpd_suexec_process_t:capability { setuid setgid };
allow httpd_suexec_process_t httpd_user_script_t:dir { search getattr };
allow httpd_suexec_process_t httpd_user_script_t:file { execute entrypoint };

allow httpd_suexec_process_t bin_t:file rx_file_perms;
allow httpd_suexec_process_t lib_t:file { execute };

allow httpd_suexec_process_t httpd_log_files_t:dir { search };
allow httpd_suexec_process_t httpd_log_files_t:file { append getattr };

allow httpd_suexec_process_t httpd_user_script_process_t:process { transition };

allow httpd_suexec_process_t httpd_t:fifo_file {getattr} ;
allow httpd_user_script_process_t httpd_t:fifo_file {getattr} ;

allow httpd_suexec_process_t httpd_var_run_t:file rw_file_perms;
allow httpd_suexec_process_t httpd_cache_t:file rw_file_perms;

# apache should set close-on-exec
dontaudit httpd_suexec_process_t httpd_t:unix_stream_socket { read write };
dontaudit { system_mail_t mta_user_agent } httpd_t:unix_stream_socket { read write };

#
# If a user starts a script by hand it gets the proper context
#
domain_auto_trans(user_t, httpd_user_script_t, httpd_user_script_process_t)

# When the server starts the script it needs to get the proper context
#
domain_auto_trans(httpd_t, httpd_user_script_t, httpd_user_script_process_t)
domain_auto_trans(httpd_t, httpd_sys_script_t, httpd_sys_script_process_t)

# If the httpd admin starts a script by hand it gets the proper context
#
domain_auto_trans(httpd_admin_t, httpd_sys_script_t, httpd_sys_script_process_t)
domain_auto_trans(httpd_admin_t, httpd_user_script_t, httpd_user_script_process_t)

#######################################################
# Allow the httpd admin to run stuff in the bin directory
#######################################################
can_exec(httpd_admin_t, bin_t)

#############################################################
# Allow the script access to the library files so it can run
#############################################################
can_exec(httpd_user_script_process_t, lib_t)
can_exec(httpd_sys_script_process_t, lib_t)

##################################################################
# Allow the script to get the file descriptor from the http deamon
# and send sigchild to http deamon
#################################################################
allow httpd_user_script_process_t httpd_t:process {sigchld};
allow httpd_user_script_process_t httpd_t:fd use;
allow httpd_user_script_process_t httpd_t:fifo_file { write };

allow httpd_sys_script_process_t httpd_t:process {sigchld};
allow httpd_sys_script_process_t httpd_t:fd use;
allow httpd_sys_script_process_t httpd_t:fifo_file {getattr write};

########################################################################
# The script needs to inherit the file descriptor and find the script it
# needs to run
########################################################################
allow httpd_user_script_process_t initrc_t:fd {use};
allow httpd_user_script_process_t init_t:fd {use};

allow httpd_user_script_process_t random_device_t:chr_file r_file_perms;

allow httpd_sys_script_process_t initrc_t:fd {use};
allow httpd_sys_script_process_t init_t:fd {use};

allow httpd_sys_script_process_t random_device_t:chr_file r_file_perms;

#######################################################################
# Allow the script to return its output
######################################################################

allow httpd_user_script_process_t httpd_var_run_t: file rw_file_perms;

allow httpd_user_script_process_t null_device_t: chr_file rw_file_perms;

allow httpd_user_script_process_t httpd_cache_t: file rw_file_perms;

allow httpd_sys_script_process_t httpd_var_run_t: file rw_file_perms;

allow httpd_sys_script_process_t null_device_t: chr_file rw_file_perms;

allow httpd_sys_script_process_t httpd_cache_t: file rw_file_perms;

###########################################################################
# Allow the script interpreters to run the scripts.  So
# the perl executable will be able to run a perl script
#########################################################################
can_exec(httpd_user_script_process_t, bin_t)
can_exec(httpd_sys_script_process_t, bin_t)

############################################################################
# Allow the script process to search the cgi directory, and users directory
##############################################################################
allow httpd_user_script_process_t httpd_user_script_t:dir {search add_name};
allow httpd_user_script_process_t home_root_t:dir { getattr search };
allow httpd_user_script_process_t user_home_dir_type:dir {getattr search};
allow httpd_user_script_process_t httpd_user_content_t:dir {search};
allow httpd_user_script_process_t httpd_sys_script_t:dir {search};

allow httpd_sys_script_process_t httpd_sys_script_t:dir {search add_name};
allow httpd_sys_script_process_t httpd_sys_content_t:dir {search};

#############################################################################
# Allow the scripts to read, read/write, append to the specified directories
# or files
############################################################################
allow httpd_user_script_process_t httpd_user_script_r_t:file r_file_perms;
allow httpd_user_script_process_t httpd_user_script_r_t:dir r_dir_perms;

allow httpd_user_script_process_t httpd_user_script_rw_t:file rw_file_perms;
allow httpd_user_script_process_t httpd_user_script_rw_t:dir rw_dir_perms;

allow httpd_user_script_process_t httpd_user_script_a_t:file ra_file_perms;
allow httpd_user_script_process_t httpd_user_script_a_t:dir ra_dir_perms;


#################
# For system scripts
#####################
allow httpd_sys_script_process_t httpd_sys_script_r_t:file r_file_perms;
allow httpd_sys_script_process_t httpd_sys_script_r_t:dir r_dir_perms;

allow httpd_sys_script_process_t httpd_sys_script_rw_t:file create_file_perms;
allow httpd_sys_script_process_t httpd_sys_script_rw_t:dir create_dir_perms;
allow httpd_sys_script_rw_t fs_t:filesystem {associate};

allow httpd_sys_script_process_t httpd_sys_script_a_t:file ra_file_perms;
allow httpd_sys_script_process_t httpd_sys_script_a_t:dir ra_dir_perms;

#######################################
# Allow users to create or edit user web content
#########################################

allow user_t httpd_user_content_t:file create_file_perms;
allow user_t httpd_user_content_t:dir create_dir_perms;
allow user_t httpd_user_content_t:lnk_file {create};

#######################################################################
# Allow the users to edit or create user scripts
####################################################################
allow user_t httpd_user_script_t:file create_file_perms;
allow user_t httpd_user_script_t:file {relabelto};
allow user_t httpd_user_script_t:dir create_dir_perms;
allow user_t httpd_user_script_t:lnk_file {create};

######################################################################
# Allow the users to create htaccess files
#####################################################################

allow user_t httpd_user_htaccess_t:file create_file_perms;
allow user_t httpd_user_htaccess_t:lnk_file {create};

#########################################################################
# Allow users to create files or directories 
# that scripts are able to read, write, or append to
###########################################################################

allow user_t httpd_user_script_r_t:file create_file_perms;
allow user_t httpd_user_script_r_t:lnk_file {create};
allow user_t httpd_user_script_r_t:dir create_dir_perms;

allow user_t httpd_user_script_rw_t:file rw_file_perms;
allow user_t httpd_user_script_rw_t:lnk_file {create};
allow user_t httpd_user_script_rw_t:dir rw_dir_perms;

allow user_t httpd_user_script_a_t:file ra_file_perms;
allow user_t httpd_user_script_a_t:lnk_file {create};
allow user_t httpd_user_script_a_t:dir ra_dir_perms;
allow user_t httpd_user_content_t:dir {relabelto relabelfrom};
allow user_t httpd_user_content_t:file {relabelto};
allow user_t httpd_user_htaccess_t:file {relabelto};

allow httpd_sys_script_t fs_t:filesystem  {associate};
allow httpd_sys_script_a_t fs_t:filesystem  {associate};
allow httpd_sys_script_r_t fs_t:filesystem  {associate};
allow httpd_sys_script_rw_t fs_t:filesystem  {associate};

allow httpd_user_script_t fs_t:filesystem  {associate};
allow httpd_user_script_a_t fs_t:filesystem  {associate};
allow httpd_user_script_r_t fs_t:filesystem  {associate};
allow httpd_user_script_rw_t fs_t:filesystem  {associate};

allow httpd_sys_content_t fs_t:filesystem {associate};
allow httpd_sys_htaccess_t fs_t:filesystem {associate};
allow httpd_user_content_t fs_t:filesystem {associate};
allow httpd_user_htaccess_t fs_t:filesystem {associate};


################################################################
# Allow the web server to run scripts and serve pages
##############################################################
allow httpd_t httpd_sys_content_t:file r_file_perms;
allow httpd_t httpd_sys_content_t:dir r_dir_perms;

allow httpd_t httpd_sys_htaccess_t: file r_file_perms;

allow httpd_t bin_t:file { read execute }; # execute perl

allow httpd_t httpd_sys_script_t:file {execute getattr read};
allow httpd_t httpd_sys_script_process_t:process {signal sigkill sigstop};
allow httpd_t httpd_sys_script_process_t:process {transition};
allow httpd_t httpd_sys_script_t:dir r_dir_perms;
allow httpd_t httpd_sys_script_rw_t:dir r_dir_perms;
allow httpd_t httpd_sys_script_rw_t:file r_file_perms;

allow httpd_t httpd_user_content_t:file r_file_perms;
allow httpd_t httpd_user_content_t:dir r_dir_perms;

allow httpd_t httpd_user_htaccess_t: file r_file_perms;

allow httpd_t httpd_user_script_t:file {execute getattr read};
allow httpd_t httpd_user_script_process_t:process {signal sigkill sigstop};
allow httpd_t httpd_user_script_process_t:process {transition};
allow httpd_t httpd_user_script_t:dir r_dir_perms;

allow httpd_t httpd_user_script_rw_t:file r_file_perms;
allow httpd_t httpd_user_script_rw_t:dir r_dir_perms;

########################################
# When the admin starts the server, the server wants to acess
# the TTY or PTY associated with the session. The httpd appears
# to run correctly without this permission, so the permission
# are commented out here. If you decide that access is needed,
# then uncomment, but be aware that this will grant httpd access
# to all sysadm_r TTYs and PTYs.
##################################################
allow httpd_t admin_tty_type:chr_file write;
dontaudit httpd_t admin_tty_type:chr_file { read write };

###########################
# Allow httpd to receive messages from the network card
########################################
#allow httpd_t netmsg_eth0_t:tcp_socket{acceptfrom};

###################
# Allow httpd to search users diretories
######################
allow httpd_t home_root_t:dir { getattr search };
allow httpd_t user_home_dir_type:dir { getattr search };
allow httpd_t user_home_type:dir { getattr search read };
# need ioctl for php3
allow httpd_t user_home_type:{ file lnk_file } { getattr read ioctl };
dontaudit httpd_t sysadm_home_dir_t:dir { getattr search };

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

##################################################
# Allow the httpd_t to access the files under /var/log/httpd
####################################################
allow httpd_t httpd_log_files_t:dir  rw_dir_perms;
allow httpd_t httpd_log_files_t:file create_file_perms;

############################################
# Allow scripts to append to http logs
#########################################
allow httpd_sys_script_process_t httpd_log_files_t:file {append};
allow httpd_user_script_process_t httpd_log_files_t:file {append};

#############################
# Allow httpd_t to get the file descriptor from init 
#####################
allow httpd_t init_t:fd use;
#allow httpd_t init_t:process { sigchld };

########################################
# Allow httpd_t access to the libraries
# that it needs
#########################################
can_exec(httpd_t, lib_t)

########################################
# Allow access to /dev/null
########################################
allow httpd_t null_device_t:chr_file rw_file_perms;

########################################
# Allow httpd_t to bind to the HTTP port
########################################
allow httpd_t { http_port_t http_cache_port_t }:tcp_socket name_bind;

###############################
# Allow httpd_t to put a pid file
# in /var/run
##############################
file_type_auto_trans(httpd_t, var_run_t, httpd_var_run_t)

###############################
# Allow httpd_t to put files in /var/cache
##############################
file_type_auto_trans(httpd_t, var_t, httpd_cache_t)

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
allow initrc_t httpd_user_script_rw_t:dir r_dir_perms;

##############################################
# Allow httpd_t to have access to files
# such as nisswitch.conf
###############################################
allow httpd_t etc_t:file { read getattr };

# Several options for handling SSI exec cmd elements:
# Option #1:  Don't support them at all.  This is the default, since
# httpd_t is not permitted to execute shell_exec_t.
# Option #2:  Run SSI exec's in the same domain as system CGI scripts.
# Uncomment the following line to enable:
#domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_process_t)
# Option #3:  Run SSI exec's directly in the httpd_t domain.  This means
# that they have the same permissions as the daemon.  Probably not a good idea.
# Uncomment the following line to enable:
#can_exec(httpd_t, shell_exec_t)


--------------Boundary-00=_M3EHIIMBKZJYNGCWUX0V--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
