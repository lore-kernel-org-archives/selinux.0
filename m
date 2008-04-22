From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: context.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:13 -0400
Message-Id: <12089007783451-git-send-email-eparis@redhat.com>
In-Reply-To: <12089007784055-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
 <12089007782327-git-send-email-eparis@redhat.com>
 <120890077840-git-send-email-eparis@redhat.com>
 <12089007784055-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes context.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

include spaces around , in function calls

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/ss/context.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 2eee0da..b9a6f7f 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -84,9 +84,9 @@ static inline int mls_context_cmp(struct context *c1, struct context *c2)
 		return 1;
 
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
-		ebitmap_cmp(&c1->range.level[0].cat,&c2->range.level[0].cat) &&
+		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
 		(c1->range.level[1].sens == c2->range.level[1].sens) &&
-		ebitmap_cmp(&c1->range.level[1].cat,&c2->range.level[1].cat));
+		ebitmap_cmp(&c1->range.level[1].cat, &c2->range.level[1].cat));
 }
 
 static inline void mls_context_destroy(struct context *c)
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
