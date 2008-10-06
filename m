Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m96JLd5M030677
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2008 15:21:39 -0400
Received: from g1t0028.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m96JLcHA022314
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2008 19:21:38 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH v7 15/17] netlabel: Changes to the NetLabel security
	attributes to allow LSMs to pass full contexts
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Mon, 06 Oct 2008 15:21:30 -0400
Message-ID: <20081006192130.15686.45936.stgit@flek.lan>
In-Reply-To: <20081006191516.15686.80823.stgit@flek.lan>
References: <20081006191516.15686.80823.stgit@flek.lan>
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
index c8f688a..ed0ca64 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2803,7 +2803,8 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
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
