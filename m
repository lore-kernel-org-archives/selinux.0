From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: chroot
Date: Wed, 11 Sep 2002 21:52:09 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XUHAENTOGR3RLV8SWNUA"
Message-Id: <200209112152.09769.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_XUHAENTOGR3RLV8SWNUA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached all the files for my chroot policy.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_XUHAENTOGR3RLV8SWNUA
Content-Type: text/plain;
  charset="us-ascii";
  name="chroot.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="chroot.te"


# Author: Russell Coker <russell@coker.com.au>
#
type chroot_exec_t, file_type, sysadmfile, exec_type;

# For a chroot environment named potato that can be entered from user_t (so
# the user can run an old version of Debian in a chroot), with the possibility
# of user_devpts_t or user_tty_device_t being the controlling tty type for
# administration.  This also defines a mount_domain for the user (so they can
# mount file systems).
#chroot(user, potato)
# For a chroot environment named apache that can be entered from initrc_t for
# running a different version of apache.
# initrc is a special case, uses the system_r role (usually appends "_r" to
# the base name of the parent domain), and has sysadm_devpts_t and
# sysadm_tty_device_t for the controlling terminal
#chroot(initrc, apache)

# the main code is in macros/program/chroot_macros.te

--------------Boundary-00=_XUHAENTOGR3RLV8SWNUA
Content-Type: text/plain;
  charset="us-ascii";
  name="chroot.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="chroot.fc"

/usr/sbin/chroot		system_u:object_r:chroot_exec_t

--------------Boundary-00=_XUHAENTOGR3RLV8SWNUA
Content-Type: text/plain;
  charset="us-ascii";
  name="chroot_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="chroot_macros.te"


# macro for chroot environments
# Author Russell Coker

# chroot(initial_domain, basename, role, tty_device_type)
define(`chroot', `

ifelse(`$1', `initrc', `
define(`chroot_role', `system_r')
define(`chroot_tty_device', `{ sysadm_devpts_t sysadm_tty_device_t }')
define(`chroot_mount_domain', `mount_t')
', `
define(`chroot_role', `$1_r')
define(`chroot_tty_device', `{ $1_devpts_t $1_tty_device_t }')

# allow mounting /proc and /dev
ifdef(`$1_mount_def', `', `
mount_domain($1, $1_mount)
role chroot_role types $1_mount_t;
')
define(`chroot_mount_domain', `$1_mount_t')
ifdef(`ssh.te', `
can_tcp_connect($1_ssh_t, $2_t)
')dnl end ssh
')dnl end ifelse initrc

# types for read-only and read-write files in the chroot
type $2_ro_t, file_type, sysadmfile, home_type, user_home_type;
type $2_rw_t, file_type, sysadmfile, home_type, user_home_type;
# type like $2_ro_t but that triggers a transition from $2_super_t to $2_t
# when you execute it
type $2_dropdown_t, file_type, sysadmfile, home_type, user_home_type;

allow chroot_mount_domain { $2_rw_t $2_ro_t }:dir { getattr search mounton };
allow chroot_mount_domain { $2_rw_t $2_ro_t }:file { getattr mounton };

# entry point for $2_super_t
type $2_super_entry_t, file_type, sysadmfile, home_type, user_home_type;
# $2_t is the base domain, has full access to $2_rw_t files
type $2_t, domain, userdomain, unpriv_userdomain;
# $2_super_t is the super-chroot domain, can also write to $2_ro_t
# but still can not access outside the chroot
type $2_super_t, domain, userdomain, unpriv_userdomain;
allow $2_super_t chroot_tty_device:chr_file rw_file_perms;

ifdef(`$1_chroot_def', `', `
dnl can not have this defined twice
define(`$1_chroot_def')

allow chroot_mount_domain { proc_t device_t fs_t }:filesystem { mount unmount };

# $1_chroot_t is the domain for /usr/sbin/chroot
type $1_chroot_t, domain;

# allow $1_chroot_t to write to the tty device
allow $1_chroot_t chroot_tty_device:chr_file rw_file_perms;
allow $1_chroot_t privfd:fd use;
allow { $1_chroot_t $2_t $2_super_t } $1_t:fd use;

role chroot_role types $1_chroot_t;
uses_shlib($1_chroot_t)
allow $1_chroot_t self:capability sys_chroot;
allow $1_t $1_chroot_t:dir { search getattr read };
allow $1_t $1_chroot_t:{ file lnk_file } { read getattr };
domain_auto_trans($1_t, chroot_exec_t, $1_chroot_t)
allow $1_chroot_t fs_t:filesystem getattr;
')dnl End conditional

role chroot_role types { $2_t $2_super_t };

# allow ps to show processes and allow killing them
allow $1_t { $2_super_t $2_t }:dir { search getattr read };
allow $1_t { $2_super_t $2_t }:{ file lnk_file } { read getattr };
allow $1_t { $2_super_t $2_t }:process signal_perms;
allow $2_super_t $2_t:dir { search getattr read };
allow $2_super_t $2_t:{ file lnk_file } { read getattr };
allow { $1_t $2_super_t } $2_t:process { signal_perms ptrace };
allow $1_t $2_super_t:process { signal_perms ptrace };
allow sysadm_t { $2_super_t $2_t }:process { signal_perms ptrace };

allow { $2_super_t $2_t } { fs_t device_t }:filesystem getattr;
allow { $2_super_t $2_t } device_t:dir { search getattr };
allow { $2_super_t $2_t } devtty_t:chr_file rw_file_perms;
allow { $2_super_t $2_t } random_device_t:chr_file r_file_perms;
allow { $2_super_t $2_t } self:capability { fowner chown fsetid setgid setuid net_bind_service sys_tty_config };
allow $2_super_t self:capability sys_ptrace;

can_tcp_connect($2_super_t, $2_t)
allow { $2_super_t $2_t } $2_rw_t:sock_file create_file_perms;

allow { $2_super_t $2_t } devpts_t:dir { getattr search read };

# quiet ps and killall
dontaudit { $2_super_t $2_t } domain:dir { search getattr };

# allow $2_t to write to the owner tty device (should remove this)
allow $2_t chroot_tty_device:chr_file { read write };

r_dir_file($1_chroot_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
can_exec($2_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
can_exec($2_super_t, { $2_ro_t $2_super_entry_t })
create_dir_notdevfile($2_super_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
# $2_super_t transitions to $2_t when it executes
# any file that $2_t can write
domain_auto_trans($2_super_t, { $2_rw_t $2_dropdown_t }, $2_t)
allow $1_chroot_t { $2_ro_t $2_rw_t }:lnk_file read;
r_dir_file($2_t, { $2_ro_t $2_super_entry_t $2_dropdown_t })
create_dir_notdevfile($2_t, $2_rw_t)
allow $2_t $2_rw_t:fifo_file create_file_perms;
allow $2_t $2_ro_t:fifo_file rw_file_perms;
allow { $1_t $2_super_t } { $2_rw_t $2_ro_t }:fifo_file create_file_perms;
create_dir_notdevfile($1_t, { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t })
can_exec($1_t, { $2_ro_t $2_dropdown_t })
domain_auto_trans($1_chroot_t, { $2_ro_t $2_rw_t $2_dropdown_t }, $2_t)
domain_auto_trans_read($1_chroot_t, $2_super_entry_t, $2_super_t)
allow { $1_t $2_super_t } { $2_ro_t $2_rw_t $2_super_entry_t $2_dropdown_t }:{ dir notdevfile_class_set } { relabelfrom relabelto };
general_proc_read_access({ $2_t $2_super_t })
general_domain_access({ $2_t $2_super_t })
can_create_pty($2)
can_create_pty($2_super)
can_network({ $2_t $2_super_t })
allow { $2_t $2_super_t } null_device_t:chr_file rw_file_perms;
allow $2_super_t { $2_rw_t $2_ro_t }:{ dir file } mounton;
allow { $2_t $2_super_t } self:capability { dac_override kill };

undefine(`chroot_role')
undefine(`chroot_tty_device')
undefine(`chroot_mount_domain')
')

--------------Boundary-00=_XUHAENTOGR3RLV8SWNUA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
