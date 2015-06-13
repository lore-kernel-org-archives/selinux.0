Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5DEnbPc012153
 for <selinux@tycho.nsa.gov>; Sat, 13 Jun 2015 10:49:37 -0400
Received: by igblz2 with SMTP id lz2so26540539igb.1
 for <selinux@tycho.nsa.gov>; Sat, 13 Jun 2015 07:49:33 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policy_define.c: fix compiler warnings
Date: Sat, 13 Jun 2015 07:49:18 -0700
Message-Id: <1434206958-9234-1-git-send-email-nnk@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes compiler warnings all similar to the following:

host C: checkpolicy <= external/selinux/checkpolicy/policy_define.c
external/selinux/checkpolicy/policy_define.c:1572:2: warning: comparison of integers of different signs: 'int' and 'uint32_t' (aka 'unsigned int') [-Wsign-compare]
        ebitmap_for_each_bit(&tclasses, node, i) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
external/selinux/checkpolicy/../libsepol/include/sepol/policydb/ebitmap.h:76:39: note: expanded from macro 'ebitmap_for_each_bit'
        for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
                                             ^ ~~~~~~~~~~~~~~~~~

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 checkpolicy/policy_define.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 093bded..27d8fe7 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1521,7 +1521,8 @@ int define_compute_type_helper(int which, avrule_t ** rule)
 	ebitmap_node_t *node;
 	avrule_t *avrule;
 	class_perm_node_t *perm;
-	int i, add = 1;
+	uint32_t i;
+	int add = 1;
 
 	avrule = malloc(sizeof(avrule_t));
 	if (!avrule) {
@@ -2745,7 +2746,7 @@ static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unused)),
 	role_datum_t *rdp = (role_datum_t *) arg;
 	role_datum_t *rdatum = (role_datum_t *) datum;
 	ebitmap_node_t *node;
-	int i;
+	uint32_t i;
 
 	/* Don't bother to process against self role */
 	if (rdatum->s.value == rdp->s.value)
-- 
2.2.0.rc0.207.ga3a616c
