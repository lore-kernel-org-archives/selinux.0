Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7I8jvrT018861
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 04:45:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7I8jDho003812
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 08:45:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: bug in policy (1.14-3+?) with apache.te unused
Date: Wed, 18 Aug 2004 18:45:50 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040817112916.GN18321@lkcl.net>
In-Reply-To: <20040817112916.GN18321@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+cxIBmDfQ8pfsNd"
Message-Id: <200408181845.50618.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_+cxIBmDfQ8pfsNd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 17 Aug 2004 21:29, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i upgraded to 1.14-6 on the policycoreutils and i get
> httpd_sysadm_content_t does not exist in file_contexts
> on a make relabel.

That's a minor bug in the apache policy for Debian, I'll fix it in the next 
upload.

> so.... well, i figured okay, let's make apache.te unused
> (as i should have done in the first place) because apache
> isn't on this system.
>
> i get a compile error on openca.te not being able to find
> httpd_t.

openca-ca.te depends on apache.te .  Why do you want to use openca without 
Apache?  Is it usable?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_+cxIBmDfQ8pfsNd
Content-Type: text/plain;
  charset="iso-8859-1";
  name="openca-ca.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openca-ca.te"

#DESC OpenCA - Open Certificate Authority
#
# Author:  Brian May <bam@snoopy.apana.org.au>
# X-Debian-Packages:
# Depends: apache.te
#

#################################
#
# domain for openCA cgi-bin scripts.
#
# Type that system CGI scripts run as
#
type openca_ca_t, domain;
role system_r types openca_ca_t;
uses_shlib(openca_ca_t)

# Types that system CGI scripts on the disk are 
# labeled with
#
type openca_ca_exec_t, file_type, sysadmfile;

# When the server starts the script it needs to get the proper context
#
ifdef(`apache.te', `
domain_auto_trans(httpd_t, openca_ca_exec_t, openca_ca_t)

#
# Allow httpd daemon to search /usr/share/openca
#
allow httpd_t openca_usr_share_t:dir { getattr search };

################################################################
# Allow the web server to run scripts and serve pages
##############################################################
allow httpd_t bin_t:file { read execute }; # execute perl

allow httpd_t openca_ca_exec_t:file {execute getattr read};
allow httpd_t openca_ca_t:process {signal sigkill sigstop};
allow httpd_t openca_ca_t:process {transition};
allow httpd_t openca_ca_exec_t:dir r_dir_perms;

##################################################################
# Allow the script to get the file descriptor from the http deamon
# and send sigchild to http deamon
#################################################################
allow openca_ca_t httpd_t:process {sigchld};
allow openca_ca_t httpd_t:fd use;
allow openca_ca_t httpd_t:fifo_file {getattr write};

############################################
# Allow scripts to append to http logs
#########################################
allow openca_ca_t httpd_log_t:file { append getattr };
')

#############################################################
# Allow the script access to the library files so it can run
#############################################################
can_exec(openca_ca_t, lib_t)

########################################################################
# The script needs to inherit the file descriptor and find the script it
# needs to run
########################################################################
allow openca_ca_t initrc_t:fd {use};
allow openca_ca_t init_t:fd {use};
allow openca_ca_t default_t:dir r_dir_perms;
allow openca_ca_t random_device_t:chr_file r_file_perms;

#######################################################################
# Allow the script to return its output
######################################################################
#allow openca_ca_t httpd_var_run_t: file rw_file_perms;
allow openca_ca_t null_device_t: chr_file rw_file_perms;
ifdef(`apache.te', `
allow openca_ca_t httpd_cache_t: file rw_file_perms;
')

###########################################################################
# Allow the script interpreters to run the scripts.  So
# the perl executable will be able to run a perl script
#########################################################################
can_exec(openca_ca_t, bin_t)

############################################################################
# Allow the script process to search the cgi directory, and users directory
##############################################################################
allow openca_ca_t openca_ca_exec_t:dir search;

#
# Allow access to writeable files under /etc/openca
#
allow openca_ca_t openca_etc_writeable_t:file create_file_perms;
allow openca_ca_t openca_etc_writeable_t:dir create_dir_perms;

#
# Allow access to other files under /etc/openca
#
allow openca_ca_t openca_etc_t:file r_file_perms;
allow openca_ca_t openca_etc_t:dir r_dir_perms;

#
# Allow access to private CA key
#
allow openca_ca_t openca_var_lib_keys_t:file create_file_perms;
allow openca_ca_t openca_var_lib_keys_t:dir create_dir_perms;

#
# Allow access to other /var/lib/openca files
#
allow openca_ca_t openca_var_lib_t:file create_file_perms;
allow openca_ca_t openca_var_lib_t:dir create_dir_perms;

#
# Allow access to other /usr/share/openca files
#
allow openca_ca_t openca_usr_share_t:file r_file_perms;
allow openca_ca_t openca_usr_share_t:lnk_file r_file_perms;
allow openca_ca_t openca_usr_share_t:dir r_dir_perms;

# /etc/openca standard files
type openca_etc_t, file_type, sysadmfile;

# /etc/openca template files
type openca_etc_in_t, file_type, sysadmfile;

# /etc/openca writeable (from CGI script) files
type openca_etc_writeable_t, file_type, sysadmfile;

# /var/lib/openca
type openca_var_lib_t, file_type, sysadmfile;

# /var/lib/openca/crypto/keys
type openca_var_lib_keys_t, file_type, sysadmfile;

# /usr/share/openca/crypto/keys
type openca_usr_share_t, file_type, sysadmfile;

--Boundary-00=_+cxIBmDfQ8pfsNd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
