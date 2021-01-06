Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B699AC4332B
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914D62311E
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbhAFIUX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:20:23 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37348 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAFIUX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 03:20:23 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 492C35613BD
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 09:19:40 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: destroy filename_trans list properly
Date:   Wed,  6 Jan 2021 09:19:22 +0100
Message-Id: <20210106081922.450743-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 09:19:40 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

OSS-Fuzz found a direct memory leak in policydb_filetrans_insert()
because filenametr_destroy() does not fully destroy the list associated
with a typetransition.

More precisely, let's consider this (minimized) CIL policy:

    (class CLASS (PERM))
    (classorder (CLASS))
    (sid SID)
    (sidorder (SID))
    (user USER)
    (role ROLE)
    (type TYPE) ; "type 1" in libsepol internal structures
    (type TYPE2) ; "type 2" in libsepol internal structures
    (type TYPE3) ; "type 3" in libsepol internal structures
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

    (typetransition TYPE2 TYPE CLASS "some_file" TYPE2)
    (typetransition TYPE3 TYPE CLASS "some_file" TYPE3)

The two typetransition statements make policydb_filetrans_insert()
insert an item with key {ttype=1, tclass=1, name="some_file"} in the
hashmap p->filename_trans. This item contains a linked list of two
filename_trans_datum_t elements:

* The first one uses {otype=2, stypes=bitmap containing 2}
* The second one uses {otype=3, stypes=bitmap containing 3}

Nevertheless filenametr_destroy() (called by
hashtab_map(p->filename_trans, filenametr_destroy, NULL);) only frees
the first element. Fix this memory leak by freeing all elements.

This issue was introduced by commit 42ae834a7428 ("libsepol,checkpolicy:
optimize storage of filename transitions") and was never present in the
kernel, as filenametr_destroy() was modified appropriately in commit
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29138
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f43d5c67463e..71ada42ca609 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1462,12 +1462,16 @@ static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 			      void *p __attribute__ ((unused)))
 {
 	filename_trans_key_t *ft = (filename_trans_key_t *)key;
-	filename_trans_datum_t *fd = datum;
+	filename_trans_datum_t *fd = datum, *next;
 
 	free(ft->name);
 	free(key);
-	ebitmap_destroy(&fd->stypes);
-	free(datum);
+	do {
+		next = fd->next;
+		ebitmap_destroy(&fd->stypes);
+		free(fd);
+		fd = next;
+	} while (fd);
 	return 0;
 }
 
-- 
2.30.0

