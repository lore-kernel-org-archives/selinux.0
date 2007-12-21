Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLHP4fG003908
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 12:25:04 -0500
Received: from QMTA08.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLHP3tf021740
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 17:25:03 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v9 04/18] NetLabel: Add secid token support to the
	NetLabel secattr struct
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 21 Dec 2007 12:09:18 -0500
Message-ID: <20071221170918.12522.32956.stgit@flek.lan>
In-Reply-To: <20071221165109.12522.29726.stgit@flek.lan>
References: <20071221165109.12522.29726.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support to the NetLabel LSM secattr struct for a secid token
and a type field, paving the way for full LSM/SELinux context support and
"static" or "fallback" labels.  In addition, this patch adds a fair amount
of documentation to the core NetLabel structures used as part of the
NetLabel kernel API.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 include/net/netlabel.h            |   91 ++++++++++++++++++++++++++++++-------
 net/ipv4/cipso_ipv4.c             |   59 +++++++++++++++---------
 net/netlabel/netlabel_unlabeled.c |    1 
 security/selinux/ss/mls.c         |   10 ++--
 security/selinux/ss/services.c    |    5 ++
 5 files changed, 120 insertions(+), 46 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 2e5b2f6..18b73cf 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -105,17 +105,49 @@ struct netlbl_dom_map;
 /* Domain mapping operations */
 int netlbl_domhsh_remove(const char *domain, struct netlbl_audit *audit_info);
 
-/* LSM security attributes */
+/*
+ * LSM security attributes
+ */
+
+/**
+ * struct netlbl_lsm_cache - NetLabel LSM security attribute cache
+ * @refcount: atomic reference counter
+ * @free: LSM supplied function to free the cache data
+ * @data: LSM supplied cache data
+ *
+ * Description:
+ * This structure is provided for LSMs which wish to make use of the NetLabel
+ * caching mechanism to store LSM specific data/attributes in the NetLabel
+ * cache.  If the LSM has to perform a lot of translation from the NetLabel
+ * security attributes into it's own internal representation then the cache
+ * mechanism can provide a way to eliminate some or all of that translation
+ * overhead on a cache hit.
+ *
+ */
 struct netlbl_lsm_cache {
 	atomic_t refcount;
 	void (*free) (const void *data);
 	void *data;
 };
-/* The catmap bitmap field MUST be a power of two in length and large
+
+/**
+ * struct netlbl_lsm_secattr_catmap - NetLabel LSM secattr category bitmap
+ * @startbit: the value of the lowest order bit in the bitmap
+ * @bitmap: the category bitmap
+ * @next: pointer to the next bitmap "node" or NULL
+ *
+ * Description:
+ * This structure is used to represent category bitmaps.  Due to the large
+ * number of categories supported by most labeling protocols it is not
+ * practical to transfer a full bitmap internally so NetLabel adopts a sparse
+ * bitmap structure modeled after SELinux's ebitmap structure.
+ * The catmap bitmap field MUST be a power of two in length and large
  * enough to hold at least 240 bits.  Special care (i.e. check the code!)
  * should be used when changing these values as the LSM implementation
  * probably has functions which rely on the sizes of these types to speed
- * processing. */
+ * processing.
+ *
+ */
 #define NETLBL_CATMAP_MAPTYPE           u64
 #define NETLBL_CATMAP_MAPCNT            4
 #define NETLBL_CATMAP_MAPSIZE           (sizeof(NETLBL_CATMAP_MAPTYPE) * 8)
@@ -127,22 +159,48 @@ struct netlbl_lsm_secattr_catmap {
 	NETLBL_CATMAP_MAPTYPE bitmap[NETLBL_CATMAP_MAPCNT];
 	struct netlbl_lsm_secattr_catmap *next;
 };
+
+/**
+ * struct netlbl_lsm_secattr - NetLabel LSM security attributes
+ * @flags: indicate which attributes are contained in this structure
+ * @type: indicate the NLTYPE of the attributes
+ * @domain: the NetLabel LSM domain
+ * @cache: NetLabel LSM specific cache
+ * @attr.mls: MLS sensitivity label
+ * @attr.mls.cat: MLS category bitmap
+ * @attr.mls.lvl: MLS sensitivity level
+ * @attr.secid: LSM specific secid token
+ *
+ * Description:
+ * This structure is used to pass security attributes between NetLabel and the
+ * LSM modules.  The flags field is used to specify which fields within the
+ * struct are valid and valid values can be created by bitwise OR'ing the
+ * NETLBL_SECATTR_* defines.  The domain field is typically set by the LSM to
+ * specify domain specific configuration settings and is not usually used by
+ * NetLabel itself when returning security attributes to the LSM.
+ *
+ */
 #define NETLBL_SECATTR_NONE             0x00000000
 #define NETLBL_SECATTR_DOMAIN           0x00000001
 #define NETLBL_SECATTR_CACHE            0x00000002
 #define NETLBL_SECATTR_MLS_LVL          0x00000004
 #define NETLBL_SECATTR_MLS_CAT          0x00000008
+#define NETLBL_SECATTR_SECID            0x00000010
 #define NETLBL_SECATTR_CACHEABLE        (NETLBL_SECATTR_MLS_LVL | \
-					 NETLBL_SECATTR_MLS_CAT)
+					 NETLBL_SECATTR_MLS_CAT | \
+					 NETLBL_SECATTR_SECID)
 struct netlbl_lsm_secattr {
 	u32 flags;
-
+	u32 type;
 	char *domain;
-
-	u32 mls_lvl;
-	struct netlbl_lsm_secattr_catmap *mls_cat;
-
 	struct netlbl_lsm_cache *cache;
+	union {
+		struct {
+			struct netlbl_lsm_secattr_catmap *cat;
+			u32 lvl;
+		} mls;
+		u32 secid;
+	} attr;
 };
 
 /*
@@ -231,10 +289,7 @@ static inline void netlbl_secattr_catmap_free(
  */
 static inline void netlbl_secattr_init(struct netlbl_lsm_secattr *secattr)
 {
-	secattr->flags = 0;
-	secattr->domain = NULL;
-	secattr->mls_cat = NULL;
-	secattr->cache = NULL;
+	memset(secattr, 0, sizeof(*secattr));
 }
 
 /**
@@ -248,11 +303,11 @@ static inline void netlbl_secattr_init(struct netlbl_lsm_secattr *secattr)
  */
 static inline void netlbl_secattr_destroy(struct netlbl_lsm_secattr *secattr)
 {
-	if (secattr->cache)
-		netlbl_secattr_cache_free(secattr->cache);
 	kfree(secattr->domain);
-	if (secattr->mls_cat)
-		netlbl_secattr_catmap_free(secattr->mls_cat);
+	if (secattr->flags & NETLBL_SECATTR_CACHE)
+		netlbl_secattr_cache_free(secattr->cache);
+	if (secattr->flags & NETLBL_SECATTR_MLS_CAT)
+		netlbl_secattr_catmap_free(secattr->attr.mls.cat);
 }
 
 /**
@@ -300,7 +355,7 @@ int netlbl_secattr_catmap_setrng(struct netlbl_lsm_secattr_catmap *catmap,
 				 gfp_t flags);
 
 /*
- * LSM protocol operations
+ * LSM protocol operations (NetLabel LSM/kernel API)
  */
 int netlbl_enabled(void);
 int netlbl_sock_setattr(struct sock *sk,
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index f18e88b..2e4e043 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -348,6 +348,7 @@ static int cipso_v4_cache_check(const unsigned char *key,
 			atomic_inc(&entry->lsm_data->refcount);
 			secattr->cache = entry->lsm_data;
 			secattr->flags |= NETLBL_SECATTR_CACHE;
+			secattr->type = NETLBL_NLTYPE_CIPSOV4;
 			if (prev_entry == NULL) {
 				spin_unlock_bh(&cipso_v4_cache[bkt].lock);
 				return 0;
@@ -865,7 +866,7 @@ static int cipso_v4_map_cat_rbm_hton(const struct cipso_v4_doi *doi_def,
 	}
 
 	for (;;) {
-		host_spot = netlbl_secattr_catmap_walk(secattr->mls_cat,
+		host_spot = netlbl_secattr_catmap_walk(secattr->attr.mls.cat,
 						       host_spot + 1);
 		if (host_spot < 0)
 			break;
@@ -948,7 +949,7 @@ static int cipso_v4_map_cat_rbm_ntoh(const struct cipso_v4_doi *doi_def,
 				return -EPERM;
 			break;
 		}
-		ret_val = netlbl_secattr_catmap_setbit(secattr->mls_cat,
+		ret_val = netlbl_secattr_catmap_setbit(secattr->attr.mls.cat,
 						       host_spot,
 						       GFP_ATOMIC);
 		if (ret_val != 0)
@@ -1014,7 +1015,8 @@ static int cipso_v4_map_cat_enum_hton(const struct cipso_v4_doi *doi_def,
 	u32 cat_iter = 0;
 
 	for (;;) {
-		cat = netlbl_secattr_catmap_walk(secattr->mls_cat, cat + 1);
+		cat = netlbl_secattr_catmap_walk(secattr->attr.mls.cat,
+						 cat + 1);
 		if (cat < 0)
 			break;
 		if ((cat_iter + 2) > net_cat_len)
@@ -1049,7 +1051,7 @@ static int cipso_v4_map_cat_enum_ntoh(const struct cipso_v4_doi *doi_def,
 	u32 iter;
 
 	for (iter = 0; iter < net_cat_len; iter += 2) {
-		ret_val = netlbl_secattr_catmap_setbit(secattr->mls_cat,
+		ret_val = netlbl_secattr_catmap_setbit(secattr->attr.mls.cat,
 				ntohs(get_unaligned((__be16 *)&net_cat[iter])),
 				GFP_ATOMIC);
 		if (ret_val != 0)
@@ -1130,7 +1132,8 @@ static int cipso_v4_map_cat_rng_hton(const struct cipso_v4_doi *doi_def,
 		return -ENOSPC;
 
 	for (;;) {
-		iter = netlbl_secattr_catmap_walk(secattr->mls_cat, iter + 1);
+		iter = netlbl_secattr_catmap_walk(secattr->attr.mls.cat,
+						  iter + 1);
 		if (iter < 0)
 			break;
 		cat_size += (iter == 0 ? 0 : sizeof(u16));
@@ -1138,7 +1141,8 @@ static int cipso_v4_map_cat_rng_hton(const struct cipso_v4_doi *doi_def,
 			return -ENOSPC;
 		array[array_cnt++] = iter;
 
-		iter = netlbl_secattr_catmap_walk_rng(secattr->mls_cat, iter);
+		iter = netlbl_secattr_catmap_walk_rng(secattr->attr.mls.cat,
+						      iter);
 		if (iter < 0)
 			return -EFAULT;
 		cat_size += sizeof(u16);
@@ -1191,7 +1195,7 @@ static int cipso_v4_map_cat_rng_ntoh(const struct cipso_v4_doi *doi_def,
 		else
 			cat_low = 0;
 
-		ret_val = netlbl_secattr_catmap_setrng(secattr->mls_cat,
+		ret_val = netlbl_secattr_catmap_setrng(secattr->attr.mls.cat,
 						       cat_low,
 						       cat_high,
 						       GFP_ATOMIC);
@@ -1251,7 +1255,9 @@ static int cipso_v4_gentag_rbm(const struct cipso_v4_doi *doi_def,
 	if ((secattr->flags & NETLBL_SECATTR_MLS_LVL) == 0)
 		return -EPERM;
 
-	ret_val = cipso_v4_map_lvl_hton(doi_def, secattr->mls_lvl, &level);
+	ret_val = cipso_v4_map_lvl_hton(doi_def,
+					secattr->attr.mls.lvl,
+					&level);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -1303,12 +1309,13 @@ static int cipso_v4_parsetag_rbm(const struct cipso_v4_doi *doi_def,
 	ret_val = cipso_v4_map_lvl_ntoh(doi_def, tag[3], &level);
 	if (ret_val != 0)
 		return ret_val;
-	secattr->mls_lvl = level;
+	secattr->attr.mls.lvl = level;
 	secattr->flags |= NETLBL_SECATTR_MLS_LVL;
 
 	if (tag_len > 4) {
-		secattr->mls_cat = netlbl_secattr_catmap_alloc(GFP_ATOMIC);
-		if (secattr->mls_cat == NULL)
+		secattr->attr.mls.cat =
+		                       netlbl_secattr_catmap_alloc(GFP_ATOMIC);
+		if (secattr->attr.mls.cat == NULL)
 			return -ENOMEM;
 
 		ret_val = cipso_v4_map_cat_rbm_ntoh(doi_def,
@@ -1316,7 +1323,7 @@ static int cipso_v4_parsetag_rbm(const struct cipso_v4_doi *doi_def,
 						    tag_len - 4,
 						    secattr);
 		if (ret_val != 0) {
-			netlbl_secattr_catmap_free(secattr->mls_cat);
+			netlbl_secattr_catmap_free(secattr->attr.mls.cat);
 			return ret_val;
 		}
 
@@ -1350,7 +1357,9 @@ static int cipso_v4_gentag_enum(const struct cipso_v4_doi *doi_def,
 	if (!(secattr->flags & NETLBL_SECATTR_MLS_LVL))
 		return -EPERM;
 
-	ret_val = cipso_v4_map_lvl_hton(doi_def, secattr->mls_lvl, &level);
+	ret_val = cipso_v4_map_lvl_hton(doi_def,
+					secattr->attr.mls.lvl,
+					&level);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -1396,12 +1405,13 @@ static int cipso_v4_parsetag_enum(const struct cipso_v4_doi *doi_def,
 	ret_val = cipso_v4_map_lvl_ntoh(doi_def, tag[3], &level);
 	if (ret_val != 0)
 		return ret_val;
-	secattr->mls_lvl = level;
+	secattr->attr.mls.lvl = level;
 	secattr->flags |= NETLBL_SECATTR_MLS_LVL;
 
 	if (tag_len > 4) {
-		secattr->mls_cat = netlbl_secattr_catmap_alloc(GFP_ATOMIC);
-		if (secattr->mls_cat == NULL)
+		secattr->attr.mls.cat =
+			               netlbl_secattr_catmap_alloc(GFP_ATOMIC);
+		if (secattr->attr.mls.cat == NULL)
 			return -ENOMEM;
 
 		ret_val = cipso_v4_map_cat_enum_ntoh(doi_def,
@@ -1409,7 +1419,7 @@ static int cipso_v4_parsetag_enum(const struct cipso_v4_doi *doi_def,
 						     tag_len - 4,
 						     secattr);
 		if (ret_val != 0) {
-			netlbl_secattr_catmap_free(secattr->mls_cat);
+			netlbl_secattr_catmap_free(secattr->attr.mls.cat);
 			return ret_val;
 		}
 
@@ -1443,7 +1453,9 @@ static int cipso_v4_gentag_rng(const struct cipso_v4_doi *doi_def,
 	if (!(secattr->flags & NETLBL_SECATTR_MLS_LVL))
 		return -EPERM;
 
-	ret_val = cipso_v4_map_lvl_hton(doi_def, secattr->mls_lvl, &level);
+	ret_val = cipso_v4_map_lvl_hton(doi_def,
+					secattr->attr.mls.lvl,
+					&level);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -1488,12 +1500,13 @@ static int cipso_v4_parsetag_rng(const struct cipso_v4_doi *doi_def,
 	ret_val = cipso_v4_map_lvl_ntoh(doi_def, tag[3], &level);
 	if (ret_val != 0)
 		return ret_val;
-	secattr->mls_lvl = level;
+	secattr->attr.mls.lvl = level;
 	secattr->flags |= NETLBL_SECATTR_MLS_LVL;
 
 	if (tag_len > 4) {
-		secattr->mls_cat = netlbl_secattr_catmap_alloc(GFP_ATOMIC);
-		if (secattr->mls_cat == NULL)
+		secattr->attr.mls.cat =
+			               netlbl_secattr_catmap_alloc(GFP_ATOMIC);
+		if (secattr->attr.mls.cat == NULL)
 			return -ENOMEM;
 
 		ret_val = cipso_v4_map_cat_rng_ntoh(doi_def,
@@ -1501,7 +1514,7 @@ static int cipso_v4_parsetag_rng(const struct cipso_v4_doi *doi_def,
 						    tag_len - 4,
 						    secattr);
 		if (ret_val != 0) {
-			netlbl_secattr_catmap_free(secattr->mls_cat);
+			netlbl_secattr_catmap_free(secattr->attr.mls.cat);
 			return ret_val;
 		}
 
@@ -1850,6 +1863,8 @@ static int cipso_v4_getattr(const unsigned char *cipso,
 		ret_val = cipso_v4_parsetag_rng(doi_def, &cipso[6], secattr);
 		break;
 	}
+	if (ret_val == 0)
+		secattr->type = NETLBL_NLTYPE_CIPSOV4;
 
 getattr_return:
 	rcu_read_unlock();
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index fd53c7a..7f5df0c 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -241,6 +241,7 @@ int netlbl_unlabel_getattr(struct netlbl_lsm_secattr *secattr)
 	if (netlabel_unlabel_acceptflg == 0)
 		return -ENOMSG;
 	netlbl_secattr_init(secattr);
+	secattr->type = NETLBL_NLTYPE_UNLABELED;
 	return 0;
 }
 
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index fb5d70a..5cf2429 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -569,7 +569,7 @@ void mls_export_netlbl_lvl(struct context *context,
 	if (!selinux_mls_enabled)
 		return;
 
-	secattr->mls_lvl = context->range.level[0].sens - 1;
+	secattr->attr.mls.lvl = context->range.level[0].sens - 1;
 	secattr->flags |= NETLBL_SECATTR_MLS_LVL;
 }
 
@@ -589,7 +589,7 @@ void mls_import_netlbl_lvl(struct context *context,
 	if (!selinux_mls_enabled)
 		return;
 
-	context->range.level[0].sens = secattr->mls_lvl + 1;
+	context->range.level[0].sens = secattr->attr.mls.lvl + 1;
 	context->range.level[1].sens = context->range.level[0].sens;
 }
 
@@ -612,8 +612,8 @@ int mls_export_netlbl_cat(struct context *context,
 		return 0;
 
 	rc = ebitmap_netlbl_export(&context->range.level[0].cat,
-				   &secattr->mls_cat);
-	if (rc == 0 && secattr->mls_cat != NULL)
+				   &secattr->attr.mls.cat);
+	if (rc == 0 && secattr->attr.mls.cat != NULL)
 		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 
 	return rc;
@@ -640,7 +640,7 @@ int mls_import_netlbl_cat(struct context *context,
 		return 0;
 
 	rc = ebitmap_netlbl_import(&context->range.level[0].cat,
-				   secattr->mls_cat);
+				   secattr->attr.mls.cat);
 	if (rc != 0)
 		goto import_netlbl_cat_failure;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d572dc9..88fcd57 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2547,6 +2547,9 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		default:
 			goto netlbl_secattr_to_sid_return;
 		}
+	} else if (secattr->flags & NETLBL_SECATTR_SECID) {
+		*sid = secattr->attr.secid;
+		rc = 0;
 	} else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		ctx = sidtab_search(&sidtab, base_sid);
 		if (ctx == NULL)
@@ -2558,7 +2561,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		mls_import_netlbl_lvl(&ctx_new, secattr);
 		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
 			if (ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
-						  secattr->mls_cat) != 0)
+						  secattr->attr.mls.cat) != 0)
 				goto netlbl_secattr_to_sid_return;
 			ctx_new.range.level[1].cat.highbit =
 				ctx_new.range.level[0].cat.highbit;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
