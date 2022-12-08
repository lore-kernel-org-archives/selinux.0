Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02F3C4332F
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiLHN01 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLHN0Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 08:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8AD7BC03
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670505928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7PF/AAYrZMazjQBpBBFfsD8WzCuo9/HtUXclqa4I4oY=;
        b=XEaMWjd4N2YWbkVSX9pPgJ8gNJ9QlhrkRKJajuN9oUJ8yh2lqxzk/UzU90sQ/+NCk4I4Qh
        JfuUbYjTQo2oXeJWD0pYzeg0B+9AP8UMEkyHctVg1XPuSejWWGxkpaTenFGz5izK9chBdQ
        Q8TPhsj1eRxH9QJmorWwIAKR00Uw0ow=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-KMgJschbMtiRcNJB2FS-iQ-1; Thu, 08 Dec 2022 08:25:27 -0500
X-MC-Unique: KMgJschbMtiRcNJB2FS-iQ-1
Received: by mail-ej1-f70.google.com with SMTP id sc5-20020a1709078a0500b007c0ca93c161so1074473ejc.7
        for <selinux@vger.kernel.org>; Thu, 08 Dec 2022 05:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PF/AAYrZMazjQBpBBFfsD8WzCuo9/HtUXclqa4I4oY=;
        b=65cO6i5eVEt7wmWcZSdJnODy4l0zms0veEGrHEuopktw6V1loRFYGXGr57juRp2OuQ
         kDStInXx4i+UyP6lkhbgkqDlBMm6Ocm6YFVebZ1G7ushqYcwcyhq6ioVrZl3N55flaUf
         LxbWGyrLsRkCn4JbD4hgtDkbigDe/DcIJrs+wd+khpWCe4eajyMvmTWbSpeDUiYD84am
         i1SdMLs5W12P2yJqrL+OTk5d6fLOs1eTeJ7zQrF8dwgWFjNkoXHl0lHkWuxKdjIhBdun
         NjLx7tC4DkE4Z6Q05jKzJlIk2oQYHV5RJrn/A4/mt6D7RtUo/VUkQexO6mBijlMP14W3
         q9KA==
X-Gm-Message-State: ANoB5pnD+iDxttf+5lTkVMCZ98R+wln8wgOjzan/JeJzuKxkDYIB0tJL
        XuUhlxPytokt5lNQX5Jsh6/NCbVBoS3YdFQh9USohpIISDDIfq1ZZssKr9RpyKQ9loQFfgSjGRy
        kM0miG2TcS5+Xoz2ZT2Mhr1yshb90rhBJpq29XVNzlkEkarfzxyiiLSvl8wkUYKJNC8/zXQ==
X-Received: by 2002:a17:907:910b:b0:7c1:1c5:c7cd with SMTP id p11-20020a170907910b00b007c101c5c7cdmr1525117ejq.5.1670505925503;
        Thu, 08 Dec 2022 05:25:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf74y8tth8222dOZJlaZ41+RTTS91MYOVsxvDIm2hr6liB2jUpVxviYSpwQpk3TTZeDuS+ZaSA==
X-Received: by 2002:a17:907:910b:b0:7c1:1c5:c7cd with SMTP id p11-20020a170907910b00b007c101c5c7cdmr1525108ejq.5.1670505925210;
        Thu, 08 Dec 2022 05:25:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709066b1200b007bf988ce9f7sm9753959ejr.38.2022.12.08.05.25.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:25:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/4] Bump Fedora versions in CI
Date:   Thu,  8 Dec 2022 14:25:18 +0100
Message-Id: <20221208132522.309657-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

...and massage the code to satisfy the latest perltidy and -Wall -Werror
with latest libselinux (plus other minor fixes found along the way).

Ondrej Mosnacek (4):
  tests: adapt style to new perltidy
  tests: use correct type for context string variables
  tests/execshare: remove special cases for arcane architectures
  ci: bump Fedora versions

 .github/workflows/checks.yml                  |  4 +-
 tests/bounds/thread.c                         | 17 +++----
 tests/dyntrace/parent.c                       | 13 +++---
 tests/dyntrans/parent.c                       |  9 ++--
 tests/execshare/parent.c                      | 16 ++-----
 tests/exectrace/parent.c                      | 13 +++---
 tests/filesystem/check_mount_context.c        | 13 +++---
 tests/filesystem/create_file_change_context.c | 46 +++++++++----------
 tests/filesystem/fs_relabel.c                 | 10 ++--
 tests/filesystem/test                         |  2 +-
 tests/fs_filesystem/test                      |  2 +-
 tests/inherit/parent.c                        |  9 ++--
 tests/keys/keyring_service.c                  | 15 +++---
 tests/prlimit/parent.c                        |  9 ++--
 tests/setnice/parent.c                        |  9 ++--
 tests/tun_tap/tun_common.c                    |  4 +-
 tests/tun_tap/tun_common.h                    |  2 +-
 tests/tun_tap/tun_relabel.c                   |  3 +-
 18 files changed, 99 insertions(+), 97 deletions(-)

-- 
2.38.1

