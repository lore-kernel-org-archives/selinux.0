Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECCBC433FE
	for <selinux@archiver.kernel.org>; Thu, 10 Feb 2022 18:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbiBJSwm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:52:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiBJSwl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Feb 2022 13:52:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE38F54
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:52:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b13so12680822edn.0
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Nog+bdpN4G0Lx3adnFJRBEOyha29dgljkyg7NlpIc2w=;
        b=Q8WdjfyJRC/vkeI8qW9kFhFS8vDwfeTHxs92ZIQWn9llF8dVGEeKU3C/7AWmjxTNdS
         qZ/X0T8b+04mP4Buq6fqv5D5ekjSF9iqc9te86nRrXC5Q4b9yWRuUWFEPgj+Zu6t1hGL
         EOgcaWpAnVgya0ftaFYS5fv4GihovYXZ1EA6Lq/b+4OsKE0ngiDiUFgCOxKUFE22dcVu
         Sig+usF06KyQ0jix0c9rz/cIsVcjBNYmLT+RQuZ6oPDhA+E+NfSpwZSSf4fQvqss4B6X
         b8E7VimuQ82MytpHpaRheltlJCtvSUWaf/e6+SuLtnh/EXgUEB0MsjBUSqqpodtegpxd
         djSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nog+bdpN4G0Lx3adnFJRBEOyha29dgljkyg7NlpIc2w=;
        b=Fwj7f7pgv0cvNyG8A0AHHdCENNr8BHeZ08rj/TtAp471tCY+pedPaDIos4HVnD7NXd
         LC/NeFMCfIYRhzfiJy0zhJBN+ud3pP1J0dgIvnH9479PNGL0Z121ZT+UaZEJ6zWijBYB
         STw0aZlUA2MzyHwR+bnze9EcSeUmhSHIWm1zbPmFlMf9Lpp/8TV3uO4DhuTrkIIb/wx3
         m+1jXfErcRwbhWRIgf5cwmzcOllCj9UCVCGv7e9jeXauF2e2Zp+WC18MIuW6m46MTdp/
         8NNiYBZbzHvxotEPQDhhQhzqTaCkwfHZpDGFUZPRzQopyeYDFkW8kl9vQWc9Q8epoRe4
         8TYA==
X-Gm-Message-State: AOAM530w+abCmHxgP1tsVAsItPJ6McCjcOfVAVVJaRS06kdk7PM8UUhE
        pYYMNIHNRrPh97tobjW2Q4tDXEbY348=
X-Google-Smtp-Source: ABdhPJy6ADuFY5+9gEdijEFN/DjhIb0yx8I10k2dJ0/fvqzUqACHO3QKcRaJ/WmQBQO/BAJuesZn0g==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr9656759edr.388.1644519160649;
        Thu, 10 Feb 2022 10:52:40 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-131-054.77.0.pool.telefonica.de. [77.0.131.54])
        by smtp.gmail.com with ESMTPSA id gi15sm4666070ejc.139.2022.02.10.10.52.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:52:40 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol: validate several flags
Date:   Thu, 10 Feb 2022 19:52:34 +0100
Message-Id: <20220210185234.41362-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210185234.41362-1-cgzones@googlemail.com>
References: <20220210185234.41362-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the type for type and role sets is valid.

Check the scope of a scope datum is valid.

Check the flavor and flags of a type datum are valid.

Check xperms are set if and only if it is an extended permission avrule.

Check xperms has a valid specified field.

Check the flag of avrule blocks is valid.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 86 +++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 41822e61..735c7a33 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -124,6 +124,15 @@ static int validate_type_set(type_set_t *type_set, validate_t *type)
 	if (validate_ebitmap(&type_set->negset, type))
 		goto bad;
 
+	switch (type_set->flags) {
+	case 0:
+	case TYPE_STAR:
+	case TYPE_COMP:
+		break;
+	default:
+		goto bad;
+	}
+
 	return 0;
 
 bad:
@@ -148,9 +157,21 @@ bad:
 static int validate_role_set(role_set_t *role_set, validate_t *role)
 {
 	if (validate_ebitmap(&role_set->roles, role))
-		return -1;
+		goto bad;
+
+	switch (role_set->flags) {
+	case 0:
+	case ROLE_STAR:
+	case ROLE_COMP:
+		break;
+	default:
+		goto bad;
+	}
 
 	return 0;
+
+bad:
+	return -1;
 }
 
 static int validate_scope(__attribute__ ((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
@@ -159,12 +180,23 @@ static int validate_scope(__attribute__ ((unused)) hashtab_key_t k, hashtab_datu
 	uint32_t *nprim = (uint32_t *)args;
 	unsigned int i;
 
+	switch (scope_datum->scope) {
+	case SCOPE_REQ:
+	case SCOPE_DECL:
+		break;
+	default:
+		goto bad;
+	}
+
 	for (i = 0; i < scope_datum->decl_ids_len; i++) {
 		if (!value_isvalid(scope_datum->decl_ids[i], *nprim))
-			return -1;
+			goto bad;
 	}
 
 	return 0;
+
+bad:
+	return -1;
 }
 
 static int validate_scopes(sepol_handle_t *handle, symtab_t scopes[], avrule_block_t *block)
@@ -403,6 +435,26 @@ static int validate_type_datum(sepol_handle_t *handle, type_datum_t *type, valid
 	if (type->bounds && validate_value(type->bounds, &flavors[SYM_TYPES]))
 		goto bad;
 
+	switch (type->flavor) {
+	case TYPE_TYPE:
+	case TYPE_ATTRIB:
+	case TYPE_ALIAS:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (type->flags) {
+	case 0:
+	case TYPE_FLAGS_PERMISSIVE:
+	case TYPE_FLAGS_EXPAND_ATTR_TRUE:
+	case TYPE_FLAGS_EXPAND_ATTR_FALSE:
+	case TYPE_FLAGS_EXPAND_ATTR:
+		break;
+	default:
+		goto bad;
+	}
+
 	return 0;
 
 bad:
@@ -688,6 +740,7 @@ static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, validate_t
 			if (validate_value(class->tclass, &flavors[SYM_CLASSES]))
 				goto bad;
 		}
+
 		switch(avrule->specified) {
 		case AVRULE_ALLOWED:
 		case AVRULE_AUDITALLOW:
@@ -705,6 +758,27 @@ static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, validate_t
 		default:
 			goto bad;
 		}
+
+		if (avrule->specified & AVRULE_XPERMS) {
+			if (!avrule->xperms)
+				goto bad;
+			switch (avrule->xperms->specified) {
+			case AVRULE_XPERMS_IOCTLFUNCTION:
+			case AVRULE_XPERMS_IOCTLDRIVER:
+				break;
+			default:
+				goto bad;
+			}
+		} else if (avrule->xperms)
+			goto bad;
+
+		switch(avrule->flags) {
+		case 0:
+		case RULE_SELF:
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	return 0;
@@ -1041,6 +1115,14 @@ static int validate_avrule_blocks(sepol_handle_t *handle, avrule_block_t *avrule
 			if (validate_symtabs(handle, decl->symtab, flavors))
 				goto bad;
 		}
+
+		switch (avrule_block->flags) {
+		case 0:
+		case AVRULE_OPTIONAL:
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	return 0;
-- 
2.34.1

