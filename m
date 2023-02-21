Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9932AC636D7
	for <selinux@archiver.kernel.org>; Tue, 21 Feb 2023 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjBUPjz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjBUPjh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Feb 2023 10:39:37 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A12CC53
        for <selinux@vger.kernel.org>; Tue, 21 Feb 2023 07:39:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h16so19028929edz.10
        for <selinux@vger.kernel.org>; Tue, 21 Feb 2023 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDUdkz+msszouP/Xgohia9J6m96MJ9GvoquJIRIExPQ=;
        b=a3NQ/wiRhAD5ayA33sipdBvLvPt1iqc14wP9ehXwepdxImQOS/4ZcDgwy7kmT5jvEy
         LPToXtWEERmPROM9gkvlvRiji90/UxFq5bLFRqs7oxkIfRYIaQpu3g/R/a2aL231nOEf
         cu/Rt4PAowsMQEYy+F+Ulf9mpc/GkSznCpLRdcprY+pS8UYjxV7V3zMdyVovu473Rm3r
         QFmABNg/+KmKcs61sX9rB/PPtlmhEo/gmOuUa2il6HlqoYClLPf+ZtD3wgkOhotZNbAr
         lFB7X+f1SnKMoKuQHk56ATLx74DFtxFMbix9DNaWBiFU+XwWaZ00TGlFuPsKep08sPey
         SWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDUdkz+msszouP/Xgohia9J6m96MJ9GvoquJIRIExPQ=;
        b=nlHrl4gPu2hzH+e1p5XCHR2qZYiYKMbVwtTpMUn5Ko53OCqHgad5JSKdgvqr/Mj5Jo
         xqOkNv14yHqqeUZTFlBmqycmdWROcLsCVZ8miUeGifx4ivjbE0ncVm3JncY9HlqFeLtJ
         T5By6v/nzDBO0X0LYacKYbFNvLUu8VkhapES1SRnxjapFLd3a2jcV/2jDfTsdB6xPCS6
         0a8+VImMNhUQdpNar6O3p27J9/qfErRNBRgvWVB3QlV26wHTwmS5O08LaWkaPBTUMDj4
         OJiO2P9pyHhspqgdXut+hQacQKFMzISf2Zgu5aKphIFBZL40deW+2Dkqb1rnj5hYpF4n
         zYBA==
X-Gm-Message-State: AO0yUKU1F4d6br7PBPJk/2t/mQeOl65E2RVHaOpOIilIiLQ08VOkKEWd
        mx84w4gYVOntbEuv5KG9S0TM671RJ5MLwSvymEo=
X-Google-Smtp-Source: AK7set9vKPTCPRuVAhoaJmyJA5yNkrzgQjOGe+Dckr0at9tt8afkJfgROHTooaPcAEl07JmL0t+f2g==
X-Received: by 2002:a17:906:af10:b0:8aa:c038:974c with SMTP id lx16-20020a170906af1000b008aac038974cmr12630820ejb.54.1676993931656;
        Tue, 21 Feb 2023 07:38:51 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-098-179.77.0.pool.telefonica.de. [77.0.98.179])
        by smtp.gmail.com with ESMTPSA id z26-20020a170906945a00b008b23b22b062sm6014105ejx.114.2023.02.21.07.38.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:38:51 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [UTIL-LINUX PATCH] mount: add rootcontext=@target
Date:   Tue, 21 Feb 2023 16:38:15 +0100
Message-Id: <20230221153815.4631-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a special value for rootcontext=, namely `@target`, to set the root
context of the new filesystem to the current context of the target
mountpoint.  Useful for in-memory filesystems, like tmpfs and ramfs.

Closes: https://github.com/util-linux/util-linux/issues/1830
---
Pull-Request: https://github.com/util-linux/util-linux/pull/1876
---
 libmount/src/context_mount.c | 18 ++++++++++++++----
 sys-utils/mount.8.adoc       |  2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 7b897345c..eba64b6c2 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -154,7 +154,9 @@ static int fix_optstr(struct libmnt_context *cxt)
 		mnt_reset_iter(&itr, MNT_ITER_FORWARD);
 
 		while (mnt_optlist_next_opt(ol, &itr, &opt) == 0) {
-			if (!is_option(mnt_opt_get_name(opt), selinux_options))
+			const char *opt_name = mnt_opt_get_name(opt);
+
+			if (!is_option(opt_name, selinux_options))
 				continue;
 			if (se_rem)
 				rc = mnt_optlist_remove_opt(ol, opt);
@@ -162,9 +164,17 @@ static int fix_optstr(struct libmnt_context *cxt)
 				const char *val = mnt_opt_get_value(opt);
 				char *raw = NULL;
 
-				rc = selinux_trans_to_raw_context(val, &raw);
-				if (rc == -1 || !raw)
-					rc = -EINVAL;
+				if (strcmp(opt_name, "rootcontext") == 0 && strcmp(val, "@target") == 0) {
+					rc = getfilecon_raw(cxt->fs->target, &raw);
+					if (rc <= 0 || !raw)
+						rc = errno ? -errno : -EINVAL;
+					else
+						rc = 0;  /* getfilecon_raw(3) returns the size of the extended attribute value */
+				} else {
+					rc = selinux_trans_to_raw_context(val, &raw);
+					if (rc == -1 || !raw)
+						rc = -EINVAL;
+				}
 				if (!rc)
 					rc = mnt_opt_set_quoted_value(opt, raw);
 				if (raw)
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 318b2fe23..5948d3389 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -508,7 +508,7 @@ The *fscontext=* option works for all filesystems, regardless of their xattr sup
 +
 You can set the default security context for unlabeled files using *defcontext=* option. This overrides the value set for unlabeled files in the policy and requires a filesystem that supports xattr labeling.
 +
-The *rootcontext=* option allows you to explicitly label the root inode of a FS being mounted before that FS or inode becomes visible to userspace. This was found to be useful for things like stateless Linux.
+The *rootcontext=* option allows you to explicitly label the root inode of a FS being mounted before that FS or inode becomes visible to userspace. This was found to be useful for things like stateless Linux. The special value *@target* can be used to assign the current context of the target mountpoint location.
 +
 Note that the kernel rejects any remount request that includes the context option, *even* when unchanged from the current context.
 +
-- 
2.39.2

