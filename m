Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02E0C433E0
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB83E20772
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 11:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9jhkPWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGHLYz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:24:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45251 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728592AbgGHLYz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 07:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594207493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VqtxgF11JBqYTP6ZSPMgqI7bipRcyMuHXdMtE/R3AH0=;
        b=S9jhkPWesC/CKmEzgxwtP6ZdJtPxLJ7BJqhy0QpMWkx0ZHb6IkTVNo+hN+/TDDNCVVPq4W
        pry/0ZYmeJ5xlZK2GN0rGzP810X6KMgiC0CYhAyCAcaduaUj6QyM4/GlDpvpbnNGv2nPTW
        L26B+HtjvWwoS9t7fYg2A78RomiEDmk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-LMAs8O_JM2ubO52yoeVL_w-1; Wed, 08 Jul 2020 07:24:51 -0400
X-MC-Unique: LMAs8O_JM2ubO52yoeVL_w-1
Received: by mail-ed1-f72.google.com with SMTP id y4so46984165edv.17
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 04:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqtxgF11JBqYTP6ZSPMgqI7bipRcyMuHXdMtE/R3AH0=;
        b=Z8rBE0vql5PSB3dG4jOiVenb/19xINclkxyVQ/eo5gmQY4aQE6ZmFv3mPE+0OZdqtH
         l5wMgOHOiqUys8iDhTd9zIEOgC7GLHtoy/c1+TmWqZkvlLi9PxsrWUBDgju1Yoi+nWww
         jO/3zUvPDvesauP8tLwTgG4eO9H3hwDADiufx2D5f6A4oTRlu816FNKUj72USRYlBI5e
         2l30x2At1BTN1GSOfrF1IVr3qefi5IoVlNlZfsKynTjL4wab1WZg4jWaHFovVVMa7nqc
         /NGYA7URa+4q61nxfxwqP7SHICX2O5ikYbrgjksyo7cHqmvxvyZmh2Nt+WjZPoGt5LBI
         q/zg==
X-Gm-Message-State: AOAM532HV+TjigFXPjo4pP7lCbnq/es7CUTSU0crrw73PpWIcfDquiWu
        YyIfo5LEBe22p60TIQJ0BCuilQ+LwvmqJME0XiKCUHLhjFUNIpohnne3acYWPTkAs11BHTNoJAA
        eP7ra8yZ8FOfRbxPNug==
X-Received: by 2002:a50:9b5d:: with SMTP id a29mr63635983edj.68.1594207490255;
        Wed, 08 Jul 2020 04:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkBgS5qM8QSE/eX5OxUeFuDiT/orJUI3XiNNpvH7LrpJFOfOF9uSBMVHjmR8pOjkNZJNdW6Q==
X-Received: by 2002:a50:9b5d:: with SMTP id a29mr63635970edj.68.1594207490008;
        Wed, 08 Jul 2020 04:24:50 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm1839374ejd.50.2020.07.08.04.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:24:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 0/3] Inline some hashtab functions to improve performance
Date:   Wed,  8 Jul 2020 13:24:44 +0200
Message-Id: <20200708112447.292321-1-omosnace@redhat.com>
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

The first patch is a minor refactoring of symtab usage in preparation
for the next patch. The second patch modifies the hashtab interface so
that callbacks are always passed directly. The last patch finishes the
job by moving some of the function definitions to the header.

The last two patches could be also just one patch, but are kept separate
for easier review of changes in the functions that are being moved
around.

For more details, please refer to the respective patch descriptions.

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

Ondrej Mosnacek (3):
  selinux: specialize symtab insert and search functions
  selinux: prepare for inlining of hashtab functions
  selinux: complete the inlining of hashtab functions

 security/selinux/ss/conditional.c |   4 +-
 security/selinux/ss/conditional.h |   2 +-
 security/selinux/ss/hashtab.c     |  59 ++------------
 security/selinux/ss/hashtab.h     |  77 +++++++++++++++---
 security/selinux/ss/mls.c         |  23 +++---
 security/selinux/ss/policydb.c    | 128 +++++++++++++++++++-----------
 security/selinux/ss/policydb.h    |   9 +++
 security/selinux/ss/services.c    |  38 ++++-----
 security/selinux/ss/symtab.c      |  21 ++++-
 security/selinux/ss/symtab.h      |   3 +
 10 files changed, 214 insertions(+), 150 deletions(-)

-- 
2.26.2

