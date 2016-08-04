From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH v3] module_to_cil: fix possible use of initialized value
Date: Thu,  4 Aug 2016 09:47:04 -0700
Message-Id: <1470329224-17870-1-git-send-email-william.c.roberts@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Correct errors like these reported by gcc:

module_to_cil.c: In function ‘block_to_cil’:
module_to_cil.c:229:20: error: ‘attr_list’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  struct list_node *curr = (*attr_list)->head;

Usages of attr_list_destroy() were called when list_init()
fails.

stack_init() and stack_destroy() also suffered from the
aforementioned issue.

To correct the issue, initialize stack and list variables to
NULL.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/module_to_cil.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b9a4af7..c74f357 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1303,11 +1303,11 @@ static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *
 {
 	int rc = -1;
 	struct cond_node *cond;
-	struct list *attr_list;
+	struct list *attr_list = NULL;
 
 	rc = list_init(&attr_list);
 	if (rc != 0) {
-		goto exit;
+		goto exit;;
 	}
 
 	for (cond = cond_list; cond != NULL; cond = cond->next) {
@@ -3482,7 +3482,7 @@ static int block_to_cil(struct policydb *pdb, struct avrule_block *block, struct
 {
 	int rc = -1;
 	struct avrule_decl *decl;
-	struct list *attr_list;
+	struct list *attr_list = NULL;
 
 	decl = block->branch_list;
 
@@ -3631,7 +3631,7 @@ static int blocks_to_cil(struct policydb *pdb)
 	int rc = -1;
 	struct avrule_block *block;
 	int indent = 0;
-	struct stack *stack;
+	struct stack *stack = NULL;
 
 	rc = stack_init(&stack);
 	if (rc != 0) {
@@ -3699,7 +3699,7 @@ static int linked_blocks_to_cil(struct policydb *pdb)
 	// Since it is linked, all optional blocks have been resolved
 	int rc = -1;
 	struct avrule_block *block;
-	struct stack *stack;
+	struct stack *stack = NULL;
 
 	rc = stack_init(&stack);
 	if (rc != 0) {
-- 
1.9.1
