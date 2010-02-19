Message-ID: <4B7EDC9A.40801@gmail.com>
Date: Fri, 19 Feb 2010 10:46:50 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>	 <4B7C47DB.40602@gmail.com>	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>	 <4B7DB3B4.2070409@gmail.com> <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

alright re-install, rebuilt refpolicy
back up and running to where I was.
(minus adding the allow rules)

here's some info(only thing missing are
the allow avc's which I can gather later on).

with the custom refpolicy only boolean enabled is upstart.
seems with this off I hit the dbus error, after enableing gdm starts up.




orig suse policy:

 > > SELinux status:                 enabled
 > > SELinuxfs mount:                /selinux
 > > Current mode:                   permissive
 > > Mode from config file:          permissive
 > > Policy version:                 24
 > > Policy from config file:        refpolicy-standard
 > >
 > > Process contexts:
 > > Current context:                system_u:system_r:kernel_t
 > > Init context:                   system_u:system_r:kernel_t
 > > /sbin/mingetty                  system_u:system_r:kernel_t
 > > /usr/sbin/sshd                  system_u:system_r:kernel_t
 > >
 > > File contexts:
 > > Controlling term:               system_u:object_r:tty_device_t
 > > /etc/passwd                     system_u:object_r:file_t
 > > /etc/shadow                     system_u:object_r:file_t
 > > /bin/bash                       system_u:object_r:file_t
 > > /bin/login                      system_u:object_r:file_t
 > > /bin/sh                         system_u:object_r:file_t ->
 > > system_u:object_r:file_t
 > > /sbin/agetty                    system_u:object_r:file_t
 > > /sbin/init                      system_u:object_r:file_t
 > > /sbin/mingetty                  system_u:object_r:file_t
 > > /usr/sbin/sshd                  system_u:object_r:file_t
 > > /lib/libc.so.6                  system_u:object_r:file_t ->
 > > system_u:object_r:file_t
 > > /lib/ld-linux.so.2              system_u:object_r:file_t ->
 > > system_u:object_r:file_t
 > >
 > > (id -Z after relabel)
 > > system_u:system_r:sysadm_t
 > > (before relabel)
 > > id -Z
 > > system_u:system_r:kernel_t
 > >
 > >

custom:
 > >
 > > SELinux status:                 enabled
 > > SELinuxfs mount:                /selinux
 > > Current mode:                   permissive
 > > Mode from config file:          error (Permission denied)
 > > Policy version:                 24
 > > Policy from config file:        targeted
 > >
 > > Process contexts:
 > > Current context:                name:user_r:user_t
 > > Init context:                   system_u:system_r:init_t
 > >
 > > File contexts:
 > > Controlling term:               justin:object_r:user_devpts_t
 > > /etc/passwd                     system_u:object_r:etc_t
 > > /etc/shadow                     system_u:object_r:shadow_t
 > > /bin/bash                       system_u:object_r:shell_exec_t
 > > /bin/login                      system_u:object_r:login_exec_t
 > > /bin/sh                         system_u:object_r:bin_t ->
 > > system_u:object_r:shell_exec_t
 > > /sbin/agetty                    system_u:object_r:getty_exec_t
 > > /sbin/init                      system_u:object_r:init_exec_t
 > > /sbin/mingetty                  system_u:object_r:getty_exec_t
 > > /usr/sbin/sshd                  system_u:object_r:sshd_exec_t
 > > /lib/libc.so.6                  system_u:object_r:lib_t ->
 > > system_u:object_r:lib_t
 > > /lib/ld-linux.so.2              system_u:object_r:lib_t ->
 > > system_u:object_r:ld_so_t
 > >
 > >
 > >
 > > id -Z
 > > (after relabel)
 > > name:user_r:user_t
 > >
 > > /etc/pam.d/*
 > >  cat login
 > > #%PAM-1.0
 > > auth	 requisite	pam_nologin.so
 > > auth	 [user_unknown=ignore success=ok ignore=ignore auth_err=die
 > > default=bad]	pam_securetty.so
 > > auth	 include	common-auth
 > > account  include 	common-account
 > > password include	common-password
 > > session  required       pam_selinux.so close
 > > session  required	pam_loginuid.so	
 > > session	 include	common-session
 > > session  required       pam_selinux.so open
 > > session  required	pam_lastlog.so	nowtmp
 > > session  optional       pam_mail.so standard
 > > session	 optional	pam_ck_connector.so
 > >
 > >
 > >
 > > cat gdm
 > > #%PAM-1.0
 > > auth     include        common-auth
 > > account  include        common-account
 > > password include        common-password
 > > session  required       pam_selinux.so close
 > > session  required       pam_loginuid.so
 > > session  include        common-session
 > > session  required       pam_selinux.so open
 > >
 > >
 > > cat xdm
 > > #%PAM-1.0
 > > auth     include        common-auth
 > > account  include        common-account
 > > password include        common-password
 > > session  required       pam_selinux.so close
 > > session  required       pam_loginuid.so
 > > session  include        common-session
 > > session  required       pam_selinux.so open
 > >
 > > (these might be mixed up, but they work id -Z shows what I want)


and the strace:

brk(0)                                  = 0x7febe998d000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe9787000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe9786000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=89126, ...}) = 0
mmap(NULL, 89126, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9770000
close(3)                                = 0
open("/lib64/libsepol.so.1", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`D\0\0\0\0\0
\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=240528, ...}) = 0
mmap(NULL, 2337280, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7febe9330000
fadvise64(3, 0, 2337280, POSIX_FADV_WILLNEED) = 0
mprotect(0x7febe936a000, 2093056, PROT_NONE) = 0
mmap(0x7febe9569000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x39000) = 0x7febe9569000
close(3)                                = 0
open("/lib64/libselinux.so.1", O_RDONLY) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340]\0\0\0\0\0
\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=118048, ...}) = 0
mmap(NULL, 2217720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7febe9112000
fadvise64(3, 0, 2217720, POSIX_FADV_WILLNEED) = 0
mprotect(0x7febe912e000, 2093056, PROT_NONE) = 0
mmap(0x7febe932d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x1b000) = 0x7febe932d000
mmap(0x7febe932f000, 1784, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x7febe932f000
close(3)                                = 0
open("/lib64/libc.so.6", O_RDONLY)      = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\220\353\1\0\0\0
\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1408560, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe976f000
mmap(NULL, 3516488, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7febe8db7000
fadvise64(3, 0, 3516488, POSIX_FADV_WILLNEED) = 0
mprotect(0x7febe8f08000, 2097152, PROT_NONE) = 0
mmap(0x7febe9108000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x151000) = 0x7febe9108000
mmap(0x7febe910d000, 18504, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x7febe910d000
close(3)                                = 0
open("/lib64/libdl.so.2", O_RDONLY)     = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\r\0\0\0\0\0
\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=14872, ...}) = 0
mmap(NULL, 2109696, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7febe8bb3000
fadvise64(3, 0, 2109696, POSIX_FADV_WILLNEED) = 0
mprotect(0x7febe8bb5000, 2097152, PROT_NONE) = 0
mmap(0x7febe8db5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x2000) = 0x7febe8db5000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe976e000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe976d000
arch_prctl(ARCH_SET_FS, 0x7febe976d790) = 0
mprotect(0x7febe8db5000, 4096, PROT_READ) = 0
mprotect(0x7febe9108000, 16384, PROT_READ) = 0
mprotect(0x7febe932d000, 4096, PROT_READ) = 0
mprotect(0x7febe9569000, 4096, PROT_READ) = 0
mprotect(0x7febe998b000, 4096, PROT_READ) = 0
mprotect(0x7febe9788000, 4096, PROT_READ) = 0
munmap(0x7febe9770000, 89126)           = 0
brk(0)                                  = 0x7febe998d000
brk(0x7febe99ae000)                     = 0x7febe99ae000
open("/etc/selinux/config", O_RDONLY)   = 3
fstat(3, {st_mode=S_IFREG|0600, st_size=72, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe9785000
read(3, "SELINUX=permissive\n#SELINUXTYPE="..., 4096) = 72
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7febe9785000, 4096)            = 0
statfs("/selinux", {f_type=0xf97cff8c, f_bsize=4096, f_blocks=0,
f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0},
f_namelen=255, f_frsize=4096}) = 0
stat("/selinux/class", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/selinux/mls", O_RDONLY)          = 3
read(3, "0", 19)                        = 1
close(3)                                = 0
open("/usr/lib/locale/locale-archive", O_RDONLY) = -1 ENOENT (No such
file or directory)
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2512, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe9785000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2512
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7febe9785000, 4096)            = 0
open("/usr/lib/locale/en_US.UTF-8/LC_IDENTIFICATION", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_IDENTIFICATION", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=373, ...}) = 0
mmap(NULL, 373, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9785000
close(3)                                = 0
open("/usr/lib64/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26050, ...}) = 0
mmap(NULL, 26050, PROT_READ, MAP_SHARED, 3, 0) = 0x7febe977e000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_MEASUREMENT", O_RDONLY) = -1 ENOENT
(No such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_MEASUREMENT", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=23, ...}) = 0
mmap(NULL, 23, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe977d000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_TELEPHONE", O_RDONLY) = -1 ENOENT
(No such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_TELEPHONE", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=59, ...}) = 0
mmap(NULL, 59, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe977c000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_ADDRESS", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_ADDRESS", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=155, ...}) = 0
mmap(NULL, 155, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe977b000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_NAME", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_NAME", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=77, ...}) = 0
mmap(NULL, 77, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe977a000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_PAPER", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_PAPER", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=34, ...}) = 0
mmap(NULL, 34, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9779000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_MESSAGES", O_RDONLY) = -1 ENOENT
(No such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_MESSAGES", O_RDONLY) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
close(3)                                = 0
open("/usr/lib/locale/en_US.utf8/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY)
= 3
fstat(3, {st_mode=S_IFREG|0644, st_size=52, ...}) = 0
mmap(NULL, 52, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9778000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_MONETARY", O_RDONLY) = -1 ENOENT
(No such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_MONETARY", O_RDONLY) = 3

 >> > > brk(0x7f75c7616000)                     = 0x7f75c7616000
 >> > > brk(0x7f75c7637000)                     = 0x7f75c7637000
 >> > >fstat(3, {st_mode=S_IFREG|0644, st_size=286, ...}) = 0
mmap(NULL, 286, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9777000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_COLLATE", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_COLLATE", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=966938, ...}) = 0
mmap(NULL, 966938, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9680000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_TIME", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_TIME", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2454, ...}) = 0
mmap(NULL, 2454, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9776000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_NUMERIC", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_NUMERIC", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=54, ...}) = 0
mmap(NULL, 54, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9775000
close(3)                                = 0
open("/usr/lib/locale/en_US.UTF-8/LC_CTYPE", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_CTYPE", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=256316, ...}) = 0
mmap(NULL, 256316, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7febe9641000
close(3)                                = 0
open("/selinux/policyvers", O_RDONLY)   = 3
read(3, "24", 19)                       = 2
close(3)                                = 0
access("/etc/selinux/targeted/booleans", F_OK) = 0
uname({sys="Linux", node="linux-dbym", ...}) = 0
open("/etc/selinux/targeted/policy/policy.24", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=4188441, ...}) = 0
mmap(NULL, 4188441, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) =
0x7febe87b4000
brk(0x7febe99cf000)                     = 0x7febe99cf000
brk(0x7febe99f0000)                     = 0x7febe99f0000
brk(0x7febe9a11000)                     = 0x7febe9a11000
brk(0x7febe9a32000)                     = 0x7febe9a32000
brk(0x7febe9a53000)                     = 0x7febe9a53000

<~~~~~~~~~~~~~~~~~~~~~~clip~~~~~~~~~~~~~~~~~~~~~~~~>
brk(0x7febead25000)                     = 0x7febead25000
brk(0x7febead46000)                     = 0x7febead46000
brk(0x7febead67000)                     = 0x7febead67000
brk(0x7febead8c000)                     = 0x7febead8c000
brk(0x7febeadb7000)                     = 0x7febeadb7000
brk(0x7febeadd8000)                     = 0x7febeadd8000
brk(0x7febeadf9000)                     = 0x7febeadf9000
brk(0x7febeae1a000)                     = 0x7febeae1a000
open("/etc/selinux/targeted/users//local.users", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=722, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x7febe9774000
read(4, "################################"..., 4096) = 722
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x7febe9774000, 4096)            = 0
mmap(NULL, 4190208, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7febe83b5000
brk(0x7febeae3b000)                     = 0x7febeae3b000
brk(0x7febeae5c000)                     = 0x7febeae5c000
brk(0x7febeae7d000)                     = 0x7febeae7d000
brk(0x7febeae9e000)                     = 0x7febeae9e000
brk(0x7febeaec2000)                     = 0x7febeaec2000
brk(0x7febeaee3000)                     = 0x7febeaee3000
brk(0x7febeaf04000)                     = 0x7febeaf04000
brk(0x7febeaf25000)                     = 0x7febeaf25000
brk(0x7febeaf46000)                     = 0x7febeaf46000
brk(0x7febeaf67000)                     = 0x7febeaf67000

<~~~~~~~~~~~~~~~~~~~~~~~~~~clip~~~~~~~~~~~~~~~~~~~~~~~~>



 > >  brk(0x7f75c7658000)                     = 0x7f75c7658000
 >> > > brk(0x7f75c7681000)                     = 0x7f75c7681000
 >> > > brk(0x7f75c76a2000)                     = 0x7f75c76a2000
 >> > > brk(0x7f75c76c3000)                     = 0x7f75c76c3000
 >> > > brk(0x7f75c76e4000)                     = 0x7f75c76e4000
 >> > > open("/etc/selinux/targeted/booleans", O_RDONLY) = 4
 >> > > fstat(4, {st_mode=S_IFREG|0644, st_size=2084, ...}) = 0
 >> > > mmap(NULL, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
 >> > > = 0x7f75c6031000
 >> > > read(4, "allow_cvs_read_shadow = 0\nallow_"..., 4096) = 2084
 >> > > read(4, "", 4096)                       = 0
 >> > > close(4)                                = 0
 >> > > munmap(0x7f75c6031000, 4096)            = 0
 >> > > open("/etc/selinux/targeted/booleans.local", O_RDONLY) = -1 
ENOENT (No
 >> > > such file or directory)
 >> > > brk(0x7f75c6270000)                     = 0x7f75c6270000
 >> > > open("/selinux/load", O_RDWR)           = 4
 >> > > write(4, "\214\377|\371\10\0\0\0SE 
Linux\30\0\0\0\0\0\0\0\10\0\0\0\7\0\0
 >> > > \0"..., 4188441) = 4188441
 >> > > close(4)                                = 0
 >> > > munmap(0x7f75c4c72000, 4190208)         = 0
 >> > > munmap(0x7f75c5071000, 4188441)         = 0
 >> > > close(3)                                = 0
 >> > > exit_group(0)                           = ?
 >> > >
 >> > >
 >> > >
 > >
 > >


(NOTE:the arrows are because I sent this to my other machine via e-mail).


Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
