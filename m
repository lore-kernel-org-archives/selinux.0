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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E94AC433ED
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E413B61244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhECRy7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhECRyz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA5C06138E
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so7286210edu.10
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=55Z2maoL2CIyHa7EJp6X9pn7o8/HQjP9mgit2hwOMZY=;
        b=sW8lA4TytbjVIb371EA1SgJXQTZ+zepO8j30GEVluei5HWwigOu26dvDY9VWZ05jrW
         blfZXVhNitg4AUi7Zvh42H5OSMHgfSswTZu5HoT3KBEiT+7ui0ZEpBZF9j4lPfUxOsdc
         uFnEt8AbPfJJS+0xdadpg1aFwdA86VppL/2ZhunYOSAzg73bXTGvfkcZ6Kc1rTkW2+4r
         K5KxxVpW15Dqe2ojz6yyTmh16K4NbUDsaWsA0wfo0w59VwUJhW68QuJJmzGMXeFebqQP
         rgyfpyG0pYcOw3XUbHKGdFLA/W7PAb8TSKmc7S/dWwoGOfUvhYNz3yaaa3yzZeHLnzLy
         THDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55Z2maoL2CIyHa7EJp6X9pn7o8/HQjP9mgit2hwOMZY=;
        b=gl1H+66Ye8GU0Pmi9ho4AMv9L6gASwFdTAelHNq5LY2BJxF7HL3Rhq5bBDOfXnjV+A
         4QqnlL47JnQ3MCYHs2moaZwpzTn7rzrpJH/+OerT5mJ1793tgc4+0OZMutjZPqXr7e4q
         VwC3wGMQOPjI6vGlRK6NXnMD8FeGjxn35F8lSTBKMRgQCoCvCdAj+G9B5LWf/6QL9ikE
         vwhOS4rkzvD64vpkPpiz6Wj/o5Oz2n75SHHqbaQ5FCbrk8/BlYSuoYFnvxq0N65t+tAk
         TgKpj4CVBuYIlI49r4yTiZy1c3rHufB9DZpmhNis3/wFoO0ylPh/YAKHto57vyhYliJ+
         kmIg==
X-Gm-Message-State: AOAM530uw1JJ/JFVTv9lKbNyKTIuzS8GwD2s7sobmZPIdFGR3IOTvb3+
        NJ0cacvs/6myoXppUAAggFp8LMOVR338Kw==
X-Google-Smtp-Source: ABdhPJyjcRMFkHVauDyMjUAPEucYVI5YsvZdVVNWZHRo0GLhoYDk/T45KESuE3VaxL8gQ1uFgQEOjw==
X-Received: by 2002:aa7:d955:: with SMTP id l21mr12525330eds.118.1620064438147;
        Mon, 03 May 2021 10:53:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 08/25] libselinux: selabel_get_digests_all_partial_matches: free memory after FTS_D block
Date:   Mon,  3 May 2021 19:53:33 +0200
Message-Id: <20210503175350.55954-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Free all memory from `selabel_get_digests_all_partial_matches()` in case
of success and failure.

Found by clang-analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../utils/selabel_get_digests_all_partial_matches.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
index 0c2edc67..e28833d2 100644
--- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -128,7 +128,7 @@ int main(int argc, char **argv)
 					printf("No SHA1 digest available for: %s\n",
 					       ftsent->fts_path);
 					printf("as file_context entry is \"<<none>>\"\n");
-					break;
+					goto cleanup;
 				}
 
 				printf("The file_context entries for: %s\n",
@@ -149,11 +149,11 @@ int main(int argc, char **argv)
 							xattr_digest[i]);
 					printf("%s\n", sha1_buf);
 				}
-
-				free(xattr_digest);
-				free(calculated_digest);
-				free(sha1_buf);
 			}
+			cleanup:
+			free(xattr_digest);
+			free(calculated_digest);
+			free(sha1_buf);
 			break;
 		}
 		default:
-- 
2.31.1

