Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF431C433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 05:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiCCFYL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 00:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiCCFYK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 00:24:10 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5290FF5
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 21:23:24 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j29-20020a634a5d000000b00376a7b5602dso2233172pgl.4
        for <selinux@vger.kernel.org>; Wed, 02 Mar 2022 21:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/YN2YXmJhNDqL2lKEiwSV0FA3jgsteuXO5FPdAULWZM=;
        b=VyAnVObO4fv/3ZdOeEFIemtw7BzNNztvGt00UwFqZjn5jqjgj32v354TN3OqGM/eDI
         gfpczPaE1nq0W5k/YyBrbNWsP6/xXIekKjMNK7DgX2XVMw72G8orbwsZXIVMFeQDwe/w
         PCt0x+9wwa5P/nTqs77CqiFnZu2xE8DiPlAnEyrJ2DQPjEtIj+OTIwOss7eYeFdspcQ8
         JEKvejXHkxK5WQv7psEBmH1auZEHN7wvt7ulr3pFiOAyDY4x4BngchBMSbXCCRHxCK0n
         0MV6nYTKz4Yv3JUTR2qurTDXjnQgL4ifdzYf5JfUj2nmVBlDRsd2Yxs2PsnMLqLuP/ur
         OoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/YN2YXmJhNDqL2lKEiwSV0FA3jgsteuXO5FPdAULWZM=;
        b=U0k0beB4Rp6nAZvPJq3h8CQktMR6zkVPKj8bP52e7Ptv092WqlYEW1joPwB0ex706Z
         3e4ZOvgEGfX0PhWo+43AQO0aFuxeYvjNxY8uQ/Ezwzp+qALF80Wh7smeiYOrkDqbB4SR
         vCA8I1Hbf7F1MxL5O+FUHy0a6Xm6F+17kqRttJQh+nC8weexsOJWuEKOR/3V+2yFi+ZH
         cKRKg/56FNuMZjkT7X1ONGrjIrNV+N6uKhdPijDMHmhvvk2A2gyhQs5JLECjqn52Bm6M
         JLvMTOr/hTo3W6cR9AeNvR/HFjyID0qbW4PTClHuZlGjNLBMgpYtCU6vA6PFydPbRb4q
         E4nA==
X-Gm-Message-State: AOAM532FznFLqNiyVLsRHSJZ6o21RJI8LXC0xQgNRbQS2L2ZC+fhCFw7
        Ik5BIhEJuzzcMWgjiFHribOiGnJ88mearron5/xhVze3wQR78f1JvHrxShtAoTUzM914TpsM1w6
        CfYjNSqaoHED08SH+1QLBnoeFLlrXpbi9Mx4sM9NA+VIcCBB8CHCN2FHtCV+Z
X-Google-Smtp-Source: ABdhPJztCiY/w2p6JgczxYXgskdkrxbV77r8Cwz5X8eNcvPW+wfBRURxLHKh3SawepCjqCTy1VUF570F3Q==
X-Received: from tweek.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:280])
 (user=tweek job=sendgmr) by 2002:a17:902:ef51:b0:150:143e:4ae9 with SMTP id
 e17-20020a170902ef5100b00150143e4ae9mr34225267plx.86.1646285003985; Wed, 02
 Mar 2022 21:23:23 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:23:06 +1100
Message-Id: <20220303052306.357002-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] libsepol: fix reallocarray imports
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     selinux@vger.kernel.org,
        "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>
Cc:     jeffv@google.com, alanstokes@google.com,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In f0a5f6e, calls to reallocarray were introduced. Ensure that the
correct header (private.h) is included when necessary.

Fixes: f0a5f6e ("libsepol: use reallocarray wrapper to avoid overflows")
Test: Built using Android CI (glibc 2.17)
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/src/kernel_to_common.c | 1 +
 libsepol/src/util.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_commo=
n.c
index dc9e689e..972499ab 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -18,6 +18,7 @@
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
=20
+#include "private.h"
 #include "kernel_to_common.h"
=20
=20
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index b7230564..1cd1308d 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -28,6 +28,8 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/util.h>
=20
+#include "private.h"
+
 struct val_to_name {
 	unsigned int val;
 	char *name;
--=20
2.35.1.574.g5d30c73bfb-goog

