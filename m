Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A84C4321E
	for <selinux@archiver.kernel.org>; Wed,  2 Nov 2022 14:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiKBOBX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKBOA6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Nov 2022 10:00:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00DEE25
        for <selinux@vger.kernel.org>; Wed,  2 Nov 2022 07:00:44 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w4so743244qts.0
        for <selinux@vger.kernel.org>; Wed, 02 Nov 2022 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEXa95vqmVRjETaj1pOX2WQOodQnq6Q7UyW56t6jVnA=;
        b=jXWwvToCDJ+qZxQ31nPrqUFZF6+jwlZuClcP0A4DyoKFvsUkxACNtxXV+RF3Ncw7a/
         Qx8Lny8wEVdSa6qhzf1sfAFxfZYKP+TdeJpatjeWsgJs+2BUqQ1b8ZNnT6qGEeC6m150
         IIlL6ZL2EvTXELvy9tJUuu9bQNVPU+QhYmh+G7hT53A+eeZDWpeQguGuEh3aH/oe2s8z
         MDe6iwapk0PEvZUWGMS5ODx3vke7ePUbH2MSCzCkmywoECVhdZ0OVS6MzN0LbfsUOYZI
         akAwcpRnA3W1xt7dS9yWoMRHqIQRYTD+JDI46Yenj1ESAoicyWN6gqUbpkN36MSZNoTq
         kd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEXa95vqmVRjETaj1pOX2WQOodQnq6Q7UyW56t6jVnA=;
        b=VNoZZGa/AbuqEmwnjHAenXRrRGClAUF3weDRqrwC9Rbd8aZpTHow7fcNbWIoO/5vrb
         AOJsP61Vma+1Ir56vY9LXJAC2TFek179fMnrTiwAQZjYdARHkJ1R1nc872eWW08/Ocjo
         1tIuEnBPvIOsZnRK9hrnEE3ruR4Fyfv9vEGxFPGdoCMlmNx/Eku5/OjtComGjSNT0Ivp
         NM1zVGBHle+GNRYdJSqNE/Jcz546Tl0BHskjhynNyl4BNO9THese/VE1ictbpvt7SnAm
         BSb6kJ+WXzrAn8eyC7q+70GPGEjSETt2NJhXpqFZJPRBpTpTH/TIvsHk4O/EK9W0hyHC
         btsQ==
X-Gm-Message-State: ACrzQf2XLSQ98VJfmt8yN0FPylZN7nDkkJ7/jt4PGnrZGDM+zz260y7w
        X6d0nVEavln6aXniRan/odcxBbj3Z6M=
X-Google-Smtp-Source: AMsMyM69G006gErK9RSjBF9OaXwoJf/ogGjNFUXLhLryfziHzSlLFNWnVgSToXj47cRv7NmnVvIGIw==
X-Received: by 2002:ac8:6f08:0:b0:3a5:45a4:ab59 with SMTP id bs8-20020ac86f08000000b003a545a4ab59mr2257022qtb.167.1667397642630;
        Wed, 02 Nov 2022 07:00:42 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b006ce0733caebsm8449846qkj.14.2022.11.02.07.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:00:42 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5 v2] Remove dependency on the Python module distutils
Date:   Wed,  2 Nov 2022 10:00:34 -0400
Message-Id: <20221102140039.914518-1-jwcart2@gmail.com>
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
 python/sepolicy/sepolicy/gui.py       | 2 +-
 python/sepolicy/setup.py              | 2 +-
 scripts/env_use_destdir               | 2 +-
 scripts/run-scan-build                | 2 +-
 10 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.38.1

