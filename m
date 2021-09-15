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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BE3C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF8860F4A
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhIONNA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhIONM7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 09:12:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D29C061574
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:11:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt8so5955159ejb.13
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VLXZ3sasAFzlRpVzSFDkB6qcIN6o5DJcUdfdi4hYnY8=;
        b=X+HsGjiJ1kkNnlsD743fGlbe6kLz5uHHVMHMVcKEpdRmHr6Gk42M4I+sqYcVDKl0Y5
         kmTXfofFDnaOJGcza7ta8Xn79VRp6DSAzXhCE3Zoi7znKIafKGHyPTo1Q3iFokpz8phH
         VCkPZyc/9cmJDtg0v1gNATsG7Qhgf6ZVg9CcRRYooD7hqhn1CungwE2XsyXPg8nBwCb8
         h3wXVFOPd1zjx9dVXt6dNrw2EVGuDgsWDZQPPYdRHBY/bify1vuW01vf0muHA6mpUcSD
         fIyCU9aMcnwK//bqD3uYTGzqP4+KuUWyUECP7lUrnBs1xY5FxYAt0BQMumWUapHfXHhZ
         18AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLXZ3sasAFzlRpVzSFDkB6qcIN6o5DJcUdfdi4hYnY8=;
        b=VrfO4jVrjzh1f+XscdnAi1B8lbKXlFT85gc8Y5dLqTFGGLeU5Pqf9zu2wJukP3Mht9
         8kDUpIzIIRPITeN4Qy19TreZrx94rQcB+HWiW5SC5Ar4fapC6/eI0ckKi0OPWVnUxaHt
         Zbic6wmGpc9ak1U2LsTgeIPaXhQs25UNd/3QZKjyb0sXwblN7kdyidbCGgo8dwj1ESTY
         sIvuoxz7jeWQhaHX6vmRNyV6sHjYK3d4JqAGj4gzOoIKW2zWk2yao0uy2dczP/+8R4Qh
         ytQfiEmsZDZ3a/2ZdzrYyc2hLJ7A/39d9/u3gH2MBkQl23HFVXDxjtN/4SDXrNPb8c+z
         eH8A==
X-Gm-Message-State: AOAM530vGRnNlmOBVUfrp9mq6qQGUKHSZYEWzsGN3+F4N/EAhXSkFufe
        HwlGbtRrpgrKZzWnVGuCtv2mXPIygg0=
X-Google-Smtp-Source: ABdhPJzwKSVKjHlKHi/aUlKFND06660czCtmOulNVkJH/K/9DkF8GPYGY/UyYHtrnLpWNUB/vAjgaw==
X-Received: by 2002:a17:906:d541:: with SMTP id cr1mr25734878ejc.81.1631711494176;
        Wed, 15 Sep 2021 06:11:34 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-239-251.95.112.pool.telefonica.de. [95.112.239.251])
        by smtp.gmail.com with ESMTPSA id s11sm1836254edy.64.2021.09.15.06.11.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:11:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 09/13] checkpolicy: resolve dismod memory leaks
Date:   Wed, 15 Sep 2021 15:11:30 +0200
Message-Id: <20210915131130.25173-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-10-cgzones@googlemail.com>
References: <20210914124828.19488-10-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Example leak:

    Indirect leak of 4 byte(s) in 1 object(s) allocated from:
        #0 0x49bacd in __interceptor_malloc (./checkpolicy/test/dismod+0x49bacd)
        #1 0x58ae54 in add_i_to_a ./libsepol/src/util.c:55:21
        #2 0x53ea8e in symtab_insert ./libsepol/src/policydb.c:1729:6
        #3 0x536252 in roles_init ./libsepol/src/policydb.c:772:7
        #4 0x536252 in policydb_init ./libsepol/src/policydb.c:892:7
        #5 0x562ff1 in sepol_policydb_create ./libsepol/src/policydb_public.c:69:6
        #6 0x521a7c in module_package_init ./libsepol/src/module.c:96:6
        #7 0x521a7c in sepol_module_package_create ./libsepol/src/module.c:126:7
        #8 0x4cfb80 in read_policy ./checkpolicy/test/dismod.c:750:7
        #9 0x4cda10 in main ./checkpolicy/test/dismod.c:878:6
        #10 0x7f8538d01e49 in __libc_start_main csu/../csu/libc-start.c:314:16

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - use sepol_policydb_free()


 checkpolicy/test/dismod.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 90c29318..1ff161da 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -751,12 +751,14 @@ static int read_policy(char *filename, policydb_t * policy)
 			fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
 			exit(1);
 		}
+		sepol_policydb_free(package->policy);
 		package->policy = (sepol_policydb_t *) policy;
 		package->file_contexts = NULL;
 		retval =
 		    sepol_module_package_read(package,
 					      (sepol_policy_file_t *) & f, 1);
-		free(package->file_contexts);
+		package->policy = NULL;
+		sepol_module_package_free(package);
 	} else {
 		if (policydb_init(policy)) {
 			fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
-- 
2.33.0

