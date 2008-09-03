Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m830oMtw015275
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2008 20:50:22 -0400
Received: from g4t0015.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m830oLXu015982
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 00:50:21 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v4 12/14] netlabel: Changes to the NetLabel security
	attributes to allow LSMs to pass full contexts
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Tue, 02 Sep 2008 20:50:13 -0400
Message-ID: <20080903005013.15669.42041.stgit@flek.lan>
In-Reply-To: <20080903003647.15669.45349.stgit@flek.lan>
References: <20080903003647.15669.45349.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch provides support for including the LSM's secid in addition to
the LSM's MLS information in the NetLabel security attributes structure.

Signed-off-by: Paul Moore <paul.moore@hp.com>
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
index 5b7ecc1..ee91337 100644
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
