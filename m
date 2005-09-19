Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8J9OfNs015975
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 05:24:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8J9Kh6H028020
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 09:20:45 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 60FAD61B07
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 19:20:48 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30335-10 for <selinux@tycho.nsa.gov>;
	Mon, 19 Sep 2005 19:20:48 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DF63361B00
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 19:20:47 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: postfix policy patch
Date: Mon, 19 Sep 2005 19:20:39 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uLoLDh2yNdY3HY8"
Message-Id: <200509191920.46554.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_uLoLDh2yNdY3HY8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows the mail server to access the user home directories 
in the targeted policy, doesn't audit when "find" is run by the Postfix 
startup and tries to check the SE Linux status, and allows the postfix 
"showq" program to do DNS lookups.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_uLoLDh2yNdY3HY8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mail.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mail.diff"

--- domains/program/mta.te.orig	2005-09-19 19:05:47.000000000 +1000
+++ domains/program/mta.te	2005-09-19 19:06:28.000000000 +1000
@@ -31,6 +31,10 @@
 create_dir_file(system_mail_t, mail_spool_t)
 allow system_mail_t mail_spool_t:fifo_file rw_file_perms;
 allow system_mail_t etc_mail_t:file { getattr read };
+
+# for reading .forward - maybe we need a new type for it?
+# also for delivering mail to maildir
+file_type_auto_trans(mta_delivery_agent, user_home_dir_t, user_home_t)
 ', `
 ifdef(`sendmail.te', `
 # sendmail has an ugly design, the one process parses input from the user and
--- domains/program/postfix.te.orig	2005-09-19 18:57:56.000000000 +1000
+++ domains/program/postfix.te	2005-09-19 19:00:02.000000000 +1000
@@ -69,6 +69,9 @@
 postfix_domain(master, `, mail_server_domain')
 rhgb_domain(postfix_master_t)
 
+# for a find command
+dontaudit postfix_master_t security_t:dir search;
+
 read_sysctl(postfix_master_t)
 
 domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
@@ -260,7 +263,7 @@
 postfix_user_domain(showq)
 # the following auto_trans is usually in postfix server domain
 domain_auto_trans(postfix_master_t, postfix_showq_exec_t, postfix_showq_t)
-allow postfix_showq_t self:udp_socket { create ioctl };
+can_resolve(postfix_showq_t)
 r_dir_file(postfix_showq_t, postfix_spool_maildrop_t)
 domain_auto_trans(postfix_postqueue_t, postfix_showq_exec_t, postfix_showq_t)
 allow postfix_showq_t self:capability { setuid setgid };

--Boundary-00=_uLoLDh2yNdY3HY8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
