Return-Path: <SRS0=ftUv=CV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6140BC433E2
	for <selinux@archiver.kernel.org>; Sat, 12 Sep 2020 19:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC5121531
	for <selinux@archiver.kernel.org>; Sat, 12 Sep 2020 19:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jTaLc/fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgILTxk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Sep 2020 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgILTxi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Sep 2020 15:53:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C53C061573
        for <selinux@vger.kernel.org>; Sat, 12 Sep 2020 12:53:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so7259455wme.0
        for <selinux@vger.kernel.org>; Sat, 12 Sep 2020 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:references:cc:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P0FTY4GVboxbZBd9dWc+/DFBk4du8MXI5pO9WaXCY9g=;
        b=jTaLc/fiT/rgMe7Hy68gfPL07Bc18xS+EyPNwr7MaTfamgfSa1ILuQFCoArnR6P81k
         qtFlHCxIi37glHYKRb1U5Azb2NN2K7++M/l5bdGQVYqSJCISuDXKnV3Cp4aHIqDt9QGw
         gVSkNzkroRP0ULNK3QPAwsvjrHJdsWl/OpLJva4N39RgqrZtoZYuMsn79helVu8H/kmO
         NwdkfFCQyXZgEU/BY6dYBKRAoCyc1P7SvcfJyTOJA+wNbktUrLdg06ppkIr9riWApobW
         yAKKfCZO3MooU1AbrGphN6SFrWMAkDo7lZ6qNpce3H6EmRZzLhegn8BshQ62vs3NF8op
         98JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P0FTY4GVboxbZBd9dWc+/DFBk4du8MXI5pO9WaXCY9g=;
        b=pYgTPbvHW9+Es6NK9jxe7NdIoQB9qtMq7O2nin/fN/g2Ds3CPhT1zlmOudKaye8g7x
         mjvp9fF4smTmX7OUh6BEbBucPRR6FAupXamP5eymtipsRkKA0fa3d06lZN74r9WKajTO
         6MN+wd4yRYhPz93tiCo9saV3fcsGUY5FjajQcUjcqj4HO3xgxzREe9SyfNxciXvR+3IP
         XZUyRR0BHik1coCzKgOOrW1G2TAv9YFpc+5puqad1uuUTUoSu9iosTkJXtZJ7KJPFDRD
         UYx/N8v+9WrHIa2Vyx+tIo1FxcJN9TjEbN6KR7gwwgCpeITpv8fdWUKDxG+g6OECd2DN
         XKoA==
X-Gm-Message-State: AOAM533fWRbyA0uc5KjdH4ayM4sZKY3T5E/oQFFqC40p0viWar8eaHDF
        XzDHjLuIFsv8F7NI0LS1Tgw=
X-Google-Smtp-Source: ABdhPJwDDbffWR0v6wL6Hw9DbRvPBJSoTSt3r+kWQWGnNnh1/+Zoh2U3sGt3xwgtuPESLivMVNoT3Q==
X-Received: by 2002:a1c:23c9:: with SMTP id j192mr3716291wmj.6.1599940416782;
        Sat, 12 Sep 2020 12:53:36 -0700 (PDT)
Received: from [192.168.178.63] ([178.27.193.97])
        by smtp.gmail.com with ESMTPSA id l8sm11888644wrx.22.2020.09.12.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 12:53:36 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [RFC PATCH] selinux: allow dontauditx rules to take effect without
 allowx
To:     selinux@vger.kernel.org
References: <6a791504-7728-3026-17ee-c22cbff8c3d1@gmail.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Message-ID: <d4e55b23-41da-902d-8b6d-83c9c47e7618@gmail.com>
Date:   Sat, 12 Sep 2020 21:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6a791504-7728-3026-17ee-c22cbff8c3d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This allows for dontauditing very specific ioctls e.g. TCGETS without
dontauditing every ioctl or granting additional permissions.

Now either an allowx, dontauditx or auditallowx rules enables checking
for extended permissions.

Dontaudit rules take precedence over dontauditx rules and auditallowx
rules take precedence over auditallow rules.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---
 security/selinux/avc.c         | 12 ++++++++----
 security/selinux/ss/services.c |  4 +---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 3c05827608b6..ad5b2e3b5abb 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -402,10 +402,14 @@ static inline u32 avc_xperms_audit_required(u32 requested,
 	} else if (result) {
 		audited = denied = requested;
 	} else {
-		audited = requested & avd->auditallow;
-		if (audited && xpd) {
-			if (!avc_xperms_has_perm(xpd, perm, XPERMS_AUDITALLOW))
-				audited &= ~requested;
+		if (xpd) {
+			if (avc_xperms_has_perm(xpd, perm, XPERMS_AUDITALLOW)) {
+				audited = requested;
+			} else {
+				audited = 0;
+			}
+		} else {
+			audited = requested & avd->auditallow;
 		}
 	}

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

