Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744CC0018C
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjKINxZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjKINxZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:53:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37D2D5B
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:53:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c773ac9b15so141257666b.2
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699538001; x=1700142801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOrC+TCRJqtUUzRkJjSAHbz8Wj/EWYo6hIJbszfLzFE=;
        b=MtswKDIVZaTM2C++vQ/Ji+xfY+Jj1p6nIHumQhcyp8schzTogNnMM9wQHeZQVFhmjC
         XIbKm0kFenRigjcJ0R4mYEi//8O0GFQsMLttXlINKN553ABB78ZePUMdUl528pLf5316
         MT0nQHBVfJiYLosI3OCEZ2vxrmwsBaDN2zeW+g0xbt7WPAPJgulNALXvpKnEipMXN2UN
         XxmM1TzPu86SIehsiRgIZzyb5K8IBtFqI8faWCKGdNA4ZA+emUTEAcE3UFByiI3al047
         LXMWilotv47fdEQFzhE6qEN6fJZbOnH0vX1+N/UaKha8LRjqZSe2u7mphpWF+QXFGSIA
         avtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538001; x=1700142801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOrC+TCRJqtUUzRkJjSAHbz8Wj/EWYo6hIJbszfLzFE=;
        b=YGy0bayKvkDb321vu0Ok+xmKhojYdsQvYzAh6OvMOZRLI3cIywH3SJwqaNr9Qe4jZL
         S7w/vEXg/ATLd4kM6XMysoflzqygpACKy5pUnTGniemO+CWs2TF7IjyMnopNzDLM83aN
         XJt/7CzZ3ZjefoSrmRppjwkkvf4hxj8PvaXc451CGHeSF2Gr+cwcClVUWe3xqxWVnion
         oxuxrSep3RRAwwKXKMFgzcPB+SUCJjAwKrXCKRLgbhjoBbEjVXfvX1w63iPiP3IaxxbA
         OFSzwS7uHMUpg80yDRL7W0bTRBSA9OKBQpilMK0qdQnwDkGbBijobAw8TKqJVkTMNvuN
         vmJQ==
X-Gm-Message-State: AOJu0Yyg6P2djwSdYWxlHNvLpRgRQ14vf8NK+MXBlklNPFmc8kbd1FmZ
        TMbcVXSOIwfNy6prEI+GxwFAGv5cHbA=
X-Google-Smtp-Source: AGHT+IFFTyNMZlLtnu64ovySUZZGh67RhtnEy9S0AKCm5Ob71TgSPpmvB2IRST8+d+W5e2rEdACwXQ==
X-Received: by 2002:a17:907:d89:b0:9bf:2673:7371 with SMTP id go9-20020a1709070d8900b009bf26737371mr4859038ejc.13.1699538001329;
        Thu, 09 Nov 2023 05:53:21 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709060e4800b009de61c89f6fsm2549900eji.1.2023.11.09.05.53.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:53:21 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] libsepol: avoid leak in OOM branch
Date:   Thu,  9 Nov 2023 14:53:14 +0100
Message-ID: <20231109135315.44095-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135315.44095-1-cgzones@googlemail.com>
References: <20231109135315.44095-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case the member sid_key failed to allocate, free the parent struct.

Reported by Clang Analyzer:

    module_to_cil.c:2607:9: warning: Potential leak of memory pointed to by 'item' [unix.Malloc]
     2607 |         return rc;
          |                ^~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 2d77e22a..ee22dbbd 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2582,6 +2582,7 @@ static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_
 		item->sid_key = strdup(sid);
 		if (!item->sid_key) {
 			ERR(NULL, "Out of memory");
+			free(item);
 			rc = -1;
 			goto exit;
 		}
-- 
2.42.0

