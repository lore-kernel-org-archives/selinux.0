Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE8FC7EE25
	for <selinux@archiver.kernel.org>; Mon, 12 Jun 2023 09:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjFLJns (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jun 2023 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjFLJnQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jun 2023 05:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5A47DBF
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686562272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d5UFRjQWzfS/kWfwsCLVbA2JvQqbDHf89Mg0dxXk9Bc=;
        b=XBtLnb5Ap3EUZ4y84hLnbnTaAufGNcZ6LJhRXONkYME31Lknw9XN6gKRxjupWQxI7QERG1
        l+3CLDZ+8V/Dybl4Znkf/4IaoLi5Xg5H2IJB2bHeNewFtBKC7uF7LYg26bo71aDgjsZbRM
        sY7AHDv5/UiwgmqMhutd0tBMJzH1epY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-HHLJlNxxP8qJzGuW6Ypm2w-1; Mon, 12 Jun 2023 05:31:11 -0400
X-MC-Unique: HHLJlNxxP8qJzGuW6Ypm2w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-514b19ded99so3376315a12.0
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562269; x=1689154269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5UFRjQWzfS/kWfwsCLVbA2JvQqbDHf89Mg0dxXk9Bc=;
        b=Bf4OEvin93mEw+OUv9AJFX81TmuWogUU2RPLF+sL4yKZaE2efiGwtNEs05RknnjlMJ
         ToNkMFssDzLsmnonH3HlRND4NRcKfI5cTpfVO5FVUIK2qcN4RB+ofTudNUmQEP2bxHFQ
         QVMijeNDXC4JdqG5NLPdSk4y42YAjG80hY9C3qVH4en2i9L5eEeMG5HO82F4tlHNEUhR
         D7hgk21EzAvf6C0+nmVGewdEociJm40fEe/zr3xDLUSpD3BTPfncTuyszD6q+Ft5A9G0
         xbBsi2YNwjU7kPa2kq6sapNizIpD+wIhBYUF21VEqaSBsr4ulSfLVtK0xAUcoDdW/Yqt
         Tt8w==
X-Gm-Message-State: AC+VfDyggRXW2ED8y5FdZNfA1v/5OJeMYULMXOw1q8pNsYBk9zSkQvCQ
        5a8miCaELhO1hH+k7rO5hr6/FBdv+ERBN3g3xxN979iV3J8pjQ4g4abgOC0y7ymJknUI6Wm6c9L
        D6sqWBTwBLUfg6/3litK7W8KLPCOiFX5YTO8q+fAF84YbVgB6b8wqJ0wnftb7s2svthuJKYW4io
        0uNFEa
X-Received: by 2002:a17:906:ee82:b0:96a:ca96:3e49 with SMTP id wt2-20020a170906ee8200b0096aca963e49mr10272382ejb.13.1686562269705;
        Mon, 12 Jun 2023 02:31:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5egXEIzZiOY/CpVmAHkHWrsZj/awBzRPIC6c375leplM/X1E+u2LVGezVr5I1PCFTJ6t/mmA==
X-Received: by 2002:a17:906:ee82:b0:96a:ca96:3e49 with SMTP id wt2-20020a170906ee8200b0096aca963e49mr10272368ejb.13.1686562269360;
        Mon, 12 Jun 2023 02:31:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906a28800b009655eb8be26sm4958000ejz.73.2023.06.12.02.31.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:31:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 0/2] Introduce an initial SID for early boot processes
Date:   Mon, 12 Jun 2023 11:31:05 +0200
Message-Id: <20230612093107.1066410-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These are userspace support patches corresponding to the following
kernel patch submission:
https://lore.kernel.org/selinux/20230612090145.1059245-1-omosnace@redhat.com/

The first patch merely removes the names of the discontinued initial
SIDs. The second patch adds the new policy capability and re-adds
the "init" initial SID's name as it's being reused for the new
functionality added by the kernel patch.

Ondrej Mosnacek (2):
  libsepol: stop translating deprecated intial SIDs to strings
  libsepol: add support for the new "init" initial SID

 libsepol/include/sepol/policydb/polcaps.h |  1 +
 libsepol/src/kernel_to_cil.c              |  4 +--
 libsepol/src/kernel_to_common.h           | 34 +++++++++++------------
 libsepol/src/kernel_to_conf.c             |  4 +--
 libsepol/src/module_to_cil.c              |  2 +-
 libsepol/src/polcaps.c                    |  1 +
 6 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.40.1

