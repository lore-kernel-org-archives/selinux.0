Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E132C433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F0120758
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 08:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL+oASgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHTIpR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:45:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47158 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726815AbgHTIpE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 04:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597913102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vqodWod3gycJmurMFR0UqNijUlyqJHcoirWHJIQa7SA=;
        b=gL+oASgpwq4SmxVEocoFIGtS0ogAK6SsSNuRH1fq1KmZ8mkjJU77Y1zMxr+izIUAXueZMy
        ITxupRhKnDQMF/rlyeeAvunUmqtMCRQXRj6xntllCfvzyBr6TaX4Sp9jOzNCFEac0JdeUE
        9cRK5+llIrPLVej8op9ftew6lIof/x4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-syiC6mPZOk2Tj3fh5HBhbw-1; Thu, 20 Aug 2020 04:44:51 -0400
X-MC-Unique: syiC6mPZOk2Tj3fh5HBhbw-1
Received: by mail-wr1-f72.google.com with SMTP id e12so399939wra.13
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 01:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqodWod3gycJmurMFR0UqNijUlyqJHcoirWHJIQa7SA=;
        b=OuD1Qe5hvgbQMoOpykg/F2J9VxPzdBxfjOUOZL6UfP/gwbsjEhabbcSiquZwO9U6Z1
         QJ7awChwXCGyp9m6RiDDhKn6Fj+W3KwnMUnoR8CbooDVZCMyiSemIfacKydX3DIXZe/Q
         7mmV3Yl9iaj86M/P7IYcKGfiTb9hZnfFiTPG7NrQcQhXNEq3mEy7YEUtf4caKcKvlSii
         nFXLvYxwjg19tdjqFR1nDS28GG9RCOQl97MPu/0Q2WwQkLDKbF2Zcw1pEq1eRKF6U0sJ
         PbiAxqMBf7CeobA7NbuiyXmt9ONyzoPY6MFD8LfCdJOJ9MRabS8rgD+q4RZZd0nSxr7p
         To1Q==
X-Gm-Message-State: AOAM532nFlxNPwoMuRDavIHBEcrErZDsw6GNU79dK0DI3rbrnB+E4RWw
        xzaP9gDZHLZQv/r9z6qNeqHrIPtINIVyG66qToy3TJhgWgCX4Qd+JdBpar5tsXpK8JxqC+8ipiJ
        zRIieHcb9Ylle9TBvyg==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr2021416wrw.31.1597913090122;
        Thu, 20 Aug 2020 01:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLhRRg4uTaE9x/DyHiS7dZhEG/GiZC9vXiJ9kjoKiha4FzAXs5X7/CI5M9OJ9yK9Ofvbpkxg==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr2021401wrw.31.1597913089906;
        Thu, 20 Aug 2020 01:44:49 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id o66sm3110856wmb.27.2020.08.20.01.44.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 01:44:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v3 0/2] Run full testsuite on Fedora in Travis CI
Date:   Thu, 20 Aug 2020 10:44:45 +0200
Message-Id: <20200820084447.1030353-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series converts the CI scripts to run the full testsuite in Fedora
VMs instead of build-testing it directly in the Ubuntu CI environment.

v3: add a more explicit note about perl-lib on Fedora <=32
v2: run also on Rawhide in addition to the current stable release

Demo Travis run:
https://travis-ci.org/github/WOnder93/selinux-testsuite/builds/716827281

Ondrej Mosnacek (2):
  README: add perl-lib as a dependency
  travis: run the full testsuite on a Fedora VM

 .travis.yml                         |  68 +++++----------
 README.md                           |   5 +-
 travis-ci/LICENSE                   |   5 ++
 travis-ci/enable-policy.sh          |  10 ---
 travis-ci/run-kvm-test.sh           | 124 ++++++++++++++++++++++++++++
 travis-ci/run-testsuite.sh          |  55 ++++++++++++
 travis-ci/setup-policy-fedora.sh    |  33 --------
 travis-ci/setup-policy-refpolicy.sh |  21 -----
 8 files changed, 207 insertions(+), 114 deletions(-)
 create mode 100644 travis-ci/LICENSE
 delete mode 100644 travis-ci/enable-policy.sh
 create mode 100755 travis-ci/run-kvm-test.sh
 create mode 100755 travis-ci/run-testsuite.sh
 delete mode 100644 travis-ci/setup-policy-fedora.sh
 delete mode 100644 travis-ci/setup-policy-refpolicy.sh

-- 
2.26.2

