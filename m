Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3AJCwq1022698
 for <selinux@tycho.nsa.gov>; Mon, 10 Apr 2017 15:12:58 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E027E564699
 for <selinux@tycho.nsa.gov>; Mon, 10 Apr 2017 21:12:49 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol: correct spelling errors in module_to_cil.c
 comments
Date: Mon, 10 Apr 2017 21:11:49 +0200
Message-Id: <20170410191149.17419-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170410191149.17419-1-nicolas.iooss@m4x.org>
References: <20170410191149.17419-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 45acdeb1a4e0..ac095c30f4f3 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -791,8 +791,8 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, vo
 	// CIL doesn't support anonymous positive/negative/complemented sets.  So
 	// instead we create a CIL type/roleattributeset that matches the set. If
 	// the set has a negative set, then convert it to is (P & !N), where P is
-	// the list of members in the positive set , and N is the list of members
-	// in the negative set. Additonally, if the set is complemented, then wrap
+	// the list of members in the positive set and N is the list of members
+	// in the negative set. Additionally, if the set is complemented, then wrap
 	// the whole thing with a negation.
 
 	struct ebitmap_node *node;
@@ -2103,13 +2103,13 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			// the policy type, it would result in duplicate declarations,
 			// which isn't allowed in CIL. Patches have been made to refpolicy
 			// to remove these duplicate role declarations, but we need to be
-			// backwards compatable and support older policies. Since we know
+			// backwards compatible and support older policies. Since we know
 			// these roles are always declared in base, only print them when we
 			// see them in the base module. If the declarations appear in a
 			// non-base module, ignore their declarations.
 			//
 			// Note that this is a hack, and if a policy author does not define
-			// one of these roles in base, the declaration will not appeaer in
+			// one of these roles in base, the declaration will not appear in
 			// the resulting policy, likely resulting in a compilation error in
 			// CIL.
 			//
@@ -2289,7 +2289,7 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 
 	if (block->flags & AVRULE_OPTIONAL) {
 		// sensitivites in user statements in optionals do not have the
-		// standard -1 offest
+		// standard -1 offset
 		sens_offset = 0;
 	}
 
-- 
2.12.0
