Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EF8C43611
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97646121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhECRzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhECRy6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE0C06138B
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u21so9140829ejo.13
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nqrTybfraTNAjTXLC1JUZdvrh3NNq0lOqSzGBA1zkYk=;
        b=rWPsl+50lk3URvD9E9zTNLeR+K8S9re4FitTBsqeLfu/chU1wPqNPZhfOzleq/0lRi
         4cngOhlSNxXGWDuAVRUcQLEi4hdVFCEfhUndLpntN8JCXJokP/ZwLX4gMArsN4Su5h3g
         zzsp+UXnmhnA26vTXuI/VsrAkowpd3jAR+ut4KVhoFdm1DPpMwnw5NDvzklJm+qqkNI6
         FPq3+uM+E/ecJRDM801UaFqV5K+dcxsaoOUAQQudDY4VWtxBlLbbQn2RQP7qIIVN4gNg
         yiZs3TLjJHoVrApfBu7O30E5p5uKZT6HjauDyctZRO1Ce83WqkTe3FKOCm5xUlhmR/Vs
         4CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqrTybfraTNAjTXLC1JUZdvrh3NNq0lOqSzGBA1zkYk=;
        b=MoYWKhcbOtUGG7UAv0JCdUzpFsZaOGXXv1g5TTYb4IpsmPQ+Lhyi15uCb7PKF92GKy
         T8ZXQNhSO2KSyKL2Glk6oEbao8ee8MR0wGf02pjXIEV40EH5+hul82XOytNwVMkeejaG
         d0seZ7MpxaVWuoftEcdBMOEO3wt8LyOWai75M1l/eO66MJHCWBNjKY/nhDVdIOOD+n6Y
         llFdP6hVpabgUy/Rx7YSFlT7iEhej7/QCcQcajwqnd1Axw94XA/QcmXZNdBvIg1oTWxq
         jjgGrru1mI9maaQBrHe1yVV6WQ0Kc3N+V6tDceG/Dsey1/kP854HURHU5m99otR77tob
         2CfQ==
X-Gm-Message-State: AOAM532Fo8Ieg60J2okaKvx72Dcn2HkE24U8fUA0E6o5M7VtYiLDRpSw
        oWqOP1GpTsj8BKeLU2u5Qtu8q/bGq9TQ/g==
X-Google-Smtp-Source: ABdhPJxcMJgjPbxGORr8hNXnRK5ifrJA4i56X95jWNs5g3454ieQgC/CPi/4bXFx0TZdrLbjBVbucA==
X-Received: by 2002:a17:907:11d1:: with SMTP id va17mr17700402ejb.485.1620064442315;
        Mon, 03 May 2021 10:54:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 22/25] libselinux: drop redundant casts to the same type
Date:   Mon,  3 May 2021 19:53:47 +0200
Message-Id: <20210503175350.55954-23-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by clang-tidy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c            | 2 +-
 libselinux/src/avc_sidtab.c           | 2 +-
 libselinux/src/is_customizable_type.c | 2 +-
 libselinux/src/selinux_restorecon.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index d56b56eb..029f874f 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -275,7 +275,7 @@ static int __policy_init(const char *init_path)
 	}
 
 	sepol_bool_iterate(avc->handle, avc->policydb,
-			   load_booleans, (void *)NULL);
+			   load_booleans, NULL);
 
 	/* Initialize the sidtab for subsequent use by sepol_context_to_sid
 	   and sepol_compute_av_reason. */
diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 8dc87560..8c81cf65 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -56,7 +56,7 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
 		rc = -1;
 		goto out;
 	}
-	newctx = (char *) strdup(ctx);
+	newctx = strdup(ctx);
 	if (!newctx) {
 		rc = -1;
 		avc_free(newnode);
diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index 92876f4d..1b17860c 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -38,7 +38,7 @@ static int get_customizable_type_list(char *** retlist)
 			while (fgets_unlocked(buf, selinux_page_size, fp)
 			       && i < ctr) {
 				buf[strlen(buf) - 1] = 0;
-				list[i] = (char *) strdup(buf);
+				list[i] = strdup(buf);
 				if (!list[i]) {
 					unsigned int j;
 					for (j = 0; j < i; j++)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 6fb9e1ff..999aa924 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1152,7 +1152,7 @@ void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)
 	unsigned char *fc_digest;
 	size_t num_specfiles, fc_digest_len;
 
-	fc_sehandle = (struct selabel_handle *) hndl;
+	fc_sehandle = hndl;
 	if (!fc_sehandle)
 		return;
 
-- 
2.31.1

