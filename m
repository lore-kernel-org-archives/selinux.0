Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0PN8ksj008603
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 18:08:46 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0PN6bcF025753
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 23:06:37 GMT
Subject: Re: Fedora Rawhide mplayer policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200501232217.51369.russell@coker.com.au>
References: <1106432170.18789.7.camel@cobra.ivg2.net>
	 <200501232217.51369.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-Iv6kto4B7lRp6Px9Z87H"
Date: Tue, 25 Jan 2005 15:56:00 -0700
Message-Id: <1106693761.21231.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Iv6kto4B7lRp6Px9Z87H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's a new version that fixes some minor things Russel Cooker noted,
fixes a typo, moves ability to read removable_device_t into common
portion, labels /usr/lib/win32 with win32_lib_t, and adds execute
permissions to win32_lib_t, and /dev/zero. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-Iv6kto4B7lRp6Px9Z87H
Content-Disposition: attachment; filename=base_user_macros.patch
Content-Type: text/x-patch; name=base_user_macros.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- base_user_macros.te	2005-01-20 11:04:24.000000000 -0700
+++ base_user_macros.new	2005-01-23 05:15:23.000000000 -0700
@@ -188,6 +188,10 @@
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
+ifdef(`mplayer.te', `
+mplayer_domain($1)
+mencoder_domain($1)
+')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')

--=-Iv6kto4B7lRp6Px9Z87H
Content-Disposition: attachment; filename=mplayer.fc
Content-Type: text/plain; name=mplayer.fc; charset=UTF-8
Content-Transfer-Encoding: 7bit

# mplayer
/usr/bin/mplayer	--	   	system_u:object_r:mplayer_exec_t
/usr/bin/mencoder	--	   	system_u:object_r:mencoder_exec_t

/usr/lib/win32(/.*)?		   	system_u:object_r:win32_lib_t 	
/usr/lib/win32/.*\.so(\.[^/]*)* -- 	system_u:object_r:shlib_t

/etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t

--=-Iv6kto4B7lRp6Px9Z87H
Content-Disposition: attachment; filename=mplayer_macros.te
Content-Type: text/plain; name=mplayer_macros.te; charset=UTF-8
Content-Transfer-Encoding: 7bit

#
# Macros for mplayer
#
# Author: Ivan Gyurdiev <ivg2@cornell.edu>
#
#
# mplayer_domain(domain_prefix)
# mencoder_domain(domain_prefix)

################################################
#    mplayer_common(prefix, mplayer domain)    #
################################################

define(`mplayer_common',`

# Home directory stuff
if (use_nfs_home_dirs) {
create_dir_file($1_$2_t, nfs_t)
}
if (use_samba_home_dirs) {
create_dir_file($1_$2_t, cifs_t)
}
ifdef(`automount.te', `
allow $1_$2_t autofs_t:dir { search getattr };
') dnl end if automount

# Read local config
r_dir_file($1_$2_t, $1_mplayer_rw_t)

# Read global config
r_dir_file($1_$2_t, mplayer_etc_t)

# Read data in /usr/share (fonts, icons..)
r_dir_file($1_$2_t, usr_t)

# Read /proc files and directories
# Necessary for /proc/meminfo, /proc/cpuinfo, etc..
allow $1_$2_t proc_t:dir search;
allow $1_$2_t proc_t:file { getattr read };

# Sysctl on kernel version 
allow $1_$2_t sysctl_kernel_t:dir search;
allow $1_$2_t sysctl_kernel_t:file { getattr read };

# allow ps
can_ps($1_t, $1_$2_t)

# uses shared libraries
uses_shlib($1_$2_t)

# localization
read_locale($1_$2_t)

# Access the terminal.
allow $1_$2_t devpts_t:dir { search };
allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;

# Required for win32 binary loader 
allow $1_$2_t zero_device_t:chr_file { read write execute };
allow $1_$2_t self:process { execmem };
allow $1_$2_t win32_lib_t:file rx_file_perms;

# Access to DVD/CD 
allow $1_$2_t device_t:lnk_file { getattr read };
allow $1_$2_t removable_device_t:blk_file { getattr read };
')

##############################
#  mplayer_domain(prefix)    #
##############################

define(`mplayer_domain',`

# Derive from X client domain
x_client_domain($1, `mplayer', `')

# Mplayer common stuff
mplayer_common($1, mplayer)

# Additional rules for search /tmp/.X11-unix
ifdef(`xdm.te', `
allow $1_mplayer_t xdm_tmp_t:dir search;
')dnl end if xdm.te

# Prevent getattr denials on restricted types when browsing with gmplayer
dontaudit $1_mplayer_t file_type:dir_file_class_set { getattr };

# Audio
allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;

# RTC clock 
allow $1_mplayer_t clock_device_t:chr_file { ioctl read };

# Read home directory content
r_dir_file($1_mplayer_t, $1_home_t);

# Allow execmod to make libSDL work
allow $1_mplayer_t shlib_t:file { execmod };

') dnl end mplayer_domain

##############################
#  mencoder_domain(prefix)   #
##############################

define(`mencoder_domain',`

# Privhome type transitions to $1_home_t in home dir.
type $1_mencoder_t, domain, privhome;

# Transition
domain_auto_trans($1_t, mencoder_exec_t, $1_mencoder_t)
can_exec($1_mencoder_t, mencoder_exec_t)
role $1_r types $1_mencoder_t;

# Mplayer common stuff
mplayer_common($1, mencoder)

') dnl end mencoder_domain

--=-Iv6kto4B7lRp6Px9Z87H
Content-Disposition: attachment; filename=mplayer.te
Content-Type: text/plain; name=mplayer.te; charset=UTF-8
Content-Transfer-Encoding: 7bit

#DESC mplayer - media player 
#
# Author: Ivan Gyurdiev <ivg2@cornell.edu>
#

# Type for the mplayer executable.
type mplayer_exec_t, file_type, exec_type, sysadmfile;
type mencoder_exec_t, file_type, exec_type, sysadmfile;
type mplayer_etc_t, file_type, sysadmfile;
type win32_lib_t, file_type, sysadmfile;

# Everything else is in the mplayer_domain macro in
# macros/program/mplayer_macros.te.

--=-Iv6kto4B7lRp6Px9Z87H--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
