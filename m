Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AED0C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 20:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6004B215A4
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 20:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="D0Ytp8av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgAaUXm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:23:42 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:56633 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUXm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 15:23:42 -0500
X-EEMSG-check-017: 52882921|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,387,1574121600"; 
   d="scan'208";a="52882921"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Jan 2020 20:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580502219; x=1612038219;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fxWrOekgztAMhFq9y7ahgSal1sC6nwQiYw10+7+4ezs=;
  b=D0Ytp8avj22M1gBX3myETqmVwv1rvSTUBBBO9is1B7CqpbMlJAQ7aobo
   uQD2JJg50x+UNXH6z3VFymhL13X0b1+nAHj6IN1wBLEGEyQN2a98n9n3z
   BAnr6eJusJFiKXZgYDxv5OPSXShkxXgecTfHpw7FTd8w2Wj9cWPJzNhFe
   ekiQ4XaXX/rnNumX7Ti3ZD9vLIOgheH9x0AZ+WimzaoSNOsCg+Meg0xYL
   ndk2CHOg3fxmfFpw84bF5nOHrJl4xwyQdq6LxEvGH7uywAW1QOWOfuCI3
   5bT57l1ukQpPZ095NLqclBccuJurWcP73g5u6erL+lh56REzndcQKPaf4
   A==;
X-IronPort-AV: E=Sophos;i="5.70,387,1574121600"; 
   d="scan'208";a="32567755"
IronPort-PHdr: =?us-ascii?q?9a23=3Apv3TIBDC//lmU3I25cfqUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT6pcbcNUDSrc9gkEXOFd2Cra4d16yK6+u5AzNIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw+xx?=
 =?us-ascii?q?fVrXdEZvpayGF1Ll6Xgxrw+9288ZF+/yleof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9Fnn/407Mn3e?=
 =?us-ascii?q?ovEg/I2wMvEd0VvXjIr9j4LrseXPqpwKXUyzjIcvNY2S366IjNah0vpeuDXb?=
 =?us-ascii?q?dufsrK1EIiCRnKjk+MqYP7JTOey+MAs2qV7uV8T+2vkXInpx9qrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIUEylarVLJ4h2aA/mY?=
 =?us-ascii?q?YJvUTfHi75hEX2jKiMekUi5ueo8Pjobq/jpp+dM494kgD+MqIwlcyjGek0Lw?=
 =?us-ascii?q?cDUmeB9em8ybHv51P1TbpUgvEsj6XVqJXaKt4apq69DQ9VyIEj6xOnAjek3t?=
 =?us-ascii?q?UXgWMILEhZeB6ZlIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhE551KDrEBIfTzWlL+tdHDEB85PBK7w/z9BNV+yIweQ2SPDb?=
 =?us-ascii?q?GdMK/Itl+I/O0vcKGwY9oOtTL8LeU1z+DhgGV/mlIHe6Stm5wNZyOWBPNjdm?=
 =?us-ascii?q?eQZHf3yvwIC3sHpEJqTvPhgUeeCxZPdn2yWOQ6/Th9B4W4W9SQDruxiaCMiX?=
 =?us-ascii?q?/oVqZdYXpLXxXXQHo=3D?=
X-IPAS-Result: =?us-ascii?q?A2A0BQCWizRe/wHyM5BlHgELHIN4gW0gEiqNF4ZVAQEBA?=
 =?us-ascii?q?QEBBosmiiWHJAkBAQEBAQEBAQEbHAEBhxc4EwIQAQEBBAEBAQEBBQMBAWyFQ?=
 =?us-ascii?q?4I7KYMwCwGCF4JnP4JXJa8iM4VKg0WBPoE4h0KFcYEHgRE2gi9shCOGFASBP?=
 =?us-ascii?q?wGMHYh5gSeXYwaCP5YzDBubBAGLM6BWIoFYKwgCGCmBaIFOUBgNjikXFY4sI?=
 =?us-ascii?q?wMwjAeCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 31 Jan 2020 20:23:38 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00VKMpK4195726
        for <selinux@vger.kernel.org>; Fri, 31 Jan 2020 15:22:53 -0500
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: Rewrite verification of map classes and classpermissionsets
Date:   Fri, 31 Jan 2020 15:24:50 -0500
Message-Id: <20200131202450.25665-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The classperms associated with each map class permission and with each
classpermissionset are verified in __cil_verify_classperms() which had
multiple problems with how it did the verification.

1) Verification was short-circuited when the first normal class is found.
  The second classpermissionset statement below would not have been
  verified.
    (classpermission cp1)
    (classpermissionset cp1 (CLASS (PERM)))
    (classpermissionset cp1 cp2)

2) The classperms of a map class permission and classpermissionset were
not checked for being NULL before the function recursively called itself.
This would result in a segfault if the missing map or set was referred to
before the classmap or classpermission occured. This error was reported by
Dominick Grift (dominick.grift@defensec.nl).
  These rules would cause a segfault.
    (classmap cm1 (mp1))
    (classmapping cm1 mp1 (cm2 (mp2)))
    (classmap cm2 (mp2))
  But an error would be produced for these rules.
    (classmap cm1 (mp1))
    (classmap cm2 (mp2))
    (classmapping cm2 mp2 (cm1 (mp1)))

3) The loop detection logic was incomplete and could only detect a loop
with a certain statement ordering.
  These rules would cause a stack overflow.
    (classmap cm1 (mp1))
    (classmapping cm1 mp1 (cm2 (mp2)))
    (classmap cm2 (mp2))
    (classmapping cm2 mp2 (cm3 (mp3)))
    (classmap cm3 (mp3))
    (classmapping cm3 mp3 (cm2 (mp2)))

Rewrote __cil_verify_classperms() to fix these errors.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_verify.c | 83 ++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 018514dc..0a098dde 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1545,25 +1545,49 @@ exit:
 	return rc;
 }
 
-static int __cil_verify_classperms(struct cil_list *classperms, struct cil_symtab_datum *orig)
+static int __cil_verify_classperms(struct cil_list *classperms,
+				   struct cil_symtab_datum *orig,
+				   struct cil_symtab_datum *parent,
+				   struct cil_symtab_datum *cur,
+				   enum cil_flavor flavor,
+				   unsigned steps, unsigned limit)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
 
+	if (classperms == NULL) {
+		if (flavor == CIL_MAP_PERM) {
+			cil_tree_log(NODE(cur), CIL_ERR, "Map class %s does not have a classmapping for %s", parent->name, cur->name);
+		} else {
+			cil_tree_log(NODE(cur), CIL_ERR, "Classpermission %s does not have a classpermissionset", cur->name);
+		}
+		goto exit;
+	}
+
+	if (steps > 0 && orig == cur) {
+		if (flavor == CIL_MAP_PERM) {
+			cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving the map class %s and permission %s", parent->name, cur->name);
+		} else {
+			cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving the set %s", cur->name);
+		}
+		goto exit;
+	} else {
+		steps++;
+		if (steps > limit) {
+			steps = 1;
+			limit *= 2;
+			orig = cur;
+		}
+	}
+
 	cil_list_for_each(curr, classperms) {
 		if (curr->flavor == CIL_CLASSPERMS) {
 			struct cil_classperms *cp = curr->data;
-			if (FLAVOR(cp->class) == CIL_CLASS) {
-				return SEPOL_OK;
-			} else { /* MAP */
+			if (FLAVOR(cp->class) != CIL_CLASS) { /* MAP */
 				struct cil_list_item *i = NULL;
 				cil_list_for_each(i, cp->perms) {
 					struct cil_perm *cmp = i->data;
-					if (&cmp->datum == orig) {
-						rc = SEPOL_ERR;
-						goto exit;
-					}
-					rc = __cil_verify_classperms(cmp->classperms, orig);
+					rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
 					if (rc != SEPOL_OK) {
 						goto exit;
 					}
@@ -1572,11 +1596,7 @@ static int __cil_verify_classperms(struct cil_list *classperms, struct cil_symta
 		} else { /* SET */
 			struct cil_classperms_set *cp_set = curr->data;
 			struct cil_classpermission *cp = cp_set->set;
-			if (&cp->datum == orig) {
-				rc = SEPOL_ERR;
-				goto exit;
-			}
-			rc = __cil_verify_classperms(cp->classperms, orig);
+			rc = __cil_verify_classperms(cp->classperms, orig, NULL, &cp->datum, CIL_CLASSPERMISSION, steps, limit);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -1586,30 +1606,14 @@ static int __cil_verify_classperms(struct cil_list *classperms, struct cil_symta
 	return SEPOL_OK;
 
 exit:
-	return rc;
+	return SEPOL_ERR;
 }
 
 static int __cil_verify_classpermission(struct cil_tree_node *node)
 {
-	int rc = SEPOL_ERR;
 	struct cil_classpermission *cp = node->data;
 
-	if (cp->classperms == NULL) {
-		cil_tree_log(node, CIL_ERR, "Classpermission %s does not have a classpermissionset", cp->datum.name);
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
-	rc = __cil_verify_classperms(cp->classperms, &cp->datum);
-	if (rc != SEPOL_OK) {
-		cil_tree_log(node, CIL_ERR, "Found circular class permissions involving the set %s",cp->datum.name);
-		goto exit;
-	}
-
-	rc = SEPOL_OK;
-
-exit:
-	return rc;
+	return __cil_verify_classperms(cp->classperms, &cp->datum, NULL, &cp->datum, CIL_CLASSPERMISSION, 0, 2);
 }
 
 struct cil_verify_map_args {
@@ -1620,24 +1624,11 @@ struct cil_verify_map_args {
 
 static int __verify_map_perm_classperms(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
 {
-	int rc = SEPOL_ERR;
 	struct cil_verify_map_args *map_args = args;
 	struct cil_perm *cmp = (struct cil_perm *)d;
 
-	if (cmp->classperms == NULL) {
-		cil_tree_log(map_args->node, CIL_ERR, "Map class %s does not have a classmapping for %s", map_args->class->datum.name, cmp->datum.name);
-		map_args->rc = SEPOL_ERR;
-		goto exit;
-	}
-
-	rc = __cil_verify_classperms(cmp->classperms, &cmp->datum);
-	if (rc != SEPOL_OK) {
-		cil_tree_log(map_args->node, CIL_ERR, "Found circular class permissions involving the map class %s and permission %s", map_args->class->datum.name, cmp->datum.name);
-		map_args->rc = SEPOL_ERR;
-		goto exit;
-	}
+	map_args->rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &map_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
 
-exit:
 	return SEPOL_OK;
 }
 
-- 
2.21.1

