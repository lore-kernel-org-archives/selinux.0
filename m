Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77ER9QZ028540
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:27:09 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77ER6mT022359
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:27:06 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070807141534.791303353@hp.com>
References: <20070807141415.525577324@hp.com>
Date: Tue, 07 Aug 2007 10:14:17 -0400
To: selinux@tycho.nsa.gov
Cc: kaigai@ak.jp.nec.com, joe@nall.com
Subject: [RFC 2/5] NetLabel: Add secid token support to the NetLabel secattr struct
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support to the NetLabel LSM secattr struct for a secid token,
paving the way for full LSM/SELinux context support.  In this patch adds a fair
amount of documentation to the core NetLabel structures used as part of the
NetLabel kernel API.

---
 include/net/netlabel.h         |   92 +++++++++++++++++++++++++++++++++--------
 net/ipv4/cipso_ipv4.c          |   56 +++++++++++++++---------
 security/selinux/ss/mls.c      |   10 ++--
 security/selinux/ss/services.c |    5 +-
 4 files changed, 118 insertions(+), 45 deletions(-)

Index: linux-2.6_staticlbl/include/net/netlabel.h
===================================================================
--- linux-2.6_staticlbl.orig/include/net/netlabel.h
+++ linux-2.6_staticlbl/include/net/netlabel.h
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
@@ -127,22 +159,51 @@ struct netlbl_lsm_secattr_catmap {
 	NETLBL_CATMAP_MAPTYPE bitmap[NETLBL_CATMAP_MAPCNT];
 	struct netlbl_lsm_secattr_catmap *next;
 };
+
+/**
+ * struct netlbl_lsm_secattr - NetLabel LSM security attributes
+ * @flags: indicate which attributes are contained in this structure
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
 					 NETLBL_SECATTR_MLS_CAT)
 struct netlbl_lsm_secattr {
 	u32 flags;
-
+	/* there is a 4 byte hole here in 64 bit architectures which we could
+	 * solve by moving the 'flags' field elsewhere in this structure but
+	 * to do so would move push it out of the first cacheline, which is not
+	 * desireable from a performance standpoint as in the case of an
+	 * unlabeled packet (most common) the 'flags' field is the only field
+	 * the LSM is likely to check */
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
@@ -231,10 +292,7 @@ static inline void netlbl_secattr_catmap
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
@@ -248,11 +306,11 @@ static inline void netlbl_secattr_init(s
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
@@ -300,7 +358,7 @@ int netlbl_secattr_catmap_setrng(struct 
 				 gfp_t flags);
 
 /*
- * LSM protocol operations
+ * LSM protocol operations (NetLabel LSM/kernel API)
  */
 int netlbl_enabled(void);
 int netlbl_sock_setattr(struct sock *sk,
Index: linux-2.6_staticlbl/net/ipv4/cipso_ipv4.c
===================================================================
--- linux-2.6_staticlbl.orig/net/ipv4/cipso_ipv4.c
+++ linux-2.6_staticlbl/net/ipv4/cipso_ipv4.c
@@ -884,7 +884,7 @@ static int cipso_v4_map_cat_rbm_hton(con
 	}
 
 	for (;;) {
-		host_spot = netlbl_secattr_catmap_walk(secattr->mls_cat,
+		host_spot = netlbl_secattr_catmap_walk(secattr->attr.mls.cat,
 						       host_spot + 1);
 		if (host_spot < 0)
 			break;
@@ -967,7 +967,7 @@ static int cipso_v4_map_cat_rbm_ntoh(con
 				return -EPERM;
 			break;
 		}
-		ret_val = netlbl_secattr_catmap_setbit(secattr->mls_cat,
+		ret_val = netlbl_secattr_catmap_setbit(secattr->attr.mls.cat,
 						       host_spot,
 						       GFP_ATOMIC);
 		if (ret_val != 0)
@@ -1033,7 +1033,8 @@ static int cipso_v4_map_cat_enum_hton(co
 	u32 cat_iter = 0;
 
 	for (;;) {
-		cat = netlbl_secattr_catmap_walk(secattr->mls_cat, cat + 1);
+		cat = netlbl_secattr_catmap_walk(secattr->attr.mls.cat,
+						 cat + 1);
 		if (cat < 0)
 			break;
 		if ((cat_iter + 2) > net_cat_len)
@@ -1068,7 +1069,7 @@ static int cipso_v4_map_cat_enum_ntoh(co
 	u32 iter;
 
 	for (iter = 0; iter < net_cat_len; iter += 2) {
-		ret_val = netlbl_secattr_catmap_setbit(secattr->mls_cat,
+		ret_val = netlbl_secattr_catmap_setbit(secattr->attr.mls.cat,
 				ntohs(get_unaligned((__be16 *)&net_cat[iter])),
 				GFP_ATOMIC);
 		if (ret_val != 0)
@@ -1149,7 +1150,8 @@ static int cipso_v4_map_cat_rng_hton(con
 		return -ENOSPC;
 
 	for (;;) {
-		iter = netlbl_secattr_catmap_walk(secattr->mls_cat, iter + 1);
+		iter = netlbl_secattr_catmap_walk(secattr->attr.mls.cat,
+						  iter + 1);
 		if (iter < 0)
 			break;
 		cat_size += (iter == 0 ? 0 : sizeof(u16));
@@ -1157,7 +1159,8 @@ static int cipso_v4_map_cat_rng_hton(con
 			return -ENOSPC;
 		array[array_cnt++] = iter;
 
-		iter = netlbl_secattr_catmap_walk_rng(secattr->mls_cat, iter);
+		iter = netlbl_secattr_catmap_walk_rng(secattr->attr.mls.cat,
+						      iter);
 		if (iter < 0)
 			return -EFAULT;
 		cat_size += sizeof(u16);
@@ -1210,7 +1213,7 @@ static int cipso_v4_map_cat_rng_ntoh(con
 		else
 			cat_low = 0;
 
-		ret_val = netlbl_secattr_catmap_setrng(secattr->mls_cat,
+		ret_val = netlbl_secattr_catmap_setrng(secattr->attr.mls.cat,
 						       cat_low,
 						       cat_high,
 						       GFP_ATOMIC);
@@ -1270,7 +1273,9 @@ static int cipso_v4_gentag_rbm(const str
 	if ((secattr->flags & NETLBL_SECATTR_MLS_LVL) == 0)
 		return -EPERM;
 
-	ret_val = cipso_v4_map_lvl_hton(doi_def, secattr->mls_lvl, &level);
+	ret_val = cipso_v4_map_lvl_hton(doi_def,
+					secattr->attr.mls.lvl,
+					&level);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -1322,12 +1327,13 @@ static int cipso_v4_parsetag_rbm(const s
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
@@ -1335,7 +1341,7 @@ static int cipso_v4_parsetag_rbm(const s
 						    tag_len - 4,
 						    secattr);
 		if (ret_val != 0) {
-			netlbl_secattr_catmap_free(secattr->mls_cat);
+			netlbl_secattr_catmap_free(secattr->attr.mls.cat);
 			return ret_val;
 		}
 
@@ -1369,7 +1375,9 @@ static int cipso_v4_gentag_enum(const st
 	if (!(secattr->flags & NETLBL_SECATTR_MLS_LVL))
 		return -EPERM;
 
-	ret_val = cipso_v4_map_lvl_hton(doi_def, secattr->mls_lvl, &level);
+	ret_val = cipso_v4_map_lvl_hton(doi_def,
+					secattr->attr.mls.lvl,
+					&level);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -1415,12 +1423,13 @@ static int cipso_v4_parsetag_enum(const 
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
@@ -1428,7 +1437,7 @@ static int cipso_v4_parsetag_enum(const 
 						     tag_len - 4,
 						     secattr);
 		if (ret_val != 0) {
-			netlbl_secattr_catmap_free(secattr->mls_cat);
+			netlbl_secattr_catmap_free(secattr->attr.mls.cat);
 			return ret_val;
 		}
 
@@ -1462,7 +1471,9 @@ static int cipso_v4_gentag_rng(const str
 	if (!(secattr->flags & NETLBL_SECATTR_MLS_LVL))
 		return -EPERM;
 
-	ret_val = cipso_v4_map_lvl_hton(doi_def, secattr->mls_lvl, &level);
+	ret_val = cipso_v4_map_lvl_hton(doi_def,
+					secattr->attr.mls.lvl,
+					&level);
 	if (ret_val != 0)
 		return ret_val;
 
@@ -1507,12 +1518,13 @@ static int cipso_v4_parsetag_rng(const s
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
@@ -1520,7 +1532,7 @@ static int cipso_v4_parsetag_rng(const s
 						    tag_len - 4,
 						    secattr);
 		if (ret_val != 0) {
-			netlbl_secattr_catmap_free(secattr->mls_cat);
+			netlbl_secattr_catmap_free(secattr->attr.mls.cat);
 			return ret_val;
 		}
 
Index: linux-2.6_staticlbl/security/selinux/ss/mls.c
===================================================================
--- linux-2.6_staticlbl.orig/security/selinux/ss/mls.c
+++ linux-2.6_staticlbl/security/selinux/ss/mls.c
@@ -569,7 +569,7 @@ void mls_export_netlbl_lvl(struct contex
 	if (!selinux_mls_enabled)
 		return;
 
-	secattr->mls_lvl = context->range.level[0].sens - 1;
+	secattr->attr.mls.lvl = context->range.level[0].sens - 1;
 	secattr->flags |= NETLBL_SECATTR_MLS_LVL;
 }
 
@@ -589,7 +589,7 @@ void mls_import_netlbl_lvl(struct contex
 	if (!selinux_mls_enabled)
 		return;
 
-	context->range.level[0].sens = secattr->mls_lvl + 1;
+	context->range.level[0].sens = secattr->attr.mls.lvl + 1;
 	context->range.level[1].sens = context->range.level[0].sens;
 }
 
@@ -612,8 +612,8 @@ int mls_export_netlbl_cat(struct context
 		return 0;
 
 	rc = ebitmap_netlbl_export(&context->range.level[0].cat,
-				   &secattr->mls_cat);
-	if (rc == 0 && secattr->mls_cat != NULL)
+				   &secattr->attr.mls.cat);
+	if (rc == 0 && secattr->attr.mls.cat != NULL)
 		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 
 	return rc;
@@ -640,7 +640,7 @@ int mls_import_netlbl_cat(struct context
 		return 0;
 
 	rc = ebitmap_netlbl_import(&context->range.level[0].cat,
-				   secattr->mls_cat);
+				   secattr->attr.mls.cat);
 	if (rc != 0)
 		goto import_netlbl_cat_failure;
 
Index: linux-2.6_staticlbl/security/selinux/ss/services.c
===================================================================
--- linux-2.6_staticlbl.orig/security/selinux/ss/services.c
+++ linux-2.6_staticlbl/security/selinux/ss/services.c
@@ -2498,6 +2498,9 @@ int security_netlbl_secattr_to_sid(struc
 		default:
 			goto netlbl_secattr_to_sid_return;
 		}
+	} else if (secattr->flags & NETLBL_SECATTR_SECID) {
+		*sid = secattr->attr.secid;
+		rc = 0;
 	} else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		ctx = sidtab_search(&sidtab, base_sid);
 		if (ctx == NULL)
@@ -2509,7 +2512,7 @@ int security_netlbl_secattr_to_sid(struc
 		mls_import_netlbl_lvl(&ctx_new, secattr);
 		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
 			if (ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
-						  secattr->mls_cat) != 0)
+						  secattr->attr.mls.cat) != 0)
 				goto netlbl_secattr_to_sid_return;
 			ctx_new.range.level[1].cat.highbit =
 				ctx_new.range.level[0].cat.highbit;

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
