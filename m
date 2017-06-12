Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5CHXLeO000769
 for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2017 13:33:21 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] libsepol: Fix neverallow bug when checking conditional
 policy
Date: Mon, 12 Jun 2017 13:34:20 -0400
Message-Id: <20170612173420.3468-1-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 9e6840e refactored neverallow checking. In the process a bug
was introduced that causes enabled conditional rules to be skipped.
The bug is that the avtab key is checked by comparing the specified
field of the key to the value AVTAB_ALLOWED. Since enabled conditional
rules have an additional bit set as well, these rules are not
considered to match.

The fix is to use a bitwise AND (&) to only check the desired bit.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
v2: Pay attention to precedence rules

 libsepol/src/assertion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 27c39e7..b08757b 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -222,7 +222,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 
-	if (k->specified != AVTAB_ALLOWED)
+	if ((k->specified & AVTAB_ALLOWED) == 0)
 		return 0;
 
 	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
@@ -471,7 +471,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	avrule_t *avrule = a->avrule;
 	avtab_t *avtab = a->avtab;
 
-	if (k->specified != AVTAB_ALLOWED)
+	if ((k->specified & AVTAB_ALLOWED) == 0)
 		goto exit;
 
 	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
-- 
2.9.4
