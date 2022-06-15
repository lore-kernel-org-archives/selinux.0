Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D2CCA473
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 12:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbiFOM1Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348484AbiFOM1V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 08:27:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2CF43AC8
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 25so15851546edw.8
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JvgN82kSDnFHT1qIJj3dyspOHbh7t9/i8LuvQ1xWf88=;
        b=eKpJGROU5xWUQbLu/zKam2uRHgD7WbS/F9GI2v/y7G0lsgSnPY7Rb486aIGy98MZ0T
         DX3rhX8squCqbuplSY3K8qgSV32O5DlLkkKnFe1QncJ/eBniyU3mZApy9GwW3SdqAQMC
         +DAh2+x9C8RYqohu+lu8ATXmYRI+mR3gEHC+TkuexiAjieQJU6YwKG8jgaDuVZLw3DKB
         2fa79EdIdX80GNoKhUoI7Gkf0rZKqbfOm5nDi+kvXZUT4e+8s+lokjnkmI6i+pHRyDFL
         Odah5pAL1H+LDNReJoqDl6YEdT77opOyiAkhjpajQUJyhulQynqYNn/tOhstPjqzaOIT
         ftXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvgN82kSDnFHT1qIJj3dyspOHbh7t9/i8LuvQ1xWf88=;
        b=7LNsWJZwd7aasPfOmu49AkRtFq3tIcRWGYLG/Npx52d1aeCeCIy5B97aoHv6QW+Lw/
         L34o3hB0+ixACXDhg5JEXm9RcoORahUWntOX+jnNunz4cnG+GHBk6VImc4OALWilLPQj
         YVtlqLjIzMiGNK8LfsFZ3pUu3CRoFINovlXiJ3t4mpYX1MPJKNOm2V8G+dN+HI6xuO4r
         JJ2dL7UzemCQadct7qZnRKFeLytpSQFkIga9wMkbNTiX6dVR3+a0Dzd+0EPOSB1l95hd
         4CXYGKNSknc1pMFXhGSyWxb1yXpLyLO33DjLYLtfZCRAoTPbfAEVXB7OaG5eIzMuB9WQ
         5IZQ==
X-Gm-Message-State: AOAM530Po3pnq3EIVlqRl4ebnZ9VEGrfNfUPs8R/oZKru6xyIB/mOwG0
        pLL10pkuiIUd3Aytlzqc1b12AMyZjuU=
X-Google-Smtp-Source: ABdhPJx2C3WFwu8Ra3n1JDwfhc15wZgbSN3ZSLOZbnY3tDCSJYYt5l+ZeAfgdrjZmcjEMbOQj1t7MA==
X-Received: by 2002:a05:6402:278d:b0:42e:d3d5:922e with SMTP id b13-20020a056402278d00b0042ed3d5922emr12322324ede.154.1655296038651;
        Wed, 15 Jun 2022 05:27:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402028900b0042dd3bf1403sm9190336edv.54.2022.06.15.05.27.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:27:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/4] filesystem: allow getfilecon(3) to pass test
Date:   Wed, 15 Jun 2022 14:27:10 +0200
Message-Id: <20220615122711.9895-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615122711.9895-1-cgzones@googlemail.com>
References: <20220614102029.13006-1-cgzones@googlemail.com>
 <20220615122711.9895-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    filesystem/ext4/test .. 67/83 getfilecon(3) Failed: Permission denied
    filesystem/ext4/test .. 71/83
    filesystem/ext4/test .. 75/83 # Looks like you failed 1 test of 83.
    filesystem/ext4/test .. Dubious, test returned 1 (wstat 256, 0x100)

    type=PROCTITLE msg=audit(02/05/22 11:47:03.170:7047) : proctitle=/root/workspace/selinux/selinux-testsuite/tests/filesystem/ext4/check_mount_context -r -m /root/workspace/selinux/selinux-testsu
    type=PATH msg=audit(02/05/22 11:47:03.170:7047) : item=0 name=/root/workspace/selinux/selinux-testsuite/tests/filesystem/ext4/mntpoint/mp1 inode=390506 dev=fe:01 mode=dir,750 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:unlabeled_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 cap_frootid=0
    type=CWD msg=audit(02/05/22 11:47:03.170:7047) : cwd=/root/workspace/selinux/selinux-testsuite/tests
    type=SYSCALL msg=audit(02/05/22 11:47:03.170:7047) : arch=x86_64 syscall=getxattr success=no exit=EACCES(Permission denied) a0=0x7ffcd27c5651 a1=0x7fec8529078d a2=0x645b39a13550 a3=0xff items=1 ppid=76535 pid=77228 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts1 ses=1 comm=check_mount_con exe=/root/workspace/selinux/selinux-testsuite/tests/filesystem/check_mount_context subj=unconfined_u:unconfined_r:test_filesystem_context_t:s0-s0:c0.c1023 key=(null)
    type=AVC msg=audit(02/05/22 11:47:03.170:7047) : avc:  denied  { getattr } for  pid=77228 comm=check_mount_con name=mp1 dev="vda1" ino=390506 scontext=unconfined_u:unconfined_r:test_filesystem_context_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:unlabeled_t:s0 tclass=dir permissive=0

In fedora-policy unlabeled_t is associated with the attribute file_type
and thus the access granted by the rule

    allow test_filesystem_context_t file_type:dir { getattr open search };

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policy/test_filesystem.te | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 4e27134..46e3f1a 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -382,7 +382,7 @@ allow test_filesystem_fscontext_t test_filesystem_context_file_t:file { create g
 
 # For testing rootcontext= Set mountpoint to unlabeled first
 allow test_filesystem_context_t test_file_t:dir { relabelfrom };
-allow test_filesystem_context_t unlabeled_t:dir { mounton relabelto };
+allow test_filesystem_context_t unlabeled_t:dir { getattr mounton relabelto };
 
 #
 ####################### Rules for nfs_filesystem/test ###################
-- 
2.36.1

