Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FEBC43219
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F79760F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhINMwG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhINMwG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B3C061760
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n10so19678389eda.10
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vNE1e9mEnoTqmeRgeC8ybL/zlx4MVHTgHYCCk/5UPKI=;
        b=ZzyUnkTAFdCkhYSBQpu+P9MQe/tKL3r6LjIGUDMO/QxSOAA74fPhPKOLAD8tPg0jQx
         RnmTFCuboDNCB6Ykpjey4G9Pxw6APwbwZBxuHYjQYHf/lD1ne/2jhrMt2elSGHrXfHKL
         j2dAvlUz7Caw/iOiAyk3HuOHcWhm7JQscMLhRoN+thvdUHbDlQ06ILVRwaxFqPhFw+6d
         OqOZNv3OHsfrbdKc5wHn3gqlPcIIaAjxYrLhSsynQJpayUoqb2P9NBpqqUlRVFiEpo7V
         zpi6mddb4dNlAyL/HKzbcAzzJNan4C/VI4xRtf84thY5c5dGWaMscu532Z0g2iDdNF8h
         hFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNE1e9mEnoTqmeRgeC8ybL/zlx4MVHTgHYCCk/5UPKI=;
        b=V5nO/HGzaiPXFLp0k1tOEjf5KeInJEi6gUn4RSO7Rqlo7TLvdP1F0zqdPqj/xNn1x+
         IIMC9GfzU2/4T+7P18eJwSM1Kheigdi8ovB/mlz+61+fZuiCqtJhclnp79uThv0iw2jY
         dyZgu3E9OgooGkkiATjnxoQPDze7JSBUdMPSJKqK58t6lGnxnXjwre+ycxlR7U+/dvuo
         NufCrSpKeZoqOZNrpkxRilZK5qr9FBHaSHOhzSO6D73TInGYpcoBzZn7XIi3noClseRo
         gsWbY8c8sQT7ZYaGSffj2UC30iaYhaY9jghWBSCXoYmKJfAsLhcyzSodWzJngo4ZswIx
         0zLw==
X-Gm-Message-State: AOAM530DwanVOjRmkTDBi1dRy377SmlSNriUd2XVedVIDu/OnbQpB+wW
        alq+SOymyfSxwCmlfD4Oom6kqo6M1Fw=
X-Google-Smtp-Source: ABdhPJxkLt1dUY9OdgPMy11x/mgi/DtysZWzKP35nW4XMKnlM3XqLDosaRr0VEF6hxNsLE3zpfEK3Q==
X-Received: by 2002:aa7:c617:: with SMTP id h23mr17752346edq.357.1631623847636;
        Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 09/13] checkpolicy: resolve dismod memory leaks
Date:   Tue, 14 Sep 2021 14:48:24 +0200
Message-Id: <20210914124828.19488-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
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
 checkpolicy/test/dismod.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 90c29318..9550b999 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -751,12 +751,15 @@ static int read_policy(char *filename, policydb_t * policy)
 			fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
 			exit(1);
 		}
+		policydb_destroy((policydb_t *) package->policy);
+		free(package->policy);
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

