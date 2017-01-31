Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJicMn020117
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:44:38 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] checkpolicy: Remove uneeded return check in
 require_symbol()
Date: Tue, 31 Jan 2017 14:44:54 -0500
Message-Id: <1485891894-18949-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1485891894-18949-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891894-18949-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since symtab_insert() no longer returns -2 in the case of a
declaration of an identifier followed by a require of the same
symbol, remove the uneeded check.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/module_compiler.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 95e29be..a5be276 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -719,23 +719,15 @@ int require_symbol(uint32_t symbol_type,
 	avrule_decl_t *decl = stack_top->decl;
 	int ret = create_symbol(symbol_type, key, datum, dest_value, SCOPE_REQ);
 
-	if (ret == 0 || ret == 1) {
-		if (ebitmap_set_bit(decl->required.scope + symbol_type,
-				    *datum_value - 1, 1)) {
-			return -3;
-		}
-	} else if (ret == -2) {
-		/* ignore require statements if that symbol was
-		 * previously declared and is in current scope */
-		if (is_id_in_scope(symbol_type, key)) {
-			ret = 1;
-		} else {
-			return -2;
-		}
-	} else if (ret < 0) {
+	if (ret < 0) {
 		return ret;
 	}
 
+	if (ebitmap_set_bit(decl->required.scope + symbol_type,
+			    *datum_value - 1, 1)) {
+		return -3;
+	}
+
 	stack_top->require_given = 1;
 	return ret;
 }
-- 
2.7.4
