Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB7C77B7F
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbjELKXj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjELKXh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F6E70C
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso14716574a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887010; x=1686479010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzQQS9CaBHFklgqFBv69aCqDC9LqvjnUF8D3AJChTho=;
        b=OShm2TSxe2rSzox1EcJh3tSbeis1E0Ab5YJGqcolN4WQZ8PqvZu++0hn+DlyTp+IfO
         SV9RhrQaOY753w/ZqFuBHgx4sI9qIWzmNavbFQSsVDSN6ugHGHfJj91vwoF4DIecVop4
         INQ+y1WnGmLw4Uvu+9X2I5L1BJVtEutw+ZKQfZ3WNkLAXGc14YiYYWoGWUYUDmiGdq17
         K4OsW4g53eLALt56i3CJe7EgFf1U3O4v2AEE3T/YI0jC5HDrBiS0K/IQIOzhIK/smeJy
         hNdoi24wkwNhtpxhEzsQOlsMwCRw1EH2DfHbca4ycYWJ3K7sYMlp59tAreEyENX14O7v
         5Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887010; x=1686479010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzQQS9CaBHFklgqFBv69aCqDC9LqvjnUF8D3AJChTho=;
        b=WWBkDrZwJ5u0bq2IWgtOBRUotvnFff/2PAYN4oC+DO6T9Uxg75yamZ6eBr3V4mmrKd
         MQHpeu2a1ebhMHT3j4W36DMZsjFlvtj0p9DV+2cqWCEyQvDjzYBT10TaJrFGChsgMLKN
         ScArLk+DYBUmTMHKAg6RTfimgAH0lCwaUnBRl9A5F7TiZea8jKj4i2+BQ/cJBNs8piJn
         jLVHNjQPaMxtUvx8UpYNv9fEf98+F1E5eNavHFRQr1ZMn+StZhPPHWIHrt8bD9gSXlTf
         W/vfqxPxapTcE9jrXsmF0MVDvMVT9uk1/luPOiaU+1TnFoQC7JFZ+jbS8N1vc8UlLane
         LQxw==
X-Gm-Message-State: AC+VfDzwFxVarytjn97ZJbyh/qXIb2suzWRhMo12RQ0ujPf6SJ6fElEq
        3AOtfIQBQTla5CbvoP4jyNWCdaPQqD3jOg==
X-Google-Smtp-Source: ACHHUZ7XoKwptnelsepDxP7ZFu6B1NWI2byYizRPG/fl6Jz1AzNPaHdVANFYK8Awawaz1FPgoKFW4w==
X-Received: by 2002:a17:907:3e1d:b0:94e:dd30:54b5 with SMTP id hp29-20020a1709073e1d00b0094edd3054b5mr26051343ejc.6.1683887009669;
        Fri, 12 May 2023 03:23:29 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/9] mcstrans: check getcon(3) and context_range_set(3) for failure
Date:   Fri, 12 May 2023 12:23:17 +0200
Message-Id: <20230512102322.72235-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    mcstrans.c: In function ‘new_context_str’:
    mcstrans.c:926:9: error: ignoring return value of ‘context_range_set’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
      926 |         context_range_set(con, range);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    mcscolor.c: In function ‘init_colors’:
    mcscolor.c:252:9: error: ignoring return value of ‘getcon’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
      252 |         getcon(&my_context);
          |         ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcscolor.c | 3 ++-
 mcstrans/src/mcstrans.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index 9ff0ce2f..7d8f676e 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -249,7 +249,8 @@ int init_colors(void) {
 	char *buffer = NULL;
 	int line = 0;
 
-	getcon(&my_context);
+	if (getcon(&my_context) < 0)
+		return 1;
 
 	cfg = fopen(selinux_colors_path(), "r");
 	if (!cfg) return 1;
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index af3f507e..34dceca5 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -923,7 +923,10 @@ new_context_str(const char *incon, const char *range) {
 	if (!con) {
 		goto exit;
 	}
-	context_range_set(con, range);
+	if (context_range_set(con, range) < 0) {
+		context_free(con);
+		goto exit;
+	}
 	rcon = strdup(context_str(con));
 	context_free(con);
 	if (!rcon) {
-- 
2.40.1

