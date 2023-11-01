Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A5C4167B
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjKAQhw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjKAQhv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:37:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B656110
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:37:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso11586311a12.2
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856663; x=1699461463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RViy1LVoXrp0digXqSDZ+AesyrDtNXvdPxpQ1tEhXEM=;
        b=AwUyNdROjIIP92U1fAlnPzqqhpoMpKGvQtRZ1kPWOrjqVnJ/jQystRIzY4V8tqFhOC
         vhNRqPrGW6pRFTbVQK57lYrmyWPialzwP6HHbtnxwQkaxhiy+JBLukbKJSDxnIoF+WBs
         gLb5TYYlZQ+tlA3hOVPRaUtDHBQgwf4hF8TSt/CXCprpekIgQ08aSJA9gP3psixJ3jsS
         F5bE2IzEI/+smUu7CI18wWCda0AN+CxgenHEKXiAjSDMeuw9Hu+hNuXcWN2NLym6/qQR
         b0/SHhV91oMOQl//tGzyb2esn0md6urI/pE51cqqHrWUXe10gQ2t78ZlAjKvZo5xgs3O
         9EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856663; x=1699461463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RViy1LVoXrp0digXqSDZ+AesyrDtNXvdPxpQ1tEhXEM=;
        b=E4bXzdbnY1K4Hb4rT0id+CdRtvRyTsOTWJ/r4eSgwlxzpNMtB+sbpCZ15jIsHgzkM8
         XelqCMt4P9/mpyctfF1vjPySD4OPerAQAtylKl/0bZlHbwGy4FNrd2Y5f/0awJAZXG8x
         Lz7PCTRgHi6AR/DFAl/EDwAb66XiZ+W7ERG5zUm9CrwXe+/ey1AeC5xut0d0VObkdYLm
         7CJZI07OHIWPLwvlNNswBhrVXUp1zaAXpJ0oKGVJxZAHVb2nh7eawzWkpovgPEKYC0U+
         pXz82DPC/WFL01mLTfNW8rLPb1H1AHpCQprDkGbtb2BH0r20DUHupDT+QhUmxLK1iBXs
         Ek3g==
X-Gm-Message-State: AOJu0Yx7zdp898Bn/8pQ1jvudNlPof5p5dJehVDjlgKKPT2931j36fWV
        ad7KWJ22C9WUHPFiGyl3/4998K/EVCk=
X-Google-Smtp-Source: AGHT+IEW2xk7rYWFlRXkNRLynO6gA6yyilTv7a6nN89xiQ3UFpjsMn8hb3yyu9Mwy2Z5ak7TTx5MPw==
X-Received: by 2002:a05:6402:2912:b0:53e:81f6:8060 with SMTP id ee18-20020a056402291200b0053e81f68060mr12623954edb.14.1698856662816;
        Wed, 01 Nov 2023 09:37:42 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id 30-20020a50875e000000b0053e07fe8d98sm1275154edv.79.2023.11.01.09.37.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:37:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/2] libsepol: avtab: check read counts for saturation
Date:   Wed,  1 Nov 2023 17:37:25 +0100
Message-ID: <20231101163725.177237-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101163725.177237-1-cgzones@googlemail.com>
References: <20231101163725.177237-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure counts are not set to the maximum value of their type.
Also limit their size during fuzzing to prevent OOM reports.

Reported-by: oss-fuzz (issue 60572), caused at the time by the filetrans
             prefix proposal
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   rebase after revert of filename prefix proposal
---
 libsepol/src/avtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 1ef5ee00..7c2328b7 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -600,7 +600,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, uint32_t vers)
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
-	if (!nel) {
+	if (zero_or_saturated(nel)) {
 		ERR(fp->handle, "table is empty");
 		goto bad;
 	}
-- 
2.42.0

