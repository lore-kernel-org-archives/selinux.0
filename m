Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m85NNMB2030999
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 19:23:22 -0400
Received: from g4t0016.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m85NNMQ2002342
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 23:23:22 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v5 01/14] netlabel: Remove unneeded in-kernel API functions
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Fri, 05 Sep 2008 19:23:19 -0400
Message-ID: <20080905232319.31840.658.stgit@flek.lan>
In-Reply-To: <20080905231853.31840.57880.stgit@flek.lan>
References: <20080905231853.31840.57880.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After some discussions with the Smack folks, well just Casey, I now have a
better idea of what Smack wants out of NetLabel in the future so I think it
is now safe to do some API "pruning".  If another LSM comes along that
needs this functionality we can always add it back in, but I don't see any
LSMs on the horizon which might make use of these functions.

Thanks to Rami Rosen who suggested removing netlbl_cfg_cipsov4_del() back
in February 2008.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 include/net/netlabel.h       |   13 -------
 net/netlabel/netlabel_kapi.c |   84 ++++++++++++------------------------------
 2 files changed, 23 insertions(+), 74 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index e4d2d6b..5303749 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -352,12 +352,9 @@ static inline void netlbl_secattr_free(struct netlbl_lsm_secattr *secattr)
 int netlbl_cfg_map_del(const char *domain, struct netlbl_audit *audit_info);
 int netlbl_cfg_unlbl_add_map(const char *domain,
 			     struct netlbl_audit *audit_info);
-int netlbl_cfg_cipsov4_add(struct cipso_v4_doi *doi_def,
-			   struct netlbl_audit *audit_info);
 int netlbl_cfg_cipsov4_add_map(struct cipso_v4_doi *doi_def,
 			       const char *domain,
 			       struct netlbl_audit *audit_info);
-int netlbl_cfg_cipsov4_del(u32 doi, struct netlbl_audit *audit_info);
 
 /*
  * LSM security attribute operations
@@ -404,22 +401,12 @@ static inline int netlbl_cfg_unlbl_add_map(const char *domain,
 {
 	return -ENOSYS;
 }
-static inline int netlbl_cfg_cipsov4_add(struct cipso_v4_doi *doi_def,
-					 struct netlbl_audit *audit_info)
-{
-	return -ENOSYS;
-}
 static inline int netlbl_cfg_cipsov4_add_map(struct cipso_v4_doi *doi_def,
 					     const char *domain,
 					     struct netlbl_audit *audit_info)
 {
 	return -ENOSYS;
 }
-static inline int netlbl_cfg_cipsov4_del(u32 doi,
-					 struct netlbl_audit *audit_info)
-{
-	return -ENOSYS;
-}
 static inline int netlbl_secattr_catmap_walk(
 	                              struct netlbl_lsm_secattr_catmap *catmap,
 				      u32 offset)
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 39793a1..6c211fe 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -82,7 +82,7 @@ int netlbl_cfg_unlbl_add_map(const char *domain,
 
 	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (entry == NULL)
-		goto cfg_unlbl_add_map_failure;
+		return -ENOMEM;
 	if (domain != NULL) {
 		entry->domain = kstrdup(domain, GFP_ATOMIC);
 		if (entry->domain == NULL)
@@ -104,49 +104,6 @@ cfg_unlbl_add_map_failure:
 }
 
 /**
- * netlbl_cfg_cipsov4_add - Add a new CIPSOv4 DOI definition
- * @doi_def: the DOI definition
- * @audit_info: NetLabel audit information
- *
- * Description:
- * Add a new CIPSOv4 DOI definition to the NetLabel subsystem.  Returns zero on
- * success, negative values on failure.
- *
- */
-int netlbl_cfg_cipsov4_add(struct cipso_v4_doi *doi_def,
-			   struct netlbl_audit *audit_info)
-{
-	int ret_val;
-	const char *type_str;
-	struct audit_buffer *audit_buf;
-
-	ret_val = cipso_v4_doi_add(doi_def);
-
-	audit_buf = netlbl_audit_start_common(AUDIT_MAC_CIPSOV4_ADD,
-					      audit_info);
-	if (audit_buf != NULL) {
-		switch (doi_def->type) {
-		case CIPSO_V4_MAP_STD:
-			type_str = "std";
-			break;
-		case CIPSO_V4_MAP_PASS:
-			type_str = "pass";
-			break;
-		default:
-			type_str = "(unknown)";
-		}
-		audit_log_format(audit_buf,
-				 " cipso_doi=%u cipso_type=%s res=%u",
-				 doi_def->doi,
-				 type_str,
-				 ret_val == 0 ? 1 : 0);
-		audit_log_end(audit_buf);
-	}
-
-	return ret_val;
-}
-
-/**
  * netlbl_cfg_cipsov4_add_map - Add a new CIPSOv4 DOI definition and mapping
  * @doi_def: the DOI definition
  * @domain: the domain mapping to add
@@ -165,10 +122,12 @@ int netlbl_cfg_cipsov4_add_map(struct cipso_v4_doi *doi_def,
 {
 	int ret_val = -ENOMEM;
 	struct netlbl_dom_map *entry;
+	const char *type_str;
+	struct audit_buffer *audit_buf;
 
 	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (entry == NULL)
-		goto cfg_cipsov4_add_map_failure;
+		return -ENOMEM;
 	if (domain != NULL) {
 		entry->domain = kstrdup(domain, GFP_ATOMIC);
 		if (entry->domain == NULL)
@@ -182,7 +141,7 @@ int netlbl_cfg_cipsov4_add_map(struct cipso_v4_doi *doi_def,
 	 * domain mapping for it. */
 
 	rcu_read_lock();
-	ret_val = netlbl_cfg_cipsov4_add(doi_def, audit_info);
+	ret_val = cipso_v4_doi_add(doi_def);
 	if (ret_val != 0)
 		goto cfg_cipsov4_add_map_failure_unlock;
 	ret_val = netlbl_domhsh_add(entry, audit_info);
@@ -196,6 +155,24 @@ cfg_cipsov4_add_map_failure_remove_doi:
 	cipso_v4_doi_remove(doi_def->doi, audit_info, netlbl_cipsov4_doi_free);
 cfg_cipsov4_add_map_failure_unlock:
 	rcu_read_unlock();
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_CIPSOV4_ADD,
+					      audit_info);
+	if (audit_buf != NULL) {
+		switch (doi_def->type) {
+		case CIPSO_V4_MAP_STD:
+			type_str = "std";
+			break;
+		case CIPSO_V4_MAP_PASS:
+			type_str = "pass";
+			break;
+		default:
+			type_str = "(unknown)";
+		}
+		audit_log_format(audit_buf,
+				 " cipso_doi=%u cipso_type=%s res=%u",
+				 doi_def->doi, type_str, ret_val == 0 ? 1 : 0);
+		audit_log_end(audit_buf);
+	}
 cfg_cipsov4_add_map_failure:
 	if (entry != NULL)
 		kfree(entry->domain);
@@ -203,21 +180,6 @@ cfg_cipsov4_add_map_failure:
 	return ret_val;
 }
 
-/**
- * netlbl_cfg_cipsov4_del - Removean existing CIPSOv4 DOI definition
- * @doi: the CIPSO DOI value
- * @audit_info: NetLabel audit information
- *
- * Description:
- * Removes an existing CIPSOv4 DOI definition from the NetLabel subsystem.
- * Returns zero on success, negative values on failure.
- *
- */
-int netlbl_cfg_cipsov4_del(u32 doi, struct netlbl_audit *audit_info)
-{
-	return cipso_v4_doi_remove(doi, audit_info, netlbl_cipsov4_doi_free);
-}
-
 /*
  * Security Attribute Functions
  */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
