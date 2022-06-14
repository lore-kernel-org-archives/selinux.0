Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A6CCA47C
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353999AbiFNKUp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353908AbiFNKUl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 06:20:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C047395
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d14so10893657eda.12
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SyaBdVPVW3Xwd5w3bqkEnZxWpvGDJO8hWc12yYaeDRA=;
        b=X5JKRUvDTTvW0kYMgn9zWzpvnP9sGqHX3AFSTYqWC0h/ondD6Quke0ILI9bnoxtsjS
         p4MvEYuJ8q9Dh0NNhJDQ62g+8KX5iPAwprBBxwDOg5SvdDeb4iaRiRhesj+49Cvg8z2A
         xOHvuyt0tNG6qC51oM0gZspEN7YWDRdZfWQIMoao5BsBnkdbRBnuoR6m6RlAGlTDsSS8
         r1NmDcDZu2qFzlWj3RKsK09GpL/gS1FnuxmS7mbP4Yac5b8mQyX0ePPbAz5YbC9FT6gO
         Amw13T0cmOrGTNPOktbq7+Yo04McgsPXMtPo2mXdFlDdglOc1yRrqXsJajPY3xmKM0IL
         fzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyaBdVPVW3Xwd5w3bqkEnZxWpvGDJO8hWc12yYaeDRA=;
        b=ZeoqSqSZNU7wXl+DbUEBIhPiIqQHSCfG/v5d+Vc+Qnd1iXi/xVrbLtH4lYgRZNAt/0
         Xh2H4G5V3YDKbUdDbZT58rQJd6rnrJs2Xvi/s2T/BEc6aY/xd+fWDk4X/cIgeOz3BudG
         iO6th3Wssyh7FBNKnSQRW9xMUdL+YhlWJOJiNVsHuGQJgSU4EkdeRveX6u7T+wzIuofN
         56waNj70WZnrvBaFWNAHpLe9ueXuHfFfsDhpEo/qSmRDd9FfssS9kGAORvHgb4p05p5c
         nTiYI8vYjXeHrzJe0mgKDU+DBGfrLiRLTEiuiNOyyFLVDJ2YIXnjJuCQ5ealIIfYH2Zi
         l2Ig==
X-Gm-Message-State: AOAM531x1PlRAsqg5ms0DxxK7SXL0sShAT+jSaU5ZHEtn/mlAzHrRimw
        qRH6PTAThVYGuthXteTNM1vxcXRZtQ4=
X-Google-Smtp-Source: AGRyM1toiWsvgSgPLQNk4lfbgdEuGnURYr8deACp9S3tID++c06OIDkb9j2+8gsRONgmJHTvbLcS8g==
X-Received: by 2002:aa7:d6d5:0:b0:431:b7c0:50c9 with SMTP id x21-20020aa7d6d5000000b00431b7c050c9mr5132849edr.62.1655202038318;
        Tue, 14 Jun 2022 03:20:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-087-232.77.1.pool.telefonica.de. [77.1.87.232])
        by smtp.gmail.com with ESMTPSA id gv17-20020a170906f11100b006febc1e9fc8sm4871186ejb.47.2022.06.14.03.20.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:20:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] filesystem: allow getfilecon(3) to pass test
Date:   Tue, 14 Jun 2022 12:20:28 +0200
Message-Id: <20220614102029.13006-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614102029.13006-1-cgzones@googlemail.com>
References: <20220614102029.13006-1-cgzones@googlemail.com>
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

