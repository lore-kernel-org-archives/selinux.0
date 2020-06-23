Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669AEC433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466BC2072E
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3csPU/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbgFWMhM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:37:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729611AbgFWMhM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 08:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592915831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kHORIeKVMeWmbFQpeycFajDeSscrCXP6fR7cB47Zj8M=;
        b=B3csPU/tzBTMgIp52G67f3KEFo1f14kHyDdVrHobq0zARsmxYOjCRv3jREBCrp0rEdz4yC
        du8c65cITJvZPB662fUPBqdSiuKlpEwHb0+BxtgVnCSF31yh8fVhVXSC6BoR2CP9F7R3xV
        bxrUsvQWeGrF3wjiv2MDu2aeJZJTW4w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-oxX-OnomMzu8OSqjIfHoAg-1; Tue, 23 Jun 2020 08:37:06 -0400
X-MC-Unique: oxX-OnomMzu8OSqjIfHoAg-1
Received: by mail-wm1-f71.google.com with SMTP id v24so4222348wmh.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 05:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHORIeKVMeWmbFQpeycFajDeSscrCXP6fR7cB47Zj8M=;
        b=I30EMyOAXCo8X5gZZUOKHJKDO9Ko7mfMpPvPwpBVyXYovYtA3VlZzamaUyjK1Aqy0H
         APRj/J159V+A8CKnXxr69/dr5yX4bThalnzHd9eed0Ojz5X6/+HT9QFHTmHwM0QLykPr
         L1ROulsB8KF5gsKNoPu8aeIqi0fu4qpMd6qrUg1SmlYtN0ScmfkMchz0HSKW1rPFkG6w
         kdkywj2KjbyPoQ60dP6sA+hoVHfhDY5R6PUqH/+D1B0pxadQvCrCtL474eEYsxPLv2g5
         CtDBV5vrRdUTTIcqt0pKiSw3cRGx6HfNGDOJzvNEsNu1bC3ajSD9vxsZhEHuOvZt+GMM
         H8mg==
X-Gm-Message-State: AOAM530KgXAN1Qh+l5UwKkrBiqn7RFl9ePPPQOFOPx3DjG7JFeVc7eIa
        EDCcWruxt6fK9X0G109ZTsLn0A56upRDuvBBbgvKGDKkjkQlEiUc+3sIFugpFsec/VlBrV90w21
        7jQ6Okr7/z1hwS66jGw==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr8057380wrm.65.1592915825101;
        Tue, 23 Jun 2020 05:37:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfxP7ewxwdCnNTUG7h/XHhLIrWLDKTEQ5JDOPA9OpQD47GpOfjIeqy3O60FMVhY8WdeaGPTQ==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr8057365wrm.65.1592915824871;
        Tue, 23 Jun 2020 05:37:04 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm3449729wma.48.2020.06.23.05.37.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:37:04 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/4] Various CI-related testsuite fixes
Date:   Tue, 23 Jun 2020 14:36:58 +0200
Message-Id: <20200623123702.401338-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are some warnings and non-fatal errors reported during CI runs.
Additionally, the CI gets stuck when there is a force-push on some
upstream repo that is cached. This series fixes these issues.

Testing Travis run:
https://travis-ci.org/github/WOnder93/selinux-testsuite/builds/698848141

Ondrej Mosnacek (4):
  Makefiles: remove bashisms
  travis: add missing node to fake selinuxfs
  travis: fix git/cache handling
  tests: stop using deprecated security_context_t

 .travis.yml                         |  2 ++
 policy/Makefile                     |  4 +++-
 tests/Makefile                      |  8 ++++++--
 tests/bounds/thread.c               |  4 ++--
 tests/dyntrace/parent.c             |  2 +-
 tests/dyntrans/parent.c             |  2 +-
 tests/execshare/parent.c            |  2 +-
 tests/exectrace/parent.c            |  2 +-
 tests/inherit/parent.c              |  2 +-
 tests/prlimit/parent.c              |  2 +-
 tests/setnice/parent.c              |  2 +-
 travis-ci/setup-policy-fedora.sh    | 10 ++++++----
 travis-ci/setup-policy-refpolicy.sh |  4 +++-
 13 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.26.2

