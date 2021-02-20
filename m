Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3720C433DB
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76F76023B
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 19:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBTTIy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 20 Feb 2021 14:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTTIx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 20 Feb 2021 14:08:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E76C061574
        for <selinux@vger.kernel.org>; Sat, 20 Feb 2021 11:08:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g5so22274290ejt.2
        for <selinux@vger.kernel.org>; Sat, 20 Feb 2021 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OlPh7/xjqqfg0k/5mxSVky2GJ+6MBbZ05KWeQSUg74U=;
        b=u949/LEmotPwEwc33KyVxUpAIKmq9E6znD7eerW+tpGBazCCodiURX69Fw0bCE+YRW
         FJ1jEsG/x1sOO0bHCCwbEInsyOn2ARCYjsqGecRfXS8itiQJ3BUvqX5W3sfzJ/iR3sHT
         tR8wFfmfJtCUZTuUPlzt46Dcx46PIaWhof+VUaxjbBNpDZYJ8FbhHe2ZsEmlayn1eKgw
         gRjdj+u3XJAhhMIBO9mpehpkB2L+moBb8qEY/K2AhiiSSvVZjOl4ruVQ9Fgsuqvph5Rh
         lR3uy6LGA3JvDC6sMYbphZYvTBFyj4z9NI36RyixZhIIFr6trjwDjnFbA2FFjM+JweJU
         Uhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OlPh7/xjqqfg0k/5mxSVky2GJ+6MBbZ05KWeQSUg74U=;
        b=jVpk7SCuPI5RrTt+ga/jjUUnBb4DXMLK5WUtf3T7UWGXLMyMQdJxzAVtwSmBuKy6Jj
         Bo2Hwr13I2/KPfbdzvSwSHfbw35Pa0eaeGQiuIPsEeHbCT0iIjf+k8dtv1W27mHi4G9f
         0ZtIbI/hRsABRFhfeIw/bE2lrV7XIp0WV9444P5Itn2EeaF/0vxi+P9NMqlCbAiBjPy+
         kWdWvB28BPANHtzzUGDV/jnK+haiSyO+sJb402I+IG8n4Dsmwwfj9fOTztF02xwiRR8j
         ptQM2cauS1purhHgy+PKKuLoOEbrYdpc/SV/94qvYb9Zlta+yPmdBIx2RaBkSdbvJjkn
         +6Ww==
X-Gm-Message-State: AOAM533gongKzMACLd3v+50PAFpiT79G7D2mkycMnj5NVYH4IhJneYMZ
        TLkLrOOWpNXEica3Af/Enb9GM0V48LL5SA==
X-Google-Smtp-Source: ABdhPJxRJ+TE08OtzWuWMJ+khL/AFBs2JeOU0b9VuRyLqVOXTLPsoqvWRhkCNgP+H9JXnyE8husYzQ==
X-Received: by 2002:a17:906:b198:: with SMTP id w24mr6411905ejy.62.1613848092213;
        Sat, 20 Feb 2021 11:08:12 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-085-022.77.0.pool.telefonica.de. [77.0.85.22])
        by smtp.gmail.com with ESMTPSA id r5sm6920515ejd.113.2021.02.20.11.08.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:08:11 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: handle SID without assigned context when writing policy.conf
Date:   Sat, 20 Feb 2021 20:08:06 +0100
Message-Id: <20210220190806.22139-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL permits not assigning a context to a SID, e.g. to an unused initial
SID, e.g. 'any_socket'.

When using the example policy from the SELinux Notebook,
https://github.com/SELinuxProject/selinux-notebook/blob/main/src/notebook-examples/cil-policy/cil-policy.cil,
secilc logs:

    No context assigned to SID any_socket, omitting from policy at cil-policy.cil:166

But secil2conf segfaults when writing the policy.conf:

    ../cil/src/cil_policy.c:274:2: runtime error: member access within null pointer of type 'struct cil_context'

Only print the assigned context if actually available.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_policy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 30d507f1..863636c7 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1661,7 +1661,9 @@ static void cil_sid_contexts_to_policy(FILE *out, struct cil_list *sids, int mls
 	cil_list_for_each(i1, sids) {
 		sid = i1->data;
 		fprintf(out, "sid %s ", sid->datum.fqn);
-		cil_context_to_policy(out, sid->context, mls);
+		if (sid->context) {
+			cil_context_to_policy(out, sid->context, mls);
+		}
 		fprintf(out,"\n");
 	}
 }
-- 
2.30.1

