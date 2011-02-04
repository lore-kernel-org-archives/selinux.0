Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p14NMBjI009140
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2011 18:22:11 -0500
Received: from mail.eurojobs.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p14NM9aK017177
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2011 23:22:10 GMT
Received: from localhost (IS-5354 [127.0.0.1])
	by mail.eurojobs.com (Postfix) with ESMTP id 8C4E6110024
	for <selinux@tycho.nsa.gov>; Fri,  4 Feb 2011 23:22:09 +0000 (GMT)
Received: from mail.eurojobs.com ([127.0.0.1])
	by localhost (mail.eurojobs.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mI8JmXw4FVSJ for <selinux@tycho.nsa.gov>;
	Fri,  4 Feb 2011 23:22:08 +0000 (GMT)
Received: from [192.168.1.14] (host1-1-dynamic.40-79-r.retail.telecomitalia.it [79.40.1.1])
	by mail.eurojobs.com (Postfix) with ESMTPSA id 29287110023
	for <selinux@tycho.nsa.gov>; Fri,  4 Feb 2011 23:22:08 +0000 (GMT)
Message-ID: <4D4C8A4C.1070101@mintsource.org>
Date: Sat, 05 Feb 2011 00:22:52 +0100
From: Simon Peter Nicholls <simon@mintsource.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Trouble logging in through SSH
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I'm having some trouble setting up SELinux using refpolicy, and am 
unable to login my test user through ssh when in enforcing mode. Could 
someone help me work out where the problem lies? I have some basic 
experience with SELinux, but based on working Fedora systems that have 
gone slightly awry.

Similar denial messages to the ssh one are seen when trying to run 
software like Emacs in permissive mode. In each case it feels like I am 
restricted by the consoletype_t, whilst I was expecting to gain an 
unconfined_t type for my user (to match unconfined_u & unconfined_r).

I also expected to see the sshd_t type for the sshd process, but it is 
using init_t. Are transitions failing for my startup services?

Some detailed info follows; Many thanks.

the denial when attempting ssh login
-------------------------------------------------
Feb  4 22:57:36 mailer kernel: type=1400 audit(1296856656.870:4): avc:  
denied  { entrypoint } for  pid=1003 comm="sshd" path="/bin/bash" 
dev=vda1 ino=1513 scontext=unconfined_u:unconfined_r:consoletype_t 
tcontext=system_u:object_r:shell_exec_t tclass=file

some debug.log for boot
--------------------------------
Feb  4 22:57:13 mailer kernel: SELinux: 2048 avtab hash slots, 211693 
rules.
Feb  4 22:57:13 mailer kernel: SELinux: 2048 avtab hash slots, 211693 
rules.
Feb  4 22:57:13 mailer kernel: SELinux:  6 users, 15 roles, 3386 types, 
143 bools
Feb  4 22:57:13 mailer kernel: SELinux:  77 classes, 211693 rules
Feb  4 22:57:13 mailer kernel: SELinux:  Permission audit_access in 
class file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission audit_access in 
class dir not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission execmod in class dir 
not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission audit_access in 
class lnk_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission open in class 
lnk_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission execmod in class 
lnk_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission audit_access in 
class chr_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission audit_access in 
class blk_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission execmod in class 
blk_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission audit_access in 
class sock_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission execmod in class 
sock_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission audit_access in 
class fifo_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux:  Permission execmod in class 
fifo_file not defined in policy.
Feb  4 22:57:13 mailer kernel: SELinux: the above unknown classes and 
permissions will be allowed
Feb  4 22:57:13 mailer kernel: SELinux:  Completing initialization.
Feb  4 22:57:13 mailer kernel: SELinux:  Setting up existing superblocks.
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev sysfs, type 
sysfs), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev rootfs, type 
rootfs), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev bdev, type 
bdev), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev proc, type 
proc), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev tmpfs, type 
tmpfs), uses transition SIDs
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev devtmpfs, type 
devtmpfs), uses transition SIDs
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev sockfs, type 
sockfs), uses task SIDs
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev debugfs, type 
debugfs), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev pipefs, type 
pipefs), uses task SIDs
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev anon_inodefs, 
type anon_inodefs), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev devpts, type 
devpts), uses transition SIDs
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev hugetlbfs, type 
hugetlbfs), uses transition SIDs
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev mqueue, type 
mqueue), uses transition SIDs
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev selinuxfs, type 
selinuxfs), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev sysfs, type 
sysfs), uses genfs_contexts
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev vda1, type 
ext4), uses xattr
Feb  4 22:57:13 mailer kernel: type=1403 audit(1296856630.883:2): policy 
loaded auid=4294967295 ses=4294967295
...
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev usbfs, type 
usbfs), uses genfs_contexts
...
Feb  4 22:57:13 mailer kernel: SELinux: initialized (dev tmpfs, type 
tmpfs), uses transition SIDs

sestatus -v
---------------
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        sipolicy

Process contexts:
Current context:                unconfined_u:unconfined_r:consoletype_t
Init context:                   system_u:system_r:init_t
/sbin/agetty                    system_u:system_r:getty_t
/usr/sbin/sshd                  system_u:system_r:init_t

File contexts:
Controlling term:               unconfined_u:object_r:devpts_t
/etc/passwd                     system_u:object_r:etc_t
/etc/shadow                     system_u:object_r:shadow_t
/bin/bash                       system_u:object_r:shell_exec_t
/bin/login                      system_u:object_r:login_exec_t
/bin/sh                         system_u:object_r:bin_t -> 
system_u:object_r:shell_exec_t
/sbin/agetty                    system_u:object_r:getty_exec_t
/sbin/init                      system_u:object_r:init_exec_t
/usr/sbin/sshd                  system_u:object_r:sshd_exec_t
/lib/libc.so.6                  system_u:object_r:lib_t -> 
system_u:object_r:lib_t

semanage login -l output
---------------------------------
Login Name                SELinux User

si                        unconfined_u
__default__               user_u
root                      root
system_u                  system_u

build.conf for policy
--------------------------
TYPE = standard
NAME = sipolicy
UNK_PERMS = allow #instead of deny, due to kernel boot complaints
DIRECT_INITRC = y
MONOLITHIC = n
UBAC = n

auth.log
-----------
Feb  4 22:57:54 mailer sshd[1005]: pam_selinux(sshd:session): pam: 
default-context=unconfined_u:unconfined_r:consoletype_t 
selected-context=(null) success 0
Feb  4 22:57:54 mailer sshd[1005]: pam_selinux(sshd:session): pam: 
default-context=unconfined_u:unconfined_r:consoletype_t 
selected-context=unconfined_u:unconfined_r:consoletype_t success 1

/etc/pam.d/sshd
--------------------
#%PAM-1.0
#auth           required        pam_securetty.so        #Disable remote 
root
auth            required        pam_unix.so
auth            required        pam_nologin.so
auth            required        pam_env.so
account         required        pam_unix.so
account         required        pam_time.so
password        required        pam_unix.so
# pam_selinux.so close should be the first session rule
session         required        pam_selinux.so close
# pam_selinux.so open should only be followed by sessions to be executed 
in the user context
session         required        pam_selinux.so open env_params
session         required        pam_unix_session.so
session         required        pam_limits.so

installed packages
------------------------
local/kernel26-selinux 2.6.36.3-1 (selinux selinux-system-utilities)
     The SELinux enabled Linux Kernel and modules
local/kernel26-selinux-headers 2.6.36.3-1 (selinux selinux-system-utilities)
     Header files and scripts for building modules for kernel26-selinux
local/selinux-coreutils 8.9-1 (selinux selinux-system-utilities)
     SELinux aware basic file, shell and text manipulation utilities of 
the GNU operating system
local/selinux-cronie 1.4.4-4 (selinux selinux-system-utilities)
     Fedora fork of vixie-cron with PAM and SELinux support
local/selinux-findutils 4.4.2-3 (selinux selinux-system-utilities)
     GNU utilities to locate files with Gentoo SELinux patch
local/selinux-flex 2.5.4a-4 (selinux selinux-system-utilities)
     A tool for generating text-scanning programs
local/selinux-logrotate 3.7.9-2 (selinux selinux-system-utilities)
     Tool to rotate system logs automatically with SELinux support
local/selinux-openssh 5.6p1-1 (selinux selinux-system-utilities)
     A Secure SHell server/client with SELinux support
local/selinux-pam 1.1.3-1 (selinux selinux-system-utilities)
     SELinux aware PAM (Pluggable Authentication Modules) library
local/selinux-procps 3.2.8-3 (selinux selinux-system-utilities)
     Utilities for monitoring your system and processes on your system 
with SELinux patch
local/selinux-psmisc 22.13-1 (selinux selinux-system-utilities)
     SELinux aware miscellaneous procfs tools
local/selinux-refpolicy 20101213-1 (selinux selinux-policies)
     Modular SELinux reference policy including headers and docs
local/selinux-refpolicy-src 20101213-1 (selinux selinux-policies)
     SELinux reference policy sources
local/selinux-setools 3.3.7-4 (selinux selinux-extras)
     SELinux SETools GUI and CLI tools and libraries for SELinux policy 
analysis
local/selinux-shadow 4.1.4.2-5 (selinux selinux-system-utilities)
     Shadow password file utilities with SELinux support
local/selinux-sudo 1.7.4p5-1 (selinux selinux-system-utilities)
     Give certain users the ability to run some commands as root with 
SELinux support
local/selinux-sysvinit 2.88-2 (selinux selinux-system-utilities)
     SELinux aware Linux System V Init
local/selinux-udev 165-1 (selinux selinux-system-utilities)
     The userspace dev tools (udev) with SELinux support
local/selinux-usr-checkpolicy 2.0.23-1 (selinux selinux-userspace)
     SELinux userspace (checkpolicy)
local/selinux-usr-libselinux 2.0.98-1 (selinux selinux-userspace)
     SELinux userspace (libselinux including python bindings)
local/selinux-usr-libsemanage 2.0.46-1 (selinux selinux-userspace)
     SELinux userspace (libsemanage including python bindings)
local/selinux-usr-libsepol 2.0.42-1 (selinux selinux-userspace)
     SELinux userspace (libsepol)
local/selinux-usr-policycoreutils 2.0.85-2 (selinux selinux-userspace)
     SELinux userspace (policycoreutils)
local/selinux-usr-sepolgen 1.0.23-4 (selinux selinux-userspace)
     SELinux userspace (sepolgen)
local/selinux-util-linux-ng 2.18-4 (selinux selinux-system-utilities)
     SELinux aware miscellaneous system utilities for Linux


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
