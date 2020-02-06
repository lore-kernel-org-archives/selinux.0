Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41052C2D0B1
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D71421775
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XizySnM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBFNTJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:19:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727668AbgBFNTJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 08:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580995148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ZTZQoZWSnTHRqL5k1IA1xTtPl00g5IgkXHuhtPsAWU=;
        b=XizySnM8L2Kuh01lbrpqkYjAXA2TJx7jV1bUkXwucgLcIY9rAAdGeG2ZN0Y0S3ZZgKhFHZ
        aVJOUVniPF0J8y7pIqZxpYSQ17IWleQ1bZq2HCLtTGx0H13I75fhgKy0mye20tbWTnz6wG
        36zyw0YtD2fv+igY7a4rex3nUzqkzlw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-OcM8xZMENBSb_a-2gfHaiw-1; Thu, 06 Feb 2020 08:19:04 -0500
X-MC-Unique: OcM8xZMENBSb_a-2gfHaiw-1
Received: by mail-wm1-f72.google.com with SMTP id b202so2771538wmb.2
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 05:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZTZQoZWSnTHRqL5k1IA1xTtPl00g5IgkXHuhtPsAWU=;
        b=TUP6nTc7mpXdU0xoD72DOEzRbmiKJHCRvRVWJU8wQCv3kOtrx0aY/ykJ5vYLF++h2s
         wb6eElwYuInDmJnFtcAt+fF4ztIq0PVE/fQhLmgIcwRTkX+e7ziK4oHYYICFDLRwIVLO
         WH8UO6d3TzQD8+0EyT8y3kMygSt2SJ0KY1s+SFher2GxBvNzlNEtLZnjrmWcN5gy9L4a
         W8HY8DigaOpHr41B94z4HYz5NAitVag6GUIprRPWmKCRj4oFA7vnLJY4tV3QxcmO9Lir
         wWLE05VdF5erqm/asI4nGCbugPWDjPaU/UOuin+dXbjjnVvzgDvsdFCmwvH2EwVtzIBs
         K7iQ==
X-Gm-Message-State: APjAAAXXtLr0YXO7qp1gwVzgc1u05RTBAmln4jE6D3wFwgBU1J/YASrI
        u271F7tJgIFZLWAidPKJwp89Wy5lbauz1wuTfNXctGEn4RcoFVaQSW+oS4g75aPgKoLrfGI37il
        ILnVjxyBfLvwg3n/5Sg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr4708922wmg.92.1580995142600;
        Thu, 06 Feb 2020 05:19:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwexG2DLm2rJP2dxisBPruB3Nn4tmMhXpjHnTlPnen6rMPcnkw3VDN+aVfpXbSsOhJJzwAaFA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr4708908wmg.92.1580995142402;
        Thu, 06 Feb 2020 05:19:02 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm3668978wme.16.2020.02.06.05.19.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:19:01 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/2] userspace: Fix DEBUG=1 build
Date:   Thu,  6 Feb 2020 14:18:59 +0100
Message-Id: <20200206131901.535779-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

...and add it to the Travis CI matrix.

Passed Travis: https://travis-ci.org/WOnder93/selinux/builds/646830495
Failed new test without the fix: https://travis-ci.org/WOnder93/selinux/builds/646833909

Ondrej Mosnacek (2):
  libsemanage: preserve parent Makefile's flags in debug mode
  Travis-CI: test that DEBUG build works

 .travis.yml              | 3 +++
 libsemanage/src/Makefile | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.24.1

