Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE2C3F2C6
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAE52469B
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 23:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adf7hKIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgB0XBi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:01:38 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43210 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgB0XBi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 18:01:38 -0500
Received: by mail-pg1-f180.google.com with SMTP id u12so438321pgb.10
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 15:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=gQisnsuFcUeViuet+CIEGLtXTXPFuf8/hNZVREFfPw4=;
        b=adf7hKIYEuCXtRG7tjjyvmC4lCutSA7pzexZKw73n8E6efmgsY8WXI4ac13RS3xeUB
         ANDckTVniuYbl6H4pP2aagtvJ24AMi2jdhbLC8mvmZ4pea1It49DM3Zza8SbT7PqN7Qf
         0KJKmtSXlwYQ/9FYbN/HmIps1vIWomkIjChJphoEqyV8EvyBgLBPkrAZwpTsB9KFJP16
         qHcAFDTBsNNsahFDpSXzjYxp8CBwPzB7xr4mTqF+jfc3gZzuNVw+e+JcUqBI8ND9gswZ
         YGiZDoheSDGE+ounU3g0WrWaOM75XhY+EC95UWHdJLtWy0t07yEFs0iI5U1ctJlaKTru
         adAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=gQisnsuFcUeViuet+CIEGLtXTXPFuf8/hNZVREFfPw4=;
        b=rGwhr5p8AYDAB9rwpNsPufVldPbWrteoToQ4tFJ2N88z7a5CxbX98Bx5NJq2k46MYy
         RxEhpJkqMC4w/OsBuOOJOSwm8oYjA0CPZ/aszW34oPpuHzkmL0FOYyF++gWOYWe2Oueb
         iS1MGKylQkoV70/AbV4T1TQXn0XV7a17Z/MzbuxIOP/+McLCJHUpbIk3Tpikkg/3wMPr
         2yi0kY4nNIizuqoLZ3MNPay12vWEvpqTt/T6QvnCHaA2FjuXPjsxkYSGoxLJjmm4ecp/
         kaORdYC7lCcLOL/2BKhovOKBaq1m98vMEvEOoJhnHgyC8sIuvqcebUbA1ABuTUZ9htMG
         PW/w==
X-Gm-Message-State: APjAAAU/A/Jh4Bz3ILSqieMR5KRG3R3DImpgOJj1pJbvIuOuzKXTiIEX
        1gwjbY/3bVPD35fncqv3vegoC1xE
X-Google-Smtp-Source: APXvYqzSCjrBfLjGBWbwHgwH+ZlHB8+W3kibIeLSL7+YEdV78firarU4rEixcPqaGJh2+x2WK4YcfA==
X-Received: by 2002:a63:4757:: with SMTP id w23mr1617333pgk.115.1582844497154;
        Thu, 27 Feb 2020 15:01:37 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id b27sm7749969pgl.77.2020.02.27.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:01:36 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Subject: libselinux: drop dso.h
Date:   Thu, 27 Feb 2020 17:01:26 -0600
Message-Id: <20200227230129.31166-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This three part patch series drops the dso.h and hidden_*
macros.

The old dso.h functionality provided libselinux with both control over
external exported symbols as well as ensuring internal callers call into
libselinux and not a symbol with the same name loaded by the linker
earlier in the library list.

The functionality is replaced by a linker script that requires public
API to explicitly be opt-in. The old method required that internal API
be explicitly annotated, and everything else is public. This should help
make it easier to control libselinux DSO hygene going forward.

The second functionality is replaced by compiler option
-fno-semantic-interposition

Note that clang has this enabled by default, and thus doesn't need it.

See:
  - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition

[PATCH 1/3] dso: drop hidden_proto and hidden_def
[PATCH 2/3] Makefile: add -fno-semantic-interposition
[PATCH 3/3] Makefile: add linker script to minimize exports

