Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E778B53
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579950; cv=none; b=X6Py9c0DiTFnD/BZQBhWjI4JzqrVG3c6ATYZvyNIkyvg27epffeQt8pWbbJ5plV+Lnq6pqMI7ff3YPgt1CJE4znoP4B9anPayOYPo3So0NbXrigUEbMqrvtd7mhjaPPx6ptkzL4nmT9eN7dC6LT5mL2WZLKfjygbtwAmP5mUzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579950; c=relaxed/simple;
	bh=ZfhRO57vjtIkIhG58tqrAITAjNVnp853kkzxLtFIQIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/d2Lxa7mjwU9bND7jTf2tcrTZv62qXI+MvxGmUkHVfIh6amSiH1SEDU1o0os74CGGqITX+7x+2JSWLJQr7C5PCkSByv2tbEZlR3CofmSsNrPUp/JxY5i8xPYhXJCW1mwbWtmiSOIHL+fHi2vTS+mpAkC9fq9Ue/ovk0he0SML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6jdQl5J; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6jdQl5J"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4727e38ec10so955370137.1
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579946; x=1710184746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpevfTe4G+S/9gbQ262i9df0qRGPNyxsJvEB7DXKM64=;
        b=F6jdQl5JKRvLv/ehlHqh0hPQxT+fQPcd8LzwAosK+j0GfUxtH7NgcRqq9rpRmif5vJ
         gpO4ZbIPuP0xJxZU8M0bI/xXZAx10/AtmyRc0rMg2PxKRl6ZXJxPwUbWUPEzyKEOdXlf
         mXPY1b3xJCNHd3VYd7L2KVdnGrz7wPItjnOu2I35aVzJPVLClM4QEgTCjoQI0ne+wbFu
         2wIzBaYttDbmLm3ZjXynzjqC+/QWe5DOs9pVLf2AAMZYyOjpc2PCqKBD6S7cRkPfrUF5
         BQ+chdT1s0bmedgnm0VK4Q7WVdJOb9mlwETzjX9b29SjLPHGyralsza36ZKAhE2DaFWI
         8S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579946; x=1710184746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpevfTe4G+S/9gbQ262i9df0qRGPNyxsJvEB7DXKM64=;
        b=iRur+GJSRAUpnL+JDVSsLjGsDgEMJQhr6O6AgCre/sEOQ/+pnLFRSdZ75sce6aDUCu
         dDc9uFh8jIp+3Q9nKb/7T6RMRPlRUOI5v1aXR83jYbBNwKOWSzlXrsuQP93Sqw0KE1T+
         qsprbaDfaouWWiz6lJMryQyqIoOV5lmN6AMqYwicMSGOS0+9zqqt4tCSLRRzDqQ4LTWg
         5aTE0WfnFZ7ABLBzp8IV3/AeLcQ0Ffsf2/cIHRF1hHvHnnzHcbYBPB+SLyegBJuG4iBU
         iu8zO65WYFcLwNNYCDzmZHXZT4YhmMvlSDcj6B/U436iFsH+TguIHL5bb6lE+B5Om+wM
         Nhqg==
X-Gm-Message-State: AOJu0YyTpjibNCLyVnPJla0xr0xDcakAY7RqMbAtNOtz9wpDZ3X/qPmU
	Jss9wXeWdzRNdJAzS83lRstxe0FuovCFo9dceVaO5HvPpyMMq2ArjBKyel8yRA6T31e4BYO+OLM
	oJcB7+OlEu9QCOxQ2yYVv3o/pi/o=
X-Google-Smtp-Source: AGHT+IGxQcWfA8MAWH/uMn6z5bLmin1H7aqWIQ6Ztynt3WPVh/4jtHNvCc9zb2CaTLhMtppKIlTSh7FoMC0bhismOuA=
X-Received: by 2002:a05:6102:2150:b0:471:c058:8a94 with SMTP id
 h16-20020a056102215000b00471c0588a94mr7441252vsg.16.1709579946220; Mon, 04
 Mar 2024 11:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-7-cgzones@googlemail.com> <CAP+JOzQ2XcrC1Mcxjdk_yE_n3NeNPB_C6QojmDA7xQFuTPVN9g@mail.gmail.com>
In-Reply-To: <CAP+JOzQ2XcrC1Mcxjdk_yE_n3NeNPB_C6QojmDA7xQFuTPVN9g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:18:55 -0500
Message-ID: <CAP+JOzR=y13Qg=x-R-MOO=OFjhjA+BHN+5LP+V=GaWHqB9yR7A@mail.gmail.com>
Subject: Re: [PATCH 07/15] checkpolicy: call YYABORT on parse errors
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Calling the parser macro YYABORT allows the parser to cleanup up any
> > allocated resources before returning.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_parse.y | 400 ++++++++++++++++++-------------------
> >  1 file changed, 200 insertions(+), 200 deletions(-)
> >
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 356626e2..f5025f28 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -163,26 +163,26 @@ typedef int (* require_func_t)(int pass);
> >  policy                 : base_policy
> >                          | module_policy
> >                          ;
> > -base_policy             : { if (define_policy(pass, 0) =3D=3D -1) retu=
rn -1; }
> > +base_policy             : { if (define_policy(pass, 0) =3D=3D -1) YYAB=
ORT; }
> >                            classes initial_sids access_vectors
> > -                          { if (pass =3D=3D 1) { if (policydb_index_cl=
asses(policydbp)) return -1; }
> > -                            else if (pass =3D=3D 2) { if (policydb_ind=
ex_others(NULL, policydbp, 0)) return -1; }}
> > +                          { if (pass =3D=3D 1) { if (policydb_index_cl=
asses(policydbp)) YYABORT; }
> > +                            else if (pass =3D=3D 2) { if (policydb_ind=
ex_others(NULL, policydbp, 0)) YYABORT; }}
> >                           opt_default_rules opt_mls te_rbac users opt_c=
onstraints
> > -                         { if (pass =3D=3D 1) { if (policydb_index_boo=
ls(policydbp)) return -1;}
> > -                          else if (pass =3D=3D 2) { if (policydb_index=
_others(NULL, policydbp, 0)) return -1;}}
> > +                         { if (pass =3D=3D 1) { if (policydb_index_boo=
ls(policydbp)) YYABORT; }
> > +                          else if (pass =3D=3D 2) { if (policydb_index=
_others(NULL, policydbp, 0)) YYABORT; }}
> >                           initial_sid_contexts opt_fs_contexts opt_fs_u=
ses opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts op=
t_ibendport_contexts
> >                         ;
> >  classes                        : class_def
> >                         | classes class_def
> >                         ;
> >  class_def              : CLASS identifier
> > -                       {if (define_class()) return -1;}
> > +                       {if (define_class()) YYABORT;}
> >                         ;
> >  initial_sids           : initial_sid_def
> >                         | initial_sids initial_sid_def
> >                         ;
> >  initial_sid_def                : SID identifier
> > -                        {if (define_initial_sid()) return -1;}
> > +                        {if (define_initial_sid()) YYABORT;}
> >                         ;
> >  access_vectors         : opt_common_perms av_perms
> >                         ;
> > @@ -193,17 +193,17 @@ common_perms              : common_perms_def
> >                         | common_perms common_perms_def
> >                         ;
> >  common_perms_def       : COMMON identifier '{' identifier_list '}'
> > -                       {if (define_common_perms()) return -1;}
> > +                       {if (define_common_perms()) YYABORT;}
> >                         ;
> >  av_perms               : av_perms_def
> >                         | av_perms av_perms_def
> >                         ;
> >  av_perms_def           : CLASS identifier '{' identifier_list '}'
> > -                       {if (define_av_perms(FALSE)) return -1;}
> > +                       {if (define_av_perms(FALSE)) YYABORT;}
> >                          | CLASS identifier INHERITS identifier
> > -                       {if (define_av_perms(TRUE)) return -1;}
> > +                       {if (define_av_perms(TRUE)) YYABORT;}
> >                          | CLASS identifier INHERITS identifier '{' ide=
ntifier_list '}'
> > -                       {if (define_av_perms(TRUE)) return -1;}
> > +                       {if (define_av_perms(TRUE)) YYABORT;}
> >                         ;
> >  opt_default_rules      : default_rules
> >                         |
> > @@ -218,34 +218,34 @@ default_rules             : default_user_def
> >                         | default_rules default_range_def
> >                         ;
> >  default_user_def       : DEFAULT_USER names SOURCE ';'
> > -                       {if (define_default_user(DEFAULT_SOURCE)) retur=
n -1; }
> > +                       {if (define_default_user(DEFAULT_SOURCE)) YYABO=
RT; }
> >                         | DEFAULT_USER names TARGET ';'
> > -                       {if (define_default_user(DEFAULT_TARGET)) retur=
n -1; }
> > +                       {if (define_default_user(DEFAULT_TARGET)) YYABO=
RT; }
> >                         ;
> >  default_role_def       : DEFAULT_ROLE names SOURCE ';'
> > -                       {if (define_default_role(DEFAULT_SOURCE)) retur=
n -1; }
> > +                       {if (define_default_role(DEFAULT_SOURCE)) YYABO=
RT; }
> >                         | DEFAULT_ROLE names TARGET ';'
> > -                       {if (define_default_role(DEFAULT_TARGET)) retur=
n -1; }
> > +                       {if (define_default_role(DEFAULT_TARGET)) YYABO=
RT; }
> >                         ;
> >  default_type_def       : DEFAULT_TYPE names SOURCE ';'
> > -                       {if (define_default_type(DEFAULT_SOURCE)) retur=
n -1; }
> > +                       {if (define_default_type(DEFAULT_SOURCE)) YYABO=
RT;; }
> >                         | DEFAULT_TYPE names TARGET ';'
> > -                       {if (define_default_type(DEFAULT_TARGET)) retur=
n -1; }
> > +                       {if (define_default_type(DEFAULT_TARGET)) YYABO=
RT; }
> >                         ;
> >  default_range_def      : DEFAULT_RANGE names SOURCE LOW ';'
> > -                       {if (define_default_range(DEFAULT_SOURCE_LOW)) =
return -1; }
> > +                       {if (define_default_range(DEFAULT_SOURCE_LOW)) =
YYABORT; }
> >                         | DEFAULT_RANGE names SOURCE HIGH ';'
> > -                       {if (define_default_range(DEFAULT_SOURCE_HIGH))=
 return -1; }
> > +                       {if (define_default_range(DEFAULT_SOURCE_HIGH))=
 YYABORT; }
> >                         | DEFAULT_RANGE names SOURCE LOW_HIGH ';'
> > -                       {if (define_default_range(DEFAULT_SOURCE_LOW_HI=
GH)) return -1; }
> > +                       {if (define_default_range(DEFAULT_SOURCE_LOW_HI=
GH)) YYABORT; }
> >                         | DEFAULT_RANGE names TARGET LOW ';'
> > -                       {if (define_default_range(DEFAULT_TARGET_LOW)) =
return -1; }
> > +                       {if (define_default_range(DEFAULT_TARGET_LOW)) =
YYABORT; }
> >                         | DEFAULT_RANGE names TARGET HIGH ';'
> > -                       {if (define_default_range(DEFAULT_TARGET_HIGH))=
 return -1; }
> > +                       {if (define_default_range(DEFAULT_TARGET_HIGH))=
 YYABORT; }
> >                         | DEFAULT_RANGE names TARGET LOW_HIGH ';'
> > -                       {if (define_default_range(DEFAULT_TARGET_LOW_HI=
GH)) return -1; }
> > +                       {if (define_default_range(DEFAULT_TARGET_LOW_HI=
GH)) YYABORT; }
> >                         | DEFAULT_RANGE names GLBLUB';'
> > -                       {if (define_default_range(DEFAULT_GLBLUB)) retu=
rn -1; }
> > +                       {if (define_default_range(DEFAULT_GLBLUB)) YYAB=
ORT; }
> >                         ;
> >  opt_mls                        : mls
> >                          |
> > @@ -256,16 +256,16 @@ sensitivities             : sensitivity_def
> >                         | sensitivities sensitivity_def
> >                         ;
> >  sensitivity_def                : SENSITIVITY identifier alias_def ';'
> > -                       {if (define_sens()) return -1;}
> > +                       {if (define_sens()) YYABORT;}
> >                         | SENSITIVITY identifier ';'
> > -                       {if (define_sens()) return -1;}
> > +                       {if (define_sens()) YYABORT;}
> >                         ;
> >  alias_def              : ALIAS names
> >                         ;
> >  dominance              : DOMINANCE identifier
> > -                       {if (define_dominance()) return -1;}
> > +                       {if (define_dominance()) YYABORT;}
> >                          | DOMINANCE '{' identifier_list '}'
> > -                       {if (define_dominance()) return -1;}
> > +                       {if (define_dominance()) YYABORT;}
> >                         ;
> >  opt_categories          : categories
> >                          |
> > @@ -274,17 +274,17 @@ categories                : category_def
> >                         | categories category_def
> >                         ;
> >  category_def           : CATEGORY identifier alias_def ';'
> > -                       {if (define_category()) return -1;}
> > +                       {if (define_category()) YYABORT;}
> >                         | CATEGORY identifier ';'
> > -                       {if (define_category()) return -1;}
> > +                       {if (define_category()) YYABORT;}
> >                         ;
> >  levels                 : level_def
> >                         | levels level_def
> >                         ;
> >  level_def              : LEVEL identifier ':' id_comma_list ';'
> > -                       {if (define_level()) return -1;}
> > +                       {if (define_level()) YYABORT;}
> >                         | LEVEL identifier ';'
> > -                       {if (define_level()) return -1;}
> > +                       {if (define_level()) YYABORT;}
> >                         ;
> >  mlspolicy              : mlspolicy_decl
> >                         | mlspolicy mlspolicy_decl
> > @@ -293,10 +293,10 @@ mlspolicy_decl            : mlsconstraint_def
> >                         | mlsvalidatetrans_def
> >                         ;
> >  mlsconstraint_def      : MLSCONSTRAIN names names cexpr ';'
> > -                       { if (define_constraint((constraint_expr_t*)$4)=
) return -1; }
> > +                       { if (define_constraint((constraint_expr_t*)$4)=
) YYABORT; }
> >                         ;
> >  mlsvalidatetrans_def   : MLSVALIDATETRANS names cexpr ';'
> > -                       { if (define_validatetrans((constraint_expr_t*)=
$3)) return -1; }
> > +                       { if (define_validatetrans((constraint_expr_t*)=
$3)) YYABORT; }
> >                         ;
> >  te_rbac                        : te_rbac_decl
> >                         | te_rbac te_rbac_decl
> > @@ -329,41 +329,41 @@ te_decl                   : attribute_def
> >                         | permissive_def
> >                         ;
> >  attribute_def           : ATTRIBUTE identifier ';'
> > -                        { if (define_attrib()) return -1;}
> > +                        { if (define_attrib()) YYABORT;}
> >                          ;
> >  expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
> > -                        { if (expand_attrib()) return -1;}
> > +                        { if (expand_attrib()) YYABORT;}
> >                          ;
> >  type_def               : TYPE identifier alias_def opt_attr_list ';'
> > -                        {if (define_type(1)) return -1;}
> > +                        {if (define_type(1)) YYABORT;}
> >                         | TYPE identifier opt_attr_list ';'
> > -                        {if (define_type(0)) return -1;}
> > +                        {if (define_type(0)) YYABORT;}
> >                         ;
> >  typealias_def           : TYPEALIAS identifier alias_def ';'
> > -                       {if (define_typealias()) return -1;}
> > +                       {if (define_typealias()) YYABORT;}
> >                         ;
> >  typeattribute_def      : TYPEATTRIBUTE identifier id_comma_list ';'
> > -                       {if (define_typeattribute()) return -1;}
> > +                       {if (define_typeattribute()) YYABORT;}
> >                         ;
> >  typebounds_def          : TYPEBOUNDS identifier id_comma_list ';'
> > -                        {if (define_typebounds()) return -1;}
> > +                        {if (define_typebounds()) YYABORT;}
> >                          ;
> >  opt_attr_list           : ',' id_comma_list
> >                         |
> >                         ;
> >  bool_def                : BOOL identifier bool_val ';'
> > -                        { if (define_bool_tunable(0)) return -1; }
> > +                        { if (define_bool_tunable(0)) YYABORT; }
> >                          ;
> >  tunable_def            : TUNABLE identifier bool_val ';'
> > -                       { if (define_bool_tunable(1)) return -1; }
> > +                       { if (define_bool_tunable(1)) YYABORT; }
> >                         ;
> >  bool_val                : CTRUE
> > -                       { if (insert_id("T",0)) return -1; }
> > +                       { if (insert_id("T",0)) YYABORT; }
> >                          | CFALSE
> > -                       { if (insert_id("F",0)) return -1; }
> > +                       { if (insert_id("F",0)) YYABORT; }
> >                          ;
> >  cond_stmt_def           : IF cond_expr '{' cond_pol_list '}' cond_else
> > -                        { if (pass =3D=3D 2) { if (define_conditional(=
(cond_expr_t*)$2, (avrule_t*)$4, (avrule_t*)$6) < 0) return -1;  }}
> > +                        { if (pass =3D=3D 2) { if (define_conditional(=
(cond_expr_t*)$2, (avrule_t*)$4, (avrule_t*)$6) < 0) YYABORT;  }}
> >                          ;
> >  cond_else              : ELSE '{' cond_pol_list '}'
> >                         { $$ =3D $3; }
> > @@ -374,28 +374,28 @@ cond_expr               : '(' cond_expr ')'
> >                         { $$ =3D $2;}
> >                         | NOT cond_expr
> >                         { $$ =3D define_cond_expr(COND_NOT, $2, 0);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cond_expr AND cond_expr
> >                         { $$ =3D define_cond_expr(COND_AND, $1, $3);
> > -                         if ($$ =3D=3D 0) return  -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cond_expr OR cond_expr
> >                         { $$ =3D define_cond_expr(COND_OR, $1, $3);
> > -                         if ($$ =3D=3D 0) return   -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cond_expr XOR cond_expr
> >                         { $$ =3D define_cond_expr(COND_XOR, $1, $3);
> > -                         if ($$ =3D=3D 0) return  -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cond_expr EQUALS cond_expr
> >                         { $$ =3D define_cond_expr(COND_EQ, $1, $3);
> > -                         if ($$ =3D=3D 0) return  -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cond_expr NOTEQUAL cond_expr
> >                         { $$ =3D define_cond_expr(COND_NEQ, $1, $3);
> > -                         if ($$ =3D=3D 0) return  -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cond_expr_prim
> >                         { $$ =3D $1; }
> >                         ;
> >  cond_expr_prim          : identifier
> >                          { $$ =3D define_cond_expr(COND_BOOL,0, 0);
> > -                         if ($$ =3D=3D COND_ERR) return   -1; }
> > +                         if ($$ =3D=3D COND_ERR) YYABORT; }
> >                          ;
> >  cond_pol_list           : cond_pol_list cond_rule_def
> >                          { $$ =3D define_cond_pol_list((avrule_t *)$1, =
(avrule_t *)$2); }
> > @@ -411,16 +411,16 @@ cond_rule_def           : cond_transition_def
> >                          ;
> >  cond_transition_def    : TYPE_TRANSITION names names ':' names identif=
ier filename ';'
> >                          { $$ =3D define_cond_filename_trans() ;
> > -                          if ($$ =3D=3D COND_ERR) return -1;}
> > +                          if ($$ =3D=3D COND_ERR) YYABORT;}
> >                         | TYPE_TRANSITION names names ':' names identif=
ier ';'
> >                          { $$ =3D define_cond_compute_type(AVRULE_TRANS=
ITION) ;
> > -                          if ($$ =3D=3D COND_ERR) return -1;}
> > +                          if ($$ =3D=3D COND_ERR) YYABORT;}
> >                          | TYPE_MEMBER names names ':' names identifier=
 ';'
> >                          { $$ =3D define_cond_compute_type(AVRULE_MEMBE=
R) ;
> > -                          if ($$ =3D=3D  COND_ERR) return -1;}
> > +                          if ($$ =3D=3D  COND_ERR) YYABORT;}
> >                          | TYPE_CHANGE names names ':' names identifier=
 ';'
> >                          { $$ =3D define_cond_compute_type(AVRULE_CHANG=
E) ;
> > -                          if ($$ =3D=3D COND_ERR) return -1;}
> > +                          if ($$ =3D=3D COND_ERR) YYABORT;}
> >                         ;
> >  cond_te_avtab_def      : cond_allow_def
> >                            { $$ =3D $1; }
> > @@ -433,34 +433,34 @@ cond_te_avtab_def : cond_allow_def
> >                         ;
> >  cond_allow_def         : ALLOW names names ':' names names  ';'
> >                         { $$ =3D define_cond_te_avtab(AVRULE_ALLOWED) ;
> > -                          if ($$ =3D=3D COND_ERR) return -1; }
> > +                          if ($$ =3D=3D COND_ERR) YYABORT; }
> >                         ;
> >  cond_auditallow_def    : AUDITALLOW names names ':' names names ';'
> >                         { $$ =3D define_cond_te_avtab(AVRULE_AUDITALLOW=
) ;
> > -                          if ($$ =3D=3D COND_ERR) return -1; }
> > +                          if ($$ =3D=3D COND_ERR) YYABORT; }
> >                         ;
> >  cond_auditdeny_def     : AUDITDENY names names ':' names names ';'
> >                         { $$ =3D define_cond_te_avtab(AVRULE_AUDITDENY)=
 ;
> > -                          if ($$ =3D=3D COND_ERR) return -1; }
> > +                          if ($$ =3D=3D COND_ERR) YYABORT; }
> >                         ;
> >  cond_dontaudit_def     : DONTAUDIT names names ':' names names ';'
> >                         { $$ =3D define_cond_te_avtab(AVRULE_DONTAUDIT)=
;
> > -                          if ($$ =3D=3D COND_ERR) return -1; }
> > +                          if ($$ =3D=3D COND_ERR) YYABORT; }
> >                         ;
> >                         ;
> >  transition_def         : TYPE_TRANSITION  names names ':' names identi=
fier filename ';'
> > -                       {if (define_filename_trans()) return -1; }
> > +                       {if (define_filename_trans()) YYABORT; }
> >                         | TYPE_TRANSITION names names ':' names identif=
ier ';'
> > -                        {if (define_compute_type(AVRULE_TRANSITION)) r=
eturn -1;}
> > +                        {if (define_compute_type(AVRULE_TRANSITION)) Y=
YABORT;}
> >                          | TYPE_MEMBER names names ':' names identifier=
 ';'
> > -                        {if (define_compute_type(AVRULE_MEMBER)) retur=
n -1;}
> > +                        {if (define_compute_type(AVRULE_MEMBER)) YYABO=
RT;}
> >                          | TYPE_CHANGE names names ':' names identifier=
 ';'
> > -                        {if (define_compute_type(AVRULE_CHANGE)) retur=
n -1;}
> > +                        {if (define_compute_type(AVRULE_CHANGE)) YYABO=
RT;}
> >                         ;
> >  range_trans_def                : RANGE_TRANSITION names names mls_rang=
e_def ';'
> > -                       { if (define_range_trans(0)) return -1; }
> > +                       { if (define_range_trans(0)) YYABORT; }
> >                         | RANGE_TRANSITION names names ':' names mls_ra=
nge_def ';'
> > -                       { if (define_range_trans(1)) return -1; }
> > +                       { if (define_range_trans(1)) YYABORT; }
> >                         ;
> >  te_avtab_def           : allow_def
> >                         | auditallow_def
> > @@ -473,51 +473,51 @@ te_avtab_def              : allow_def
> >                         | xperm_neverallow_def
> >                         ;
> >  allow_def              : ALLOW names names ':' names names  ';'
> > -                       {if (define_te_avtab(AVRULE_ALLOWED)) return -1=
; }
> > +                       {if (define_te_avtab(AVRULE_ALLOWED)) YYABORT; =
}
> >                         ;
> >  auditallow_def         : AUDITALLOW names names ':' names names ';'
> > -                       {if (define_te_avtab(AVRULE_AUDITALLOW)) return=
 -1; }
> > +                       {if (define_te_avtab(AVRULE_AUDITALLOW)) YYABOR=
T; }
> >                         ;
> >  auditdeny_def          : AUDITDENY names names ':' names names ';'
> > -                       {if (define_te_avtab(AVRULE_AUDITDENY)) return =
-1; }
> > +                       {if (define_te_avtab(AVRULE_AUDITDENY)) YYABORT=
; }
> >                         ;
> >  dontaudit_def          : DONTAUDIT names names ':' names names ';'
> > -                       {if (define_te_avtab(AVRULE_DONTAUDIT)) return =
-1; }
> > +                       {if (define_te_avtab(AVRULE_DONTAUDIT)) YYABORT=
; }
> >                         ;
> >  neverallow_def         : NEVERALLOW names names ':' names names  ';'
> > -                       {if (define_te_avtab(AVRULE_NEVERALLOW)) return=
 -1; }
> > +                       {if (define_te_avtab(AVRULE_NEVERALLOW)) YYABOR=
T; }
> >                         ;
> >  xperm_allow_def                : ALLOWXPERM names names ':' names iden=
tifier xperms ';'
> > -                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_ALLOWED)) return -1; }
> > +                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_ALLOWED)) YYABORT; }
> >                         ;
> >  xperm_auditallow_def   : AUDITALLOWXPERM names names ':' names identif=
ier xperms ';'
> > -                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_AUDITALLOW)) return -1; }
> > +                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_AUDITALLOW)) YYABORT; }
> >                         ;
> >  xperm_dontaudit_def    : DONTAUDITXPERM names names ':' names identifi=
er xperms ';'
> > -                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_DONTAUDIT)) return -1; }
> > +                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_DONTAUDIT)) YYABORT; }
> >                         ;
> >  xperm_neverallow_def   : NEVERALLOWXPERM names names ':' names identif=
ier xperms ';'
> > -                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_NEVERALLOW)) return -1; }
> > +                       {if (define_te_avtab_extended_perms(AVRULE_XPER=
MS_NEVERALLOW)) YYABORT; }
> >                         ;
> >  attribute_role_def     : ATTRIBUTE_ROLE identifier ';'
> > -                       {if (define_attrib_role()) return -1; }
> > +                       {if (define_attrib_role()) YYABORT; }
> >                         ;
> >  role_type_def          : ROLE identifier TYPES names ';'
> > -                       {if (define_role_types()) return -1;}
> > +                       {if (define_role_types()) YYABORT;}
> >                         ;
> >  role_attr_def          : ROLE identifier opt_attr_list ';'
> > -                       {if (define_role_attr()) return -1;}
> > +                       {if (define_role_attr()) YYABORT;}
> >                          ;
> >  role_trans_def         : ROLE_TRANSITION names names identifier ';'
> > -                       {if (define_role_trans(0)) return -1; }
> > +                       {if (define_role_trans(0)) YYABORT; }
> >                         | ROLE_TRANSITION names names ':' names identif=
ier ';'
> > -                       {if (define_role_trans(1)) return -1;}
> > +                       {if (define_role_trans(1)) YYABORT;}
> >                         ;
> >  role_allow_def         : ALLOW names names ';'
> > -                       {if (define_role_allow()) return -1; }
> > +                       {if (define_role_allow()) YYABORT; }
> >                         ;
> >  roleattribute_def      : ROLEATTRIBUTE identifier id_comma_list ';'
> > -                       {if (define_roleattribute()) return -1;}
> > +                       {if (define_roleattribute()) YYABORT;}
> >                         ;
> >  opt_constraints         : constraints
> >                          |
> > @@ -529,97 +529,97 @@ constraint_decl           : constraint_def
> >                         | validatetrans_def
> >                         ;
> >  constraint_def         : CONSTRAIN names names cexpr ';'
> > -                       { if (define_constraint((constraint_expr_t*)$4)=
) return -1; }
> > +                       { if (define_constraint((constraint_expr_t*)$4)=
) YYABORT; }
> >                         ;
> >  validatetrans_def      : VALIDATETRANS names cexpr ';'
> > -                       { if (define_validatetrans((constraint_expr_t*)=
$3)) return -1; }
> > +                       { if (define_validatetrans((constraint_expr_t*)=
$3)) YYABORT; }
> >                         ;
> >  cexpr                  : '(' cexpr ')'
> >                         { $$ =3D $2; }
> >                         | NOT cexpr
> >                         { $$ =3D define_cexpr(CEXPR_NOT, $2, 0);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cexpr AND cexpr
> >                         { $$ =3D define_cexpr(CEXPR_AND, $1, $3);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cexpr OR cexpr
> >                         { $$ =3D define_cexpr(CEXPR_OR, $1, $3);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | cexpr_prim
> >                         { $$ =3D $1; }
> >                         ;
> >  cexpr_prim             : U1 op U2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_USER, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | R1 role_mls_op R2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | T1 op T2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | U1 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | U1 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, CEXPR_USER, =
$2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | U2 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | U2 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_USER =
| CEXPR_TARGET), $2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | U3 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | U3 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_USER =
| CEXPR_XTARGET), $2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | R1 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | R1 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, CEXPR_ROLE, =
$2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | R2 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | R2 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_ROLE =
| CEXPR_TARGET), $2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | R3 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | R3 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_ROLE =
| CEXPR_XTARGET), $2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | T1 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | T1 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, CEXPR_TYPE, =
$2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | T2 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | T2 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_TYPE =
| CEXPR_TARGET), $2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | T3 op { if (insert_separator(1)) return -1; }=
 names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | T3 op { if (insert_separator(1)) YYABORT; } n=
ames_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_TYPE =
| CEXPR_XTARGET), $2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | SAMEUSER
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_USER, C=
EXPR_EQ);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | SOURCE ROLE { if (insert_separator(1)) return=
 -1; } names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | SOURCE ROLE { if (insert_separator(1)) YYABOR=
T; } names_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, CEXPR_ROLE, =
CEXPR_EQ);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | TARGET ROLE { if (insert_separator(1)) return=
 -1; } names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | TARGET ROLE { if (insert_separator(1)) YYABOR=
T; } names_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_ROLE =
| CEXPR_TARGET), CEXPR_EQ);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | ROLE role_mls_op
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | SOURCE TYPE { if (insert_separator(1)) return=
 -1; } names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | SOURCE TYPE { if (insert_separator(1)) YYABOR=
T; } names_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, CEXPR_TYPE, =
CEXPR_EQ);
> > -                         if ($$ =3D=3D 0) return -1; }
> > -                       | TARGET TYPE { if (insert_separator(1)) return=
 -1; } names_push
> > +                         if ($$ =3D=3D 0) YYABORT; }
> > +                       | TARGET TYPE { if (insert_separator(1)) YYABOR=
T; } names_push
> >                         { $$ =3D define_cexpr(CEXPR_NAMES, (CEXPR_TYPE =
| CEXPR_TARGET), CEXPR_EQ);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | L1 role_mls_op L2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_L1L2, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | L1 role_mls_op H2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_L1H2, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | H1 role_mls_op L2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_H1L2, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | H1 role_mls_op H2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_H1H2, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | L1 role_mls_op H1
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_L1H1, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         | L2 role_mls_op H2
> >                         { $$ =3D define_cexpr(CEXPR_ATTR, CEXPR_L2H2, $=
2);
> > -                         if ($$ =3D=3D 0) return -1; }
> > +                         if ($$ =3D=3D 0) YYABORT; }
> >                         ;
> >  op                     : EQUALS
> >                         { $$ =3D CEXPR_EQ; }
> > @@ -639,7 +639,7 @@ users                       : user_def
> >                         | users user_def
> >                         ;
> >  user_def               : USER identifier ROLES names opt_mls_user ';'
> > -                       {if (define_user()) return -1;}
> > +                       {if (define_user()) YYABORT;}
> >                         ;
> >  opt_mls_user           : LEVEL mls_level_def RANGE mls_range_def
> >                         |
> > @@ -648,7 +648,7 @@ initial_sid_contexts        : initial_sid_context_d=
ef
> >                         | initial_sid_contexts initial_sid_context_def
> >                         ;
> >  initial_sid_context_def        : SID identifier security_context_def
> > -                       {if (define_initial_sid_context()) return -1;}
> > +                       {if (define_initial_sid_context()) YYABORT;}
> >                         ;
> >  opt_dev_contexts       : dev_contexts |
> >                         ;
> > @@ -662,23 +662,23 @@ dev_context_def           : pirq_context_def |
> >                           dtree_context_def
> >                         ;
> >  pirq_context_def       : PIRQCON number security_context_def
> > -                       {if (define_pirq_context($2)) return -1;}
> > +                       {if (define_pirq_context($2)) YYABORT;}
> >                         ;
> >  iomem_context_def      : IOMEMCON number64 security_context_def
> > -                       {if (define_iomem_context($2,$2)) return -1;}
> > +                       {if (define_iomem_context($2,$2)) YYABORT;}
> >                         | IOMEMCON number64 '-' number64 security_conte=
xt_def
> > -                       {if (define_iomem_context($2,$4)) return -1;}
> > +                       {if (define_iomem_context($2,$4)) YYABORT;}
> >                         ;
> >  ioport_context_def     : IOPORTCON number security_context_def
> > -                       {if (define_ioport_context($2,$2)) return -1;}
> > +                       {if (define_ioport_context($2,$2)) YYABORT;}
> >                         | IOPORTCON number '-' number security_context_=
def
> > -                       {if (define_ioport_context($2,$4)) return -1;}
> > +                       {if (define_ioport_context($2,$4)) YYABORT;}
> >                         ;
> >  pci_context_def        : PCIDEVICECON number security_context_def
> > -                       {if (define_pcidevice_context($2)) return -1;}
> > +                       {if (define_pcidevice_context($2)) YYABORT;}
> >                         ;
> >  dtree_context_def      : DEVICETREECON path security_context_def
> > -                       {if (define_devicetree_context()) return -1;}
> > +                       {if (define_devicetree_context()) YYABORT;}
> >                         ;
> >  opt_fs_contexts         : fs_contexts
> >                          |
> > @@ -687,7 +687,7 @@ fs_contexts         : fs_context_def
> >                         | fs_contexts fs_context_def
> >                         ;
> >  fs_context_def         : FSCON number number security_context_def secu=
rity_context_def
> > -                       {if (define_fs_context($2,$3)) return -1;}
> > +                       {if (define_fs_context($2,$3)) YYABORT;}
> >                         ;
> >  net_contexts           : opt_port_contexts opt_netif_contexts opt_node=
_contexts
> >                         ;
> > @@ -698,9 +698,9 @@ port_contexts               : port_context_def
> >                         | port_contexts port_context_def
> >                         ;
> >  port_context_def       : PORTCON identifier number security_context_de=
f
> > -                       {if (define_port_context($3,$3)) return -1;}
> > +                       {if (define_port_context($3,$3)) YYABORT;}
> >                         | PORTCON identifier number '-' number security=
_context_def
> > -                       {if (define_port_context($3,$5)) return -1;}
> > +                       {if (define_port_context($3,$5)) YYABORT;}
> >                         ;
> >  opt_ibpkey_contexts     : ibpkey_contexts
> >                          |
> > @@ -709,9 +709,9 @@ ibpkey_contexts             : ibpkey_context_def
> >                         | ibpkey_contexts ibpkey_context_def
> >                         ;
> >  ibpkey_context_def     : IBPKEYCON ipv6_addr number security_context_d=
ef
> > -                       {if (define_ibpkey_context($3,$3)) return -1;}
> > +                       {if (define_ibpkey_context($3,$3)) YYABORT;}
> >                         | IBPKEYCON ipv6_addr number '-' number securit=
y_context_def
> > -                       {if (define_ibpkey_context($3,$5)) return -1;}
> > +                       {if (define_ibpkey_context($3,$5)) YYABORT;}
> >                         ;
> >  opt_ibendport_contexts : ibendport_contexts
> >                         |
> > @@ -720,7 +720,7 @@ ibendport_contexts  : ibendport_context_def
> >                          | ibendport_contexts ibendport_context_def
> >                          ;
> >  ibendport_context_def  : IBENDPORTCON identifier number security_conte=
xt_def
> > -                        {if (define_ibendport_context($3)) return -1;}
> > +                        {if (define_ibendport_context($3)) YYABORT;}
> >                          ;
> >  opt_netif_contexts      : netif_contexts
> >                          |
> > @@ -729,7 +729,7 @@ netif_contexts              : netif_context_def
> >                         | netif_contexts netif_context_def
> >                         ;
> >  netif_context_def      : NETIFCON identifier security_context_def secu=
rity_context_def
> > -                       {if (define_netif_context()) return -1;}
> > +                       {if (define_netif_context()) YYABORT;}
> >                         ;
> >  opt_node_contexts       : node_contexts
> >                          |
> > @@ -738,9 +738,9 @@ node_contexts               : node_context_def
> >                         | node_contexts node_context_def
> >                         ;
> >  node_context_def       : NODECON ipv4_addr_def ipv4_addr_def security_=
context_def
> > -                       {if (define_ipv4_node_context()) return -1;}
> > +                       {if (define_ipv4_node_context()) YYABORT;}
> >                         | NODECON ipv6_addr ipv6_addr security_context_=
def
> > -                       {if (define_ipv6_node_context()) return -1;}
> > +                       {if (define_ipv6_node_context()) YYABORT;}
> >                         ;
> >  opt_fs_uses             : fs_uses
> >                          |
> > @@ -749,11 +749,11 @@ fs_uses                 : fs_use_def
> >                          | fs_uses fs_use_def
> >                          ;
> >  fs_use_def              : FSUSEXATTR filesystem security_context_def '=
;'
> > -                        {if (define_fs_use(SECURITY_FS_USE_XATTR)) ret=
urn -1;}
> > +                        {if (define_fs_use(SECURITY_FS_USE_XATTR)) YYA=
BORT;}
> >                          | FSUSETASK identifier security_context_def ';=
'
> > -                        {if (define_fs_use(SECURITY_FS_USE_TASK)) retu=
rn -1;}
> > +                        {if (define_fs_use(SECURITY_FS_USE_TASK)) YYAB=
ORT;}
> >                          | FSUSETRANS identifier security_context_def '=
;'
> > -                        {if (define_fs_use(SECURITY_FS_USE_TRANS)) ret=
urn -1;}
> > +                        {if (define_fs_use(SECURITY_FS_USE_TRANS)) YYA=
BORT;}
> >                          ;
> >  opt_genfs_contexts      : genfs_contexts
> >                          |
> > @@ -762,36 +762,36 @@ genfs_contexts          : genfs_context_def
> >                          | genfs_contexts genfs_context_def
> >                          ;
> >  genfs_context_def      : GENFSCON filesystem path '-' identifier secur=
ity_context_def
> > -                       {if (define_genfs_context(1)) return -1;}
> > +                       {if (define_genfs_context(1)) YYABORT;}
> >                         | GENFSCON filesystem path '-' '-' {insert_id("=
-", 0);} security_context_def
> > -                       {if (define_genfs_context(1)) return -1;}
> > +                       {if (define_genfs_context(1)) YYABORT;}
> >                          | GENFSCON filesystem path security_context_de=
f
> > -                       {if (define_genfs_context(0)) return -1;}
> > +                       {if (define_genfs_context(0)) YYABORT;}
> >                         ;
> >  ipv4_addr_def          : IPV4_ADDR
> > -                       { if (insert_id(yytext,0)) return -1; }
> > +                       { if (insert_id(yytext,0)) YYABORT; }
> >                         ;
> >  xperms         : xperm
> > -                       { if (insert_separator(0)) return -1; }
> > +                       { if (insert_separator(0)) YYABORT; }
> >                         | nested_xperm_set
> > -                       { if (insert_separator(0)) return -1; }
> > +                       { if (insert_separator(0)) YYABORT; }
> >                         | tilde xperm
> > -                        { if (insert_id("~", 0)) return -1; }
> > +                        { if (insert_id("~", 0)) YYABORT; }
> >                         | tilde nested_xperm_set
> > -                       { if (insert_id("~", 0)) return -1;
> > -                         if (insert_separator(0)) return -1; }
> > +                       { if (insert_id("~", 0)) YYABORT;
> > +                         if (insert_separator(0)) YYABORT; }
> >                         ;
> >  nested_xperm_set       : '{' nested_xperm_list '}'
> >                         ;
> >  nested_xperm_list      : nested_xperm_element
> >                         | nested_xperm_list nested_xperm_element
> >                         ;
> > -nested_xperm_element: xperm '-' { if (insert_id("-", 0)) return -1; } =
xperm
> > +nested_xperm_element: xperm '-' { if (insert_id("-", 0)) YYABORT; } xp=
erm
> >                         | xperm
> >                         | nested_xperm_set
> >                         ;
> >  xperm          : number
> > -                        { if (insert_id(yytext,0)) return -1; }
> > +                        { if (insert_id(yytext,0)) YYABORT; }
> >                         ;
> >  security_context_def   : identifier ':' identifier ':' identifier opt_=
mls_range_def
> >                         ;
> > @@ -799,14 +799,14 @@ opt_mls_range_def : ':' mls_range_def
> >                         |
> >                         ;
> >  mls_range_def          : mls_level_def '-' mls_level_def
> > -                       {if (insert_separator(0)) return -1;}
> > +                       {if (insert_separator(0)) YYABORT;}
> >                         | mls_level_def
> > -                       {if (insert_separator(0)) return -1;}
> > +                       {if (insert_separator(0)) YYABORT;}
> >                         ;
> >  mls_level_def          : identifier ':' id_comma_list
> > -                       {if (insert_separator(0)) return -1;}
> > +                       {if (insert_separator(0)) YYABORT;}
> >                         | identifier
> > -                       {if (insert_separator(0)) return -1;}
> > +                       {if (insert_separator(0)) YYABORT;}
> >                         ;
> >  id_comma_list           : identifier
> >                         | id_comma_list ',' identifier
> > @@ -816,26 +816,26 @@ tilde                     : '~'
> >  asterisk               : '*'
> >                         ;
> >  names                  : identifier
> > -                       { if (insert_separator(0)) return -1; }
> > +                       { if (insert_separator(0)) YYABORT; }
> >                         | nested_id_set
> > -                       { if (insert_separator(0)) return -1; }
> > +                       { if (insert_separator(0)) YYABORT; }
> >                         | asterisk
> > -                        { if (insert_id("*", 0)) return -1;
> > -                         if (insert_separator(0)) return -1; }
> > +                        { if (insert_id("*", 0)) YYABORT;
> > +                         if (insert_separator(0)) YYABORT; }
> >                         | tilde identifier
> > -                        { if (insert_id("~", 0)) return -1;
> > -                         if (insert_separator(0)) return -1; }
> > +                        { if (insert_id("~", 0)) YYABORT;
> > +                         if (insert_separator(0)) YYABORT; }
> >                         | tilde nested_id_set
> > -                       { if (insert_id("~", 0)) return -1;
> > -                         if (insert_separator(0)) return -1; }
> > -                        | identifier '-' { if (insert_id("-", 0)) retu=
rn -1; } identifier
> > -                       { if (insert_separator(0)) return -1; }
> > +                       { if (insert_id("~", 0)) YYABORT;
> > +                         if (insert_separator(0)) YYABORT; }
> > +                        | identifier '-' { if (insert_id("-", 0)) YYAB=
ORT; } identifier
> > +                       { if (insert_separator(0)) YYABORT; }
> >                         ;
> >  tilde_push              : tilde
> > -                        { if (insert_id("~", 1)) return -1; }
> > +                        { if (insert_id("~", 1)) YYABORT; }
> >                         ;
> >  asterisk_push           : asterisk
> > -                        { if (insert_id("*", 1)) return -1; }
> > +                        { if (insert_id("*", 1)) YYABORT; }
> >                         ;
> >  names_push             : identifier_push
> >                         | '{' identifier_list_push '}'
> > @@ -847,7 +847,7 @@ identifier_list_push        : identifier_push
> >                         | identifier_list_push identifier_push
> >                         ;
> >  identifier_push                : IDENTIFIER
> > -                       { if (insert_id(yytext, 1)) return -1; }
> > +                       { if (insert_id(yytext, 1)) YYABORT; }
> >                         ;
> >  identifier_list                : identifier
> >                         | identifier_list identifier
> > @@ -856,33 +856,33 @@ nested_id_set           : '{' nested_id_list '}'
> >                          ;
> >  nested_id_list          : nested_id_element | nested_id_list nested_id=
_element
> >                          ;
> > -nested_id_element       : identifier | '-' { if (insert_id("-", 0)) re=
turn -1; } identifier | nested_id_set
> > +nested_id_element       : identifier | '-' { if (insert_id("-", 0)) YY=
ABORT; } identifier | nested_id_set
> >                          ;
> >  identifier             : IDENTIFIER
> > -                       { if (insert_id(yytext,0)) return -1; }
> > +                       { if (insert_id(yytext,0)) YYABORT; }
> >                         ;
> >  filesystem             : FILESYSTEM
> > -                        { if (insert_id(yytext,0)) return -1; }
> > +                        { if (insert_id(yytext,0)) YYABORT; }
> >                          | IDENTIFIER
> > -                       { if (insert_id(yytext,0)) return -1; }
> > +                       { if (insert_id(yytext,0)) YYABORT; }
> >                          ;
> >  path                   : PATH
> > -                       { if (insert_id(yytext,0)) return -1; }
> > +                       { if (insert_id(yytext,0)) YYABORT; }
> >                         | QPATH
> > -                       { yytext[strlen(yytext) - 1] =3D '\0'; if (inse=
rt_id(yytext + 1,0)) return -1; }
> > +                       { yytext[strlen(yytext) - 1] =3D '\0'; if (inse=
rt_id(yytext + 1,0)) YYABORT; }
> >                         ;
> >  filename               : FILENAME
> > -                       { yytext[strlen(yytext) - 1] =3D '\0'; if (inse=
rt_id(yytext + 1,0)) return -1; }
> > +                       { yytext[strlen(yytext) - 1] =3D '\0'; if (inse=
rt_id(yytext + 1,0)) YYABORT; }
> >                         ;
> >  number                 : NUMBER
> >                         { unsigned long x;
> >                           errno =3D 0;
> >                           x =3D strtoul(yytext, NULL, 0);
> >                           if (errno)
> > -                             return -1;
> > +                             YYABORT;
> >  #if ULONG_MAX > UINT_MAX
> >                           if (x > UINT_MAX)
> > -                             return -1;
> > +                             YYABORT;
> >  #endif
> >                           $$ =3D (unsigned int) x;
> >                         }
> > @@ -892,33 +892,33 @@ number64          : NUMBER
> >                           errno =3D 0;
> >                           x =3D strtoull(yytext, NULL, 0);
> >                           if (errno)
> > -                             return -1;
> > +                             YYABORT;
> >                           $$ =3D (uint64_t) x;
> >                         }
> >                         ;
> >  ipv6_addr              : IPV6_ADDR
> > -                       { if (insert_id(yytext,0)) return -1; }
> > +                       { if (insert_id(yytext,0)) YYABORT; }
> >                         ;
> >  policycap_def          : POLICYCAP identifier ';'
> > -                       {if (define_polcap()) return -1;}
> > +                       {if (define_polcap()) YYABORT;}
> >                         ;
> >  permissive_def         : PERMISSIVE identifier ';'
> > -                       {if (define_permissive()) return -1;}
> > +                       {if (define_permissive()) YYABORT;}
> >
> >  /*********** module grammar below ***********/
> >
> >  module_policy           : module_def avrules_block
> > -                        { if (end_avrule_block(pass) =3D=3D -1) return=
 -1;
> > -                          if (policydb_index_others(NULL, policydbp, 0=
)) return -1;
> > +                        { if (end_avrule_block(pass) =3D=3D -1) YYABOR=
T;
> > +                          if (policydb_index_others(NULL, policydbp, 0=
)) YYABORT;
> >                          }
> >                          ;
> >  module_def              : MODULE identifier version_identifier ';'
> > -                        { if (define_policy(pass, 1) =3D=3D -1) return=
 -1; }
> > +                        { if (define_policy(pass, 1) =3D=3D -1) YYABOR=
T; }
> >                          ;
> >  version_identifier      : VERSION_IDENTIFIER
> > -                        { if (insert_id(yytext,0)) return -1; }
> > +                        { if (insert_id(yytext,0)) YYABORT; }
> >                         | number
> > -                        { if (insert_id(yytext,0)) return -1; }
> > +                        { if (insert_id(yytext,0)) YYABORT; }
> >                          | ipv4_addr_def /* version can look like ipv4 =
address */
> >                          ;
> >  avrules_block           : avrule_decls avrule_user_defs
> > @@ -942,7 +942,7 @@ require_decl            : require_class ';'
> >                          | require_decl_def require_id_list ';'
> >                          ;
> >  require_class           : CLASS identifier names
> > -                        { if (require_class(pass)) return -1; }
> > +                        { if (require_class(pass)) YYABORT; }
> >                          ;
> >  require_decl_def        : ROLE        { $$ =3D require_role; }
> >                          | TYPE        { $$ =3D require_type; }
> > @@ -955,24 +955,24 @@ require_decl_def        : ROLE        { $$ =3D re=
quire_role; }
> >                          | CATEGORY    { $$ =3D require_cat; }
> >                          ;
> >  require_id_list         : identifier
> > -                        { if ($<require_func>0 (pass)) return -1; }
> > +                        { if ($<require_func>0 (pass)) YYABORT; }
> >                          | require_id_list ',' identifier
> > -                        { if ($<require_func>0 (pass)) return -1; }
> > +                        { if ($<require_func>0 (pass)) YYABORT; }
> >                          ;
> >  optional_block          : optional_decl '{' avrules_block '}'
> > -                        { if (end_avrule_block(pass) =3D=3D -1) return=
 -1; }
> > +                        { if (end_avrule_block(pass) =3D=3D -1) YYABOR=
T; }
> >                            optional_else
> > -                        { if (end_optional(pass) =3D=3D -1) return -1;=
 }
> > +                        { if (end_optional(pass) =3D=3D -1) YYABORT; }
> >                          ;
> >  optional_else           : else_decl '{' avrules_block '}'
> > -                        { if (end_avrule_block(pass) =3D=3D -1) return=
 -1; }
> > +                        { if (end_avrule_block(pass) =3D=3D -1) YYABOR=
T; }
> >                          | /* empty */
> >                          ;
> >  optional_decl           : OPTIONAL
> > -                        { if (begin_optional(pass) =3D=3D -1) return -=
1; }
> > +                        { if (begin_optional(pass) =3D=3D -1) YYABORT;=
 }
> >                          ;
> >  else_decl               : ELSE
> > -                        { if (begin_optional_else(pass) =3D=3D -1) ret=
urn -1; }
> > +                        { if (begin_optional_else(pass) =3D=3D -1) YYA=
BORT; }
> >                          ;
> >  avrule_user_defs        : user_def avrule_user_defs
> >                          | /* empty */
> > --
> > 2.43.0
> >
> >
