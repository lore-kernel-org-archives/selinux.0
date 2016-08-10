From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH 2/5] libsepol: ensure key is valid before doing search
Date: Wed, 10 Aug 2016 14:51:19 -0700
Message-Id: <1470865882-22435-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1470865882-22435-1-git-send-email-william.c.roberts@intel.com>
References: <1470865882-22435-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/mls.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 1e84bb7..2dc5f2b 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -262,6 +262,7 @@ int mls_context_isvalid(const policydb_t * p, const context_struct_t * c)
 	user_datum_t *usrdatum;
 	unsigned int i, l;
 	ebitmap_node_t *cnode;
+	hashtab_key_t key;
 
 	if (!p->mls)
 		return 1;
@@ -279,11 +280,12 @@ int mls_context_isvalid(const policydb_t * p, const context_struct_t * c)
 		if (!c->range.level[l].sens
 		    || c->range.level[l].sens > p->p_levels.nprim)
 			return 0;
-		levdatum = (level_datum_t *) hashtab_search(p->p_levels.table,
-							    p->
-							    p_sens_val_to_name
-							    [c->range.level[l].
-							     sens - 1]);
+
+		key = p->p_sens_val_to_name[c->range.level[l].sens - 1];
+		if (!key)
+			return 0;
+
+		levdatum = (level_datum_t *) hashtab_search(p->p_levels.table, key);
 		if (!levdatum)
 			return 0;
 
-- 
1.9.1
