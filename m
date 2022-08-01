Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D333C00140
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 01:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiHAB5h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiHAB5g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jul 2022 21:57:36 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC88DE81
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 18:57:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o16-20020a9d4110000000b0061cac66bd6dso7331134ote.11
        for <selinux@vger.kernel.org>; Sun, 31 Jul 2022 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VJhz2pk41wsZl7aCEn0lBmRP0jblxEYJZNi694UUD9A=;
        b=mgo0H905PbOEYetlGnM0u3LTSQZTqRaYcjURPSNQz3EzF+WeUSkEOTXlgNc0rkv4D9
         q7mv7/wjXf0/w9c2NqrGXSNdFqN7qLgLSjeZrYm3F7odJW8NZ6W5bnGa6ter1VdoJ2dY
         MB95QUNYLON2zCpSSljxB3U6RPsvOjCnScDJ48suw8kKCxnNqibwAJLgpioR/fwoYGA7
         pcQhPE/TdIZQsR7e86BhGuKXEGQEDB/uCQmvkNTLFW36mE8rb+YQvCqybWg4Bxuu5a0s
         i43ST57oGQMhGQeNwz3QD8FF+92t4u6zrLzHCdOaKw0VnDZ7achRsD+W20PdA04XMtYm
         t1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VJhz2pk41wsZl7aCEn0lBmRP0jblxEYJZNi694UUD9A=;
        b=sTjUWIBb3nwgiixNhpWcBCo+gRlh8AheNwSDEgzjaeqoGHHUJlfB8C+cx97Of3d/Q1
         FDhHvr6dl/Eq5z1gjweVQbx9aKtvIQppoCJBwX2TAVaM2ZiaqdlFVUrs/bLTaJKUwYXh
         HSjSkEyST/HGrRQv+ToVshlwq0TFI/ToxQRyBFu5RuNCJwmrLUM8ibCNIxbgiOrLu/y/
         EEB6RTLkb0Iupbes3S28rNlLwR6KR1L/tw6nG7go43PFD3VcPpPT3FJNoF98ErPrg+Em
         B3SsnnJeFP4bDDjiZ0q44lo0We+7O/6wTfksDpgBzYf4107Itc8s894+9mG7C386QMF3
         wY3A==
X-Gm-Message-State: AJIora/fI17tDPDgi7oTUagxN3dn3GnpwOBVMS5GOKj52LGzY71q/w3p
        ZEn5Lono5cLMylHcQmXAuYEhfH8MGn8=
X-Google-Smtp-Source: AGRyM1uCK84dNyQoSn2Bryuh7P+KcgKYsob4zIQrfxPvl7fTkzlPJuy1qbe5dRZN4dOa00GfMl2zGg==
X-Received: by 2002:a9d:6d08:0:b0:61c:bbc4:7996 with SMTP id o8-20020a9d6d08000000b0061cbbc47996mr5160551otp.277.1659319054754;
        Sun, 31 Jul 2022 18:57:34 -0700 (PDT)
Received: from metis.hsd1.tx.comcast.net ([2601:2c3:c880:1cb0:f1dd:9542:7e38:c208])
        by smtp.gmail.com with ESMTPSA id h4-20020a056830164400b0061c9c7813d4sm2553084otr.24.2022.07.31.18.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 18:57:34 -0700 (PDT)
From:   chris.lindee@gmail.com
X-Google-Original-From: chris.lindee+git@gmail.com
To:     selinux@vger.kernel.org
Cc:     Chris Lindee <chris.lindee+github@gmail.com>
Subject: Adjust sepolgen grammar to support allowxperm, et. al.
Date:   Sun, 31 Jul 2022 20:57:19 -0500
Message-Id: <20220801015721.393211-1-chris.lindee+git@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide basic support for allowxperm, auditallowxperm, dontauditxperm and neverallowxperm.  While I would prefer additional changes to help avoid the presence of magic numbers (e.g. a new macro, much like interface, but for recursively defining named xperm numbers), this patch set is sufficient for my and - hopefully - the majority of the community's needs.

In particular, this change will keep /usr/bin/sepolgen-ifgen from spewing errors on the following policy every time selinux-policy-targeted gets updated: https://github.com/openzfs/zfs/pull/13271/files#diff-70b325e496b997b3c4a5a9f0aacee16343b82e07a8ed8220304ccb5f6504a582

Signed-off-by: Chris Lindee <chris.lindee+github@gmail.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 python/sepolgen/src/sepolgen/refpolicy.py | 18 ++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)


