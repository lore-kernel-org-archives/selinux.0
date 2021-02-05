Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC50EC43603
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67A564EE4
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhBEWTK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhBEOcQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 09:32:16 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F705C061794
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 08:10:09 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id a14so1440473ios.2
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=errCeBy60WZ/5hFu6jO+IeEFT3eVf90nuuRPvnSzgNk=;
        b=oehJeoFcyv8tRq6B2azBjpiH1T6mFB88Aj2jlRNRHKjyYE/pVcWy8iLUBjwqO1g22/
         mn2ebyMpY55YIFdsDrvo7qyi9su6LE5uG2X5btL1bnwjVzFk7ZiwbrmipWJ/2yOszj0R
         On1UBGxJndz52EDEKGa5uw5kcU6GVZgwntKvG7/9eynb+M/U09DxdMJPN5lKM7eA6XkR
         Zl1FSxSE8yvL9AKug8NKad42PLSxb95xURQ++yr+iL6jE8Mr2GTgk+qz8MITtd2xrxts
         CMgdoh112noNhIiwm3nAENKaafwxx2aB5tJVxyKMSabErNUDT7hEmB+ClYXCSAc0Ty6W
         PyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=errCeBy60WZ/5hFu6jO+IeEFT3eVf90nuuRPvnSzgNk=;
        b=SziF1C8EZtlX7A/hY4r6p3me7ZSiutHMAQUoCkZSl6+6pr117eLY25K3GJkXQ6Vy6z
         G4sg3bMI2mL6kTGNv/eZP2yyPOj8xpOi5cjlkuIgWRo9K+5SS4C42Ay+sesGPe6iKQEy
         yqSx0grMYH4SeCkvcLdv75fUXliaEfIzVRDYuk0tcxkty1yetxXqStUGpZjkD8+gNwGs
         N3hdQ1HpnX9AdrCCZh2VswmcPo5MH+rjB1hBYWv74lzAMZkcpuk350sJ+W/VW1S6Qql+
         JIOdQAcfPgGutkoBZCKvIPvxANKQZmLzQWgcQpXRuCXWAaCUxSZ9uU+vIu4W8nW8JSI9
         9Bxw==
X-Gm-Message-State: AOAM531iCjoeM0SUMYoaXnxBmOa9ySqXmcZaNyRG9XjBHn8TNN6iPsjE
        qSbe9WKuCp8b078cSohhi8odpJ6p3vOfaQ==
X-Google-Smtp-Source: ABdhPJy/SDP0XgfI9Pedsre/XRc8FKyRBZhezEn6fyG3XKRTEAPiAa89liyf7K+YSPGOKoeMwS8HGg==
X-Received: by 2002:ac8:4517:: with SMTP id q23mr4355185qtn.284.1612534088928;
        Fri, 05 Feb 2021 06:08:08 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c12sm8079219qtq.76.2021.02.05.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:08:07 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/2] libsepol: Validate policydb values when reading binary
Date:   Fri,  5 Feb 2021 09:07:58 -0500
Message-Id: <20210205140800.275993-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss reports that fuzzing /usr/libexec/hll/pp with the
American Fuzzy Lop revealed that inconsistent policy modules could be
created that caused NULL dereferences and other problems.

This patch validates the policydb when reading in the binary policy. See
the description of the second patch for more details.

The validation requires a negligible amount of time to complete.

James Carter (2):
  libsepol: Create function ebitmap_highest_set_bit()
  libsepol: Validate policydb values when reading binary policy

 libsepol/include/sepol/policydb/ebitmap.h |   1 +
 libsepol/src/ebitmap.c                    |  20 +
 libsepol/src/policydb.c                   |  35 +-
 libsepol/src/policydb_validate.c          | 764 ++++++++++++++++++++++
 libsepol/src/policydb_validate.h          |   7 +
 5 files changed, 815 insertions(+), 12 deletions(-)
 create mode 100644 libsepol/src/policydb_validate.c
 create mode 100644 libsepol/src/policydb_validate.h

-- 
2.26.2

