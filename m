Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C5C4360C
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A5A6121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhECRzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhECRy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9DC061761
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u3so9148769eja.12
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mdTJWbH5fYeX8RUN2psmigQmLOEaN7onfXdrssOTbl8=;
        b=DefnVkgvUFb6yNYkv3qPK5KG7descNdJTUWrchyR2SSDl0CxLkCv1c50+MRT9z1DC1
         HY8uyXNPxUfxduIBqc7vH6cOrkBGVmmFSgio2WRZKuesJ/u3AvYe3Q/Z4gPoRBR6yhiK
         Ls6wnHo9MlFXbDFhHfAm2g838j3I+dUQQoLpdjbwqPwq7BvUrjhgFqLJkFDn1YnJm9CU
         GfWrB8jHkoaTsNTqVTVUSY6jZCmUGD7wdfrC8chNJbywpcgUY3QWZ74T0+4XlEMBVzWR
         uJmXRq59vsa3rOuHek+6I9cKLpQFJ0pkoTZIJBmiZyPcA31kK+jzoopu3mOCgnORzxIE
         twqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdTJWbH5fYeX8RUN2psmigQmLOEaN7onfXdrssOTbl8=;
        b=QYWdhBoMBn+QVV0RleGOZFkexBVFrP0FtNNm+hb+03UF5M5ecm1alZCyqWWTDDR2EH
         AeIG3ncSNW3Xci1tHPbgbqvjEY7yMMj9mUEUVAKoRf/XOrOTxKIQaeStj7HeaXav1Mja
         m2g1o1lUJF0Likh5zjXXf25tWdSslyU4kxdieOfFRWPtAzrdnFRp7Is09EqOJUfPLqkv
         BUcAkt8BrY/PklHh43iDreywNObERKDqwYzdaW4IYcXIEKNPL1fuKLXm940hNAmOLBNn
         p4U7ZEa/OtP1xGkKrcpYVcLjBJSs4huiRsBl/i6/YJJdkCmueHuId9RtcIL2biTufB9c
         +lsg==
X-Gm-Message-State: AOAM533aGk3HkBPyDgTV0griG6/crYyEzxHKZq0vbmVfUAccPA7Vfq45
        sBnjNIPuH/HfNdC3Uhc5kWRQjcnElryBIw==
X-Google-Smtp-Source: ABdhPJzk7Up7qYkBJoW7hvAIhu8IvdTKdVvDcgiMbyOteQYINKK/hvYR97IYKtIcfFopcTKEwmg+9w==
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr14987660ejc.231.1620064441415;
        Mon, 03 May 2021 10:54:01 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 19/25] libselinux: label_file::init(): do not pass NULL to strdup
Date:   Mon,  3 May 2021 19:53:44 +0200
Message-Id: <20210503175350.55954-20-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If any of the build flags `BUILD_HOST` or `ANDROID` is set and the
caller did not pass an option of type `SELABEL_OPT_PATH`, the variable
`path` might be not set.
Add a check to avoid calling `strdup()` with a NULL pointer.

Found by cppcheck.

src/label_file.c:759:26: warning: Possible null pointer dereference: path [nullPointer]
 rec->spec_file = strdup(path);
                         ^
src/label_file.c:713:21: note: Assignment 'path=NULL', assigned value is 0
 const char *path = NULL;
                    ^
src/label_file.c:759:26: note: Null pointer dereference
 rec->spec_file = strdup(path);
                         ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 4d4e3a76..39a56133 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -756,6 +756,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	}
 
 #endif
+
+	if (!path)
+		goto finish;
+
 	rec->spec_file = strdup(path);
 
 	/*
-- 
2.31.1

