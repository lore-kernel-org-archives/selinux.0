From: Joshua Brindle <method@manicmethod.com>
Subject: [PATCH] Subject: remove expand_rule function
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Date: Tue, 12 Aug 2008 13:59:32 -0400
Message-ID: <20080812175930.28190.87119.stgit@misterfreeze>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Send again with the right date and time ;)

This removes the (apparently) unused expand_rule function

Signed-off-by: Joshua Brindle <method@manicmethod.com>
---

 libsepol/src/expand.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 3194f8a..14dc4fc 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1917,35 +1917,6 @@ int expand_convert_type_set(policydb_t * p, uint32_t * typemap,
 	return 0;
 }
 
-/* Expand a rule into a given avtab - checking for conflicting type
- * rules.  Return 1 on success, 0 if the rule conflicts with something
- * (and hence was not added), or -1 on error. */
-int expand_rule(sepol_handle_t * handle,
-		policydb_t * source_pol,
-		avrule_t * source_rule, avtab_t * dest_avtab,
-		cond_av_list_t ** cond, cond_av_list_t ** other, int enabled)
-{
-	int retval;
-	ebitmap_t stypes, ttypes;
-
-	if (source_rule->specified & AVRULE_NEVERALLOW)
-		return 1;
-
-	ebitmap_init(&stypes);
-	ebitmap_init(&ttypes);
-
-	if (type_set_expand(&source_rule->stypes, &stypes, source_pol, 1))
-		return -1;
-	if (type_set_expand(&source_rule->ttypes, &ttypes, source_pol, 1))
-		return -1;
-	retval = expand_rule_helper(handle, source_pol, NULL,
-				    source_rule, dest_avtab,
-				    cond, other, enabled, &stypes, &ttypes);
-	ebitmap_destroy(&stypes);
-	ebitmap_destroy(&ttypes);
-	return retval;
-}
-
 int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * rolemap)
 {
 	unsigned int i;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
