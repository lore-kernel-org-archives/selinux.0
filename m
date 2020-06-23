Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF2FC433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9EF20738
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QA/162Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbgFWMhQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:37:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55044 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729611AbgFWMhQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 08:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592915835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNtyxHB6E7Z0SJoNFTQlSwZsiWPKhoHLbzJCv3GxjkY=;
        b=QA/162Akn3J79hdtCBgfV6N/M/vDzY9Xu+EQZbBDeOaEmyDb/GHJwnyiXEWwPUKOOumtHf
        B+jahSKkFyqHFIioCpt52+Ke1g2sKtbCj93nCxwGTxM1UktOamJsrR6MEEC/cD90WwrGay
        jYygx87CBAdLymYmvf4Og1iCBTryajE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-70aCvwUrN7-RR2rteuHmDg-1; Tue, 23 Jun 2020 08:37:09 -0400
X-MC-Unique: 70aCvwUrN7-RR2rteuHmDg-1
Received: by mail-wr1-f70.google.com with SMTP id l3so6216147wrw.4
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 05:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNtyxHB6E7Z0SJoNFTQlSwZsiWPKhoHLbzJCv3GxjkY=;
        b=IqWu93R8A6PkIAE9Uskv42KIAGz0LOJta4rRF+TISmLqwSCt8pYsbONR/BxgQK4IBH
         kfomxCuB8JcxE/t6UOhrAA+d+JyRYB/mjBTdRJxYv0kgDJ2Cx7csCamRE7DZWPKqMUXd
         cE0n37dMan1gQAmj0LDHzB4z3YWhdaOtvzAGc9SJd+ucGWpDCAf5YEwq4y9oZtWMx/0h
         Qc/7WGp0jdPbimpD7o/RLXvKhVfAcZjJTD/nC5cIX6BVc4uFeN73uYMhVsdkxSIvOD8C
         4/+KFoGqHgMPNM6Zh/0e030PHY7Yo1SzByJRCHyUDg3/Di7MsCGKsZnDaonbGYv2I5jy
         UJaA==
X-Gm-Message-State: AOAM533Itp6RDjYNgoC6syXNkvdgaLYl9PeGrcFHlSb88+PQGNuKgfGx
        erwmUtpXDheVrY9ok9Cxq/bUO2vyruagxnzrhc2YcB4td0SSnyt0enf9oh5UpwKcxyrmmlLWdLe
        Yvk+Bd+sBcbjPRCapYA==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr17246986wml.177.1592915828355;
        Tue, 23 Jun 2020 05:37:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwex/d4Fr7QBEF275MMfS8AdY855pkmA5OVQODKq628e/M80bvGU1co4dTN1U4oEI/IBfTb9Q==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr17246964wml.177.1592915828045;
        Tue, 23 Jun 2020 05:37:08 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm3449729wma.48.2020.06.23.05.37.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:37:07 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 3/4] travis: fix git/cache handling
Date:   Tue, 23 Jun 2020 14:37:01 +0200
Message-Id: <20200623123702.401338-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623123702.401338-1-omosnace@redhat.com>
References: <20200623123702.401338-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The current way of fetching new changes from git blows up when there has
been a force-push. Switch to just fetching and then checking out the
remote branch directly rather than using git pull.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 travis-ci/setup-policy-fedora.sh    | 10 ++++++----
 travis-ci/setup-policy-refpolicy.sh |  4 +++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/travis-ci/setup-policy-fedora.sh b/travis-ci/setup-policy-fedora.sh
index d2793f0..bce8698 100644
--- a/travis-ci/setup-policy-fedora.sh
+++ b/travis-ci/setup-policy-fedora.sh
@@ -4,11 +4,12 @@ set -ex
 
 if ! [ -d selinux-policy/.git ]; then
 	git clone --recursive https://github.com/fedora-selinux/selinux-policy
-	(cd selinux-policy/policy/modules/contrib && git checkout rawhide)
 else
-	(cd selinux-policy && git pull || { git checkout '*' && git pull; })
-	(cd selinux-policy/policy/modules/contrib && git pull)
+	git -C selinux-policy fetch origin
+	git -C selinux-policy/policy/modules/contrib fetch origin
 fi
+git -C selinux-policy checkout origin/rawhide
+git -C selinux-policy/policy/modules/contrib checkout origin/rawhide
 
 if ! [ -d container-selinux/.git ]; then
 	git clone https://github.com/containers/container-selinux.git
@@ -17,8 +18,9 @@ if ! [ -d container-selinux/.git ]; then
 			selinux-policy/policy/modules/contrib/$f
 	done
 else
-	(cd container-selinux && git pull)
+	git -C container-selinux fetch origin
 fi
+git -C container-selinux checkout origin/master
 
 cd selinux-policy
 
diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-refpolicy.sh
index abd4ca4..3010467 100644
--- a/travis-ci/setup-policy-refpolicy.sh
+++ b/travis-ci/setup-policy-refpolicy.sh
@@ -5,11 +5,13 @@ set -ex
 if ! [ -d refpolicy/.git ]; then
 	git clone https://github.com/SELinuxProject/refpolicy
 else
-	git pull || { git checkout '*' && git pull; }
+	git -C refpolicy fetch origin
 fi
 
 cd refpolicy
 
+git checkout origin/master
+
 [ -f policy/modules.conf ] || make conf
 
 make -j`nproc --all` BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin
-- 
2.26.2

