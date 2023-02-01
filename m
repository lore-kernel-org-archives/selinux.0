Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238ECC636D4
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 10:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjBAKzU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBAKzT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 05:55:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4459E5B
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 02:55:18 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mc11so27700143ejb.10
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaz46VNTuztP+8XGRf+9Uy7aUzyx7wS8C+XeMQlua/k=;
        b=f8WLN1qf9FeDUUM05gGud5hKLW8otA0dPsJhoqfvk9rF7CgwqyRDEK9NTOo2GbOCIh
         HuZzHet5j7KzdU53ouOw7VZK+iPdq22au0g5b0vVLBjaHIWQyedyeDK6tq7aEfoaQcxz
         vLys0xYw4APmMeEnN2REjnhGKip41n5Bw69S541thsUbXEX6kXaAIo/xP9e5ickesECD
         r8a5lIJ5NCbxkuZ8YSIn9q1ajsNKCjmpn5kNPleHF7GTwDu/nKB4wmNLK4r6uUWTaopy
         BUk17fNEeueps52Fn27H3e62Ou3lQgK1b6lUIQL6whi2P3l2pkt6hj/pXmj7hmCOSjzp
         nSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaz46VNTuztP+8XGRf+9Uy7aUzyx7wS8C+XeMQlua/k=;
        b=ef4eKi1Ve5gLIAnVyCi5AFX52ORx6a+5Lrqn9leOWCfpw1ZsWF3OySy0y3vwC64uZH
         wuM+o8Vv32faLScQH7QpEpzxdBSnYivh03pmz29dKBhZJD15md7R7reWNhvYPPGbCu0Y
         BXvVI0lkYB2Dda0dyDRNH9zvJcjBwrLDB4W8s8H9UXT/4JXj5JH9hz5DzL80xNXv+7mt
         MRpdClnpxl32qpwn+0JW8B4nvBb25RQ0NXCb3tJMxUgTtqkhFUr3SoOu9pzb8CF5J+pZ
         b0U13OFMsG7DePg/XRPLSk8yclN6rv/M/yKOom9IAOCFUpw4FWn/tzrjq9gJ4Ex1vTrd
         v1cg==
X-Gm-Message-State: AO0yUKU1aVs5pBGIWwCuslK1V9iXepuIzPIQd8wQ6gX0CXlhGRbO38Sr
        DXCYioh+PJvJbZrci1eQrcrs8OYpqCIXtA==
X-Google-Smtp-Source: AK7set9m1FMf4N6qHB/rFyeM8YWEOPZg3YfQF9Mr6rfzE7L7THyCcNIPAbHuXPTg30ZLeAUwaRMCgA==
X-Received: by 2002:a17:906:9b89:b0:88a:73b7:6d2b with SMTP id dd9-20020a1709069b8900b0088a73b76d2bmr2149590ejc.62.1675248916664;
        Wed, 01 Feb 2023 02:55:16 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-178-099.77.8.pool.telefonica.de. [77.8.178.99])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm9927632ejg.221.2023.02.01.02.55.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:55:16 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libselinux: restore: use fixed sized integer for hash index
Date:   Wed,  1 Feb 2023 11:55:10 +0100
Message-Id: <20230201105510.14125-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201105510.14125-1-cgzones@googlemail.com>
References: <20230201105510.14125-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The hash mask is set to 2^16 - 1, which does not fit into a signed 16
bit integer.  Use uint32_t to be on the safe side.  Also use size_t for
counting in debug function.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 40a759f0..7ef2d45d 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -435,7 +435,8 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 			const struct rest_flags *flags)
 {
 	file_spec_t *prevfl, *fl;
-	int h, ret;
+	uint32_t h;
+	int ret;
 	struct stat64 sb;
 
 	__pthread_mutex_lock(&fl_mutex);
@@ -524,7 +525,8 @@ unlock_1:
 static void filespec_eval(void)
 {
 	file_spec_t *fl;
-	int h, used, nel, len, longest;
+	uint32_t h;
+	size_t used, nel, len, longest;
 
 	if (!fl_head)
 		return;
@@ -544,7 +546,7 @@ static void filespec_eval(void)
 	}
 
 	selinux_log(SELINUX_INFO,
-		     "filespec hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
+		     "filespec hash table stats: %zu elements, %zu/%zu buckets used, longest chain length %zu\n",
 		     nel, used, HASH_BUCKETS, longest);
 }
 #else
@@ -559,7 +561,7 @@ static void filespec_eval(void)
 static void filespec_destroy(void)
 {
 	file_spec_t *fl, *tmp;
-	int h;
+	uint32_t h;
 
 	if (!fl_head)
 		return;
-- 
2.39.1

