Return-Path: <SRS0=AqYs=TE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E29FC43219
	for <selinux@archiver.kernel.org>; Sat,  4 May 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A3720449
	for <selinux@archiver.kernel.org>; Sat,  4 May 2019 19:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfEDT7J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 May 2019 15:59:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42115 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDT7J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 May 2019 15:59:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so12061045wrb.9
        for <selinux@vger.kernel.org>; Sat, 04 May 2019 12:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Drxo443mvMGapHZL6gPlWvNr7JrNFvNulNELabaRk3o=;
        b=m4U3Zf8h1aKCd6m31WL6AJNKbXVEgy9ZTPsIj54rzFzjuxul+Pl0xD8eKfCgwhq5oE
         SS9YK58B04dtWfEbE7QPg15dRYDfmbVOMmz/WjtpTjJP1gc9Pt4uH23Bj9uX6Nll3Ric
         oKIBcem0vuUOrVl2zuYdH+PgpAb2OgAtIS+tesLBqdzYWwflsa64U8CRQVyyikZ7QmPN
         DybsD6alA+bop7Pz136i5A6DE4alK0glNIF2hmtOeNYwS4ioVMNTcEK/9PhlSWAZ4Sdj
         eAZ0UCuyRvxlmf6Dg0iP1MngKFm3NYiCurwVfm8L6TzVbAgN915fhNrvCNW25UwnC5zr
         e3eQ==
X-Gm-Message-State: APjAAAXma7atQKpvQpKSO/gDD331Gdj9mwXFcyFkYUTXS+bALT+qLaT3
        b4jFbLexHGOetf/WQNzJlCDW5rlC0bQ=
X-Google-Smtp-Source: APXvYqx0Y6ElKb/fp5e94kwEz0zN+Ob9oEDbKytRaqDMVhZavbALqAkJcdxugu5uNNzhfAi7qV5wBQ==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr12113001wrs.265.1556999947519;
        Sat, 04 May 2019 12:59:07 -0700 (PDT)
Received: from localhost.localdomain.com (adsl-dyn106.91-127-30.t-com.sk. [91.127.30.106])
        by smtp.gmail.com with ESMTPSA id o8sm7964150wra.4.2019.05.04.12.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 12:59:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: remove some no-op BUG_ONs
Date:   Sat,  4 May 2019 21:59:06 +0200
Message-Id: <20190504195906.8146-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since acdf52d97f82 ("selinux: convert to kvmalloc"), these check whether
an address-of value is NULL, which is pointless.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cc043bc8fd4c..20a089d0aca8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -651,9 +651,7 @@ static void context_struct_compute_av(struct policydb *policydb,
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_AV | AVTAB_XPERMS;
 	sattr = &policydb->type_attr_map_array[scontext->type - 1];
-	BUG_ON(!sattr);
 	tattr = &policydb->type_attr_map_array[tcontext->type - 1];
-	BUG_ON(!tattr);
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
@@ -1059,9 +1057,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_XPERMS;
 	sattr = &policydb->type_attr_map_array[scontext->type - 1];
-	BUG_ON(!sattr);
 	tattr = &policydb->type_attr_map_array[tcontext->type - 1];
-	BUG_ON(!tattr);
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
-- 
2.20.1

