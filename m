Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13439C433DB
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 08:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B5D64DEF
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 08:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhB1Itp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 03:49:45 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:54703 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhB1Ito (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 03:49:44 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9C77E56127F
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 09:49:02 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: invalidate the pointer to the policydb if policydb_init fails
Date:   Sun, 28 Feb 2021 09:48:58 +0100
Message-Id: <20210228084858.8499-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 28 09:49:03 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Facebook's Infer static analyzer warns about a use-after-free issue in
libsemanage:

    int semanage_direct_mls_enabled(semanage_handle_t * sh)
    {
            sepol_policydb_t *p = NULL;
            int retval;

            retval = sepol_policydb_create(&p);
            if (retval < 0)
                    goto cleanup;

            /* ... */
    cleanup:
            sepol_policydb_free(p);
            return retval;
    }

When sepol_policydb_create() is called, p is allocated and
policydb_init() is called. If this second call fails, p is freed
andsepol_policydb_create() returns -1, but p still stores a pointer to
freed memory. This pointer is then freed again in the cleanup part of
semanage_direct_mls_enabled().

Fix this by setting p to NULL in sepol_policydb_create() after freeing
it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb_public.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
index e5def7078eb0..0218c9403856 100644
--- a/libsepol/src/policydb_public.c
+++ b/libsepol/src/policydb_public.c
@@ -68,6 +68,7 @@ int sepol_policydb_create(sepol_policydb_t ** sp)
 	p = &(*sp)->p;
 	if (policydb_init(p)) {
 		free(*sp);
+		*sp = NULL;
 		return -1;
 	}
 	return 0;
-- 
2.30.0

