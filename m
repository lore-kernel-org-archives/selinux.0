Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5783C432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BF120730
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNg0tnYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRMbF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:31:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbfKRMbE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 07:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574080263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntpEIx9ThxWIKjY19mE+SoIj8Apka13+xqQxQdiykh0=;
        b=XNg0tnYD80zMLLj4aLnfb77npOCnHT5plxTfE5aE+gn+LPs4pce2pAsy71CsdrT3pLp8WQ
        NxXjXAKQK3c8ZBB9gD5pTVs2Mg+DLKpH2mvVBjz55AN/LRNteoVSdn+5BKpnJJufqLc1Pn
        FUfaMwdThI/0yfrWvp5/iPds0EzZMyE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-OfOZp43APCyt7LsZwuNBxw-1; Mon, 18 Nov 2019 07:31:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id w4so15260459wro.10
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 04:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCpDSS1g5DyKtUgwLK7HNs1W3cLbkN0WrlDgyUZbbDU=;
        b=Krm+xXddTY8eIe+g3ehim6EyVvSwcNths5Av3TKk4r98/78GVUWFjrczSR8HLrVgoF
         j1WOCOW8HWxZbKhKHB7W14ngJ9m2x3zpAgI1BG/QbdJnLwzcr4wJfi8nVFi9/hYN9BBR
         yUjXwWqumf1EGjNoMmqt6TAgkeeKdEv1skxar/Wp3lWb/6ntzeqSLp5YVTqcejxSIhYO
         IBltT42YFL7U7lzhwc5f3sHD2J3JS/jd8Q/Ua7daaZNhSA1sShypP6rj30sm6keTBGgF
         yZyBQWYwOi9z7epEA2qY+zEICMn4mGtuU4+sEXxclGK+R4tzYTK5BOoZocOuU2h1j+49
         tlUQ==
X-Gm-Message-State: APjAAAXtwELma3Nb0CbVYrFhF9RSZuGn3+oaBo1Jl1XjrSivlHTnf6/J
        8Ul49iOJ4RKMVHgK3FLVLuBX2IK+zIFat1CxJIWuUAkrGdiHQ60wZD1qq4qnV8y4/izSyvBkvDz
        ClKBT76UGYYa/0AcuZg==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr23200416wmj.28.1574080259995;
        Mon, 18 Nov 2019 04:30:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKvltwHgx/PngIinZZwJFWjJd5MBu6k+EDkoNAvJXT+Uq/e4ugS466q2FsQavwyx2YdudEYg==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr23200396wmj.28.1574080259727;
        Mon, 18 Nov 2019 04:30:59 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h205sm21815802wmf.35.2019.11.18.04.30.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 04:30:58 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v3 0/3] Fix refpolicy build & build test_policy.pp in Travis
Date:   Mon, 18 Nov 2019 13:30:53 +0100
Message-Id: <20191118123056.338496-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: OfOZp43APCyt7LsZwuNBxw-1
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
613471070

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
 policy/test_policy.if               | 21 +++++++++++--
 policy/test_ptrace.te               |  2 +-
 travis-ci/enable-policy.sh          | 10 ++++++
 travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
 travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
 8 files changed, 133 insertions(+), 13 deletions(-)
 create mode 100644 travis-ci/enable-policy.sh
 create mode 100644 travis-ci/setup-policy-fedora.sh
 create mode 100644 travis-ci/setup-policy-refpolicy.sh

--=20
2.23.0

