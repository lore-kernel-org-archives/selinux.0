Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA27496
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 00:35:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA25816
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 04:33:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id EAA25812
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 04:33:34 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0261592724
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 14:34:56 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 4C4416CB
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 06:34:47 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: mta patch
Date: Sat, 21 Sep 2002 06:34:46 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_Y1URROBNB22O2GDUWZ6L"
Message-Id: <200209210634.46864.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_Y1URROBNB22O2GDUWZ6L
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The attached policy patch improves the support for qmail and postfix, the 
general support for mail servers other than Sendmail, and allows initrc_t 
programs to run mailx (IE to send mail from an initrc script).

-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.

--------------Boundary-00=_Y1URROBNB22O2GDUWZ6L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mta.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mta.diff"

diff -ru /tmp/policy/domains/program/initrc.te policy/domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2002-09-21 05:01:26.000000000 +0200
+++ policy/domains/program/initrc.te	2002-09-21 05:22:05.000000000 +0200
@@ -9,7 +9,7 @@
 # initrc_t is the domain of the init rc scripts.
 # initrc_exec_t is the type of the init program.
 #
-type initrc_t, domain, privlog, privowner;
+type initrc_t, domain, privlog, privowner, privmail;
 role system_r types initrc_t;
 every_domain(initrc_t)
 type initrc_exec_t, file_type, sysadmfile, exec_type;
diff -ru /tmp/policy/domains/program/qmail.te policy/domains/program/qmail.te
--- /tmp/policy/domains/program/qmail.te	2002-08-23 20:44:19.000000000 +0200
+++ policy/domains/program/qmail.te	2002-09-20 23:04:07.000000000 +0200
@@ -140,7 +140,7 @@
 allow qmail_qread_t etc_qmail_t:dir search;
 allow qmail_qread_t privfd:fd use;
 
-daemon_sub_domain(qmail_inject_t, qmail_queue)
+daemon_sub_domain(qmail_inject_t, qmail_queue, `, mta_user_agent')
 role sysadm_r types qmail_queue_t;
 in_user_role(qmail_queue_t)
 allow qmail_inject_t qmail_queue_exec_t:file read;
diff -ru /tmp/policy/file_contexts/program/postfix.fc policy/file_contexts/program/postfix.fc
--- /tmp/policy/file_contexts/program/postfix.fc	2002-08-26 18:50:44.000000000 +0200
+++ policy/file_contexts/program/postfix.fc	2002-09-13 13:49:12.000000000 +0200
@@ -7,7 +7,7 @@
 /usr/lib/postfix/local		system_u:object_r:postfix_local_exec_t
 /usr/lib/postfix/master		system_u:object_r:postfix_master_exec_t
 /usr/lib/postfix/pickup		system_u:object_r:postfix_pickup_exec_t
-/usr/lib/postfix/qmgr		system_u:object_r:postfix_qmgr_exec_t
+/usr/lib/postfix/(n)?qmgr	system_u:object_r:postfix_qmgr_exec_t
 /usr/lib/postfix/showq		system_u:object_r:postfix_showq_exec_t
 /usr/lib/postfix/smtp		system_u:object_r:postfix_smtp_exec_t
 /usr/lib/postfix/smtpd		system_u:object_r:postfix_smtpd_exec_t
diff -ru /tmp/policy/macros/program/mta_macros.te policy/macros/program/mta_macros.te
--- /tmp/policy/macros/program/mta_macros.te	2002-08-26 18:50:44.000000000 +0200
+++ policy/macros/program/mta_macros.te	2002-09-20 23:03:17.000000000 +0200
@@ -62,6 +62,8 @@
 ')
 allow mta_user_agent $1_tmp_t:file { read getattr };
 
+allow mta_user_agent { $1_devpts_t $1_tty_device_t }:chr_file { read write };
+
 # Write to the user domain tty.
 allow $1_mail_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_mail_t $1_devpts_t:chr_file rw_file_perms;

--------------Boundary-00=_Y1URROBNB22O2GDUWZ6L--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
