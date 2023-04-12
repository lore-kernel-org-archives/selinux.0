Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC6DC77B76
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 21:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDLVEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDLVEO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 17:04:14 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA27AAC
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id u4so8736043qvj.10
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681333449; x=1683925449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAVZ+Hthb7de/FaTUKxjucYu4MeSAPvVD5OXpEk6lyI=;
        b=BDG/hGi3bMBYVDxbGVU7/UE47m2P3Zd5v5QierIJNE3wRg/JGaR9hLt8wbiB9U4gRW
         cHcUUlQUt5yv+Qdk4xM2d+SWgeoEu9/Hht/fZXZzfJFkAWpxB67+huxO/B9F5e4WXoyl
         u/xQuqRJ8KnHEQATelCFgUdSEdoYg7z+J6Gxzu/Pe6J8ZgSI3G0CkbIvBR7xbCGRQhQ6
         Whsc5uO2QZ7kLvir6dKLNgzb/uqBcS3pzyF13tRkvtPLocpYUvYlc0wf/WRaunWzgAS6
         X6dFL7ChWPBzNV5o9RNxo8PldR/0QA1pyFANkR5GUeo/sVj2Z2kjfF7vjlAB5WSJPORS
         FTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333449; x=1683925449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAVZ+Hthb7de/FaTUKxjucYu4MeSAPvVD5OXpEk6lyI=;
        b=E5EYF5wphJiFIn1x1qdtbJtr4txQchGFHaADKdvDte+945fs4GvaXQPXIxht5IJj8G
         u0xi/aF0sfQduYicBasoL66uPPv5bnmxBrl389cB+1w8+TByl6VVo/aGyvdIBy1HwOt9
         uHhWe4+vY9DS6w0blZrWQULV31vHl+jsDU+KlktsT6gw89liFtuuALpWCh40UoeRIK7d
         EPU+NQMamP3kUeGcMkNjPdRXRrIUcldEZYokOwKIjVf8v8N9c2MYe4NU0u0Y1o0QpJTL
         sIZJDdUTk6yeocSIZIC3wFpbKvMTu0eHQk1fH/IVf2jKJf0GnsoWcxVpNg5pFckJcw72
         IPUw==
X-Gm-Message-State: AAQBX9ctHWKwUvi9czpHeMG/h16cGBTRVE8KbvKhYIxSspQq4xXAmSQG
        JPwvOW+kVE8cLCSTC54pw0cvwdR1V2A=
X-Google-Smtp-Source: AKy350Z93ioqfctK5Qhf84bvt5DxoM/63HUrPME5XlsMkkzten3zC/W+uSxG+4hHMb4iBiRs5fnpQw==
X-Received: by 2002:a05:6214:493:b0:5df:4d3e:b8da with SMTP id pt19-20020a056214049300b005df4d3eb8damr30267453qvb.10.1681333449062;
        Wed, 12 Apr 2023 14:04:09 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id oe6-20020a056214430600b005e16003edc9sm5025758qvb.104.2023.04.12.14.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:04:08 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/6] Add support for notself and other to CIL
Date:   Wed, 12 Apr 2023 17:04:00 -0400
Message-Id: <20230412210406.522892-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch set adds support for using notself and other in AV rules.
See patch 3 for more details.

Patches 1 and 2 are new patches related to ebitmaps.

Patch 3 is a modified version of the patch sent to the list on March 1st.
The recent changes are just removing some ebitmap_init() and ebitmap_destroy()
calls that are not needed with patch 2.

Patch 4 is Christian's patch unmodified.

Patch 5 is a new patch that updates the CIL documentation

Patch 6 is a new patch that adds a simple policy that can be used to test secilc.

Christian Göttsche (1):
  libsepol: update CIL generation for trivial not-self rules

James Carter (5):
  libsepol: Changes to ebitmap.h to fix compiler warnings
  libsepol/cil: Do not call ebitmap_init twice for an ebitmap
  libsepol/cil: Add notself and other support to CIL
  secilc/docs: Add notself and other keywords to CIL documentation
  secilc/test: Add notself and other tests

 libsepol/cil/src/cil.c                    |  12 ++
 libsepol/cil/src/cil_binary.c             |  91 +++++++-
 libsepol/cil/src/cil_build_ast.c          |  10 +-
 libsepol/cil/src/cil_find.c               | 246 ++++++++++++++++++----
 libsepol/cil/src/cil_internal.h           |   4 +
 libsepol/cil/src/cil_resolve_ast.c        |   4 +
 libsepol/cil/src/cil_verify.c             |   3 +-
 libsepol/include/sepol/policydb/ebitmap.h |   4 +-
 libsepol/src/module_to_cil.c              |  30 ++-
 secilc/docs/README.md                     |   1 -
 secilc/docs/cil_access_vector_rules.md    | 244 +++------------------
 secilc/docs/cil_reference_guide.md        |   9 -
 secilc/docs/secil.xml                     |   2 +
 secilc/test/notself_and_other.cil         |  65 ++++++
 14 files changed, 444 insertions(+), 281 deletions(-)
 create mode 100644 secilc/test/notself_and_other.cil

-- 
2.39.2

