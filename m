Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GCuNvt027858
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 08:56:23 -0400
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GCtYqH017309
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 12:55:34 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 05/16] selinux: Fix a problem in
	security_netlbl_sid_to_secattr()
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Date: Tue, 16 Sep 2008 08:56:20 -0400
Message-ID: <20080916125620.17132.60664.stgit@flek.lan>
In-Reply-To: <20080916124722.17132.38741.stgit@flek.lan>
References: <20080916124722.17132.38741.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently when SELinux fails to allocate memory in
security_netlbl_sid_to_secattr() the NetLabel LSM domain field is set to
NULL which triggers the default NetLabel LSM domain mapping which may not
always be the desired mapping.  This patch fixes this by returning an error
when the kernel is unable to allocate memory.  This could result in more
failures on a system with heavy memory pressure but it is the "correct"
thing to do.

Signed-off-by: Paul Moore <paul.moore@hp.com>
Acked-by: James Morris <jmorris@namei.org>
---

 security/selinux/ss/services.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d11a815..8d17dfb 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2788,7 +2788,7 @@ netlbl_secattr_to_sid_return_cleanup:
  */
 int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 {
-	int rc = -ENOENT;
+	int rc;
 	struct context *ctx;
 
 	if (!ss_initialized)
@@ -2796,10 +2796,16 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 
 	read_lock(&policy_rwlock);
 	ctx = sidtab_search(&sidtab, sid);
-	if (ctx == NULL)
+	if (ctx == NULL) {
+		rc = -ENOENT;
 		goto netlbl_sid_to_secattr_failure;
+	}
 	secattr->domain = kstrdup(policydb.p_type_val_to_name[ctx->type - 1],
 				  GFP_ATOMIC);
+	if (secattr->domain == NULL) {
+		rc = -ENOMEM;
+		goto netlbl_sid_to_secattr_failure;
+	}
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY;
 	mls_export_netlbl_lvl(ctx, secattr);
 	rc = mls_export_netlbl_cat(ctx, secattr);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
