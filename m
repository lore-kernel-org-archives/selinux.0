Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5JIJ8qZ006185
 for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2015 14:19:08 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 01/10 v3] libsepol: Add new ebitmap function named
 ebitmap_match_any()
Date: Fri, 19 Jun 2015 14:19:07 -0400
Message-Id: <1434737956-17932-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434737956-17932-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1434737956-17932-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This function returns true if there is a common bit that is set
in both bitmaps.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/ebitmap.c                    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 801438c..7b3508d 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -86,6 +86,7 @@ extern unsigned int ebitmap_cardinality(ebitmap_t *e1);
 extern int ebitmap_hamming_distance(ebitmap_t * e1, ebitmap_t * e2);
 extern int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src);
 extern int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2);
+extern int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit);
 extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
 extern void ebitmap_destroy(ebitmap_t * e);
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index be6b591..58f2fc4 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -224,6 +224,28 @@ int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2)
 	return 1;
 }
 
+int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2)
+{
+	ebitmap_node_t *n1 = e1->node;
+	ebitmap_node_t *n2 = e2->node;
+
+	while (n1 && n2) {
+		if (n1->startbit < n2->startbit) {
+			n1 = n1->next;
+		} else if (n2->startbit < n1->startbit) {
+			n2 = n2->next;
+		} else {
+			if (n1->map & n2->map) {
+				return 1;
+			}
+			n1 = n1->next;
+			n2 = n2->next;
+		}
+	}
+
+	return 0;
+}
+
 int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit)
 {
 	ebitmap_node_t *n;
-- 
1.9.3
