Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153EC4167B
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 18:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjKCS1I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjKCS1G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 14:27:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3FD7B
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 11:26:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so32453311fa.0
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699036004; x=1699640804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPq51/zWKEaX0Ugs0BO93z31TvLRHL0P4szzXPPrFYA=;
        b=Lb3pOtPVzJm3Mlx3dIEoQH0AB2HsPk6cTdTWa8QFjXffEbFfPnIhLH6RAIsb/FGZKx
         Ju9zr89uEGDN6FPyoFEjM1IkNNzj6yxlMUK+9T4ZO8l4Dd3YsMxKTeyfGI+97q62n027
         6edkd2OH5HnBP1zrUlyDLRlxfP0mHk/Hq0Z4fThN9F43VX4nfcfDrzzXVEJFeYZBvxEI
         WVVT+eUQIAAE8+ggiyGAN0maB81FJHQ6GHSxBI/fuzku4wtN2eAOdxls5Ujw9oV59bQI
         vj0LiQYJf8VdVw6uirqT4UAlPzmOg/dHGRQcxinTOCTcxRc+rRGuoefrbEELtmfYSu/e
         NnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699036004; x=1699640804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPq51/zWKEaX0Ugs0BO93z31TvLRHL0P4szzXPPrFYA=;
        b=L8xu0G027OYB3R6D00Ip3SVsVSmMAXZMlszM53RZdECrGLnaKrd+3RB8CsYqDOTsPX
         mbOIHtyDzM4JS7Yh9RWkB6fmSjIeSN02ot3/+CFZHq5lScQbS4pRkZAXjhQCs2qkjstd
         vlIbz1iQkB2du0qhzMYFkPN12PJqpSQZb208yo3UhyQO7udCUW4iGS2scaOSFa/8Ocx5
         Vn56NHQ+AZTb7VT/udXasM1M2AlzD8OViCAWtWgjs60c2CienqexzmHqqKZUKRPiD6eK
         qwW6a73fUWnId6vQcV0MvaRSBHsZMn3CizTOltrSPRwWYb25EiSsavPSskwpUFPUyNXc
         Wrpg==
X-Gm-Message-State: AOJu0YyhyFv228baorWHDw+hnjIzwrAKvQ12mz9qlfZRI298CZC07wP2
        h6BkjrOCIr6sqm7aJIkr0B+aNRDbU2w=
X-Google-Smtp-Source: AGHT+IGCY/bRs9qQYuYzVf8zQjW8UwhVmnLXnJYzIn8xmNA/S3IogfN17bFcHOg/06cRAI07FkyTRg==
X-Received: by 2002:a05:6512:34c8:b0:509:497f:c327 with SMTP id w8-20020a05651234c800b00509497fc327mr4031903lfr.0.1699036004104;
        Fri, 03 Nov 2023 11:26:44 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-003-098-230.77.3.pool.telefonica.de. [77.3.98.230])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b0052ff9bae873sm1210275edt.5.2023.11.03.11.26.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:26:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/3] libsepol: more strict validation
Date:   Fri,  3 Nov 2023 19:26:37 +0100
Message-ID: <20231103182637.85003-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103182637.85003-1-cgzones@googlemail.com>
References: <20231103182637.85003-1-cgzones@googlemail.com>
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
index b20ed579..d04f6bcd 100644
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
@@ -1203,6 +1207,8 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p, valid
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

