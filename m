Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F534C433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1980564E99
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhCPUs1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhCPUq5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 16:46:57 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09291C061756
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:46:57 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id t16so325174qvr.12
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRBz0TmwQUZDHrXeDqZKEcQG5wdjJ6pae6s147KCb/Q=;
        b=j3UrUBdibL2E5mjMPmwG+ngR+zO7sifSgVrWEg1tGKOFgz2Wvim8fq1xWvZJDuJVn6
         EV9o9R7oCQKLmjBU0JSA3QXJ+OWBQNvbZm+FryqLRLhnxAjmay/xwXsF3F+C86Yb+B97
         yysP+glE03egU/lmisHrnK/hGGtG6jd9gNLEVAt271w4XF3NWeMDI/0wq4FERRZfQFzX
         ws3IZiHhMI48TygTwKfQ7+fTydDkH1Ueeo+VQU9ISUVqpuDPRlVn63rm6Em2ue4PsJcp
         9FPKC9zirUH+NFHfGf6csk8ql7pKkbgB4o41H3irsnwSU+Uw2dw/KMX6SG+4d/qi1xmD
         Umlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRBz0TmwQUZDHrXeDqZKEcQG5wdjJ6pae6s147KCb/Q=;
        b=qq8+CsZRtTqSQp8ScW+7lQBWhK54HGIjdaWGflGw5q1tL1g2NfwGOZFWqVaMELBnzy
         BZ8LEIQBfAlyr/cyS2MEmHfPA3WMODvSSBV/wuBkN67oOn4YRRm9WF/3bkoifHXxovO5
         dZVZXHabcmSRK3YNsL+fOQiumSk1wdWeO+lNycY9WzKSBKagInI9JqHlzWaoEPKOuj9i
         Nr4XCdlNatnfykMceQENQaOM3e+p3jJRa5xY1VVCGbFJatqkcX9W4lMvLE7ALPgrZkcZ
         yBTiwbQ3z1ZRFxtLhCU+3zx+Jb+AgDngFOZsNF+fHtwOOHmoMKlVRGX4w2PRki5S7J5U
         1daQ==
X-Gm-Message-State: AOAM530ySiLFkWl9rhTYM9Iea+yRZ5sKQwh1YE4K7K05U+O7A9xkj77Q
        Cn68TljHfFPnMRx117kciXXixdB4m/0=
X-Google-Smtp-Source: ABdhPJzNOekUqYCmF35Bb9+K6r5GLp1CwG/vBNeOgfPPsCOcKXoYrJGJ0oEmAZqqkQTBe6prR2SCTw==
X-Received: by 2002:ad4:4745:: with SMTP id c5mr1412134qvx.39.1615927616165;
        Tue, 16 Mar 2021 13:46:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v4sm13905687qte.18.2021.03.16.13.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:46:55 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/4] libsepol/cil: Allow lists in constraint expressions
Date:   Tue, 16 Mar 2021 16:46:43 -0400
Message-Id: <20210316204646.52060-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The expectation in CIL was to use user, role, or type attributes in
constraint expressions. The problem is that neither user nor role
attributes are part of the kernel binary policy, so when converting
from a kernel policy to CIL, that would require the creation of a
role or user attribute. The better solution is to just allow a list
to be used. In fact, the only thing preventing a list to be used
is a check in cil_verify_constraint_leaf_expr_syntax().

Remove the check and allow lists in constraint expressions.

The following is now allowed:
  (constrain (CLASS1 (PERM1)) (eq r1 (ROLE1 ROLE2 ROLE_ATTR3)))

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_verify.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 6706e219..09e3daf9 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -225,9 +225,6 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
 				cil_log(CIL_ERR, "u3, r3, and t3 can only be used with (mls)validatetrans rules\n");
 				goto exit;
 			}
-		} else if (r_flavor == CIL_LIST) {
-			cil_log(CIL_ERR, "t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side\n");
-			goto exit;
 		}
 	} else {
 		if (r_flavor == CIL_CONS_U2) {
-- 
2.26.2

