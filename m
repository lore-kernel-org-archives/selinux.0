Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9E9bRvr006147
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 05:37:27 -0400
Received: from mx51.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9E9bPMP024562
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 09:37:26 GMT
Subject: [PATCH] refpolicy:groupadd_t needs transition to nscd_t
From: shintaro_fujiwara <shin216@xf7.so-net.ne.jp>
To: selinux@tycho.nsa.gov, pebenito@tresys.com
Content-Type: text/plain
Date: Sun, 14 Oct 2007 18:42:23 +0900
Message-Id: <1192354943.3074.1.camel@notepc.intrajp-yokosuka.co.jp>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- policy/modules/admin/usermanage.te  (revision 2454)
+++ policy/modules/admin/usermanage.te  (working copy)
@@ -227,6 +227,8 @@
 
 miscfiles_read_localization(groupadd_t)
 
+nscd_domtrans(groupadd_t)
+
 auth_manage_shadow(groupadd_t)
 auth_relabel_shadow(groupadd_t)
 auth_etc_filetrans_shadow(groupadd_t)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
