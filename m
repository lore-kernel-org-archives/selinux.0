Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E316C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7109224125
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zbw5AtYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAWM53 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:57:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36142 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726240AbgAWM53 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 07:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579784248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nlmmimid0sY1DeantLWMBQ/czSfJCxIUjm/zNfDLtVA=;
        b=Zbw5AtYbPZhZm3z+ywYBuZGMpqqnGhUb1Ww0ekABJAL6QByIbr2QvtuRDcJknKOyZ2Lkv2
        XPgmc0LZhD72QAp7gylXg9k0SkipDJgcu6C+wFTL4qL3HvuyURWPYCZF1Ix8EX7yeysZHq
        pCDY1gnk+VT8dx0pXAUYUZLaRgcBGZo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-1IurbjvKM1K1Mh-KuTyEwQ-1; Thu, 23 Jan 2020 07:57:19 -0500
X-MC-Unique: 1IurbjvKM1K1Mh-KuTyEwQ-1
Received: by mail-wr1-f71.google.com with SMTP id b13so1606249wrx.22
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 04:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlmmimid0sY1DeantLWMBQ/czSfJCxIUjm/zNfDLtVA=;
        b=dAZ7QdSDHgdjioSSKhQzUCwoNH1ImlpMuY3W4zrEsb+70gO+bpvVec7jYpvKu1QESz
         XrHiIYGdfhUDqKTDYe5Hkgw7ltbZzNlfx63BojMBpSix4Kq6R0ozukIoxt4Fj+glz7GA
         YWsyYBetXUTfqlj6e1u33XMa3/gn7g/Ty4cQ32x1Y3oRNq7nHGFaEOKhSr6+moJSa+HR
         Jf5M3hufMasZ896WRwymAbS/3xdZCY6htCWDS9Ybp/CI1koAfNlSWqoKdmjNd6VDVX+O
         e27oS/rewvR0+j3ypg3Kbqo9ZUkpRqB8VNjWfzCrASHeYotwMVNhQolf1FWoYpn0Za//
         gJpA==
X-Gm-Message-State: APjAAAU7Ru3GMf9JVtLyezMFeObJY3aTq0lRAGGoNUb/rN/miK8vXEmR
        HZij08W4LvQ6nVZocHz8ZI2jzmVMGSXSFts3GiEZt4JGti01d2yHrj2TAla+1OjW0qzs3jhxf3b
        1ZPOFhuGilDH/ILen1A==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3898858wmi.146.1579784238041;
        Thu, 23 Jan 2020 04:57:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzn+wsth2BT/9vQJKyLy2n4ZeKIfrRApmcqGy8WALt9zxq7qsWZfjxgHTCvwuhDv83bluPGIw==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3898838wmi.146.1579784237790;
        Thu, 23 Jan 2020 04:57:17 -0800 (PST)
Received: from omos.redhat.com (ip-46.34.233.121.o2inet.sk. [46.34.233.121])
        by smtp.gmail.com with ESMTPSA id d8sm2821028wrx.71.2020.01.23.04.57.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:57:17 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 0/4] Fix build with -fno-common
Date:   Thu, 23 Jan 2020 13:57:12 +0100
Message-Id: <20200123125716.12662-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GCC 10 is going to enable -fno-common by default [1], so fix all build
errors uncovered by it and add it to global CFLAGS to avoid introducing
new bugs.

Changes in v2:
 - remove also struct te_assert definition, which is also useless
 - redo cil_mem_error_handler to match commit 4459d635b8f1 as suggested
   by Jim Carter

Travis build: [2]

[1] https://gcc.gnu.org/gcc-10/porting_to.html#common
[2] https://travis-ci.org/WOnder93/selinux/builds/640875119

Ondrej Mosnacek (4):
  libsepol: fix CIL_KEY_* build errors with -fno-common
  libsepol: remove leftovers of cil_mem_error_handler
  checkpolicy: remove unused te_assertions
  Makefile: always build with -fno-common

 Makefile                        |   3 +-
 checkpolicy/checkpolicy.h       |  14 --
 libsepol/cil/src/cil.c          | 162 ++++++++++++++++
 libsepol/cil/src/cil_internal.h | 322 ++++++++++++++++----------------
 libsepol/cil/src/cil_mem.h      |   1 -
 libsepol/cil/src/cil_strpool.c  |   8 +-
 6 files changed, 329 insertions(+), 181 deletions(-)

-- 
2.24.1

