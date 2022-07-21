Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA0CCA48A
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiGUPFb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiGUPF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:05:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB59FFB
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m8so2513649edd.9
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YwBQH7wecA99fS23bg/tAycE9d7BB96fbZ1PFmxJwYk=;
        b=RMcTwk2+/dSxN7F99G9oWAJe9+03BciUrLaRBXn3UffEK7W1Kl9NPKWQytH4hx/X7I
         tIUqSZiZib74dIcpgRmgC2juPuSbj1zk7EoByJS7dxXs5TqBUTtyU2t/4K/+nt7PdlJt
         m8y8fUE+AnolRQ9k1YPlKBoMUt9WMR/B+bCPCpRO9fgUgchgOC5HZVi1BzYTlStHmHLQ
         fmW7qlH0fOUeVSa+9RcUcY6saHWjLpwfepYor9vd2xZ32JepY9ph6vnSCOHVV+9ox3oV
         x3+9TrAldmfwb8BBCISJf7SCEGfKipjNYoKT/dFsKWRmhPY7w8vBRRc1orVarxh94ini
         WFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwBQH7wecA99fS23bg/tAycE9d7BB96fbZ1PFmxJwYk=;
        b=F9qLI68RUwW0LoQihF5VB8cxpcrbC7/q73xL57O/OG5IFcO706DWJGP9fvIKksNljn
         +KJl8dfPaBJPv2/zBeADe57Rw8HMsvDkrCHoUXP/uSH0mChSXaNZl+AaFBlNdypR8OXt
         nQ5jfpvJSw+z3kvkQxNw8Tu3+yrhq1P6ePi+tCsOnrJ94sRJM8z/JjTcIEKwWqYP80xb
         ux4FjqmLlkYHJBou1S+BWMlqhbcoQZ+VJO31UTZSlx7rLKfiq+J++c7zREyFGjMEODhW
         F2y+cg+7Ag5pLlO1S8qHphdMIh9NQJYQe/anVCrG/0g1CzUjiIGyDOKXJqN6Sm0Kcvz3
         ehWw==
X-Gm-Message-State: AJIora/mJJ1vSscNrLLci7ovlhdVtJVxVt/rPVFTiMlyVX97tdljuGyT
        9fpNSwh5+La+EKtXxvxElZcxSftBaKHIJQ==
X-Google-Smtp-Source: AGRyM1vaO8xVbDZi/6w0Ng4JnW1U+1IlCW8jTwBwtnimTrEZSg+OJlil6PzyAPb8diiEZnqQDoe2rg==
X-Received: by 2002:a05:6402:510e:b0:43a:c671:7cd0 with SMTP id m14-20020a056402510e00b0043ac6717cd0mr57904188edd.103.1658415924802;
        Thu, 21 Jul 2022 08:05:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0043a1255bc68sm1120992edr.94.2022.07.21.08.05.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 4/8] checkpolicy: add front-end support for segregate attributes
Date:   Thu, 21 Jul 2022 17:05:11 +0200
Message-Id: <20220721150515.19843-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
References: <20220721150515.19843-1-cgzones@googlemail.com>
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
 checkpolicy/policy_define.c | 66 +++++++++++++++++++++++++++++++++++++
 checkpolicy/policy_define.h |  1 +
 checkpolicy/policy_parse.y  |  5 +++
 checkpolicy/policy_scan.l   |  2 ++
 4 files changed, 74 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 8bf36859..cf6fbf08 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1220,6 +1220,72 @@ exit:
 	return rc;
 }
 
+int define_segregate_attributes(void)
+{
+	char *id = NULL;
+	segregate_attributes_rule_t *sattr = NULL;
+	int rc = -1;
+
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}
+
+	sattr = malloc(sizeof(segregate_attributes_rule_t));
+	if (!sattr) {
+		yyerror("Out of memory!");
+		goto exit;
+	}
+
+	ebitmap_init(&sattr->attrs);
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

