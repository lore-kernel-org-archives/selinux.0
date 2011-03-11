From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: [v2] [SELinux] Discussions about rbacsep
Date: Fri, 11 Mar 2011 15:20:57 +0800
Message-Id: <1299828060-18411-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi Stephen and Chris,

I have fixed the semantics of the role_transtion rule for the newly created files or dirs objects same as that for the process class. Since class-specific role_transition rules would be handled after TE rules, we could make use of checking if (newcontext.type == roletr->type) and (scontext->role == roletr->role) before setting newcontext.role = roletr->new_role;

Then in the refpolicy we could adopt Stephen's suggestion for the role_transition rule such as:
	role_transition sysadm_r user_home_t sysadm_r;

But I think we could omit class in above rule, since such role_transition semantics only takes place when filedir == true, that is, when the new object is of file or dir class.

The test results seem promising:

   [root/sysadm_r/s0@~]# seclow "sesearch -SC --role_trans -t user_home_t"
   Password: 
   Found 8 role_transition rules:
      role_transition auditadm_r user_home_t auditadm_r;
      role_transition guest_r user_home_t guest_r;
      role_transition secadm_r user_home_t secadm_r;
      role_transition staff_r user_home_t staff_r;
      role_transition sysadm_r user_home_t sysadm_r;
      role_transition unconfined_r user_home_t unconfined_r;
      role_transition user_r user_home_t user_r;
      role_transition xguest_r user_home_t xguest_r;
   
   [root/sysadm_r/s0@~]# 

   [root/sysadm_r/s0@~]# id -Z
   root:sysadm_r:sysadm_t:s0-s15:c0.c1023
   [root/sysadm_r/s0@~]# ls -Zd
   dr-xr-x---  root root root:object_r:user_home_dir_t:s0-s15:c0.c1023 .
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 file
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 dir 
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 lnk_file
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]#
   
   [root/sysadm_r/s0@~]# mkdir dir 
   [root/sysadm_r/s0@~]# touch file
   [root/sysadm_r/s0@~]# ln -s file lnk_file
   [root/sysadm_r/s0@~]# ls -Z
   drwxr-xr-x  root root root:sysadm_r:user_home_t:s0     dir
   -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
   lrwxrwxrwx  root root root:sysadm_r:user_home_t:s0     lnk_file -> file
   [root/sysadm_r/s0@~]# 
   

Looking forward to your comments on my previous questions about rbacsep.

Thanks a lot!

Best regards,
Harry


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
