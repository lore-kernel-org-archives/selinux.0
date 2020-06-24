Return-Path: <SRS0=RPjD=AF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265CC433DF
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 16:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D116B2077D
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 16:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrsLrd80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404687AbgFXQNV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404235AbgFXQNV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Jun 2020 12:13:21 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7BDC061573;
        Wed, 24 Jun 2020 09:13:20 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m9so1292169qvx.5;
        Wed, 24 Jun 2020 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dWD301dE5xQ6+5qgKu4psPrGwvipRdbm7OlZT1KZ6JU=;
        b=UrsLrd806h3hataecdsJiLj0FA7do7edAuriwQKNiiqQhTzHBJzG5VqMxVVlkJfsC5
         +BOWGxJ9EniePz9BhGMoN+tttSvw7uY+ASSBzT0n5Z1VoTm0YxnEujukndFUewVp0bs/
         VHePBWItUvXcXHuOHJ/5S1CJMsv/vifbIylgNPNYG1m6dtcS4BI0m0PoYzMP1gR0PysD
         GtVhjPzMij73QtagK3/fC4iVOX2YCEfrl+Ohh6qX6doRJoBj2vhRLQPM/2otMKGmRl74
         SJUCWuf9eVh051povoT/xK05AYFzPcw/rlRGj6PXfec7ze5TCbjuJ8JhmBKJy8PiNtoN
         9BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dWD301dE5xQ6+5qgKu4psPrGwvipRdbm7OlZT1KZ6JU=;
        b=uYoWxBnK7IPIn4MwKeOyUnTyPaqrbSyPQd6cafPWFX6U6w5hclK6pwdy486jCUfz3k
         JW6RcZzcjbCtLmphkYWYAAL91Fwu5jThf9HOpECpTGXhUO0x4m2URp4y/gepXmqMAoMW
         dAazgJLJfSDO43WcIVp+13YutVapuMM4M7sVXapK/Gy9IfZ9WzHJgoYDqzRpUh18vDNh
         mej8tSKVOZ7UwkSZJHK0MJKE/A+aniRoEdjzql8RqhqrExkXwqJTnqKQAxpahgF7x8ni
         6nS8/ZUkoyIlmmC7uQ4KF5RaFXaAu9fa8kzprguEaQbAAHy89FdS8YMlu64PoscCWBvD
         boPg==
X-Gm-Message-State: AOAM532dMCSosnMF2BVoE1NnKlQRBZHNDzqhH9fyYV9qtyo1tLPpEy6x
        W4LLvY2bPrIp32tzwzgk74E=
X-Google-Smtp-Source: ABdhPJzLFBmGgK50QIh/uVBW/oVG6bNxmeVs17oC332RehywW4jQJrqiZc//90PdxD1Ay+zDnPhBcQ==
X-Received: by 2002:a0c:b542:: with SMTP id w2mr32498419qvd.181.1593015200102;
        Wed, 24 Jun 2020 09:13:20 -0700 (PDT)
Received: from archlaptop.localdomain ([165.166.214.225])
        by smtp.gmail.com with ESMTPSA id a6sm3562709qko.27.2020.06.24.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:13:19 -0700 (PDT)
Date:   Wed, 24 Jun 2020 12:12:58 -0400
From:   Ethan Edwards <ethancarteredwards@gmail.com>
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] security: selinux: ss: conditional.c fixed a checkpatch
 warning
Message-ID: <20200624161258.nbit7xlca5hkxtub@archlaptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`sizeof buf` changed to `sizeof(buf)`

Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
---
 security/selinux/ss/conditional.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 0cc7cdd58465..90a2f5927e55 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -215,7 +215,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 	if (!booldatum)
 		return -ENOMEM;
 
-	rc = next_entry(buf, fp, sizeof buf);
+	rc = next_entry(buf, fp, sizeof(buf));
 	if (rc)
 		goto err;
 
@@ -416,7 +416,7 @@ int cond_read_list(struct policydb *p, void *fp)
 	u32 i, len;
 	int rc;
 
-	rc = next_entry(buf, fp, sizeof buf);
+	rc = next_entry(buf, fp, sizeof(buf));
 	if (rc)
 		return rc;
 
-- 
2.27.0

