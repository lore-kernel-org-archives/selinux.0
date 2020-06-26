Return-Path: <SRS0=GP6F=AH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB35C433E0
	for <selinux@archiver.kernel.org>; Fri, 26 Jun 2020 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E9A208B6
	for <selinux@archiver.kernel.org>; Fri, 26 Jun 2020 11:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS7d+zW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgFZLoH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:44:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgFZLoH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jun 2020 07:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593171845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3fD/Y91afA1m39ftFUDHF4x4jf48XnEGH/EuiN36iOg=;
        b=HS7d+zW7marhtyYrMxpDCXeWmp9CF5oKPtwZAV/h70K5stw+163s14cYCTLIUI1lqYvno+
        uzDQCgEEfI806jOLsXq8Ed8VqjkntY+B29btsJfzBfO8xyq6xOPyFUGiMdPPYZ6u3/0yTp
        J5EoJ+Ajtb4cLu0bvAlKHvqIiA6Z8oA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-OFiuc_82MJKjwz7Z7PEZfA-1; Fri, 26 Jun 2020 07:44:04 -0400
X-MC-Unique: OFiuc_82MJKjwz7Z7PEZfA-1
Received: by mail-wr1-f70.google.com with SMTP id h28so10334994wrc.18
        for <selinux@vger.kernel.org>; Fri, 26 Jun 2020 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fD/Y91afA1m39ftFUDHF4x4jf48XnEGH/EuiN36iOg=;
        b=p2fJLUM10vgPGnW7abwo16MUnNsaSyST1jPBMj+JdLHSXGdz+vpmo48+xyfAfMr3l5
         CgwbVd8Jez4JZNRHEy2C1kpbAmfSitqNiQQeBB6hpZJW8KKEswa9seWlbcDOjL+aHfhD
         9xXkShwSNjuRyJ+pRDMV86OdgyFTrTNdQvHdHCPo6PkHssp3+2ifIZcLsFOTyG6kGrgh
         jiHtShUt2RFj1ja2ivd+a8186Ec3DGMIuGB53SBAQuElefDKzC2VFtKe3PSM/MsUnrnG
         /Bx178n0xaAz3t4uSFGX+xYoaZ94TLLPvJu88KityGWNbts9zN+/q5LUgp55whNyPirc
         6rCg==
X-Gm-Message-State: AOAM531DArj2VkY/k18x16ySRr08YSCuzOOIbQdOHEVGG1ZXcj2fD7BR
        gBjQPpDDJFa2Bay7WhUt5VBb0NamexwBSvbOCVfvDNFP4essvVCIqWF+V6qg1PYBRD79VmTssXP
        K+/aYHF28DjsbnlWOUQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3000049wmj.136.1593171842616;
        Fri, 26 Jun 2020 04:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs3yYNyyfM74KnU5apaJSWEWtuQ/b2vW+vH0YKz4j32FMIAcOl9rHLjj/QOEI6FsS45nuTVA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3000030wmj.136.1593171842352;
        Fri, 26 Jun 2020 04:44:02 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id f12sm23626703wrw.53.2020.06.26.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 04:44:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] travis: fix `make conf` invocation
Date:   Fri, 26 Jun 2020 13:43:59 +0200
Message-Id: <20200626114359.80134-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In refpolicy when a module is added/removed, the policy build config
may need to be rebuilt. Currently we run `make conf` just once and then
reuse it via cache. Instead, we need to run it unconditionally, since
the other targets won't trigger that implictly.

In Fedora policy the default module config is included and maintained in
git, so we don't need to (and must not) call make conf at all.

Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 travis-ci/setup-policy-fedora.sh    | 2 --
 travis-ci/setup-policy-refpolicy.sh | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/travis-ci/setup-policy-fedora.sh b/travis-ci/setup-policy-fedora.sh
index bce8698..a07c990 100644
--- a/travis-ci/setup-policy-fedora.sh
+++ b/travis-ci/setup-policy-fedora.sh
@@ -26,8 +26,6 @@ cd selinux-policy
 
 grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' build.conf
 
-[ -f policy/modules.conf ] || make conf
-
 make -j`nproc --all` BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin
 sudo make install install-headers
 
diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-refpolicy.sh
index 3010467..d63e7e4 100644
--- a/travis-ci/setup-policy-refpolicy.sh
+++ b/travis-ci/setup-policy-refpolicy.sh
@@ -12,7 +12,7 @@ cd refpolicy
 
 git checkout origin/master
 
-[ -f policy/modules.conf ] || make conf
+make conf
 
 make -j`nproc --all` BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin
 sudo make install install-headers
-- 
2.26.2

