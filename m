Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88IT3rT006392
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 14:29:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88IT1fe028679
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 18:29:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DE34661AFC
	for <selinux@tycho.nsa.gov>; Thu,  9 Sep 2004 04:28:55 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05399-03 for <selinux@tycho.nsa.gov>;
	Thu, 9 Sep 2004 04:28:55 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8139161AF9
	for <selinux@tycho.nsa.gov>; Thu,  9 Sep 2004 04:28:55 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3E937B58F0
	for <selinux@tycho.nsa.gov>; Thu,  9 Sep 2004 04:28:54 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ssh policy
Date: Thu, 9 Sep 2004 04:28:52 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k90PBm7q2ZqPtJF"
Message-Id: <200409090428.52881.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_k90PBm7q2ZqPtJF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch restores the functionality of sshd_extern_t after the 
recent can_exec change.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_k90PBm7q2ZqPtJF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ssh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ssh.diff"

--- /usr/src/se/policy/domains/program/ssh.te	2004-09-02 23:18:48.000000000 +1000
+++ ./domains/program/ssh.te	2004-09-07 23:36:07.000000000 +1000
@@ -26,6 +26,8 @@
 # privfd is for passing the terminal file handle to the user process
 # auth_chkpwd is for running unix_chkpwd and unix_verify.
 type $1_t, domain, privuser, privrole, privlog, privowner, privfd, auth_chkpwd, nscd_client_domain;
+can_exec($1_t, sshd_exec_t)
+r_dir_file($1_t, self)
 role system_r types $1_t;
 dontaudit $1_t shadow_t:file { getattr read };
 uses_shlib($1_t)
@@ -147,8 +149,6 @@
 # sshd_extern_t is the domain for ssh from outside our network
 #
 sshd_program_domain(sshd)
-can_exec(sshd_t, sshd_exec_t)
-r_dir_file(sshd_t, self)
 if (ssh_sysadm_login) {
 sshd_spawn_domain(sshd, userdomain, { sysadm_devpts_t userpty_type })
 } else {

--Boundary-00=_k90PBm7q2ZqPtJF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
