Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9E53WuG020043
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 01:03:32 -0400
Received: from mx53.ms.so-net.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9E53UJR024006
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 05:03:31 GMT
Subject: [PATCH] refpolicy:useradd_t needs process transition to nscd_t
From: shintaro_fujiwara <shin216@xf7.so-net.ne.jp>
To: selinux@tycho.nsa.gov, cpebenito@tresys.com
Content-Type: text/plain
Date: Sun, 14 Oct 2007 14:08:31 +0900
Message-Id: <1192338511.3126.11.camel@notepc.intrajp-yokosuka.co.jp>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Index: policy/modules/admin/usermanage.te
===================================================================
--- policy/modules/admin/usermanage.te  (revision 2454)
+++ policy/modules/admin/usermanage.te  (working copy)
@@ -502,6 +502,8 @@
 
 miscfiles_read_localization(useradd_t)
 
+nscd_domtrans(useradd_t)
+
 seutil_read_config(useradd_t)
 seutil_read_file_contexts(useradd_t)
 seutil_read_default_contexts(useradd_t)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
