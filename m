From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: Augment BUG_ON assertion for secclass_map.
Date: Mon, 15 Jun 2015 13:27:10 -0400
Message-Id: <1434389230-1438-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ensure that we catch any cases where tclass == 0.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 3c17dda..dcb8b0f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -101,6 +101,7 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 		return;
 	}
 
+	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
 	perms = secclass_map[tclass-1].perms;
 
 	audit_log_format(ab, " {");
@@ -149,7 +150,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 		kfree(scontext);
 	}
 
-	BUG_ON(tclass >= ARRAY_SIZE(secclass_map));
+	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
 	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
 }
 
-- 
2.1.0
