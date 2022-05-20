Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF583C433F5
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 12:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349453AbiETMvY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349624AbiETMvP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 08:51:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630B2CCB4
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 05:51:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i27so15414690ejd.9
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pgfNaqyAqcqvfKLoe0dSNDevkArzZ9O7iIIXYp77yw=;
        b=RAF9xYaJEqgI2rpBW8Cn7g4D5XIt08EBeJ42u0aYRb0tmaD3ZQDZuUSrkDfnrwQArP
         cXTQTASMZoDCSRo3JWG8JcQY312OBZCYY6RAtZwFcAvsne8jeIvMJGqo9k4CjcThQg0q
         t7RHRKdbnozuCb3v9MNH19c7e2+aNrH0d9vlPr7yil2cR4BqtuwtEBrq28wFWF4wVaru
         7H7fAohrsm284sjxtBNUN5PYlkUuEFymW8B5i/os7MdCq6RQgdPE4gqsezEwiNW6LN27
         bQ+c8qtINoMsqz2X2BBqBOvl2dhyhXgsO+ne4HESIZ39e2CGFbo6uSk5RVZc74kWCP7+
         DLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pgfNaqyAqcqvfKLoe0dSNDevkArzZ9O7iIIXYp77yw=;
        b=ewKi4uyO+mJM3ffLlQC2n5lFS6CLKmMKLKzHBqMHpLE6C7Zx34KRyTmxj1EB0DSUTO
         oo2k18wCciIx8h3hNTp7pb+CUbGznm3v8c1GCeXO/QkuJpMHibzZkFc6IoGtBXWkIlTt
         4EP0QOpY5Ji6Dzu5KN9VMO5/9sJ0wqXmQlfg+KDEHGAkNxiDEvt107piOAfMuMYulnOh
         nyGhyGJ03lUCVFJ/alGRY6BUp0Y3f6XAvB/NYM/OWjvzw2D0tgLLvUFfgIZW41v2vBpu
         6TDPhGowbTyef8zV1pfmjeL8zYeoxIKfUjGKE9MHJshdDEfA1DKO++RhyWuikc1VND8W
         wx8A==
X-Gm-Message-State: AOAM530cXgFGxGXS5ocyaiVQm/vTQN82GGpayyez3bY+poKcNR48LV+g
        nJD68x0BJk1aSXk89feoXutER0umlys=
X-Google-Smtp-Source: ABdhPJz67BCm1TSokVxjgM3xjQ53WoAaJo0eW5MyFvVrN/+it6WNiMVc51vqb9C/S2OkED21BwVG2Q==
X-Received: by 2002:a17:907:7f90:b0:6f3:ee68:d332 with SMTP id qk16-20020a1709077f9000b006f3ee68d332mr8439137ejc.114.1653051072668;
        Fri, 20 May 2022 05:51:12 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402120600b0042aa6a43ccdsm4289498edw.28.2022.05.20.05.51.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:51:12 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/audit2allow: close file stream on error
Date:   Fri, 20 May 2022 14:51:07 +0200
Message-Id: <20220520125107.8423-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    sepolgen-ifgen-attr-helper.c: In function ‘load_policy’:
    sepolgen-ifgen-attr-helper.c:196:17: warning: leak of FILE ‘fp’ [CWE-775] [-Wanalyzer-file-leak]
      196 |                 fprintf(stderr, "Out of memory!\n");
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/audit2allow/sepolgen-ifgen-attr-helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/audit2allow/sepolgen-ifgen-attr-helper.c
index 6f3ba962..5e6cffc1 100644
--- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
+++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
@@ -194,12 +194,14 @@ static policydb_t *load_policy(const char *filename)
 	policydb = malloc(sizeof(policydb_t));
 	if (policydb == NULL) {
 		fprintf(stderr, "Out of memory!\n");
+		fclose(fp);
 		return NULL;
 	}
 
 	if (policydb_init(policydb)) {
 		fprintf(stderr, "Out of memory!\n");
 		free(policydb);
+		fclose(fp);
 		return NULL;
 	}
 
@@ -208,6 +210,7 @@ static policydb_t *load_policy(const char *filename)
 		fprintf(stderr,
 			"error(s) encountered while parsing configuration\n");
 		free(policydb);
+		fclose(fp);
 		return NULL;
 	}
 
-- 
2.36.1

