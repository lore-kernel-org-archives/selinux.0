Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E9C46467
	for <selinux@archiver.kernel.org>; Mon, 16 Jan 2023 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjAPVqr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Jan 2023 16:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjAPVqk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Jan 2023 16:46:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B6265A4
        for <selinux@vger.kernel.org>; Mon, 16 Jan 2023 13:46:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v30so42465455edb.9
        for <selinux@vger.kernel.org>; Mon, 16 Jan 2023 13:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVXbh7iY4veoyv7uc67an2tl8zw1Uhf+X9eMeG3LOrY=;
        b=hgD5ieI9NrYkyQgXveKq+TTVb1jEeK8FaRsezzxpotwq+zmxW/rffiXm2IKRXLNU9j
         Btdizni0yBzKNvJ0YgbZyUovNvSBScCCbMvEF0/wpy271DCuhYTb94wgznvo0Rsaz6wr
         pWrqL/b1dVt30hvnWGebvc881L6WyjEmmf8c1xzEoQuy1+ED8fORdEm6siwpKv6V0bWz
         a06RWU/NN+BrTtH8S5VyTaNeAyNVTRJl+RIhfqtVm1g0OJHwiaVDIsIygwgZYpC16jfm
         fmug3bSkDViZ6NH1BSJG0RxoOBSvOjilESDxNUfW2QFhfj2PSBt66GuqL+jM4b+b1GiZ
         kGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVXbh7iY4veoyv7uc67an2tl8zw1Uhf+X9eMeG3LOrY=;
        b=w74aCXOyOJ8JoJ9yHIHJxobWO6HIrxSMYUKzdZbYtokjk4y8jAB3uZo+D9wAxS3TyD
         xPzQVTiaz7P8roUX6mxcVwf0yJbn+1R5VFsTtaeRAj3DG38GJu8zC4ZftddnewpIemcs
         a2P8ODW066xSyyF+2Ok8ti+G35PSoT5mM3uaP8aPEkt/1afqlVBGPkL6gvIWgePlJk7Q
         C18ud7DbF4f0HnNBeGbV5hKN/aFaXXOsg4D9tmhttbImEgjPLmg85I/8J5vet/H9IUns
         OOrHaYQwby365wZC+vvWZPw7+kqaQlSwwDV0ZKgHxmkyqaqLTQS4B4CKQujg+qKcwbwz
         NAFQ==
X-Gm-Message-State: AFqh2ko6LjlnnKeuFx2dGRcYpuRbop9JUvOfjoCqaXiW1De+wHweyTer
        i4NQF1GxeBr1JH0wbU6dPKvnBiUg151bzA==
X-Google-Smtp-Source: AMrXdXsVdEo/Nl0smAMoXk36VrmE27mM/6/vI7UN3SKTug4d5Ob3Na6rX8jVB455CVc/qUwDU5QRxQ==
X-Received: by 2002:a05:6402:1f8c:b0:499:bf1b:5ee with SMTP id c12-20020a0564021f8c00b00499bf1b05eemr906964edc.6.1673905598258;
        Mon, 16 Jan 2023 13:46:38 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-139-118.77.6.pool.telefonica.de. [77.6.139.118])
        by smtp.gmail.com with ESMTPSA id z13-20020aa7c64d000000b00499c377b463sm8018167edr.47.2023.01.16.13.46.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 13:46:37 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [TESTSUITE PATCH] policy: drop usage of files_list_pids()
Date:   Mon, 16 Jan 2023 22:46:26 +0100
Message-Id: <20230116214626.28955-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

files_list_pids() has been superseded and marked deprecated in the
Reference Policy since Jun 2020[1].  In the latest release it has been
completely removed[2].

Grant the necessary permissions via raw rules to support recent
Refpolicy versions as well as old ones without the replacement
interface files_list_runtime().

[1]: https://github.com/SELinuxProject/refpolicy/commit/be04bb3e7e63671ed8a3c501a2ee76e11c3b92bb
[2]: https://github.com/SELinuxProject/refpolicy/commit/3ca0cd59d7a9b531dd3620a02940396343fe2ed5

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policy/test_global.te | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index e95102a..4bf30f8 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -121,7 +121,6 @@ allow testsuite_domain proc_t:file { getattr read open };
 files_list_var(testsuite_domain)
 files_list_home(testsuite_domain)
 dev_read_rand(testsuite_domain)
-files_list_pids(testsuite_domain)
 require {
 	type root_t;
 	type etc_t;
@@ -136,8 +135,12 @@ require {
 	type init_t;
 	type initrc_t;
 	type console_device_t;
+	type var_t;
+	type var_run_t;
 }
-allow testsuite_domain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir list_dir_perms;
+allow testsuite_domain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t var_run_t }:dir list_dir_perms;
+allow testsuite_domain var_t:dir search_dir_perms;
+allow testsuite_domain { var_t var_run_t }:lnk_file read_lnk_file_perms;
 allow testsuite_domain lib_t:file read_file_perms;
 allow testsuite_domain lib_t:lnk_file read;
 allow testsuite_domain etc_t:file read_file_perms;
-- 
2.39.0

