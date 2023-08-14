Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E89C0729B
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjHNNVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHNNUx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61619A0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1d03e124so530909966b.2
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019245; x=1692624045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gz2DG6hVVCAcG3/CCzRTc/rhYhJL45RjMUpsbqCWED0=;
        b=kzLrl3ylMzMNMqCPp6KR95zqm+7uMLP06CqKumPN3HEo0RTTojKreRPAW93giqyWi/
         4QQUncDHxU4yAphxblJ6glxWMIJx9zx85gVxUjJ2izuJm10bm4ADiJCh4abHgNPnCkAd
         Y9T1VEAtVs6l0NGbnuhhRe6rAsvA7aAo3mmtGVc04eMwrwisD7ax4/kkD3z/kTn8I+Nl
         FXKtJCVjfSW0N6VC04cAesYOoF2D2vtV3gs8l1BcXMDVVGxHZvO3+YQvncgC1A6qfInj
         tjPJiv/N/Glt1SyTqdArzmIvemtf/L4ofRC2Bn/wBYUVfCRzEf8ZrIY+mE1aOVu9BZaf
         p/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019245; x=1692624045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz2DG6hVVCAcG3/CCzRTc/rhYhJL45RjMUpsbqCWED0=;
        b=S+3zlsoaLe/lf76aaKFPEr/AFsEbICktWOOipzqOX13O4pvEe0ISnfssw8fUAHLulG
         WDsNn+2FZuA9ePXUxfQkw+efmCcnZZIu0PLj8lBF4sE4SYuSofU8ylhncKnoObibf3gf
         krVJ2WXNdiVCwsCelI2inLxlStbq9MhloxMkJaaFlnaSCDWUpEkcda6nKkTUZGUOza7X
         yrMm94xHktJSYL7WYn+QiCCq1hR8JwalMTeZYQmk9voG+Z4eoVrAaZABDlak9Sh9dEht
         9DahBAkeshq/w/osYul02KfdfaPxQ9lLQAPw5o/d8fR5LFOi/mVNRv0rX+N99iIOjSzu
         jjbQ==
X-Gm-Message-State: AOJu0YzPkAoKwpQSg+dwjNEico4PqPckrHh0GPdohowxv6Mb858+eGUW
        UbxpDdq/8aqp5tgV/eC5jb1TkeGk+oaMLag+1f8=
X-Google-Smtp-Source: AGHT+IEIWDVdVayEamvtqEyaYHFLgLDQ8n6auVZqQ1AsyxVsDfCD92JoWO1fN1YbcbnikZu3tGBWFg==
X-Received: by 2002:a17:907:7808:b0:99c:5708:496f with SMTP id la8-20020a170907780800b0099c5708496fmr6888803ejc.47.1692019245305;
        Mon, 14 Aug 2023 06:20:45 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 09/27] libselinux: simplify zeroing allocation
Date:   Mon, 14 Aug 2023 15:20:07 +0200
Message-Id: <20230814132025.45364-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Merge malloc(3) plus memset(3) call into calloc(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 5ac23e1f..b9be1c9d 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -716,10 +716,9 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		if (! *dst)
 			continue;
 
-		sub = malloc(sizeof(*sub));
+		sub = calloc(1, sizeof(*sub));
 		if (! sub)
 			goto err;
-		memset(sub, 0, sizeof(*sub));
 
 		sub->src = strdup(src);
 		if (! sub->src)
@@ -1357,10 +1356,9 @@ int selabel_file_init(struct selabel_handle *rec,
 {
 	struct saved_data *data;
 
-	data = (struct saved_data *)malloc(sizeof(*data));
+	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
-	memset(data, 0, sizeof(*data));
 
 	rec->data = data;
 	rec->func_close = &closef;
-- 
2.40.1

