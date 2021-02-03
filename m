Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27600C433E6
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEB164F74
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhBCI7k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:59:40 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:43957 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhBCI7j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:59:39 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AD4665648FF
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 09:58:56 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: remove unused files
Date:   Wed,  3 Feb 2021 09:58:44 +0100
Message-Id: <20210203085846.6680-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  3 09:58:56 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

libsepol/src/roles.c contains functions which do not match its header
file libsepol/include/sepol/roles.h:

    // In roles.c
    int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
                          sepol_policydb_t * p, const char *role, int *response)
    // In roles.h
    extern int sepol_role_exists(const sepol_policydb_t * policydb,
                                 const char *role, int *response);

and:

    // In roles.c
    int sepol_role_list(sepol_handle_t * handle,
                        sepol_policydb_t * p, char ***roles, unsigned int *nroles)
    // In roles.h
    extern int sepol_role_list(const sepol_policydb_t * policydb,
                               char ***roles, unsigned int *nroles);

Instead of fixing the parameter type (using sepol_handle_t or
sepol_policydb_t but not different ones), remove these functions, as
they appear not to be used. They are not exported in libsepol.so.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/include/sepol/roles.h | 18 ------------
 libsepol/src/roles.c           | 53 ----------------------------------
 2 files changed, 71 deletions(-)
 delete mode 100644 libsepol/include/sepol/roles.h
 delete mode 100644 libsepol/src/roles.c

diff --git a/libsepol/include/sepol/roles.h b/libsepol/include/sepol/roles.h
deleted file mode 100644
index e750078c8dab..000000000000
--- a/libsepol/include/sepol/roles.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef _SEPOL_ROLES_H_
-#define _SEPOL_ROLES_H_
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-extern int sepol_role_exists(const sepol_policydb_t * policydb,
-			     const char *role, int *response);
-
-extern int sepol_role_list(const sepol_policydb_t * policydb,
-			   char ***roles, unsigned int *nroles);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/libsepol/src/roles.c b/libsepol/src/roles.c
deleted file mode 100644
index 4540cee80e19..000000000000
--- a/libsepol/src/roles.c
+++ /dev/null
@@ -1,53 +0,0 @@
-#include <stdlib.h>
-#include <string.h>
-
-#include <sepol/policydb/hashtab.h>
-#include <sepol/policydb/policydb.h>
-
-#include "debug.h"
-#include "handle.h"
-
-/* Check if a role exists */
-int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
-		      sepol_policydb_t * p, const char *role, int *response)
-{
-
-	policydb_t *policydb = &p->p;
-	*response = (hashtab_search(policydb->p_roles.table, role) != NULL);
-
-	return STATUS_SUCCESS;
-}
-
-/* Fill an array with all valid roles */
-int sepol_role_list(sepol_handle_t * handle,
-		    sepol_policydb_t * p, char ***roles, unsigned int *nroles)
-{
-
-	policydb_t *policydb = &p->p;
-	unsigned int tmp_nroles = policydb->p_roles.nprim;
-	char **tmp_roles = (char **)malloc(tmp_nroles * sizeof(char *));
-	char **ptr;
-	unsigned int i;
-	if (!tmp_roles)
-		goto omem;
-
-	for (i = 0; i < tmp_nroles; i++) {
-		tmp_roles[i] = strdup(policydb->p_role_val_to_name[i]);
-		if (!tmp_roles[i])
-			goto omem;
-	}
-
-	*nroles = tmp_nroles;
-	*roles = tmp_roles;
-
-	return STATUS_SUCCESS;
-
-      omem:
-	ERR(handle, "out of memory, could not list roles");
-
-	ptr = tmp_roles;
-	while (ptr && *ptr)
-		free(*ptr++);
-	free(tmp_roles);
-	return STATUS_ERR;
-}
-- 
2.30.0

