Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A4ECAAA1
	for <selinux@archiver.kernel.org>; Fri, 28 Oct 2022 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJ1UjD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1UjC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Oct 2022 16:39:02 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FEF236423
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:00 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h10so4836373qvq.7
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+09TYYlWE9fURqTDdsiTm429HbvRZOh1WZLQt8N7+8=;
        b=S0TGer4QlcKIbiwXHp+2p3BONXR7S8f6lU9Bj9ieaHk7OMa0FATOV8Opydpq+F5qRi
         gA3TDUh7Tza5L3tk7OE7avhQzv2Y0xgZZ/a9hLK1w45Ujiaru4h0iXgjyFvzw7Fj2VLZ
         ZzbvXTZp/PyDh21hR3f4CW+azG9qhKV1YhQ7Jr2BVfivT7o/uOY1Kxo7pbVFFyjeMN8B
         T3qcITzhc8XSWPoaM3BZzyj14NvikSF61T7mih4QPFmWyP+zz6O98kc40Ldtd0m0aRte
         +HQWAVVeENI1s8K38jDq3/I5pPo9g0H3i9lBrPAxctEAKdcnBCMjJSAOLYg1OA9vd1oY
         F+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+09TYYlWE9fURqTDdsiTm429HbvRZOh1WZLQt8N7+8=;
        b=WO+cv1uVURCfxn+d6rpD4Vb57aO2AHL9FU9iuNVGP4DjoVVUg3BfbT56VwiYZ/mrHZ
         DIE3YQcnwujUdyQ4Av6Ubu1SsvVcnMe3q8/l/NTF9RvMKye7BJqtr3XibrGyrFHPI5pD
         rP6f01y7e/hIvxfvKFCODBoTZb8lo2HktSvpKxFKS3o7BpdglEP/knH2JsYzgA9u4P6O
         MgxIp3YTdbRhURhFcrPyI+pitCdT/saOPKrCruMe64hyybDxpWkm9Vrk6WESf5+7ocJW
         h49zNWtT8eSefliCwZvmVDm8E+SNdEzm3btOtVYxllDW8ImyW2RwVzlhCvNdIg2oIBRO
         lpvQ==
X-Gm-Message-State: ACrzQf3aupmFUiY/2HVgWGRwulEMM8b2nqW/Kd8dchK3GHC8lEAgaWyh
        cN1G1gqkmEE4U4aaEdQaiSKp3bva7/E=
X-Google-Smtp-Source: AMsMyM6tui2Y/OPGjLM+N51Qhilr9rABHFJyhxtTAK/PRziT8agFGmJV8K/gvvzdixMmEzJNzG1DjQ==
X-Received: by 2002:a05:6214:b6b:b0:4bb:9fea:f53a with SMTP id ey11-20020a0562140b6b00b004bb9feaf53amr1214107qvb.7.1666989539080;
        Fri, 28 Oct 2022 13:38:59 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006ecfb2c86d3sm3606642qkl.130.2022.10.28.13.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:38:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5] Remove dependency on the Python module distutils
Date:   Fri, 28 Oct 2022 16:38:47 -0400
Message-Id: <20221028203852.526472-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The distutils package is deprecated and scheduled to be removed in
Python 3.12.

When building the SELinux userspace we currently get warnings like the following:
<string>:1: DeprecationWarning: The distutils.sysconfig module is deprecated, use sysconfig instead
<string>:1: DeprecationWarning: The distutils package is deprecated and slated for removal in Python 3.12. Use setuptools or check PEP 632 for potential alternatives

I am not a Python expert, but everything seems to work with these patches.
I would appreciate other people testing this and any Python experts to let
me know if this is the right way of replacing distutils.

James Carter (5):
  libselinux: Remove dependency on the Python module distutils
  libsemanage: Remove dependency on the Python module distutils
  python: Remove dependency on the Python module distutils
  scripts: Remove dependency on the Python module distutils
  README.md: Remove mention of python3-distutils dependency

 README.md                             | 1 -
 libselinux/src/Makefile               | 2 +-
 libselinux/src/setup.py               | 2 +-
 libsemanage/src/Makefile              | 2 +-
 python/semanage/Makefile              | 2 +-
 python/sepolgen/src/sepolgen/Makefile | 2 +-
 python/sepolicy/sepolicy/gui.py       | 2 +-
 python/sepolicy/setup.py              | 2 +-
 scripts/env_use_destdir               | 2 +-
 scripts/run-scan-build                | 2 +-
 10 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.37.3

