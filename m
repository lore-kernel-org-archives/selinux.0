Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB973C433EF
	for <selinux@archiver.kernel.org>; Tue,  8 Mar 2022 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiCHS7R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbiCHS7Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Mar 2022 13:59:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333A192B2
        for <selinux@vger.kernel.org>; Tue,  8 Mar 2022 10:58:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx21so41315184ejb.13
        for <selinux@vger.kernel.org>; Tue, 08 Mar 2022 10:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UsPowHRXWPrbqiMfxZGq34vKdDRvvQve4Vrpaw10rlM=;
        b=Q3pwNTIdkMBRgCZUWuL8uHSMHU5pQiyk5bmUEy/zD6DMEoEjGF33JqT7eubmm2z0YT
         SW4ROyCZMSqoi3sNS40MlXc4oaVZibVkerQOjRoWBDgZMlAtLMJsC+wPdsEEOPqriIzS
         4z+HVVUj+57f09/pgCMB8BBSD/uEbhIeLuIPVNoZ3Pug4hVLPpMzxansCOGeTO0kGfWN
         qYev77WdcDrEcTPdJW7uw+W74fcLqy6rSca9E2Nx1uQ27Wjsvnl/2KvA7HPaaCKoHW3n
         0ajziEX8zdxNRIfpSw5r2ZouHSuWibV9q2bwrkBAXeh6AymhBpM4BVGNQDH4oOq7Amz4
         MLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsPowHRXWPrbqiMfxZGq34vKdDRvvQve4Vrpaw10rlM=;
        b=mZoBFm2DhodUiHyk7IMRPZhKUz7lWFQ7pczF2/NxURxwv64nIZo1U5p2lMt2FiQH4q
         NZfyFdHI82Kuv604AsI/CXovFTqBfIDooQdPn9XHjXVgWo/XorfXGvbBojIQvFPqQ3P8
         EX+/qpxjLhDNweil7stGtjypbpxivSZ63yKSWe+hywein8kVzERb01YFJjUuREwaZcqd
         8OWDwH0a8FuoRD+78XJuc1EK8bW6Di7kR9o/z+cCoaymRtHBlVhIGYVfWh1zlWkNqQjh
         QEsLzWwsmJSkNfr/ZNLOMumFCfGwcjSvBtaqNCZjE08Fgw9DGCg0ymxBz240HCyZjHG6
         LTpg==
X-Gm-Message-State: AOAM532eEw8RgfOlBvo9H2oTSYL/xY+LQt7dhC2KnqWQdA2M2XMVx0zJ
        PkKnrTqhCsn6Xyt2Vxo8BDyFF5vsb1g31g==
X-Google-Smtp-Source: ABdhPJyB7Pi5eGyznrcIcvg03thTTwXmB7Th7G9EzvB6TGBuACshjIqnKN71MkKOZXndmZLqIiI35g==
X-Received: by 2002:a17:907:72c5:b0:6da:e99e:226c with SMTP id du5-20020a17090772c500b006dae99e226cmr14915580ejc.515.1646765898184;
        Tue, 08 Mar 2022 10:58:18 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-252-105.77.6.pool.telefonica.de. [77.6.252.105])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906961500b006daac87ddb0sm5408063ejx.140.2022.03.08.10.58.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:58:17 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: validate boolean datum arrays
Date:   Tue,  8 Mar 2022 19:58:10 +0100
Message-Id: <20220308185811.72407-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308185811.72407-1-cgzones@googlemail.com>
References: <20220308185811.72407-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Validate the boolean entries in the policy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 72063351..b51dd366 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -577,6 +577,41 @@ static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_user_datum(margs->handle, d, margs->flavors, margs->mls);
 }
 
+static int validate_bool_datum(sepol_handle_t *handle, cond_bool_datum_t *boolean, validate_t flavors[])
+{
+	if (validate_value(boolean->s.value, &flavors[SYM_BOOLS]))
+		goto bad;
+
+	switch (boolean->state) {
+	case 0:
+	case 1:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (boolean->flags) {
+	case 0:
+	case COND_BOOL_FLAGS_TUNABLE:
+		break;
+	default:
+		goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid bool datum");
+	return -1;
+}
+
+static int validate_bool_datum_wrapper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	map_arg_t *margs = args;
+
+	return validate_bool_datum(margs->handle, d, margs->flavors);
+}
+
 static int validate_datum_array_gaps(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
 	unsigned int i;
@@ -607,6 +642,11 @@ static int validate_datum_array_gaps(sepol_handle_t *handle, policydb_t *p, vali
 			goto bad;
 	}
 
+	for (i = 0; i < p->p_bools.nprim; i++) {
+		if (bool_xnor(p->bool_val_to_struct[i], ebitmap_get_bit(&flavors[SYM_BOOLS].gaps, i)))
+			goto bad;
+	}
+
 	return 0;
 
 bad:
@@ -647,6 +687,9 @@ static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, v
 	if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CATS]))
 		goto bad;
 
+	if (hashtab_map(p->p_bools.table, validate_bool_datum_wrapper, &margs))
+		goto bad;
+
 	return 0;
 
 bad:
-- 
2.35.1

