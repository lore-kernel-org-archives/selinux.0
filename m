From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: v1 Add class support to the role_transition rule
Date: Thu, 24 Mar 2011 18:42:38 +0800
Message-Id: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Comments:
---------
In v1 patches I've endorsed most of suggestions/comments received on v0,
thanks!

I've rebased the three SELinux kernel patches on the latest Eric tree,
but can't boot it up with below messages:

   type=1404 audit(1300962000.147:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
   filename_trans_read: nel=27
   filename_trans_read: ft=ddea4400 ft->name=ddea4420 ft->name
   filename_trans_read: ft=ddea4440 ft->name=dda20000 ft->name=
   filename_trans_read: ft=ddea4460 ft->name=de979c80 ft->name=
   filename_trans_read: ft=ddea4480 ft->name=dda40000 ft->name=
   filename_trans_read: ft=ddea44a0 ft->name=dda07080 ft->name=
   SELinux:  Could not load policy file /etc/selinux/refpolicy-mls/policy/policy.26:  Invalid argument
   Unable to load SELinux Policy. Machine is in enforcing mode. Halting now.
   Kernel panic - not syncing: Attempted to kill init!
   Pid: 1, comm: init Not tainted 2.6.38-rc7 #2
   Call Trace:
    [<c14eb9a3>] ? panic+0x61/0x149
    [<c102b9ea>] ? do_exit+0x6fa/0x700
    [<c102ba2e>] ? do_group_exit+0x3e/0xb0
    [<c102bab3>] ? sys_exit_group+0x13/0x20
    [<c14edc61>] ? syscall_call+0x7/0xb

Obviously the init program fails to load the policy. I have not digged into
this yet, however, if I apply these rebased patches on the latest Linus tree
again, the kernel could boot up successfully. So it is the Linus tree that
I've used to test all these patches so far, please find them out below.


Testings I've done:
-------------------

0. Add below snippet into sysadm.te for testing:

   role_transition sysadm_r user_home_t:{ file dir lnk_file fifo_file sock_file chr_file blk_file } sysadm_r;
   role sysadm_r types user_home_t;
   
   gen_require(`
           type vlock_exec_t, vlock_t;
   ')
   role_transition sysadm_r vlock_exec_t system_r;
   
1. Verify that the dismod program could display the class field of the
   role_transition rule correctly:
   
   /work/selinux/selinux/checkpolicy$ test/dismod /work/selinux/refpolicy/sysadm.pp 
   Reading policy...
   ......
   Command ('m' for menu):  7
   role transitions:
   --- begin avrule block ---
   decl 1:
   role transition  sysadm_r [vlock_exec_t] : [process] system_r
   role transition  sysadm_r [user_home_t] :{ [file] [dir] [lnk_file] [chr_file] [blk_file] [sock_file] [fifo_file] } sysadm_r
   --- begin avrule block ---
   decl 2:
   ......
   --- begin avrule block ---
   decl 342:
   
   Command ('m' for menu):  q
   /work/selinux/selinux/checkpolicy$ 
   
2. Further verify the binary reprensentation of the role_transition rule
   are correct, with the classes field *after* that of new_role in image:
   
   /work/selinux/refpolicy$ ls -l /etc/selinux/refpolicy-mls/policy/policy.26 
   -rw-r--r--. 2 root root 5849742 2011-03-24 16:58 /etc/selinux/refpolicy-mls/policy/policy.26
   /work/selinux/refpolicy$ xxd /etc/selinux/refpolicy-mls/policy/policy.26 > policy_26_xxd
   /work/selinux/refpolicy$ vim policy_26_xxd
   ......
   055c510:                                    0d00  l.....S.........
   055c520: 0000 0300 0000 a006 0000 0b00 0000 0200  ................
   055c530: 0000 0300 0000 a103 0000 0b00 0000 0200  ................
   055c540: 0000 0800 0000 b707 0000 0b00 0000 0200  ................
   055c550: 0000 0800 0000 a70a 0000 0b00 0000 0200  ................
   055c560: 0000 0a00 0000 db00 0000 0b00 0000 0200  ................
   055c570: 0000 0a00 0000 8e05 0000 0a00 0000 0600  ................
   055c580: 0000 0a00 0000 8e05 0000 0a00 0000 0700  ................
   055c590: 0000 0a00 0000 8e05 0000 0a00 0000 0900  ................
   055c5a0: 0000 0a00 0000 8e05 0000 0a00 0000 0a00  ................
   055c5b0: 0000 0a00 0000 8e05 0000 0a00 0000 0b00  ................
   055c5c0: 0000 0a00 0000 8e05 0000 0a00 0000 0c00  ................
   055c5d0: 0000 0a00 0000 8e05 0000 0a00 0000 0d00  ................
   055c5e0: 0000 0c00 0000 9209 0000 0b00 0000 0200  ................
   055c5f0: 0000 
   ......
   /work/selinux/refpolicy$
   
3. Run-time test one - verify that the role_transition rule works for
   non-process classes:
  
   [root/sysadm_r/s0@~]# sestatus 
   SELinux status:                 enabled
   SELinuxfs mount:                /selinux
   Current mode:                   enforcing
   Mode from config file:          enforcing
   Policy version:                 26
   Policy from config file:        refpolicy-mls
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# id -Z
   root:sysadm_r:sysadm_t:s0-s15:c0.c1023
   [root/sysadm_r/s0@~]# ls -Zd
   dr-xr-x---  root root root:object_r:user_home_dir_t:s0-s15:c0.c1023 .
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 dir
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 file
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# mkdir dir
   [root/sysadm_r/s0@~]# touch file
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# ls -Z
   drwxr-xr-x  root root root:sysadm_r:user_home_t:s0     dir
   -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
   [root/sysadm_r/s0@~]#

4. Run-time test two - verify that the role_transition rule works for the
   process class:

   [root/sysadm_r/s0@~]# ls -Z /usr/sbin/vlock-main 
   -rws--x--x  root root system_u:object_r:vlock_exec_t:s0 /usr/sbin/vlock-main
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# seclow "setenforce 0"
   Password: 
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 system_u:object_r:vlock_exec_t:s0 process
   root:system_r:vlock_t:s0-s15:c0.c1023
   [root/sysadm_r/s0@~]# 
     
   [root/staff_r/s0@~]# vlock &
   [1] 743
   [root/staff_r/s0@~]# ps Z -C vlock-main
   LABEL                             PID TTY      STAT   TIME COMMAND
   root:staff_r:vlock_t:s0-s15:c0.c1023 743 pts/0 T      0:00 /usr/sbin/vlock-main
   
   [1]+  Stopped                 vlock
   [root/staff_r/s0@~]# 
   
   [root/sysadm_r/s0@~]# vlock &
   [1] 759
   [root/sysadm_r/s0@~]# ps Z -C vlock-main
   LABEL                             PID TTY      STAT   TIME COMMAND
   root:staff_r:vlock_t:s0-s15:c0.c1023 743 pts/0 T      0:00 /usr/sbin/vlock-main
   root:system_r:vlock_t:s0-s15:c0.c1023 759 ttyS0 T     0:00 /usr/sbin/vlock-main
   
   [1]+  Stopped                 vlock
   [root/sysadm_r/s0@~]# 
   
   (Note, "setenforce 0" is to shortcut the necessary user-role & role-type settings in sysadm.pp for system_r)
   
5. (TODO) restorecon doesn't take into account the role_transition rule
   for non-process class so far:
   
   [root/sysadm_r/s0@~]# ls -Zd dir file
   drwxr-xr-x  root root root:sysadm_r:user_home_t:s0     dir
   -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# restorecon dir file
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# ls -Zd dir file
   drwxr-xr-x  root root root:object_r:user_home_t:s0     dir
   -rw-r--r--  root root root:object_r:user_home_t:s0     file
   [root/sysadm_r/s0@~]# 

6. Verify that SELinux kernel policydb_write > role_trans_write works well:

   [root/sysadm_r/s0@~]# setenforce 1
   [root/sysadm_r/s0@~]# sestatus 
   SELinux status:                 enabled
   SELinuxfs mount:                /selinux
   Current mode:                   enforcing
   Mode from config file:          enforcing
   Policy version:                 26
   Policy from config file:        refpolicy-mls
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# cat /selinux/policy > policy_read
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# ls -l policy_read 
   -rw-r--r-- 1 root root 5849742 Mar 24 10:08 policy_read
   [root/sysadm_r/s0@~]# ls -l /etc/selinux/refpolicy-mls/policy/policy.26 
   -rw-r--r-- 1 root root 5849742 Mar 24 09:03 /etc/selinux/refpolicy-mls/policy/policy.26
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# xxd policy_read > policy_read_xxd
   [root/sysadm_r/s0@~]# vim policy_read_xxd 
   ......
   055c510:                                    0d00  l.....S.........
   055c520: 0000 0300 0000 a006 0000 0b00 0000 0200  ................
   055c530: 0000 0300 0000 a103 0000 0b00 0000 0200  ................
   055c540: 0000 0800 0000 b707 0000 0b00 0000 0200  ................
   055c550: 0000 0800 0000 a70a 0000 0b00 0000 0200  ................
   055c560: 0000 0a00 0000 db00 0000 0b00 0000 0200  ................
   055c570: 0000 0a00 0000 8e05 0000 0a00 0000 0600  ................
   055c580: 0000 0a00 0000 8e05 0000 0a00 0000 0700  ................
   055c590: 0000 0a00 0000 8e05 0000 0a00 0000 0900  ................
   055c5a0: 0000 0a00 0000 8e05 0000 0a00 0000 0a00  ................
   055c5b0: 0000 0a00 0000 8e05 0000 0a00 0000 0b00  ................
   055c5c0: 0000 0a00 0000 8e05 0000 0a00 0000 0c00  ................
   055c5d0: 0000 0a00 0000 8e05 0000 0a00 0000 0d00  ................
   055c5e0: 0000 0c00 0000 9209 0000 0b00 0000 0200  ................
   055c5f0: 0000 
   [root/sysadm_r/s0@~]# 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
