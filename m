Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0644DC4332F
	for <selinux@archiver.kernel.org>; Tue, 20 Dec 2022 15:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiLTPmF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiLTPlw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Dec 2022 10:41:52 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B018B37
        for <selinux@vger.kernel.org>; Tue, 20 Dec 2022 07:41:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jo4so21205611ejb.7
        for <selinux@vger.kernel.org>; Tue, 20 Dec 2022 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPgUuxwg8Egj4RTaVdGwysZX/vzJs/Q2lLf0sxIKtNQ=;
        b=oWwn6zuFIDANiW5SWbp4kmf+SivShXAKXYXN/c1pDLovdGxgDcI3Muu+4FBCOvPrB5
         VIejOvvFYGGXWgXY/0Ma1ahsBnv+1P6ggPOaO2jiKdElJCCTH/TluoJyAVH8JwIoLuzV
         GgMxYbevM5JWC54+3NbVs+PArxSUyrLESsuOr5rrCg1GJH7SFbnTO7bjk+H9XvM+/wS9
         K18ZN7uX6taqA/8PXa7wTTJSxGVcxYnCyXYvJNsxVnmFCbZThE+4kdSxJL8A+JsDb+g9
         rJ37E7YaCx3ur5qvzScXteQu3kgswFWZEmrFJ2eGFABTFoFtzcSodE35c+zmeBREfvLm
         FM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPgUuxwg8Egj4RTaVdGwysZX/vzJs/Q2lLf0sxIKtNQ=;
        b=euNhqs+eVUKR4IXH1bB/IL9KxrvHiYRfRMWI6V/SgZoiv0sXOzPQjAJHXJhov7W5hV
         1qMsBZXju7IDZDmavYtfGYJfhH6NsTu2a20XNpvcJnhEU2ndRttK1903n8pLyfYk5Kfc
         qoXijTqZDAog/Sh+d7MNqRP/oz+LRyVyPWI+Y55dAHyjvrJiq2ksDgPyXt0hV7y+0CAp
         3KAHLW9AVCcGtmNGEo/dNpEuDdmtrWjs4q950Rk+NVbCgmx2VjrwUNaJ2SNW2WE311wh
         V0VcEZD2ju2c3qbuOxdchaD/wY0yDO5ZMXgGwnmWwP06kBounJVBxNAJYJk1thAN9emv
         Ahog==
X-Gm-Message-State: ANoB5pnR5RQmCs6WqZqMcm0UTjWZNgV2wtWS+NJRrNpngt3Q0gFrXREK
        y64aZRcTuooFg4q0Lxi/2ZhewPWXNb+mDQ==
X-Google-Smtp-Source: AA0mqf6HhM5Mhc8AIxpipni6bIzDjCWx/8mt6f20EJagOGEqPB7fWeNCJbGVqXz6s4hjsEznjudy0A==
X-Received: by 2002:a17:906:4995:b0:7c1:808e:7660 with SMTP id p21-20020a170906499500b007c1808e7660mr29869351eju.43.1671550901415;
        Tue, 20 Dec 2022 07:41:41 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-176-092.77.8.pool.telefonica.de. [77.8.176.92])
        by smtp.gmail.com with ESMTPSA id e22-20020a17090681d600b007c0d0dad9c6sm5861653ejx.108.2022.12.20.07.41.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:41:41 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: reject attributes in type av rules for kernel policies
Date:   Tue, 20 Dec 2022 16:41:34 +0100
Message-Id: <20221220154134.25652-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The kernel does not support type attributes as source or target in type
av rules (type_transition, type_member, type_change)[1].  Such rules
should have been expanded[2].

[1]: https://github.com/SELinuxProject/selinux-kernel/blob/abe3c631447dcd1ba7af972fe6f054bee6f136fa/security/selinux/ss/services.c#L1843
[2]: https://github.com/SELinuxProject/selinux/blob/0a8c177dacdc1df96ea11bb8aa75e16c4fa82285/libsepol/src/expand.c#L1981

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 521ea4ff..469c14f4 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -770,12 +770,20 @@ bad:
  * Functions to validate a kernel policydb
  */
 
-static int validate_avtab_key(const avtab_key_t *key, int conditional, validate_t flavors[])
+static int validate_avtab_key(const avtab_key_t *key, int conditional, const policydb_t *p, validate_t flavors[])
 {
-	if (validate_value(key->source_type, &flavors[SYM_TYPES]))
-		goto bad;
-	if (validate_value(key->target_type, &flavors[SYM_TYPES]))
-		goto bad;
+	if (p->policy_type == POLICY_KERN && key->specified & AVTAB_TYPE) {
+		if (validate_simpletype(key->source_type, p, flavors))
+			goto bad;
+		if (validate_simpletype(key->target_type, p, flavors))
+			goto bad;
+	} else {
+		if (validate_value(key->source_type, &flavors[SYM_TYPES]))
+			goto bad;
+		if (validate_value(key->target_type, &flavors[SYM_TYPES]))
+			goto bad;
+	}
+
 	if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
 		goto bad;
 	switch (0xFFF & key->specified) {
@@ -821,7 +829,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *
 {
 	map_arg_t *margs = args;
 
-	if (validate_avtab_key(k, 0, margs->flavors))
+	if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
 		return -1;
 
 	if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, margs->policy, margs->flavors))
@@ -845,13 +853,13 @@ static int validate_avtab(sepol_handle_t *handle, const avtab_t *avtab, const po
 	return 0;
 }
 
-static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_list_t *cond_av, validate_t flavors[])
+static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_list_t *cond_av, const policydb_t *p, validate_t flavors[])
 {
 	const struct avtab_node *avtab_ptr;
 
 	for (; cond_av; cond_av = cond_av->next) {
 		for (avtab_ptr = cond_av->node; avtab_ptr; avtab_ptr = avtab_ptr->next) {
-			if (validate_avtab_key(&avtab_ptr->key, 1, flavors)) {
+			if (validate_avtab_key(&avtab_ptr->key, 1, p, flavors)) {
 				ERR(handle, "Invalid cond av list");
 				return -1;
 			}
@@ -996,9 +1004,9 @@ static int validate_cond_list(sepol_handle_t *handle, const cond_list_t *cond, c
 	for (; cond; cond = cond->next) {
 		if (validate_cond_expr(handle, cond->expr, &flavors[SYM_BOOLS]))
 			goto bad;
-		if (validate_cond_av_list(handle, cond->true_list, flavors))
+		if (validate_cond_av_list(handle, cond->true_list, p, flavors))
 			goto bad;
-		if (validate_cond_av_list(handle, cond->false_list, flavors))
+		if (validate_cond_av_list(handle, cond->false_list, p, flavors))
 			goto bad;
 		if (validate_avrules(handle, cond->avtrue_list, 1, p, flavors))
 			goto bad;
-- 
2.39.0

