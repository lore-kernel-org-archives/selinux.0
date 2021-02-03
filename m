Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C549EC433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB7264F8C
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 17:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhBCRRp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhBCRRl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 12:17:41 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99767C061573
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 09:17:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so442070eds.12
        for <selinux@vger.kernel.org>; Wed, 03 Feb 2021 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHbYRj5YDeqPeKJB1k9XEmHCynunPqcnx1gDOOtkyy0=;
        b=UI/qQa0qvCVN24cRCBP9Mu9xptTPOt+CrsEVkj3elT42OM0JiJs2JjK0V0IQ53NnlJ
         Tg67Slf9EVwegp9jC6Hi2RCH3cMI3tLbAmV6MrJkD+uCVm4FRmpiA40t4m8iBbcGc/AH
         afTc7MH7drZF8SAkt5/yJLFw//ehH3bRPTJ9alIQn8bmGUx136D4vh+M8xbLWvnaU6Zl
         75yuSwusvijh6ynB51nJ7cvZBPL/O+N8ubIRMejDwVPTcf2xnPYiZzEg7qIW+zj4H5Wp
         sqQYfrDD8IYJCKnuayA/9VQFVuazkU40nIln3en7WWJo9KX/aXyQyiHpKMg50uGOwM+M
         6oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHbYRj5YDeqPeKJB1k9XEmHCynunPqcnx1gDOOtkyy0=;
        b=MKkjQ4M12L24lEQuprGWFjeEMxKw5y5hJwK9TbnQknbL7BH8/QKD40frc+15qB8wmi
         Nh29zJwXEsMVYz2JtOJLawzb85l9lG7hvwpCVgLa45EUNKMoafE8YrK1mbN5nRMNGY8a
         DKFlGztirAxNAY7UmYFODzUkDWW6JY2VOENd7Nk1b7Cs8Ktdo1yv+GY0HfPOcJU+9Qqf
         /Ux9KR+8QjZAMtP5pU75CBIolpvZytqvyVtOtUVKvN8xtieyuESrcZMUtSx2rAwjfl20
         AV9tti3vKvBY+z1BnMZw6V1MaMBchIRZ8IoyjyqNixszOKPW0ShSQ6zTYkeZq17pbfxl
         QjhA==
X-Gm-Message-State: AOAM531iknvXAzAfa+qp854FANTLXApr1unUmWzkbIOp2LN4Ehygcac9
        mFXOnZGCDyCYUCig0jMzmmtr67h1Z44=
X-Google-Smtp-Source: ABdhPJyuQl5YpJbXMpeLBQ9IMdzdzSa5tDdD1tOQ4VlTnPnqsgdqY4l7f11J/Ipo4HHTBXnOY7EYKQ==
X-Received: by 2002:aa7:d148:: with SMTP id r8mr4048336edo.127.1612372620379;
        Wed, 03 Feb 2021 09:17:00 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-080-008.77.0.pool.telefonica.de. [77.0.80.8])
        by smtp.gmail.com with ESMTPSA id z16sm1256353ejx.73.2021.02.03.09.16.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:16:59 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libselinux/getconlist: report failures
Date:   Wed,  3 Feb 2021 18:16:53 +0100
Message-Id: <20210203171654.37002-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the given context a priori, to print a more user friendly message,
opposed to a generic following get_ordered_context_list/_with_level
failure.

Notify the user about failures of get_ordered_context_list/_with_level,
so no-context-found and a failure results are distinguishable.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getconlist.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 29c16640..76654b75 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -58,8 +58,14 @@ int main(int argc, char **argv)
 			free(level);
 			return 2;
 		}
-	} else
+	} else {
 		cur_context = argv[optind + 1];
+		if (security_check_context(cur_context) != 0) {
+			fprintf(stderr, "Given context '%s' is invalid.\n", cur_context);
+			free(level);
+			return 3;
+		}
+	}
 
 	/* Get the list and print it */
 	if (level)
@@ -72,6 +78,11 @@ int main(int argc, char **argv)
 		for (i = 0; list[i]; i++)
 			puts(list[i]);
 		freeconary(list);
+	} else {
+		fprintf(stderr, "get_ordered_context_list%s failure: %d(%s)\n",
+			level ? "_with_level" : "", errno, strerror(errno));
+		free(level);
+		return 4;
 	}
 
 	free(level);
-- 
2.30.0

