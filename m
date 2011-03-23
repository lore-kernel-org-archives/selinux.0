From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: v0 Add class support to the role_transition rule
Date: Wed, 23 Mar 2011 10:28:37 +0800
Message-Id: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Comments:
---------
Add class support to the role_transition rule so that it could be used in
a much more generalized	manner.

So far the semantics of the role_transition rule does not support specifying
the class, and in SELinux kernel security server it could be applied to the
process class only.

With the class support the role_transition rule could be used for non-process
classes, and the newly created object could have roles other than "object_r",
which is a prerequisit for real RBAC separation development in the future.


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
   are correct:
   
   /work/selinux/refpolicy$ ls -lt /etc/selinux/refpolicy-mls/policy/policy.25 
   -rw-r--r--. 2 root root 5849742 2011-03-22 15:39 /etc/selinux/refpolicy-mls/policy/policy.25
   /work/selinux/refpolicy$ xxd /etc/selinux/refpolicy-mls/policy/policy.25 > policy_25_xxd
   /work/selinux/refpolicy$ vim policy_25_xxd
   ......
   055c510:                                    0d00  l.....S.........
   055c520: 0000 0300 0000 a006 0000 0200 0000 0b00  ................
   055c530: 0000 0300 0000 a103 0000 0200 0000 0b00  ................
   055c540: 0000 0800 0000 b707 0000 0200 0000 0b00  ................
   055c550: 0000 0800 0000 a70a 0000 0200 0000 0b00  ................
   055c560: 0000 0a00 0000 db00 0000 0200 0000 0b00  ................
   055c570: 0000 0a00 0000 8e05 0000 0600 0000 0a00  ................
   055c580: 0000 0a00 0000 8e05 0000 0700 0000 0a00  ................
   055c590: 0000 0a00 0000 8e05 0000 0900 0000 0a00  ................
   055c5a0: 0000 0a00 0000 8e05 0000 0a00 0000 0a00  ................
   055c5b0: 0000 0a00 0000 8e05 0000 0b00 0000 0a00  ................
   055c5c0: 0000 0a00 0000 8e05 0000 0c00 0000 0a00  ................
   055c5d0: 0000 0a00 0000 8e05 0000 0d00 0000 0a00  ................
   055c5e0: 0000 0c00 0000 9209 0000 0200 0000 0b00  ................
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
   Policy version:                 25
   Policy from config file:        refpolicy-mls
   [root/sysadm_r/s0@~]#      
   [root/sysadm_r/s0@~]# id -Z
   root:sysadm_r:sysadm_t:s0-s15:c0.c1023 
   [root/sysadm_r/s0@~]# ls -Zd
   dr-xr-x---  root root root:object_r:user_home_dir_t:s0-s15:c0.c1023 .
   [root/sysadm_r/s0@~]#
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 file
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 dir 
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# mkdir dir
   [root/sysadm_r/s0@~]# touch file
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# ls -Zd dir file
   drwxr-xr-x  root root root:sysadm_r:user_home_t:s0     dir
   -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
   [root/sysadm_r/s0@~]# 
   
4. Run-time test two - verify that the role_transition rule works for the
   process class:
   
   [root/sysadm_r/s0@~]# ls -Z /usr/sbin/vlock-main 
   -rws--x--x  root root system_u:object_r:vlock_exec_t:s0 /usr/sbin/vlock-main
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# compute_create root:staff_r:staff_t:s0-s15:c0.c1023 system_u:object_r:vlock_exec_t:s0 process
   root:staff_r:vlock_t:s0-s15:c0.c1023
   [root/sysadm_r/s0@~]#
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 system_u:object_r:vlock_exec_t:s0 process
   root:system_r:vlock_t:s0-s15:c0.c1023
   [root/sysadm_r/s0@~]# 
   
   [root/staff_r/s0@~]# vlock &
   [1] 796
   [root/staff_r/s0@~]# ps Z -C vlock-main
   LABEL                             PID TTY      STAT   TIME COMMAND
   root:staff_r:vlock_t:s0-s15:c0.c1023 796 pts/0 T      0:00 /usr/sbin/vlock-main
   
   [1]+  Stopped                 vlock
   [root/staff_r/s0@~]# 
   
   [root/sysadm_r/s0@~]# seclow "setenforce 0"
   Password: 
   [root/sysadm_r/s0@~]# vlock &
   [1] 812
   [root/sysadm_r/s0@~]# ps Z -C vlock-main
   LABEL                             PID TTY      STAT   TIME COMMAND
   root:staff_r:vlock_t:s0-s15:c0.c1023 796 pts/0 T      0:00 /usr/sbin/vlock-main
   root:system_r:vlock_t:s0-s15:c0.c1023 812 ttyS0 T     0:00 /usr/sbin/vlock-main
   
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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
