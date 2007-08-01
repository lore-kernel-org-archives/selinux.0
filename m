Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71FHotn003425
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 11:17:51 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l71FHoKI020108
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 15:17:50 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070801151557.264877461@hp.com>
References: <20070801151257.475951538@hp.com>
Date: Wed, 01 Aug 2007 11:12:59 -0400
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/2] NET: fix memory leaks from security_secid_to_secctx()
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The security_secid_to_secctx() function returns memory that must be freed
by a call to security_release_secctx() which was not always happening.  This
patch fixes two of these problems (all that I could find in the kernel source
at present).

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/netlabel/netlabel_user.c |    4 +++-
 net/xfrm/xfrm_policy.c       |    5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6_secctx-leaks/net/netlabel/netlabel_user.c
===================================================================
--- linux-2.6_secctx-leaks.orig/net/netlabel/netlabel_user.c
+++ linux-2.6_secctx-leaks/net/netlabel/netlabel_user.c
@@ -113,8 +113,10 @@ struct audit_buffer *netlbl_audit_start_
 	if (audit_info->secid != 0 &&
 	    security_secid_to_secctx(audit_info->secid,
 				     &secctx,
-				     &secctx_len) == 0)
+				     &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
+		security_release_secctx(secctx, secctx_len);
+	}
 
 	return audit_buf;
 }
Index: linux-2.6_secctx-leaks/net/xfrm/xfrm_policy.c
===================================================================
--- linux-2.6_secctx-leaks.orig/net/xfrm/xfrm_policy.c
+++ linux-2.6_secctx-leaks/net/xfrm/xfrm_policy.c
@@ -2195,9 +2195,10 @@ void xfrm_audit_log(uid_t auid, u32 sid,
 	}
 
 	if (sid != 0 &&
-		security_secid_to_secctx(sid, &secctx, &secctx_len) == 0)
+	    security_secid_to_secctx(sid, &secctx, &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
-	else
+		security_release_secctx(secctx, secctx_len);
+	} else
 		audit_log_task_context(audit_buf);
 
 	if (xp) {

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
