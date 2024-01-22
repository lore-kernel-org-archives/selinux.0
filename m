Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940943D0C6
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931722; cv=none; b=AWyL+VLnJRCO9LLLpwIsztjlOJCa6oz+rEIeJGd6ux7USoVNaPoVJiTg4s0Gdv769RLH+ISBKxTefk/Xk/kdNteUg16tg4iHNYfr96aSmt5gcrK2ZxkESwHwdmtru8Pltk77eYLx+gifVbV2qX3rl3/+MWAmyiJKXgXBU6P2Rik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931722; c=relaxed/simple;
	bh=vc3pJlRXg1DTzid6a+bpZ2t+WT8r9WGGzeDvTAVBeu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFDxQHuN+0pT10DTRGbwvEVAEdxhMYvSWlwUlCfDUhEMy25PUasbP+TslwhoCyYYHGtIDzGcoyWzxT0cugjsHrt1wdAQvIRiraZL1X7q1Tk0TwGWNPqbJSB3FVJs0TkeQzHx9Jo8lZBa4Jg2/466M/ekTERg9SnYJ6QdPWmIWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hBeMtGoU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hBeMtGoU"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28da6285c1so559836366b.0
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931718; x=1706536518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/6oQYNWVMXjhXZlmL8NNLyR2hCD/B/c4mzbwlbF/eQ=;
        b=hBeMtGoUfnmp15K5UoZpkKNjxTJ8Qsj7Z46DTSlOEuH6hY+O1I+q3cMdgBYeiNRO0Q
         EhHA5ojauZybydXkZEVFLaNGSacjo925idYL1n/+8xlaQiwzPGBbrt/H2QK8CoIpW4/9
         sbng1e1s5vELQS2pFx5FjPnJuSreeAy0+q1wtQA4Xwt7TCwaiS5jeyGh2JueHuo+B5jn
         Y6OYpqNrQQmZ4KIU9SvwFoezRvcs7njUikNhZhl/C1XICmtRue745C2wg1NtTnnXU+dp
         qGQ2t2T5NoVTneMOHkOkJeyg1fo/iJf3PCMKB/okBjhPpUHej95rUrwVsoy4SfHjRQkZ
         6U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931718; x=1706536518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/6oQYNWVMXjhXZlmL8NNLyR2hCD/B/c4mzbwlbF/eQ=;
        b=guoK3WW+Gsv1jFVbMDAc8unzT7fvgsjbBCJuPmAZEqfK7ImCSs/Vfit4NpNPaZ62ge
         3Q8kaSjImMEGWcaCaeFw2daln4Cx4Oh5ReIyyftYIl+PRw4qt50+iFygoPT87oTdp5RG
         /aN6Wvh9Jnm0NmJMgyHXUwEin3gw7e8mMTUUNGnv/BIQRT087KrmHINdayg8OWmiDiJm
         oU3s/eW7amEN8rRvzcZ7wvu1k3St0h+Xroty3QaqcwyC59jqARvndJ5y1xelJX2lCsGz
         qcxnAkhrnfCW0ltORfwl4gHOzCa0ZtxvfVlGOVio8Ni+EoMHTjEChUlkVQqQF9E92xms
         e1fg==
X-Gm-Message-State: AOJu0Yy6MSWRgMyS4z64RNvMMxoCvhYB9zOO/36kZlimKtXF1f6TIwi4
	+AyVI8b/5mIEkID86xYpHcQuDBGNvtqN0UqVHhM74WFbZ6f3DJ9lqhvA+8zQ
X-Google-Smtp-Source: AGHT+IGrDTZRxxCAubYeXwY3Hex+G7J4HdkhTG5O2vFbzgL4cHXbR8uW7IzR71P947sZfVrqhpsf0A==
X-Received: by 2002:a17:906:68cf:b0:a2d:a38c:7b7f with SMTP id y15-20020a17090668cf00b00a2da38c7b7fmr4992250ejr.19.1705931717470;
        Mon, 22 Jan 2024 05:55:17 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:17 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 07/15] checkpolicy: call YYABORT on parse errors
Date: Mon, 22 Jan 2024 14:54:59 +0100
Message-ID: <20240122135507.63506-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Calling the parser macro YYABORT allows the parser to cleanup up any
allocated resources before returning.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_parse.y | 400 ++++++++++++++++++-------------------
 1 file changed, 200 insertions(+), 200 deletions(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 356626e2..f5025f28 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -163,26 +163,26 @@ typedef int (* require_func_t)(int pass);
 policy			: base_policy
                         | module_policy
                         ;
-base_policy             : { if (define_policy(pass, 0) == -1) return -1; }
+base_policy             : { if (define_policy(pass, 0) == -1) YYABORT; }
                           classes initial_sids access_vectors
-                          { if (pass == 1) { if (policydb_index_classes(policydbp)) return -1; }
-                            else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1; }}
+                          { if (pass == 1) { if (policydb_index_classes(policydbp)) YYABORT; }
+                            else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) YYABORT; }}
 			  opt_default_rules opt_mls te_rbac users opt_constraints 
-                         { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
-			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1;}}
+                         { if (pass == 1) { if (policydb_index_bools(policydbp)) YYABORT; }
+			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) YYABORT; }}
 			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts opt_ibendport_contexts
 			;
 classes			: class_def 
 			| classes class_def
 			;
 class_def		: CLASS identifier
-			{if (define_class()) return -1;}
+			{if (define_class()) YYABORT;}
 			;
 initial_sids 		: initial_sid_def 
 			| initial_sids initial_sid_def
 			;
 initial_sid_def		: SID identifier
-                        {if (define_initial_sid()) return -1;}
+                        {if (define_initial_sid()) YYABORT;}
 			;
 access_vectors		: opt_common_perms av_perms
 			;
@@ -193,17 +193,17 @@ common_perms		: common_perms_def
 			| common_perms common_perms_def
 			;
 common_perms_def	: COMMON identifier '{' identifier_list '}'
-			{if (define_common_perms()) return -1;}
+			{if (define_common_perms()) YYABORT;}
 			;
 av_perms		: av_perms_def
 			| av_perms av_perms_def
 			;
 av_perms_def		: CLASS identifier '{' identifier_list '}'
-			{if (define_av_perms(FALSE)) return -1;}
+			{if (define_av_perms(FALSE)) YYABORT;}
                         | CLASS identifier INHERITS identifier 
-			{if (define_av_perms(TRUE)) return -1;}
+			{if (define_av_perms(TRUE)) YYABORT;}
                         | CLASS identifier INHERITS identifier '{' identifier_list '}'
-			{if (define_av_perms(TRUE)) return -1;}
+			{if (define_av_perms(TRUE)) YYABORT;}
 			;
 opt_default_rules	: default_rules
 			|
@@ -218,34 +218,34 @@ default_rules		: default_user_def
 			| default_rules default_range_def
 			;
 default_user_def	: DEFAULT_USER names SOURCE ';'
-			{if (define_default_user(DEFAULT_SOURCE)) return -1; }
+			{if (define_default_user(DEFAULT_SOURCE)) YYABORT; }
 			| DEFAULT_USER names TARGET ';'
-			{if (define_default_user(DEFAULT_TARGET)) return -1; }
+			{if (define_default_user(DEFAULT_TARGET)) YYABORT; }
 			;
 default_role_def	: DEFAULT_ROLE names SOURCE ';'
-			{if (define_default_role(DEFAULT_SOURCE)) return -1; }
+			{if (define_default_role(DEFAULT_SOURCE)) YYABORT; }
 			| DEFAULT_ROLE names TARGET ';'
-			{if (define_default_role(DEFAULT_TARGET)) return -1; }
+			{if (define_default_role(DEFAULT_TARGET)) YYABORT; }
 			;
 default_type_def	: DEFAULT_TYPE names SOURCE ';'
-			{if (define_default_type(DEFAULT_SOURCE)) return -1; }
+			{if (define_default_type(DEFAULT_SOURCE)) YYABORT;; }
 			| DEFAULT_TYPE names TARGET ';'
-			{if (define_default_type(DEFAULT_TARGET)) return -1; }
+			{if (define_default_type(DEFAULT_TARGET)) YYABORT; }
 			;
 default_range_def	: DEFAULT_RANGE names SOURCE LOW ';'
-			{if (define_default_range(DEFAULT_SOURCE_LOW)) return -1; }
+			{if (define_default_range(DEFAULT_SOURCE_LOW)) YYABORT; }
 			| DEFAULT_RANGE names SOURCE HIGH ';'
-			{if (define_default_range(DEFAULT_SOURCE_HIGH)) return -1; }
+			{if (define_default_range(DEFAULT_SOURCE_HIGH)) YYABORT; }
 			| DEFAULT_RANGE names SOURCE LOW_HIGH ';'
-			{if (define_default_range(DEFAULT_SOURCE_LOW_HIGH)) return -1; }
+			{if (define_default_range(DEFAULT_SOURCE_LOW_HIGH)) YYABORT; }
 			| DEFAULT_RANGE names TARGET LOW ';'
-			{if (define_default_range(DEFAULT_TARGET_LOW)) return -1; }
+			{if (define_default_range(DEFAULT_TARGET_LOW)) YYABORT; }
 			| DEFAULT_RANGE names TARGET HIGH ';'
-			{if (define_default_range(DEFAULT_TARGET_HIGH)) return -1; }
+			{if (define_default_range(DEFAULT_TARGET_HIGH)) YYABORT; }
 			| DEFAULT_RANGE names TARGET LOW_HIGH ';'
-			{if (define_default_range(DEFAULT_TARGET_LOW_HIGH)) return -1; }
+			{if (define_default_range(DEFAULT_TARGET_LOW_HIGH)) YYABORT; }
 			| DEFAULT_RANGE names GLBLUB';'
-			{if (define_default_range(DEFAULT_GLBLUB)) return -1; }
+			{if (define_default_range(DEFAULT_GLBLUB)) YYABORT; }
 			;
 opt_mls			: mls
                         | 
@@ -256,16 +256,16 @@ sensitivities	 	: sensitivity_def
 			| sensitivities sensitivity_def
 			;
 sensitivity_def		: SENSITIVITY identifier alias_def ';'
-			{if (define_sens()) return -1;}
+			{if (define_sens()) YYABORT;}
 			| SENSITIVITY identifier ';'
-			{if (define_sens()) return -1;}
+			{if (define_sens()) YYABORT;}
 	                ;
 alias_def		: ALIAS names
 			;
 dominance		: DOMINANCE identifier 
-			{if (define_dominance()) return -1;}
+			{if (define_dominance()) YYABORT;}
                         | DOMINANCE '{' identifier_list '}' 
-			{if (define_dominance()) return -1;}
+			{if (define_dominance()) YYABORT;}
 			;
 opt_categories          : categories
                         |
@@ -274,17 +274,17 @@ categories 		: category_def
 			| categories category_def
 			;
 category_def		: CATEGORY identifier alias_def ';'
-			{if (define_category()) return -1;}
+			{if (define_category()) YYABORT;}
 			| CATEGORY identifier ';'
-			{if (define_category()) return -1;}
+			{if (define_category()) YYABORT;}
 			;
 levels	 		: level_def 
 			| levels level_def
 			;
 level_def		: LEVEL identifier ':' id_comma_list ';'
-			{if (define_level()) return -1;}
+			{if (define_level()) YYABORT;}
 			| LEVEL identifier ';' 
-			{if (define_level()) return -1;}
+			{if (define_level()) YYABORT;}
 			;
 mlspolicy		: mlspolicy_decl
 			| mlspolicy mlspolicy_decl
@@ -293,10 +293,10 @@ mlspolicy_decl		: mlsconstraint_def
 			| mlsvalidatetrans_def
 			;
 mlsconstraint_def	: MLSCONSTRAIN names names cexpr ';'
-			{ if (define_constraint((constraint_expr_t*)$4)) return -1; }
+			{ if (define_constraint((constraint_expr_t*)$4)) YYABORT; }
 			;
 mlsvalidatetrans_def	: MLSVALIDATETRANS names cexpr ';'
-			{ if (define_validatetrans((constraint_expr_t*)$3)) return -1; }
+			{ if (define_validatetrans((constraint_expr_t*)$3)) YYABORT; }
 			;
 te_rbac			: te_rbac_decl
 			| te_rbac te_rbac_decl
@@ -329,41 +329,41 @@ te_decl			: attribute_def
 			| permissive_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
-                        { if (define_attrib()) return -1;}
+                        { if (define_attrib()) YYABORT;}
                         ;
 expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
-                        { if (expand_attrib()) return -1;}
+                        { if (expand_attrib()) YYABORT;}
                         ;
 type_def		: TYPE identifier alias_def opt_attr_list ';'
-                        {if (define_type(1)) return -1;}
+                        {if (define_type(1)) YYABORT;}
 	                | TYPE identifier opt_attr_list ';'
-                        {if (define_type(0)) return -1;}
+                        {if (define_type(0)) YYABORT;}
     			;
 typealias_def           : TYPEALIAS identifier alias_def ';'
-			{if (define_typealias()) return -1;}
+			{if (define_typealias()) YYABORT;}
 			;
 typeattribute_def	: TYPEATTRIBUTE identifier id_comma_list ';'
-			{if (define_typeattribute()) return -1;}
+			{if (define_typeattribute()) YYABORT;}
 			;
 typebounds_def          : TYPEBOUNDS identifier id_comma_list ';'
-                        {if (define_typebounds()) return -1;}
+                        {if (define_typebounds()) YYABORT;}
                         ;
 opt_attr_list           : ',' id_comma_list
 			| 
 			;
 bool_def                : BOOL identifier bool_val ';'
-                        { if (define_bool_tunable(0)) return -1; }
+                        { if (define_bool_tunable(0)) YYABORT; }
                         ;
 tunable_def		: TUNABLE identifier bool_val ';'
-			{ if (define_bool_tunable(1)) return -1; }
+			{ if (define_bool_tunable(1)) YYABORT; }
 			;
 bool_val                : CTRUE
- 			{ if (insert_id("T",0)) return -1; }
+ 			{ if (insert_id("T",0)) YYABORT; }
                         | CFALSE
-			{ if (insert_id("F",0)) return -1; }
+			{ if (insert_id("F",0)) YYABORT; }
                         ;
 cond_stmt_def           : IF cond_expr '{' cond_pol_list '}' cond_else
-                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2, (avrule_t*)$4, (avrule_t*)$6) < 0) return -1;  }}
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2, (avrule_t*)$4, (avrule_t*)$6) < 0) YYABORT;  }}
                         ;
 cond_else		: ELSE '{' cond_pol_list '}'
 			{ $$ = $3; }
@@ -374,28 +374,28 @@ cond_expr               : '(' cond_expr ')'
 			{ $$ = $2;}
 			| NOT cond_expr
 			{ $$ = define_cond_expr(COND_NOT, $2, 0);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| cond_expr AND cond_expr
 			{ $$ = define_cond_expr(COND_AND, $1, $3);
-			  if ($$ == 0) return  -1; }
+			  if ($$ == 0) YYABORT; }
 			| cond_expr OR cond_expr
 			{ $$ = define_cond_expr(COND_OR, $1, $3);
-			  if ($$ == 0) return   -1; }
+			  if ($$ == 0) YYABORT; }
 			| cond_expr XOR cond_expr
 			{ $$ = define_cond_expr(COND_XOR, $1, $3);
-			  if ($$ == 0) return  -1; }
+			  if ($$ == 0) YYABORT; }
 			| cond_expr EQUALS cond_expr
 			{ $$ = define_cond_expr(COND_EQ, $1, $3);
-			  if ($$ == 0) return  -1; }
+			  if ($$ == 0) YYABORT; }
 			| cond_expr NOTEQUAL cond_expr
 			{ $$ = define_cond_expr(COND_NEQ, $1, $3);
-			  if ($$ == 0) return  -1; }
+			  if ($$ == 0) YYABORT; }
 			| cond_expr_prim
 			{ $$ = $1; }
 			;
 cond_expr_prim          : identifier
                         { $$ = define_cond_expr(COND_BOOL,0, 0);
-			  if ($$ == COND_ERR) return   -1; }
+			  if ($$ == COND_ERR) YYABORT; }
                         ;
 cond_pol_list           : cond_pol_list cond_rule_def 
                         { $$ = define_cond_pol_list((avrule_t *)$1, (avrule_t *)$2); }
@@ -411,16 +411,16 @@ cond_rule_def           : cond_transition_def
                         ;
 cond_transition_def	: TYPE_TRANSITION names names ':' names identifier filename ';'
                         { $$ = define_cond_filename_trans() ;
-                          if ($$ == COND_ERR) return -1;}
+                          if ($$ == COND_ERR) YYABORT;}
 			| TYPE_TRANSITION names names ':' names identifier ';'
                         { $$ = define_cond_compute_type(AVRULE_TRANSITION) ;
-                          if ($$ == COND_ERR) return -1;}
+                          if ($$ == COND_ERR) YYABORT;}
                         | TYPE_MEMBER names names ':' names identifier ';'
                         { $$ = define_cond_compute_type(AVRULE_MEMBER) ;
-                          if ($$ ==  COND_ERR) return -1;}
+                          if ($$ ==  COND_ERR) YYABORT;}
                         | TYPE_CHANGE names names ':' names identifier ';'
                         { $$ = define_cond_compute_type(AVRULE_CHANGE) ;
-                          if ($$ == COND_ERR) return -1;}
+                          if ($$ == COND_ERR) YYABORT;}
     			;
 cond_te_avtab_def	: cond_allow_def
                           { $$ = $1; }
@@ -433,34 +433,34 @@ cond_te_avtab_def	: cond_allow_def
 			;
 cond_allow_def		: ALLOW names names ':' names names  ';'
 			{ $$ = define_cond_te_avtab(AVRULE_ALLOWED) ;
-                          if ($$ == COND_ERR) return -1; }
+                          if ($$ == COND_ERR) YYABORT; }
 		        ;
 cond_auditallow_def	: AUDITALLOW names names ':' names names ';'
 			{ $$ = define_cond_te_avtab(AVRULE_AUDITALLOW) ;
-                          if ($$ == COND_ERR) return -1; }
+                          if ($$ == COND_ERR) YYABORT; }
 		        ;
 cond_auditdeny_def	: AUDITDENY names names ':' names names ';'
 			{ $$ = define_cond_te_avtab(AVRULE_AUDITDENY) ;
-                          if ($$ == COND_ERR) return -1; }
+                          if ($$ == COND_ERR) YYABORT; }
 		        ;
 cond_dontaudit_def	: DONTAUDIT names names ':' names names ';'
 			{ $$ = define_cond_te_avtab(AVRULE_DONTAUDIT);
-                          if ($$ == COND_ERR) return -1; }
+                          if ($$ == COND_ERR) YYABORT; }
 		        ;
 			;
 transition_def		: TYPE_TRANSITION  names names ':' names identifier filename ';'
-			{if (define_filename_trans()) return -1; }
+			{if (define_filename_trans()) YYABORT; }
 			| TYPE_TRANSITION names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_TRANSITION)) return -1;}
+                        {if (define_compute_type(AVRULE_TRANSITION)) YYABORT;}
                         | TYPE_MEMBER names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_MEMBER)) return -1;}
+                        {if (define_compute_type(AVRULE_MEMBER)) YYABORT;}
                         | TYPE_CHANGE names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_CHANGE)) return -1;}
+                        {if (define_compute_type(AVRULE_CHANGE)) YYABORT;}
     			;
 range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
-			{ if (define_range_trans(0)) return -1; }
+			{ if (define_range_trans(0)) YYABORT; }
 			| RANGE_TRANSITION names names ':' names mls_range_def ';'
-			{ if (define_range_trans(1)) return -1; }
+			{ if (define_range_trans(1)) YYABORT; }
 			;
 te_avtab_def		: allow_def
 			| auditallow_def
@@ -473,51 +473,51 @@ te_avtab_def		: allow_def
 			| xperm_neverallow_def
 			;
 allow_def		: ALLOW names names ':' names names  ';'
-			{if (define_te_avtab(AVRULE_ALLOWED)) return -1; }
+			{if (define_te_avtab(AVRULE_ALLOWED)) YYABORT; }
 		        ;
 auditallow_def		: AUDITALLOW names names ':' names names ';'
-			{if (define_te_avtab(AVRULE_AUDITALLOW)) return -1; }
+			{if (define_te_avtab(AVRULE_AUDITALLOW)) YYABORT; }
 		        ;
 auditdeny_def		: AUDITDENY names names ':' names names ';'
-			{if (define_te_avtab(AVRULE_AUDITDENY)) return -1; }
+			{if (define_te_avtab(AVRULE_AUDITDENY)) YYABORT; }
 		        ;
 dontaudit_def		: DONTAUDIT names names ':' names names ';'
-			{if (define_te_avtab(AVRULE_DONTAUDIT)) return -1; }
+			{if (define_te_avtab(AVRULE_DONTAUDIT)) YYABORT; }
 		        ;
 neverallow_def		: NEVERALLOW names names ':' names names  ';'
-			{if (define_te_avtab(AVRULE_NEVERALLOW)) return -1; }
+			{if (define_te_avtab(AVRULE_NEVERALLOW)) YYABORT; }
 		        ;
 xperm_allow_def		: ALLOWXPERM names names ':' names identifier xperms ';'
-			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_ALLOWED)) return -1; }
+			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_ALLOWED)) YYABORT; }
 		        ;
 xperm_auditallow_def	: AUDITALLOWXPERM names names ':' names identifier xperms ';'
-			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_AUDITALLOW)) return -1; }
+			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_AUDITALLOW)) YYABORT; }
 		        ;
 xperm_dontaudit_def	: DONTAUDITXPERM names names ':' names identifier xperms ';'
-			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_DONTAUDIT)) return -1; }
+			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_DONTAUDIT)) YYABORT; }
 		        ;
 xperm_neverallow_def	: NEVERALLOWXPERM names names ':' names identifier xperms ';'
-			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_NEVERALLOW)) return -1; }
+			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_NEVERALLOW)) YYABORT; }
 		        ;
 attribute_role_def	: ATTRIBUTE_ROLE identifier ';'
-			{if (define_attrib_role()) return -1; }
+			{if (define_attrib_role()) YYABORT; }
 		        ;
 role_type_def		: ROLE identifier TYPES names ';'
-			{if (define_role_types()) return -1;}
+			{if (define_role_types()) YYABORT;}
 			;
 role_attr_def		: ROLE identifier opt_attr_list ';'
- 			{if (define_role_attr()) return -1;}
+ 			{if (define_role_attr()) YYABORT;}
                         ;
 role_trans_def		: ROLE_TRANSITION names names identifier ';'
-			{if (define_role_trans(0)) return -1; }
+			{if (define_role_trans(0)) YYABORT; }
 			| ROLE_TRANSITION names names ':' names identifier ';'
-			{if (define_role_trans(1)) return -1;}
+			{if (define_role_trans(1)) YYABORT;}
 			;
 role_allow_def		: ALLOW names names ';'
-			{if (define_role_allow()) return -1; }
+			{if (define_role_allow()) YYABORT; }
 			;
 roleattribute_def	: ROLEATTRIBUTE identifier id_comma_list ';'
-			{if (define_roleattribute()) return -1;}
+			{if (define_roleattribute()) YYABORT;}
 			;
 opt_constraints         : constraints
                         |
@@ -529,97 +529,97 @@ constraint_decl		: constraint_def
 			| validatetrans_def
 			;
 constraint_def		: CONSTRAIN names names cexpr ';'
-			{ if (define_constraint((constraint_expr_t*)$4)) return -1; }
+			{ if (define_constraint((constraint_expr_t*)$4)) YYABORT; }
 			;
 validatetrans_def	: VALIDATETRANS names cexpr ';'
-			{ if (define_validatetrans((constraint_expr_t*)$3)) return -1; }
+			{ if (define_validatetrans((constraint_expr_t*)$3)) YYABORT; }
 			;
 cexpr			: '(' cexpr ')'
 			{ $$ = $2; }
 			| NOT cexpr
 			{ $$ = define_cexpr(CEXPR_NOT, $2, 0);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| cexpr AND cexpr
 			{ $$ = define_cexpr(CEXPR_AND, $1, $3);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| cexpr OR cexpr
 			{ $$ = define_cexpr(CEXPR_OR, $1, $3);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| cexpr_prim
 			{ $$ = $1; }
 			;
 cexpr_prim		: U1 op U2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| R1 role_mls_op R2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| T1 op T2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $2);
-			  if ($$ == 0) return -1; }
-			| U1 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| U1 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_USER, $2);
-			  if ($$ == 0) return -1; }
-			| U2 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| U2 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_TARGET), $2);
-			  if ($$ == 0) return -1; }
-			| U3 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| U3 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_XTARGET), $2);
-			  if ($$ == 0) return -1; }
-			| R1 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| R1 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, $2);
-			  if ($$ == 0) return -1; }
-			| R2 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| R2 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), $2);
-			  if ($$ == 0) return -1; }
-			| R3 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| R3 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_XTARGET), $2);
-			  if ($$ == 0) return -1; }
-			| T1 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| T1 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, $2);
-			  if ($$ == 0) return -1; }
-			| T2 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| T2 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), $2);
-			  if ($$ == 0) return -1; }
-			| T3 op { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| T3 op { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_XTARGET), $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| SAMEUSER
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, CEXPR_EQ);
-			  if ($$ == 0) return -1; }
-			| SOURCE ROLE { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| SOURCE ROLE { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, CEXPR_EQ);
-			  if ($$ == 0) return -1; }
-			| TARGET ROLE { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| TARGET ROLE { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), CEXPR_EQ);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| ROLE role_mls_op
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
-			  if ($$ == 0) return -1; }
-			| SOURCE TYPE { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| SOURCE TYPE { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, CEXPR_EQ);
-			  if ($$ == 0) return -1; }
-			| TARGET TYPE { if (insert_separator(1)) return -1; } names_push
+			  if ($$ == 0) YYABORT; }
+			| TARGET TYPE { if (insert_separator(1)) YYABORT; } names_push
 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), CEXPR_EQ);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| L1 role_mls_op L2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L1L2, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| L1 role_mls_op H2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L1H2, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| H1 role_mls_op L2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_H1L2, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| H1 role_mls_op H2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_H1H2, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| L1 role_mls_op H1
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L1H1, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			| L2 role_mls_op H2
 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_L2H2, $2);
-			  if ($$ == 0) return -1; }
+			  if ($$ == 0) YYABORT; }
 			;
 op			: EQUALS
 			{ $$ = CEXPR_EQ; }
@@ -639,7 +639,7 @@ users			: user_def
 			| users user_def
 			;
 user_def		: USER identifier ROLES names opt_mls_user ';'
-	                {if (define_user()) return -1;}
+	                {if (define_user()) YYABORT;}
 			;
 opt_mls_user		: LEVEL mls_level_def RANGE mls_range_def
 			|
@@ -648,7 +648,7 @@ initial_sid_contexts	: initial_sid_context_def
 			| initial_sid_contexts initial_sid_context_def
 			;
 initial_sid_context_def	: SID identifier security_context_def
-			{if (define_initial_sid_context()) return -1;}
+			{if (define_initial_sid_context()) YYABORT;}
 			;
 opt_dev_contexts	: dev_contexts |
 			;
@@ -662,23 +662,23 @@ dev_context_def		: pirq_context_def |
 			  dtree_context_def
 			;
 pirq_context_def 	: PIRQCON number security_context_def
-		        {if (define_pirq_context($2)) return -1;}
+		        {if (define_pirq_context($2)) YYABORT;}
 		        ;
 iomem_context_def	: IOMEMCON number64 security_context_def
-		        {if (define_iomem_context($2,$2)) return -1;}
+		        {if (define_iomem_context($2,$2)) YYABORT;}
 		        | IOMEMCON number64 '-' number64 security_context_def
-		        {if (define_iomem_context($2,$4)) return -1;}
+		        {if (define_iomem_context($2,$4)) YYABORT;}
 		        ;
 ioport_context_def	: IOPORTCON number security_context_def
-			{if (define_ioport_context($2,$2)) return -1;}
+			{if (define_ioport_context($2,$2)) YYABORT;}
 			| IOPORTCON number '-' number security_context_def
-			{if (define_ioport_context($2,$4)) return -1;}
+			{if (define_ioport_context($2,$4)) YYABORT;}
 			;
 pci_context_def  	: PCIDEVICECON number security_context_def
-		        {if (define_pcidevice_context($2)) return -1;}
+		        {if (define_pcidevice_context($2)) YYABORT;}
 		        ;
 dtree_context_def	: DEVICETREECON path security_context_def
-		        {if (define_devicetree_context()) return -1;}
+		        {if (define_devicetree_context()) YYABORT;}
 		        ;
 opt_fs_contexts         : fs_contexts 
                         |
@@ -687,7 +687,7 @@ fs_contexts		: fs_context_def
 			| fs_contexts fs_context_def
 			;
 fs_context_def		: FSCON number number security_context_def security_context_def
-			{if (define_fs_context($2,$3)) return -1;}
+			{if (define_fs_context($2,$3)) YYABORT;}
 			;
 net_contexts		: opt_port_contexts opt_netif_contexts opt_node_contexts
 			;
@@ -698,9 +698,9 @@ port_contexts		: port_context_def
 			| port_contexts port_context_def
 			;
 port_context_def	: PORTCON identifier number security_context_def
-			{if (define_port_context($3,$3)) return -1;}
+			{if (define_port_context($3,$3)) YYABORT;}
 			| PORTCON identifier number '-' number security_context_def
-			{if (define_port_context($3,$5)) return -1;}
+			{if (define_port_context($3,$5)) YYABORT;}
 			;
 opt_ibpkey_contexts     : ibpkey_contexts
                         |
@@ -709,9 +709,9 @@ ibpkey_contexts		: ibpkey_context_def
 			| ibpkey_contexts ibpkey_context_def
 			;
 ibpkey_context_def	: IBPKEYCON ipv6_addr number security_context_def
-			{if (define_ibpkey_context($3,$3)) return -1;}
+			{if (define_ibpkey_context($3,$3)) YYABORT;}
 			| IBPKEYCON ipv6_addr number '-' number security_context_def
-			{if (define_ibpkey_context($3,$5)) return -1;}
+			{if (define_ibpkey_context($3,$5)) YYABORT;}
 			;
 opt_ibendport_contexts	: ibendport_contexts
 			|
@@ -720,7 +720,7 @@ ibendport_contexts	: ibendport_context_def
                         | ibendport_contexts ibendport_context_def
                         ;
 ibendport_context_def	: IBENDPORTCON identifier number security_context_def
-                        {if (define_ibendport_context($3)) return -1;}
+                        {if (define_ibendport_context($3)) YYABORT;}
                         ;
 opt_netif_contexts      : netif_contexts 
                         |
@@ -729,7 +729,7 @@ netif_contexts		: netif_context_def
 			| netif_contexts netif_context_def
 			;
 netif_context_def	: NETIFCON identifier security_context_def security_context_def
-			{if (define_netif_context()) return -1;} 
+			{if (define_netif_context()) YYABORT;}
 			;
 opt_node_contexts       : node_contexts 
                         |
@@ -738,9 +738,9 @@ node_contexts		: node_context_def
 			| node_contexts node_context_def
 			;
 node_context_def	: NODECON ipv4_addr_def ipv4_addr_def security_context_def
-			{if (define_ipv4_node_context()) return -1;}
+			{if (define_ipv4_node_context()) YYABORT;}
 			| NODECON ipv6_addr ipv6_addr security_context_def
-			{if (define_ipv6_node_context()) return -1;}
+			{if (define_ipv6_node_context()) YYABORT;}
 			;
 opt_fs_uses             : fs_uses
                         |
@@ -749,11 +749,11 @@ fs_uses                 : fs_use_def
                         | fs_uses fs_use_def
                         ;
 fs_use_def              : FSUSEXATTR filesystem security_context_def ';'
-                        {if (define_fs_use(SECURITY_FS_USE_XATTR)) return -1;}
+                        {if (define_fs_use(SECURITY_FS_USE_XATTR)) YYABORT;}
                         | FSUSETASK identifier security_context_def ';'
-                        {if (define_fs_use(SECURITY_FS_USE_TASK)) return -1;}
+                        {if (define_fs_use(SECURITY_FS_USE_TASK)) YYABORT;}
                         | FSUSETRANS identifier security_context_def ';'
-                        {if (define_fs_use(SECURITY_FS_USE_TRANS)) return -1;}
+                        {if (define_fs_use(SECURITY_FS_USE_TRANS)) YYABORT;}
                         ;
 opt_genfs_contexts      : genfs_contexts
                         |
@@ -762,36 +762,36 @@ genfs_contexts          : genfs_context_def
                         | genfs_contexts genfs_context_def
                         ;
 genfs_context_def	: GENFSCON filesystem path '-' identifier security_context_def
-			{if (define_genfs_context(1)) return -1;}
+			{if (define_genfs_context(1)) YYABORT;}
 			| GENFSCON filesystem path '-' '-' {insert_id("-", 0);} security_context_def
-			{if (define_genfs_context(1)) return -1;}
+			{if (define_genfs_context(1)) YYABORT;}
                         | GENFSCON filesystem path security_context_def
-			{if (define_genfs_context(0)) return -1;}
+			{if (define_genfs_context(0)) YYABORT;}
 			;
 ipv4_addr_def		: IPV4_ADDR
-			{ if (insert_id(yytext,0)) return -1; }
+			{ if (insert_id(yytext,0)) YYABORT; }
 			;
 xperms		: xperm
-			{ if (insert_separator(0)) return -1; }
+			{ if (insert_separator(0)) YYABORT; }
 			| nested_xperm_set
-			{ if (insert_separator(0)) return -1; }
+			{ if (insert_separator(0)) YYABORT; }
 			| tilde xperm
-                        { if (insert_id("~", 0)) return -1; }
+                        { if (insert_id("~", 0)) YYABORT; }
 			| tilde nested_xperm_set
-			{ if (insert_id("~", 0)) return -1;
-			  if (insert_separator(0)) return -1; }
+			{ if (insert_id("~", 0)) YYABORT;
+			  if (insert_separator(0)) YYABORT; }
 			;
 nested_xperm_set	: '{' nested_xperm_list '}'
 			;
 nested_xperm_list	: nested_xperm_element
 			| nested_xperm_list nested_xperm_element
 			;
-nested_xperm_element: xperm '-' { if (insert_id("-", 0)) return -1; } xperm
+nested_xperm_element: xperm '-' { if (insert_id("-", 0)) YYABORT; } xperm
 			| xperm
 			| nested_xperm_set
 			;
 xperm		: number
-                        { if (insert_id(yytext,0)) return -1; }
+                        { if (insert_id(yytext,0)) YYABORT; }
 			;
 security_context_def	: identifier ':' identifier ':' identifier opt_mls_range_def
 	                ;
@@ -799,14 +799,14 @@ opt_mls_range_def	: ':' mls_range_def
 			|	
 			;
 mls_range_def		: mls_level_def '-' mls_level_def
-			{if (insert_separator(0)) return -1;}
+			{if (insert_separator(0)) YYABORT;}
 	                | mls_level_def
-			{if (insert_separator(0)) return -1;}
+			{if (insert_separator(0)) YYABORT;}
 	                ;
 mls_level_def		: identifier ':' id_comma_list
-			{if (insert_separator(0)) return -1;}
+			{if (insert_separator(0)) YYABORT;}
 	                | identifier
-			{if (insert_separator(0)) return -1;}
+			{if (insert_separator(0)) YYABORT;}
 	                ;
 id_comma_list           : identifier
 			| id_comma_list ',' identifier
@@ -816,26 +816,26 @@ tilde			: '~'
 asterisk		: '*'
 			;
 names           	: identifier
-			{ if (insert_separator(0)) return -1; }
+			{ if (insert_separator(0)) YYABORT; }
 			| nested_id_set
-			{ if (insert_separator(0)) return -1; }
+			{ if (insert_separator(0)) YYABORT; }
 			| asterisk
-                        { if (insert_id("*", 0)) return -1; 
-			  if (insert_separator(0)) return -1; }
+                        { if (insert_id("*", 0)) YYABORT;
+			  if (insert_separator(0)) YYABORT; }
 			| tilde identifier
-                        { if (insert_id("~", 0)) return -1;
-			  if (insert_separator(0)) return -1; }
+                        { if (insert_id("~", 0)) YYABORT;
+			  if (insert_separator(0)) YYABORT; }
 			| tilde nested_id_set
-	 		{ if (insert_id("~", 0)) return -1; 
-			  if (insert_separator(0)) return -1; }
-                        | identifier '-' { if (insert_id("-", 0)) return -1; } identifier 
-			{ if (insert_separator(0)) return -1; }
+	 		{ if (insert_id("~", 0)) YYABORT;
+			  if (insert_separator(0)) YYABORT; }
+                        | identifier '-' { if (insert_id("-", 0)) YYABORT; } identifier
+			{ if (insert_separator(0)) YYABORT; }
 			;
 tilde_push              : tilde
-                        { if (insert_id("~", 1)) return -1; }
+                        { if (insert_id("~", 1)) YYABORT; }
 			;
 asterisk_push           : asterisk
-                        { if (insert_id("*", 1)) return -1; }
+                        { if (insert_id("*", 1)) YYABORT; }
 			;
 names_push		: identifier_push
 			| '{' identifier_list_push '}'
@@ -847,7 +847,7 @@ identifier_list_push	: identifier_push
 			| identifier_list_push identifier_push
 			;
 identifier_push		: IDENTIFIER
-			{ if (insert_id(yytext, 1)) return -1; }
+			{ if (insert_id(yytext, 1)) YYABORT; }
 			;
 identifier_list		: identifier
 			| identifier_list identifier
@@ -856,33 +856,33 @@ nested_id_set           : '{' nested_id_list '}'
                         ;
 nested_id_list          : nested_id_element | nested_id_list nested_id_element
                         ;
-nested_id_element       : identifier | '-' { if (insert_id("-", 0)) return -1; } identifier | nested_id_set
+nested_id_element       : identifier | '-' { if (insert_id("-", 0)) YYABORT; } identifier | nested_id_set
                         ;
 identifier		: IDENTIFIER
-			{ if (insert_id(yytext,0)) return -1; }
+			{ if (insert_id(yytext,0)) YYABORT; }
 			;
 filesystem		: FILESYSTEM
-                        { if (insert_id(yytext,0)) return -1; }
+                        { if (insert_id(yytext,0)) YYABORT; }
                         | IDENTIFIER
-			{ if (insert_id(yytext,0)) return -1; }
+			{ if (insert_id(yytext,0)) YYABORT; }
                         ;
 path     		: PATH
-			{ if (insert_id(yytext,0)) return -1; }
+			{ if (insert_id(yytext,0)) YYABORT; }
 			| QPATH
-			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) return -1; }
+			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) YYABORT; }
 			;
 filename		: FILENAME
-			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) return -1; }
+			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) YYABORT; }
 			;
 number			: NUMBER 
 			{ unsigned long x;
 			  errno = 0;
 			  x = strtoul(yytext, NULL, 0);
 			  if (errno)
-			      return -1;
+			      YYABORT;
 #if ULONG_MAX > UINT_MAX
 			  if (x > UINT_MAX)
-			      return -1;
+			      YYABORT;
 #endif
 			  $$ = (unsigned int) x;
 			}
@@ -892,33 +892,33 @@ number64		: NUMBER
 			  errno = 0;
 			  x = strtoull(yytext, NULL, 0);
 			  if (errno)
-			      return -1;
+			      YYABORT;
 			  $$ = (uint64_t) x;
 			}
 			;
 ipv6_addr		: IPV6_ADDR
-			{ if (insert_id(yytext,0)) return -1; }
+			{ if (insert_id(yytext,0)) YYABORT; }
 			;
 policycap_def		: POLICYCAP identifier ';'
-			{if (define_polcap()) return -1;}
+			{if (define_polcap()) YYABORT;}
 			;
 permissive_def		: PERMISSIVE identifier ';'
-			{if (define_permissive()) return -1;}
+			{if (define_permissive()) YYABORT;}
 
 /*********** module grammar below ***********/
 
 module_policy           : module_def avrules_block
-                        { if (end_avrule_block(pass) == -1) return -1;
-                          if (policydb_index_others(NULL, policydbp, 0)) return -1;
+                        { if (end_avrule_block(pass) == -1) YYABORT;
+                          if (policydb_index_others(NULL, policydbp, 0)) YYABORT;
                         }
                         ;
 module_def              : MODULE identifier version_identifier ';'
-                        { if (define_policy(pass, 1) == -1) return -1; }
+                        { if (define_policy(pass, 1) == -1) YYABORT; }
                         ;
 version_identifier      : VERSION_IDENTIFIER
-                        { if (insert_id(yytext,0)) return -1; }
+                        { if (insert_id(yytext,0)) YYABORT; }
 			| number
-                        { if (insert_id(yytext,0)) return -1; }
+                        { if (insert_id(yytext,0)) YYABORT; }
                         | ipv4_addr_def /* version can look like ipv4 address */
                         ;
 avrules_block           : avrule_decls avrule_user_defs
@@ -942,7 +942,7 @@ require_decl            : require_class ';'
                         | require_decl_def require_id_list ';'
                         ;
 require_class           : CLASS identifier names
-                        { if (require_class(pass)) return -1; }
+                        { if (require_class(pass)) YYABORT; }
                         ;
 require_decl_def        : ROLE        { $$ = require_role; }
                         | TYPE        { $$ = require_type; }
@@ -955,24 +955,24 @@ require_decl_def        : ROLE        { $$ = require_role; }
                         | CATEGORY    { $$ = require_cat; }
                         ;
 require_id_list         : identifier
-                        { if ($<require_func>0 (pass)) return -1; }
+                        { if ($<require_func>0 (pass)) YYABORT; }
                         | require_id_list ',' identifier
-                        { if ($<require_func>0 (pass)) return -1; }
+                        { if ($<require_func>0 (pass)) YYABORT; }
                         ;
 optional_block          : optional_decl '{' avrules_block '}'
-                        { if (end_avrule_block(pass) == -1) return -1; }
+                        { if (end_avrule_block(pass) == -1) YYABORT; }
                           optional_else
-                        { if (end_optional(pass) == -1) return -1; }
+                        { if (end_optional(pass) == -1) YYABORT; }
                         ;
 optional_else           : else_decl '{' avrules_block '}'
-                        { if (end_avrule_block(pass) == -1) return -1; }
+                        { if (end_avrule_block(pass) == -1) YYABORT; }
                         | /* empty */
                         ;
 optional_decl           : OPTIONAL
-                        { if (begin_optional(pass) == -1) return -1; }
+                        { if (begin_optional(pass) == -1) YYABORT; }
                         ;
 else_decl               : ELSE
-                        { if (begin_optional_else(pass) == -1) return -1; }
+                        { if (begin_optional_else(pass) == -1) YYABORT; }
                         ;
 avrule_user_defs        : user_def avrule_user_defs
                         | /* empty */
-- 
2.43.0

