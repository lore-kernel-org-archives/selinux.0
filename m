Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8E6C433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F181564F8C
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 17:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhBCRRp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhBCRRl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 12:17:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1D3C0613D6
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 09:17:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l12so524896edt.3
        for <selinux@vger.kernel.org>; Wed, 03 Feb 2021 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i33UezBDuD8/xEWYRdQB0AXv1sicv5L8V0h+HMhsnDw=;
        b=mF3qAsxzg4X9W2mCI2cbS+FQs4EeuP6BM+FURsfEL3bOIFCIrkeVPC6VuKX642clOM
         naUBFyh4rWn/ACHJG0s9DxN6cu1aPvOeGStq4FgfjeKreiA+gIAjeuhXUacwKOKH5yXD
         8EKUVRbZlZgwv8NdSvofwrohyWy2B/ohAZVcm5Lte1cxRJ7B/VP0RVunx/fjKwNorDcL
         bFkW5SfoWAm6qP01HuJnUQfDDguSOMUrAXWZx+BustTtEsoz4ZUeRp+z81GXoKcnQCTx
         ATCpYX5D/EMnKDvvIUpDSzZcASNKaCW0vPSNnPk3pzkjzS/pugNEb+XFc8bbUAE/l39k
         O/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i33UezBDuD8/xEWYRdQB0AXv1sicv5L8V0h+HMhsnDw=;
        b=lhli9b8F8eWkGZmhnOTq7cvn0qPquq5wW7eT8Y7R1/ePSoO2AOlv7Mw0EyzQQ727VE
         f0t3Eo/VMN4gilK76S+CCFrS8qx9cF3gRsBkLK2m77dlIeTHWxi0MDj/fDLHYdsNTGh5
         Y2CZd0ij7uU37LfMBRCjcSGLyKXAVUMFRxbzPG9eypiWSNGEOOGtLNqCgNxF+smX/+Uz
         tMOqDWIlg+yhp7wKLaqkEEaSccHQ3lga8TuueQtdIe7AgBAO8enorwFV3SlSa/ZzpFzU
         MmSUnuTtHZTrDNAOzz3KlshBbRN5u8hHMULuPXPfjqKPpBVxQNpqFhXcGCPMv80cqPEc
         rBQA==
X-Gm-Message-State: AOAM531V8SDCC0oWGA3iMmcWxoi6eNI+KhAeUeTIKsORO27wM0QgJb0b
        GsbVI9V7XM510AxwDJSvx8MPTdQLSFI=
X-Google-Smtp-Source: ABdhPJxyusgpspjfc2be5ZFqlqN/Z9d5X1js89kWM73mWeqhDZCv/gDUI2+YSQTQf44a3NwscXxocw==
X-Received: by 2002:a50:998f:: with SMTP id m15mr4085541edb.342.1612372620786;
        Wed, 03 Feb 2021 09:17:00 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-080-008.77.0.pool.telefonica.de. [77.0.80.8])
        by smtp.gmail.com with ESMTPSA id z16sm1256353ejx.73.2021.02.03.09.17.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:17:00 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] policycoreutils/fixfiles.8: add missing file systems and merge check and verify
Date:   Wed,  3 Feb 2021 18:16:54 +0100
Message-Id: <20210203171654.37002-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210203171654.37002-1-cgzones@googlemail.com>
References: <20210203171654.37002-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mention the supported file systems ext4, gfs2 and btrfs.

The options check and verify are interchangeable, merge their
description.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/scripts/fixfiles.8 | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 12342530..c4e894e5 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -35,8 +35,8 @@ database (extended attributes) on filesystems.
 .P
 It can also be run at any time to relabel when adding support for
 new policy, or  just check whether the file contexts are all
-as you expect.  By default it will relabel all mounted ext2, ext3, xfs and 
-jfs file systems as long as they do not have a security context mount 
+as you expect.  By default it will relabel all mounted ext2, ext3, ext4, gfs2, xfs,
+jfs and btrfs file systems as long as they do not have a security context mount
 option.  You can use the \-R flag to use rpmpackages as an alternative.
 The file /etc/selinux/fixfiles_exclude_dirs can contain a list of directories
 excluded from relabeling.
@@ -79,7 +79,7 @@ Modify verbosity from progress to verbose. (Run restorecon with \-v instead of \
 .SH "ARGUMENTS"
 One of:
 .TP 
-.B check
+.B check | verify
 print any incorrect file context labels, showing old and new context, but do not change them.
 .TP 
 .B restore
@@ -88,9 +88,6 @@ change any incorrect file context labels.
 .B relabel
 Prompt for removal of contents of /tmp directory and then change any incorrect file context labels to match the install file_contexts file.
 .TP 
-.B verify
-List out files with incorrect file context labels, but do not change them.
-.TP 
 .B [[dir/file] ... ] 
 List of files or directories trees that you wish to check file context on.
 
-- 
2.30.0

