Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2CNuJDo015281
	for <selinux@tycho.nsa.gov>; Sat, 12 Mar 2005 18:56:19 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2CNmM7c000967
	for <selinux@tycho.nsa.gov>; Sat, 12 Mar 2005 23:48:22 GMT
Subject: New policy for yam
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com, hampton-rh@rainbolthampton.net
Content-Type: multipart/mixed; boundary="=-EBob+N//3t8jgSDulznf"
Date: Sat, 12 Mar 2005 18:50:42 -0500
Message-Id: <1110671442.7641.15.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EBob+N//3t8jgSDulznf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is written on an FC3 base system using the selinux-policy-strict-
sources-1.22.1-2 policy from March 11th.  These are the first policies
I've submitted so I'd appreciate any comments on how to write better
policies.

David


--=-EBob+N//3t8jgSDulznf
Content-Disposition: attachment; filename=yam.fc
Content-Type: text/plain; name=yam.fc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# yam
/etc/yam.conf		--	system_u:object_r:yam_etc_t
/usr/bin/yam			system_u:object_r:yam_exec_t
/var/yam(/.*)?			system_u:object_r:yam_content_t
/var/www/yam(/.*)?		system_u:object_r:yam_content_t

--=-EBob+N//3t8jgSDulznf
Content-Disposition: attachment; filename=yam.te
Content-Type: text/plain; name=yam.te; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# DESC yam - Yum/Apt Mirroring
#
# Author: David Hampton <hampton@employees.org>
#


#
# Yam downloads lots of files, indexes them, and makes them available
# for upload.  Define a type for these file.
#
type yam_content_t, file_type, sysadmfile, httpdcontent;


#
# Common definitions used by both the command line and the cron
# invocation of yam.
#
define(`yam_common',`

# Update the content being managed by yam.
create_dir_file($1_t, yam_content_t)

# Content can also be on ISO image files.
r_dir_file($1_t, iso9660_t)

# Need to go through /var to get to /var/yam
# Go through /var/www to get to /var/www/yam
allow $1_t var_t:dir { getattr search };
allow $1_t httpd_sys_content_t:dir { getattr search };

# Allow access to locale database,  nsswitch, and mtab
read_locale($1_t)
allow $1_t etc_t:file { getattr read };
allow $1_t etc_runtime_t:file { getattr read };

# Python seems to need things from various places
allow $1_t { bin_t sbin_t }:dir { search getattr };
allow $1_t { bin_t sbin_t lib_t usr_t }:file { getattr read };
allow $1_t bin_t:lnk_file read;

# Python works fine without reading /proc/meminfo
dontaudit $1_t proc_t:dir search;
dontaudit $1_t proc_t:file { getattr read };

# Yam wants to run rsync, lftp, mount, and a shell.  Allow the latter
# two here.  Run rsync and lftp in the yam_t context so that we dont
# have to give any other programs write access to the yam_t files.
general_domain_access($1_t)
can_exec($1_t, shell_exec_t)
can_exec($1_t, rsync_exec_t)
can_exec($1_t, bin_t)
can_exec($1_t, usr_t) #/usr/share/createrepo/genpkgmetadata.py
ifdef(`mount.te', `
domain_auto_trans($1_t, mount_exec_t, mount_t)
')

# Rsync and lftp need to network.  They also set files attributes to
# match whats on the remote server.
can_network_client($1_t)
allow $1_t self:capability { chown fowner fsetid dac_override };

# access to sysctl_kernel_t ( proc/sys/kernel/* )
read_sysctl($1_t)

# Programs invoked to build package lists need various permissions.
# genpkglist creates tmp files in /var/cache/apt/genpkglist
allow $1_t var_t:file { getattr read write };
allow $1_t var_t:dir read;
# mktemp
allow $1_t urandom_device_t:chr_file read;
# mv
allow $1_t proc_t:lnk_file read;
allow $1_t selinux_config_t:dir search;
allow $1_t selinux_config_t:file { getattr read };
')


##########
##########

#
# Runnig yam from the command line
#
application_domain(yam, `, nscd_client_domain')
role system_r types yam_t;
yam_common(yam)
etc_domain(yam)
tmp_domain(yam)

# Terminal access
allow yam_t devpts_t:dir search;
allow yam_t devtty_t:chr_file { read write };
allow yam_t sshd_t:fd use;
allow yam_t sysadm_devpts_t:chr_file { getattr ioctl read write };

# Reading dotfiles...
dontaudit yam_t staff_home_dir_t:dir search;		# /root
allow yam_t home_root_t:dir search;			# /home
allow yam_t user_home_dir_t:dir { getattr search };	# /home/user


##########
##########

#
# Running yam from cron
#
application_domain(yam_crond, `, nscd_client_domain')
role system_r types yam_crond_t;
ifdef(`crond.te', `
system_crond_entry(yam_exec_t, yam_crond_t)
')

yam_common(yam_crond)
allow yam_crond_t yam_etc_t:file r_file_perms;
file_type_auto_trans(yam_crond_t, tmp_t, yam_tmp_t, `{ file dir }')

allow yam_crond_t devtty_t:chr_file { read write };

# Reading dotfiles...
# LFTP uses a directory for its dotfiles
allow yam_crond_t default_t:dir search;

# Don't know why init tries to read this.
allow initrc_t yam_etc_t:file read;


##########
##########

# The whole point of this program is to make updates available on a
# local web server.  Allow apache access to these files.
ifdef(`apache.te', `
allow httpd_t yam_content_t:dir { getattr search };
allow httpd_t yam_content_t:file { getattr read };
allow httpd_t yam_content_t:lnk_file { getattr read };
')

# Mount needs access to the yam directories in order to mount the ISO
# files on a loobpack file system.
ifdef(`mount.te', `
allow mount_t yam_content_t:dir mounton;
allow mount_t yam_content_t:file { read write };
')

--=-EBob+N//3t8jgSDulznf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
