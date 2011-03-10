From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: Discussions about rbacsep
Date: Thu, 10 Mar 2011 14:51:48 +0800
Message-Id: <1299739911-19352-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello Stephen and Chirs,

Many thanks for all your feedbacks on the previous discussions about rbacsep, I have tried to study all old emails in the past week and started to play with security_compute_sid to take the role_transition into consideration. The attached SELinux kernel patches and refpolicy patch are not for review but discussion. Having them applied I could have files or dirs created by user in their HOME retain user's role. For example:

   [root/sysadm_r/s0@~]# getenforce 
   Enforcing
   [root/sysadm_r/s0@~]# ls -Zd
   dr-xr-x---  root root root:object_r:user_home_dir_t:s0-s15:c0.c1023 .
   [root/sysadm_r/s0@~]# id -Z
   root:sysadm_r:sysadm_t:s0-s15:c0.c1023
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 file
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# compute_create root:sysadm_r:sysadm_t:s0-s15:c0.c1023 root:object_r:user_home_dir_t:s0-s15:c0.c1023 dir 
   root:sysadm_r:user_home_t:s0
   [root/sysadm_r/s0@~]# 
   
   [root/sysadm_r/s0@~]# mkdir dir
   [root/sysadm_r/s0@~]# touch file
   [root/sysadm_r/s0@~]# ls -Z
   drwxr-xr-x  root root root:sysadm_r:user_home_t:s0     dir
   -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
   [root/sysadm_r/s0@~]# audhigh "ausearch -ts recent -sv no -m SELINUX_ERR"
   Password: 
   <no matches>
   [root/sysadm_r/s0@~]# 
   
   [root/sysadm_r/s0@~]# seclow "sesearch -SC --role_trans -s object_r"
   Password: 
   Found 10 role_transition rules:
      role_transition object_r auditadm_t auditadm_r;
      role_transition dbadm_r mysqld_initrc_exec_t system_r;
      role_transition dbadm_r postgresql_initrc_exec_t system_r;
      role_transition logadm_r syslogd_initrc_exec_t system_r;
      role_transition logadm_r auditd_initrc_exec_t system_r;
      role_transition object_r secadm_t secadm_r;
      role_transition object_r staff_t staff_r;
      role_transition object_r sysadm_t sysadm_r;
      role_transition object_r user_t user_r;
      role_transition webadm_r httpd_initrc_exec_t system_r;
   [root/sysadm_r/s0@~]#


Below are my further questions and todo list, I would like to get your opinions on them, thanks a lot!

1. So far we are clear about how to setup the security contexts for process/sockets/files/dirs classes, but what for the rest classes?

Once we have answers to this question could we start thinking about coming up a flexible way to compute different parts of security context for different class. Currently for the process/sockets/files/dirs classes, I could further combine security_is_socket/filedir_class functions into one and return some enum number which could be leveraged by security_compute_sid.

2. For files/dirs classes, newly created object will have its SID computed by security_transition_sid, and for the AVTAB_TRANSITION rule, newcontext->user = scontext->user (creator's user), so if the object has the creator's role, then I guess we won't have the user-role problem at all. 

Comments?

3. Furthermore, the newly created object for the files/dirs classes will have the creator's current level as its MLS attribute, so we won't have the user-range probelem as well. 

Comments?

4. In the current refpolicy/SELinux kernel implementation, I am not very sure about how dirs' role is implemented as "object_r" by default.

By "file" init SID ?

5. We probably would want to add a new role_change rule to support change the role for the controlling terminal. This would require the changes to libsepol and checkplicy to support such new rule. Do we need to change policydb as well? If not then I guess we would have to make use of policydb.te_avtab to cover role_change as well.

Comments?

6. Maybe we also would want to modify genhomedircon to specify files/dirs in HOME retain user's role, otherwise if we restorecon it its role would be re-labeled as object_r again:

   [root/sysadm_r/s0@~]# ls -Z
   -rw-r--r--  root root root:sysadm_r:user_home_t:s0     file
   [root/sysadm_r/s0@~]# matchpathcon file
   file	<<none>>
   [root/sysadm_r/s0@~]# restorecon file
   [root/sysadm_r/s0@~]# ls -Z
   -rw-r--r--  root root root:object_r:user_home_t:s0     file
   [root/sysadm_r/s0@~]# 

But how about files/dirs not at HOME directory? How to let restorecon knows about their role is other than object_r? (we certainly could do so by semanage fcontext)

7. Introduce below constraints to enforce rbacsep as pointed out by Chris, for example, to have user_r:mozilla_t domain unable to access files of staff_r:mozilla_t:

   constrain { file dir ...} { getattr open read write ... }
   (
   	(r1 == r2) or
   	(r1 == system_r) or
   	(r2 == object_r) or
   	...
   );

8. Collaps various xxx_sudo_t into a single sudo_t. However, this can't be achieved just by the type_transition rule, since in the rule of "type_transition sudo_t shell_exec_t X_t", where X_t should be determined by the current domain's role.

Maybe, just maybe, we could invent another new rule "type_transition_role", for example, 
	type_transition_role sudo_t shell_exec_t; 
then in security_compute_sid if scontext->type == sudo_t and tcontext->type == shell_exec_t the newcontext->type = the default type associated with scontext->role.

Comments?

Thanks again!

Best regards,
Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
