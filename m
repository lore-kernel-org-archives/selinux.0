Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA29809
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 11:51:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA08425
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 15:51:07 GMT
Received: from smtpproxy2.mitre.org (smtpproxy2.mitre.org [192.80.55.70])
	by jazzswing.ncsc.mil  with ESMTP id PAA08417
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 15:51:06 GMT
Message-ID: <3D456490.F870B1C7@mitre.org>
Date: Mon, 29 Jul 2002 11:51:44 -0400
From: Michelle Gosselin <mgoss@mitre.org>
MIME-Version: 1.0
To: giovanni <giovanni@unirel.it>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Apache on SELinux
References: <200207291212.26166.giovanni@unirel.it>
Content-Type: multipart/mixed;
 boundary="------------40C810E3768304DD03B92A54"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------40C810E3768304DD03B92A54
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

MITRE has written policy statements for the Apache Web Server.  A paper
describing the Apache policy is available from both Sourceforge and the
MITRE public server.  

http://selinux.sourceforge.net/devel/policy.php3
http://www.mitre.org/support/papers/tech_papers_01/gosselin_apache/index.shtml

I've also attached an apache.te file and a brief summary of the policy. 
These files will be available on Sourceforge and the MITRE public server soon.

The summary discusses a change that we made to suexec. Once this change
has been approved for public release, we will make that available also.

- Michelle Gosselin 

giovanni wrote:
> 
> We are going to experiment apache web server on selinux. If someone has
> already done it, could give us some information or a configuration example?
> 
> Thanks
> 
> Giovanni Mugnai
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
--------------40C810E3768304DD03B92A54
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353";
 name="apache.te"
Content-Transfer-Encoding: 7bit
Content-Description: Unknown Document
Content-Disposition: inline;
 filename="apache.te"

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

#########################################################
# Apache types
#########################################################
# httpd_config_t is the type given to the configuration
# files for apache /etc/httpd/conf
#
type httpd_config_t, file_type, sysadmfile;

# httpd_log_files_t is the type that is given to the log files
# that httpd generates.  /var/log/httpd

type httpd_log_files_t, file_type, sysadmfile;

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

# httpd_admin_t has access to all of the httpd files, such as
# the configuration files and the log files.  They also 
# have access to system content and/or user content
#
type httpd_admin_t, domain;
role httpd_admin_r types httpd_admin_t;
every_domain(httpd_admin_t)

# httpd_t is the type that httpd process runs as
#
type httpd_t, domain;
role system_r types httpd_t;
every_domain(httpd_t)
domain_auto_trans(initrc_t, httpd_exec_t, httpd_t)
type_transition init_t httpd_exec_t:process httpd_t;

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
role user_r types httpd_user_script_process_t;
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
allow httpd_user_script_process_t file_t:dir r_dir_perms;

allow httpd_user_script_process_t random_device_t:chr_file r_file_perms;

allow httpd_sys_script_process_t initrc_t:fd {use};
allow httpd_sys_script_process_t init_t:fd {use};
allow httpd_sys_script_process_t file_t:dir r_dir_perms;

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
allow httpd_user_script_process_t user_home_t:dir {search};
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

###########################################################################
# Allow the users and httpd admin to edit or create content
##########################################################################
allow httpd_admin_t httpd_sys_content_t:file create_file_perms;
allow httpd_admin_t httpd_user_content_t:file create_file_perms;
allow httpd_admin_t httpd_sys_content_t:dir rw_dir_perms;
allow httpd_admin_t httpd_user_content_t:dir rw_dir_perms;
allow httpd_admin_t httpd_sys_content_t:lnk_file {create};
allow httpd_admin_t httpd_user_content_t:lnk_file {create};

allow user_t httpd_user_content_t:file create_file_perms;
allow user_t httpd_user_content_t:dir create_dir_perms;
allow user_t httpd_user_content_t:lnk_file {create};

#######################################################################
# Allow the users and admins to edit or create scripts
####################################################################
allow user_t httpd_user_script_t:file create_file_perms;
allow user_t httpd_user_script_t:file {relabelto};
allow user_t httpd_user_script_t:dir create_dir_perms;
allow user_t httpd_user_script_t:lnk_file {create};

allow httpd_admin_t httpd_sys_script_t:file create_file_perms;
allow httpd_admin_t httpd_sys_script_t:dir create_dir_perms;
allow httpd_admin_t httpd_sys_script_t:lnk_file {create};

######################################################################
# Allow the users and httpd admins to create htaccess files
#####################################################################
allow httpd_admin_t httpd_sys_htaccess_t:file create_file_perms;
allow httpd_admin_t httpd_sys_htaccess_t:lnk_file {create};

allow user_t httpd_user_htaccess_t:file create_file_perms;
allow user_t httpd_user_htaccess_t:lnk_file {create};

#########################################################################
# Allow users and httpd admins to create files or directories 
# that scripts are able to read, write, or append to
###########################################################################
allow httpd_admin_t httpd_sys_script_r_t:file create_file_perms;
allow httpd_admin_t httpd_sys_script_r_t:lnk_file {create};
allow httpd_admin_t httpd_sys_script_r_t:dir create_dir_perms;

allow httpd_admin_t httpd_user_script_r_t:file create_file_perms;
allow httpd_admin_t httpd_user_script_r_t:lnk_file {create};
allow httpd_admin_t httpd_user_script_r_t:dir create_dir_perms;

allow user_t httpd_user_script_r_t:file create_file_perms;
allow user_t httpd_user_script_r_t:lnk_file {create};
allow user_t httpd_user_script_r_t:dir create_dir_perms;

allow httpd_admin_t httpd_sys_script_rw_t:file rw_file_perms;
allow httpd_admin_t httpd_sys_script_rw_t:lnk_file {create};
allow httpd_admin_t httpd_sys_script_rw_t:dir rw_dir_perms;

allow httpd_admin_t httpd_user_script_rw_t:file rw_file_perms;
allow httpd_admin_t httpd_user_script_rw_t:lnk_file {create};
allow httpd_admin_t httpd_user_script_rw_t:dir rw_dir_perms;

allow user_t httpd_user_script_rw_t:file rw_file_perms;
allow user_t httpd_user_script_rw_t:lnk_file {create};
allow user_t httpd_user_script_rw_t:dir rw_dir_perms;

allow httpd_admin_t httpd_sys_script_a_t:file ra_file_perms;
allow httpd_admin_t httpd_sys_script_a_t:lnk_file {create};
allow httpd_admin_t httpd_sys_script_a_t:dir ra_dir_perms;

allow httpd_admin_t httpd_user_script_a_t:file ra_file_perms;
allow httpd_admin_t httpd_user_script_a_t:lnk_file {create};
allow httpd_admin_t httpd_user_script_a_t:dir ra_dir_perms;

allow user_t httpd_user_script_a_t:file ra_file_perms;
allow user_t httpd_user_script_a_t:lnk_file {create};
allow user_t httpd_user_script_a_t:dir ra_dir_perms;

####################################
# Allow a domain change to httpd_admin_t via the newrole command
#####################################
allow httpd_admin_t newrole_t:fd use;
allow httpd_admin_t newrole_t:process {sigchld};
can_exec(httpd_admin_t, shell_exec_t)
allow httpd_admin_t shell_exec_t:file {entrypoint};
allow newrole_t httpd_admin_t:process {transition};
allow newrole_t httpd_admin_t:fd {create};

####################################
# Allow a system administrator to use newrole 
# to change their type to httpd_admin_t
#####################################
allow httpd_admin_t sysadm_tty_device_t:chr_file rw_file_perms;
allow httpd_admin_t sysadm_devpts_t:chr_file rw_file_perms;
allow httpd_admin_t sysadm_t:fd {create};
allow httpd_admin_t sysadm_t:process {transition};

######################################
# Allow user_t to become httpd_admin_t
# by using newrole
######################################

allow httpd_admin_t user_tty_device_t:chr_file rw_file_perms;
allow httpd_admin_t user_devpts_t:chr_file rw_file_perms;
allow httpd_admin_t user_t:fd {create};
allow httpd_admin_t user_t:process {transition};

#############################################################################
# Allow the httpd admin to use chcon to change contexts  on scripts, web pages,
# and htaccess files.  Allow users to change the contexts on their info
###########################################################################
allow httpd_admin_t httpd_sys_script_t:dir  {relabelto};
allow httpd_admin_t httpd_sys_script_a_t:dir  {relabelto};
allow httpd_admin_t httpd_sys_script_r_t:dir  {relabelto};
allow httpd_admin_t httpd_sys_script_rw_t:dir  {relabelto};

allow httpd_admin_t httpd_user_script_t:dir  {relabelto};
allow httpd_admin_t httpd_user_script_a_t:dir  {relabelto};
allow httpd_admin_t httpd_user_script_r_t:dir  {relabelto};
allow httpd_admin_t httpd_user_script_rw_t:dir  {relabelto};

allow httpd_admin_t httpd_sys_script_a_t:file  {relabelto};
allow httpd_admin_t httpd_sys_script_r_t:file  {relabelto};
allow httpd_admin_t httpd_sys_script_rw_t:file  {relabelto};

allow httpd_admin_t httpd_user_script_r_t:file  {relabelto};
allow httpd_admin_t httpd_user_script_rw_t:file  {relabelto};
allow httpd_admin_t httpd_user_script_a_t:file  {relabelto};

allow user_t httpd_user_script_r_t:file  {relabelto};
allow user_t httpd_user_script_rw_t:file  {relabelto};
allow user_t httpd_user_script_a_t:file  {relabelto};

allow user_t httpd_user_script_t:dir {relabelto};
allow user_t httpd_user_script_r_t:dir  {relabelto};
allow user_t httpd_user_script_rw_t:dir  {relabelto};
allow user_t httpd_user_script_a_t:dir  {relabelto};

allow httpd_admin_t httpd_sys_content_t:dir {relabelto};
allow httpd_admin_t httpd_user_content_t:dir {relabelto};

allow user_t httpd_user_content_t:dir {relabelto relabelfrom};

allow httpd_admin_t httpd_sys_content_t:file {relabelto};
allow httpd_admin_t httpd_sys_htaccess_t:file {relabelto};
allow httpd_admin_t httpd_user_content_t:file {relabelto};
allow httpd_admin_t httpd_user_htaccess_t:file {relabelto};

allow user_t httpd_user_content_t:file {relabelto};
allow user_t httpd_user_htaccess_t:file {relabelto};

allow httpd_admin_t httpd_sys_script_t:dir  {transition};
allow httpd_admin_t httpd_sys_script_a_t:dir  {transition};
allow httpd_admin_t httpd_sys_script_r_t:dir  {transition};
allow httpd_admin_t httpd_sys_script_rw_t:dir  {transition};

allow httpd_admin_t httpd_user_script_t:dir  {transition};
allow httpd_admin_t httpd_user_script_a_t:dir  {transition};
allow httpd_admin_t httpd_user_script_r_t:dir  {transition};
allow httpd_admin_t httpd_user_script_rw_t:dir  {transition};

allow user_home_t httpd_user_script_t:dir {transition};
allow user_home_t httpd_user_script_r_t:dir  {transition};
allow user_home_t httpd_user_script_rw_t:dir  {transition};
allow user_home_t httpd_user_script_a_t:dir  {transition};

allow httpd_admin_t httpd_sys_content_t:dir {transition};
allow httpd_admin_t httpd_user_content_t:dir {transition};

allow user_home_t httpd_user_content_t:dir {transition};

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

################################
# Rules for httpd_admin_t
#################################
# Allow httpd_admin_t to do everything user_t can do
#################################
#clone user_t httpd_admin_t;
######################################
# Allow httpd_admin_t to edit the server config files
######################################
allow httpd_admin_t httpd_config_t:file create_file_perms;
allow httpd_admin_t httpd_config_t:dir rw_dir_perms;
allow httpd_admin_t httpd_config_t:lnk_file link_file_perms;
allow httpd_admin_t httpd_config_t:security { sid_to_context };
######################################################
# Allow the httpd_admin_t to view or edit the web server log files
#######################################################
allow httpd_admin_t httpd_log_files_t:file create_file_perms;
allow httpd_admin_t httpd_log_files_t:dir rw_dir_perms ;
allow httpd_admin_t httpd_log_files_t:security { sid_to_context };
allow httpd_admin_t httpd_log_files_t:lnk_file link_file_perms;
##################################################
# Allow the httpd_admin_t to view files in /etc/httpd/modules
# directory.  This is where the module libraries for 
# Apache are kept
##################################################
allow httpd_admin_t httpd_modules_t:dir r_dir_perms;
allow httpd_admin_t httpd_modules_t:file r_file_perms;

####################################################
# Allow the httpd_admin_t to do the following to httpd
# executable and process if you want the HTTPd admin role to run the binary
#######################################################
#allow httpd_admin_t httpd_exec_t:file rx_file_perms;
#allow httpd_admin_t httpd_t:security { sid_to_context };
#allow httpd_admin_t httpd_t:process{ sigkill sigstop signal transition};

########################################
# When the admin starts the server, the server wants to acess
# the TTY or PTY associated with the session. The httpd appears
# to run correctly without this permission, so the permission
# are commented out here. If you decide that access is needed,
# then uncomment, but be aware that this will grant httpd access
# to all sysadm_r TTYs and PTYs.
##################################################
#allow httpd_t sysadm_tty_device_t:chr_file rw_file_perms;
#allow httpd_t sysadm_devpts_t:chr_file rw_file_perms;
###########################
# Allow httpd to receive messages from the network card
########################################
#allow httpd_t netmsg_eth0_t:tcp_socket{acceptfrom};

###################
# Allow httpd to search users diretories
######################
allow httpd_t user_home_t:dir {search};
allow httpd_t user_home_t:file {getattr read};

############################################################################
# Allow the httpd_t the capability to bind to a port and various other stuff
############################################################################
allow httpd_t httpd_t:capability {chown net_bind_service setgid setuid kill};

#################################################
# Allow the httpd_t to read the web servers config files
###################################################
allow httpd_t httpd_config_t:file r_file_perms;
allow httpd_t httpd_config_t:dir r_dir_perms;
##################################################

##################################################
# Allow the httpd_t to read, append, and find the log files
####################################################
allow httpd_t httpd_log_files_t:file{read append create getattr};
allow httpd_t httpd_log_files_t:dir  r_dir_perms;

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


--------------40C810E3768304DD03B92A54
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353";
 name="apache_policy.txt"
Content-Transfer-Encoding: 7bit
Content-Description: Unknown Document
Content-Disposition: inline;
 filename="apache_policy.txt"

General Policy for Apache 

The Apache server is allowed to 

   * accept user requests for web pages, 
   * read web pages, 
   * execute scripts, 
   * check password protection on web pages and scripts, 
   * display web pages back to the user, 
   * send and receive messages to and from the network 
   * bind to port 80 
   * read web configuration files located in /etc/httpd/conf 
   * read and append to web log files located in /var/log/httpd 
   * execute system libraries and Apache-specific libraries 

The system boot process is allowed to start the Apache server. 

The web administrator is allowed to 

   * create and modify system web pages, 
   * modify and execute system scripts, 
   * specify password protection on system web pages and scripts, and 
   * specify which files can be accessed by system scripts 

Users are allowed to 

   * send requests for web pages to the Apache server, 
   * modify user web pages, 
   * modify and execute user scripts, 
   * specify password protection on their web pages and scripts, and 
   * specify which files can be accessed by user scripts. 

Script processes are allowed to 

   * execute script interpreters and libraries 
   * read, write, and append specially marked files. 
  
  
Role and Type Definitions 

A new role and several new types were defined to implement policy rules for 
Apache. They are listed below: 

httpd_adm_r		       Web administrator 
httpd_t			       Apache daemon 
httpd_sys_content_t	       System web pages 
httpd_user_content_t	       User web pages 
httpd_sys_script_t	       System script files 
httpd_user_script_t	       User script files 
httpd_sys_htaccess_t	       Access files for system web directories 
httpd_user_htaccess_t	       Access files for user web directories 
httpd_config_t		       Apache configuration files in /etc/httpd/conf 
httpd_log_files_t	       Apache log files located in /var/log/httpd 
httpd_modules_t		       Libraries included with Apache 
httpd_exec_t		       Apache executable file 
httpd _admin_t		       Web administrator shell process 
httpd_sys_script_process_t     System script process 
httpd_user_script_process_t    User script process 
httpd_sys_script_r_t	       Files that can be read by system scripts 
httpd_sys_script_rw_t	       Files that be read and written by system scripts
httpd_sys_script_a_t	       Files that can be appended by system scripts 
httpd_user_script_r_t	       Files that can be read by user scripts 
httpd_user_script_rw_t	       Files that can be read and written to by user 
			       scripts 
httpd_user_script_a_t	       Files that be appended to by user scripts 
httpd_suexec_t		       Suexec executable file 
httpd_suexec_process_t	       User script process with user privleges 

Policy Stated with Type Definitions 

The policy states that a process of type httpd_t (the Apache daemon) can 

   * connect to the network and bind to port 80, 
   * read files of type httpd_sys_content_t (system web pages) or 
     httpd_user_content_t (user web pages) 
   * execute files of type httpd_sys_script_t (system scripts) and type 
     httpd_user_script_t (user scripts) 
   * read files of type httpd_sys_htaccess_t (files that provide password 
     protection on directories containing system web pages and scripts) and 
     httpd_user_htaccess_t (files that provide password protection on 
     directories containing user web pages and scripts) 
   * read files of type httpd_config_t (web configuration files) 
   * read and append files of type httpd_log_files_t (log files) 
   * execute files of type lib_t (system libraries) and httpd_modules_t 
     (httpd libraries) 

The policy allows files of type initrc_t to execute files of type 
httpd_exec_t. This allows the boot process to run the Apache daemon. 

The policy allows a web administrator (a user with the httpd_adm_r role) to 
change the context of his shell to httpd_admin_t. The policy allows a 
process with this context to 

   * execute files of type httpd_exec_t (the Apache daemon) 
   * modify files of type httpd_sys_content_t (system web pages) 
   * modify and execute files of type httpd_sys_script_t (system scripts) 
   * create files of type httpd_sys_htaccess_t (password protection files) 
   * create files of type httpd_sys_script_r_t (files or directories that 
     can be read by system scripts ), httpd_sys_script_rw_t, (files or 
     directories that can be read and written by system scripts), and 
     httpd_sys_script_a_t (files or directories that can be appended by 
     system scripts). 
   * read and write files of type httpd_config_t and httpd_log_files_t (the 
     web configuration files and web log files) 

The policy allows a user to 

   * send requests to port 80 either locally or via the network, 
   * modify files of type httpd_user_content_t (user web pages) 
   * modify and execute files of type httpd_user_script_t (user scripts) 
   * create files of type httpd_user_htaccess_t (password protection files) 
   * create files of type httpd_user_script_r_t (files that can be read by 
     user scripts ), httpd_user_script_rw_t, (files that can be read and 
     written by user scripts), and httpd_user_script_a_t (files that can be 
     appended by user scripts). 

Apache can be configured to either call or not call suexec prior to running a 
script.  With RedHat 7.1, the default configuration is for Apache to call 
suexec.  Calling suexec allows the script process to run with the privileges of
the user owning the script.  We modified suexec to also transition the user 
identifier in the security context to the user identifier of the script.  
Therefore, the user identifier associated with the script will be recorded in
log files if the script does something malicious.  If suexec is not called, the
user identifier of the script is not recorded, but the script will not have
user privileges. 

When a script is executed, the following security context transitions 
automatically take place: 

   * When the daemon executes a system script (httpd_sys_script_t), the 
     process type transitions to httpd_sys_script_process_t. 
   * When the daemon executes a user script (httpd_user_script_t) and 
     Apache is configured to use the modified suexec to run user scripts , 
     the user id of the process changes to the user id associated with the 
     script, the role transitions to user_r and the type first transitions to 
     httpd_suexec_process_t and then transitions the 
     httpd_user_script_process_t. The resulting process runs with user level 
     premissions. 
   * When the daemon executes a user script and Apache is not configured 
     to use modified suexec to run user scripts, the user id and role do not 
     change. The type transitions to httpd_user_script_t. 
   * When a user executes a user script, the process type transitions to 
     httpd_user_script_process_t. 

The policy allows processes of type httpd_sys_script_process_t (system 
script processes) and httpd_user_script_process_t to 

   * execute files of type bin_t (scripts) and 
   * execute files of type lib_t (libraries). 

The policy allows processes of type httpd_sys_script_process_t (system 
script processes) to 

   * read files of type httpd_sys_script_r_t, 
   * read and write files of type httpd_sys_script_rw_t, and 
   * apend files of type httpd_sys_script_a_t. 

The policy allows processes of type httpd_user_script_process_t (user script 
processes) to 

   * read files of type httpd_user_script_r_t, 
   * read and write files of type httpd_user_script_rw_t, and 
   * apend files of type httpd_user_script_a_t. 

Everything not explicitly allowed by the policy is denied. 
--------------40C810E3768304DD03B92A54--



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
