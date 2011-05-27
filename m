From: Harry Ciao <qingtao.cao@windriver.com>
To: <sds@tycho.nsa.gov>, <method@manicmethod.com>, <jmorris@namei.org>,
        <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: v0 Add role attribute support to libsepol
Date: Fri, 27 May 2011 09:24:19 +0800
Message-ID: <1306459464-2497-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Comments:
---------
Add role attribute to SELinux, which aims at replacing the deprecated
role dominance rule.

Previous discussions could be found here:
http://www.spinics.net/lists/selinux/msg00974.html

A role attribute could be declared by the rule of
"attribute <role_attribute_name> role;" and further used in the
user-roles, role-types, role-allows and role_transition rules. In order
to avoid ambiguity, the role-types would no longer to declare a role,
another new rule of role-attr is added to declare a regular role and
optionally a list of role attribute that the regular role belongs to
(like the type rule). Also the role-attribute association could be
declared by a new rule of roleattribute.

BTW, since the flavor and roles ebitmap of a role_datum_t structure
are not needed to be written to policy.X, the SELinux kernel driver
would not need any change. The maximum version number in both libsepol
and kernel remain the same.

FIXME_1:
I may need some help to specify the "kind" of a required attribute
(of a type attribute or role attribute), please see the notes left in
the patches. BTW, since multiple declarations of role/user are allowed,
so far I just explicitly declare the required role attribute :-P


Testings I've done:
-------------------
1. Use role attribute in several different modules to test if a role
   attribute used in user-roles, role-types, role-allows and role-transition
   rules could be properly compiled/linked/expanded.
   
   Also in order to support that role-types rule no longer is used to
   declare a regular role, we have to use the role-attr rule to declare
   the related role explicitly (so far only nx_server_r and unconfined_r).
   
   Please refer to the attached refpolicy patch for above tests, then make
   policy.
   

2. Make a hexdump of policy.26 by xxd tool, then check out the policy value
   for those identifiers related with this test:
   
   0035b40:                       07 0000 004a 0300  r_tmpfs_t....J..
   0035b50: 0001 0000 0000 0000 0076 6c6f 636b 5f74  .........vlock_t
   
   vlock_t: len = 7, policy value = 0x34a, prop = 01, bounds = 0
   
   00353b0:                          0800 0000 fa02  ..shadow_t......
   00353c0: 0000 0100 0000 00000000  7379 7361 646d  ..........sysadm
   00353d0: 5f74 1200 0000 cb01 0000 0000 0000 0000  _t
   
   sysadm_t: len = 8, policy value = 0x2fa, prop = 01, bounds = 0
   
   003d3f0: 635f 7409 0000 0034 0600 0001 0000 0000  c_t....4........
   003d400: 0000 006e 6577 726f 6c65 5f74 0900 0000  ...newrole_t....
   
   newrole_t: len = 9, policy value = 0x634, prop = 0x01, bounds = 0
   
   0045dc0:                                    0800  ......cgroup_t..
   0045dd0: 0000 7309 0000 0100 0000 0000 0000 6368  ..s...........ch
   0045de0: 6b70 7764 5f74 0800 0000 7409 0000 0100  kpwd_t
   
   chkpwd_t: len = 0x08, policy value = 0x973, prop = 0x01, bounds = 0
   
   002c6a0:                                      07  ................
   002c6b0: 0000 0005 0000 0000 0000 0073 7461 6666  ...........staff
   002c6c0: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........
   
   staff_r: len = 0x07, policy value = 0x05, bounds = 0
   
   002cc60:                               0800 0000  .......@........
   002cc70: 0a00 0000 0000 0000 7379 7361 646d 5f72  ........sysadm_r
   
   sysadm_r: len = 0x08, policy value = 0x0a, bounds = 0
   
   002cec0:                               0800 0000  @...............
   002ced0: 0b00 0000 0000 0000 7379 7374 656d 5f72  ........system_r
   
   system_r: len = 0x08, policy value = 0x0b, bounds = 0
   
   
3. Check out the hexdump for the sysadm_r_2 and sysadm_r_3 role, verify
   if their types.types ebitmap records all types specified in the
   "role role_attribute_1 types xxx;" rule:
   
   002d470:                  0a 0000 0010 0000 0000  ................
   002d480: 0000 0073 7973 6164 6d5f 725f 3240 0000  ...sysadm_r_2@..
   002d490: 0040 0000 0001 0000 0000 0000 0000 8000  .@..............
   002d4a0: 0000 0000 0040 0000 0080 0900 0004 0000  .....@..........
   002d4b0: 00c0 0200 0000 0000 0000 0000 0240 0300  .............@..
   002d4c0: 0000 0200 0000 0000 0000 0600 0000 0000  ................
   002d4d0: 0000 0008 0040 0900 0000 0000 0000 0004  .....@..........
   002d4e0: 000a 0000 0011 0000 0000 0000 0073 7973  .............sys
   002d4f0: 6164 6d5f 725f 3340 0000 0040 0000 0001  adm_r_3@...@....
   002d500: 0000 0000 0000 0000 0001 0000 0000 0040  ...............@
   002d510: 0000 0080 0900 0004 0000 00c0 0200 0000  ................
   002d520: 0000 0000 0000 0240 0300 0000 0200 0000  .......@........
   002d530: 0000 0000 0600 0000 0000 0000 0008 0040  ...............@
   002d540: 0900 0000 0000 0000 0004 0065 0d00 00fa  ...........e....
   
   sysadm_r_2:
   	len = 0x0a, policy value = 0x10, bounds = 0
   	dominates:
   		ms = 0x40, highbit = 0x40, node = 0x01, 
		startbit = 0, map: 00 8000 0000 0000 00 (policy value = 0x10)
   	types.types:
   		ms = 0x40, highbit = 0x980, node = 0x04, 
		startbit = 0x2c0, map: 00 0000 0000 0000 02 (policy value = 0x2fa, sysadm_t)
		startbit = 0x340, map: 00 0200 0000 0000 00 (policy value = 0x34a, vlock_t)
   		startbit = 0x600, map: 00 0000 0000 0008 00 (policy value = 0x634, newrole_t)
   		startbit = 0x940, map: 00 0000 0000 0004 00 (policy value = 0x973, chkpwd_t)
   
   sysadm_r_3:
   	len = 0x0a, policy value = 0x11, bounds = 0
   	(The dominates and types.types ebitmaps are the same as that
	 of sysadm_r_2)	
   
   
4. Check out the hexdump of the root user, verify if its roles.roles ebitmap
   records the policy values of sysadm_r_2 and sysadm_r_3 that specified in
   the "user root roles role_attribute_1 ...;" rule:
   
   004fc20:                            04 0000 0003  ................
   004fc30: 0000 0000 0000 0072 6f6f 7440 0000 0040  .......root@...@
   004fc40: 0000 0001 0000 0000 0000 0012 8701 0000  ................
   004fc50: 0000 0002 0000 0001 0000 0010 0000 0040  ...............@
   004fc60: 0000 0000 0000 0000 0000 0040 0000 0000  ...........@....
   004fc70: 0400 0010 0000 0000 0000 00ff ffff ffff  ................
   004fc80: ffff ff40 0000 00ff ffff ffff ffff ff80  ...@............
   
   root:
   	len = 0x04, policy value = 0x03, bounds = 0x0
   	roles.roles:
   		ms = 0x40, highbit = 0x40, node = 0x01,
   		startbit = 0, map: 12 8701 0000 0000 00
   
   roles.roles ebitmap for the root user recorded following policy values:
   	2, 5, 9, 10, 11, 16, 17
   where 5 == staff_r, 10 == sysadmd_r, 11 == system_r, 16 == sysadm_r_2,
	 17 == sysadm_r_3
   
   
5. Boot up the system with the latest Eric SELinux tree:
   
   [root/sysadm_r/s0@~]# sestatus 
   SELinux status:                 enabled
   SELinuxfs mount:                /selinux
   Current mode:                   enforcing
   Mode from config file:          enforcing
   Policy version:                 26
   Policy from config file:        refpolicy-mls
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# echo "sysadm_r_2:sysadm_t" >> /etc/selinux/refpolicy-mls/contexts/default_type 
   [root/sysadm_r/s0@~]# echo "sysadm_r_3:sysadm_t" >> /etc/selinux/refpolicy-mls/contexts/default_type 
   [root/sysadm_r/s0@~]#
   

6. Use newrole command to switch between sysadm_r and sysadm_r_2/3, to
   prove that the role_attribute_1 used in relevant
   role-allow/user-roles/role-types rules have been properly linked/expanded:
   
   [root/sysadm_r/s0@~]# newrole -r sysadm_r_2 -p
   Password: 
   [root/sysadm_r_2/s0@~]#
   [root/sysadm_r_2/s0@~]# id -Z
   root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023
   [root/sysadm_r_2/s0@~]# 
   [root/sysadm_r_2/s0@~]# newrole -r sysadm_r -p
   Password: 
   [root/sysadm_r/s0@~]# 
   [root/sysadm_r/s0@~]# newrole -r sysadm_r_3 -p
   Password: 
   [root/sysadm_r_3/s0@~]# 
   [root/sysadm_r_3/s0@~]# newrole -r sysadm_r -p
   Password: 
   [root/sysadm_r/s0@~]# id -Z
   root:sysadm_r:sysadm_t:s0-s15:c0.c1023
   [root/sysadm_r/s0@~]# 
   

7. Use the compute_create command to prove that the role_attribute_1 used
   in relevant role_transition rule has been properly linked/expanded:
   
   [root/sysadm_r_2/s0@~]# ls -Z /usr/sbin/vlock-main 
   -rws--x--x  root root system_u:object_r:vlock_exec_t:s0 /usr/sbin/vlock-main
   [root/sysadm_r_2/s0@~]# 
   [root/sysadm_r_2/s0@~]# compute_create `id -Z` system_u:object_r:vlock_exec_t:s0 process
   root:system_r:vlock_t:s0-s15:c0.c1023
   [root/sysadm_r_2/s0@~]# 
   
   [root/sysadm_r_3/s0@~]# compute_create `id -Z` system_u:object_r:vlock_exec_t:s0 process
   root:system_r:vlock_t:s0-s15:c0.c1023
   [root/sysadm_r_3/s0@~]# 
   

8. FIXME_2:
   The result of compute_create in the above steps has showed that the
   domain transition from sysadm_t to vlock_t, and the role transition from
   sysadm_r_2/3 to system_r could have taken place correctly. BTW, since
   security_compute_sid() has called policydb_context_isvalid(), so the
   "root:system_r:vlock_t:s0-s15:c0.c1023" context is valid.
   
   However, the root:sysadm_r_2:sysadm_t would fail to run the vlock
   program with the below AVC denied message, what else refpolicy rule
   should I have added ?
   
   [root/sysadm_r_2/s0@~]# date
   Thu May 26 06:27:29 GMT 2011
   [root/sysadm_r_2/s0@~]# vlock
   /usr/bin/vlock: line 224: /usr/sbin/vlock-main: Permission denied
   [root/sysadm_r_2/s0@~]# exit
   
   [root/sysadm_r/s0@~]# audhigh "ausearch -ts 06:27:29 -sv no"
   Password: 
   ----
   time->Thu May 26 06:27:32 2011
   type=SYSCALL msg=audit(1306391252.699:38): arch=40000003 syscall=11 success=no exit=-13 a0=80db080 a1=80da830 a2=80d07b0 a3=80da830 items=0 ppid=723 pid=849 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyS0 ses=4294967295 comm="vlock" exe="/bin/bash" subj=root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023 key=(null)
   type=AVC msg=audit(1306391252.699:38): avc:  denied  { transition } for  pid=849 comm="vlock" path="/usr/sbin/vlock-main" dev=sda ino=50097 scontext=root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023 tcontext=root:system_r:vlock_t:s0-s15:c0.c1023 tclass=process
   [root/sysadm_r/s0@~]# 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
