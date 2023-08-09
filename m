Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59036C001DE
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHIUk5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIUkz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:40:55 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC91B4
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:40:55 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4039f7e1d3aso1059851cf.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691613654; x=1692218454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4hQGlSL+5HQZNgT92hnxF+TaaWzMkH6s/j07BXVAM4=;
        b=iMVz59TOXmfdmH0h9hEPg5Qe92DfITb14szjMzmRnyu6t4kxMQyn787GYwjIUErNVO
         r9XhEbwWU7K0pieesUX06p0nhFmzgwlI4AXAlZUZ/yRQTBpp/0vaGxWZCobRtNmeu7yt
         48gXHBoS5Acjt4+JcTOov6Ae23jXCLfeUHvvM9stG0A5d7FeRqj8EqjzPDAiH9SwuD/E
         TY/UKrMXxvl9cKjfvkQcVI3kSXJo25aC+y1TzXffgpPSDtWoMe/omZt3k28zQIn8jxfy
         +NYVxJffASgGc6634MwpvG4Y2O3iGWJLeWKT4tE5DooJQzIs3uKfhCQg1U02qS0iNfh0
         +aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613654; x=1692218454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4hQGlSL+5HQZNgT92hnxF+TaaWzMkH6s/j07BXVAM4=;
        b=FBmFcCAGBGqqNBUlWHX+5y0Ul07wQGoA78CnYLDjlHwvqTcGwgkxhLW1eYO8SnJ05X
         QF9aKthwyJZf+Q7sHysy7SMVP7+RWilWOtUh2THXt2NDJHXV9Kljvzv9+aYgTmPK5oNy
         Ssx89TXkAzMnfps6f7i52G9RBUkZFwq2yXuOue89XexC4x4eYzOsKRSYlZeiJVRhETU2
         E6aHRPlGkIE38in1NOsr+h3+sPsPsU9GUW9UvxFC48UFhHmX49SxHLvUg51a6Kj6zNby
         vNkDld9zYG1GCJAX2OGvHbx9cVzEsVXKGTAVJsiBWmkG+zJ8YuAvNAExkmVUIFypEhdy
         iB+g==
X-Gm-Message-State: AOJu0YwjuZhWM1kmD4NDdMLELOwsI9j7Xy7RL9WnGB23jY/o5RI4MIYM
        vTpxX95tXFyN77bTqkptcHfq4sBP/hA=
X-Google-Smtp-Source: AGHT+IH8uU24WJHM3injHy3XVLmUqHr7wldw+x2hsEzKM42xUg0hfV9zoEvNnauAJ0hEwPYK64XtWA==
X-Received: by 2002:ac8:5d91:0:b0:403:c8c4:fd42 with SMTP id d17-20020ac85d91000000b00403c8c4fd42mr463508qtx.20.1691613654009;
        Wed, 09 Aug 2023 13:40:54 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b0041020e8e261sm711295qtx.1.2023.08.09.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:40:53 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, cgzones@googlemail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/7 v2] libsepol: Use ERR() instead of log_err()
Date:   Wed,  9 Aug 2023 16:40:44 -0400
Message-ID: <20230809204046.110783-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809204046.110783-1-jwcart2@gmail.com>
References: <20230809204046.110783-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since log_err() has been removed, use ERR() instead of log_err() in
module_to_cil.c.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 3e168285..d2868019 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1191,10 +1191,10 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 		if (avrule->flags & RULE_NOTSELF) {
 			if (!ebitmap_is_empty(&avrule->ttypes.types) || !ebitmap_is_empty(&avrule->ttypes.negset)) {
 				if (avrule->source_filename) {
-					log_err("%s:%lu: Non-trivial neverallow rules with targets containing not or minus self not yet supported",
+					ERR(NULL, "%s:%lu: Non-trivial neverallow rules with targets containing not or minus self not yet supported",
 						avrule->source_filename, avrule->source_line);
 				} else {
-					log_err("Non-trivial neverallow rules with targets containing not or minus self not yet supported");
+					ERR(NULL, "Non-trivial neverallow rules with targets containing not or minus self not yet supported");
 				}
 				rc = -1;
 				goto exit;
-- 
2.41.0

