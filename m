Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m93EpcNk004316
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 10:51:38 -0400
Received: from g5t0009.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m93Epc8A029194
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 14:51:38 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH] selinux: Fix an uninitialized variable BUG/panic in
	selinux_secattr_to_sid()
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org
Date: Fri, 03 Oct 2008 10:51:15 -0400
Message-ID: <20081003145114.22380.57711.stgit@flek>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At some point during the 2.6.27 development cycle two new fields were added
to the SELinux context structure, a string pointer and a length field.  The
code in selinux_secattr_to_sid() was not modified and as a result these two
fields were left uninitialized which could result in erratic behavior,
including kernel panics, when NetLabel is used.  This patch fixes the
problem by fully initializing the context in selinux_secattr_to_sid() before
use and reducing the level of direct context manipulation done to help
prevent future problems.

Please apply this to the 2.6.27-rcX release stream.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/ss/services.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d11a815..8551952 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2737,6 +2737,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		if (ctx == NULL)
 			goto netlbl_secattr_to_sid_return;
 
+		context_init(&ctx_new);
 		ctx_new.user = ctx->user;
 		ctx_new.role = ctx->role;
 		ctx_new.type = ctx->type;
@@ -2745,13 +2746,9 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 			if (ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
 						  secattr->attr.mls.cat) != 0)
 				goto netlbl_secattr_to_sid_return;
-			ctx_new.range.level[1].cat.highbit =
-				ctx_new.range.level[0].cat.highbit;
-			ctx_new.range.level[1].cat.node =
-				ctx_new.range.level[0].cat.node;
-		} else {
-			ebitmap_init(&ctx_new.range.level[0].cat);
-			ebitmap_init(&ctx_new.range.level[1].cat);
+			memcpy(&ctx_new.range.level[1].cat,
+			       &ctx_new.range.level[0].cat,
+			       sizeof(ctx_new.range.level[0].cat));
 		}
 		if (mls_context_isvalid(&policydb, &ctx_new) != 1)
 			goto netlbl_secattr_to_sid_return_cleanup;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
