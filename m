Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8AEB64D7
	for <selinux@archiver.kernel.org>; Fri, 16 Jun 2023 22:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFPWC4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjFPWCz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Jun 2023 18:02:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A9119
        for <selinux@vger.kernel.org>; Fri, 16 Jun 2023 15:02:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62de557711eso10485856d6.3
        for <selinux@vger.kernel.org>; Fri, 16 Jun 2023 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686952973; x=1689544973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhiJ1JbxJFbkvt19H+LCVa2J4zY+LlCmt3X1pRG4Puo=;
        b=PyTlDd933eezcAW4qgW6CC1cdd8H5m1P6OW0VqqPx7/zFqOmJgpD3NKyljT/dgDxE0
         qsuHqgFIdhcMPmZ7Om5HHFpn0Ev1njQqH2ftjQ6lmoXG1S0OnmZK7liNlpuDCfqyYaLF
         uhnlXKfMmKg5PwDKcQ0xf5oCpKwYb6uBF3xBfYshkyyL1s3A00h5oLQicUcmFnfd5VM+
         l5/N5OJ4SrLZJy0rtblTpMzTmIo04tnfeaegQs7gmY+vtOdMEEzf2EkZtiDXwt+Zz9PB
         xUBtxS/IDwP2tGUPyDJzf48kQXgOLGf77b7LlNRuTD17WYvaVzctpIIyR2HOwORyAIMU
         YOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686952973; x=1689544973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhiJ1JbxJFbkvt19H+LCVa2J4zY+LlCmt3X1pRG4Puo=;
        b=USXsU2NuNVrXi7vbXml8xkzl8tXAi/Vm7d58PoXGYeBZtpjX8hFVzRjT0agsGqSKXf
         ujM5pZhbWVKLdsJTu7cXTTHFz2wXStSW0AbMqnlaQJJxQseEX6nA6SVBH3WqKMJxlPii
         IMJ7ICGtFsV7RdQ5607SJfM/YOdJUxZYmlDZVPOtb8vh63xkvXe9YRXGLmqHyAKbdzQ9
         GUkpExgVny3CPrJ3p2FxNiP3pKsdcC7zV7CHDW1yWXSo/eHZ2dM1SKKIVl9xUNR6U49G
         74l0JLtnLcBd+Zm2bPIZqy+3B7WuwvBBTp3xCF0skq9EZxPrvefDkYwP6JzT4mrV9PJJ
         CknA==
X-Gm-Message-State: AC+VfDxCGyByqzDKvnpYWSbsepTAfiKxW4vTOurlA16VlvvhnY5LUMsN
        bJFcNKNH7kLo10VTLDt7DCSgEp3ZThHVgEl/fA==
X-Google-Smtp-Source: ACHHUZ7IVrTKeWvuvkFzvkNz5uLnBlAhzsTvegwuvLRjUs9pGf9JTSIrL6pAfZe30o6s0GbLMuTplA==
X-Received: by 2002:ad4:5d64:0:b0:5e0:e52c:5d7a with SMTP id fn4-20020ad45d64000000b005e0e52c5d7amr3729472qvb.38.1686952973454;
        Fri, 16 Jun 2023 15:02:53 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id iw13-20020a0562140f2d00b00630011ea80csm749249qvb.10.2023.06.16.15.02.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 15:02:53 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: cleanup the policycap accessor functions
Date:   Fri, 16 Jun 2023 18:02:43 -0400
Message-ID: <20230616220242.340763-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=paul@paul-moore.com; h=from:subject; bh=Xia1TQI4S2u7+DKPJk+h9WCdzd55+gTqLYvv7F/TwVo=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBkjNwDtz0oASoBr03WTRBEHegU9vToz0hZI3QHj W7n7kTO5PGJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZIzcAwAKCRDqIPLalzeJ c6cFEACDR8RtkLmBIH4iPMjz3zya/Y6ryMIJI6FVfBr7tJpigANBEal+SnqmbD+oQxod9e+oam0 rHo+EPjucFNB4gGhtkiJ0p8vq7VkETahzdFUL4owazViJYKFZHXGhsKjY4nZ401FLJRNSdB/KnG kowP7Actj5kwkfzivIC9uu9rFQ/tCW9ofstJjWrVP+/KINSFO7v32eZN1C2uNlv14lBfH+CiGUp 4gj6qp43EBGIybybu/dMhBu97/MoVB/1G7Bk1yFyhlOKnynZ5UkU0M/s/p918Q2pSIs4lyZLUWe PflQWq14pL421zKBY3EazDXSSWiJhm5Z5+CRhmV6OeVEvlkyHLv+V+GQdNll9W9FscvP3UNlQwv O/1Qe1MLhLB2pkpn8eJa7sfr2iXrCadnZv/S5ie81FGIbldCkqwMwSnhQXIaQaf2hs+SoicxMmd 9kSgaHvwNjRM4v+QK/yXlfr2LhOIoD+QNsTNVhjIkgl1Ow4H5dj+ZFA1fDwEGs2dAFPgvEecKWG qUMpVFRl/4Oq2QX1CJBSOENUXl6YUEu+VwVU9+am57j7NhMmUZMvyPKQH3zouXvKZjaVDx5aCtk G9YeLemRqfP/Gjk6LXYdiAX8APDvS50hdfdkM/JQoJ6UBKld5wlmkzahZJtSpwVyf9hlg1ZeE2k 8CAOATc2XMJ+bQw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the process of reverting back to directly accessing the global
selinux_state pointer we left behind some artifacts in the
selinux_policycap_XXX() helper functions.  This patch cleans up
some of that left-behind cruft.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/security.h | 35 +++++++++--------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 3b605f39e040..60eb161a0e5a 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -148,58 +148,45 @@ static inline bool checkreqprot_get(void)
 
 static inline bool selinux_policycap_netpeer(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_NETPEER]);
+	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_NETPEER]);
 }
 
 static inline bool selinux_policycap_openperm(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_OPENPERM]);
+	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_OPENPERM]);
 }
 
 static inline bool selinux_policycap_extsockclass(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_EXTSOCKCLASS]);
+	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_EXTSOCKCLASS]);
 }
 
 static inline bool selinux_policycap_alwaysnetwork(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_ALWAYSNETWORK]);
+	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_ALWAYSNETWORK]);
 }
 
 static inline bool selinux_policycap_cgroupseclabel(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_CGROUPSECLABEL]);
+	return READ_ONCE(selinux_state.policycap[POLICYDB_CAP_CGROUPSECLABEL]);
 }
 
 static inline bool selinux_policycap_nnp_nosuid_transition(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
 }
 
 static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
 }
 
 static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 {
-	struct selinux_state *state = &selinux_state;
-
-	return READ_ONCE(state->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
 struct selinux_policy_convert_data;
-- 
2.41.0

