Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814CDC433C1
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED056188B
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCWRIo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhCWRIh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Mar 2021 13:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616519316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mGXsKqwmCuWhJMJy6T6zftVw1uWRfrsTgEFydCHaDcA=;
        b=fbTbnFt1gfTaWTPQU13vGU6PZy2WtFJzKUwYGEX4TiwGCK4KX8ofpCKUgSUy1E/i3ZGobn
        Q61IM9OD75sAFQDNIsLU+QfzPVpgavpZD3KEhJq3Y8P9gIW7btVCA46n1EI1lMKMTpAVLl
        pC21ZHUYddU7shllQb6VNrkEbOCIUxI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-qa_pjj1mNXOSQA-w1CHGYQ-1; Tue, 23 Mar 2021 13:08:33 -0400
X-MC-Unique: qa_pjj1mNXOSQA-w1CHGYQ-1
Received: by mail-ej1-f70.google.com with SMTP id en21so1362671ejc.2
        for <selinux@vger.kernel.org>; Tue, 23 Mar 2021 10:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGXsKqwmCuWhJMJy6T6zftVw1uWRfrsTgEFydCHaDcA=;
        b=W/gnscWsfEFjXuvbUvvy3pVC/+CY1I8Okw72igRrYK/e8OO8wtdyvQVzh4QVo6gFhO
         7VTdoRmP4m3512h3c3zK1vrvOXFbPhTozeq/R0DBdwWHqDVGo/cx88bzJD4mkCb6kWt1
         /dT9MxsXT56JBd8QQ4Ej9/rfyYQVp+WGWsgrqnnksREHf2y7S24XmoDBqhynioLMDdOf
         Mz72Wiw1BCONtrDE/gXTurLdKPVAyLKWx484LHJW61eiYWeXf8cEuIi6uGHeLF0VC/OG
         SRTQ8tQMBYzitUhDWIPdpTrwoxsa1YmvE2gKzrQcNoWZmtJ/vuHkDUcDkBs3ifvjkqvd
         y8MA==
X-Gm-Message-State: AOAM532eVxiU48mdo6jNU63EIWudfXWBSJhqqp7tT/yVWqKt58uf/Bj2
        9CfXNs+erGr+r0qawya44+Sg3RpixX8a8yNFEPP6m/ki2xSJumy70NAkFkt78DJIErbSw+ISJ6S
        PpbTY4lWzM13i8r1f0uD5P26DwSj9UC3I2uLi0daqboBCTaG2FwFoAcmDuwGn9tdoiGtFiw==
X-Received: by 2002:a50:fb10:: with SMTP id d16mr5646263edq.73.1616519312425;
        Tue, 23 Mar 2021 10:08:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+Fqe4nK0z/XRbVyM1W084+0hSuE0/LohaihYM9SsirqQIdwATnxyEpoHhHYvzz4vAyNohYA==
X-Received: by 2002:a50:fb10:: with SMTP id d16mr5646238edq.73.1616519312205;
        Tue, 23 Mar 2021 10:08:32 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k9sm13337948edn.68.2021.03.23.10.08.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:08:31 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 0/6] Parallel setfiles/restorecon
Date:   Tue, 23 Mar 2021 18:08:24 +0100
Message-Id: <20210323170830.182553-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series adds basic support for parallel relabeling to the libselinux
API and the setfiles/restorecon CLI tools. It turns out that doing the
relabeling in parallel can significantly reduce the time even with a
relatively simple approach.

The first patch is a small cleanup that was found along the way and can
be applied independently. Patches 2-4 are small incremental changes that
make the internal selinux_restorecon functions more thread-safe (I kept
them separate for ease of of review, but maybe they should be rather
folded into the netx patch...). Patch 5 then completes the parallel
relabeling implementation at libselinux level and adds a new function
to the API that allows to make use of it. Finally, patch 6 adds parallel
relabeling support to he setfiles/restorecon tools.

The relevant man pages are also updated to reflect the new
functionality.

The patch descriptions contain more details, namely the last patch has
also some benchmark numbers.

Please test and review. I'm still not fully confident I got everything
right (esp. regarding error handling), but I wanted to put this forward
as an RFC to get some early feedback.

Ondrej Mosnacek (6):
  selinux_restorecon: simplify fl_head allocation by using calloc()
  selinux_restorecon: protect file_spec list with a mutex
  selinux_restorecon: introduce selinux_log_sync()
  selinux_restorecon: add a global mutex to synchronize progress output
  selinux_restorecon: introduce selinux_restorecon_parallel(3)
  setfiles/restorecon: support parallel relabeling

 libselinux/include/selinux/restorecon.h       |  14 +
 libselinux/man/man3/selinux_restorecon.3      |  29 +
 .../man/man3/selinux_restorecon_parallel.3    |   1 +
 libselinux/src/libselinux.map                 |   5 +
 libselinux/src/selinux_internal.h             |  14 +
 libselinux/src/selinux_restorecon.c           | 498 ++++++++++++------
 policycoreutils/setfiles/Makefile             |   2 +-
 policycoreutils/setfiles/restore.c            |   7 +-
 policycoreutils/setfiles/restore.h            |   2 +-
 policycoreutils/setfiles/restorecon.8         |   9 +
 policycoreutils/setfiles/setfiles.8           |   9 +
 policycoreutils/setfiles/setfiles.c           |  28 +-
 12 files changed, 436 insertions(+), 182 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3

-- 
2.30.2

