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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D291DC11F66
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D4561C44
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGFR5X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhGFR5W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63345C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bu12so35629472ejb.0
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v23z/5GoWAZhN2MjQlwfVIQFvhkXRPQPRvLEnxTFbcw=;
        b=X2YAZRWvy8Y3s07xY8qOGwmGsEDR4RLXIY1CarMhcS1YSf79/32EtzVhe6GDFv56bI
         MJ3JqNmZWRZuv7K9m5L765QDjA1F+5uqwT/lS0srcuPp710lk/HSTtVuohvdkFT2inJ1
         icrLW6QhsY/V2Rb+orx5ixO5DZS25KeYDjd09BV98kPC6PdMow6S0tIZWOXXG7Ccvw3D
         FozbxvO0LKTnqTDieO27RKRMdkGcUUBCHl42erqroawGwiolm/oBb0W+M04LuCfxvA5T
         XtNynEDcDkxpdc2GDnByryWSfOYt/WOe/t6Rr1SvR/Isk16wKU+2XktVRhM/w00yzLfq
         IJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v23z/5GoWAZhN2MjQlwfVIQFvhkXRPQPRvLEnxTFbcw=;
        b=b2QFNzpW2F0mh7WRr9h0bjmOv1px+hqgao2vn4vRUpHHsUScLxfmx6/58KdGgUNr6s
         8kjI0CDP+RIJiNxtWjty+4f0etryIvRqY6WfyrQ2/D9Z6RJxbpmYmXmFqN3VBJNaDtjY
         PlZ8Fjr8tzaW1ejf/ET+OeuTDE3+zFEj7xxQuUZgFCRErZIY1SKOyyKPaUCHvougS10a
         IzOeTsBX8xrMVfnyWvo3WIn4vBoLCpT4CzL9gyMy9ffzTIrc37g29IbLkNncf5GNAyrf
         x6f+G1MEomhi4KcYOQ2yg0XKafD99Hkkt9aZV3iSuGUNwg2PvWA+Znm4+JX0hWLRo2IY
         7DYg==
X-Gm-Message-State: AOAM5310QWVf+Dcwou/g0AwvDhmDBlykLM4K55rwedorZbf8Vge4hjxH
        BdkUHqiCH70G6IKBALBu1yOurnSW7WY=
X-Google-Smtp-Source: ABdhPJx2lC8x6a/8uhp5sfWBRnOkjpXP/wpTn3MVHmyQdc7x62iHX2u3m6kvLo9En5wXHs1Ev0dV7Q==
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr19929645ejc.431.1625594081909;
        Tue, 06 Jul 2021 10:54:41 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 04/13] checkpolicy: drop dead condition
Date:   Tue,  6 Jul 2021 19:54:24 +0200
Message-Id: <20210706175433.29270-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `id` is guaranteed to be non-NULL due to the preceding
while condition.

    policy_define.c:1171:7: style: Condition '!id' is always false [knownConditionTrueFalse]
      if (!id) {
          ^
    policy_define.c:1170:13: note: Assuming that condition 'id=queue_remove(id_queue)' is not redundant
     while ((id = queue_remove(id_queue))) {
                ^
    policy_define.c:1171:7: note: Condition '!id' is always false
      if (!id) {
          ^

Found by Cppcheck.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 16234f31..7eff747a 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1168,11 +1168,6 @@ int expand_attrib(void)
 
 	ebitmap_init(&attrs);
 	while ((id = queue_remove(id_queue))) {
-		if (!id) {
-			yyerror("No attribute name for expandattribute statement?");
-			goto exit;
-		}
-
 		if (!is_id_in_scope(SYM_TYPES, id)) {
 			yyerror2("attribute %s is not within scope", id);
 			goto exit;
-- 
2.32.0

