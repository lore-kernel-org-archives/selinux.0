Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBFAC43460
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCFC6121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhECRy5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhECRyx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2880C06174A
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h10so7264584edt.13
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FSFNkp3zfDVlCOXZVNpd6NENdAAQgbrDoDyhNlN4s5c=;
        b=Guo0ensQPAsQ+vFqxPAo1zCjsBsjWnEHYNfzpcjID6kU+OeCj95SeMJGmG9CJvjZNs
         4TKuXlFo6K2iMElDiTT8DjFhYsBkRxjV+u3yzQgF7VeZkJ+SJb7L/jj5kcqQOp9ijFGG
         be4rOFhWW9EjQn5cGtUOvMzWMikkmbt82mpMj3iwIU66rqOoMbY3q3EMk4qRiG03fX9g
         q8XG0ePJ4NtmDXGw2OTTDRW/yVTm7Lk6WgLL8AQJaU+IA8UGDqr/pR8wNfYRHh78PkDj
         35ISdYemD6/4tc3GkX6f0OsveIzGbvrpDYIK9Ct3qWSlqIp+0NKziOhu7tR8C9Xz2R58
         +1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSFNkp3zfDVlCOXZVNpd6NENdAAQgbrDoDyhNlN4s5c=;
        b=TY0WFOaVhH66jpOvCtrBZpjtRXQI/LjtZXFhGC5m0YuKeXV9SnMC8dWoLvl2IvIIBb
         PQX9oEsIzIFRmUDfVEPt8oL4gEJ2Xs3AyLUfQENTJxwkzOIOIBNm7jmnf804oOKsxogW
         r6vo5C/Oimf/ki90ueXf1tP+zkeVGQ0pMGOYjn85VYBLlE01UyNjLwormdzQBBQgfu+D
         ImKSpjNRgNc+8Z++Oa4aLPl5sGrCrOf6Kfwq7U31xd70eeit5o8nLmtchB7YLX5TLsFL
         ZJ5g975iRp21cLGqOi1yv8CUsJSsez15sYpfcxkE74TwuFwapKsx+1qASSwQQ41q06qE
         woOg==
X-Gm-Message-State: AOAM531J39npxefk3v48yK0Ws8U6U6G0tgRBCIsHH5ZlWFYURGbtnJY7
        94f5WoQg2VNicizZoueRfrnFuIdFt51Ldw==
X-Google-Smtp-Source: ABdhPJzrWIaPRjx3Xhw9Z1Cgn7uSgykdY9UubdofOVjGbliV6TRSU3ETJrPm9rf+2UxoTRfwOUeghA==
X-Received: by 2002:aa7:d408:: with SMTP id z8mr7101376edq.286.1620064436452;
        Mon, 03 May 2021 10:53:56 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 02/25] libselinux: selinux_file_context_cmp(): do not discard const qualifier
Date:   Mon,  3 May 2021 19:53:27 +0200
Message-Id: <20210503175350.55954-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

matchpathcon.c: In function ‘selinux_file_context_cmp’:
matchpathcon.c:487:18: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
  487 |  rest_a = strchr((char *)a, ':');
      |                  ^
matchpathcon.c:488:18: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
  488 |  rest_b = strchr((char *)b, ':');
      |                  ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/matchpathcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2ec66650..9e1fab59 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -477,15 +477,15 @@ void matchpathcon_checkmatches(char *str __attribute__((unused)))
 int selinux_file_context_cmp(const char * a,
 			     const char * b)
 {
-	char *rest_a, *rest_b;	/* Rest of the context after the user */
+	const char *rest_a, *rest_b;	/* Rest of the context after the user */
 	if (!a && !b)
 		return 0;
 	if (!a)
 		return -1;
 	if (!b)
 		return 1;
-	rest_a = strchr((char *)a, ':');
-	rest_b = strchr((char *)b, ':');
+	rest_a = strchr(a, ':');
+	rest_b = strchr(b, ':');
 	if (!rest_a && !rest_b)
 		return 0;
 	if (!rest_a)
-- 
2.31.1

