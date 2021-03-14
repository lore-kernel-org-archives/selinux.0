Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A3FC4332E
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6AC64EBD
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhCNUSZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:18:25 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48312 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhCNURx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 16:17:53 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 665A05646B4
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 21:17:52 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 6/6] libsepol/cil: do not leak avrulex_ioctl_table memory when an error occurs
Date:   Sun, 14 Mar 2021 21:16:51 +0100
Message-Id: <20210314201651.474432-6-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314201651.474432-1-nicolas.iooss@m4x.org>
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 21:17:52 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

OSS-Fuzz found a memory leak when trying to compile the following
policy:

    (class CLASS (PERM ioctl))
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

    (permissionx ioctl_test (ioctl CLASS (and (range 0x1600 0x19FF) (not (range 0x1750 0x175F)))))
    (allowx TYPE TYPE ioctl_test)

    (boolean BOOLEAN false)

    (booleanif (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (not (xor (eq BOOLEAN BOOLEAN)
                (and (eq BOOLEAN BOOLEAN) BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
                BOOLEAN ) ) )
        (true
            (allow TYPE TYPE (CLASS (PERM)))
        )
    )

When the CIL compiler reports "Conditional expression exceeded max
allowable depth" because of the loooooong expression in the booleanif
statement, cil_binary_create_allocated_pdb returns without freeing the
memory which was allocated to store the keys and values of hash table
avrulex_ioctl_table.

Fix this by moving the freeing logic to a dedicated destructor function
and calling it in the exit block of cil_binary_create_allocated_pdb.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28618
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index f80d84679f85..18532aad9801 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1668,14 +1668,6 @@ exit:
 		}
 		cil_list_destroy(&xperms_list, CIL_FALSE);
 	}
-
-	// hashtab_t does not have a way to free keys or datum since it doesn't
-	// know what they are. We won't need the keys/datum after this function, so
-	// clean them up here.
-	free(avtab_key);
-	ebitmap_destroy(datum);
-	free(datum);
-
 	return rc;
 }
 
@@ -1885,6 +1877,15 @@ exit:
 	return rc;
 }
 
+static int __cil_avrulex_ioctl_destroy(hashtab_key_t k, hashtab_datum_t datum, __attribute__((unused)) void *args)
+{
+	free(k);
+	ebitmap_destroy(datum);
+	free(datum);
+
+	return SEPOL_OK;
+}
+
 int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
 {
 	int rc;
@@ -5037,6 +5038,7 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 
 exit:
 	hashtab_destroy(role_trans_table);
+	hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy, NULL);
 	hashtab_destroy(avrulex_ioctl_table);
 	free(type_value_to_cil);
 	free(class_value_to_cil);
-- 
2.30.2

