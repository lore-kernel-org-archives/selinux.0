Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3151EB64DD
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHKQ17 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjHKQ15 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730318F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf9252eddso306338566b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771275; x=1692376075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qE3ABhVnQhCHOxyYzH8zSMrW/8rvEczqQ6pQab+oN9Q=;
        b=B0MFr0/s1L7q18kLhhmiNmdtCMPVQtyjNIErc7fse6HlEWMOf5GFQWf5le1k9aVtet
         hZ5ss7HN7DfTbKSfaRoA6++0BLl50a5pFlmwwsNQuVSAXNDYIoLMTfNw/mt8kfiRjM3B
         XtHo4+7bi/dpUjGRBHby4QGec6bftJha8pxVcWGDkMDXdHsfyeFCK68+EE6Ok1URv4Ca
         TJxBZm6DZYuErDopAEhBPusMafc0x2u9BhZWlvcebZPJUEaY9LOxuyhN1bxOFyzkQ44C
         7D5CwriVuTdXPYitjXvzn1TXtniB+WeMvdtrzdCRD77PrFRRfw6daoBXcx5dKAve8I1Z
         hfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771275; x=1692376075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE3ABhVnQhCHOxyYzH8zSMrW/8rvEczqQ6pQab+oN9Q=;
        b=b3QJZvqiKFuY0jWuu884fmLxL8uAHKdfjB9HlaJCfFCcJ0/75C09jwQZ0UPYQfSrcC
         nKvvuKuAnDoq+/YBwulHEXPJSp02smdMtWHJ1Gx8179xg9dqHuB4zcxaVXXhxYyRk5wd
         ZgnQFAW787nC+lsJSPWLifgbHSwJEXIKdDUfpiIVspsDWagOVJ+FFtjL8stzRzJR4aO+
         gwLaXlIoSK1CAbcygZg6OliHC835K1cWFpWInbM5nxMn7hLJzP0FEA4iZJj5pCqnv/z4
         3Bb4nrthf5ZszPdihkbqfour1Sa27vpfFtOUuw4xCktnbd4hdVt1LWIKZiWUU7gLPy1x
         YoZw==
X-Gm-Message-State: AOJu0Yzv5x0CPVqtY+FOREgYCTlnj4YErzdrCOplBa2TcVRYsULnRT9d
        dKfyrjVyqkiqRnagi3FHzN/tdvmjj69xOA==
X-Google-Smtp-Source: AGHT+IHD2VdgEs/0DURZTCiiHr/QFJ9Suko7OPMWGZJHWVq/fjyj7kOmrJJjdnAuvcx7xPL1FQs6HQ==
X-Received: by 2002:a17:906:15a:b0:98d:f4a7:71cf with SMTP id 26-20020a170906015a00b0098df4a771cfmr1904482ejh.62.1691771274733;
        Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 12/24] libselinux: avoid regex serialization truncations
Date:   Fri, 11 Aug 2023 18:27:19 +0200
Message-Id: <20230811162731.50697-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check (for the probably impossible) case the serialized data is longer
than the compiled fcontext format supports.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 16df6790..88d82fed 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -176,7 +176,7 @@ int regex_writef(struct regex_data *regex, FILE *fp, int do_write_precompregex)
 		/* encode the pattern for serialization */
 		rc = pcre2_serialize_encode((const pcre2_code **)&regex->regex,
 					    1, &bytes, &serialized_size, NULL);
-		if (rc != 1) {
+		if (rc != 1 || serialized_size >= UINT32_MAX) {
 			rc = -1;
 			goto out;
 		}
-- 
2.40.1

