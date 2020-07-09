Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10CC433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502F92077D
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMnzdTYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGITUJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:20:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgGITUI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 15:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594322407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ALKj2fQRMNBb+QQfWcN9ZRGgllOb6YVqQrsNDO64/s=;
        b=JMnzdTYTwpB/5TUzeQZ1mY9oEvJfg3uivxz9eQca50sZdmyO9hvvF7tXSMvXUtcVlV179p
        Dg8BDohzmOkWhvcE9rREuHFMYSaKM4GxDaW8jB43tKj5vGIM2FMWjHBjx65s9rAYyzIKbx
        ZLD5crX9nFJJLADI+1bWhCcnKDEPmGo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-oF6W3E9HNbKK384IePLfSQ-1; Thu, 09 Jul 2020 15:20:00 -0400
X-MC-Unique: oF6W3E9HNbKK384IePLfSQ-1
Received: by mail-wm1-f71.google.com with SMTP id o138so3178583wme.4
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 12:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ALKj2fQRMNBb+QQfWcN9ZRGgllOb6YVqQrsNDO64/s=;
        b=j1wg0hoyEUBUrBGQj1XFqAlCTOyObMgSDNt4+6GmfyneLvuIMuwRvjKY4hEnyF8Wsy
         UPsD0eOrbuJaQkyX7Edc+Bg2nABa2jAxkooTkUR6j5YnaXC+M6jDlcU4hhUnaWhmw+t4
         D35xRDG+CqqKrrZlmbbca07oTCCRMKJRtadGjKRGZ7clT6uBFqf/9wIwIzzDmkJC0eEw
         PhFXYDrTs5LHw1QW9/M2+VYu9DrGbwZJqs5D46jbSlGH4wRWrwETguqjJoxlwecO0a7K
         WBXfHytR8FQU56sQJh0sTo3l3Tg30HUsunIs0gPDovBiA4Ya11vkPlVzGp2HZG7zhf0X
         qykA==
X-Gm-Message-State: AOAM530gyygzYQuPSuPtjwW0DpiK0GSgXEpU38UTxcxkEHknSpe/q2Hb
        64UgOASCTn4SK3OUT3/bQCoEbImxanA1CF5G0mFwq2MSVptHJy/sLacKHKAikPlhWPWchUORl1z
        aW+IkKWpG1uy4wVEf0Q==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr1380438wma.161.1594322394953;
        Thu, 09 Jul 2020 12:19:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynpYjROIQdclX6EAYxP0OsVUhR9xYjR7eeYNNk+O512jmsS50jLhLH5XtjM32/Z9y7iGzxtA==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr1380422wma.161.1594322394656;
        Thu, 09 Jul 2020 12:19:54 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id f14sm7205086wro.90.2020.07.09.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 12:19:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 0/2] Inline some hashtab functions to improve performance
Date:   Thu,  9 Jul 2020 21:19:50 +0200
Message-Id: <20200709191952.435970-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Right now, hashtab_search() and hashtab_insert() are defined in
hashtab.c and need to call functions indirectly via function
pointers. It turns out that defining (the relevent parts of) these
functions inline in the header and passing the function pointers as
arguments makes them significantly faster.

The first patch modifies the hashtab interface so that callbacks are
always passed directly. The second patch finishes the job by moving some
of the function definitions to the header.These could be also just one
patch, but are kept separate for easier review of changes in the
functions that are being moved around.

For more details, please refer to the respective patch descriptions.

Changes in v4:
 - drop patch 1 which is now applied
 - add ACK from Stephen to the last patch
 - use policydb_filenametr_search() in
   filename_trans_read_helper_compat()

Changes in v3:
 - add perf numbers for two more use cases positively affected: policy
   load and MCS relabeling
 - drop inlining of hashtab_map() (perf-testing that change alone showed
   zero difference in both policy load and relabeling time)
 - reword the commit message of patch 2

I intended to refactor the code to hide the awkward hashtab funcions
away, but it turned out the result would be even more messy than the
current version, so I left the other code unchanged from v2. I do
believe the performance gain is worth making the hashtab interface more
low-level.

Changes in v2:
 - drop already applied v1 patches 1 and 2
 - reword patch descriptions to better explain what is going on and why
 - split out some of the symtab changes into a separate patch
 - tweak the signature and argument names of symtab_insert()

Ondrej Mosnacek (2):
  selinux: prepare for inlining of hashtab functions
  selinux: complete the inlining of hashtab functions

 security/selinux/ss/hashtab.c  | 59 +++-----------------------
 security/selinux/ss/hashtab.h  | 77 ++++++++++++++++++++++++++++------
 security/selinux/ss/mls.c      |  2 +-
 security/selinux/ss/policydb.c | 76 +++++++++++++++++++++++----------
 security/selinux/ss/policydb.h |  9 ++++
 security/selinux/ss/services.c |  4 +-
 security/selinux/ss/symtab.c   | 16 ++++---
 7 files changed, 147 insertions(+), 96 deletions(-)

-- 
2.26.2

