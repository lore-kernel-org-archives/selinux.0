Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAU5qPIi016062
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 00:52:26 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAU5ohWg008541
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 05:50:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 39E4D61AFE
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 16:52:16 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 24981-04 for <selinux@tycho.nsa.gov>;
	Tue, 30 Nov 2004 16:52:15 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1EF9361AFD
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 16:52:15 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 93428E3
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 16:52:06 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: proc_net_t policy
Date: Tue, 30 Nov 2004 16:52:03 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GqArBiblTZ00Qgo"
Message-Id: <200411301652.06178.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_GqArBiblTZ00Qgo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch to support proc_net_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_GqArBiblTZ00Qgo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-11-21 21:51:14.000000000 +1100
+++ domains/program/unused/postfix.te	2004-11-28 17:35:23.000000000 +1100
@@ -158,6 +158,8 @@
 allow postfix_$1_t self:capability { setuid setgid dac_override };
 can_network(postfix_$1_t)
 can_ypbind(postfix_$1_t)
+allow postfix_$1_t proc_net_t:dir search;
+allow postfix_$1_t proc_net_t:file { getattr read };
 ')
 
 postfix_server_domain(smtp, `, mail_server_sender')
@@ -272,6 +271,8 @@
 allow postfix_showq_t self:tcp_socket create_socket_perms;
 allow postfix_showq_t { ttyfile ptyfile }:chr_file { read write };
 dontaudit postfix_showq_t net_conf_t:file r_file_perms;
+allow postfix_showq_t proc_net_t:dir search;
+allow postfix_showq_t proc_net_t:file { getattr read };
 
 postfix_user_domain(postdrop, `, mta_user_agent')
 allow postfix_postdrop_t postfix_spool_maildrop_t:dir rw_dir_perms;
--- /usr/src/se/policy/domains/program/unused/dhcpc.te	2004-11-13 03:56:01.000000000 +1100
+++ domains/program/unused/dhcpc.te	2004-11-28 17:25:58.000000000 +1100
@@ -79,7 +79,8 @@
 
 allow dhcpc_t etc_t:lnk_file read;
 allow dhcpc_t { etc_t etc_runtime_t }:file { getattr read };
-allow dhcpc_t proc_t:file { getattr read };
+allow dhcpc_t proc_net_t:dir search;
+allow dhcpc_t { proc_t proc_net_t }:file { getattr read };
 allow dhcpc_t self:file { getattr read };
 allow dhcpc_t sysctl_kernel_t:dir search;
 allow dhcpc_t sysctl_kernel_t:file read;
--- /usr/src/se/policy/domains/program/unused/sysstat.te	2004-06-17 15:10:41.000000000 +1000
+++ domains/program/unused/sysstat.te	2004-11-28 07:45:40.000000000 +1100
@@ -51,8 +51,8 @@
 allow sysstat_t fs_t:filesystem getattr;
 
 # get info from /proc
-allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:dir r_dir_perms;
-allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:file { read getattr };
+allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t proc_net_t }:dir r_dir_perms;
+allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t proc_net_t }:file { read getattr };
 
 domain_auto_trans(initrc_t, sysstat_exec_t, sysstat_t)
 allow sysstat_t init_t:fd use;

--Boundary-00=_GqArBiblTZ00Qgo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
