Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53DC433FE
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 14:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiKDOjG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKDOic (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 10:38:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704FB31371
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 07:36:22 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x13so3302064qvn.6
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIsCw7z+g+3QDtmofJ+788zchi/m9IoUPX8kyQjCtbM=;
        b=Y1OMiH6AswUsn485BxfMS/79ZwJmg2ZkFfluIYaZfXBFWonroSGi/t9zHYV+ozRh1o
         J6NDcEbuD/9QzrgjI2y12wU1DhA1veougftfhWF4jPy1Sd8OBauhg/wkT2QZQ7dNGq+s
         vPXaN676YxgIdM5cEgMvbwvyoTf91bqE4e5rZDedZlRAiLd6gcu+V07HvGnViwy8TjUw
         Zw3P3TBsBZTo/SMArqHp0wMh6P0fRpJs4Dvl74reqnC4AjVufgj7eo6Ms7LVS7J215gH
         QFz9o0y7XJOryWXsY4a8hSzTENSuAmNcxTYE9QsyqG0PZtGSZS+sve/eJrKVA/NRAWWc
         mCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIsCw7z+g+3QDtmofJ+788zchi/m9IoUPX8kyQjCtbM=;
        b=TbPKud7zA3xcMxrlOEViBfV6qA1vuyHqcciXt5dwEBGA/gv1JpwlnqT5Hb+WyU4DgN
         YmJfHP551X4xKN/jymHxtsG7/ksXyxYuhpATjDQiI5rUEqUmKFhL4Bc2S9MZ1wGPm3kM
         ySnR+WRjdmEd5EbO7b9OaDzJ08BzUYc5dkEGqqdbpoj76FGEolGljTPAVWIWddRtLGXC
         UB/nRjmlKOJXwVfTbBZajy4vDvqymTVNFMo4MPsbiq4YEXoVcaKsq9iDzWw+LdCNs6UG
         5XFHGNZz+ksme4fh6C2GhqfyFnVFYwWgcM+4okHxLf8hyO+jlIYRizwO3gI+/KYxEVnf
         MREA==
X-Gm-Message-State: ACrzQf2bres5goU05faDmQvSL2O9vhfKwEeOTC3NpHu8RgUksJtTw43L
        30p2Mma/SN0P+qG/104rkHYZ+OBrZHM=
X-Google-Smtp-Source: AMsMyM4Rsi4GEfFwcg7MMD44dzbzZyJF3C7dSXHg4H82EgW8D36fsRXPpWUV/bJr1+rpGJwCVN++Rg==
X-Received: by 2002:a0c:cb92:0:b0:4bb:7aa3:d8ce with SMTP id p18-20020a0ccb92000000b004bb7aa3d8cemr31877871qvk.45.1667572581201;
        Fri, 04 Nov 2022 07:36:21 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b003a50b501a01sm2479324qtn.87.2022.11.04.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:36:20 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5 v3] Remove dependency on the Python module distutils
Date:   Fri,  4 Nov 2022 10:36:11 -0400
Message-Id: <20221104143616.1089636-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
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

v3: Removed a second usage of distutils in python/sepolicy/sepolicy/gui.py

v2: Use sysconfig.get_path('purelib'... when original used
    get_python_lib(prefix=... and use sysconfig.get_path('platlib'...
    when original used get_python_lib(plat_specific=1, prefix=...

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
 python/sepolicy/sepolicy/gui.py       | 4 ++--
 python/sepolicy/setup.py              | 2 +-
 scripts/env_use_destdir               | 2 +-
 scripts/run-scan-build                | 2 +-
 10 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.38.1

