Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AA6C2D0E5
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BD120748
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfjr+1x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0PVR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:21:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26209 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgC0PVQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 11:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oJaLrNx4/t7fq9T8XF9Nyy200mwlWBypYP9ahPkF+ZA=;
        b=Yfjr+1x1L/Tr5Jj0J9W84fvyeNsL7ScmkUth2+s0V8rTTgiRc5H3k1ZQoIEUxNqF0UV8mg
        qFPpXMstXi0LTDWCOBREpNVENU+SiwaNHt2DOKKqzqzFFXKwv/NNdDz9v6tNRnD10Ym0DL
        ljvb7tzt3Seq9PvXAx/s/ZMyX8gTWek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-VLBKmZuZPDefpHFrOcQofQ-1; Fri, 27 Mar 2020 11:21:11 -0400
X-MC-Unique: VLBKmZuZPDefpHFrOcQofQ-1
Received: by mail-wm1-f72.google.com with SMTP id m4so4496715wmi.5
        for <selinux@vger.kernel.org>; Fri, 27 Mar 2020 08:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJaLrNx4/t7fq9T8XF9Nyy200mwlWBypYP9ahPkF+ZA=;
        b=rPbetZd0Fa/Qh3/1A2Ymhgc4jrI0JTF+hm0pJTDkWIV1O5jVAKhwn2tF8HZEGlbuym
         tSHfEPBaV7Nmt1LUwqxdKgP/yZRz2iNaYMEquEKvKd9X2JDpNyAzp6687U2ess+0NZEy
         v4Zu2j3wJy5/F1+NVlwuh8T4dnyRFrdbgt+5Nr+zaGN+xbeEfkeBbqLEPDjJXkFZPHcP
         9uPIR//ciMzLz2xfSKWQZHFlORVnEGFsYeec2jXV8Yfue0HH1nhMtxFsmrYMn0hD6EUw
         YW9OC3Z1c231LUbj9FSxi1a7/F+ZdyhClaf3RoNNdwMawjGgs83X5jY+3H5F+Zd1pVeb
         QcOQ==
X-Gm-Message-State: ANhLgQ1mS/VqFedPBQp3KtfdpNBjDCm13k995CVVQDcMxF1XKpwL4BJj
        KjWkkYAubXmY8X3ZGRrdXd9SbsOnzwOdNETTtz6ZUbOAAoDzbYvFxgdaf5B1fR53yknxUmXTvUr
        4zJoBOIKYd9NMXGA0Tw==
X-Received: by 2002:adf:f7cf:: with SMTP id a15mr4537610wrq.224.1585322469859;
        Fri, 27 Mar 2020 08:21:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+jWFpyNlTqZodQOP0PuERcmQpfZGRlLzFscO+ObUcALdFUEWjXd/5sdJXPRKmA4pncgGmyQ==
X-Received: by 2002:adf:f7cf:: with SMTP id a15mr4537598wrq.224.1585322469665;
        Fri, 27 Mar 2020 08:21:09 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id t21sm8284746wmt.43.2020.03.27.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:21:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Chris PeBenito <pebenito@ieee.org>
Subject: [PATCH 0/2] userspace: Implement new format of filename trans rules
Date:   Fri, 27 Mar 2020 16:21:05 +0100
Message-Id: <20200327152107.95915-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches are the userspace side of the kernel change posted at [1].

The first patch changes libsepol's internal representation of filename
transition rules in a way similar to kernel commit c3a276111ea2
("selinux: optimize storage of filename transitions") [2].

The second patch then builds upon that and implements reading and
writing of a new binary policy format that uses this representation also
in the data layout.

See individual patches for more details.

NOTE: This series unfortunately breaks the build of setools. Moreover,
when an existing build of setools dynamically links against the new
libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
handling this, since setools relies on non-public libsepol policydb
API/ABI.

[1] https://lore.kernel.org/selinux/20200327151941.95619-1-omosnace@redhat.com/T/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b

Ondrej Mosnacek (2):
  libsepol,checkpolicy: optimize storage of filename transitions
  libsepol: implement POLICYDB_VERSION_COMP_FTRANS

 checkpolicy/policy_define.c                |  52 ++--
 checkpolicy/test/dispol.c                  |  27 +-
 libsepol/cil/src/cil_binary.c              |  29 +-
 libsepol/include/sepol/policydb/policydb.h |  18 +-
 libsepol/src/expand.c                      |  60 +---
 libsepol/src/kernel_to_cil.c               |  24 +-
 libsepol/src/kernel_to_conf.c              |  24 +-
 libsepol/src/policydb.c                    | 313 ++++++++++++++++-----
 libsepol/src/write.c                       | 100 +++++--
 9 files changed, 440 insertions(+), 207 deletions(-)

-- 
2.25.1

