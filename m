Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJicMm020117
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:44:38 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol: Return +1 when declaration is followed by a
 require
Date: Tue, 31 Jan 2017 14:44:53 -0500
Message-Id: <1485891894-18949-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1485891894-18949-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891894-18949-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A check is made in symtab_insert() for the case when an identifier
had already been declared and was now being required. This meant
that a declaration followed by a require was treated differently
from a require followed by a declaration.

Remove that check and treat both cases the same (which means
returning +1).

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/policydb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 5b9b9f0..3cff6d2 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1666,9 +1666,6 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
 		}
 	} else if (scope_datum->scope == SCOPE_REQ && scope == SCOPE_DECL) {
 		scope_datum->scope = SCOPE_DECL;
-	} else if (scope_datum->scope != scope) {
-		/* This only happens in DECL then REQUIRE case, which is handled by caller */
-		return -2;
 	}
 
 	/* search through the pre-existing list to avoid adding duplicates */
-- 
2.7.4
