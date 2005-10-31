Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9VDdhMA012037
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 08:39:43 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9VDYqmc001537
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 13:34:53 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A240061B01
	for <selinux@tycho.nsa.gov>; Tue,  1 Nov 2005 00:34:52 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27370-06 for <selinux@tycho.nsa.gov>;
	Tue, 1 Nov 2005 00:34:52 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B56B161B00
	for <selinux@tycho.nsa.gov>; Tue,  1 Nov 2005 00:34:51 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id C352C2711C
	for <selinux@tycho.nsa.gov>; Tue,  1 Nov 2005 00:34:44 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: sendmail policy
Date: Tue, 1 Nov 2005 00:34:39 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_01hZDqekiRWn28V"
Message-Id: <200511010034.44643.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_01hZDqekiRWn28V
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The sendmail design is difficult for us because the same program is used as an 
application (for queuing mail) and as a daemon (for receiving mail from the 
network).  Attached is a patch to create a new domain for launching sendmail 
which alleviates this problem.

When /etc/init.d/sendmail is executed from initrc_t or sysadm_t it transitions 
to sendmail_launch_t, which then transitions to sendmail_t when executing 
sendmail_exec_t.

Also one of the implications of this change is that the sendmail stop script 
can only signal processes in the sendmail_t domain.  Because of this and 
other factors such as daemon start scripts that re-write config files I will 
probably end up making a macro for this.  But I'm not planning to write new 
macros or other really significant changes before the transition to the 
reference policy.

The main reason for this change is to make things easier for the transition to 
the reference policy (apparently the current policy makes things difficult).  
I'd planned this for a while.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_01hZDqekiRWn28V
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/mta.te.orig	2005-10-31 23:03:34.000000000 +1100
+++ domains/program/mta.te	2005-10-31 23:19:30.000000000 +1100
@@ -38,9 +38,8 @@
 ', `
 ifdef(`sendmail.te', `
 # sendmail has an ugly design, the one process parses input from the user and
-# then does system things with it.
-domain_auto_trans(initrc_t, sendmail_exec_t, sendmail_t)
-', `
+# then does system things with it.  But the sendmail_launch_t domain works
+# around this.
 domain_auto_trans(initrc_t, sendmail_exec_t, system_mail_t)
 ')
 allow initrc_t sendmail_exec_t:lnk_file { getattr read };
--- file_contexts/program/sendmail.fc.orig	2005-10-31 23:06:43.000000000 +1100
+++ file_contexts/program/sendmail.fc	2005-10-31 23:47:48.000000000 +1100
@@ -4,3 +4,10 @@
 /var/log/mail(/.*)?			system_u:object_r:sendmail_log_t:s0
 /var/run/sendmail\.pid		--	system_u:object_r:sendmail_var_run_t:s0
 /var/run/sm-client\.pid		--	system_u:object_r:sendmail_var_run_t:s0
+ifdef(`distro_redhat', `
+/etc/rc.d/init.d/sendmail	--	system_u:object_r:sendmail_launch_exec_t:s0
+/var/lock/subsys/sm-client	--	system_u:object_r:sendmail_launch_lock_t:s0
+/var/lock/subsys/sendmail	--	system_u:object_r:sendmail_launch_lock_t:s0
+', `
+/etc/init.d/sendmail	--	system_u:object_r:sendmail_launch_exec_t:s0
+')
--- domains/program/sendmail.te.orig	2005-10-31 23:03:45.000000000 +1100
+++ domains/program/sendmail.te	2005-11-01 00:20:19.000000000 +1100
@@ -13,7 +13,48 @@
 # daemon started by the init rc scripts.
 #
 
-daemon_domain(sendmail, `, nscd_client_domain, mta_delivery_agent, mail_server_domain, mail_server_sender', nosysadm)
+daemon_base_domain(sendmail_launch)
+range_transition { initrc_t sysadm_t } sendmail_launch_exec_t s0;
+
+allow sendmail_launch_t { etc_t proc_t etc_runtime_t self }:file { getattr read };
+allow sendmail_launch_t { bin_t sbin_t etc_t }:lnk_file { getattr read };
+allow sendmail_launch_t { bin_t sbin_t }:dir search;
+can_exec(sendmail_launch_t, { etc_t bin_t sbin_t shell_exec_t })
+access_terminal(sendmail_launch_t, sysadm)
+ifdef(`consoletype.te', `
+domain_auto_trans(sendmail_launch_t, consoletype_exec_t, consoletype_t)
+')
+read_locale(sendmail_launch_t)
+r_dir_file(sendmail_launch_t, etc_mail_t)
+allow sendmail_launch_t self:fifo_file rw_file_perms;
+allow sendmail_launch_t self:capability { chown kill sys_nice };
+allow sendmail_launch_t self:unix_stream_socket create_stream_socket_perms;
+can_ps(sendmail_launch_t, sendmail_t)
+dontaudit sendmail_launch_t domain:dir search;
+allow sendmail_launch_t sendmail_t:process signal;
+ifdef(`distro_redhat', `
+lock_domain(sendmail_launch)
+')
+dontaudit sendmail_launch_t mnt_t:dir search;
+allow sendmail_launch_t devpts_t:dir search;
+
+file_type_auto_trans(sendmail_launch_t, var_run_t, sendmail_var_run_t, file)
+
+daemon_core_rules(sendmail, `, nscd_client_domain, mta_delivery_agent, mail_server_domain, mail_server_sender')
+
+# stuff from daemon_domain and daemon_base_domain because we can not have an
+# automatic transition from initrc_t
+rhgb_domain(sendmail_t)
+read_sysctl(sendmail_t)
+domain_auto_trans(sendmail_launch_t, sendmail_exec_t, sendmail_t)
+allow sendmail_t privfd:fd use;
+allow { sendmail_t sendmail_launch_t } var_t:dir { getattr search };
+var_run_domain(sendmail)
+allow sendmail_t devtty_t:chr_file rw_file_perms;
+dontaudit { sendmail_t sendmail_launch_t } sysadm_home_dir_t:dir search;
+read_locale(sendmail_t)
+allow sendmail_t fs_t:filesystem getattr;
+
 
 tmp_domain(sendmail)
 logdir_domain(sendmail)
@@ -48,11 +89,6 @@
 
 allow sendmail_t etc_mail_t:dir rw_dir_perms;
 allow sendmail_t etc_mail_t:file create_file_perms;
-# for the start script to run make -C /etc/mail
-allow initrc_t etc_mail_t:dir rw_dir_perms;
-allow initrc_t etc_mail_t:file create_file_perms;
-allow system_mail_t initrc_t:fd use;
-allow system_mail_t initrc_t:fifo_file write;
 
 # Write to /var/spool/mail and /var/spool/mqueue.
 allow sendmail_t var_spool_t:dir { getattr search };
@@ -101,7 +137,7 @@
 ifdef(`crond.te', `
 dontaudit system_mail_t system_crond_tmp_t:file append;
 ')
-dontaudit sendmail_t admin_tty_type:chr_file { getattr ioctl };
+dontaudit sendmail_t admin_tty_type:chr_file rw_file_perms;
 
 # sendmail wants to read /var/run/utmp if the controlling tty is /dev/console
 allow sendmail_t initrc_var_run_t:file { getattr read };

--Boundary-00=_01hZDqekiRWn28V--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
