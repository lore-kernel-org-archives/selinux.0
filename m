Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A2FC433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BC260FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJSPDm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232402AbhJSPDl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GIsiRHMNF+3drUqlTYzCwlumTzXj6CULOcYvFJ3WHN4=;
        b=Xf48EDnnChCBeVjFN+4Nx4w0eNGLofxs3CRWUbxGj9u0jgWRXk7hHqHjaX6GsslgYaKZyA
        7Usb/1pAupxMvTAhD7zmbEJEdW/6o+41N4jmEUIIRVAEgUeb+aYP2Y/47uBK0djnKfE4+L
        kUQ9+Fe3YJsDEHCO9PY6laMgdYT/y+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-3lGR8k36MO-lf_Hi9sQMsQ-1; Tue, 19 Oct 2021 11:01:25 -0400
X-MC-Unique: 3lGR8k36MO-lf_Hi9sQMsQ-1
Received: by mail-wm1-f69.google.com with SMTP id 128-20020a1c0486000000b0030dcd45476aso2608693wme.0
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GIsiRHMNF+3drUqlTYzCwlumTzXj6CULOcYvFJ3WHN4=;
        b=ZdqEjlxaMD3tFT9uAUVamhB+L0xShvQaJasAQqkXqgm5Zh4Fo6PTJ6wsbaxcPDzxmu
         0yF5+FScDQQSTKhqRoIluQYpRP63j8aeoudlCYOHL87qz+fStMxAe6jPwl8M+DEP6qJw
         Fa9pDCBBP7kVjd1qkagXs5jsKQ9bUHNiGzKsH/vgVotI7czyFw7nxs/9NBGOSLJZ+luN
         cx2xBBA3K6ftKW0rwYyd/ujcZ8JKqHWDbt42wjGEE4mxzoFS9nAY3+Ue3r+Osk+j9fum
         pzERnMiqdpdyTCMZmpIbTGOvqRU31+WVOr7O/69n14og+aeCS9a/IK+QthrzCnxD67R7
         j8eQ==
X-Gm-Message-State: AOAM530leM0TbsDPW3Mh5bhzAMtGREeOj6owePM5KM7h0Rp+8BWBkKL7
        MfL8FnWJOyTEvberBVU5zid3wzsrDdzgSWNzVra5UY8oF/VOJoF42Sg+AmeKbHUYfLYXnjZzj/q
        RbzKS+FBUNWN+mwIUXAuVwXJOQJmlEWqh4G6/7cm34A/HBgLqlTROX/ygOLtijTYFfGXytA==
X-Received: by 2002:adf:b34c:: with SMTP id k12mr43872621wrd.1.1634655684277;
        Tue, 19 Oct 2021 08:01:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvLV8RBWTO2bpVcHCWSFJxuTnpS0+4F3zpFLNQBMTucohVSqcZtcdrr5gvlBEx3G4uyyKf2g==
X-Received: by 2002:adf:b34c:: with SMTP id k12mr43872558wrd.1.1634655683892;
        Tue, 19 Oct 2021 08:01:23 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r4sm19271630wrz.58.2021.10.19.08.01.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:01:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 0/7] Parallel setfiles/restorecon
Date:   Tue, 19 Oct 2021 17:01:15 +0200
Message-Id: <20211019150122.459722-1-omosnace@redhat.com>
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

Changes v2->v3:
- add a patch to fix pre-exiting data race in label_file
- wait for threads to complete using pthread_join(3) to prevent thread leaks

Changes v1->v2:
- make selinux_log() synchronized instead of introducing selinux_log_sync()
- fix -Wcomma warning
- update the swig files as well
- bump new symbol version to LIBSELINUX_3.3 (this may need further update
  depending on when this gets merged)

Ondrej Mosnacek (7):
  label_file: fix a data race
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
 18 files changed, 458 insertions(+), 174 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3

-- 
2.31.1

