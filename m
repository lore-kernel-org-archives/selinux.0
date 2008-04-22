From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: mls_types.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:16 -0400
Message-Id: <12089007783524-git-send-email-eparis@redhat.com>
In-Reply-To: <12089007782044-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
 <12089007782327-git-send-email-eparis@redhat.com>
 <120890077840-git-send-email-eparis@redhat.com>
 <12089007784055-git-send-email-eparis@redhat.com>
 <12089007783451-git-send-email-eparis@redhat.com>
 <12089007782803-git-send-email-eparis@redhat.com>
 <12089007782044-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes mls_types.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

spaces used instead of tabs

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/ss/mls_types.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index 0c692d5..b6e943a 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -31,7 +31,7 @@ static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
 		return 1;
 
 	return ((l1->sens == l2->sens) &&
-	        ebitmap_cmp(&l1->cat, &l2->cat));
+		ebitmap_cmp(&l1->cat, &l2->cat));
 }
 
 static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
@@ -40,7 +40,7 @@ static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
 		return 1;
 
 	return ((l1->sens >= l2->sens) &&
-	        ebitmap_contains(&l1->cat, &l2->cat));
+		ebitmap_contains(&l1->cat, &l2->cat));
 }
 
 #define mls_level_incomp(l1, l2) \
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
