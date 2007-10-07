Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l97CnPp3023905
	for <selinux@tycho.nsa.gov>; Sun, 7 Oct 2007 08:49:26 -0400
Received: from mx07.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l97CnM43018532
	for <selinux@tycho.nsa.gov>; Sun, 7 Oct 2007 12:49:24 GMT
Subject: [Refpolicy PATCH] (just a m4macro description miss?)
From: shintaro_fujiwara <shin216@xf7.so-net.ne.jp>
To: selinux@tycho.nsa.gov, cpebenito@tresys.com
Content-Type: text/plain
Date: Sun, 07 Oct 2007 21:53:22 +0900
Message-Id: <1191761602.3169.4.camel@notepc.intrajp-yokosuka.co.jp>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Index: policy/modules/services/ucspitcp.if
===================================================================
--- policy/modules/services/ucspitcp.if (revision 2446)
+++ policy/modules/services/ucspitcp.if (working copy)
@@ -20,7 +20,7 @@
 ##     </summary>
 ## </param>
 #
-interface(`ucspitcp_service_domain', `
+interface(`ucspitcp_service_domain',`
	gen_require(`
		type ucspitcp_t;
		role system_r;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
