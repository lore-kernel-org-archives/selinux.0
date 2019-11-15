Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B22C432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D297720733
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYm9+F2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfKOPQc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:16:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29347 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727380AbfKOPQ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573830988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E6nIvbP52YxRoc/7UCe2yJFho9w+onZ6I7kx42kFDK4=;
        b=FYm9+F2T29FjOuldirA0vZYv+wvdCURvTsx+/jEcdERMSKAB+7KPR9SXysX+DO2q1YyxCv
        BjEs48DGbSZcWtpzZlrI1r+T7PcChKJNmfsqRmPJ0aTMxnAwu+DZhmOW+DFXtpJJQckBaa
        cP4UGQe2PtnHL9z94OUmyFezANISwvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-wrkLhszvPGeoI5eBxGYKsQ-1; Fri, 15 Nov 2019 10:16:27 -0500
Received: by mail-wm1-f70.google.com with SMTP id 199so7131490wmb.0
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 07:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IxzdqDjGf5VhxeNyWOtmpENKMQuXs8U4TbdEp1sG64=;
        b=rS/Su1s0nN/j7HPaJpwWTeDdyrLbrIFiw8HlAJ5XvCkduHen6iuo52DOW/t2VwW/YP
         1pehRNPDOnJny7qDYWgrv20PqVqWPvM5kUmKtLWlzXU6C3L2uS4jiG3Sab96fZTn58j5
         /i2UkQJRL3DmEuVyfvVRIBGsvXJjZqGbOOLNpjjGPxB5540/CU+mZ37ZdrBsVgYI45qC
         Kfy647DuwXLHb/16s9euSspjJ8P+PVyDMqTQXEzR5J75d40Xx6naLblOvFwRsC4jVzTv
         NsjOneTmzKy+wXfTQk7moyHvnp/d2qiU10/Sy1qTQ6zfeoFnNcTHKz+5YFB+0xU5lix5
         aLTQ==
X-Gm-Message-State: APjAAAXf7INiGUuqQhR8sXdoYHhDz4BsdocOg/JgQSi0908xtl8O0gvp
        fmTFegLwqBtfvPWqBmx70hM0/cdKuLj843olDiUATb8znGjU1ceJ5kdP8uxa//Yt2YRxBjUVYSz
        ECygKNSHXedrGWtHQmQ==
X-Received: by 2002:a1c:9d4a:: with SMTP id g71mr16051053wme.66.1573830985792;
        Fri, 15 Nov 2019 07:16:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyD0TNbtnK4JR4mvzLKgbcjDwsFnWwSZlangHT3h/YMlTsVhNjGqJq46inHweR3PZC4GQ7ADw==
X-Received: by 2002:a1c:9d4a:: with SMTP id g71mr16051017wme.66.1573830985435;
        Fri, 15 Nov 2019 07:16:25 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j63sm10337239wmj.46.2019.11.15.07.16.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 07:16:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2 0/3] Fix refpolicy build & build test_policy.pp in Travis
Date:   Fri, 15 Nov 2019 16:16:20 +0100
Message-Id: <20191115151623.265770-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: wrkLhszvPGeoI5eBxGYKsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series fixes the remaining test_policy.pp build errors under
refpolicy and enables building the test policy under both Fedora policy
and refpolicy in Travis CI.

Changes in v2:
 - report policy version 999 in the fake selinuxfs to force building
   latest version
 - install userspace tools and libraries straight from source instead
   of working around maissing features in the Ubuntu builds
 - install also latest keyutils from source to allow the new 'keys'
   subtest helpers to build

Ondrej Mosnacek (3):
  policy: consolidate macros for home dirs access
  policy: add fallbacks for Fedora-specific macros
  travis: test building the test policy package

 .travis.yml                         | 48 ++++++++++++++++++++++++++---
 policy/Makefile                     | 11 ++++---
 policy/test_overlayfs.te            |  6 ++--
 policy/test_policy.if               | 23 ++++++++++++--
 travis-ci/enable-policy.sh          | 10 ++++++
 travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
 travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
 7 files changed, 136 insertions(+), 14 deletions(-)
 create mode 100644 travis-ci/enable-policy.sh
 create mode 100644 travis-ci/setup-policy-fedora.sh
 create mode 100644 travis-ci/setup-policy-refpolicy.sh

--=20
2.23.0

