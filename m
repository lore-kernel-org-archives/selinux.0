Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFE9C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 11:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA7C2073E
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 11:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JthYZ2pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEDL7d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 07:59:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53505 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728029AbgEDL7d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 07:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588593572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J6p4Ww+xvVudISCyaWaHF6UQ99ZIoypbibTw1/O4b84=;
        b=JthYZ2pM0LQOXyetKA/Ydo0e4DK5xZun21n9yIKv/XlfjR463zSNnUE7BviUUxsedoqoR4
        ryt8PmgkJPhJW2ewUmKOcAwrRdLi97hhxSti2io6V4pyeRKUe7FAA7CFnRWbfgcaoTMVKJ
        JDOQRknvnNa9fq0pFQrz9Hgd3Vjl2TU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-jIaXCQa1Pm2Mr4Ov38eggg-1; Mon, 04 May 2020 07:59:28 -0400
X-MC-Unique: jIaXCQa1Pm2Mr4Ov38eggg-1
Received: by mail-wr1-f71.google.com with SMTP id e5so10583277wrs.23
        for <selinux@vger.kernel.org>; Mon, 04 May 2020 04:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6p4Ww+xvVudISCyaWaHF6UQ99ZIoypbibTw1/O4b84=;
        b=gHe9dgPTWpMrgevP1X23/S36/0GWqtGR7GFUraIv6RxTe7kmO57E7Iku80GjZQjj5g
         AIZ7vcKyF7DZGHLJpDU13I3UkcfrqtLqF0l/Dv+cRlaXkkls1P+GV5nR/oeZU5/zlakX
         NypF41hOlEdAUypR574ZnOJzeCzTUf+febl37dCjxMNdUv2cTaKHonnwyolqrwL3qIqA
         SAX/NflP4tM9H552oz4hYaKQlbTOy/bobpJ0zMgaaeiybdqDuE1z5qwRhjQeImKshRFn
         koVqW8r2X332WALnktgROCQ2++X8BW+U0A+k9D4Zi9CFjYEFcG5ue03bTEFopAIRrxqi
         PQ3Q==
X-Gm-Message-State: AGi0PuY9YC9WzTdxPj0cLCbtu6brrNve6rwEi80nOJAWDFOJISoM+PKH
        lm+boWpQH1VeAdZD3VPPZtwgsYGtWRcB2yOgEGfVOot9WD/wMRDflV6ts8lZpow7CNzQZKppqFF
        2K0IlkpRU6AY8Iw0l0Q==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr14267457wmg.177.1588593566582;
        Mon, 04 May 2020 04:59:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypK2SN44I0KXADknW9mWuh8bkzomQe+lY6wG6/NteB5yiEglBvORNuHL03BSFxRpY7Ws5FG2aA==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr14267438wmg.177.1588593566364;
        Mon, 04 May 2020 04:59:26 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y9sm12524724wmm.26.2020.05.04.04.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:59:25 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 0/3] Inline some hashtab functions to improve performance
Date:   Mon,  4 May 2020 13:59:20 +0200
Message-Id: <20200504115923.88828-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Right now, hashtab_search(), hashtab_insert(), and hashtab_map() are
defined in hashtab.c and need to call functions indirectly by function
pointers. It turns out that defining (the relevent parts of) these
functions inline in the header and passing the function pointers as
arguments makes them significantly faster (verified for hashtab_search()
at least).

The first patch is a minor refactoring of symtab usage in preparation
for the next patch. The second patch modifies the hashtab interface so
that callbacks are always passed directly. The last patch finishes the
job by moving some of the function definitions to the header.

The last two patches could be also just one patch, but are kept separate
for easier review of changes in the functions that are being moved
around.

For more details, please refer to the respective patch descriptions.

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
 security/selinux/ss/hashtab.c     |  79 ++----------------
 security/selinux/ss/hashtab.h     |  98 +++++++++++++++++++----
 security/selinux/ss/mls.c         |  23 +++---
 security/selinux/ss/policydb.c    | 128 +++++++++++++++++++-----------
 security/selinux/ss/policydb.h    |   9 +++
 security/selinux/ss/services.c    |  38 ++++-----
 security/selinux/ss/symtab.c      |  21 ++++-
 security/selinux/ss/symtab.h      |   3 +
 10 files changed, 232 insertions(+), 173 deletions(-)

-- 
2.25.4

