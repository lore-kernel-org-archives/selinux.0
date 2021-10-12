Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBE5C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 16:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6B1604DC
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 16:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhJLQ6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhJLQ6W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 12:58:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E7C061570
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 09:56:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so27766836ybk.16
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JIJ5w4TMIICbNZUaDbjDGcHk/fSmd140jim7+0P9yU0=;
        b=TLi8XuzJrNiANRZDenlegnRSqXYaupn5KIuT6u+AGmWVTesxYxntdjILdiFZ+4PrhJ
         7/PAyZELdXYJpgv4pcmR30N9qdukWeLRK2+vJdjCh1wkQWtBdTlJRzNbG/suobRZniwJ
         mKzHZawACwZ8NAsZ92hZhXVvPOHIAaRwBVJIMXeMLtpTizrLqt4w3QpSPo0NlQyuL4Hs
         kLttaXi5jKewEVyxlw0/uO+UTCaOZ819/kfVmwDijiMJCZ6AQ7SGhPUQ4McuL/eOImAT
         Tyfi+2WRtwLKELmBp/XqbXRxrgtsNXkESC1z33xHdHzZjKvrrylU5YD7k7U8TfUZ2nT8
         WwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JIJ5w4TMIICbNZUaDbjDGcHk/fSmd140jim7+0P9yU0=;
        b=t34PIwTm0jkZhEByx1uCW9oh6Fg4SKCRPndLEnHpz0fegQpuc6VMFWLIlGcNWhLKQ/
         lT+s0UgoN5awo2DVy5FMnWooWFYFJFh/qJtrdC/3h2iDW1izEcrHoIR7fKrmOYjCs/8t
         iFazWM4liLL3m4vJh0+3wJsgrxAezaydWTpFhevBlDU+2Yv+LpqWw1Y7PXKntY5peS4+
         fIXQMjuJHgOiBI+qh9YhNiatYamCL9D7KYYIA/A8Dpzipt04rcA63LbhGyI4Yl2RwvpK
         tSvU+sZ9laOpa9uiijGlwvclioNfBOCtaMh+y9Yu09aykCY67VYOrNNh3BoWMJccqODe
         /SoA==
X-Gm-Message-State: AOAM530bpCmjRdFDWjHcSLBvzeVl19D+vYYXW9cYipuwMyCa4gfhvLCV
        02hKAFq6uHd1AyBTNiOf3TTKOKcw3g==
X-Google-Smtp-Source: ABdhPJyibaELnh3cCCM9a3Gh2OX2BWVk12YMcQGBurcM2T2GnhfAla+oUTJFMwQRfPSCuXIJVzOq7Gdcqw==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:39c7:8168:c0b2:b46e])
 (user=tkjos job=sendgmr) by 2002:a25:c013:: with SMTP id c19mr30563608ybf.255.1634057779213;
 Tue, 12 Oct 2021 09:56:19 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:56:11 -0700
Message-Id: <20211012165614.2873369-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v5 0/3] binder: use cred instead of task for security context
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

v5:
- reorder/refactor patches as suggested by Stephen Smalley so eiud fix
  is first and saves the cred during binder_open()
- set *secid=0 for !CONFIG_SECURITY version of secuirty_cred_getsecid()

Todd Kjos (3):
  binder: use euid from cred instead of using task
  binder: use cred instead of task for selinux checks
  binder: use cred instead of task for getsecid

 drivers/android/binder.c          | 14 ++++++++------
 drivers/android/binder_internal.h |  4 ++++
 include/linux/lsm_hook_defs.h     | 14 +++++++-------
 include/linux/lsm_hooks.h         | 14 +++++++-------
 include/linux/security.h          | 28 ++++++++++++++--------------
 security/security.c               | 14 +++++++-------
 security/selinux/hooks.c          | 48 +++++++++++++-----------------------------------
 7 files changed, 60 insertions(+), 76 deletions(-)
