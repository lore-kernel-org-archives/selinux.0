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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D26C433ED
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB936121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhECRzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhECRy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29EC061349
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id zg3so9165256ejb.8
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6uSO+VAXsI68QiGIglToPcJmQwH6vpV52Zwf88xDxpY=;
        b=SwGB2wsmGPDyre+2q+1gLPqxIQR0siJFRXle9BKhCc6UnD0uE3AcwTqfm7Eymj3nVR
         c2m+OTjDK6XMnNMjgim9X3K24zQm7JWQT3h+fMMKNmolVi1bw4p7DYt33PgD9WnwCthp
         9xoxfI9Y5h7Al0TXDPS6yhaeJdQdr4Ij91G60pi5pc5Cp0gZLUj0OoWwJU8FG4hCqvU8
         1dmomnwrL3npX1gL54DjQaIQU/CvdlP/kxwAC5wrJnOEFdCSl83XISe3J/OZNm7DFzg1
         TKy4rr1qex/DFLRyJ2mvkpBh1ukOcHE+RcpFEjGOYdCbFnL75j1O6bVoL+5kZNr4H7lJ
         ytJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uSO+VAXsI68QiGIglToPcJmQwH6vpV52Zwf88xDxpY=;
        b=U/IiBCPrVP6hzSljiUh7qhvYQQlk8DutkUUmnAhkuwDtcH4Ca451VIIkDrTX/kV1wh
         y6rMo0ScXrdaN4DBbhoFZP7ng+Gf8VAp89HqDgzUCmzDaHc+wriaQoiburIBNCWYCV7o
         Rzt9XouxB4No08IPtMgQ7cgZdilu9vHiMgO2iXKV2nnQiFCoNaUWpib1eNjC4165vrRG
         djRuUnKKjT0zdngBwxrH8UJX1h3rYtdvRmRj9X6okPA7vbw5I7DkGClDWJ8HF0wk5646
         Qnzc2dANMo4KVB3gV9Bwj5cnTZZjAPWYQxa0yLKWnL6/XPlO4zibXEvmwUTRYuWvAVM9
         9FoA==
X-Gm-Message-State: AOAM533qN5tyZqQ7XZRzvkFL9i1WJmwVzQUT8f9uMr1fKgxK/vzD+PUv
        bqTDiZD1S9EPgh/Jev5IBC7PN7pI1bLJMg==
X-Google-Smtp-Source: ABdhPJyoP3cxYPrSrOTpQ7w8qO49wG7FWwUpi9twaJpPQNAYN4e0P5ppA1zVOBru3e7njk4lwFWjFg==
X-Received: by 2002:a17:907:2176:: with SMTP id rl22mr13551785ejb.155.1620064441141;
        Mon, 03 May 2021 10:54:01 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 18/25] libselinux: init_selinux_config(): free resources on error
Date:   Mon,  3 May 2021 19:53:43 +0200
Message-Id: <20210503175350.55954-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by Infer.

selinux_config.c:181: error: Resource Leak
  resource of type `_IO_FILE` acquired by call to `fopen()` at line 165, column 7 is not released after line 181, column 6.
  179. 				type = strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
  180. 				if (!type)
  181. 					return;
            ^
  182. 				end = type + strlen(type) - 1;
  183. 				while ((end > type) &&

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_config.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 6c523895..97f81a8b 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -177,8 +177,11 @@ static void init_selinux_config(void)
 			if (!strncasecmp(buf_p, SELINUXTYPETAG,
 					 sizeof(SELINUXTYPETAG) - 1)) {
 				type = strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
-				if (!type)
+				if (!type) {
+					free(line_buf);
+					fclose(fp);
 					return;
+				}
 				end = type + strlen(type) - 1;
 				while ((end > type) &&
 				       (isspace(*end) || iscntrl(*end))) {
@@ -187,6 +190,8 @@ static void init_selinux_config(void)
 				}
 				if (setpolicytype(type) != 0) {
 					free(type);
+					free(line_buf);
+					fclose(fp);
 					return;
 				}
 				free(type);
-- 
2.31.1

