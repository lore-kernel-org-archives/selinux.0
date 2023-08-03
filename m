Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24993C04A6A
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjHCQXe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjHCQXd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 12:23:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8AD30D5
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 09:23:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1461677a12.1
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691079810; x=1691684610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T+4o5IqM1ckjv1vB6Hj+yuZO8zxIn1UbsF72lQnCa4=;
        b=NJ3r4C8epSqMA5Y0ij5563ebDDj4KB6wNygl28VMxB0J0Tdn8t4vQZLwE+z0qsy6qn
         iah71iHYLKJxeVvz3eZsecDSiTYlKQe8XL6fXLB4re3Vg/5E8Latqf7zPmkhkzHZc4Jg
         1QcH1aQfhOGCQjF4lIBW4j88TJOvpReVXA+rrEwvhQX/W1SkDpPrVEzfAH1vhSwF+s7Q
         g+maoCk3G+VeKdHOFx28v03fTjdnsLKaURPDI/aFRcFt5ATPYZX+NY6um5NFplu31lTQ
         BLtPwATfrjxi0kst5A5Votxo6ZLdKVt4LOoxDKHuVIzrbKz33A37LYow7uG13Zp8czNY
         M+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079810; x=1691684610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2T+4o5IqM1ckjv1vB6Hj+yuZO8zxIn1UbsF72lQnCa4=;
        b=P2ullN7OQqER9neVgEmiNhSQWO77ZZl3/StnvA2qcqh8510TSXBAgh+pP7ZaQn7ZlE
         26obAxvstyYAIbtUZGXq0/pGTSSI80UMxlEr1S+O+aEIksT9DCfywnY2fWAstu7pj3P7
         fEeUDm5igRhmxfzVIYMfHbImw2DMmMjl+hOXthogi9iETwM5CvHiYG4eV+ptSXXtsFkw
         1ck5vUszaqcQqoB0GURkVKIrmJ8FJpHQs7qalSC8IXAXGQdxeEfsuroBQyRHETdu1QjX
         Qr7rC33XbXXD2BovZz+ZZM9bqW5YrfEJDTBl4dJRjAyfo6T+UWHCnF8AHKzuIOOphs7k
         LAlw==
X-Gm-Message-State: ABy/qLYUfamXEA9PrO1TnvDhZ6MPQFzvNm7yEQjQqi/I0XC7UUsMUIsD
        wB2RXWBufYIlQ49qnkPNQ12SNsKbk1fpjsSz/hk=
X-Google-Smtp-Source: APBJJlFDzd8R2gki70N43uEEzdKhYQ30Z8NZukVUeJRULzGEArkeb25EnsmMVKTtzs6RaPFEqdNFTA==
X-Received: by 2002:aa7:c994:0:b0:522:2d1b:5a38 with SMTP id c20-20020aa7c994000000b005222d1b5a38mr8074960edt.10.1691079810454;
        Thu, 03 Aug 2023 09:23:30 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-150-191.77.0.pool.telefonica.de. [77.0.150.191])
        by smtp.gmail.com with ESMTPSA id u4-20020a05640207c400b0051d9ee1c9d3sm348edy.84.2023.08.03.09.23.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:23:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] libselinux/utils: update selabel_partial_match
Date:   Thu,  3 Aug 2023 18:23:23 +0200
Message-Id: <20230803162326.302824-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Print usage information and exit if required path option is not given
or superfluous arguments are given.

Constify read-only variables assigned command line arguments.

Simplify bool evaluation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_partial_match.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/selabel_partial_match.c
index 7bbd5777..0df2627a 100644
--- a/libselinux/utils/selabel_partial_match.c
+++ b/libselinux/utils/selabel_partial_match.c
@@ -28,7 +28,7 @@ int main(int argc, char **argv)
 {
 	int opt;
 	bool partial_match;
-	char *validate = NULL, *path = NULL, *file = NULL;
+	const char *validate = NULL, *path = NULL, *file = NULL;
 
 	struct selabel_handle *hnd;
 	struct selinux_opt selabel_option[] = {
@@ -55,6 +55,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (!path || optind != argc)
+		usage(argv[0]);
+
 	selabel_option[0].value = file;
 	selabel_option[1].value = validate;
 
@@ -69,7 +72,7 @@ int main(int argc, char **argv)
 	partial_match = selabel_partial_match(hnd, path);
 
 	printf("Match or Partial match: %s\n",
-		    partial_match == 1 ? "TRUE" : "FALSE");
+		    partial_match ? "TRUE" : "FALSE");
 
 	selabel_close(hnd);
 	return partial_match;
-- 
2.40.1

