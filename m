Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E949DC433E6
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992E023102
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbhAFIJm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:09:42 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44704 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIJm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 03:09:42 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2429D564F64;
        Wed,  6 Jan 2021 09:08:59 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: ensure that decls hold consistent symbols when loading a binary policy
Date:   Wed,  6 Jan 2021 09:08:36 +0100
Message-Id: <20210106080836.344857-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 09:08:59 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While fuzzing /usr/libexec/hll/pp, a policy module was generated which
made "key" be NULL in required_scopes_to_cil() when doing:

    key = pdb->sym_val_to_name[sym][i];

This was caused by using a decl->required.scope[sym] bitmap which was
not consistent with the policy symbols.

Ensure this consistency when loading a binary policy by introducing a
new function which is called after policydb_index_others(), so that
p->sym_val_to_name[sym] can be used to check whether a symbol exists, in
a performent way (instead of searching the hash table
p->symtab[sym].table).

This issue has been found while fuzzing hll/pp with the American Fuzzy
Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
This replaces patch "libsepol: ensure that hashtab_search is not called
with a NULL key"
(https://lore.kernel.org/selinux/CAP+JOzQcM03WUJ-Fg2LuLxzCGiagJnuyJozv7ed6f34vnKEKXA@mail.gmail.com/T/#m059ac9bc2bdb9e4c436ebe3cef03124de25f1f06)

 libsepol/src/policydb.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6faaaa5895d0..f43d5c67463e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1209,6 +1209,51 @@ int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
 	return 0;
 }
 
+/*
+ * Verify the consistency of declarations, after the symbols were indexed
+ */
+int policydb_verify_decl_symbols(sepol_handle_t * handle, policydb_t * p)
+{
+	avrule_block_t *curblock;
+	avrule_decl_t *decl;
+	struct ebitmap_node *node;
+	unsigned int i, sym;
+
+	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
+		for (decl = curblock->branch_list; decl != NULL;
+		     decl = decl->next) {
+			for (sym = 0; sym < SYM_NUM; sym++) {
+				ebitmap_for_each_positive_bit(&decl->declared.scope[sym], node, i) {
+					if (i >= p->symtab[sym].nprim) {
+						ERR(handle, "too large value for symbol in declared scope %u: %u >= %u",
+						    decl->decl_id, i, p->symtab[sym].nprim);
+						return -1;
+					}
+					if (p->sym_val_to_name[sym][i] == NULL) {
+						ERR(handle, "invalid symbol %u in declared scope %u",
+						    i, decl->decl_id);
+						return -1;
+					}
+				}
+				ebitmap_for_each_positive_bit(&decl->required.scope[sym], node, i) {
+					if (i >= p->symtab[sym].nprim) {
+						ERR(handle, "too large value for symbol in required scope %u: %u >= %u",
+						    decl->decl_id, i, p->symtab[sym].nprim);
+						return -1;
+					}
+					if (p->sym_val_to_name[sym][i] == NULL) {
+						ERR(handle, "invalid symbol %u in required scope %u",
+						    i, decl->decl_id);
+						return -1;
+					}
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Define the other val_to_name and val_to_struct arrays
  * in a policy database structure.  
@@ -4501,6 +4546,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	if (policydb_index_others(fp->handle, p, verbose))
 		goto bad;
 
+	if (policydb_verify_decl_symbols(fp->handle, p))
+		goto bad;
+
 	if (ocontext_read(info, p, fp) == -1) {
 		goto bad;
 	}
-- 
2.30.0

