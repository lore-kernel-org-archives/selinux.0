From: <rongqing.li@windriver.com>
To: <sds@tycho.nsa.gov>, <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 0/2] Review request for reorganizing the role transition rule
Date: Tue, 24 May 2011 17:46:12 +0800
Message-ID: <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Comments:
---------
Organize the roletr in hash table rather than single list.

Testings I've done:
-------------------
1. Prepare the test

1.1 Search valid role_transition statement from policy.24, to prepare to get role transition results from kernel by compute_create:
	
	root@qemu-host:/root> sesearch --role_tran
	Found 5 role_transition rules:
	   role_transition webadm_r httpd_initrc_exec_t system_r;
	   role_transition dbadm_r postgresql_initrc_exec_t system_r;
	   role_transition logadm_r syslogd_initrc_exec_t system_r;
	   role_transition logadm_r auditd_initrc_exec_t system_r;
	   role_transition dbadm_r mysqld_initrc_exec_t system_r;

1.2 Add roles to SELinux root user, or else root:logadm_r:logadm_t and others are not a valid security context and lead to compute_create failed. 

	root@qemu-host:/root> semanage user -l |grep root
	root            user       s0         s0-s0:c0.c1023                 staff_r sysadm_r
	root@qemu-host:/root> 
	root@qemu-host:/root> semanage user -m -R staff_r -R logadm_r -R sysadm_r -R dbadm_r -R logadm_r -R webadm_r -R system_r root
	root@qemu-host:/root> 
	root@qemu-host:/root> semanage user -l |grep root
	root            user       s0         s0-s0:c0.c1023                 dbadm_r staff_r logadm_r sysadm_r system_r webadm_r

2. Before applying these patches, use the compute_create tool to trigger SELinux kernel function of security_compute_sid() which would access the roletr single list

	root@qemu-host:/root>compute_create root:logadm_r:logadm_t:s0 system_u:object_r:auditd_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:logadm_r:logadm_t:s0 system_u:object_r:syslogd_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:dbadm_r:dbadm_t:s0 system_u:object_r:postgresql_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:dbadm_r:dbadm_t:s0 system_u:object_r:mysqld_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:webadm_r:webadm_t:s0 system_u:object_r:httpd_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	
3. After applying these patches, use the compute_create tool to trigger SELinux kernel function of security_compute_sid() which would access the roletr hashtab 

	root@qemu-host:/root>compute_create root:logadm_r:logadm_t:s0 system_u:object_r:auditd_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:logadm_r:logadm_t:s0 system_u:object_r:syslogd_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:dbadm_r:dbadm_t:s0 system_u:object_r:postgresql_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:dbadm_r:dbadm_t:s0 system_u:object_r:mysqld_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

	root@qemu-host:/root>compute_create root:webadm_r:webadm_t:s0 system_u:object_r:httpd_initrc_exec_t:s0 process
	root:system_r:initrc_t:s0
	root@qemu-host:/root>

4. After applying these patches, check the /selinux/policy file works well.

4.1 Dump the policy, check the policy sizes between dumped policy and original policy are same, replace the original policy with dumped policy

	root@qemu-host:/root> cat /selinux/policy >dumppolicy 
	root@qemu-host:/root> 
	root@qemu-host:/root> ls dumppolicy policy.24  -l
	-rw-r--r-- 1 root root 5628880 May 20 06:00 dumppolicy
	-rw-r--r-- 1 root root 5628880 May 19 05:51 policy.24
	root@qemu-host:/root> cp dumppolicy /etc/selinux/refpolicy/policy/policy.24 
	root@qemu-host:/root> 
	
4.2 Reboot system, check SELinux works well.
	 
	root@qemu-host:/root> sestatus 
	SELinux status:                 enabled
	SELinuxfs mount:                /selinux
	Current mode:                   enforcing 
	Mode from config file:          enforcing
	Policy version:                 26
	Policy from config file:        refpolicy
	root@qemu-host:/root> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
