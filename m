Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037ACC433B4
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96CE61244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhECRyw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhECRyv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB76C061763
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b25so9187456eju.5
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMt43KJT+WxO1UdHWmvdY4lRxHbY73oczquAa6vXswU=;
        b=RqT63lTcUf0KdeEBiguh+vnqP8cL42pUl/0xzJ5Rj41vLMk5Ky6QP0JRC/6MhOA5C+
         U0eYVRqZcd2s07SpQb5al5MPLClR/eRiXNvV/Bt2WU9aKGlACBe+6pZGjFWux0pTgM46
         WSFsrVCCRf35nyKaa/lNpOxebx05nl9TOg6gKrHyQbySTWaJ8+07MgyfA2ZaSDiMykW+
         WDAKAuRC0KlRB4huS6//LP0OsE9lvXw4vfeV4dORu1s2EVsI6dUZKmZUtU4Xa4isxZlo
         bWpIA+TcDrtaopGJ+g+qS9VIStrA1n4smh8ZCBXesejgcOWdquvHJu0nUFTkDH3YUavJ
         vWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMt43KJT+WxO1UdHWmvdY4lRxHbY73oczquAa6vXswU=;
        b=NsMgyOM2hZfqfIw3jWuYg87Lm3LJAKfOHJFa8WgFvTP7DXdUDo4F0nTNhLNDlSbcRC
         p4cZ37AVg+ZoPMFE3PyPxH5Ux1ItgcprtPVxIVF3tySSxrcaGiKSRsu9CH6B88mJXxn5
         K2V/3PKxN86j5Vlzr9/lYohtkCuFrPPAdexYPSCwdzUBDVTk54sDki8lmd0msdkF/f2O
         LpGonPN3Nf9Ke8+sNi2Hwa+7ChwyktPOweSAayeZf97TxBUGaOAW2s9uGQsLqdufK5pR
         gTNiric49sJIKGST40usPGAPvpxGKE8qBhtQ3yBDkGSQs0warFnaiyk0ies7imcHxfxQ
         5kIg==
X-Gm-Message-State: AOAM533CKU0KHTMsHIHUxXWVkEJdTThxGgxgxo5FtXbPNuwc2WKWrLAd
        Ph2/qjnE314Ljh3lT/FS5nwrXpELnAp6QA==
X-Google-Smtp-Source: ABdhPJxOGfWX2IHPJ1f9xaRS7zzMuIo+oGtc/Q5NK/lkJWsoqN+9CL+m4mi4F8aSkjK7aseUeocbYw==
X-Received: by 2002:a17:906:5c52:: with SMTP id c18mr18351881ejr.354.1620064435825;
        Mon, 03 May 2021 10:53:55 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 00/25] libselinux: misc compiler and static analyzer findings
Date:   Mon,  3 May 2021 19:53:25 +0200
Message-Id: <20210503175350.55954-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Several changes found by compilers and static analyzer regarding const
qualifiers, dead code, code smells and resource cleanup.

Contains no changes with regard to libselinux callers.

Christian Göttsche (25):
  libselinux: sidtab_hash(): do not discard const qualifier
  libselinux: selinux_file_context_cmp(): do not discard const qualifier
  libselinux: label_common(): do not discard const qualifier
  libselinux: Sha1Finalise(): do not discard const qualifier
  libselinux: sefcontext_compile: mark local variable static
  libselinux: avcstat: use standard length modifier for unsigned long
    long
  libselinux: selinux_restorecon: mark local variable static
  libselinux: selabel_get_digests_all_partial_matches: free memory after
    FTS_D block
  libselinux: getconlist: free memory on multiple level arguments
  libselinux: exclude_non_seclabel_mounts(): drop unused variable
  libselinux: context_new(): drop dead assignment
  libselinux: label_x::init(): drop dead assignment
  libselinux: label_media::init(): drop dead assignment
  libselinux: setexecfilecon(): drop dead assignment
  libselinux: getdefaultcon: free memory on multiple same arguments
  libselinux: store_stem(): do not free possible non-heap object
  libselinux: matchmediacon(): close file on error
  libselinux: init_selinux_config(): free resources on error
  libselinux: label_file::init(): do not pass NULL to strdup
  libselinux: matchpathcon: free memory on realloc failure
  libselinux: label_db::db_init(): open file with CLOEXEC mode
  libselinux: drop redundant casts to the same type
  libselinux: sidtab_sid_stats(): unify parameter name
  libselinux: regex: unify parameter names
  libselinux: label_file.c: fix indent

 libselinux/src/audit2why.c                    |  2 +-
 libselinux/src/avc_sidtab.c                   | 15 ++++-----
 libselinux/src/context.c                      |  2 +-
 libselinux/src/is_customizable_type.c         |  2 +-
 libselinux/src/label_db.c                     |  2 +-
 libselinux/src/label_file.c                   | 16 ++++++----
 libselinux/src/label_file.h                   |  8 +++--
 libselinux/src/label_media.c                  |  1 -
 libselinux/src/label_x.c                      |  1 -
 libselinux/src/matchmediacon.c                |  1 +
 libselinux/src/matchpathcon.c                 | 32 +++++++++++--------
 libselinux/src/regex.c                        |  4 +--
 libselinux/src/selinux_config.c               |  7 +++-
 libselinux/src/selinux_restorecon.c           |  7 ++--
 libselinux/src/setexecfilecon.c               |  1 -
 libselinux/src/sha1.c                         | 10 +++---
 libselinux/src/sha1.h                         |  2 +-
 libselinux/utils/avcstat.c                    |  4 +--
 libselinux/utils/getconlist.c                 |  1 +
 libselinux/utils/getdefaultcon.c              |  3 ++
 libselinux/utils/sefcontext_compile.c         |  2 +-
 .../selabel_get_digests_all_partial_matches.c | 10 +++---
 22 files changed, 76 insertions(+), 57 deletions(-)

-- 
2.31.1

