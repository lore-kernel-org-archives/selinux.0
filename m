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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F69C4361A
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE68961244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhECRzF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhECRy7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13097C06138C
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gx5so9154377ejb.11
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vio2xh7NH/IqS63KvGAdagJdOQONzhZvJd0dIjpP+hw=;
        b=fCN3WE9/hLzXS3bQp3S0jh6N68vTZ+VvBXDCt/+Ub6SkxwsGh6XMrVnz3aclIOQULe
         Vm1/claM7wpc6nG4P2f4ttNnFG++fqZ6/jyN6urbR73aYwxXwm/cYt5mjCXKai6TYdgo
         0x2twvEqotBy3GwfileIt4Zp1VJ2P2p2brAfmNNSas6/KlhiF19DEfk7urg6R2VSynh2
         XKbytFcUSbu4ZUw9CShnPYtCHmayErJFTJptwOAs0bJNBdsmIsXEOwW142Q7zhszS16P
         tcurHzDs4wREB+AsWqxzIRvUZ3+joYYczuEn7vYIxytUxqbge3zN6nF/Zaq4UXnkHi6t
         hJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vio2xh7NH/IqS63KvGAdagJdOQONzhZvJd0dIjpP+hw=;
        b=un855IAV7ysBfjJ3iZhDoO/RRZG9XMahNT24+2KWDc5CFLT1oDytDaKXvjjCjz9zPU
         0IRmOzQQfkmj4fAx8X/G0PoGeNC5X2aDDLzINa6qclMyDbji+TVoMn4MSDwG00671vYJ
         GHH4gKcNep3ZN5gL2unWbc9Rk8ZOThITDqls399jYsaK6VtdKmyx3XbQIJo/a0LUrkVC
         amnebCEddU1oTUpsLBQdbWduOG0cFYo+RjXxCsYgyVV7Pb6tyznWAoRN9fKCn4x/QT/e
         tsicFnHg6sKdg3camgBQGCYYEJq0NgVfKh0knaNeIOHEzLOmpBXvmFHcsjUmlwO0s9hN
         w0eQ==
X-Gm-Message-State: AOAM530N7qZoTGqoayV7+OJ8zrf8rtqjPqhjZij2Ux5EfpaZhyuQVPzQ
        YYmaNRJmfWuUiwUc9nTGS1+13IF+vWPIPw==
X-Google-Smtp-Source: ABdhPJx6aLcrym+AcoSNYSM7lRTZg2k0u7vWA2tURQ/5WPLvDmvWPjQlhXV+bJHrmWTkDDtjD4k5Jg==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr16984584ejf.31.1620064442865;
        Mon, 03 May 2021 10:54:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 24/25] libselinux: regex: unify parameter names
Date:   Mon,  3 May 2021 19:53:49 +0200
Message-Id: <20210503175350.55954-25-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the same parameter names as in the header `regex.h`.

Found by clang-tidy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 770bc3ea..73987d9f 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -319,7 +319,7 @@ char const *regex_version(void)
 }
 
 int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
-		    int unused __attribute__((unused)), bool *regex_compiled)
+		    int do_load_precompregex __attribute__((unused)), bool *regex_compiled)
 {
 	int rc;
 	uint32_t entry_len;
@@ -387,7 +387,7 @@ static inline pcre_extra *get_pcre_extra(struct regex_data *regex)
 }
 
 int regex_writef(struct regex_data *regex, FILE *fp,
-		 int unused __attribute__((unused)))
+		 int do_write_precompregex __attribute__((unused)))
 {
 	int rc;
 	size_t len;
-- 
2.31.1

