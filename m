From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH 1/5] libsepol: fix invalid access of NULL on type_val_to_struct
Date: Wed, 10 Aug 2016 14:51:18 -0700
Message-Id: <1470865882-22435-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

In type_set_expand:
When nprim, the table index counter, is greater than the value of initizalized
entries in the type_val_to_struct[] array, detect this as invalid
and return an error.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/expand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 0ad57f5..e6d3ef1 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2514,6 +2514,10 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 				if (i > p->p_types.nprim - 1)
 					goto err_types;
 
+				if (!p->type_val_to_struct[i]) {
+					goto err_types;
+				}
+
 				if (p->type_val_to_struct[i]->flavor ==
 				    TYPE_ATTRIB) {
 					if (ebitmap_union
-- 
1.9.1
