Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GCvamc028598
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 08:57:36 -0400
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GCulqH018258
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 12:56:47 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 14/16] netlabel: Changes to the NetLabel security
	attributes to allow LSMs to pass full contexts
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Date: Tue, 16 Sep 2008 08:57:23 -0400
Message-ID: <20080916125723.17132.59895.stgit@flek.lan>
In-Reply-To: <20080916124722.17132.38741.stgit@flek.lan>
References: <20080916124722.17132.38741.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch provides support for including the LSM's secid in addition to
the LSM's MLS information in the NetLabel security attributes structure.

Signed-off-by: Paul Moore <paul.moore@hp.com>
Acked-by: James Morris <jmorris@namei.org>
---

 include/net/netlabel.h         |    2 +-
 security/selinux/ss/services.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 074cad4..d56517a 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -203,7 +203,7 @@ struct netlbl_lsm_secattr {
 	u32 type;
 	char *domain;
 	struct netlbl_lsm_cache *cache;
-	union {
+	struct {
 		struct {
 			struct netlbl_lsm_secattr_catmap *cat;
 			u32 lvl;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8d17dfb..ed0b00b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2806,7 +2806,8 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 		rc = -ENOMEM;
 		goto netlbl_sid_to_secattr_failure;
 	}
-	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY;
+	secattr->attr.secid = sid;
+	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
 	mls_export_netlbl_lvl(ctx, secattr);
 	rc = mls_export_netlbl_cat(ctx, secattr);
 	if (rc != 0)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
