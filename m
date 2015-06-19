Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5JIJ8qa006185
 for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2015 14:19:08 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/10 v3] libsepol: Treat types like an attribute in the
 attr_type_map.
Date: Fri, 19 Jun 2015 14:19:08 -0400
Message-Id: <1434737956-17932-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434737956-17932-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1434737956-17932-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Types are treated as attributes that contain only themselves. This
is how types are already treated in the type_attr_map.

Treating types this way makes finding rules that apply to a given
type much easier. This simplifies the implementation of neverallow
checking in assertion.c and bounds checking in hierarchy.c.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/expand.c   | 24 ++++++++++++++++--------
 libsepol/src/policydb.c |  4 ++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 478eaff..7b99f40 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2311,25 +2311,33 @@ static int type_attr_map(hashtab_key_t key
 	policydb_t *p = state->out;
 	unsigned int i;
 	ebitmap_node_t *tnode;
+	int value;
 
 	type = (type_datum_t *) datum;
+	value = type->s.value;
+
 	if (type->flavor == TYPE_ATTRIB) {
-		if (ebitmap_cpy(&p->attr_type_map[type->s.value - 1],
-				&type->types)) {
-			ERR(state->handle, "Out of memory!");
-			return -1;
+		if (ebitmap_cpy(&p->attr_type_map[value - 1], &type->types)) {
+			goto oom;
 		}
 		ebitmap_for_each_bit(&type->types, tnode, i) {
 			if (!ebitmap_node_get_bit(tnode, i))
 				continue;
-			if (ebitmap_set_bit(&p->type_attr_map[i],
-					    type->s.value - 1, 1)) {
-				ERR(state->handle, "Out of memory!");
-				return -1;
+			if (ebitmap_set_bit(&p->type_attr_map[i], value - 1, 1)) {
+				goto oom;
 			}
 		}
+	} else {
+		if (ebitmap_set_bit(&p->attr_type_map[value - 1], value - 1, 1)) {
+			goto oom;
+		}
 	}
+
 	return 0;
+
+oom:
+	ERR(state->handle, "Out of memory!");
+	return -1;
 }
 
 /* converts typeset using typemap and expands into ebitmap_t types using the attributes in the passed in policy.
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 1677eb5..670aef8 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3936,6 +3936,10 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			/* add the type itself as the degenerate case */
 			if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
 				goto bad;
+			if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
+				if (ebitmap_set_bit(&p->attr_type_map[i], i, 1))
+					goto bad;
+			}
 		}
 	}
 
-- 
1.9.3
