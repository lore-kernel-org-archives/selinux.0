Message-ID: <3F711241.2020101@diyab.net>
Date: Tue, 23 Sep 2003 23:40:49 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: postfix virtual delivery patch
Content-Type: multipart/mixed;
 boundary="------------000204020207040404060803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000204020207040404060803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch to the current selinux userland archive.  It adds 
two lines into postfix.te to allow virtual domain delivery to work and 
one line in postfix.fc to relabel /usr/lib/postfix/virtual.

For some reason when it tries to apply the patch section for 
selinux-usr/policy/file_contexts/program/postfix.fc it says that it can 
not find the file but if you type in the exact same thing when it 
prompts you it will work.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright

--------------000204020207040404060803
Content-Type: text/plain;
 name="postfix_virtual.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="postfix_virtual.diff"

diff -ur src/policy/domains/program/unused/postfix.te selinux-usr/policy/domains/program/unused/postfix.te
--- src/policy/domains/program/unused/postfix.te	2003-09-23 22:03:57.000000000 -0400
+++ selinux-usr/policy/domains/program/unused/postfix.te	2003-09-23 22:05:29.000000000 -0400
@@ -150,6 +151,9 @@
 allow postfix_local_t postfix_public_t:sock_file write;
 can_exec(postfix_local_t, shell_exec_t)
 
+postfix_server_domain(virtual, `, mta_delivery_agent')
+allow postfix_virtual_t postfix_spool_t:file rw_file_perms;
+
 define(`postfix_public_domain',`
 postfix_server_domain($1)
 allow postfix_$1_t postfix_public_t:dir search;
diff -ur src/policy/file_contexts/program/postfix.fc selinux-usr/policy/file_contexts/program/postfix.fc
--- src/policy/file_contexts/program/postfix.fc	2003-09-23 22:03:08.000000000 -0400
+++ selinux-usr/policy/file_contexts/program/postfix.fc	2003-09-23 22:05:02.000000000 -0400
@@ -13,6 +13,7 @@
 /usr/lib/postfix/smtpd		system_u:object_r:postfix_smtpd_exec_t
 /usr/lib/postfix/bounce		system_u:object_r:postfix_bounce_exec_t
 /usr/lib/postfix/pipe		system_u:object_r:postfix_pipe_exec_t
+/usr/lib/postfix/virtual	system_u:object_r:postfix_virtual_exec_t
 /usr/sbin/postalias		system_u:object_r:postfix_master_exec_t
 /usr/sbin/postcat		system_u:object_r:postfix_master_exec_t
 /usr/sbin/postconf		system_u:object_r:postfix_master_exec_t

--------------000204020207040404060803--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
