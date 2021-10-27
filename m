Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5288C433EF
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3E3610A4
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbhJ0SPM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhJ0SPL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Oct 2021 14:15:11 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC59C061570
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id v17so3343797qtp.1
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AlFeat0rC243DiPHOitPDvmLRjwunfHZG1UYuRK7fOI=;
        b=dn2ukT797nc/L9vWB76ItcY3UnCLJlDOF5viCfybK69ozUM4QMkYTMMCJdfy77M8WE
         7ADA1zoLmKTrxi7Vc69wbc0HJst2DM7XOmsb95ViG5K9fFf9Z3m4vo5f3HWtrwmLqM9I
         arfpE26A3dfFBTSvJ+Ymjr1WmZ+fv2gHHgAcpdUeWD+w0ZPcpr9VBkN3Zql4SEz/zigv
         xayvTPdFjqvv2lxIr4tpKLmPXBlBhZXH3dbhLfCkDOc3ww7hdISlzEBV7Tjozs5NV62F
         1sJhZivFpacUpApisonjsdK13MMuQZHi16YOXJLun5Lj89bavOe43po5kOPOVyGX7qH3
         Tm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AlFeat0rC243DiPHOitPDvmLRjwunfHZG1UYuRK7fOI=;
        b=7sR2HpAx7xYSqMmNF95B1CHUzEC7nhrswL3xVNOcr5kfWHvhBhszEh6kAVoTsLOCWB
         eVsvipfewthGDscqlXcCN6NNw8yq36yQV8d5Ax3brGu6yRlGeAuEEZDajGGB1aD4TRHO
         QBi+dQeVdSjSACYYDrE75jC2hWUbzjrP1RbwgbYRDxkLnqAJfCD8hpgWcf2Y6EN3Ik3D
         Y0rl+i2UkqMxW43gwD7Yx4LX+A7A4lXOxpVjYkdhOBgSDCOM2fAmTSbLgNYfnTLQxFQQ
         TyDzHcL+zzOT6E2f+Oa8bXVshYJOd42GLA1aUirgbvsSjvKOZ7jTP470zgzYMZKqBfL1
         LiBQ==
X-Gm-Message-State: AOAM532PrFc1ispHSPtpUvcLvgWxUZCuIdSWc4lxOfD0mhEFJVp0d+Dm
        bmBHDO3pf2TE1PNKak/pjQQkbC5yoes=
X-Google-Smtp-Source: ABdhPJwn2Hi7EejrzH7FvUWLjT9IIoYEQdS+ryLpakPEWoTZU/9KvIcg48D6Fbsmt+x2UgwIz3OEqg==
X-Received: by 2002:ac8:7f82:: with SMTP id z2mr33115844qtj.209.1635358365261;
        Wed, 27 Oct 2021 11:12:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id l15sm440561qtk.41.2021.10.27.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:12:31 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/4] Fix/add optional file type handling for genfscon rules
Date:   Wed, 27 Oct 2021 14:12:06 -0400
Message-Id: <20211027181210.1019597-1-jwcart2@gmail.com>
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

Patches 2-4 adds support in CIL for handling an optional file type
in genfscon rules, updates the CIL documentation, and adds support
when writing out CIL from a kernel policy or module as well. 

James Carter (4):
  libsepol: Add support for file types in writing out policy.conf
  libsepol/cil: Allow optional file type in genfscon rules
  secilc/docs: Document the optional file type for genfscon rules
  libsepol: Write out genfscon file type when writing out CIL policy

 libsepol/cil/src/cil_binary.c               | 39 +++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c            | 43 +++++++++++++++++++--
 libsepol/cil/src/cil_internal.h             |  1 +
 libsepol/src/kernel_to_cil.c                | 35 ++++++++++++++++-
 libsepol/src/kernel_to_conf.c               | 35 ++++++++++++++++-
 libsepol/src/module_to_cil.c                | 27 ++++++++++++-
 secilc/docs/cil_file_labeling_statements.md | 10 ++++-
 7 files changed, 179 insertions(+), 11 deletions(-)

-- 
2.31.1

