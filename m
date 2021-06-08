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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC604C4743E
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9629A61351
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhFHQBP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhFHQBP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63452C061574
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id he7so14012702ejc.13
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0dT1WXYFxWGO7YTg0yBqdK6fLrIxfUrG/rl0MeVrInw=;
        b=KSCLgnNKJVLFf/1SD9twyQm9K0lNpSC73tU/bbRzYaAlrCANYbP9x3whLyxY2gTkBl
         DSQ0WZJWo/GAYR8UKrjTuqg0GOIZSIYIa8ejjjm5sDRHb/vWTven4cfe33BfOcmUb3J1
         2BplCwyoenoKXW0ZMCG7YXsArcPdmRY8hPsA7m1qUj8u4dMuG/KRdk364Fv8rz8w2gdT
         IkvNXokhsa0XNHBFn+tv1jNUzdxr64ZZHPYuDIEz+1Vrv99aS0YGwUkNDETMp6GLwpsB
         DR2yfRbof2iMzav2OEMOI1Vl0PiSJRiV695Bmwojm56Y84Bes77nJKxf0koNGCVAdCBi
         fPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dT1WXYFxWGO7YTg0yBqdK6fLrIxfUrG/rl0MeVrInw=;
        b=oD5ZL1HZrym5LokbNDUI4zY79guHz2VKbjz1+NG3d85UNZ5VySlAQG6k/3OYYHEY9F
         pFMqcbEO4SsFZJr+IrqXjPwSnqOOzAHXP62ASn3hfaNSuhJdaybRusI1aZViLLz23oJH
         60PuHOq1udPG2CyKem+Uf0mD9Pw3tb0QRqmhDehyL9IWMEvMJVkEC27RgCOLRpjin5Ww
         tKyk3TtCT+6oNdTs75UfDM1F+iKuCgpfeBHIffjTEQFWl+Xp17/hhFUj85LcOrB+DsNk
         hXjzH46Brlop/s61aQaDAkR+H9asLLid4hVyzrLPR0lyRAMOPTdWDhoP04gecivULpt5
         /1GQ==
X-Gm-Message-State: AOAM531rjTLZTOCCnc3FDrOiwsF3w0VpPkgQycJTW8jHvXvju2Q20d2W
        kBVt5K40aBHwGbcXXtHvTAKxJH5T9mE=
X-Google-Smtp-Source: ABdhPJx5YtmwJFk/A9muFwl80nwivcoF7UbnKaoPxb1btF9XyzdmI55gBlnqwy/9aaAqRBvZkxo2CA==
X-Received: by 2002:a17:906:a1d2:: with SMTP id bx18mr23944381ejb.423.1623167960966;
        Tue, 08 Jun 2021 08:59:20 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:20 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 03/23] libsepol: remove unused functions
Date:   Tue,  8 Jun 2021 17:58:52 +0200
Message-Id: <20210608155912.32047-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The functions `role_set_get_role`, `sepol_validate_transition` and
`sepol_sidtab_remove` seem to be unused since the initial import.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 18 ----------------
 libsepol/src/services.c | 47 -----------------------------------------
 libsepol/src/sidtab.c   | 31 ---------------------------
 3 files changed, 96 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3f7ddb11..fc1d0711 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1791,24 +1791,6 @@ int type_set_or_eq(type_set_t * dst, type_set_t * other)
 	return ret;
 }
 
-int role_set_get_role(role_set_t * x, uint32_t role)
-{
-	if (x->flags & ROLE_STAR)
-		return 1;
-
-	if (ebitmap_get_bit(&x->roles, role - 1)) {
-		if (x->flags & ROLE_COMP)
-			return 0;
-		else
-			return 1;
-	} else {
-		if (x->flags & ROLE_COMP)
-			return 1;
-		else
-			return 0;
-	}
-}
-
 /***********************************************************************/
 /* everything below is for policy reads */
 
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 39fbd979..ff91f7d2 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1024,53 +1024,6 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	return 0;
 }
 
-static int sepol_validate_transition(sepol_security_id_t oldsid,
-				     sepol_security_id_t newsid,
-				     sepol_security_id_t tasksid,
-				     sepol_security_class_t tclass)
-{
-	context_struct_t *ocontext;
-	context_struct_t *ncontext;
-	context_struct_t *tcontext;
-	class_datum_t *tclass_datum;
-	constraint_node_t *constraint;
-
-	if (!tclass || tclass > policydb->p_classes.nprim) {
-		ERR(NULL, "unrecognized class %d", tclass);
-		return -EINVAL;
-	}
-	tclass_datum = policydb->class_val_to_struct[tclass - 1];
-
-	ocontext = sepol_sidtab_search(sidtab, oldsid);
-	if (!ocontext) {
-		ERR(NULL, "unrecognized SID %d", oldsid);
-		return -EINVAL;
-	}
-
-	ncontext = sepol_sidtab_search(sidtab, newsid);
-	if (!ncontext) {
-		ERR(NULL, "unrecognized SID %d", newsid);
-		return -EINVAL;
-	}
-
-	tcontext = sepol_sidtab_search(sidtab, tasksid);
-	if (!tcontext) {
-		ERR(NULL, "unrecognized SID %d", tasksid);
-		return -EINVAL;
-	}
-
-	constraint = tclass_datum->validatetrans;
-	while (constraint) {
-		if (!constraint_expr_eval_reason(ocontext, ncontext, tcontext,
-					  0, constraint, NULL, 0)) {
-			return -EPERM;
-		}
-		constraint = constraint->next;
-	}
-
-	return 0;
-}
-
 /*
  * sepol_validate_transition_reason_buffer - the reason buffer is realloc'd
  * in the constraint_expr_eval_reason() function.
diff --git a/libsepol/src/sidtab.c b/libsepol/src/sidtab.c
index e6bf5716..255e0725 100644
--- a/libsepol/src/sidtab.c
+++ b/libsepol/src/sidtab.c
@@ -84,37 +84,6 @@ int sepol_sidtab_insert(sidtab_t * s, sepol_security_id_t sid,
 	return 0;
 }
 
-int sepol_sidtab_remove(sidtab_t * s, sepol_security_id_t sid)
-{
-	int hvalue;
-	sidtab_node_t *cur, *last;
-
-	if (!s || !s->htable)
-		return -ENOENT;
-
-	hvalue = SIDTAB_HASH(sid);
-	last = NULL;
-	cur = s->htable[hvalue];
-	while (cur != NULL && sid > cur->sid) {
-		last = cur;
-		cur = cur->next;
-	}
-
-	if (cur == NULL || sid != cur->sid)
-		return -ENOENT;
-
-	if (last == NULL)
-		s->htable[hvalue] = cur->next;
-	else
-		last->next = cur->next;
-
-	context_destroy(&cur->context);
-
-	free(cur);
-	s->nel--;
-	return 0;
-}
-
 context_struct_t *sepol_sidtab_search(sidtab_t * s, sepol_security_id_t sid)
 {
 	int hvalue;
-- 
2.32.0

