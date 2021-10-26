Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854DAC433F5
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6069660F0F
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhJZLzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235550AbhJZLzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IYiSU8fTKoL0HAdQQQXKljsSGtZcnBFcBCXKCc2i4Wc=;
        b=iYR8O0D3Hb1w+1CdCp7clje6Ul7AxeeKdZqXmj8dFVddI1VNeSGiOKOildfw+dQG1vFc1s
        0fi7DoguOJurVl7rb8+uSkT+WNPpaVDD7EfZBRtihCjN//ALGTlxSP9D8rULMy4+YpW0LJ
        8q8xxIyh7CbCXZZ0yxdutAWJU+MHtFU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-Udk2eK6_N1asTa6OA6RMlw-1; Tue, 26 Oct 2021 07:52:43 -0400
X-MC-Unique: Udk2eK6_N1asTa6OA6RMlw-1
Received: by mail-ed1-f72.google.com with SMTP id o22-20020a056402439600b003dd4f228451so6311411edc.16
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYiSU8fTKoL0HAdQQQXKljsSGtZcnBFcBCXKCc2i4Wc=;
        b=TH48yJFMfXWAU1ErLX3VymE5/1XAxx4SECAt9CPp2sHL3W4qErnMbWXj31uuOIrnvO
         vjquFcDFptoBj68/1k1/u1FmW5o7uEkI3DV0rzH5EPJRpPGzDNU3Bk+DUvDrnpU3yvVe
         kxrj9LoQqJYFcrdhlufnCwLzV50TpXnX8wU8MM69gEoD6UYeX7Buyawn9JxYaKka0sLm
         F9uOo90HNfIrsMjvsovRM2+mw+JV5sj9FgtKOAS2SC2+PS+xngQjDJ/CY4S8ISwJcvcy
         tgFxnZAOs/AVE2pvMMr6Sjzw8vnEQCpljjAKJCaOlK2l9+j2gW3/VLh8/ICRwVeb2Xoa
         YWjg==
X-Gm-Message-State: AOAM530oO1ldgfJqix7OTt/XqGt2sK8mSuxV5HSHWaXXVfuSTjMcQ2sL
        OtweuS/zRxDz9gr+SsgMqtU10H4Nt2pMDg6dv/FXtsBMryUKss0UPjCxlT4KqIC7dopUVu4nIMm
        LoRUX6qbcy5hiv3fySQKos/r8lcAkOnKOICQGOO6nMFQyR9JOcliWB5iIfoTRuMdC1uSJ6w==
X-Received: by 2002:a05:6402:3554:: with SMTP id f20mr34948240edd.354.1635249162256;
        Tue, 26 Oct 2021 04:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLdd1l7VDBeHtb30AVsT/C1OFYlwGz/JS/+0K6xeJlc+7wZRaEsVRNDwWTKsCGzh+m3HVi5Q==
X-Received: by 2002:a05:6402:3554:: with SMTP id f20mr34948215edd.354.1635249162029;
        Tue, 26 Oct 2021 04:52:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:41 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 0/8] Parallel setfiles/restorecon
Date:   Tue, 26 Oct 2021 13:52:31 +0200
Message-Id: <20211026115239.267449-1-omosnace@redhat.com>
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

The first patch fixes a data race around match tracking in label_file.
Second patch is a small cleanup found along the way. Patches 3-6 are
small incremental changes that various functions more thread-safe.
Patch 7 then completes the parallel relabeling implementation at
libselinux level and adds a new function to the API that allows to make
use of it. Finally, patch 8 adds parallel relabeling support to the
setfiles/restorecon tools.

The relevant man pages are also updated to reflect the new
functionality.

The patch descriptions contain more details, namely the last patch has
also some benchmark numbers.

Changes v3->v4:
- add a patch to fix a pre-existing data race in is_context_customizable()

Changes v2->v3:
- add a patch to fix a pre-existing data race in label_file
- wait for threads to complete using pthread_join(3) to prevent thread leaks

Changes v1->v2:
- make selinux_log() synchronized instead of introducing selinux_log_sync()
- fix -Wcomma warning
- update the swig files as well
- bump new symbol version to LIBSELINUX_3.3 (this may need further update
  depending on when this gets merged)

Ondrej Mosnacek (8):
  label_file: fix a data race
  selinux_restorecon: simplify fl_head allocation by using calloc()
  selinux_restorecon: protect file_spec list with a mutex
  libselinux: make selinux_log() thread-safe
  libselinux: make is_context_customizable() thread-safe
  selinux_restorecon: add a global mutex to synchronize progress output
  selinux_restorecon: introduce selinux_restorecon_parallel(3)
  setfiles/restorecon: support parallel relabeling

 libselinux/include/selinux/restorecon.h       |  14 +
 libselinux/man/man3/selinux_restorecon.3      |  29 ++
 .../man/man3/selinux_restorecon_parallel.3    |   1 +
 libselinux/src/callbacks.c                    |   8 +-
 libselinux/src/callbacks.h                    |  13 +-
 libselinux/src/is_customizable_type.c         |  23 +-
 libselinux/src/label_file.c                   |  15 +-
 libselinux/src/label_file.h                   |   2 +-
 libselinux/src/libselinux.map                 |   5 +
 libselinux/src/selinux_internal.h             |  16 +
 libselinux/src/selinux_restorecon.c           | 458 ++++++++++++------
 libselinux/src/selinuxswig_python.i           |   6 +-
 libselinux/src/selinuxswig_python_exception.i |   8 +
 policycoreutils/setfiles/Makefile             |   2 +-
 policycoreutils/setfiles/restore.c            |   7 +-
 policycoreutils/setfiles/restore.h            |   2 +-
 policycoreutils/setfiles/restorecon.8         |   9 +
 policycoreutils/setfiles/setfiles.8           |   9 +
 policycoreutils/setfiles/setfiles.c           |  28 +-
 19 files changed, 469 insertions(+), 186 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3

-- 
2.31.1

