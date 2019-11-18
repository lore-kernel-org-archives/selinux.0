Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99720C432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D00A20659
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQxAUtuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKROwo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:52:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36944 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726748AbfKROwn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 09:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574088762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fvq81DE10WVfYUmdVex1QSP3ppJjoVQxj0CY55haVSo=;
        b=fQxAUtuHbeSWmL/1wFKe68OOl1uQm+WxEsJX4qYkav1l1Ha3m+btOug71mXRL2/lL2pUUU
        cgeCIvfIYmHbSMhjhMOoZpf4R3kz06gY8DLv2CjB6xp2pt7M9KhLdCHoR21r94yZKP1Mbv
        MM3qK1rwQdFWvObBnknyJBxp5zpBqAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Nh_RRfUBOryM8V6ojxI9kA-1; Mon, 18 Nov 2019 09:52:40 -0500
Received: by mail-wr1-f69.google.com with SMTP id n11so3120853wrq.5
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 06:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VsN8QokDAH1fh8yGL0FMoEpfa+QFGR/65Zlrmsv8Xmw=;
        b=X0QcnVVCxgr0GXiUOOLC2r/lYbADzjkhXhj6aO28HVLS7XsDvwiNcE/A4nSQ8iy/7b
         LmjP0XPsy5tD5UPxRcmyc98bgsszWUYjTxBT3Vy+CmnrYtG7Pqmn8iBfl4gRhzGXyZgy
         udHFnAlBkPRM9MioO3jsh5iY8cCXEcDLbuCHvpxIhwfUz6KTxyuicDm0Txw5gHg05W49
         EqfpWYrf5bKsn5nfNCbDutMEzwaGOlhQgywu2AGEV9fRplLADrq5yqOe4i7ot/Y4K6P7
         Jyh3d8tpxwG6kVFCON2wHSD1VLx4yKdG0Zz348Avn9MKR75Hety6dVgxJJ/2NjxGWw9T
         o9fw==
X-Gm-Message-State: APjAAAU7OpyLZsDJFPl/YXdG2h45IAXCJ/T30WiM4OwbYZXywUAjiS7p
        juqjko555MQK/+dWTlfUOBOsnDqKx+pkkWaY4q2istx8W9iGYs/AXYtkYsCXYm7VwpYdMyiLOc/
        gjOlj6qf/QETpQx6Eww==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr30972909wma.116.1574088759326;
        Mon, 18 Nov 2019 06:52:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6U/6jUHffK4xT2uAU2Ye4I1kPMjSiT5KFTckvVDeEeWiGrtJwNmaSRji9huPO+rDIpiiAdw==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr30972883wma.116.1574088759021;
        Mon, 18 Nov 2019 06:52:39 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o5sm23044658wrx.15.2019.11.18.06.52.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:52:38 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v4 0/3] Fix refpolicy build & build test_policy.pp in Travis
Date:   Mon, 18 Nov 2019 15:52:35 +0100
Message-Id: <20191118145238.408124-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: Nh_RRfUBOryM8V6ojxI9kA-1
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

Passed Travis run: https://travis-ci.org/WOnder93/selinux-testsuite/builds/=
613536331

Changes in v4:
 - more fine-grained dev_rw_infiniband_dev() fallback as suggested by
   Stephen Smalley

Changes in v3:
 - drop the first patch, replace with the following:
 - add patch to replace userdom_search_generic_user_home_dirs()
   directly with userdom_search_user_home_dirs()
 - add a fallback for userdom_search_admin_dir()

Changes in v2:
 - report policy version 999 in the fake selinuxfs to force building
   latest version
 - install userspace tools and libraries straight from source instead
   of working around missing features in the Ubuntu builds
 - install also latest keyutils from source to allow the new 'keys'
   subtest helpers to build

Ondrej Mosnacek (3):
  policy: drop the unneeded userdom_search_generic_user_home_dirs()
  policy: add fallbacks for Fedora-specific macros
  travis: test building the test policy package

 .travis.yml                         | 48 ++++++++++++++++++++++++++---
 policy/Makefile                     | 11 ++++---
 policy/test_ipc.te                  |  2 +-
 policy/test_policy.if               | 22 +++++++++++--
 policy/test_ptrace.te               |  2 +-
 travis-ci/enable-policy.sh          | 10 ++++++
 travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
 travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
 8 files changed, 134 insertions(+), 13 deletions(-)
 create mode 100644 travis-ci/enable-policy.sh
 create mode 100644 travis-ci/setup-policy-fedora.sh
 create mode 100644 travis-ci/setup-policy-refpolicy.sh

--=20
2.23.0

