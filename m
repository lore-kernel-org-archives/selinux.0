Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i817r7rT018994
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 03:53:07 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i817r3eu022613
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 07:53:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C650961AFE
	for <selinux@tycho.nsa.gov>; Wed,  1 Sep 2004 17:53:03 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15078-02 for <selinux@tycho.nsa.gov>;
	Wed, 1 Sep 2004 17:53:03 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6AFB761AFC
	for <selinux@tycho.nsa.gov>; Wed,  1 Sep 2004 17:53:03 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0BDCFB58DA
	for <selinux@tycho.nsa.gov>; Wed,  1 Sep 2004 17:53:02 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: udev policy
Date: Wed, 1 Sep 2004 17:53:01 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d/XNB/InSTd7XTk"
Message-Id: <200409011753.01483.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_d/XNB/InSTd7XTk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows udev in rawhide to work properly with no audit 
messages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_d/XNB/InSTd7XTk
Content-Type: text/x-diff;
  charset="us-ascii";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- /usr/src/se/policy/domains/program/unused/udev.te	2004-09-01 10:52:36.000000000 +1000
+++ domains/program/unused/udev.te	2004-09-01 17:51:52.000000000 +1000
@@ -43,7 +43,8 @@
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
 	
 # to read the file_contexts file
-r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
+allow udev_t { selinux_config_t default_context_t file_context_t }:dir search;
+allow udev_t { selinux_config_t file_context_t }:file { getattr read };
 
 allow udev_t policy_config_t:dir { search };
 allow udev_t proc_t:file { read };
@@ -82,6 +83,11 @@
 ifdef(`consoletype.te', `
 can_exec(udev_t, consoletype_exec_t)
 ')
+ifdef(`pamconsole.te', `
+allow udev_t pam_var_console_t:dir search;
+')
+allow udev_t var_lock_t:dir search;
+allow udev_t var_lock_t:file getattr;
 domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
 ifdef(`hide_broken_symptoms', `
 dontaudit ifconfig_t udev_t:unix_dgram_socket { read write };

--Boundary-00=_d/XNB/InSTd7XTk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
