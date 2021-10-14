Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC1EC433FE
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6245610D1
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJNOzl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231938AbhJNOzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 10:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634223215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pc/PxkTJEkG61Iip5Le2urOnh92JCs0AOkQZTlXxBPQ=;
        b=aB9ypTJNCSkByDPTYMv8q2Pf8pj10CNEo0C5IOXEw2tJh5ZY1FN8u+28R5IWgEx/f/uX1A
        xfZOu1XEoNjeZnT70Coo43dtZ4hzMMy6VXOBPDqTu3Ge35Sio47TSGDDd+tYdtzA1f6vks
        slDeh7+jGYDeMIKxXuRP4vffkrxOew4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-mdKTL2NANsKbcI8fgBkAMA-1; Thu, 14 Oct 2021 10:53:32 -0400
X-MC-Unique: mdKTL2NANsKbcI8fgBkAMA-1
Received: by mail-wr1-f71.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso4775334wrg.1
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pc/PxkTJEkG61Iip5Le2urOnh92JCs0AOkQZTlXxBPQ=;
        b=yawpFYOP2ve4mOO2RsWX8Tis5Q7tzpVTrQYy+c4CBgu2KoKm/J7U+MbBSU5dpEaMdI
         USFcLo40xMrcwKnaCRFawL3nqG2Mo+0Ix+MBklOcbmVEriVo1ie40hs83LWTsKg6zTzX
         G5JRTuW2Mk0Kvo4nzNCyPNIKwX+ZvODlYZniVJKZBVNQnc6MfslUrAsU8WmdindjAtiR
         6c5HutbBvCv0hPQ1DA8SP4bqiQY1fKxMgVibqLdKPVtgNSBntZD6kNP4Gqdr5+upd25U
         pQO289/mXyBABtGTYawpTq5sfaYpAfZ2dC334weYH6AhPjOktaBpnzlW+sam4R8XjM41
         sHtA==
X-Gm-Message-State: AOAM531Rjy3JbDBjMomE/j2w2U7ibjKDH1bTWvT8YoYMH/WzE7zH4DzQ
        3ggzqGKFu14/UaRXEwyHS6wC30dUGwkx3j27f8ajRmJKLeAHNHqsQefgFq9bVh2AhoAa+WnYHpt
        T0xQxOMF8Uppe2O/UjbG+r1nOXEDPUVW29SQljjIGHfp1QcPBkbvYyxsRuvavc9QYMosSYQ==
X-Received: by 2002:adf:a194:: with SMTP id u20mr7304620wru.275.1634223201224;
        Thu, 14 Oct 2021 07:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM5OSG5x2DHBDExX4H34pQZMDItOMLRRVDZCOVZyVzM0wgE/cCulydDW2OT4jAmYsVqd82ZQ==
X-Received: by 2002:adf:a194:: with SMTP id u20mr7304574wru.275.1634223200887;
        Thu, 14 Oct 2021 07:53:20 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k17sm2485489wrc.93.2021.10.14.07.53.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:53:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 0/6] Parallel setfiles/restorecon
Date:   Thu, 14 Oct 2021 16:53:13 +0200
Message-Id: <20211014145319.798740-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series adds basic support for parallel relabeling to the libselinux
API and the setfiles/restorecon CLI tools. It turns out that doing the
relabeling in parallel can significantly reduce the time even with a
relatively simple approach.

The first patch is a small cleanup that was found along the way and can
be applied independently. Patches 2-4 are small incremental changes that
make the internal selinux_restorecon functions more thread-safe (I kept
them separate for ease of of review, but maybe they should be rather
folded into the netx patch...). Patch 5 then completes the parallel
relabeling implementation at libselinux level and adds a new function
to the API that allows to make use of it. Finally, patch 6 adds parallel
relabeling support to he setfiles/restorecon tools.

The relevant man pages are also updated to reflect the new
functionality.

The patch descriptions contain more details, namely the last patch has
also some benchmark numbers.

Changes v1->v2:
- make selinux_log() synchronized instead of introducing selinux_log_sync()
- fix -Wcomma warning
- update the swig files as well
- bump new symbol version to LIBSELINUX_3.3 (this may need further update
  depending on when this gets merged)

Ondrej Mosnacek (6):
  selinux_restorecon: simplify fl_head allocation by using calloc()
  selinux_restorecon: protect file_spec list with a mutex
  libselinux: make selinux_log() thread-safe
  selinux_restorecon: add a global mutex to synchronize progress output
  selinux_restorecon: introduce selinux_restorecon_parallel(3)
  setfiles/restorecon: support parallel relabeling

 libselinux/include/selinux/restorecon.h       |  14 +
 libselinux/man/man3/selinux_restorecon.3      |  29 ++
 .../man/man3/selinux_restorecon_parallel.3    |   1 +
 libselinux/src/callbacks.c                    |   8 +-
 libselinux/src/callbacks.h                    |  13 +-
 libselinux/src/libselinux.map                 |   5 +
 libselinux/src/selinux_internal.h             |  14 +
 libselinux/src/selinux_restorecon.c           | 466 ++++++++++++------
 libselinux/src/selinuxswig_python.i           |   6 +-
 libselinux/src/selinuxswig_python_exception.i |   8 +
 policycoreutils/setfiles/Makefile             |   2 +-
 policycoreutils/setfiles/restore.c            |   7 +-
 policycoreutils/setfiles/restore.h            |   2 +-
 policycoreutils/setfiles/restorecon.8         |   9 +
 policycoreutils/setfiles/setfiles.8           |   9 +
 policycoreutils/setfiles/setfiles.c           |  28 +-
 16 files changed, 444 insertions(+), 177 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3

-- 
2.31.1

