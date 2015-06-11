Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5BIQkGI029974
 for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2015 14:26:46 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/10] libsepol: Treat types like an attribute in the
 attr_type_map.
Date: Thu, 11 Jun 2015 14:26:39 -0400
Message-Id: <1434047207-25503-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Types are treated as attributes that contain only themselves. This
is how types are already treated in the type_attr_map.

Treating types this way makes finding rules that apply to a given
type much easier.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/expand.c   | 26 +++++++++++++++++---------
 libsepol/src/policydb.c |  4 ++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index b999890..cbd39df 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2317,25 +2317,33 @@ static int type_attr_map(hashtab_key_t key
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
-		}
 		ebitmap_for_each_bit(&type->types, tnode, i) {
 			if (!ebitmap_node_get_bit(tnode, i))
 				continue;
-			if (ebitmap_set_bit(&p->type_attr_map[i],
-					    type->s.value - 1, 1)) {
-				ERR(state->handle, "Out of memory!");
-				return -1;
+			if (ebitmap_set_bit(&p->type_attr_map[i], value - 1, 1)) {
+				goto out;
 			}
+			if (ebitmap_set_bit(&p->attr_type_map[value - 1], i, 1)) {
+				goto out;
+			}
+		}
+	} else {
+		if (ebitmap_set_bit(&p->attr_type_map[value - 1], value - 1, 1)) {
+			goto out;
 		}
 	}
+
 	return 0;
+
+out:
+	ERR(state->handle, "Out of memory!");
+	return -1;
 }
 
 /* converts typeset using typemap and expands into ebitmap_t types using the attributes in the passed in policy.
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 8c3c7ac..be0c701 100644
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
