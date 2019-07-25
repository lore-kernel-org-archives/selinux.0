Return-Path: <SRS0=pD7g=VW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA3C7618B
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 10:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0424B218DA
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 10:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfGYKws (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:52:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53539 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfGYKws (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Jul 2019 06:52:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so44551270wmj.3
        for <selinux@vger.kernel.org>; Thu, 25 Jul 2019 03:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1Bjt8+Ll+clH1XfAwMheIIcZAXei7lLBKhpDlOqq9g=;
        b=KUg4CY0j8Pag3pQhOVxCtr0nyPtCw+GvDGQshEy+cbqSiGueIL7WiutuN45wA1sk1S
         ciRowt1f5p5Gq9FP95+xKq+pqLAvJAwH77gpL4/HogpraBVYgDuM3DHxMk2y3HMvcrWe
         t/Aw5hvOaubEvxKPmX3Czs46qI/bpwRcgWJjvKUpM5c/+MEUovp0n+kfD4FEY2+iiC3h
         AUFoJg71XrcSRhxdi9kG4Dtd1QYq9qcfWxd/uTN0/6QJGSwug6xNxPAmRsi6p7e5ckb4
         2BtPecJg7jJtxSSilG6V387TRlOb+5LujlQPZdDBMkkJjKf8JPa2xqYCkbtB8JKLBs+9
         T60w==
X-Gm-Message-State: APjAAAW7LrDrUH11nbc7KzHeWQzukZ/rMOeo7fYQbGDrDCqY4dRyHxuT
        62QkWvuVlDrSjObm6EqNcnCMjw9K+NQRLw==
X-Google-Smtp-Source: APXvYqzNzb90vkhztwN8bvckZwbeK72rBHQUSJstqnMGH6TTnMv1DBEEJt4LEjfg7ti2aPeVf/OhHA==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr81497309wme.177.1564051966237;
        Thu, 25 Jul 2019 03:52:46 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y1sm36990792wma.32.2019.07.25.03.52.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:52:45 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Subject: [PATCH] selinux: fix memory leak in policydb_init()
Date:   Thu, 25 Jul 2019 12:52:43 +0200
Message-Id: <20190725105243.28404-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since roles_init() adds some entries to the role hash table, we need to
destroy also its keys/values on error, otherwise we get a memory leak in
the error path.

Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index daecdfb15a9c..38d0083204f1 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -274,6 +274,8 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return v;
 }
 
+static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap);
+
 /*
  * Initialize a policy database structure.
  */
@@ -321,8 +323,10 @@ static int policydb_init(struct policydb *p)
 out:
 	hashtab_destroy(p->filename_trans);
 	hashtab_destroy(p->range_tr);
-	for (i = 0; i < SYM_NUM; i++)
+	for (i = 0; i < SYM_NUM; i++) {
+		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
 		hashtab_destroy(p->symtab[i].table);
+	}
 	return rc;
 }
 
-- 
2.21.0

