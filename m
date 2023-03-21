Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF6C6FD1D
	for <selinux@archiver.kernel.org>; Tue, 21 Mar 2023 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCUSkv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCUSkt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Mar 2023 14:40:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8052AD3D
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 11:40:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ga7so301092qtb.2
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679424044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrltfV/SraXqMoXkb5ukq/oIvIdX3ZZ08C5+eYXMh00=;
        b=CVTDQ9tUjiajWjuFROCJboeBPSvc1NGhS6V1iPZLsbUszz7UGTi9IRc9Xp7MmzRe0E
         VsERBojLfYFB0yNw668VwT3zbPkVi955/FDcBvVs5SGpyUhyTQTmcxlWynSNb86K6HJq
         i/uzo6Y19lzyIJQB4X8UT9QiWPzJnFs5ysnpnULZk3kD1V38lp+8Zo0J++wWPXL0S+0d
         9V4nEMiYCzvOXb6RkO6nF4BMb2Nz3dbZcxzsdTSJLefX7NcECRWUy9I5PhZi8ED83yLR
         GXrQJGiPeMZaIM7WtYKOWieepROJVYe4Ut2ZeH3nXidFSrRl6P0QSre66BN2Oazt2D2c
         Yavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrltfV/SraXqMoXkb5ukq/oIvIdX3ZZ08C5+eYXMh00=;
        b=LH1ouqSsnHUtBvbCqHDFp38BD8vSkxX3OQ/o4JxFqEr/QkAtoqqBwMIWsqLECnE5Ym
         CHCMNblgii0n3P5aGNQ0ii77JXNfOER2wB5z7ZNZSA7CWc+xdQfhfMzuZLjHBTwuQLBU
         4P7OcfYCXWsQEZFjEryjlMoH1MAIspVB9n5ifiwj85GYrifxGx7+1Q37p6FinN3ybSmu
         TRL8zPArrM/YtPPL/TPCJG33JWUuBjfB78FnvIS8WtGl5o4R2TDP8fr7dJui9vXQq5rJ
         t07n6JzMzQs5KDX4ECU6yhcAOIHg49hvADAP29ql6ys5+5/Nx4g1/6IKGa2bJwn5rr8/
         EPuQ==
X-Gm-Message-State: AO0yUKV9hRcvI5o58TCizrF32QuNunXGJXohHWW+bCI4TOa+24NLnjev
        IMWwpMhEFVlw058oukkuxB/2dZDiUkWqgF+AcQ==
X-Google-Smtp-Source: AK7set9ud6ZZGif3HB73eVwFC73UXe6CxMAViU4RusVuQc5udC5hxWrpwaXHoy/s5Il2vvCtrhzQKQ==
X-Received: by 2002:ac8:7f10:0:b0:3db:339c:c58b with SMTP id f16-20020ac87f10000000b003db339cc58bmr1774709qtk.5.1679424044569;
        Tue, 21 Mar 2023 11:40:44 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id x205-20020a3763d6000000b00741a8e96f25sm9853531qkb.88.2023.03.21.11.40.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:40:44 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: update the file list in MAINTAINERS
Date:   Tue, 21 Mar 2023 14:40:43 -0400
Message-Id: <20230321184043.119340-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When we removed the checkreqprot and runtime-disable functionality we
also moved the deprecations notices from Documentation/ABI/obsolete
to Documentation/ABI/removed but unfortunately forgot to update the
associated entries in the MAINTAINERS file.  This patch corrects that
problem.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303212204.3G5mRatJ-lkp@intel.com
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..6a73e5ea004b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18823,8 +18823,8 @@ S:	Supported
 W:	https://selinuxproject.org
 W:	https://github.com/SELinuxProject
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
-F:	Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
-F:	Documentation/ABI/obsolete/sysfs-selinux-disable
+F:	Documentation/ABI/removed/sysfs-selinux-checkreqprot
+F:	Documentation/ABI/removed/sysfs-selinux-disable
 F:	Documentation/admin-guide/LSM/SELinux.rst
 F:	include/trace/events/avc.h
 F:	include/uapi/linux/selinux_netlink.h
-- 
2.40.0

