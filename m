From: <rongqing.li@windriver.com>
To: <sds@tycho.nsa.gov>, <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 0/1] Review request for skipping file_name_trans_write() when policy downgraded
Date: Fri, 20 May 2011 10:38:05 +0800
Message-ID: <1305859086-28362-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Comments:
---------
When policyvers is less than POLICYDB_VERSION_FILENAME_TRANS, skip file_name_trans_write().	


Testings I've done:
-------------------
1. dump the policy:

	cat /selinux/policy >/root/dumppolicy

1.1 if do not apply this patch, the size of dumppolicy is larger than original policy size.

	root@qemu-host:/root> ls -l   
	total 16548
	-rw-r--r-- 1 root root 5628884 May 19 09:40 dumppolicy
	-rw-r--r-- 1 root root 5628880 May 19 05:51 policy.24

1.2 After apply this patch. the sizes are same.

	root@qemu-host:/root> ls -l   
	total 16548
	-rw-r--r-- 1 root root 5628880 May 19 09:45 dumppolicy
	-rw-r--r-- 1 root root 5628880 May 19 05:51 policy.24


2. replace the old refpolicy with the dumped policy

	cp dumppolicy /etc/selinux/wr-strict/policy/policy.24

3. reboot the system, system can start up, and selinux work well.

3.1 If do not apply this patch, when the system starts up, it will print the below error.
and the SELinux does not start up

	SELinux: 2048 avtab hash slots, 213157 rules.
	SELinux: 2048 avtab hash slots, 213157 rules.
	SELinux: roletr:  5 entries and 5/32 buckets used, longest chain length 1
	SELinux:  6 users, 15 roles, 3387 types, 144 bools, 1 sens, 1024 cats
	SELinux:  77 classes, 213157 rules
	SELinux: mls:  range overflow
	SELinux: error reading MLS range of context

3.2 After apply this patch. the system can startup, the SELinux works well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
