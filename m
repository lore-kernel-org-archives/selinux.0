Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71FO1fd004158
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 11:24:01 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l71FNuKI021844
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 15:23:56 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070801151554.725968439@hp.com>
References: <20070801151257.475951538@hp.com>
Date: Wed, 01 Aug 2007 11:12:58 -0400
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/2] SELinux: remove redundant pointer checks before calling kfree()
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We don't need to check for NULL pointers before calling kfree().

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/hooks.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6_secctx-leaks/security/selinux/hooks.c
===================================================================
--- linux-2.6_secctx-leaks.orig/security/selinux/hooks.c
+++ linux-2.6_secctx-leaks/security/selinux/hooks.c
@@ -4658,8 +4658,7 @@ static int selinux_secid_to_secctx(u32 s
 
 static void selinux_release_secctx(char *secdata, u32 seclen)
 {
-	if (secdata)
-		kfree(secdata);
+	kfree(secdata);
 }
 
 #ifdef CONFIG_KEYS

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
