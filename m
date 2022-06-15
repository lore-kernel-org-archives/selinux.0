Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B1CCA473
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354769AbiFOPi6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355063AbiFOPir (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 11:38:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8313DC6
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 08:38:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so23996445ejj.12
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJ8ffxeT0iHz0XntzlGTrEeeiqV0BUSbMNvSqdQXuwY=;
        b=bZfdENfigEX87gM/Y3vn8fkB3ef4qcZQGbIKj9NtyrO9ZeblKtuqsp/M12QHM2KSKk
         g26RK1oBlL7kg4OEz3jrtLa4Hd2bV+e1HgiiGr7wJxjXanSl72Af6k3vw79AkpfRiWub
         UVKDTI40Dm2X2DGlZwRR16en9tM4JxxP9QjMjGYSF1uP10UXBK3WDpGEJv5ia7rc6nkl
         iVQtChFIiKlU9s7hX1HAs9fBm/SU5zRObYP/MJAxxon376HIsXMSEi1NoCg7vJqtfEn5
         HfssgoK8sInSJFSfyS1yQtAB54sdo4bNokwynL9RjpRyv5eRRT1Vj4cidTkZrxUvCMBc
         oOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJ8ffxeT0iHz0XntzlGTrEeeiqV0BUSbMNvSqdQXuwY=;
        b=iOTQO08ErtKkDpGzwQ4RRa7ZQFfDTi5uk8Qj6ke6LhP5F6puRn/OUmoNqeFma3KQgv
         fMW1KnBmDd2b+Hvcm1yU7d+xh0zfo3Afz+BPMnOgXq8GpKEkXwNfsGMlALAx9cz4iDSS
         iYLwvKOy4xlvJrmUxrcy0AMCJyPLC7jWWalEL+ioAy/yLOXu5K7vW56FHnSEB9tukxL6
         ZkM328ynZ2GJj74pcg4yfacvNrzBoz8IUT2gnB5pY22ypNQF/va/CpSnhe2qltCt7t8Y
         Qbaa7ZITCaRz9nEwXzP8PbrpqyXPI6FjQwgrJkqHLb14XVZ04pziFLI32I1mJk9ibTRf
         UqeQ==
X-Gm-Message-State: AJIora+0bLbW0IK6paifsp+zGgrWVIOcPDyNWgaeFLWezv/l5Mbn+a0G
        YCbZAw1v26OlgRpg1IkeEuHyEMPtugxc4Q==
X-Google-Smtp-Source: AGRyM1v43Ma8v5v/KWXPjYrN53j47L8a8x1omADryKE5yPNZ7I1G/51YncC2X5/NF6qWZ7KA07Uxog==
X-Received: by 2002:a17:907:1620:b0:711:da21:d836 with SMTP id hb32-20020a170907162000b00711da21d836mr355765ejc.427.1655307524012;
        Wed, 15 Jun 2022 08:38:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id e11-20020a056402190b00b0043120d5f3dcsm9888021edz.14.2022.06.15.08.38.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:38:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: free contexts previously transferred in selinux_add_opt()
Date:   Wed, 15 Jun 2022 17:38:39 +0200
Message-Id: <20220615153839.314007-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`selinux_add_opt()` stopped taking ownership of the passed context since
commit 70f4169ab421 ("selinux: parse contexts for mount options early").

    unreferenced object 0xffff888114dfd140 (size 64):
      comm "mount", pid 15182, jiffies 4295687028 (age 796.340s)
      hex dump (first 32 bytes):
        73 79 73 74 65 6d 5f 75 3a 6f 62 6a 65 63 74 5f  system_u:object_
        72 3a 74 65 73 74 5f 66 69 6c 65 73 79 73 74 65  r:test_filesyste
      backtrace:
        [<ffffffffa07dbef4>] kmemdup_nul+0x24/0x80
        [<ffffffffa0d34253>] selinux_sb_eat_lsm_opts+0x293/0x560
        [<ffffffffa0d13f08>] security_sb_eat_lsm_opts+0x58/0x80
        [<ffffffffa0af1eb2>] generic_parse_monolithic+0x82/0x180
        [<ffffffffa0a9c1a5>] do_new_mount+0x1f5/0x550
        [<ffffffffa0a9eccb>] path_mount+0x2ab/0x1570
        [<ffffffffa0aa019e>] __x64_sys_mount+0x20e/0x280
        [<ffffffffa1f47124>] do_syscall_64+0x34/0x80
        [<ffffffffa200007e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

    unreferenced object 0xffff888108e71640 (size 64):
      comm "fsmount", pid 7607, jiffies 4295044974 (age 1601.016s)
      hex dump (first 32 bytes):
        73 79 73 74 65 6d 5f 75 3a 6f 62 6a 65 63 74 5f  system_u:object_
        72 3a 74 65 73 74 5f 66 69 6c 65 73 79 73 74 65  r:test_filesyste
      backtrace:
        [<ffffffff861dc2b1>] memdup_user+0x21/0x90
        [<ffffffff861dc367>] strndup_user+0x47/0xa0
        [<ffffffff864f6965>] __do_sys_fsconfig+0x485/0x9f0
        [<ffffffff87940124>] do_syscall_64+0x34/0x80
        [<ffffffff87a0007e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4d20a139a86d..fdf8465aa97b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2600,8 +2600,9 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 				}
 			}
 			rc = selinux_add_opt(token, arg, mnt_opts);
+			kfree(arg);
+			arg = NULL;
 			if (unlikely(rc)) {
-				kfree(arg);
 				goto free_opt;
 			}
 		} else {
@@ -2792,17 +2793,13 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
 					  struct fs_parameter *param)
 {
 	struct fs_parse_result result;
-	int opt, rc;
+	int opt;
 
 	opt = fs_parse(fc, selinux_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
 
-	rc = selinux_add_opt(opt, param->string, &fc->security);
-	if (!rc)
-		param->string = NULL;
-
-	return rc;
+	return selinux_add_opt(opt, param->string, &fc->security);
 }
 
 /* inode security operations */
-- 
2.36.1

