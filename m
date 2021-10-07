Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D381C433F5
	for <selinux@archiver.kernel.org>; Thu,  7 Oct 2021 00:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D3260F6D
	for <selinux@archiver.kernel.org>; Thu,  7 Oct 2021 00:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhJGAs0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Oct 2021 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJGAs0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Oct 2021 20:48:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94874C061753
        for <selinux@vger.kernel.org>; Wed,  6 Oct 2021 17:46:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso5729837ybc.6
        for <selinux@vger.kernel.org>; Wed, 06 Oct 2021 17:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RiNo10qigaewXNskXWDjf8RGesyfVGXCVVY+c8mvumk=;
        b=s9RM15/OlUmOcNzsadQlUngC5XCaFRvZDrvfpjpvjqc/Khpftz2AcowOqC++yIXKVX
         TbIowssKA+A1UTSXFVb6NNrpOCYjeZKB4DYG08HgyUn84iBIugHKvVpIY5/3IhQPH56g
         FeyZHf2B3CnS2uFxt/c/+CQrNtD28AY72artX5WoAZy4uoxz4FMFQCBhzLTkHEWEfvSQ
         pVJHFl2wSjwbX422PVf+sLxVugd5HFL6dxUdeJmOKMl11pFoivbdB4autoVk2iRo3cfC
         ccwCnvzY4faO5Pwpo3Bcql9HnMyQHBhqxNjqpPcEirGmjKeMMXX9KnpRKCq4tFKOrIrz
         Yilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RiNo10qigaewXNskXWDjf8RGesyfVGXCVVY+c8mvumk=;
        b=OLJH6N3zHMSbkOOw1ie1stbUgKHKWqmfH2kvyA7KztJ8oqspEsFpPKQlOydq7IMznv
         ufV1sDYW1m/KOy1CuVXtRX2yg8wvgU1LkaWJF0o/qjEhhZI0rlSz4wDfk0gljMFuf3Ln
         f4roGE+kzbr2/rQA2bF0/a+x4VZhcPmM7Kzd+csguQjIR7xsxB1t35yN9OH7jyXqx/3v
         +6QDeQe88GOAHWGCKWfnw00ZicXeR5om2UpPShtt4iBpgJUH6cUfGo2tlFgCokjXKkSP
         xWhcTKsqIrj+getmLsewUpGzJPKJHR1Gc5ckafxTg3NatbCXl9bzY/b5LS6Kdk7eXXCT
         dXug==
X-Gm-Message-State: AOAM533a+nBJVI2bxNnTmp4ADb5NSF9C9qwtof7CD0SfD2dG7n7mIvn9
        chyN/ugUX3T84f+K0VXgBCI9e5IZjQ==
X-Google-Smtp-Source: ABdhPJxv2Ot34RxVC2xJ0cMsLDuUENvC7xNWUpRNm7n8iUeJR1ye6f3+WgWQS4WtMn+OZXXvuRQNZAs1AA==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a25:a525:: with SMTP id h34mr1545139ybi.168.1633567592745;
 Wed, 06 Oct 2021 17:46:32 -0700 (PDT)
Date:   Wed,  6 Oct 2021 17:46:26 -0700
Message-Id: <20211007004629.1113572-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 0/3] binder: use cred instead of task for security context
From:   Todd Kjos <tkjos@google.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series fixes the possible use of an incorrect security context
when checking selinux permissions, getting a security ID, or lookup
up the euid.

The previous behavior was to save the group_leader 'struct task_struct'
in binder_open() and using that to obtain security IDs or euids.

This has been shown to be unreliable, so this series instead saves the
'struct cred' of the task that called binder_open(). This cred is used
for these lookups instead of the task.

v1 and v2 of this series were a single patch "binder: use euid from"
cred instead of using task". During review, Stephen Smalley identified
two more related issues so the corresponding patches were added to
the series.

v3:
- add 2 patches to fix getsecid and euid

v4:
- fix minor checkpatch issues
- fix build-break for !CONFIG_SECURITY

Todd Kjos (3):
  binder: use cred instead of task for selinux checks
  binder: use cred instead of task for getsecid
  binder: use euid from cred instead of using task

 drivers/android/binder.c          | 14 ++++++++------
 drivers/android/binder_internal.h |  4 ++++
 include/linux/lsm_hook_defs.h     | 14 +++++++-------
 include/linux/lsm_hooks.h         | 14 +++++++-------
 include/linux/security.h          | 28 ++++++++++++++--------------
 security/security.c               | 14 +++++++-------
 security/selinux/hooks.c          | 48 +++++++++++++-----------------------------------
 7 files changed, 60 insertions(+), 76 deletions(-)
