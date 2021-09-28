Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D1C433EF
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A72B61246
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbhI1Ps4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1Psz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:48:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324FAC06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s17so66157745edd.8
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JKnQuMHaBMfpY/3fWHFejTQul5LVF20aHJanG2kNNXE=;
        b=OG/bXFko2YOTdeus952N9D1zF5NkQB5CoTBKpc6vQQJZEcAjRdlZNkV0+deItNkvlQ
         0XDl310B9R9oggJlTREjYKs65qrJlcntJg/MCVlKpy1gxZR5Iw+zR24fj8/yP8Xu5BjX
         NF9WsaOVqkkUfABabj2axCEXKU+XW96NYjBNawW4N0bnzUw3EJzsoU8X8ibizo9Av6zi
         aCHtsYF5Nh4vg4dr8ADnir9YYLpgl93jEIqqm7ttHyT9lWBwoSw4YKFw5BKKDORMuoyj
         ssC/5smmzH4IVmaRv9zn0wSO8vK5iXgJtf6d6yjDwZ4IlxIk9MByTmQ7y5H9w2SYTgSM
         iyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKnQuMHaBMfpY/3fWHFejTQul5LVF20aHJanG2kNNXE=;
        b=mHvDGNWv9JJLEQVNKxOTjCmiCgMdpVr5Jh1yJRgHS3LTNqf928StRU/ICyyMnBH30E
         fGRTd+pOM6KUrlzWi6WdaumOwZj5AmTXTraYc80fz8hnPha4FyeHH3ssbXPjEGlJ0mjE
         Xmw8NAg18y/oSTW6TJ6xMEg2hsEOJN/acFq/3m1Bn+/H3r9P9KNY94fdF0YxoLgfWG9Q
         d4R+0A/HOc2aeFJyrWXFHN7eGUxQ6dMriN9nKJHLK394geFJyqo5nuEh0wK5FV2k0iss
         Wzdjqnan0lCiWpHOhn8fr4IfM/9cl79S1yk7sjVUBwA+03UMcQmxZ26T6Z0EVtlFzhkU
         XV7A==
X-Gm-Message-State: AOAM531Fbnvt09+Tjo5kABkpWzEnH4yI5rnmJtXPDK6xAT3ILZepjPTr
        K2tNMLpDmo1wlUQ7I7x90+9bJvxRPqI=
X-Google-Smtp-Source: ABdhPJzm90xsDzI3WQPSVf6I2QEx7uQYMkU/J+nEyaP07IokUiWHhklw2X1dS8Y+9RnA8oGLFzJrLQ==
X-Received: by 2002:a17:906:6b1a:: with SMTP id q26mr7246771ejr.185.1632843986892;
        Tue, 28 Sep 2021 08:46:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 7/9] checkpolicy: update documentation
Date:   Tue, 28 Sep 2021 17:46:18 +0200
Message-Id: <20210928154620.11181-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add missing command-line arguments to synopsis and highlight mentions of
other tools in man pages.

Add missing space between arguments in help message.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkmodule.8 | 11 +++++++----
 checkpolicy/checkpolicy.8 |  8 +++++---
 checkpolicy/checkpolicy.c |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index c4b1592b..1061a6f2 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -3,7 +3,7 @@
 checkmodule \- SELinux policy module compiler
 .SH SYNOPSIS
 .B checkmodule
-.I "[\-h] [\-b] [\-C] [\-m] [\-M] [\-U handle_unknown ] [\-V] [\-o output_file] [input_file]"
+.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-U handle_unknown] [\-V] [\-o output_file] [input_file]"
 .SH "DESCRIPTION"
 This manual page describes the
 .BR checkmodule
@@ -15,9 +15,12 @@ into a binary representation.  It can generate either a base policy
 module (default) or a non-base policy module (\-m option); typically,
 you would build a non-base policy module to add to an existing module
 store that already has a base module provided by the base policy.  Use
-semodule_package to combine this module with its optional file
-contexts to create a policy package, and then use semodule to install
-the module package into the module store and load the resulting policy.
+.B semodule_package(8)
+to combine this module with its optional file
+contexts to create a policy package, and then use
+.B semodule(8)
+to install the module package into the module store and load the resulting
+policy.
 
 .SH OPTIONS
 .TP
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index f4e6fb24..2984c238 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-V] [input_file]"
+.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-O] [\-E] [\-V] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -13,8 +13,10 @@ command.
 .B checkpolicy
 is a program that checks and compiles a SELinux security policy configuration
 into a binary representation that can be loaded into the kernel.  If no 
-input file name is specified, checkpolicy will attempt to read from
-policy.conf or policy, depending on whether the \-b flag is specified.
+input file name is specified,
+.B checkpolicy
+will attempt to read from policy.conf or policy, depending on whether the \-b
+flag is specified.
 
 .SH OPTIONS
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 9459486b..6740c6d4 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -109,7 +109,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
 	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
-	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O]"
+	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
 	     "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
-- 
2.33.0

