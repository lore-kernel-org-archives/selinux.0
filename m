Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C785C433F5
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356158AbiASQfd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356159AbiASQfc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 11:35:32 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AE2C06173E
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:31 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id bc19so2940766qvb.11
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkDDpecYRmfpJOGlple4ThaWQ34EwKZUH50HlmE2SkY=;
        b=YTAbxQK0SGJIrDmIsTSrVodlKjQ+gXWllXIrQGmbPlaRBbLxbGA4B3YOz7IgA63OgO
         ABAnLn1ffI4DbSk6n1oxmboy/aW/UEFZ4asK8VHJrLJkehvWNv8SnTftcWI9/pipoVbG
         gfvA651mPQlXlgfpUwQyjeBKf3h641pw2jJ5FMycQyLOwBLhBPAA1154EQ7xMRSBONDA
         WGyYGh5GH2/iTohYCF3lxZQnGerOhvZljjSFGGSsreI736c4IzBGVgCvDNf/I8ZB7t9e
         kIvnuINTYUGgXENADv+z+jQ2akbRWwWNsKIuw33tRPuLFOWvGq9dQlHuXiLqqwQXrOoJ
         b9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkDDpecYRmfpJOGlple4ThaWQ34EwKZUH50HlmE2SkY=;
        b=OLL+xcsoi26ejPqEeXnWpkQUuCUxZtzxYUq0IkQoVRXQGX54Fcuk8j3bwPhXLGGjYc
         1hHSVusq/KBaMSC5q0YMDAClmT5j0DifhwpY/hY7xJy7yl4WQQnChgtinO6qtvyIQQOQ
         3QxGWQ+Cd0Z0Sn6n/d64Toij81CAVYPe1qJnQoqcrhT0X9Gehn3/wmMA3OJ7Ey8ITt8x
         W7UGarjBb/hJhs/RiTyjEbWsj/huMl8LKw5TUTaEp9H0bkqGmLbX6MlDPA4XvNE/q+Fe
         QpgRVhDeu9otNXMXICDc+1zkmc1Cukj6lQl7EtuX+hS81YBcHvaeHX/soKaSiF2+0XeC
         lE/g==
X-Gm-Message-State: AOAM532vV8PZpme94TU8rxvTXd6C19vlxbgTm7vLSj9GPDr4+Cx8p/Ru
        9mBRVTn9HnsTAzke2lLmGRNxwb6+Ro0=
X-Google-Smtp-Source: ABdhPJwTzHbmD62sTiaDX9R2bP9xwuz3Z2I66tkrjTwP0r0Z9lWXHJcuOvYYFzGrbADDOm0kdZY2JA==
X-Received: by 2002:a05:6214:23c8:: with SMTP id hr8mr28396228qvb.26.1642610130813;
        Wed, 19 Jan 2022 08:35:30 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id b200sm127231qkc.50.2022.01.19.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:35:30 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4 v2] libsepol/cil: Provide more control over reporting bounds failures
Date:   Wed, 19 Jan 2022 11:35:16 -0500
Message-Id: <20220119163518.93780-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220119163518.93780-1-jwcart2@gmail.com>
References: <20220119163518.93780-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 4b2e2a248e48b2902ab1ef3cab86322a3c6ef055 (libsepol/cil: Limit
the amount of reporting for bounds failures) limited the number of
bounds failures that were reported to the first two matching rules
for the first two bad rules.

Instead, report the first two matching rules for the first four bad
rules at the default log level and report all matching rules for all
bad rules for higher verbosity levels.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 4ac8ce8d..b7da8241 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4863,6 +4863,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 			struct cil_avrule target;
 			struct cil_tree_node *n1 = NULL;
 			int count_bad = 0;
+			enum cil_log_level log_level = cil_get_log_level();
 
 			*violation = CIL_TRUE;
 
@@ -4909,16 +4910,16 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 						__cil_print_rule("      ", "allow", r2);
 					}
 					count_matching++;
-					if (count_matching >= 2) {
-						cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
+					if (count_matching >= 2 && num_matching > 2 && log_level == CIL_ERR) {
+						cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown (use \"-v\" to show all)\n", num_matching);
 						break;
 					}
 				}
 				cil_list_destroy(&matching, CIL_FALSE);
 				cil_list_destroy(&target.perms.classperms, CIL_TRUE);
 				count_bad++;
-				if (count_bad >= 2) {
-					cil_log(CIL_ERR, "  Only first 2 of %d bad rules shown\n", numbad);
+				if (count_bad >= 4 && numbad > 4 && log_level == CIL_ERR) {
+					cil_log(CIL_ERR, "  Only first 4 of %d bad rules shown (use \"-v\" to show all)\n", numbad);
 					break;
 				}
 			}
-- 
2.31.1

