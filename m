Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC3FC433DB
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200C364DDB
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 23:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhAaXNy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jan 2021 18:13:54 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:48759 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhAaXNq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jan 2021 18:13:46 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5760156079F
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 00:13:01 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: fix memory leak when a constraint expression is too deep
Date:   Mon,  1 Feb 2021 00:12:55 +0100
Message-Id: <20210131231255.58909-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  1 00:13:01 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When __cil_validate_constrain_expr() fails,
cil_constrain_to_policydb_helper() does not destroy the constraint
expression. This leads to a memory leak reported by OSS-Fuzz with the
following CIL policy:

    (class CLASS (PERM))
    (classorder (CLASS))
    (sid SID)
    (sidorder (SID))
    (user USER)
    (role ROLE)
    (type TYPE)
    (category CAT)
    (categoryorder (CAT))
    (sensitivity SENS)
    (sensitivityorder (SENS))
    (sensitivitycategory SENS (CAT))
    (allow TYPE self (CLASS (PERM)))
    (roletype ROLE TYPE)
    (userrole USER ROLE)
    (userlevel USER (SENS))
    (userrange USER ((SENS)(SENS (CAT))))
    (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

    (constrain
        (CLASS (PERM))
        (or
            (eq t1 TYPE)
            (or
                (eq t1 TYPE)
                (or
                    (eq t1 TYPE)
                    (or
                        (eq t1 TYPE)
                        (or
                            (eq t1 TYPE)
                            (eq t1 TYPE)
                        )
                    )
                )
            )
        )
    )

Add constraint_expr_destroy(sepol_expr) to destroy the expression.

Moreover constraint_expr_destroy() was not freeing all items of an
expression. Code in libsepol/src and checkpolicy contained while loop to
free all the items of a constraint expression, but not the one in
libsepol/cil. As freeing only the first item of an expression is
misleading, change the semantic of constraint_expr_destroy() to iterate
the list of constraint_expr_t and to free all items.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28938
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c   |  7 +------
 libsepol/cil/src/cil_binary.c |  1 +
 libsepol/src/constraint.c     |  6 +++++-
 libsepol/src/policydb.c       | 15 ++-------------
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index bf6c3e68bef3..c9286f7733c5 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3479,12 +3479,7 @@ static constraint_expr_t *constraint_expr_clone(constraint_expr_t * expr)
 
 	return h;
       oom:
-	e = h;
-	while (e) {
-		l = e;
-		e = e->next;
-		constraint_expr_destroy(l);
-	}
+	constraint_expr_destroy(h);
 	return NULL;
 }
 
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 3b01ade146c5..7ba2098b61ea 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2841,6 +2841,7 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
 	return SEPOL_OK;
 
 exit:
+	constraint_expr_destroy(sepol_expr);
 	free(sepol_constrain);
 	return rc;
 }
diff --git a/libsepol/src/constraint.c b/libsepol/src/constraint.c
index 71540195d633..58eb6da7940f 100644
--- a/libsepol/src/constraint.c
+++ b/libsepol/src/constraint.c
@@ -38,10 +38,14 @@ int constraint_expr_init(constraint_expr_t * expr)
 
 void constraint_expr_destroy(constraint_expr_t * expr)
 {
-	if (expr != NULL) {
+	constraint_expr_t *next;
+
+	while (expr != NULL) {
+		next = expr->next;
 		ebitmap_destroy(&expr->names);
 		type_set_destroy(expr->type_names);
 		free(expr->type_names);
 		free(expr);
+		expr = next;
 	}
 }
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 71ada42ca609..f45d28c764ba 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1359,7 +1359,6 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 {
 	class_datum_t *cladatum;
 	constraint_node_t *constraint, *ctemp;
-	constraint_expr_t *e, *etmp;
 
 	if (key)
 		free(key);
@@ -1371,12 +1370,7 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	hashtab_destroy(cladatum->permissions.table);
 	constraint = cladatum->constraints;
 	while (constraint) {
-		e = constraint->expr;
-		while (e) {
-			etmp = e;
-			e = e->next;
-			constraint_expr_destroy(etmp);
-		}
+		constraint_expr_destroy(constraint->expr);
 		ctemp = constraint;
 		constraint = constraint->next;
 		free(ctemp);
@@ -1384,12 +1378,7 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 
 	constraint = cladatum->validatetrans;
 	while (constraint) {
-		e = constraint->expr;
-		while (e) {
-			etmp = e;
-			e = e->next;
-			constraint_expr_destroy(etmp);
-		}
+		constraint_expr_destroy(constraint->expr);
 		ctemp = constraint;
 		constraint = constraint->next;
 		free(ctemp);
-- 
2.30.0

