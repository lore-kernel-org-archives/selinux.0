Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0MMGEFX020527
	for <selinux@tycho.nsa.gov>; Sat, 22 Jan 2005 17:16:16 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0MMG7sF028556
	for <selinux@tycho.nsa.gov>; Sat, 22 Jan 2005 22:16:11 GMT
Subject: Fedora Rawhide mplayer policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: multipart/mixed; boundary="=-GsxN0yzqNqhqT7ieEnhy"
Date: Sat, 22 Jan 2005 15:16:10 -0700
Message-Id: <1106432170.18789.7.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-GsxN0yzqNqhqT7ieEnhy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I filed a bug on mplayer not being able to read /dev/rtc, and dwalsh 
advised that I should try to write a mplayer policy.

So, this is what I came up with... 
It's tailored to Fedora Rawhide 1.21.2-7 strict + the livna mplayer
packages. It also assumes Daniel Walsh has added nscd_client_domain to
x_client_macros.te.

Comments? I've never written a policy before, so I borrowed as much as I
could from others. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-GsxN0yzqNqhqT7ieEnhy
Content-Disposition: attachment; filename=base_user_macros.patch
Content-Type: text/x-patch; name=base_user_macros.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- base_user_macros.te	2005-01-20 11:04:24.000000000 -0700
+++ base_user_macros.new	2005-01-20 15:21:56.000000000 -0700
@@ -188,6 +188,8 @@
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
+ifdef(`mplayer.te', `mplayer_domain($1)')
+ifdef(`mplayer.te', `mencoder_domain($1)')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')

--=-GsxN0yzqNqhqT7ieEnhy
Content-Disposition: attachment; filename=mplayer.fc
Content-Type: text/plain; name=mplayer.fc; charset=UTF-8
Content-Transfer-Encoding: 7bit

# mplayer
/usr/bin/mplayer	--	system_u:object_r:mplayer_exec_t
/usr/bin/mencoder	--	system_u:object_r:mencoder_exec_t
/etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t

--=-GsxN0yzqNqhqT7ieEnhy
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

#######################


# These are common acess permissions for mplayer and mencoder
# mplayer_common($1,$2)

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
# FIXME: more is needed here - it wants execute on /dev/zero and /usr/lib/win32/*

allow $1_mencoder_t zero_device_t:chr_file { read write };
allow $1_mencoder_t self:process { execmem };

')

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
dontaudit $1_mplayer_t *:dir_file_class_set { getattr };

# Audio
allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;

# RTC clock 
allow $1_mplayer_t clock_device_t:chr_file { ioctl read };

# Read home directory content
r_dir_file($1_mplayer_t, $1_home_t);

# Allow execmod to make libSDL work
allow $1_mplayer_t shlib_t:file { execmod };

# Play DVD/VCD 
allow $1_mplayer_t device_t:lnk_file { getattr read };
allow $1_mplayer_t removable_device_t:blk_file { getattr read };

') dnl end mplayer_domain

############################

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

--=-GsxN0yzqNqhqT7ieEnhy
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

# Everything else is in the mplayer_domain macro in
# macros/program/mplayer_macros.te.

--=-GsxN0yzqNqhqT7ieEnhy--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
