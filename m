Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBOIAWIi009184
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 13:10:32 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBOI8ibn014777
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 18:08:45 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1C07261AFD
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 05:10:34 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27259-02 for <selinux@tycho.nsa.gov>;
	Sat, 25 Dec 2004 05:10:33 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 98CAD61AF9
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 05:10:33 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 9A22EA4
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 05:10:32 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: proc_net_t and mail servers
Date: Sat, 25 Dec 2004 05:10:29 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XuFzB4Z2glaS0ry"
Message-Id: <200412250510.31249.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_XuFzB4Z2glaS0ry
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patches grant postfix access to proc_net_t and dontaudit 
system_mail_t and sysadm_mail_t access to proc_net_t when sendmail is being 
used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_XuFzB4Z2glaS0ry
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mta.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mta.diff"

--- /tmp/u/etc/selinux/strict/src/policy/macros/program/sendmail_macros.te	2004-12-25 04:27:33.000000000 +1100
+++ macros/program/sendmail_macros.te	2004-12-25 05:01:09.880287432 +1100
@@ -45,6 +45,7 @@
 ifelse(`$1', `sysadm', `
 allow $1_mail_t proc_t:dir { getattr search };
 allow $1_mail_t proc_t:{ lnk_file file } { getattr read };
+dontaudit $1_mail_t proc_net_t:dir search;
 allow $1_mail_t sysctl_kernel_t:file { getattr read };
 allow $1_mail_t etc_runtime_t:file { getattr read };
 ', `
--- /tmp/u/etc/selinux/strict/src/policy/domains/program/sendmail.te	2004-12-25 04:27:33.000000000 +1100
+++ domains/program/sendmail.te	2004-12-25 05:02:29.787224456 +1100
@@ -86,6 +86,7 @@
 allow system_mail_t proc_t:dir search;
 allow system_mail_t proc_t:file { getattr read };
 allow system_mail_t proc_t:lnk_file read;
+dontaudit system_mail_t proc_net_t:dir search;
 allow sendmail_t sysctl_kernel_t:dir search;
 allow sendmail_t sysctl_kernel_t:file { getattr read };
 allow system_mail_t fs_t:filesystem getattr;

--Boundary-00=_XuFzB4Z2glaS0ry
Content-Type: text/x-diff;
  charset="us-ascii";
  name="postfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="postfix.diff"

--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-12-03 19:49:24.000000000 +1100
+++ domains/program/unused/postfix.te	2004-12-25 04:53:28.000000000 +1100
@@ -52,6 +52,8 @@
 allow postfix_$1_t proc_t:file r_file_perms;
 allow postfix_$1_t postfix_exec_t:dir r_dir_perms;
 allow postfix_$1_t fs_t:filesystem getattr;
+allow postfix_$1_t proc_net_t:dir search;
+allow postfix_$1_t proc_net_t:file { getattr read };
 can_exec(postfix_$1_t, postfix_$1_exec_t)
 
 allow postfix_$1_t tmp_t:dir getattr;

--Boundary-00=_XuFzB4Z2glaS0ry--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
