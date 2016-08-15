From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH v3 6/7] libsepol: bound attr_type_map access by nprim
Date: Mon, 15 Aug 2016 08:59:13 -0700
Message-Id: <1471276754-25266-7-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471276754-25266-1-git-send-email-william.c.roberts@intel.com>
References: <1471276754-25266-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Correct an invalid memory access when attr_type_map array
indexing is outside of bounds.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/policydb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 604e022..9f1c507 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3972,6 +3972,10 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 					if (!ebitmap_node_get_bit(tnode, j)
 					    || i == j)
 						continue;
+
+					if (j >= p->p_types.nprim)
+						goto bad;
+
 					if (ebitmap_set_bit
 					    (&p->attr_type_map[j], i, 1))
 						goto bad;
-- 
1.9.1
