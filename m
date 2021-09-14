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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291C3C433FE
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8BB60F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhINMwC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhINMwC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7666C061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z94so13508066ede.8
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wxVrwi7fqRCUdi0rstdW3xmsLEx4av06gtb8OTs43dA=;
        b=VEyv86Gb6XT6v6opXjl3kKKyRNRgOTf0cr/0ciRCGV7ti6/l3FSJcWpD8OeywbPSBk
         RGbEoQYv+hydsvjrVFTkpRrMUy51RUfjynd/Vxty37HvMIjF3ILL5uS3634DVOBhZA4V
         dli22+Y6pFlgIBhSn3VayghjMzt8nvjbsHG3OYuIDu30WdIL8F5FVV8NGUGxUBZqwCJn
         OxJfHMB7XAk15kcv1nHFysWwbY0865pqZnJAwbL0x0YmREHyizSNkc9oc0w5HbvK48jj
         ED3+lkTeX1NB1E7wZBnNJaVuVvdEH70muKZuGS8uMvh2QMALn7lQNM/jZlLJ52gqi6rB
         9U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxVrwi7fqRCUdi0rstdW3xmsLEx4av06gtb8OTs43dA=;
        b=364RJKvX8X+Edv1pDn/Hwzu9CSi/7AYZ+3CQfoBxbTVHWB/NJuXCPxe4EvdlZhV9ny
         ZFv1F2GGxCCOuzRF2wyMPs3W3c2l6ljK+Mb5E1SyFYRkWn3+/G2Le7By1U5yPByip1aP
         t96ykcO4MRomE339SWMLU4tvbmQPvs8QkuJTIAPxPCJtKQxNmTyYkoNT50kOjr5KSP9X
         I6z/av0D1rOPjcFRbh58BGZxHce3CkZkls6gLERl2rI81vEYQ2v0gnEDsmEAkfq8oYMA
         a5nx/E59CggWHqMNuQIx7ZgSgmXEpnn2SUHAVSDpI6B3uLEdatF20zvDfIBxpMLbwGjn
         ii8w==
X-Gm-Message-State: AOAM530izUZ1qTyb3ZTJhVHeDuwgiY460nv+ZXoa8xqStKnKJDaR+5ec
        LkqEVEPDusU4v+dd9Jtxv8QqD9y+9UA=
X-Google-Smtp-Source: ABdhPJxKWKMvotIZz2YXsuwPMGx3oWBmNr7lNiyNajgrkga7jxpL8kqTpDoNqPs1OKQrLxQEu0wvsQ==
X-Received: by 2002:a05:6402:49a:: with SMTP id k26mr19613030edv.279.1631623843176;
        Tue, 14 Sep 2021 05:50:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 01/13] libsepol: avoid implicit conversions
Date:   Tue, 14 Sep 2021 14:48:16 +0200
Message-Id: <20210914124828.19488-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid implicit conversions from signed to unsigned values, found by
UB sanitizers, by using unsigned values in the first place.

    util.c:95:15: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index a47cae87..902c63c5 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -92,7 +92,7 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 	cladatum = policydbp->class_val_to_struct[tclass - 1];
 	p = avbuf;
 	for (i = 0; i < cladatum->permissions.nprim; i++) {
-		if (av & (1 << i)) {
+		if (av & (UINT32_C(1) << i)) {
 			v.val = i + 1;
 			rc = hashtab_map(cladatum->permissions.table,
 					 perm_name, &v);
-- 
2.33.0

