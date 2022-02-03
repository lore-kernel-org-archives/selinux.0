Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA25C433FE
	for <selinux@archiver.kernel.org>; Thu,  3 Feb 2022 16:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiBCQxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352441AbiBCQxm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Feb 2022 11:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643907221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cSwCIpKuDz76hHrpmrwQyNFintUuOPvax3SLQQxfN5U=;
        b=S8cSAUNN+t5Ui0hB4pSoDWHjsWkGWpISg4tfZ+ZufJPj3u55oL1QllagL1/6tnqG7wxW8a
        DTxwerE74YA8mUFqmFyisGNv/MUaBOWjAAFWZ3DSfjBbxCDdVpoM0klHkYs8IG2/fUZ9oc
        sjdr01aG3YJgdgWknDVBkONtRubcy6E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-PsKeKNReMZOUjXT57IL70Q-1; Thu, 03 Feb 2022 11:53:40 -0500
X-MC-Unique: PsKeKNReMZOUjXT57IL70Q-1
Received: by mail-ed1-f69.google.com with SMTP id w3-20020a50c443000000b0040696821132so1740491edf.22
        for <selinux@vger.kernel.org>; Thu, 03 Feb 2022 08:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSwCIpKuDz76hHrpmrwQyNFintUuOPvax3SLQQxfN5U=;
        b=L13Jzm9IWF8f/bT1UZayjK1BEqwOhgzEeL4fSmShHnQKZDFkIG3dUEUhgDCMV3mF8a
         /FfJMHfPJ9WSvTCX1l5DgA10J9vEKUGZHyuU7yE8OwDL4EjLdVrwmgqHoefbrjTqCIxx
         7eA2MMBB3saCIKkpfEBot/tV1MCzcwuny+kiqscoGfFFB3r/oRKwHFktvDL1+q7e6jw2
         WLj71titJ6DqRlUSH7cCCaM0i0rSWamRTRcQxXZsTSEauO7MAcGmZLkPQjmYT3T+hPuQ
         80Xl3Tg4fcQLK4ttRPTconrzw/rMMxtrrhVkG/snqZrHQckeNM1MJ8nflzChNPBXdY1t
         Z1SQ==
X-Gm-Message-State: AOAM5303oGJAeCp9t9JMMWaP6J5HgCCed2z8urQX4AVK/JPom5ChKzdD
        pgz8yTBx+m0SBsN8FgvfOTu+flRjzeOIkOFEE0VC7zsZhzIItR/YaDqTdwgbw3dfLtDOwxTgHwP
        nZyBi4ltWEPnrVCMM85Ls+baTU3nsXdOHLKr0M8u2bOQzuEwKo3qjc/nkn/gBIWmFUpi34g==
X-Received: by 2002:a17:906:7308:: with SMTP id di8mr29787733ejc.567.1643907217799;
        Thu, 03 Feb 2022 08:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhKbhhFEgT5S1Kccz1FHmfosB4vE2ZWA8zv//iRS6dd4b+CIRmJp4zk5qem3NxV/TcvgNYpA==
X-Received: by 2002:a17:906:7308:: with SMTP id di8mr29787662ejc.567.1643907216533;
        Thu, 03 Feb 2022 08:53:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id bs4sm18141027edb.84.2022.02.03.08.53.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:53:35 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 0/6] Optionally rebuild policy store only if there were external changes to modules
Date:   Thu,  3 Feb 2022 17:53:21 +0100
Message-Id: <20220203165327.213601-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series extends libsemanage and semodule with optional capability to
detect external changes to modules and perform a rebuild if there are
any. See patch 5 for motivation and more details.

The first four patches are preparatory cleanup/refactoring, patch 5
implements the libsemanage side of the feature described above, and
patch 6 adds a command-line option to semodule that allows to turn on
the feature.

Default behavior of libsemanage and semodule is not changed (apart from
added checksum calculation on each transaction, which however seems to
add no noticeable overhead based on benchmarks - see patch 5 for
details).

Another minor difference is a slightly different format of the checksum
string printed by `semodule --checksum ...` (see patch 2).

v2:
- fix a spelling mistake found by James Carter
- eliminate 'rebuild' goto label from semanage_direct_commit()
- extract some of the semanage_direct_commit() cleanups into a separate
  patch
- unify checksum string format (semodule --checksum and the internal
  store checksum now use the same format and a common formatting helper)
  - also the semanage_module_compute_checksum() is updated to do the
    formatting rather than leaving it up to semodule
- add missing space for null terminator to the checksum string buffers
- make the semantics of check_ext_changes more natural (and make them
  actually match the documentation)
  - before: had to be used along with the rebuild flag to have an effect
    if no other changes are being done in the transaction
  - now: check_ext_changes == 1 simply forces a rebuild any time module
    content changes are detected (i.e. it's kind of a conditional
    version of -B)
  - also now: rebuild + check_ext_changes == rebuild
- rename --smart to --rebuild-if-modules-changed (it's long, but it's
  the least ambiguous I could come up with)
- also update semodule.8 man page
- update commit messages to reflect new naming and behavior

Ondrej Mosnacek (6):
  libsemanage: add missing include to boolean_record.c
  semodule,libsemanage: move module hashing into libsemanage
  libsemanage: move compressed file handling into a separate object
  libsemanage: clean up semanage_direct_commit() a bit
  libsemanage: optionally rebuild policy when modules are changed
    externally
  semodule: add command-line option to detect module changes

 libsemanage/include/semanage/handle.h         |   5 +
 libsemanage/include/semanage/modules.h        |  26 +
 libsemanage/src/boolean_record.c              |   4 +-
 libsemanage/src/compressed_file.c             | 224 ++++++++
 libsemanage/src/compressed_file.h             |  78 +++
 libsemanage/src/direct_api.c                  | 541 ++++++++----------
 libsemanage/src/direct_api.h                  |   4 -
 libsemanage/src/handle.c                      |  11 +-
 libsemanage/src/handle.h                      |   1 +
 libsemanage/src/libsemanage.map               |   5 +
 libsemanage/src/modules.c                     |  59 ++
 libsemanage/src/modules.h                     |   3 +
 libsemanage/src/semanage_store.c              |  53 +-
 libsemanage/src/semanage_store.h              |   1 +
 .../src/semanageswig_python_exception.i       |   8 +
 .../semodule => libsemanage/src}/sha256.c     |   0
 .../semodule => libsemanage/src}/sha256.h     |   0
 policycoreutils/semodule/Makefile             |   2 +-
 policycoreutils/semodule/semodule.8           |   7 +
 policycoreutils/semodule/semodule.c           |  85 ++-
 20 files changed, 721 insertions(+), 396 deletions(-)
 create mode 100644 libsemanage/src/compressed_file.c
 create mode 100644 libsemanage/src/compressed_file.h
 rename {policycoreutils/semodule => libsemanage/src}/sha256.c (100%)
 rename {policycoreutils/semodule => libsemanage/src}/sha256.h (100%)

-- 
2.34.1

