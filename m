Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9E4j4M6019243
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 00:45:05 -0400
Received: from mx09.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9E4j2oq021290
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 04:45:03 GMT
Subject: [PATCH] refpolicy:locallogin problem still exists?
From: shintaro_fujiwara <shin216@xf7.so-net.ne.jp>
To: selinux@tycho.nsa.gov, cpebenito@tresys.com
Content-Type: text/plain
Date: Sun, 14 Oct 2007 13:49:58 +0900
Message-Id: <1192337398.3126.8.camel@notepc.intrajp-yokosuka.co.jp>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Index: modules/system/locallogin.te
===================================================================
--- modules/system/locallogin.te        (revision 2454)
+++ modules/system/locallogin.te        (working copy)
@@ -33,7 +33,7 @@
 # Local login local policy
 #
 
-allow local_login_t self:capability { dac_override chown fowner fsetid
kill setgid setuid sys_nice sys_resource sys_tty_config };
+allow local_login_t self:capability { audit_control dac_override chown
fowner fsetid kill setgid setuid sys_nice sys_resource sys_tty_config };
 allow local_login_t self:process ~{ ptrace setcurrent setexec
setfscreate setrlimit execmem execstack execheap };
 allow local_login_t self:process { setrlimit setexec };
 allow local_login_t self:fd use;
@@ -102,6 +102,8 @@
 auth_rw_faillog(local_login_t)
 auth_manage_pam_console_data(local_login_t)
 auth_domtrans_pam_console(local_login_t)
+auth_domtrans_chk_passwd(local_login_t)
+logging_send_audit_msgs(local_login_t)
 
 corecmd_list_bin(local_login_t)
 corecmd_read_bin_symlinks(local_login_t)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
