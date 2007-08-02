Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KYmtf024869
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:34:48 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KYkM1006719
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:34:46 GMT
Date: Thu, 2 Aug 2007 16:33:35 -0400
Message-Id: <200708022033.l72KXZNT032350@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_ssh changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove unconfined_domain from sshd
Multiple minor fixes

--- nsaserefpolicy/policy/modules/services/ssh.if	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/ssh.if	2007-08-02 11:02:02.000000000 -0400
@@ -202,6 +202,7 @@
 #
 template(`ssh_per_role_template',`
 	gen_require(`
+		type sshd_t;
 		type ssh_agent_exec_t, ssh_keysign_exec_t;
 	')
 
@@ -708,3 +709,42 @@
 
 	dontaudit $1 sshd_key_t:file { getattr read };
 ')
+
+########################################
+## <summary>
+##	Inherit and use a file descriptor
+##	from the ssh-agent.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ssh_use_user_ssh_agent_fds',`
+	gen_require(`
+		type $1_ssh_agent_t;
+	')
+
+	allow $2 $1_ssh_agent_t:fd use;
+')
+
+########################################
+## <summary>
+##	dontaudit use of file descriptor
+##	from the ssh-agent.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ssh_dontaudit_use_user_ssh_agent_fds',`
+	gen_require(`
+		type $1_ssh_agent_t;
+	')
+
+	dontaudit $2 $1_ssh_agent_t:fd use;
+')
+
--- nsaserefpolicy/policy/modules/services/ssh.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/ssh.te	2007-08-02 11:02:02.000000000 -0400
@@ -24,7 +24,7 @@
 
 # Type for the ssh-agent executable.
 type ssh_agent_exec_t;
-files_type(ssh_agent_exec_t)
+application_executable_file(ssh_agent_exec_t)
 
 # ssh client executable.
 type ssh_exec_t;
@@ -100,6 +100,11 @@
 	userdom_use_unpriv_users_ptys(sshd_t)
 ')
 
+
+optional_policy(`
+	xserver_getattr_xauth(sshd_t)
+')
+
 optional_policy(`
 	daemontools_service_domain(sshd_t, sshd_exec_t)
 ')
@@ -119,7 +124,12 @@
 ')
 
 optional_policy(`
-	unconfined_domain(sshd_t)
+	usermanage_read_crack_db(sshd_t)
+')
+
+optional_policy(`
+	unconfined_shell_domtrans(sshd_t)
+	userdom_read_all_users_home_content_files(sshd_t)
 ')
 
 ifdef(`TODO',`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
