From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: netlabel.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:09 -0400
Message-Id: <1208900778580-git-send-email-eparis@redhat.com>
In-Reply-To: <12089007782175-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes netlabel.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

spaces used instead of tabs

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/include/netlabel.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 9a9e7cd..487a7d8 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -64,7 +64,7 @@ static inline void selinux_netlbl_cache_invalidate(void)
 }
 
 static inline void selinux_netlbl_sk_security_reset(
-	                                       struct sk_security_struct *ssec,
+					       struct sk_security_struct *ssec,
 					       int family)
 {
 	return;
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
