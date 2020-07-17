Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68624C43600
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1CD21775
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TkI+hwhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGQRnP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQRnP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jul 2020 13:43:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C9C0619D3
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so5753276plm.10
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV1gvV23mO4MSWHgMeM+r7999nuQAFQGTkfq3zyvhrU=;
        b=TkI+hwhyWG7WZvnJTwRRMikLIXphh/PU89bCIE8P6SFs0SaHpCf4VAcMkSYIWejrmC
         UHjYj/pWqealOdMvuvGnbGyDGiR092Y/coL6eRwohd6FSkw/1x0lTSsWwdlxAmTbJF9z
         MG+bnlBW3Pz3hPqkiZYjpkgP2T6E3WFs4nd00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV1gvV23mO4MSWHgMeM+r7999nuQAFQGTkfq3zyvhrU=;
        b=p+MkfydSAqrDO6A5qTxxldf0qJJo0DZOP60RA8iNhyw1fd1OEpRtm1qo4n+GziPuTX
         2xvE7Q0utfPNEV3nSmp1KWSBu8dQp+nbRiGb3Xd1wQ0B8jcppLOj4pVAcCwWHCeKo3gi
         KbbDOyxBn3hh1xAjWHCTKtkIhFfeRmqI5+pjSexYsb2AvmKVoaD0Yp815aIECC0JZ96U
         /MeRo3RW0+ZKk5zpCYj8tatbOdkGfVcb0EK0vWJtUcU/j1WauyUJQ2Jejw4Zyq1kQL2M
         pPUq3jnLYgiplwKyarXqBW4NESXn+QdCzIjR37mAc8yCPih+88Ct9wUFc8zoo2dMtXY0
         qV6A==
X-Gm-Message-State: AOAM533PrBJvAb5dywKMbK6fpCMW/bcYNcEtAfhLVqmmUTOgdxCAxDJa
        QGNN5N/rIqU6C4F8HJ6BvLBS0w==
X-Google-Smtp-Source: ABdhPJxKZBG7RqgWoCxDb3CWPD97sCGFFzSrqXIIWjriKiDJA4WPNj/7bJe6bdbUYimvfgj8GzzH+g==
X-Received: by 2002:a17:90b:1386:: with SMTP id hr6mr10767858pjb.93.1595007794310;
        Fri, 17 Jul 2020 10:43:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm8245611pfu.124.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] Introduce partial kernel_read_file() support
Date:   Fri, 17 Jul 2020 10:42:55 -0700
Message-Id: <20200717174309.1164575-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

Here's my attempt at clearing the path to partial read support in
kernel_read_file(), which fixes a number of issues along the way. I'm
still fighting with the firmware test suite (it doesn't seem to pass
for me even in stock v5.7... ?) But I don't want to block Scott's work[1]
any this week, so here's the series as it is currently.

The primary difference to Scott's approach is to avoid adding a new set of
functions and just adapt the existing APIs to deal with "offset". Also,
the fixes for the enum are first in the series so they can be backported
without the header file relocation.

I'll keep poking at the firmware tests...

-Kees

[1] https://lore.kernel.org/lkml/202007161415.10D015477@keescook/

Kees Cook (12):
  firmware_loader: EFI firmware loader must handle pre-allocated buffer
  fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
  fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
  fs/kernel_read_file: Split into separate source file
  fs/kernel_read_file: Remove redundant size argument
  fs/kernel_read_file: Switch buffer size arg to size_t
  fs/kernel_read_file: Add file_size output argument
  LSM: Introduce kernel_post_load_data() hook
  firmware_loader: Use security_post_load_data()
  module: Call security_kernel_post_load_data()
  LSM: Add "contents" flag to kernel_read_file hook
  fs/kernel_file_read: Add "offset" arg for partial reads

Scott Branden (1):
  fs/kernel_read_file: Split into separate include file

 drivers/base/firmware_loader/fallback.c       |   8 +-
 .../base/firmware_loader/fallback_platform.c  |  12 +-
 drivers/base/firmware_loader/main.c           |  13 +-
 fs/Makefile                                   |   3 +-
 fs/exec.c                                     | 132 +-----------
 fs/kernel_read_file.c                         | 189 ++++++++++++++++++
 include/linux/fs.h                            |  39 ----
 include/linux/ima.h                           |  19 +-
 include/linux/kernel_read_file.h              |  55 +++++
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |  12 ++
 include/linux/security.h                      |  19 +-
 kernel/kexec.c                                |   2 +-
 kernel/kexec_file.c                           |  18 +-
 kernel/module.c                               |  24 ++-
 security/integrity/digsig.c                   |   8 +-
 security/integrity/ima/ima_fs.c               |   9 +-
 security/integrity/ima/ima_main.c             |  58 ++++--
 security/integrity/ima/ima_policy.c           |   1 +
 security/loadpin/loadpin.c                    |  17 +-
 security/security.c                           |  26 ++-
 security/selinux/hooks.c                      |   8 +-
 22 files changed, 432 insertions(+), 246 deletions(-)
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/linux/kernel_read_file.h

-- 
2.25.1

