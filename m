Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04508C6FD1C
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCIVvg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjCIVv2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:28 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA7FEF14
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:22 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z6so3802462qtv.0
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL5P9YbgmNZ82zcdKKtKFeBjBG0r1oC3uQlDTZOOTZU=;
        b=qHnlPme9gwQY8+lnh5Sy14QE94rFGp1ltKHiX7+NC03VfILp+Efa1FtokflsZd1N6n
         pc42Cgu0ZM15LkQRudn8CQ+5dyqrokB+vQpKETMcZiUulfM4Ne+6/plnGnj6geuTMYfF
         fsOiVE6NMg00JB7NcObbmshct4sirdxdH2++iqNSnYc84aJ6OQoiSQSMqbe/xzzXAYqI
         ZP/FzPbJO/2FvWZAasLn0ZJjTSBoHAcPyvAxZTKxqCE05iGIMv5opkqhopTLctiWPaeR
         ceLGa7IbCAC8RfsrFLFf6opKt1d0NlN6ajw/M/5UUsYz6pggvojgus79MIQ5/2oNlovG
         IBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL5P9YbgmNZ82zcdKKtKFeBjBG0r1oC3uQlDTZOOTZU=;
        b=GrZlgifO96fC6d8Y41vg2eqpVOX8gKy8xJI4UbotEeQZagyxLltlkvg8+cQV+F72Vm
         Oitipp0qLYFCE/e4uNdvZ1ZoQujVUkIeYHVmcz3dtMzt9sG2nsP0/KPe85QXRFG+5i73
         Ywy41ATFG2Rpt64ZsqnlBIBN99TXnc97Q8fh8Nj7VyNyjhOpGiUbQZI7hOIdnb4YArdk
         Rt/osFFt8S2yji2ytM3Dd6pXHS42K189PIXgg4ZJJHFAa44ie+DKPe9ZHkIOUTCa9Xi7
         UDY6ssi2EEURs9vsnhagB2KkecHp88+nCyP8pMQsoR3zYEKuxfbdO3g3Ozdl3M4BzF1C
         9ZnA==
X-Gm-Message-State: AO0yUKUjUy0+EavQjPURd+KQ+jpoM/tVYDCBIxCwD0252A4lTkPpQP3e
        rIkLnX0Gq5eNkekWHb3Medf79xLzOVc=
X-Google-Smtp-Source: AK7set+nM2NDWSjclFwKOvPL+4kF4hxUossAvEJCFaQHQVUKnQEc+4os/P5cp2NrzlHVAiCwbhkq3g==
X-Received: by 2002:a05:622a:50c:b0:3a8:fdf:8ff8 with SMTP id l12-20020a05622a050c00b003a80fdf8ff8mr41934417qtx.36.1678398681057;
        Thu, 09 Mar 2023 13:51:21 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:20 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 4/9 v2] libsepol/cil: Process deny rules
Date:   Thu,  9 Mar 2023 16:51:09 -0500
Message-Id: <20230309215114.357831-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A deny rule is like a neverallow rule, except that permissions are
removed rather than an error reported.

(allow S1 T1 P1)
(deny  S2 T2 P2)

First, write the allow rule with all of the permissions not in the deny rule

P3 = P1 and not P2
(allow S1 T1 P3)

Any other rules will only involve the common permissions
P4 = P1 and P2

Next, write the allow rule for any types in S1 that are not in S2

S3 = S1 and not S2
if S3 then
  (allow S3 T1 P4)

Finally, write any allow rules needed to cover any type in T1 that are
not in T2. Since, T1 and T2 might be "self", this requires slightly more
complicated handling.

if T1 is self and T2 is self then
  Nothing more needs to be done
else if T1 is self and T2 is not self then
  S4 = S1 and S2
  S5 = S4 and not T2
  if S5 then
    (allow S5 self P4)
else if T1 is not self and T2 is self then
  S4 = S1 and S2
  S5 = S4 and not T1
  S6 = S4 and T1
  T6 = T1 and not S4
  if S5 then
    (allow S5 T1 P4)
  if S6 then
    if T6 then
      (allow S6 T6 P4)
    if cardinality of S6 > 1 then
      for S in S6 do
        T = S6 and not S
        if T then
          (allow S T P4)
else if T1 is not self and T2 is not self then
  S4 = S1 and S2
  T3 = T1 and not T2
  if T3 then
    (allow S4 T3 P4)

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2:
Renamed cil_classperms_match() to cil_classperms_match_any()
Renamed cil_classperms_list_match() cil_classperms_list_match_any()
Added function cil_classperms_match_all()
Added function cil_classperms_list_match_all()
Updated cil_classperms_andnot() to use the cil_classperms_match_any() and
    cil_classperms_list_match_any() functions.
Added function cil_classperms_and()
Added function cil_classperms_map_and()
Added function cil_classperms_set_and()
Added function cil_classperms_list_and()
Fixed problem in error handling in cil_create_and_insert_attribute_and_set()
    that was found by Daniel Burgener.
Fixed problem in error handling in cil_create_attribute_d1_and_not_d2()
    that was found by Daniel Burgener.
Change cil_create_and_add_avrule() to copy the classperms list, so the
    caller doesn't have to do it.
Completely changed the logic of cil_remove_permissions_from_rule() to
    eliminate the problem of excessive overlap in the new rules that was
    found by Daniel Burgener.

 libsepol/cil/src/cil_deny.c | 1132 +++++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_deny.h |   36 ++
 libsepol/cil/src/cil_post.c |    7 +
 3 files changed, 1175 insertions(+)
 create mode 100644 libsepol/cil/src/cil_deny.c
 create mode 100644 libsepol/cil/src/cil_deny.h

diff --git a/libsepol/cil/src/cil_deny.c b/libsepol/cil/src/cil_deny.c
new file mode 100644
index 00000000..5c010caf
--- /dev/null
+++ b/libsepol/cil/src/cil_deny.c
@@ -0,0 +1,1132 @@
+/*
+ * This file is public domain software, i.e. not copyrighted.
+ *
+ * Warranty Exclusion
+ * ------------------
+ * You agree that this software is a non-commercially developed program
+ * that may contain "bugs" (as that term is used in the industry) and
+ * that it may not function as intended. The software is licensed
+ * "as is". NSA makes no, and hereby expressly disclaims all, warranties,
+ * express, implied, statutory, or otherwise with respect to the software,
+ * including noninfringement and the implied warranties of merchantability
+ * and fitness for a particular purpose.
+ *
+ * Limitation of Liability
+ *-----------------------
+ * In no event will NSA be liable for any damages, including loss of data,
+ * lost profits, cost of cover, or other special, incidental, consequential,
+ * direct or indirect damages arising from the software or the use thereof,
+ * however caused and on any theory of liability. This limitation will apply
+ * even if NSA has been advised of the possibility of such damage. You
+ * acknowledge that this is a reasonable allocation of risk.
+ *
+ * Original author: James Carter
+ */
+
+#include <sepol/policydb/ebitmap.h>
+
+#include "cil_internal.h"
+#include "cil_find.h"
+#include "cil_flavor.h"
+#include "cil_list.h"
+#include "cil_strpool.h"
+#include "cil_log.h"
+#include "cil_symtab.h"
+#include "cil_build_ast.h"
+#include "cil_copy_ast.h"
+#include "cil_deny.h"
+
+#define CIL_DENY_ATTR_PREFIX "deny_rule_attr"
+
+/*
+ * A deny rule is like a neverallow rule, except that permissions are
+ * removed rather than an error reported.
+ *
+ * (allow S1 T1 P1)
+ * (deny  S2 T2 P2)
+ *
+ * First, write the allow rule with all of the permissions not in the deny rule
+ *
+ * P3 = P1 and not P2
+ * (allow S1 T1 P3)
+ *
+ * Any other rules will only involve the common permissions
+ * P4 = P1 and P2
+ *
+ * Next, write the allow rule for any types in S1 that are not in S2
+ *
+ * S3 = S1 and not S2
+ * if S3 then
+ *   (allow S3 T1 P4)
+ *
+ * Finally, write any allow rules needed to cover any type in T1 that are
+ * not in T2. Since, T1 and T2 might be "self", this requires slightly more
+ * complicated handling.
+ *
+ * if T1 is self and T2 is self then
+ *   Nothing more needs to be done
+ * else if T1 is self and T2 is not self then
+ *   S4 = S1 and S2
+ *   S5 = S4 and not T2
+ *   if S5 then
+ *     (allow S5 self P4)
+ * else if T1 is not self and T2 is self then
+ *   S4 = S1 and S2
+ *   S5 = S4 and not T1
+ *   S6 = S4 and T1
+ *   T6 = T1 and not S4
+ *   if S5 then
+ *     (allow S5 T1 P4)
+ *   if S6 then
+ *     if T6 then
+ *       (allow S6 T6 P4)
+ *     if cardinality of S6 > 1 then
+ *       for S in S6 do
+ *         T = S6 and not S
+ *         if T then
+ *           (allow S T P4)
+ * else if T1 is not self and T2 is not self then
+ *   S4 = S1 and S2
+ *   T3 = T1 and not T2
+ *   if T3 then
+ *     (allow S4 T3 P4)
+ */
+
+static int cil_perm_match(const struct cil_perm *p1, const struct cil_list *pl2)
+{
+	struct cil_list_item *curr;
+
+	cil_list_for_each(curr, pl2) {
+		struct cil_perm *p = curr->data;
+		if (p == p1) {
+			return CIL_TRUE;
+		}
+	}
+	return CIL_FALSE;
+}
+
+static int cil_class_perm_match(const struct cil_class *c1, const struct cil_perm *p1, const struct cil_list *cpl2)
+{
+	struct cil_list_item *curr;
+
+	cil_list_for_each(curr, cpl2) {
+		if (curr->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = curr->data;
+			if (FLAVOR(cp->class) == CIL_CLASS) {
+				if (cp->class == c1) {
+					if (cil_perm_match(p1, cp->perms)) {
+						return CIL_TRUE;
+					}
+				}
+			} else { /* MAP */
+				struct cil_list_item *p;
+				cil_list_for_each(p, cp->perms) {
+					struct cil_perm *cmp = p->data;
+					if (cil_class_perm_match(c1, p1, cmp->classperms)) {
+						return CIL_TRUE;
+					}
+				}
+			}
+		} else { /* SET */
+			struct cil_classperms_set *cp_set = curr->data;
+			struct cil_classpermission *cp = cp_set->set;
+			if (cil_class_perm_match(c1, p1, cp->classperms)) {
+				return CIL_TRUE;
+			}
+		}
+	}
+	return CIL_FALSE;
+}
+
+static int cil_classperms_match_any(const struct cil_classperms *cp1, const struct cil_list *cpl2)
+{
+	struct cil_list_item *curr;
+
+	cil_list_for_each(curr, cp1->perms) {
+		struct cil_perm *perm = curr->data;
+		if (cil_class_perm_match(cp1->class, perm, cpl2)) {
+			return CIL_TRUE;
+		}
+	}
+	return CIL_FALSE;
+}
+
+int cil_classperms_list_match_any(const struct cil_list *cpl1, const struct cil_list *cpl2)
+{
+	struct cil_list_item *curr;
+
+	if (!cpl1 || !cpl2) {
+		return (!cpl1 && !cpl2) ? CIL_TRUE : CIL_FALSE;
+	}
+
+	cil_list_for_each(curr, cpl1) {
+		if (curr->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = curr->data;
+			if (FLAVOR(cp->class) == CIL_CLASS) {
+				if (cil_classperms_match_any(cp, cpl2)) {
+					return CIL_TRUE;
+				}
+			} else { /* MAP */
+				struct cil_list_item *p;
+				cil_list_for_each(p, cp->perms) {
+					struct cil_perm *cmp = p->data;
+					if (cil_classperms_list_match_any(cmp->classperms, cpl2)) {
+						return CIL_TRUE;
+					}
+				}
+			}
+		} else { /* SET */
+			struct cil_classperms_set *cp_set = curr->data;
+			struct cil_classpermission *cp = cp_set->set;
+			if (cil_classperms_list_match_any(cp->classperms, cpl2)) {
+				return CIL_TRUE;
+			}
+		}
+	}
+	return CIL_FALSE;
+}
+
+static int cil_classperms_match_all(const struct cil_classperms *cp1, const struct cil_list *cpl2)
+{
+	struct cil_list_item *curr;
+
+	cil_list_for_each(curr, cp1->perms) {
+		struct cil_perm *perm = curr->data;
+		if (!cil_class_perm_match(cp1->class, perm, cpl2)) {
+			return CIL_FALSE;
+		}
+	}
+	return CIL_TRUE;
+}
+
+int cil_classperms_list_match_all(const struct cil_list *cpl1, const struct cil_list *cpl2)
+{
+	struct cil_list_item *curr;
+
+	if (!cpl1 || !cpl2) {
+		return (!cpl1 && !cpl2) ? CIL_TRUE : CIL_FALSE;
+	}
+
+	cil_list_for_each(curr, cpl1) {
+		if (curr->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = curr->data;
+			if (FLAVOR(cp->class) == CIL_CLASS) {
+				if (!cil_classperms_match_all(cp, cpl2)) {
+					return CIL_FALSE;
+				}
+			} else { /* MAP */
+				struct cil_list_item *p;
+				cil_list_for_each(p, cp->perms) {
+					struct cil_perm *cmp = p->data;
+					if (!cil_classperms_list_match_all(cmp->classperms, cpl2)) {
+						return CIL_FALSE;
+					}
+				}
+			}
+		} else { /* SET */
+			struct cil_classperms_set *cp_set = curr->data;
+			struct cil_classpermission *cp = cp_set->set;
+			if (!cil_classperms_list_match_all(cp->classperms, cpl2)) {
+				return CIL_FALSE;
+			}
+		}
+	}
+	return CIL_TRUE;
+}
+
+static void cil_classperms_copy(struct cil_classperms **new, const struct cil_classperms *old)
+{
+	cil_classperms_init(new);
+	(*new)->class_str = old->class_str;
+	(*new)->class = old->class;
+	cil_copy_list(old->perm_strs, &(*new)->perm_strs);
+	cil_copy_list(old->perms, &(*new)->perms);
+}
+
+static void cil_classperms_set_copy(struct cil_classperms_set **new, const struct cil_classperms_set *old)
+{
+	cil_classperms_set_init(new);
+	(*new)->set_str = old->set_str;
+	(*new)->set = old->set;
+}
+
+void cil_classperms_list_copy(struct cil_list **new, const struct cil_list *old)
+{
+	struct cil_list_item *curr;
+
+	if (!new) {
+		return;
+	}
+
+	if (!old) {
+		*new = NULL;
+		return;
+	}
+
+	cil_list_init(new, CIL_LIST);
+
+	cil_list_for_each(curr, old) {
+		if (curr->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *new_cp;
+			cil_classperms_copy(&new_cp, curr->data);
+			cil_list_append(*new, CIL_CLASSPERMS, new_cp);
+		} else { /* SET */
+			struct cil_classperms_set *new_cps;
+			cil_classperms_set_copy(&new_cps, curr->data);
+			cil_list_append(*new, CIL_CLASSPERMS_SET, new_cps);
+		}
+	}
+
+	if (cil_list_is_empty(*new)) {
+		cil_list_destroy(new, CIL_FALSE);
+	}
+}
+
+/* Append cp1 and cpl2 to result */
+static void cil_classperms_and(struct cil_list **result, const struct cil_classperms *cp1, const struct cil_list *cpl2)
+{
+	struct cil_classperms *new_cp = NULL;
+	struct cil_list_item *curr;
+
+	if (cil_classperms_match_all(cp1, cpl2)) {
+		cil_classperms_copy(&new_cp, cp1);
+		cil_list_append(*result, CIL_CLASSPERMS, new_cp);
+		return;
+	}
+
+	cil_list_for_each(curr, cp1->perms) {
+		struct cil_perm *perm = curr->data;
+		if (cil_class_perm_match(cp1->class, perm, cpl2)) {
+			if (new_cp == NULL) {
+				cil_classperms_init(&new_cp);
+				new_cp->class_str = cp1->class_str;
+				new_cp->class = cp1->class;
+				cil_list_init(&new_cp->perm_strs, CIL_PERM);
+				cil_list_init(&new_cp->perms, CIL_PERM);
+				cil_list_append(*result, CIL_CLASSPERMS, new_cp);
+			}
+			cil_list_append(new_cp->perm_strs, CIL_STRING, perm->datum.fqn);
+			cil_list_append(new_cp->perms, CIL_DATUM, perm);
+		}
+	}
+}
+
+/* Append cp1 and cpl2 to result */
+static void cil_classperms_map_and(struct cil_list **result, const struct cil_classperms *cp1, const struct cil_list *cpl2)
+{
+	struct cil_classperms *new_cp = NULL;
+	struct cil_list_item *p;
+
+	cil_list_for_each(p, cp1->perms) {
+		struct cil_perm *map_perm = p->data;
+		if (cil_classperms_list_match_all(map_perm->classperms, cpl2)) {
+			if (new_cp == NULL) {
+				cil_classperms_init(&new_cp);
+				new_cp->class_str = cp1->class_str;
+				new_cp->class = cp1->class;
+				cil_list_init(&new_cp->perm_strs, CIL_PERM);
+				cil_list_init(&new_cp->perms, CIL_PERM);
+				cil_list_append(*result, CIL_CLASSPERMS, new_cp);
+			}
+			cil_list_append(new_cp->perm_strs, CIL_STRING, map_perm->datum.fqn);
+			cil_list_append(new_cp->perms, CIL_DATUM, map_perm);
+		} else {
+			struct cil_list *new_cpl = NULL;
+			cil_classperms_list_and(&new_cpl, map_perm->classperms, cpl2);
+			if (new_cpl) {
+				struct cil_list_item *i;
+				cil_list_for_each(i, new_cpl) {
+					cil_list_append(*result, i->flavor, i->data);
+				}
+				cil_list_destroy(&new_cpl, CIL_FALSE);
+			}
+		}
+	}
+}
+
+/* Append cps1 and cpl2 to result */
+static void cil_classperms_set_and(struct cil_list **result, const struct cil_classperms_set *cps1, const struct cil_list *cpl2)
+{
+	struct cil_classpermission *cp = cps1->set;
+
+	if (cil_classperms_list_match_all(cp->classperms, cpl2)) {
+		struct cil_classperms_set *new_cps;
+		cil_classperms_set_copy(&new_cps, cps1);
+		cil_list_append(*result, CIL_CLASSPERMS_SET, new_cps);
+	} else {
+		struct cil_list *new_cpl;
+		cil_classperms_list_and(&new_cpl, cp->classperms, cpl2);
+		if (new_cpl) {
+			struct cil_list_item *i;
+			cil_list_for_each(i, new_cpl) {
+				cil_list_append(*result, i->flavor, i->data);
+			}
+			cil_list_destroy(&new_cpl, CIL_FALSE);
+		}
+	}
+}
+
+/* result = cpl1 and cpl2 */
+void cil_classperms_list_and(struct cil_list **result, const struct cil_list *cpl1, const struct cil_list *cpl2)
+{
+	struct cil_list_item *curr;
+
+	if (!result) {
+		return;
+	}
+
+	if (!cpl1 || !cpl2) {
+		*result = NULL;
+		return;
+	}
+
+	if (cil_classperms_list_match_all(cpl1, cpl2)) {
+		cil_classperms_list_copy(result, cpl1);
+		return;
+	}
+
+	cil_list_init(result, CIL_LIST);
+
+	cil_list_for_each(curr, cpl1) {
+		if (curr->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = curr->data;
+			if (FLAVOR(cp->class) == CIL_CLASS) {
+				cil_classperms_and(result, cp, cpl2);
+			} else { /* MAP */
+				cil_classperms_map_and(result, cp, cpl2);
+			}
+		} else { /* SET */
+			struct cil_classperms_set *cps = curr->data;
+			cil_classperms_set_and(result, cps, cpl2);
+		}
+	}
+
+	if (cil_list_is_empty(*result)) {
+		cil_list_destroy(result, CIL_FALSE);
+	}
+}
+
+/* Append cp1 and not cpl2 to result */
+static void cil_classperms_andnot(struct cil_list **result, const struct cil_classperms *cp1, const struct cil_list *cpl2)
+{
+	struct cil_classperms *new_cp = NULL;
+	struct cil_list_item *curr;
+
+	if (!cil_classperms_match_any(cp1, cpl2)) {
+		cil_classperms_copy(&new_cp, cp1);
+		cil_list_append(*result, CIL_CLASSPERMS, new_cp);
+		return;
+	}
+
+	cil_list_for_each(curr, cp1->perms) {
+		struct cil_perm *perm = curr->data;
+		if (!cil_class_perm_match(cp1->class, perm, cpl2)) {
+			if (new_cp == NULL) {
+				cil_classperms_init(&new_cp);
+				new_cp->class_str = cp1->class_str;
+				new_cp->class = cp1->class;
+				cil_list_init(&new_cp->perm_strs, CIL_PERM);
+				cil_list_init(&new_cp->perms, CIL_PERM);
+				cil_list_append(*result, CIL_CLASSPERMS, new_cp);
+			}
+			cil_list_append(new_cp->perm_strs, CIL_STRING, perm->datum.fqn);
+			cil_list_append(new_cp->perms, CIL_DATUM, perm);
+		}
+	}
+}
+
+/* Append cp1 and not cpl2 to result */
+static void cil_classperms_map_andnot(struct cil_list **result, const struct cil_classperms *cp1, const struct cil_list *cpl2)
+{
+	struct cil_classperms *new_cp = NULL;
+	struct cil_list_item *p;
+
+	cil_list_for_each(p, cp1->perms) {
+		struct cil_perm *map_perm = p->data;
+		if (!cil_classperms_list_match_any(map_perm->classperms, cpl2)) {
+			if (new_cp == NULL) {
+				cil_classperms_init(&new_cp);
+				new_cp->class_str = cp1->class_str;
+				new_cp->class = cp1->class;
+				cil_list_init(&new_cp->perm_strs, CIL_PERM);
+				cil_list_init(&new_cp->perms, CIL_PERM);
+				cil_list_append(*result, CIL_CLASSPERMS, new_cp);
+			}
+			cil_list_append(new_cp->perm_strs, CIL_STRING, map_perm->datum.fqn);
+			cil_list_append(new_cp->perms, CIL_DATUM, map_perm);
+		} else {
+			struct cil_list *new_cpl = NULL;
+			cil_classperms_list_andnot(&new_cpl, map_perm->classperms, cpl2);
+			if (new_cpl) {
+				struct cil_list_item *i;
+				cil_list_for_each(i, new_cpl) {
+					cil_list_append(*result, i->flavor, i->data);
+				}
+				cil_list_destroy(&new_cpl, CIL_FALSE);
+			}
+		}
+	}
+}
+
+/* Append cps1 and not cpl2 to result */
+static void cil_classperms_set_andnot(struct cil_list **result, const struct cil_classperms_set *cps1, const struct cil_list *cpl2)
+{
+	struct cil_classpermission *cp = cps1->set;
+
+	if (!cil_classperms_list_match_any(cp->classperms, cpl2)) {
+		struct cil_classperms_set *new_cps;
+		cil_classperms_set_copy(&new_cps, cps1);
+		cil_list_append(*result, CIL_CLASSPERMS_SET, new_cps);
+	} else {
+		struct cil_list *new_cpl;
+		cil_classperms_list_andnot(&new_cpl, cp->classperms, cpl2);
+		if (new_cpl) {
+			struct cil_list_item *i;
+			cil_list_for_each(i, new_cpl) {
+				cil_list_append(*result, i->flavor, i->data);
+			}
+			cil_list_destroy(&new_cpl, CIL_FALSE);
+		}
+	}
+}
+
+/* result = cpl1 and not cpl2 */
+void cil_classperms_list_andnot(struct cil_list **result, const struct cil_list *cpl1, const struct cil_list *cpl2)
+{
+	struct cil_list_item *curr;
+
+	if (!result) {
+		return;
+	}
+
+	if (!cpl1) {
+		*result = NULL;
+		return;
+	}
+
+	if (!cpl2 || !cil_classperms_list_match_any(cpl1, cpl2)) {
+		cil_classperms_list_copy(result, cpl1);
+		return;
+	}
+
+	cil_list_init(result, CIL_LIST);
+
+	cil_list_for_each(curr, cpl1) {
+		if (curr->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = curr->data;
+			if (FLAVOR(cp->class) == CIL_CLASS) {
+				cil_classperms_andnot(result, cp, cpl2);
+			} else { /* MAP */
+				cil_classperms_map_andnot(result, cp, cpl2);
+			}
+		} else { /* SET */
+			struct cil_classperms_set *cps = curr->data;
+			cil_classperms_set_andnot(result, cps, cpl2);
+		}
+	}
+
+	if (cil_list_is_empty(*result)) {
+		cil_list_destroy(result, CIL_FALSE);
+	}
+}
+
+/* result = d1 and d2 */
+static int cil_datums_and(ebitmap_t *result, const struct cil_symtab_datum *d1, const struct cil_symtab_datum *d2)
+{
+	int rc = SEPOL_OK;
+	enum cil_flavor f1 = FLAVOR(d1);
+	enum cil_flavor f2 = FLAVOR(d2);
+
+	if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
+		struct cil_type *t1 = (struct cil_type *)d1;
+		struct cil_type *t2 = (struct cil_type *)d2;
+		ebitmap_init(result);
+		if (t1->value == t2->value) {
+			rc = ebitmap_set_bit(result, t1->value, 1);
+			if (rc != SEPOL_OK) {
+				ebitmap_destroy(result);
+				goto exit;
+			}
+		}
+	} else if (f1 == CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
+		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
+		struct cil_type *t2 = (struct cil_type *)d2;
+		ebitmap_init(result);
+		if (ebitmap_get_bit(a1->types, t2->value)) {
+			rc = ebitmap_set_bit(result, t2->value, 1);
+			if (rc != SEPOL_OK) {
+				ebitmap_destroy(result);
+				goto exit;
+			}
+		}
+	} else if (f1 != CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
+		struct cil_type *t1 = (struct cil_type *)d1;
+		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
+		ebitmap_init(result);
+		if (ebitmap_get_bit(a2->types, t1->value)) {
+			rc = ebitmap_set_bit(result, t1->value, 1);
+			if (rc != SEPOL_OK) {
+				ebitmap_destroy(result);
+				goto exit;
+			}
+		}
+	} else {
+		/* Both are attributes */
+		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
+		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
+		rc = ebitmap_and(result, a1->types, a2->types);
+		if (rc != SEPOL_OK) {
+			ebitmap_destroy(result);
+			goto exit;
+		}
+	}
+exit:
+	return rc;
+}
+
+/* result = d1 and not d2 */
+static int cil_datums_andnot(ebitmap_t *result, const struct cil_symtab_datum *d1, const struct cil_symtab_datum *d2)
+{
+	int rc = SEPOL_OK;
+	enum cil_flavor f1 = FLAVOR(d1);
+	enum cil_flavor f2 = FLAVOR(d2);
+
+	if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
+		struct cil_type *t1 = (struct cil_type *)d1;
+		struct cil_type *t2 = (struct cil_type *)d2;
+		ebitmap_init(result);
+		if (t1->value != t2->value) {
+			rc = ebitmap_set_bit(result, t1->value, 1);
+			if (rc != SEPOL_OK) {
+				ebitmap_destroy(result);
+				goto exit;
+			}
+		}
+	} else if (f1 == CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
+		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
+		struct cil_type *t2 = (struct cil_type *)d2;
+		rc = ebitmap_cpy(result, a1->types);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rc = ebitmap_set_bit(result, t2->value, 0);
+		if (rc != SEPOL_OK) {
+			ebitmap_destroy(result);
+			goto exit;
+		}
+	} else if (f1 != CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
+		struct cil_type *t1 = (struct cil_type *)d1;
+		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
+		ebitmap_init(result);
+		if (!ebitmap_get_bit(a2->types, t1->value)) {
+			rc = ebitmap_set_bit(result, t1->value, 1);
+			if (rc != SEPOL_OK) {
+				ebitmap_destroy(result);
+				goto exit;
+			}
+		}
+	} else {
+		/* Both are attributes */
+		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
+		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
+		rc = ebitmap_andnot(result, a1->types, a2->types, a1->types->highbit);
+		if (rc != SEPOL_OK) {
+			ebitmap_destroy(result);
+			goto exit;
+		}
+	}
+exit:
+	return rc;
+}
+
+static size_t num_digits(unsigned n)
+{
+	size_t num = 1;
+	while (n >= 10) {
+		n /= 10;
+		num++;
+	}
+	return num;
+}
+
+static char *cil_create_new_attribute_name(unsigned num)
+{
+	char *s1 = NULL;
+	char *s2 = NULL;
+	size_t len_num = num_digits(num);
+	size_t len = strlen(CIL_DENY_ATTR_PREFIX) + 1 + len_num + 1;
+	int rc;
+
+	if (len >= CIL_MAX_NAME_LENGTH) {
+		cil_log(CIL_ERR, "Name length greater than max name length of %d",
+				CIL_MAX_NAME_LENGTH);
+		goto exit;
+	}
+
+	s1 = cil_malloc(len);
+	rc = snprintf(s1, len, "%s_%u", CIL_DENY_ATTR_PREFIX, num);
+	if (rc < 0 || (size_t)rc >= len) {
+		cil_log(CIL_ERR, "Error creating new attribute name");
+		free(s1);
+		goto exit;
+	}
+
+	s2 = cil_strpool_add(s1);
+	free(s1);
+
+exit:
+	return s2;
+}
+
+static struct cil_list *cil_create_and_expr_list(enum cil_flavor flavor, void *v1, void *v2)
+{
+	struct cil_list *expr;
+
+	cil_list_init(&expr, CIL_TYPE);
+	cil_list_append(expr, CIL_OP, (void *)CIL_AND);
+	cil_list_append(expr, flavor, v1);
+	cil_list_append(expr, flavor, v2);
+
+	return expr;
+}
+
+static struct cil_list *cil_create_andnot_expr_list(enum cil_flavor flavor, void *v1, void *v2)
+{
+	struct cil_list *expr, *sub_expr;
+
+	cil_list_init(&expr, CIL_TYPE);
+	cil_list_append(expr, CIL_OP, (void *)CIL_AND);
+	cil_list_append(expr, flavor, v1);
+	cil_list_init(&sub_expr, CIL_TYPE);
+	cil_list_append(sub_expr, CIL_OP, (void *)CIL_NOT);
+	cil_list_append(sub_expr, flavor, v2);
+	cil_list_append(expr, CIL_LIST, sub_expr);
+
+	return expr;
+}
+
+static struct cil_tree_node *cil_create_and_insert_node(struct cil_tree_node *prev, enum cil_flavor flavor, void *data)
+{
+	struct cil_tree_node *new;
+
+	cil_tree_node_init(&new);
+	new->parent = prev->parent;
+	new->line = prev->line;
+	new->hll_offset = prev->hll_offset;
+	new->flavor = flavor;
+	new->data = data;
+	new->next = prev->next;
+	prev->next = new;
+
+	return new;
+}
+
+static int cil_create_and_insert_attribute_and_set(struct cil_db *db, struct cil_tree_node *prev, struct cil_list *str_expr, struct cil_list *datum_expr, ebitmap_t *types, struct cil_symtab_datum **d)
+{
+	struct cil_tree_node *attr_node = NULL;
+	char *name;
+	struct cil_typeattribute *attr = NULL;
+	struct cil_tree_node *attrset_node = NULL;
+	struct cil_typeattributeset *attrset = NULL;
+	symtab_t *symtab = NULL;
+	int rc = SEPOL_ERR;
+
+	name = cil_create_new_attribute_name(db->num_types_and_attrs);
+	if (!name) {
+		goto exit;
+	}
+
+	cil_typeattributeset_init(&attrset);
+	attrset->attr_str = name;
+	attrset->str_expr = str_expr;
+	attrset->datum_expr = datum_expr;
+
+	cil_typeattribute_init(&attr);
+	cil_list_init(&attr->expr_list, CIL_TYPE);
+	cil_list_append(attr->expr_list, CIL_LIST, datum_expr);
+	attr->types = types;
+	attr->used = CIL_ATTR_AVRULE;
+	attr->keep = (ebitmap_cardinality(types) < db->attrs_expand_size) ? CIL_FALSE : CIL_TRUE;
+
+	attr_node = cil_create_and_insert_node(prev, CIL_TYPEATTRIBUTE, attr);
+	attrset_node = cil_create_and_insert_node(attr_node, CIL_TYPEATTRIBUTESET, attrset);
+
+	rc = cil_get_symtab(prev->parent, &symtab, CIL_SYM_TYPES);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	rc = cil_symtab_insert(symtab, name, &attr->datum, attr_node);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	db->num_types_and_attrs++;
+
+	*d = &attr->datum;
+
+	return SEPOL_OK;
+
+exit:
+	if (attr_node) {
+		cil_destroy_typeattribute(attr_node->data); // This will not destroy datum_expr
+		free(attr_node);
+	}
+	if (attrset_node) {
+		prev->next = attrset_node->next;
+		free(attrset_node);
+	}
+	return rc;
+}
+
+static int cil_create_attribute_d1_and_not_d2(struct cil_db *db, struct cil_tree_node *prev, struct cil_symtab_datum *d1, struct cil_symtab_datum *d2, struct cil_symtab_datum **d3)
+{
+	struct cil_list *str_expr;
+	struct cil_list *datum_expr;
+	ebitmap_t *types;
+	int rc;
+
+	*d3 = NULL;
+
+	if (d1 == d2) {
+		return SEPOL_OK;
+	}
+
+	str_expr = cil_create_andnot_expr_list(CIL_STRING, d1->fqn, d2->fqn);
+	datum_expr = cil_create_andnot_expr_list(CIL_DATUM, d1, d2);
+
+	types = cil_malloc(sizeof(*types));
+	rc = cil_datums_andnot(types, d1, d2);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	if (ebitmap_is_empty(types)) {
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
+	if (ebitmap_cardinality(types) == 1) {
+		unsigned i = ebitmap_highest_set_bit(types);
+		*d3 = DATUM(db->val_to_type[i]);
+		ebitmap_destroy(types);
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
+	rc = cil_create_and_insert_attribute_and_set(db, prev, str_expr, datum_expr, types, d3);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_list_destroy(&str_expr, CIL_FALSE);
+	cil_list_destroy(&datum_expr, CIL_FALSE);
+	free(types);
+	return rc;
+}
+
+static int cil_create_attribute_d1_and_d2(struct cil_db *db, struct cil_tree_node *prev, struct cil_symtab_datum *d1, struct cil_symtab_datum *d2, struct cil_symtab_datum **d3)
+{
+	struct cil_list *str_expr;
+	struct cil_list *datum_expr;
+	ebitmap_t *types;
+	int rc;
+
+	if (d1 == d2) {
+		*d3 = d1;
+		return SEPOL_OK;
+	}
+
+	*d3 = NULL;
+
+	str_expr = cil_create_and_expr_list(CIL_STRING, d1->fqn, d2->fqn);
+	datum_expr = cil_create_and_expr_list(CIL_DATUM, d1, d2);
+
+	types = cil_malloc(sizeof(*types));
+	rc = cil_datums_and(types, d1, d2);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	if (ebitmap_is_empty(types)) {
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
+	if (ebitmap_cardinality(types) == 1) {
+		unsigned i = ebitmap_highest_set_bit(types);
+		*d3 = DATUM(db->val_to_type[i]);
+		ebitmap_destroy(types);
+		rc = SEPOL_OK;
+		goto exit;
+	}
+
+	rc = cil_create_and_insert_attribute_and_set(db, prev, str_expr, datum_expr, types, d3);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_list_destroy(&str_expr, CIL_FALSE);
+	cil_list_destroy(&datum_expr, CIL_FALSE);
+	free(types);
+	return rc;
+}
+
+static struct cil_avrule *cil_create_avrule(struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classperms)
+{
+	struct cil_avrule *new;
+
+	cil_avrule_init(&new);
+	new->is_extended = CIL_FALSE;
+	new->rule_kind = CIL_AVRULE_ALLOWED;
+	new->src_str = src->name;
+	new->src = src;
+	new->tgt_str = tgt->name;
+	new->tgt = tgt;
+	new->perms.classperms = classperms;
+
+	return new;
+}
+
+static struct cil_tree_node *cil_create_and_add_avrule(struct cil_tree_node *curr, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classperms)
+{
+	struct cil_avrule *new_avrule;
+	struct cil_list *new_cp_list;
+
+	cil_classperms_list_copy(&new_cp_list, classperms);
+	new_avrule = cil_create_avrule(src, tgt, new_cp_list);
+	return cil_create_and_insert_node(curr, CIL_AVRULE, new_avrule);
+}
+
+static int cil_remove_permissions_from_rule(struct cil_db *db, struct cil_tree_node *allow_node, const struct cil_tree_node *deny_node)
+{
+	struct cil_avrule *allow_rule = allow_node->data;
+	struct cil_deny_rule *deny_rule = deny_node->data;
+	struct cil_symtab_datum *s1 = allow_rule->src;
+	struct cil_symtab_datum *t1 = allow_rule->tgt;
+	struct cil_list *p1 = allow_rule->perms.classperms;
+	struct cil_symtab_datum *s2 = deny_rule->src;
+	struct cil_symtab_datum *t2 = deny_rule->tgt;
+	struct cil_list *p2 = deny_rule->classperms;
+	struct cil_list *p3 = NULL;
+	struct cil_list *p4 = NULL;
+	struct cil_symtab_datum *s3 = NULL;
+	struct cil_tree_node *curr = allow_node;
+	int rc;
+
+	cil_classperms_list_andnot(&p3, p1, p2);
+	if (!cil_list_is_empty(p3)) {;
+		curr = cil_create_and_add_avrule(curr, s1, t1, p3);
+	}
+	cil_destroy_classperms_list(&p3);
+	p3 = NULL;
+
+	cil_classperms_list_and(&p4, p1, p2);
+	if (cil_list_is_empty(p4)) {
+		cil_tree_log(allow_node, CIL_ERR, "Allow rule did not match deny rule: No matching class and permissions");
+		cil_tree_log((struct cil_tree_node *)deny_node, CIL_ERR, "Deny rule");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	rc = cil_create_attribute_d1_and_not_d2(db, NODE(s1), s1, s2, &s3);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	if (s3) {
+		curr = cil_create_and_add_avrule(curr, s3, t1, p4);
+	}
+
+	if (DATUM(t1) == DATUM(db->selftype) && DATUM(t2) == DATUM(db->selftype)) {
+		/* Nothing more is needed */
+	} else if (DATUM(t1) == DATUM(db->selftype) && DATUM(t2) != DATUM(db->selftype)) {
+		struct cil_symtab_datum *s4, *s5;
+		rc = cil_create_attribute_d1_and_d2(db, NODE(s1), s1, s2, &s4);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rc = cil_create_attribute_d1_and_not_d2(db, NODE(s4), s4, t2, &s5);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		if (s5) {
+			curr = cil_create_and_add_avrule(curr, s5, DATUM(db->selftype), p4);
+		}
+	} else if (DATUM(t1) != DATUM(db->selftype) && DATUM(t2) == DATUM(db->selftype)) {
+		struct cil_symtab_datum *s4, *s5, *s6, *t6;
+		rc = cil_create_attribute_d1_and_d2(db, NODE(s1), s1, s2, &s4);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rc = cil_create_attribute_d1_and_not_d2(db, NODE(s4), s4, t1, &s5);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rc = cil_create_attribute_d1_and_d2(db, NODE(s4), s4, t1, &s6);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rc = cil_create_attribute_d1_and_not_d2(db, NODE(t1), t1, s4, &t6);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		if (s5) {
+			curr = cil_create_and_add_avrule(curr, s5, t1, p4);
+		}
+		if (s6 && FLAVOR(s6) == CIL_TYPEATTRIBUTE) {
+			struct cil_typeattribute *s6_attr = (struct cil_typeattribute *)s6;
+			ebitmap_node_t *n;
+			unsigned i;
+
+			if (t6) {
+				curr = cil_create_and_add_avrule(curr, s6, t6, p4);
+			}
+
+			if (ebitmap_cardinality(s6_attr->types) > 1) {
+				struct cil_symtab_datum *s = NULL;
+				struct cil_symtab_datum *t = NULL;
+				ebitmap_for_each_positive_bit(s6_attr->types, n, i) {
+					s = DATUM(db->val_to_type[i]);
+					rc = cil_create_attribute_d1_and_not_d2(db, NODE(s6), s6, s, &t);
+					if (rc != SEPOL_OK) {
+						goto exit;
+					}
+					if (t) {
+						curr = cil_create_and_add_avrule(curr, s, t, p4);
+					}
+				}
+			}
+		}
+	} else {
+		struct cil_symtab_datum *s4, *t3;
+		rc = cil_create_attribute_d1_and_d2(db, NODE(s1), s1, s2, &s4);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		rc = cil_create_attribute_d1_and_not_d2(db, NODE(t1), t1, t2, &t3);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		if (t3) {
+			curr = cil_create_and_add_avrule(curr, s4, t3, p4);
+		}
+	}
+
+exit:
+	if (p4) {
+		cil_destroy_classperms_list(&p4);
+	}
+	return rc;
+}
+
+static int cil_find_matching_allow_rules(struct cil_list *matching, struct cil_tree_node *start, struct cil_tree_node *deny_node)
+{
+	struct cil_deny_rule *deny_rule = deny_node->data;
+	struct cil_avrule target;
+
+	target.rule_kind = CIL_AVRULE_ALLOWED;
+	target.is_extended = CIL_FALSE;
+	target.src = deny_rule->src;
+	target.tgt = deny_rule->tgt;
+	target.perms.classperms = deny_rule->classperms;
+
+	return cil_find_matching_avrule_in_ast(start, CIL_AVRULE, &target, matching, CIL_FALSE);
+}
+
+static int cil_process_deny_rule(struct cil_db *db, struct cil_tree_node *start, struct cil_tree_node *deny_node)
+{
+	struct cil_list *matching;
+	struct cil_list_item *item;
+	int rc;
+
+	cil_list_init(&matching, CIL_NODE);
+
+	rc = cil_find_matching_allow_rules(matching, start, deny_node);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_list_for_each(item, matching) {
+		struct cil_tree_node *allow_node = item->data;
+		rc = cil_remove_permissions_from_rule(db, allow_node, deny_node);
+		cil_tree_node_remove(allow_node);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+	}
+
+exit:
+	cil_list_destroy(&matching, CIL_FALSE);
+	return rc;
+}
+
+static int cil_process_deny_rules(struct cil_db *db, struct cil_tree_node *start, struct cil_list *deny_rules)
+{
+	struct cil_list_item *item;
+	int rc;
+
+	cil_list_for_each(item, deny_rules) {
+		struct cil_tree_node *deny_node = item->data;
+		rc = cil_process_deny_rule(db, start, deny_node);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		cil_tree_node_remove(deny_node);
+	}
+
+exit:
+	return rc;
+}
+
+static int __cil_find_deny_rules(struct cil_tree_node *node,  uint32_t *finished, void *extra_args)
+{
+	struct cil_list *deny_rules = extra_args;
+
+	if (node->flavor == CIL_BLOCK) {
+		struct cil_block *block = node->data;
+		if (block->is_abstract == CIL_TRUE) {
+			*finished = CIL_TREE_SKIP_HEAD;
+		}
+	} else if (node->flavor == CIL_MACRO) {
+		*finished = CIL_TREE_SKIP_HEAD;
+	} else if (node->flavor == CIL_DENY_RULE) {
+		cil_list_append(deny_rules, CIL_DENY_RULE, node);
+	}
+	return SEPOL_OK;
+}
+
+int cil_process_deny_rules_in_ast(struct cil_db *db)
+{
+	struct cil_tree_node *start;
+	struct cil_list *deny_rules;
+	int rc = SEPOL_ERR;
+
+	cil_list_init(&deny_rules, CIL_DENY_RULE);
+
+	if (!db) {
+		cil_log(CIL_ERR, "No CIL db provided to process deny rules\n");
+		goto exit;
+	}
+
+	start = db->ast->root;
+	rc = cil_tree_walk(start, __cil_find_deny_rules, NULL, NULL, deny_rules);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "An error occurred while getting deny rules\n");
+		goto exit;
+	}
+
+	rc = cil_process_deny_rules(db, start, deny_rules);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "An error occurred while processing deny rules\n");
+		goto exit;
+	}
+
+exit:
+	cil_list_destroy(&deny_rules, CIL_FALSE);
+	return rc;
+}
diff --git a/libsepol/cil/src/cil_deny.h b/libsepol/cil/src/cil_deny.h
new file mode 100644
index 00000000..f22e8bf1
--- /dev/null
+++ b/libsepol/cil/src/cil_deny.h
@@ -0,0 +1,36 @@
+/*
+ * This file is public domain software, i.e. not copyrighted.
+ *
+ * Warranty Exclusion
+ * ------------------
+ * You agree that this software is a non-commercially developed program
+ * that may contain "bugs" (as that term is used in the industry) and
+ * that it may not function as intended. The software is licensed
+ * "as is". NSA makes no, and hereby expressly disclaims all, warranties,
+ * express, implied, statutory, or otherwise with respect to the software,
+ * including noninfringement and the implied warranties of merchantability
+ * and fitness for a particular purpose.
+ *
+ * Limitation of Liability
+ *-----------------------
+ * In no event will NSA be liable for any damages, including loss of data,
+ * lost profits, cost of cover, or other special, incidental, consequential,
+ * direct or indirect damages arising from the software or the use thereof,
+ * however caused and on any theory of liability. This limitation will apply
+ * even if NSA has been advised of the possibility of such damage. You
+ * acknowledge that this is a reasonable allocation of risk.
+ *
+ * Original author: James Carter
+ */
+
+#ifndef CIL_DENY_H_
+#define CIL_DENY_H_
+
+int cil_classperms_list_match_any(const struct cil_list *cpl1, const struct cil_list *cpl2);
+int cil_classperms_list_match_all(const struct cil_list *cpl1, const struct cil_list *cpl2);
+void cil_classperms_list_copy(struct cil_list **new, const struct cil_list *old);
+void cil_classperms_list_and(struct cil_list **result, const struct cil_list *cpl1, const struct cil_list *cpl2);
+void cil_classperms_list_andnot(struct cil_list **result, const struct cil_list *cpl1, const struct cil_list *cpl2);
+int cil_process_deny_rules_in_ast(struct cil_db *db);
+
+#endif /* CIL_DENY_H_ */
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index a7c66ead..da97a392 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -47,6 +47,7 @@
 #include "cil_policy.h"
 #include "cil_verify.h"
 #include "cil_symtab.h"
+#include "cil_deny.h"
 
 #define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
 #define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/src/module_to_cil.c */
@@ -2551,6 +2552,12 @@ int cil_post_process(struct cil_db *db)
 		goto exit;
 	}
 
+	rc = cil_process_deny_rules_in_ast(db);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to process deny rules\n");
+		goto exit;
+	}
+
 	rc = cil_post_verify(db);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Failed to verify cil database\n");
-- 
2.39.2

