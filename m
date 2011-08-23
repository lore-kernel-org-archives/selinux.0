Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NA8eJo018446
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 06:08:40 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NA8cAm022964
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 10:08:39 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: v0 Separate tunables from booleans
Date: Tue, 23 Aug 2011 18:08:26 +0800
Message-ID: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Comments
---------
Separate tunables from booleans.

The effective branch of an if-else conditional that controlled by a tunable
should be expanded and registered to te_avtab hashtab permanently; while the
whole if-else conditional that controlled by a boolean should be expaned and
registered to te_cond_avtab hashtab as normal.

Also nearly all tunables(exceptions see below) would be discarded from
policy.X.

With this patchset, the size of policy.X would drop significantly from 600+k
down to 322+k bytes(since most of tunables are default to false, and there is
no else branch of most conditionals).

Note, so far some tunable would be used along with some boolean in the
tunable_policy() macro(say pppd_can_insmod), this is not recommended and such
tunable would have to be transformed as boolean.


Tests I've done
----------------
1. Apply below patchset for refpolicy to cope with toolchain:

   0001-Add-the-definition-of-the-boolean_policy-marcro.patch
   0002-user_ping-is-a-tunable-use-tunable_policy-for-it.patch
   0003-mmap_low_allowed-is-a-tunable-use-tunable_policy-for.patch
   0004-secure_mode_insmod-is-a-boolean-use-boolean_policy-f.patch

   Mostly these patches would add a new boolean_policy() macro and make
   the tunable_policy() macro use "tunable" keyword rather than "bool".

2. The refpolicy could be built successfully.
   The following messages are triggered since the secure_mode_insmod boolean
   is used in tunable_policy() macro(along with pppd_can_insmod tunable):

   libsepol.bool_copy_callback: ppp: Mismatch between boolean/tunable definition and usage for secure_mode_insmod
   libsepol.bool_copy_callback: ppp: Mismatch between boolean/tunable definition and usage for secure_mode_insmod

3. We can see the size of policy.X dropped significantly:

   cao@cao-laptop:/etc/selinux/refpolicy/policy$ ls -l
   total 6312
   -rw-r--r--. 1 root root 3227130 2011-08-23 15:51 policy.24
   cao@cao-laptop:/etc/selinux/refpolicy/policy$ 

4. If the console_login tunable defaults to true, after booting up this
   policy.X, we can see that the type_change rule controlled by it are
   available, and the /dev/console would be re-labelled properly:
   
   [root/sysadm_r/@~]# sesearch -SCT -t console_device_t
   Found 11 semantic te rules:
      type_change unconfined_t console_device_t : chr_file user_tty_device_t; 
      type_change logadm_t console_device_t : chr_file user_tty_device_t; 
      type_change webadm_t console_device_t : chr_file user_tty_device_t; 
      type_change dbadm_t console_device_t : chr_file user_tty_device_t; 
      type_change user_t console_device_t : chr_file user_tty_device_t; 
      type_change staff_t console_device_t : chr_file user_tty_device_t; 
      type_change xguest_t console_device_t : chr_file user_tty_device_t; 
      type_change secadm_t console_device_t : chr_file user_tty_device_t; 
      type_change auditadm_t console_device_t : chr_file user_tty_device_t; 
      type_change guest_t console_device_t : chr_file user_tty_device_t; 
      type_change sysadm_t console_device_t : chr_file user_tty_device_t; 
   
   [root/sysadm_r/@~]# tty
   /dev/console
   [root/sysadm_r/@~]# ls -Z `tty`
   crw--w----  root tty root:object_r:user_tty_device_t  /dev/console
   [root/sysadm_r/@~]# 

5. Also only real booleans would be preserved for policy.X, except that
   pppd_can_insmod tunable is used along with secure_mode_insmod and it
   has been transformed as a boolean during link:
   
   [root/sysadm_r/@~]# ls /selinux/booleans/ -l
   total 0
   -rw-r--r-- 1 root root 0 Aug 23 07:57 pppd_can_insmod
   -rw-r--r-- 1 root root 0 Aug 23 07:57 secure_mode
   -rw-r--r-- 1 root root 0 Aug 23 07:57 secure_mode_insmod
   -rw-r--r-- 1 root root 0 Aug 23 07:57 secure_mode_policyload
   [root/sysadm_r/@~]# getsebool -a
   pppd_can_insmod --> off
   secure_mode --> off
   secure_mode_insmod --> off
   secure_mode_policyload --> off
   [root/sysadm_r/@~]# 
   
6. If the console_login tunable defaults to false, rebuild policy.X and
   we can see that it becomes smaller, with all type_change rule gone and
   /dev/console not re-labelled:
   
   cao@cao-laptop:/etc/selinux/refpolicy/policy$ ls -lt
   total 6312
   -rw-r--r--. 1 root root 3226998 2011-08-23 16:38 policy.24
   cao@cao-laptop:/etc/selinux/refpolicy/policy$ 
   
   [root/sysadm_r/@~]# sesearch -SCT -t console_device_t
   
   [root/sysadm_r/@~]# tty
   /dev/console
   [root/sysadm_r/@~]# ls -Z `tty`
   crw--w----  root tty root:object_r:console_device_t   /dev/console
   [root/sysadm_r/@~]# 
   
7. Build as monolithic, ok.
   
8. Trigger module downgrade, since the flags of cond_bool_datum_t won't
   be written to a downgraded module, all tunables are regarded as booleans,
   and we can see that the size of policy.X becomes what it is used to be:
   
   cao@cao-laptop:/etc/selinux/refpolicy/policy$ ls -lt
   total 12268
   -rw-r--r--. 2 root root 6086586 2011-08-23 17:06 policy.24
   cao@cao-laptop:/etc/selinux/refpolicy/policy$

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
