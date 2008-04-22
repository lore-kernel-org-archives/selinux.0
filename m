From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: mls.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:15 -0400
Message-Id: <12089007782044-git-send-email-eparis@redhat.com>
In-Reply-To: <12089007782803-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
 <12089007782327-git-send-email-eparis@redhat.com>
 <120890077840-git-send-email-eparis@redhat.com>
 <12089007784055-git-send-email-eparis@redhat.com>
 <12089007783451-git-send-email-eparis@redhat.com>
 <12089007782803-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes mls.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

spaces used instead of tabs

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/ss/mls.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index ab53663..0fdf625 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -13,7 +13,7 @@
 /*
  * Updated: Hewlett-Packard <paul.moore@hp.com>
  *
- *      Added support to import/export the MLS label from NetLabel
+ *	Added support to import/export the MLS label from NetLabel
  *
  * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
  */
@@ -31,7 +31,7 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r);
 int mls_level_isvalid(struct policydb *p, struct mls_level *l);
 
 int mls_context_to_sid(char oldc,
-	               char **scontext,
+		       char **scontext,
 		       struct context *context,
 		       struct sidtab *s,
 		       u32 def_sid);
@@ -49,7 +49,7 @@ int mls_compute_sid(struct context *scontext,
 		    struct context *newcontext);
 
 int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
-                         struct context *usercon);
+			 struct context *usercon);
 
 #ifdef CONFIG_NETLABEL
 void mls_export_netlbl_lvl(struct context *context,
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
