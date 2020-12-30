Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF3C43381
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35901221F8
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 10:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL3KIj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 05:08:39 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38266 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3KIi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 05:08:38 -0500
Received: from localhost.localdomain (174.17.206.77.rev.sfr.net [77.206.17.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E6B68565ABF
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 11:07:56 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/6] libsepol: ensure that hashtab_search is not called with a NULL key
Date:   Wed, 30 Dec 2020 11:07:42 +0100
Message-Id: <20201230100746.2549568-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 11:07:57 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While fuzzing /usr/libexec/hll/pp, a policy module was generated which
triggered a NULL result when doing:

    key = pdb->sym_val_to_name[sym][i];

Detect such unexpected behavior to exit with an error instead of
crashing.

This issue has been found while fuzzing hll/pp with the American Fuzzy
Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index c99790eb76e7..99360a9afdd0 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3459,6 +3459,10 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 		map = decl->required.scope[sym];
 		ebitmap_for_each_positive_bit(&map, node, i) {
 			key = pdb->sym_val_to_name[sym][i];
+			if (key == NULL) {
+				rc = -1;
+				goto exit;
+			}
 
 			scope_datum = hashtab_search(pdb->scope[sym].table, key);
 			if (scope_datum == NULL) {
-- 
2.29.2

