From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 11/13] SELinux: mls.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:32 -0400
Message-Id: <12085547143694-git-send-email-eparis@redhat.com>
In-Reply-To: <1208554714873-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
 <12085547141335-git-send-email-eparis@redhat.com>
 <12085547141160-git-send-email-eparis@redhat.com>
 <12085547142556-git-send-email-eparis@redhat.com>
 <12085547141952-git-send-email-eparis@redhat.com>
 <1208554714873-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes mls.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
locateion of { around struct and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/ss/mls.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index feaf0a5..8b1706b 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -32,7 +32,7 @@
  * Return the length in bytes for the MLS fields of the
  * security context string representation of `context'.
  */
-int mls_compute_context_len(struct context * context)
+int mls_compute_context_len(struct context *context)
 {
 	int i, l, len, head, prev;
 	char *nm;
@@ -86,7 +86,7 @@ int mls_compute_context_len(struct context * context)
  * Update `*scontext' to point to the end of the MLS fields.
  */
 void mls_sid_to_context(struct context *context,
-                        char **scontext)
+			char **scontext)
 {
 	char *scontextp, *nm;
 	int i, l, head, prev;
@@ -146,7 +146,7 @@ void mls_sid_to_context(struct context *context,
 
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
-			                 &context->range.level[1]))
+					 &context->range.level[1]))
 				break;
 			else
 				*scontextp++ = '-';
@@ -305,20 +305,21 @@ int mls_context_to_sid(char oldc,
 					*p++ = 0;
 
 				/* Separate into range if exists */
-				if ((rngptr = strchr(scontextp, '.')) != NULL) {
+				rngptr = strchr(scontextp, '.');
+				if (rngptr != NULL) {
 					/* Remove '.' */
 					*rngptr++ = 0;
 				}
 
 				catdatum = hashtab_search(policydb.p_cats.table,
-				                          scontextp);
+							  scontextp);
 				if (!catdatum) {
 					rc = -EINVAL;
 					goto out;
 				}
 
 				rc = ebitmap_set_bit(&context->range.level[l].cat,
-				                     catdatum->value - 1, 1);
+						     catdatum->value - 1, 1);
 				if (rc)
 					goto out;
 
@@ -395,7 +396,7 @@ int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
 		rc = -ENOMEM;
 	} else {
 		rc = mls_context_to_sid(':', &tmpstr, context,
-		                        NULL, SECSID_NULL);
+					NULL, SECSID_NULL);
 		kfree(freestr);
 	}
 
@@ -406,7 +407,7 @@ int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
  * Copies the MLS range `range' into `context'.
  */
 static inline int mls_range_set(struct context *context,
-                                struct mls_range *range)
+				struct mls_range *range)
 {
 	int l, rc = 0;
 
@@ -423,7 +424,7 @@ static inline int mls_range_set(struct context *context,
 }
 
 int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
-                         struct context *usercon)
+			 struct context *usercon)
 {
 	if (selinux_mls_enabled) {
 		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
@@ -449,11 +450,11 @@ int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
 		   that of the user's default clearance (but
 		   only if the "fromcon" clearance dominates
 		   the user's computed sensitivity level) */
-		if (mls_level_dom(user_clr, fromcon_clr)) {
+		if (mls_level_dom(user_clr, fromcon_clr))
 			*usercon_clr = *fromcon_clr;
-		} else if (mls_level_dom(fromcon_clr, user_clr)) {
+		else if (mls_level_dom(fromcon_clr, user_clr))
 			*usercon_clr = *user_clr;
-		} else
+		else
 			return -EINVAL;
 	}
 
@@ -525,7 +526,7 @@ int mls_compute_sid(struct context *scontext,
 			    rtr->target_class == tclass) {
 				/* Set the range from the rule */
 				return mls_range_set(newcontext,
-				                     &rtr->target_range);
+						     &rtr->target_range);
 			}
 		}
 		/* Fallthrough */
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
