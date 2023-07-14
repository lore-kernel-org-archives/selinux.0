Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE6EB64DC
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjGNSoZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjGNSoY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:44:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B32D6B
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9926623e367so299289566b.0
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689360262; x=1691952262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GNxra1aV40ir7qGnj4nvL+9oXUzgUjUbIrEK/WMMok=;
        b=Jl01EBCyp37iQdHlLPsZ8pZA1cksQa7Jn0vCOOkChBeh67kkZZ2Zyh4Xvkl+iBaclB
         F7811LUNOeTf6HpPxzf6J96Kl2CbnrC/QcQnFGp+5eDa2YrDKjE9L92Ks7DHLSHCDMGX
         NnmJ9RWP4ashomlVy+EI8OSHs9246bpzCIN4lUchgbEw/ZEtovHkYDSbSGYhfnZ8aQ2I
         jWYZoU1ScV7WvjYVzliqyEijPadTEDaXIBVKxp/HTKXjd/UK7ohe9UNyL0UJo1XIP82W
         KU81PYZbWsetuf3ecqtyg2X3v/oQyiBDjNiF3CUXU0rjJGUZrrFNyx9RU9GEY65sEHby
         P/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360262; x=1691952262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GNxra1aV40ir7qGnj4nvL+9oXUzgUjUbIrEK/WMMok=;
        b=gACCMPn3vnWRx5Rt7AruIZkwue27TYdXE3VgL75juUPBD+9LTKOPMRciw4glI/pr8m
         3qaGT2vD1g/KZhi5UjczTdd7K3SbQwYLyGqjD3uje17lV3AdxoLNER/FwZ3wuEpXb9Gk
         xVAcovjob2JQ65s0xo0RmTP2fKFgyiOt1r9RMlYc5qpQnH8SLP9SQ6f+zoa8p4thHoFZ
         pcSEAD+M5Akm+AWfV/pXM7hWcTme0v/8z5r26OfWYaQsfie6U9EtNc3HfvFKGBt18vRz
         GdlRXoCV9M+aaV5f9q5sYt0f9mABlD0LwMS9VcwuEHCcMHnypRT7Df43wCL/kkv+Ko/o
         L5/w==
X-Gm-Message-State: ABy/qLatBAT3YxkBANJJmm/JIHDHCnWmjsQRqLa8Y8y0AYOy1qhnxriO
        aDKMntzD0eLgIc4mOjLUaw05IpCe4AxDuw==
X-Google-Smtp-Source: APBJJlHI+P2FZnF25HK4oacUi9M+UVOviGPVD7g5bVBRobBbZ37I1ChAz8Almw0y+nslyxUbYLtwyw==
X-Received: by 2002:a17:906:207:b0:988:aeb7:2a37 with SMTP id 7-20020a170906020700b00988aeb72a37mr4350990ejd.33.1689360261630;
        Fri, 14 Jul 2023 11:44:21 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm5692167eju.215.2023.07.14.11.44.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:44:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] libsepol: validate: use fixed sized integers
Date:   Fri, 14 Jul 2023 20:44:11 +0200
Message-Id: <20230714184414.40724-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid issues on architectures where unsigned int and uint32_t are not of
the same size.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 08b4a477..7db4ad35 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -23,7 +23,7 @@ typedef struct map_arg {
 
 static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitmap_t *gaps)
 {
-	unsigned int i;
+	uint32_t i;
 
 	ebitmap_init(gaps);
 
@@ -180,7 +180,7 @@ static int validate_scope(__attribute__ ((unused)) hashtab_key_t k, hashtab_datu
 {
 	const scope_datum_t *scope_datum = (scope_datum_t *)d;
 	const uint32_t *nprim = (uint32_t *)args;
-	unsigned int i;
+	uint32_t i;
 
 	switch (scope_datum->scope) {
 	case SCOPE_REQ:
@@ -205,7 +205,7 @@ static int validate_scopes(sepol_handle_t *handle, const symtab_t scopes[], cons
 {
 	const avrule_decl_t *decl;
 	unsigned int i;
-	unsigned int num_decls = 0;
+	uint32_t num_decls = 0;
 
 	for (; block != NULL; block = block->next) {
 		for (decl = block->branch_list; decl; decl = decl->next) {
@@ -685,7 +685,7 @@ static int validate_bool_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 
 static int validate_datum_array_gaps(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
-	unsigned int i;
+	uint32_t i;
 
 	for (i = 0; i < p->p_classes.nprim; i++) {
 		if (bool_xnor(p->class_val_to_struct[i], ebitmap_get_bit(&flavors[SYM_CLASSES].gaps, i)))
@@ -1377,7 +1377,7 @@ bad:
 static int validate_permissives(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
 	ebitmap_node_t *node;
-	unsigned i;
+	uint32_t i;
 
 	ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
 		if (validate_simpletype(i, p, flavors))
@@ -1429,7 +1429,7 @@ static int validate_range_transitions(sepol_handle_t *handle, const policydb_t *
 static int validate_typeattr_map(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
 	const ebitmap_t *maps = p->type_attr_map;
-	unsigned int i;
+	uint32_t i;
 
 	if (p->policy_type == POLICY_KERN) {
 		for (i = 0; i < p->p_types.nprim; i++) {
-- 
2.40.1

