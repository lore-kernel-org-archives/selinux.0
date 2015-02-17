Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1HKUWeH005127
 for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2015 15:30:32 -0500
Subject: [PATCH] selinux: reconcile security_netlbl_secattr_to_sid() and
 mls_import_netlbl_cat()
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 17 Feb 2015 15:30:23 -0500
Message-ID: <20150217203023.17101.31816.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rickard_strandqvist@spectrumdigital.se
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move the NetLabel secattr MLS category import logic into
mls_import_netlbl_cat() where it belongs, and use the
mls_import_netlbl_cat() function in security_netlbl_secattr_to_sid().

Reported-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/ss/mls.c      |   10 +++-------
 security/selinux/ss/services.c |    6 +-----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index d307b37..e108884 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -654,19 +654,15 @@ int mls_import_netlbl_cat(struct context *context,
 
 	rc = ebitmap_netlbl_import(&context->range.level[0].cat,
 				   secattr->attr.mls.cat);
-	if (rc != 0)
-		goto import_netlbl_cat_failure;
-
-	rc = ebitmap_cpy(&context->range.level[1].cat,
-			 &context->range.level[0].cat);
-	if (rc != 0)
+	if (rc)
 		goto import_netlbl_cat_failure;
+	memcpy(&context->range.level[1].cat, &context->range.level[0].cat,
+	       sizeof(context->range.level[0].cat));
 
 	return 0;
 
 import_netlbl_cat_failure:
 	ebitmap_destroy(&context->range.level[0].cat);
-	ebitmap_destroy(&context->range.level[1].cat);
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a1d3944..9e2d820 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3179,13 +3179,9 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		ctx_new.type = ctx->type;
 		mls_import_netlbl_lvl(&ctx_new, secattr);
 		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
-			rc = ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
-						   secattr->attr.mls.cat);
+			rc = mls_import_netlbl_cat(&ctx_new, secattr);
 			if (rc)
 				goto out;
-			memcpy(&ctx_new.range.level[1].cat,
-			       &ctx_new.range.level[0].cat,
-			       sizeof(ctx_new.range.level[0].cat));
 		}
 		rc = -EIDRM;
 		if (!mls_context_isvalid(&policydb, &ctx_new))
