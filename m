Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7369BC433F5
	for <selinux@archiver.kernel.org>; Wed, 16 Mar 2022 20:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiCPUzP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiCPUzO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Mar 2022 16:55:14 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB213D12
        for <selinux@vger.kernel.org>; Wed, 16 Mar 2022 13:53:59 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b189so2886109qkf.11
        for <selinux@vger.kernel.org>; Wed, 16 Mar 2022 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZ/pfUWEvbe1nqABg42UBD8IgI55qkv84XktlEF0z4E=;
        b=JtMCk7SIPpxbH9U2ooiqNf7sgLbjZhkroDiKYIgxREBLoX5LEtdnOCHETkJMbGb7E8
         HKHkcU70I0Z9QSprf6V9GbzgkXakzOyA29IWC828yvJa9huSyJM/j+vgFRNLH0IAp124
         r3/FOPMJnMgBt3Ku8YUYtq4kn+oeTEcgDvHBcdYxuFSnyONWDXqDx1GuUT97l2mcjbGS
         xCD6kpSFYd7nc+5XKFOG2/tY9B04jp8Z7kAWSo00WOYfMfYaE/OSxixbhuqhAvuGJX4r
         iZoe8oZQsNqzq4xULygANXNbVBUDa56wGybvmIiipFtZcCLJ4VPGnnEweuK+HSPBn1t8
         guoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZ/pfUWEvbe1nqABg42UBD8IgI55qkv84XktlEF0z4E=;
        b=R58x8kH9dBSEgoQPQYiz4cS6v28arOb7PING3jVyzftlFB8S6GHh4Tl+bX+yUqhbik
         bxDlPZMB+kE0Ow2nj1k2HWZQQdQYXp9X1ljEpinKaCkUbaPw3aveFJpzqIPMmWTzLO98
         aq0EsOBNWDaIuk0yQEBsDx6SiYRHEk+VChhjf0luuX97Sy0fvcKAo/Yk7jXqINUnsEXK
         CExNFp3jvI6yvlhUtdPs13vkZfP/o3n7ufR7y2jE3e6129HFRF7VK/XqKvzhN4g8NnbH
         yLBhrrQyWQUVlvkwyFNxSOfOaTJebRHxRy7fgZlyLi1yHN8MhV6t/T+tKNtBuPzdx5GL
         24YQ==
X-Gm-Message-State: AOAM533kz2/QQF9DSXP/BRf78+UMk0oNwd3tUWcDeUw2yBF7pYOYgZVK
        0jhlds1cmLiDhD4dJVhXB4rHt7O840Q=
X-Google-Smtp-Source: ABdhPJzcPpiPBSC8aN5ZhPLy6TUwkA7lGp6S4kuB2p0wSk2418CFO+e9EKiuOl5EBNGGVWPql6rLhg==
X-Received: by 2002:a37:9a83:0:b0:67b:31be:2ac2 with SMTP id c125-20020a379a83000000b0067b31be2ac2mr1072638qke.416.1647464038171;
        Wed, 16 Mar 2022 13:53:58 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm2012829qtw.26.2022.03.16.13.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:53:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Validate conditional expressions
Date:   Wed, 16 Mar 2022 16:53:46 -0400
Message-Id: <20220316205346.260080-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When validating a policydb, validate the conditional expressions
including the values of the booleans within them.

Found by oss-fuzz (#45523)

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index a2dcebe4..13d9480d 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -881,9 +881,52 @@ bad:
 	return -1;
 }
 
+static int validate_cond_expr(sepol_handle_t *handle, struct cond_expr *expr, validate_t *bool)
+{
+	int depth = -1;
+
+	for (; expr; expr = expr->next) {
+		switch(expr->expr_type) {
+		case COND_BOOL:
+			if (validate_value(expr->bool, bool))
+				goto bad;
+			if (depth == (COND_EXPR_MAXDEPTH - 1))
+				goto bad;
+			depth++;
+			break;
+		case COND_NOT:
+			if (depth < 0)
+				goto bad;
+			break;
+		case COND_OR:
+		case COND_AND:
+		case COND_XOR:
+		case COND_EQ:
+		case COND_NEQ:
+			if (depth < 1)
+				goto bad;
+			depth--;
+			break;
+		default:
+			goto bad;
+		}
+	}
+
+	if (depth != 0)
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid cond expression");
+	return -1;
+}
+
 static int validate_cond_list(sepol_handle_t *handle, cond_list_t *cond, validate_t flavors[])
 {
 	for (; cond; cond = cond->next) {
+		if (validate_cond_expr(handle, cond->expr, &flavors[SYM_BOOLS]))
+			goto bad;
 		if (validate_cond_av_list(handle, cond->true_list, flavors))
 			goto bad;
 		if (validate_cond_av_list(handle, cond->false_list, flavors))
-- 
2.34.1

