Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2256C433DB
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985D964FB2
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhCJTak (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCJTaZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Mar 2021 14:30:25 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E75C061760
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 11:30:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 2so13994184qtw.1
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhqtzYfhBfor3fVjBKW+Zm3kIoRtru60tUVC0UqLAZk=;
        b=Lo6MQiYHYrC/xjz4tTst0tw6RmQVeAUa2DrcaW9vscV3s7f7AhQVThErLV5vt9l9Il
         ALfDU0o8qDbI76IOjrVmjDuxrbtHLbSZ/zb84+9cdNKlMziAIL7dCisG/NgrmZM8u0pN
         5lnEh7EBWdjwrewvVD3MRwLlaWnlx942aiiwXiWIlW9PariLQJ64pcSx53mJK6yPORap
         5dw42cFABKjch3sUcDYu5ilZmfeKJBYj+qUp//ect0z/3HI2sF1mrDN/9NNVL+ChpaiQ
         zgfljHZMZAYRfk6S6Ir2vjs8ShRGwesGV2zAH0NXVBol/LrwQHjuasXyaJDBJ9QDsYWA
         ALAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhqtzYfhBfor3fVjBKW+Zm3kIoRtru60tUVC0UqLAZk=;
        b=ghDPQ8Yo1vUS9P564g0NHMnd8AsYTxdz1SOM5/OKZ6ZT9u9qnGCEHJewFzqT4Ia7F/
         B4UeTUdPklTLO2nTpT7It7BlLFhHdX1uX9EH0ncUt9w7WQTuc1jnav+WQH1ebM3qglsd
         GSqQbBIJCNd5tQayWUA6on/51ad62wkJ+SUFOF7DbYhVrwEYZjxoh8Cdd2TLsHnKYc9s
         QzsN3Pb4u4l0cXJ0a5kEH5y/5O717bL82SCTv8txUBreIESfYk0CMd165Nhwnd2Fmtlu
         ZXUBiLiTDelU6x6kM5nGsC0u+AoY3r52xRViYn9/vRxApCwNOIT0kvIaEwFhNn3n92Rs
         2nLg==
X-Gm-Message-State: AOAM533JPH5iFJyVvE7Yd0k/CWKRDrAxp4LJ10QnIEqCO5VAIDLCfakL
        J+ysCAsBoIqS+sHTl33z3duTbhZWHSw=
X-Google-Smtp-Source: ABdhPJwk3NLgDtvtTfYRdU/DaLyaWrKC18uUSNfaEl6IYxmbJEde6oQ7D/2H4nRR/3c+lx7e1qAvbQ==
X-Received: by 2002:ac8:1405:: with SMTP id k5mr4339646qtj.262.1615404622044;
        Wed, 10 Mar 2021 11:30:22 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d23sm178816qka.125.2021.03.10.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:30:21 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: Expand role attributes in constraint expressions
Date:   Wed, 10 Mar 2021 14:30:12 -0500
Message-Id: <20210310193012.166256-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When creating the kernel binary policy, role attributes in constraint
expressions are not expanded. This causes the constraint expression
to refer to a non-existent role in the kernel policy. This can lead
to a segfault when converting the binary policy back to conf or CIL
source or when using policy tools such as seinfo.

Expand role attributes in constraint expressions when creating the
kernel binary policy.

Reported-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index eac7e450..2d9cb566 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -71,6 +71,38 @@ static int map_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * map)
 	return 0;
 }
 
+static int ebitmap_expand_roles(policydb_t *p, ebitmap_t *roles)
+{
+	ebitmap_node_t *node;
+	unsigned int bit;
+	role_datum_t *role;
+	ebitmap_t tmp;
+
+	ebitmap_init(&tmp);
+	ebitmap_for_each_positive_bit(roles, node, bit) {
+		role = p->role_val_to_struct[bit];
+		assert(role);
+		if (role->flavor != ROLE_ATTRIB) {
+			if (ebitmap_set_bit(&tmp, bit, 1)) {
+				ebitmap_destroy(&tmp);
+				return -1;
+			}
+		} else {
+			if (ebitmap_union(&tmp, &role->roles)) {
+				ebitmap_destroy(&tmp);
+				return -1;
+			}
+		}
+	}
+	ebitmap_destroy(roles);
+	if (ebitmap_cpy(roles, &tmp)) {
+		ebitmap_destroy(&tmp);
+		return -1;
+	}
+	ebitmap_destroy(&tmp);
+	return 0;
+}
+
 static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -333,6 +365,9 @@ static int constraint_node_clone(constraint_node_t ** dst,
 					if (map_ebitmap(&expr->names, &new_expr->names, state->rolemap)) {
 						goto out_of_mem;
 					}
+					if (ebitmap_expand_roles(state->out, &new_expr->names)) {
+						goto out_of_mem;
+					}
 				} else if (new_expr->attr & CEXPR_USER) {
 					if (map_ebitmap(&expr->names, &new_expr->names, state->usermap)) {
 						goto out_of_mem;
-- 
2.26.2

