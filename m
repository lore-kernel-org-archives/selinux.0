Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F1C05051
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjHKQ2B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjHKQ2A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:28:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF47218F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99cce6f7de2so306105866b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771278; x=1692376078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEHJ9A5IiHK7rkzOyAH9B21P48m0kTXcW6LRMfoByDU=;
        b=qn6bpQCc46yOvWhWc7AuM9/MDP96mXQo+0/D9y4oRhaP6Im+LKtbfUkn/50wLqBK5X
         xwcXCOa8o6vfSLR702Smhe9MHGB1uAhE9XI2qm7sOcL3HrnYPhuhSXGsUbRjdrlUuSO0
         1inMZp5k9AYC6mQQlat8l3mOcF1puf1XSLuH6dbN89JwKY0k2ciN3jh7314JW1EdIZL7
         wSyoPT36werVPds/RJmInNcYVNIXCoBIl5ErTmdmnsCr4sonLbYa0GR0XH9DpPQATCzC
         q2Yc/qj9bcnk3bp/nQoWZmNxZaURK2l3DSfhhHVfLjCdZyl9f6sJrkT9fNKpfoKi9bjy
         ePOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771278; x=1692376078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEHJ9A5IiHK7rkzOyAH9B21P48m0kTXcW6LRMfoByDU=;
        b=ZO+AjGBuZbTU1GIqcmU/rYn91s67XNHvLpo3wxIn85TJ6Ajsmv+xhKlJnfJ0idvL+7
         MJe99nNkFxhDQqbmkx2bxDnrOJclRc4v+rw4RODkF+iyGqo0zU2bUkkymYOW58e5OKt1
         NCv9PYeu4boWyTFWr+WJI+tbhqo8SiVOL4bI86tSLTeowoX+dXvXXPLMHBIU/xvezQqf
         GVwCxghUpK6D6lRjixC1qEi1rfywHZWO6HRkg1KnmGDRO7jyrWfip1NpfpO1PR9w20B1
         Ioxe3hVT5cKzsJ7WpmisMZfINg1ouQNAHjaCXygHrfCQV+MIHOdU/TKwFnxfL+PE8hnF
         1zrQ==
X-Gm-Message-State: AOJu0YxRLgUL2ycQ2ch4hxmx4L2Pz5G7vHPg/yStiHDq4w2BDQWpp5Sj
        i/Eu4CGrXVRcWYFakxMwz2hPlqfqIMl/NQ==
X-Google-Smtp-Source: AGHT+IFaq38dP/ucpG5++AaLhiprjOuJPaKLX0Mlb4h9+slpaw850gOxUY3nLjpkdHTt2VTils3bFw==
X-Received: by 2002:a17:907:a054:b0:982:25d1:bfd3 with SMTP id gz20-20020a170907a05400b0098225d1bfd3mr2095216ejc.15.1691771278150;
        Fri, 11 Aug 2023 09:27:58 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 19/24] libselinux: avoid unused function
Date:   Fri, 11 Aug 2023 18:27:26 +0200
Message-Id: <20230811162731.50697-20-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Define selabel_subs_init() only if its call-sites are enabled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index f9f4648a..471fd56b 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -674,6 +674,7 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 	return NULL;
 }
 
+#if !defined(BUILD_HOST) && !defined(ANDROID)
 static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		       struct selabel_sub **out_subs)
 {
@@ -756,6 +757,7 @@ err:
 	}
 	goto out;
 }
+#endif
 
 static char *selabel_sub_key(struct saved_data *data, const char *key)
 {
-- 
2.40.1

