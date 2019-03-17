Return-Path: <SRS0=VGN0=RU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7261AC4360F
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BAD21019
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 13:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCQNr1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Mar 2019 09:47:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40913 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCQNr0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Mar 2019 09:47:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id u10so7596741wmj.5
        for <selinux@vger.kernel.org>; Sun, 17 Mar 2019 06:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8wLuZVbRgRDLrB9NjHoNttBS7CXMpzCE02UZmbtXvk=;
        b=es2vfu5X9cp5prF/yqUu06dJXYr6gaJSpbdaQplJh8sP3OPL7n64x+k6V9KB3CFIIp
         M5WmfIeeFPwa6zjOVhMZtkOtX9n2Yc1dgAj1H/BnzuTMwaL3fhGVR9KNKxpLkvmVuuYb
         gN8uUO4xnYfZ17JPVD7hIqEFbsv06zSXPloZqw5IRPVtVnhmTZW5C1+6Xq8/tNlb+rps
         9h6c16rlkCmgbNmUYXthK07xZdv3sXCxnFq9qk6dKmWcJA2Jwr+x5q2BNDKP+zPPj88X
         AcQP25I4SQ4lVtHZj0UT7J7LQDOBrp7Dg+6ffClmI1sLSVEQ26j/WxaIl3l5O4pMjhia
         qA+Q==
X-Gm-Message-State: APjAAAUIMjeHtqboCXvwNabnGID8CHlIV7b68/dRhTQWZ2fuLxk6Fkgb
        w4dg9zhfSvqwtuJt/G7ZZD9ed1Dwx50=
X-Google-Smtp-Source: APXvYqxoCNUDvVFN9R+9ALdK8WLtRdxFUnWVWWqVLIviDgZjzV8ZtxPVr0BFns5rc615fbK0eby+LA==
X-Received: by 2002:a1c:f014:: with SMTP id a20mr7824469wmb.122.1552830444185;
        Sun, 17 Mar 2019 06:47:24 -0700 (PDT)
Received: from localhost.localdomain (bband-dyn196.178-41-14.t-com.sk. [178.41.14.196])
        by smtp.gmail.com with ESMTPSA id 132sm13224790wmd.30.2019.03.17.06.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 06:47:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>,
        syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com
Subject: [PATCH] selinux: fix NULL dereference in policydb_destroy()
Date:   Sun, 17 Mar 2019 14:46:53 +0100
Message-Id: <20190317134653.26824-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The conversion to kvmalloc() forgot to account for the possibility that
p->type_attr_map_array might be null in policydb_destroy().

Fix this by destroying its contents only if it is not NULL.

Also make sure ebitmap_init() is called on all entries before
policydb_destroy() can be called. Right now this is a no-op, because
both kvcalloc() and ebitmap_init() just zero out the whole struct, but
let's rather not rely on a specific implementation.

Reported-by: syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com
Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

NOTE: This applies directly on top of current Linus' tree, since the
problematic commit is not present in the selinux/stable-5.1 branch.

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6b576e588725..daecdfb15a9c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -828,9 +828,11 @@ void policydb_destroy(struct policydb *p)
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
 
-	for (i = 0; i < p->p_types.nprim; i++)
-		ebitmap_destroy(&p->type_attr_map_array[i]);
-	kvfree(p->type_attr_map_array);
+	if (p->type_attr_map_array) {
+		for (i = 0; i < p->p_types.nprim; i++)
+			ebitmap_destroy(&p->type_attr_map_array[i]);
+		kvfree(p->type_attr_map_array);
+	}
 
 	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
@@ -2496,10 +2498,13 @@ int policydb_read(struct policydb *p, void *fp)
 	if (!p->type_attr_map_array)
 		goto bad;
 
+	/* just in case ebitmap_init() becomes more than just a memset(0): */
+	for (i = 0; i < p->p_types.nprim; i++)
+		ebitmap_init(&p->type_attr_map_array[i]);
+
 	for (i = 0; i < p->p_types.nprim; i++) {
 		struct ebitmap *e = &p->type_attr_map_array[i];
 
-		ebitmap_init(e);
 		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
 			rc = ebitmap_read(e, fp);
 			if (rc)
-- 
2.20.1

