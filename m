Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38518C433DF
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D8222284
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hbxg29Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbgJIMrP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgJIMrP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 08:47:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5052C0613D2
        for <selinux@vger.kernel.org>; Fri,  9 Oct 2020 05:47:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so9205694edi.7
        for <selinux@vger.kernel.org>; Fri, 09 Oct 2020 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iFY8AvDHTYUhp9SKfGVsKtBgAP8P/Rn38ke3kvwZe/I=;
        b=hbxg29UfCtyb+w8d6AhIJdMEYb93Q5QJO93HO1/ITLc/xuNXSEDdvGBu2s3CGDww9g
         qqkIIGQgoeNPsq5IVYGp4lO0ucDKvk5/gActX5G5P+HzvNlcF174wyEIJ/CTYacVG21r
         dMTZrtyy+u91X3HqPOyUmWtF4nXT0bMbgcbQtHxEvony/4CWi4KZlPjJ26+4YWYcxOoD
         iiGc2t9YLHNjaAz6xg4u+1tJMvQC98Vbj9mLPTG9gsshm/bY9kxSdBM9Craa5BISFRV+
         ztBB9OCSnPeVR5eRZ6FKUeEnCjeer1p8Fpj51AHGsQbOzpqzhW2x+R3lVz+F1fjLLEC4
         3X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFY8AvDHTYUhp9SKfGVsKtBgAP8P/Rn38ke3kvwZe/I=;
        b=FmhzoiZlEO0eW7fm8cYOkGMytr0LJQYzmsU+l94t6W3w/BCcsy6r7VCcTSff4xrKDc
         l+3KDkWHCYtyNrlFZbyS7QO9OKdwG0Uow430pJOIsiXn2JofPChqP3dcpi9dZhyl/QgT
         kfccbu4RFv5RVHVdiW6gEUjlLMwQNRy4boART6qzpr6WThTNzfN2chZPwcvHizhMNsGu
         taeWvzTGEHWPpdRMaZG+FYqoj8Il76xnKIIwf90lO0yQZ2VhaPMrfi2ROsZFh2ZdfG8J
         UptVfEABtaT4EAyVVgWhZ0frniX6XGrY1e0LVKD02b1HAkpVLg2GL5QirpsCX46VAfAM
         fDDg==
X-Gm-Message-State: AOAM5319edNMUN6Z8NfyxA6h4Sou54UgBhPMKiMhcZsDCLtPZmiYE3G2
        FQgp4dJx0yroW404e2rxEKg=
X-Google-Smtp-Source: ABdhPJzuZVOJybO5xmtUqbZ9CgvabBaFXc3+V2kcz62s04QmlyNu+WKlWpUpKV6H2eGXmNaGbteKFw==
X-Received: by 2002:a05:6402:d6:: with SMTP id i22mr14252265edu.53.1602247633604;
        Fri, 09 Oct 2020 05:47:13 -0700 (PDT)
Received: from ?IPv6:2a02:810d:4bc0:8098:f29f:ba0e:35fd:4559? ([2a02:810d:4bc0:8098:f29f:ba0e:35fd:4559])
        by smtp.gmail.com with ESMTPSA id ds8sm5883910ejc.86.2020.10.09.05.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 05:47:12 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v2] selinux: allow dontauditx and auditallowx rules to take
 effect without allowx
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@googlemail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>
References: <CAHC9VhQ9h4rQK8W03jCmtqgr81jRueh_jzd8XjAkjzcCvGmCmw@mail.gmail.com>
Message-ID: <a30c2b0c-d403-f296-5f15-aa7ec3a99db4@gmail.com>
Date:   Fri, 9 Oct 2020 14:47:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ9h4rQK8W03jCmtqgr81jRueh_jzd8XjAkjzcCvGmCmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This allows for dontauditing very specific ioctls e.g. TCGETS without
dontauditing every ioctl or granting additional permissions.

Now either an allowx, dontauditx or auditallowx rules enables checking
for extended permissions.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---

v2: dropped the precedence change, I will make my case for that seperately.

 security/selinux/ss/services.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9704c8a32303..597b79703584 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -596,9 +596,7 @@ void services_compute_xperms_drivers(
 					node->datum.u.xperms->driver);
 	}

-	/* If no ioctl commands are allowed, ignore auditallow and auditdeny */
-	if (node->key.specified & AVTAB_XPERMS_ALLOWED)
-		xperms->len = 1;
+	xperms->len = 1;
 }

 /*
--
2.28.0

