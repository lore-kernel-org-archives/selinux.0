Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3416CC4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 17:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiLPRZg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 12:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiLPRZd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 12:25:33 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E5747DF
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 09:25:31 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id j16so3228132qtv.4
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhlp1DC5hTiFtQt2OfWjni9zO4NONCFR1Zagzq40oH8=;
        b=6t6nqyU8WXsRUDHXhVfoWGACqg69Wy4bhjreB0FcaQNN2y6N5VeTdoMGmrGuqEzfO/
         NvQp25QBciLChrlpWDDd6GpjbAm2KvSWe70zA27yhjXWb/A0fdeG0t6olWaD4C1L9fUE
         bpF/GuacFvfJ2wzk84tokM7sbLP3lgs4uUAfb9fO1Vq+Hxdd4jWAewXFDwAATvZx8fqD
         lsSBepXuZSBunmgWDt3Yxyy8Q1/DTakqkSdL6LO6rznqc3/MlIfISRNYucXaArDoEEr5
         ToxEdG8o7KuFcD2hubfziA/YTHae1X5h8QoiLjuNkHOWZzvtNIbG8T4kl1dx+Ik+eLJv
         taPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhlp1DC5hTiFtQt2OfWjni9zO4NONCFR1Zagzq40oH8=;
        b=oBtbKeYWdrV0evTTf212Jb2Q/t3g/zPCbcgMIHSoQ6xOIHb4ZQ/C6aCdVJYOGG3JLM
         r71umyZjGL4bhimAe8xvd+MJuFJHIA/z2tyPbpYZVTF3JdG9pyBdVXrFaSolViOKGebP
         31iDOcdrdG533GFae0EU9Qhi5Gf1jy14Kd9b+gwBRrR7VB99QRCm2OSFQrQjdptUmV57
         OP1sogDyWnIYrloYvcugNjwTT29nqgJRCWoj1LUoQN2mvXmemi5UHUwG/o/xDykbYMEA
         zgPX84/NgI70tEorEAB7BH+iBGYU6km1oKND/A6jilXzl2aMv8Lbpb2j1O8sIh+THSDR
         wHPQ==
X-Gm-Message-State: ANoB5pkuJ4SRq1z5CiFE4OUJ3y+NjGt76Ogany80Gri1mTKiMHYflHEN
        2mNqiwr2A423qtVWSJiVpjto0wc8ZbDe31U=
X-Google-Smtp-Source: AA0mqf6u3bQHqVxdWteEok2y1gAK5HDRAhCCKcaW79gI/ZwtSkwCX3QVUAOi4vqfPCpYbrp731f9eg==
X-Received: by 2002:ac8:5b53:0:b0:39d:457:6f53 with SMTP id n19-20020ac85b53000000b0039d04576f53mr56563405qtw.39.1671211530143;
        Fri, 16 Dec 2022 09:25:30 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id r17-20020ac84251000000b003a50ef44a77sm1613894qtm.28.2022.12.16.09.25.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:25:29 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] notebook: make use of "allowlist" instead of "whitelist"
Date:   Fri, 16 Dec 2022 12:25:28 -0500
Message-Id: <20221216172528.146970-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/types_of_policy.md | 2 +-
 src/xperm_rules.md     | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/types_of_policy.md b/src/types_of_policy.md
index 8172947..b224460 100644
--- a/src/types_of_policy.md
+++ b/src/types_of_policy.md
@@ -348,7 +348,7 @@ Requires kernel 3.14 minimum.
 
 For the *selinux* target platform adds new *xperm* rules as explained in the
 [**Extended Access Vector Rules**](xperm_rules.md#extended-access-vector-rules)
-section. This is to support 'ioctl whitelisting' as explained in the
+section. This is to support ioctl allowlists as explained in the
 [***ioctl* Operation Rules**](xperm_rules.md#ioctl-operation-rules) section.
 Requires kernel 4.3 minimum.
 For modular policy support requires libsepol 2.7 minimum.
diff --git a/src/xperm_rules.md b/src/xperm_rules.md
index ea5d335..a74af9f 100644
--- a/src/xperm_rules.md
+++ b/src/xperm_rules.md
@@ -9,7 +9,7 @@ a fixed 32 bits to permission sets in 256 bit increments: *allowxperm*,
 
 The rules for extended permissions are subject to the 'operation' they
 perform with Policy version 30 and kernels from 4.3 supporting ioctl
-whitelisting (if required to be declared in modular policy, then
+allowlists (if required to be declared in modular policy, then
 libsepol 2.7 minimum is required).
 
 **The common format for Extended Access Vector Rules are:**
@@ -74,7 +74,7 @@ Conditional Policy Statements
 
 ### *ioctl* Operation Rules
 
-Use cases and implementation details for ioctl command whitelisting are
+Use cases and implementation details for ioctl command allowlists are
 described in detail at
 <http://marc.info/?l=selinux&m=143336061925628&w=2>, with the final
 policy format changes shown in the example below with a brief overview
@@ -118,9 +118,8 @@ tclass=udp_socket permissive=0
 
 Notes:
 
-1. Important: The ioctl operation is not 'deny all' ioctl requests
-   (hence whitelisting). It is targeted at the specific
-   source/target/class set of ioctl commands. As no other *allowxperm*
+1. Important: The ioctl operation is not 'deny all', it is targeted at the
+   specific source/target/class set of ioctl commands. As no other *allowxperm*
    rules have been defined in the example, all other ioctl calls may
    continue to use any valid request parameters (provided there are
    *allow* rules for the *ioctl* permission).
-- 
2.39.0

