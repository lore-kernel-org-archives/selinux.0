Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3901C4167B
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjKAQil (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbjKAQik (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:38:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B46B11B
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:38:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso2124388a12.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856714; x=1699461514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2ZBmBt3OVeECFdp5EaVDChMvH4meeSVzpOCcU+vBac=;
        b=Xnt5PKt0Xmu3WeqlZPmxj/hpLx8/+sLpZmpmcqlnNmi6cOGCkChNp3t3JkhiE694Yy
         EhBZtiNbnLEJFddUZfb8ufb8RCbK+R8XCdDOVHPSzN1ms2imqkcLeYn0HPEVXUjmKwYY
         REXwnns8Dn1qs2d41qdnpind6WMX3OzvN6w8hdd/BmtfKX820pXuVqXfkVk6hXjTrbUr
         mVG0rVJiT7IVsSwj5tXihUAYR6vYG4kmQk4Uuqn4jQjj2I92GBy5tTdNmXuLZB/d0Se2
         6gEYCfKTsit1wg6DpATGzIzMo+ZowEprFpf41aAyFKV8U/4MT0mKbuzwm8Sf0cGDoVyh
         EBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856714; x=1699461514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2ZBmBt3OVeECFdp5EaVDChMvH4meeSVzpOCcU+vBac=;
        b=V7Cv5MYtAq5p1RypYOH80WvTSq1xe4Yp1owgMtHWuktGCMIijmhvsZgYZCvEj3JAkm
         ro2EQhxwTqEPXrdmu6hW7pK+h5I8DzM0JlVj82BbLbaIqpqbA5NaYRA4vQaqKAV5CBNW
         w29Lzohi+++dYzcm7gtoQYSKyU7K5VyXyc43/fd/I+3gDhz8wEKHXrqr3GGfBL1v89/T
         cJYhdeRheyfk74lNPE39qr+ocBQjWhRI7rzOVuj5/yOMUbJOxcKPN17fxnahCdnulq3f
         1dh7qS0gFZqUxGQrv4hKK63IweY7e1Pqb2MsylcMWfX2YZ1hUEC22mLRwvavwXAaRumv
         uWbw==
X-Gm-Message-State: AOJu0YzJKUNFqOko6zgLcQHVrwNJmeLxyfh4o0fFXUpRVHUzlQWvPL1J
        jRNowsjeV16fbRcm9Khz0h7YR5HcWA4=
X-Google-Smtp-Source: AGHT+IGE63R1EhqgugVjBsR46netgBzGW37Ux0zhI+FCbHDOmBm3Hsx+CJUnrxGgx/wmJXbvw+pO+A==
X-Received: by 2002:aa7:c711:0:b0:540:16be:6562 with SMTP id i17-20020aa7c711000000b0054016be6562mr2977127edq.15.1698856713900;
        Wed, 01 Nov 2023 09:38:33 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0053eb9af1e15sm1245939eds.77.2023.11.01.09.38.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:38:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol: more strict validation
Date:   Wed,  1 Nov 2023 17:38:30 +0100
Message-ID: <20231101163830.177769-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101163830.177769-1-cgzones@googlemail.com>
References: <20231101163830.177769-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure the ibendport port is not 0 (similar to the kernel).

More general depth test for boolean expressions.

Ensure the boolean id is not set for logic operators.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index c6a66fb3..0e4805ef 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1002,13 +1002,15 @@ static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *ex
 		case COND_BOOL:
 			if (validate_value(expr->boolean, boolean))
 				goto bad;
-			if (depth == (COND_EXPR_MAXDEPTH - 1))
+			if (depth >= (COND_EXPR_MAXDEPTH - 1))
 				goto bad;
 			depth++;
 			break;
 		case COND_NOT:
 			if (depth < 0)
 				goto bad;
+			if (expr->boolean != 0)
+				goto bad;
 			break;
 		case COND_OR:
 		case COND_AND:
@@ -1017,6 +1019,8 @@ static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *ex
 		case COND_NEQ:
 			if (depth < 1)
 				goto bad;
+			if (expr->boolean != 0)
+				goto bad;
 			depth--;
 			break;
 		default:
@@ -1199,6 +1203,8 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p, valid
 						goto bad;
 					break;
 				case OCON_IBENDPORT:
+					if (octx->u.ibendport.port == 0)
+						goto bad;
 					if (!octx->u.ibendport.dev_name)
 						goto bad;
 					break;
-- 
2.42.0

