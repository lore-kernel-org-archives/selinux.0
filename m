Message-ID: <4DA45416.70103@tresys.com>
Date: Tue, 12 Apr 2011 09:31:02 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
Subject: Re: v2 Add class support to the role_transition rule
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/25/2011 01:51 AM, Harry Ciao wrote:
> Comments:
> ---------
> The outstanding changes in v2 from v1 include:
> 
> 1. The newly added class support in role_trans structure in both kernel
> and libsepol have been renamed to "tclass";
> 
> 2. The role_transition rule will be handled in a unified way for both
> process class and non-process classes - roletr->type would always be
> used to compare with tcontext->type, which is the type for the parent
> directory accomodating the newly created object, or the program
> executable type.
> 
> 
> Testings I've done:
> -------------------
> 
> 0. Add below snippet into sysadm.te for testing:
> 
>    role_transition sysadm_r user_home_t:{ file dir } sysadm_r;
>    role sysadm_r types user_home_t;
>    
>    gen_require(`
>            type vlock_exec_t, vlock_t;
>    ')
>    role_transition sysadm_r vlock_exec_t system_r;
>    
> 1. Verify that the dismod program could display the class field of the
>    role_transition rule correctly:
>    
>    /work/selinux/selinux/checkpolicy$ test/dismod /work/selinux/refpolicy/sysadm.pp 
>    Reading policy...
>    ......
>    Command ('m' for menu):  7
>    role transitions:
>    --- begin avrule block ---
>    decl 1:
>    role transition  sysadm_r [vlock_exec_t] : [process] system_r
>    role transition  sysadm_r [user_home_t] :{ [file] [dir] } sysadm_r
>    --- begin avrule block ---
>    decl 2:
>    ......
>    --- begin avrule block ---
>    decl 342:
>    
>    Command ('m' for menu):  q
>    /work/selinux/selinux/checkpolicy$ 
>    
> 2. Further verify the binary reprensentation of the role_transition rule
>    are correct, with the classes field *after* that of new_role in image:
> 
>    /work/selinux/refpolicy$ ls -l /etc/selinux/refpolicy-mls/policy/
>    total 5728
>    -rw-r--r--. 1 root root 5849662 2011-03-25 13:12 policy.26
>    /work/selinux/refpolicy$ xxd /etc/selinux/refpolicy-mls/policy/policy.26 > policy_26_xxd
>    /work/selinux/refpolicy$ vim policy_26_xxd
>    ......
>    055c510:                                    0800  l.....S.........
>    055c520: 0000 0300 0000 a006 0000 0b00 0000 0200  ................
>    055c530: 0000 0300 0000 a103 0000 0b00 0000 0200  ................
>    055c540: 0000 0800 0000 b707 0000 0b00 0000 0200  ................
>    055c550: 0000 0800 0000 a70a 0000 0b00 0000 0200  ................
>    055c560: 0000 0a00 0000 db00 0000 0b00 0000 0200  ................
>    055c570: 0000 0a00 0000 8e05 0000 0a00 0000 0600  ................
>    055c580: 0000 0a00 0000 8e05 0000 0a00 0000 0700  ................
>    055c590: 0000 0c00 0000 9209 0000 0b00 0000 0200  ................
>    055c5a0: 0000 
>    ......
>    /work/selinux/refpolicy$ 
> 
> 3. Run-time test one - verify that the role_transition rule works for
>    non-process classes:
> 
>    [root/sysadm_r/s0@~]# sestatus 
>    SELinux status:                 enabled
>    SELinuxfs mount:                /selinux
>    Current mode:                   enforcing
>    Mode from config file:          enforcing
>    Policy version:                 26
>    Policy from config file:        refpolicy-mls
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# id -Z
>    root:sysadm_r:sysadm_t:s0-s15:c0.c1023
>    [root/sysadm_r/s0@~]# ls -Zd
>    dr-xr-x---  root root root:object_r:user_home_dir_t:s0-s15:c0.c1023 .
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# mkdir parent
>    [root/sysadm_r/s0@~]# ls -Z
>    drwxr-xr-x  root root root:object_r:user_home_t:s0     parent
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_t:s0 dir
>    root:sysadm_r:user_home_t:s0
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_t:s0 file
>    root:sysadm_r:user_home_t:s0
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_t:s0 lnk_file
>    root:object_r:user_home_t:s0
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# cd parent
>    [root/sysadm_r/s0@parent]# mkdir dir
>    [root/sysadm_r/s0@parent]# touch file
>    [root/sysadm_r/s0@parent]# ln -s file file_lk
>    [root/sysadm_r/s0@parent]# mkfifo pipe
>    [root/sysadm_r/s0@parent]# 
>    [root/sysadm_r/s0@parent]# ls -Z
>    drwxr-xr-x  root root root:sysadm_r:user_home_t:s0     dir
>    -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
>    lrwxrwxrwx  root root root:object_r:user_home_t:s0     file_lk -> file
>    prw-r--r--  root root root:object_r:user_home_t:s0     pipe
>    [root/sysadm_r/s0@parent]# 
> 
> 4. Run-time test two - verify that the role_transition rule works for the
>    process class:
> 
>    [root/sysadm_r/s0@~]# ls -Z /usr/sbin/vlock-main 
>    -rws--x--x  root root system_u:object_r:vlock_exec_t:s0 /usr/sbin/vlock-main
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# seclow "setenforce 0"
>    Password: 
>    [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 system_u:object_r:vlock_exec_t:s0 process
>    root:system_r:vlock_t:s0-s15:c0.c1023
>    [root/sysadm_r/s0@~]# 
>      
>    [root/staff_r/s0@~]# vlock &
>    [1] 743
>    [root/staff_r/s0@~]# ps Z -C vlock-main
>    LABEL                             PID TTY      STAT   TIME COMMAND
>    root:staff_r:vlock_t:s0-s15:c0.c1023 743 pts/0 T      0:00 /usr/sbin/vlock-main
>    [1]+  Stopped                 vlock
>    [root/staff_r/s0@~]# 
>    
>    [root/sysadm_r/s0@~]# vlock &
>    [1] 759
>    [root/sysadm_r/s0@~]# ps Z -C vlock-main
>    LABEL                             PID TTY      STAT   TIME COMMAND
>    root:staff_r:vlock_t:s0-s15:c0.c1023 743 pts/0 T      0:00 /usr/sbin/vlock-main
>    root:system_r:vlock_t:s0-s15:c0.c1023 759 ttyS0 T     0:00 /usr/sbin/vlock-main
>    [1]+  Stopped                 vlock
>    [root/sysadm_r/s0@~]# 
>    
>    (Note, "setenforce 0" is to shortcut the necessary user-role & role-type
>     settings in sysadm.pp for system_r)
>    
> 5. (TODO) restorecon doesn't take into account the role_transition rule
>    for non-process class so far:
> 
>    [root/sysadm_r/s0@~]# cd parent/
>    [root/sysadm_r/s0@parent]# 
>    [root/sysadm_r/s0@parent]# ls -Z
>    drwxr-xr-x  root root root:sysadm_r:user_home_t:s0     dir
>    -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
>    lrwxrwxrwx  root root root:object_r:user_home_t:s0     file_lk -> file
>    prw-r--r--  root root root:object_r:user_home_t:s0     pipe
>    [root/sysadm_r/s0@parent]# 
>    [root/sysadm_r/s0@parent]# restorecon . -R
>    [root/sysadm_r/s0@parent]# 
>    [root/sysadm_r/s0@parent]# ls -Z
>    drwxr-xr-x  root root root:object_r:user_home_t:s0     dir
>    -rw-r--r--  root root root:object_r:user_home_t:s0     file
>    lrwxrwxrwx  root root root:object_r:user_home_t:s0     file_lk -> file
>    prw-r--r--  root root root:object_r:user_home_t:s0     pipe
>    [root/sysadm_r/s0@parent]# 
> 
> 6. Verify that SELinux kernel policydb_write > role_trans_write works well:
> 
>    [root/sysadm_r/s0@~]# setenforce 1
>    [root/sysadm_r/s0@~]# sestatus 
>    SELinux status:                 enabled
>    SELinuxfs mount:                /selinux
>    Current mode:                   enforcing
>    Mode from config file:          enforcing
>    Policy version:                 26
>    Policy from config file:        refpolicy-mls
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# ls -l policy_read 
>    -rw-r--r-- 1 root root 5849662 Mar 25 05:26 policy_read
>    [root/sysadm_r/s0@~]# ls -l /etc/selinux/refpolicy-mls/policy/
>    total 5732
>    -rw-r--r-- 1 root root 5849662 Mar 25 05:15 policy.26
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# xxd policy_read > policy_read_xxd
>    [root/sysadm_r/s0@~]# vim policy_read_xxd 
>    ......
>    055c510:                                    0800  l.....S.........
>    055c520: 0000 0300 0000 a006 0000 0b00 0000 0200  ................
>    055c530: 0000 0300 0000 a103 0000 0b00 0000 0200  ................
>    055c540: 0000 0800 0000 b707 0000 0b00 0000 0200  ................
>    055c550: 0000 0800 0000 a70a 0000 0b00 0000 0200  ................
>    055c560: 0000 0a00 0000 db00 0000 0b00 0000 0200  ................
>    055c570: 0000 0a00 0000 8e05 0000 0a00 0000 0600  ................
>    055c580: 0000 0a00 0000 8e05 0000 0a00 0000 0700  ................
>    055c590: 0000 0c00 0000 9209 0000 0b00 0000 0200  ................
>    055c5a0: 0000 
>    ......
>    [root/sysadm_r/s0@~]# 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

All 5 userspace patches applied in libsepol-2.0.43 and checkpolicy-2.0.24

Thanks!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
