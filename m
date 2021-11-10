Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8780C433EF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD7F60EDF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhKJOuV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhKJOuV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 09:50:21 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51851C061764
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:33 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z9so2273379qtj.9
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyRglnk0GL7JCjkXyhYnizmVg+OnrsecD77fGERZXFk=;
        b=A2NkFNM2ODclk8eJe5PIJNH5GqoFxPMnZ6Qc16MH3q5C5G1GkTkiUeLgkMiMd8P/pl
         m4jqAOZdfpppUuaqvwel7UKsDAVOwKNELA/zt1fPUrrUOMGZgyt5o00q+JHQOBVER59D
         DZHE83JBxzfHveWP/K6vmATRS1ZN7fP5rR6wWAX8IfXcHg/U84vaorxeSNxqXTaY1ZqM
         PnGojdlo2uR2FqxexOKky9I61Skb8lni2kq8dzOnKA5aUITqS2Ly2qXVYBQcjk/TjxOk
         /g1+JyprKhQUCJxQMJiCXXzbBURNtDQntaugd33HsQW6kVaqYg6Jm65qWC88u1lBQXU9
         VuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyRglnk0GL7JCjkXyhYnizmVg+OnrsecD77fGERZXFk=;
        b=b0FMzL0121Yx+27sYp9aGmm69QC70fbg5ey3rZDiqAcsOZhleZNRkP8Qx46uzaRw5f
         OSypoo3X5XlCTECkP/6eaV7hIOih9ybQ9T1NPiYg05iSkSCgEjNOjODfDS6mUNyEjUI3
         ZY0RF6VYFCarpWqM6ddb8LynQrVizX1Wzm1ICBlASmoO7MWu6DKB54f4Hi8TKw+M55gn
         QzLCcesoDJ9O2XBrZFLTlxkNP40lw6jsRjQP7ZpyqYSMDdGWNf0v5LFmPQgZUxJRfYC5
         c+13VIz5Z3MIZ06SWB2W47P+um/9/exob3xxD1x+DqSYVC0gT8d+l+nynukHFpa+h+RV
         tkIA==
X-Gm-Message-State: AOAM5312/avzWrZ9UJrxlP087sKiyLwxjrIuqO0UDrMFYOvzn5aGgCaZ
        vsZXm9BkZyus9fncXqUrCMlvIJ0iPz4=
X-Google-Smtp-Source: ABdhPJzzevrIr98+H7N2tCw7GRvXodjU9njSYH32RfpAqZ3UdHMU8MqKNlteDTdqh6s4Qhhahd8qGw==
X-Received: by 2002:a05:622a:116:: with SMTP id u22mr103905qtw.193.1636555652447;
        Wed, 10 Nov 2021 06:47:32 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r10sm58633qta.27.2021.11.10.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:47:31 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, stephen.smalley.work@gmail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/5 v2] Fix/add optional file type handling for genfscon rules
Date:   Wed, 10 Nov 2021 09:47:22 -0500
Message-Id: <20211110144727.1467744-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

genfscon rules have always supported an optional file type, but when
the ability for writing a policy.conf file from a kernel policy was
added to libsepol it did not include that support. Support for the
optional file type was also left out of CIL genfscon rules.

This patch set fixes these problems.

Patch 1 adds support for writing the optional file type in genfscon rules
when writing a policy.conf file from a kernel policy.

Patches 2-5 adds support in CIL for handling an optional file type
in genfscon rules, updates the CIL documentation, and adds support
when writing out CIL from a kernel policy or module as well. 

James Carter (5):
  libsepol: Add support for file types in writing out policy.conf
  libsepol/cil: Refactor filecon file type handling
  libsepol/cil: Allow optional file type in genfscon rules
  secilc/docs: Document the optional file type for genfscon rules
  libsepol: Write out genfscon file type when writing out CIL policy

 libsepol/cil/src/cil.c                      |  6 ++-
 libsepol/cil/src/cil_binary.c               | 37 +++++++++++++
 libsepol/cil/src/cil_build_ast.c            | 49 +++++++++++++++---
 libsepol/cil/src/cil_internal.h             |  5 +-
 libsepol/cil/src/cil_write_ast.c            | 57 +++++++++++++++++----
 libsepol/src/kernel_to_cil.c                | 35 ++++++++++++-
 libsepol/src/kernel_to_conf.c               | 35 ++++++++++++-
 libsepol/src/module_to_cil.c                | 27 +++++++++-
 secilc/docs/cil_file_labeling_statements.md | 10 +++-
 9 files changed, 234 insertions(+), 27 deletions(-)

-- 
2.31.1

