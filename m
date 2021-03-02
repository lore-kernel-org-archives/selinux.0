Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC9C433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114BD64E87
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352815AbhCCEVm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:21:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245548AbhCBRXF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Mar 2021 12:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614705680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vVxv61bJ5naCgkuoFC8HHETIUtpy0LyG6DQTSuQrXHE=;
        b=bFR1JwrgJjqRWGVBZyL06RZWY+7EB7BQxRZAw4nNOYuYBRtDWSuA1jRv+KYIIu4pCCmbYv
        lDu5g8Lt8jbQE5D3VPJmFflNn8Itrfei7/vxQKoV+Hl+S3Q/imPnVJH/I7mhcdyE1svMjN
        fUpyvJa+WYZsH5KeS+JWvIvNufTavDE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-rInnf-mQOje_9Rj0x6bBiw-1; Tue, 02 Mar 2021 12:21:18 -0500
X-MC-Unique: rInnf-mQOje_9Rj0x6bBiw-1
Received: by mail-ed1-f70.google.com with SMTP id t9so10785567edd.3
        for <selinux@vger.kernel.org>; Tue, 02 Mar 2021 09:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVxv61bJ5naCgkuoFC8HHETIUtpy0LyG6DQTSuQrXHE=;
        b=nTZYfleCZ85vH805SQ/F6EqOsSqtAd84Iadk7KJuEkIR9cXfZ+6rKbJ5qHleV0rfmx
         TXMylCecSI/j1zpOBcIAxdtdC2NLP5tRfsplwGSx15WzRjiT80PGPbvlyCH5hd2JFL+w
         /xNHYcLkrGZMQ+mkdlsfCXJVUCAvGNM0sQZF2vTYKQPc5l/lq1WczrM5BsxMTcWRfYON
         /aRgcG69x3stwYtg1z/7Z99/LxcKM24MKcv8vcqVCrEPc9f0s/nAvMK2r8qYoz48Y/ZU
         IkfBPHnzMlfXwRipRAyxlASdQkkLCpRJl1xuN9pttX3EO9ldsVBblzEioQXlm2DYiCFY
         PtqQ==
X-Gm-Message-State: AOAM533JA8NR8wSX0mfIhbH5IpeQl34lFstSSoWqWRDws3dEUyOrObj8
        Qm1mPfCi893qRwCFswGfjhQ6g+PQMKlR+hQds0YXTK4JZ6zusqRYfi/JIN7MrPELuf6yLtCiAZp
        8rLo20BlQOAQV4hktFR8ndXKQhtWHu6JXzlRA9HEVl/GFUbdXb9siCY3z5i5c7uzmFmjnZw==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr21767320edb.103.1614705677295;
        Tue, 02 Mar 2021 09:21:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoQKD2af0kQgFb9Ken3pCCorM+Sp2uv7+KzuEKhI3uzdrzgktHfY7tZbMwhtJwzCFN7SMsiA==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr21767307edb.103.1614705677120;
        Tue, 02 Mar 2021 09:21:17 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id pk5sm17922560ejb.119.2021.03.02.09.21.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:21:16 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/3] perf_event: fixes and cleanups
Date:   Tue,  2 Mar 2021 18:21:11 +0100
Message-Id: <20210302172114.443689-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

See individual patches for details.

Ondrej Mosnacek (3):
  perf_event: measure CPU 0 rather than CPU 1
  perf_event: fix wrong use of perf_event_open(2) API
  perf_event: fix CAP_SYS_ADMIN references

 tests/perf_event/perf_event.c | 18 +++++++++++-----
 tests/perf_event/test         | 39 ++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 19 deletions(-)

-- 
2.29.2

