Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F77C77B7A
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 13:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjFBNGW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjFBNGT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 09:06:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B29E46
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 06:06:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so2959493a12.2
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685711174; x=1688303174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMJFJnvpWMiKXLzJR1ieblGVX60uRabrDkpAh+QkFwY=;
        b=BOfqk7n83nQX3ZhQYxbYRq7f6N4Bnm2wslQVHXLjeqwSjIooYWGrf6D0460XFa9790
         zqF6CKOaTtQP8JtIY3rFOo/ARc3rXF3yXn4DNnmz4pXngp9YFbYV/OFr8TlKfQD5g245
         K4H6SkRxx9b54HamM4keBlowM/3T3bzlgnPjBPkplNNygGsHWvlNZtVfUWH+KlqQU+5r
         uG1VVk0dm+UOmQbLt+d4ekBisPkUaD64i78uLUH2YEFI0B/B8Y3+67YWZSBoa3uFyYgF
         0Cw+vgg2Yg1noK/7fNPoShsTMLHlwTbbPUsKNr5fuXgRE7M5QptW8zub9Ds6CuN6APp7
         BqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711174; x=1688303174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMJFJnvpWMiKXLzJR1ieblGVX60uRabrDkpAh+QkFwY=;
        b=Gub9WxPB27P5xQSwXr+OQ2rPEge3qID0Z6CssNOdATd0Mn22Xd4ZZ2IXErFE4rqc3z
         kAHOUQXz3dL63YTFpO51LNgwxFfcQ5sihqNK8HreRWJ8sOeY8nRP/rSsQov988TzyaSB
         uYZq2gu041bk6jiTZBeJGCMTDMjVbhAqyTue2ChwPe+sdwcZya4OqB/3nQKBGW/SEVPj
         M+mK1g+OZEYihejTY2UsAEepgQEJ9mBzWlUe4RarzEn15cs/OlmYrhvS6210MoqMPUL2
         Qsux5PWlbh6nezG0TwCK12w/KsvsrlNBj7BEhBIhkbJIMcRx+cS/HEglGfWSLsRMWs6n
         kWTQ==
X-Gm-Message-State: AC+VfDwF1YBYOE3x2MbOqngnq16syhwvyRqku9Jp+vL5eZq++JYusq5o
        ZXyVH/UObZgvquHkisolrQHbJeGZzhqeLA==
X-Google-Smtp-Source: ACHHUZ7wS4d3zzUklA1kp3Cgmw4GUEmTNrFamagh7ppc5XxOZpPti0a8TEOvtdwxU/Yb5bR5Oo74tw==
X-Received: by 2002:a05:6402:31ee:b0:514:8fa7:45a2 with SMTP id dy14-20020a05640231ee00b005148fa745a2mr1788498edb.39.1685711174193;
        Fri, 02 Jun 2023 06:06:14 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id z19-20020aa7c653000000b005149b6ec1bdsm669961edr.29.2023.06.02.06.06.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:06:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/4] libsepol: drop message for uncommon error cases
Date:   Fri,  2 Jun 2023 15:06:05 +0200
Message-Id: <20230602130608.24586-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Match surrounding code and the message were quite generic too.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  added signed-off
---
 libsepol/src/kernel_to_conf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index c48a7114..cb7cb740 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2886,7 +2886,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out, struct policydb *pdb)
 	for (pirq = pdb->ocontexts[1]; pirq != NULL; pirq = pirq->next) {
 		rc = snprintf(pirq_str, 21, "%i", pirq->u.pirq);
 		if (rc < 0 || rc >= 21) {
-			fprintf(stderr,"error1\n");
 			rc = -1;
 			goto exit;
 		}
@@ -2894,7 +2893,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out, struct policydb *pdb)
 		ctx = context_to_str(pdb, &pirq->context[0]);
 		if (!ctx) {
 			rc = -1;
-			fprintf(stderr,"error2\n");
 			goto exit;
 		}
 
-- 
2.40.1

