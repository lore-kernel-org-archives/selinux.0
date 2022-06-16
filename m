Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA36CC433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiFPNOU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376938AbiFPNOR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 09:14:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E926AEA
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn20so2145645edb.6
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gLONVdGYOb35y+62hTaYz+Ej29o7Qj4Q6LBLaJU8b/E=;
        b=dufuDBwNNuUkrfyNKq6T+culdR6eoJ0Eu9K4Uw0Ke0PWAqCaGXZ/MY3zB2nHw4FrtH
         ujaWvZ03sq7hnk68NexM2gWRt8zdnMNZbWYU50ph8Tn2NoMFfv2WBYM1pXAirt4g/qcF
         THggL1DVpW7rWFfNn9Hui9np1AS3BzYwh3VJmkXbSdaxs+uWogV4alhWUD72/L0c2X1N
         UnxornkIMj+C73GWhk4h41kVbCZ/JIZzT/886AtWf+kOaVWYZOH9aYNhhMkV+OFNl3B7
         ZiGVPBGAIS54T/yXnhx9qbK1RSK00iEsXLHsIu4P/whEUlUF6UvzDGuBm/XGXnQEn1tU
         ipUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLONVdGYOb35y+62hTaYz+Ej29o7Qj4Q6LBLaJU8b/E=;
        b=MlX+uGTxmqU2DTeQvHAFgFw8W0f+n1Y78i+x9ZeKy83PPxYIlU11yHVwQ59vRUA+QB
         hCJZpA+mCbIbwRTFJMEtitwvzbrQk3EIxOJ6otXD/GBISP/kpl2gvCtmEU2wTEq5pLeR
         OAJzT2ewZXFjd7Xbnsh0REkJR3ZmJhQsAwCXFQpHOBJTpAu4vVcjwK8nqRgQ43m+r26I
         tr+DDMxbDKlJn/y1gMTtYx4d6bMsZjUDhjqVeGgsD1S4PqQ/gi7K9ji7LDCvplUqkDR4
         voykcKuJ3XjEZS3e0VUp5g7xmvCWrjGIelDJLV287XkVEX6En/LFMLHpbVGeR4wh53re
         x/1Q==
X-Gm-Message-State: AJIora9UQ1xxv60BB02Z/zDUVtHhxF26+buk5bcPFbu79/NS3wq+T2fm
        YAJeucK1eJHBRrfiwyqi9PaXhWjVNLDokg==
X-Google-Smtp-Source: AGRyM1sffoe4XYoZRFHZnA2hW6HxPp81x8QZv09Woc9Z9WTXNghPWyd7MVj0xeygqJGA0rqX4DHcgA==
X-Received: by 2002:a05:6402:f:b0:42e:561:a1c0 with SMTP id d15-20020a056402000f00b0042e0561a1c0mr6485181edu.309.1655385254801;
        Thu, 16 Jun 2022 06:14:14 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-158-068.77.8.pool.telefonica.de. [77.8.158.68])
        by smtp.gmail.com with ESMTPSA id y11-20020a056402270b00b0042e1cbc4471sm1831530edd.3.2022.06.16.06.14.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:14:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/4] checkpolicy: add front-end support for segregate attributes
Date:   Thu, 16 Jun 2022 15:14:09 +0200
Message-Id: <20220616131409.23271-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616131409.23271-1-cgzones@googlemail.com>
References: <20220616131409.23271-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support specifying segregate attributes.

The following two blocks are equivalent:

    segregate_attributes attr1, attr2, attr3;

    segregate_attributes attr1, attr2;
    segregate_attributes attr1, attr3;
    segregate_attributes attr2, attr3;

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 74 +++++++++++++++++++++++++++++++++++++
 checkpolicy/policy_define.h |  1 +
 checkpolicy/policy_parse.y  |  5 +++
 checkpolicy/policy_scan.l   |  2 +
 4 files changed, 82 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 8bf36859..faa8c00f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1220,6 +1220,80 @@ exit:
 	return rc;
 }
 
+int define_segregate_attributes(void)
+{
+	char *id = NULL;
+	segregate_attribute_t *sattr = NULL;
+	int rc = -1;
+
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}
+
+	sattr = malloc(sizeof(segregate_attribute_t));
+	if (!sattr) {
+		yyerror("Out of memory!");
+		goto exit;
+	}
+
+	ebitmap_init(&sattr->attrs);
+	sattr->line = policydb_lineno;
+	sattr->source_line = source_lineno;
+	sattr->source_filename = strdup(source_file);
+	if (!sattr->source_filename) {
+		yyerror("Out of memory!");
+		goto exit;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+		const type_datum_t *attr;
+
+		if (!is_id_in_scope(SYM_TYPES, id)) {
+			yyerror2("attribute %s is not within scope", id);
+			goto exit;
+		}
+
+		attr = hashtab_search(policydbp->p_types.table, id);
+		if (!attr) {
+			yyerror2("attribute %s is not declared", id);
+			goto exit;
+		}
+
+		if (attr->flavor != TYPE_ATTRIB) {
+			yyerror2("%s is a type, not an attribute", id);
+			goto exit;
+		}
+
+		if (ebitmap_get_bit(&sattr->attrs, attr->s.value - 1)) {
+			yyerror2("attribute %s used multiple times", id);
+			goto exit;
+		}
+
+		if (ebitmap_set_bit(&sattr->attrs, attr->s.value - 1, TRUE)) {
+			yyerror("Out of memory!");
+			goto exit;
+		}
+
+		free(id);
+	}
+
+	sattr->next = policydbp->segregate_attributes;
+	policydbp->segregate_attributes = sattr;
+
+	sattr = NULL;
+	rc = 0;
+exit:
+	if (sattr) {
+		free(sattr->source_filename);
+		ebitmap_destroy(&sattr->attrs);
+		free(sattr);
+	}
+	free(id);
+	return rc;
+}
+
 static int add_aliases_to_type(type_datum_t * type)
 {
 	char *id;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 50a7ba78..f55d0b17 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -68,6 +68,7 @@ int define_type(int alias);
 int define_user(void);
 int define_validatetrans(constraint_expr_t *expr);
 int expand_attrib(void);
+int define_segregate_attributes(void);
 int insert_id(const char *id,int push);
 int insert_separator(int push);
 role_datum_t *define_role_dom(role_datum_t *r);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 45f973ff..acd6096d 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -104,6 +104,7 @@ typedef int (* require_func_t)(int pass);
 %token ALIAS
 %token ATTRIBUTE
 %token EXPANDATTRIBUTE
+%token SEGREGATEATTRIBUTES
 %token BOOL
 %token TUNABLE
 %token IF
@@ -320,6 +321,7 @@ rbac_decl		: attribute_role_def
 			;
 te_decl			: attribute_def
                         | expandattribute_def
+                        | segregateattributes_def
                         | type_def
                         | typealias_def
                         | typeattribute_def
@@ -337,6 +339,9 @@ attribute_def           : ATTRIBUTE identifier ';'
 expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
                         { if (expand_attrib()) return -1;}
                         ;
+segregateattributes_def : SEGREGATEATTRIBUTES identifier ',' id_comma_list ';'
+                        { if (define_segregate_attributes()) return -1;}
+                        ;
 type_def		: TYPE identifier alias_def opt_attr_list ';'
                         {if (define_type(1)) return -1;}
 	                | TYPE identifier opt_attr_list ';'
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 9fefea7b..d865dcb6 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -123,6 +123,8 @@ ATTRIBUTE |
 attribute			{ return(ATTRIBUTE); }
 EXPANDATTRIBUTE |
 expandattribute                 { return(EXPANDATTRIBUTE); }
+SEGREGATE_ATTRIBUTES |
+segregate_attributes		{ return(SEGREGATEATTRIBUTES); }
 TYPE_TRANSITION |
 type_transition			{ return(TYPE_TRANSITION); }
 TYPE_MEMBER |
-- 
2.36.1

