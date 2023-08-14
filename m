Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B365C001E0
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 16:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHNQQO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjHNQP4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 12:15:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278E9F1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 09:15:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so70250281fa.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692029753; x=1692634553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6UF68hTO0o96HPmOYRP/bi0gPqKNVLcaMl8xdzMpzE=;
        b=d+ndACAaTRa+5BwfTdRe0YGQ5kOVA7Y9S2OTca5HYL/DSQoJe89dRGqgNOJZxVR5Rh
         kMePGM/C/IjCR9R1Cx2Dcd2ZKnoMgp9l6xG8vTDnIML3nQwsg0HoaomxQut2ItQrXbXN
         EOPnxAu8JKWPSE2BCnGk39PNaMHgiuR2bwiJqkcgsWRRoOvvSuQWhKYjtb+Teqeuxc1p
         lwVC3K/uoHQpUCjP6huBIqgHveGOkbpoYVCNNpGE1GqJn23YiPKwrVN2bFYkoUV0uCaC
         jPImOQGiOjD16EQCJYTak6dw6zZmjevPVzVSAo/aubFvIDB/AgHrTiuuK4/qZhJaljWn
         +3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692029753; x=1692634553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6UF68hTO0o96HPmOYRP/bi0gPqKNVLcaMl8xdzMpzE=;
        b=U7eN/yICVDfgjUeIyrs3Oc4itDcXzOHiX+sRW3n65xRFGDWAa1pjqDwtRFaLBcmZ+l
         lHv+B+F6N0g0uw+b6IrTAp8lc5vWS1VFCfrM8zUEZsd+QquOYkqG+HX7PkKjQ8VV/Gay
         RvRzaJh6/BLpkM4S2TjbuGa0KrA84v/J/IcvihVdgSUpsfqoEsPr1R7HCjOH8i7S2q/S
         PG/IU+v6E8q2vS5XaFbq+4griKd/lQpwoFefG/WKM3l5nLlu5Ezw2eW61gcGE3OtgcnU
         P2d+sZZnMImg/2dunMALy+trzSW67ZjCXnEdSbthM/y9m7ojwrxYOANTx8Jc+D87z5vC
         hUUA==
X-Gm-Message-State: AOJu0YzR6DO/x1sgEk62E7164FZABEoV7cLtMbPdAuivpF+2mCb8wAo5
        VeuLuNRwB/UyfW9QB09C0TqpdgzreI7J9aOoX2/0Y4nL
X-Google-Smtp-Source: AGHT+IE1u9pn3l6z2ZQ60mftfutWs5twRlkB7ctGtbb5S/sakc62bTUM962UeeM+ZYu/Pr7vVirw59I1BX/kF7Uijp0=
X-Received: by 2002:a2e:808d:0:b0:2ba:8127:a2c5 with SMTP id
 i13-20020a2e808d000000b002ba8127a2c5mr4164344ljg.53.1692029752709; Mon, 14
 Aug 2023 09:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230714173240.192987-1-jwcart2@gmail.com>
In-Reply-To: <20230714173240.192987-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 14 Aug 2023 12:15:41 -0400
Message-ID: <CAP+JOzTJSH+-z+7uMidazS+V+dHoLXr8fQH20yZ+WXY-BB3aXQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Remove support for role dominance rules
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 14, 2023 at 1:32=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Role dominance has been deprecated for a very, very long time (since
> at least August 2008) and has never been used in any widely deployed
> policy.
>
> Remove support for compiling role dominance rules.
>
> Support will remain, for now, in libsepol for backwards compatibility.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

There should not be any controversy over this patch, so I plan on
merging it soon unless someone objects.
Jim

> ---
>  checkpolicy/policy_define.c | 184 ------------------------------------
>  checkpolicy/policy_define.h |   2 -
>  checkpolicy/policy_parse.y  |  14 ---
>  3 files changed, 200 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 8421b253..23a65339 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2926,190 +2926,6 @@ int define_roleattribute(void)
>         return 0;
>  }
>
> -role_datum_t *merge_roles_dom(role_datum_t * r1, role_datum_t * r2)
> -{
> -       role_datum_t *new;
> -
> -       if (pass =3D=3D 1) {
> -               return (role_datum_t *) 1;      /* any non-NULL value */
> -       }
> -
> -       new =3D malloc(sizeof(role_datum_t));
> -       if (!new) {
> -               yyerror("out of memory");
> -               return NULL;
> -       }
> -       memset(new, 0, sizeof(role_datum_t));
> -       new->s.value =3D 0;               /* temporary role */
> -       if (ebitmap_or(&new->dominates, &r1->dominates, &r2->dominates)) =
{
> -               yyerror("out of memory");
> -               free(new);
> -               return NULL;
> -       }
> -       if (ebitmap_or(&new->types.types, &r1->types.types, &r2->types.ty=
pes)) {
> -               yyerror("out of memory");
> -               free(new);
> -               return NULL;
> -       }
> -       if (!r1->s.value) {
> -               /* free intermediate result */
> -               type_set_destroy(&r1->types);
> -               ebitmap_destroy(&r1->dominates);
> -               free(r1);
> -       }
> -       if (!r2->s.value) {
> -               /* free intermediate result */
> -               yyerror("right hand role is temporary?");
> -               type_set_destroy(&r2->types);
> -               ebitmap_destroy(&r2->dominates);
> -               free(r2);
> -       }
> -       return new;
> -}
> -
> -/* This function eliminates the ordering dependency of role dominance ru=
le */
> -static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unuse=
d)),
> -                                hashtab_datum_t datum, void *arg)
> -{
> -       role_datum_t *rdp =3D (role_datum_t *) arg;
> -       role_datum_t *rdatum =3D (role_datum_t *) datum;
> -       ebitmap_node_t *node;
> -       uint32_t i;
> -
> -       /* Don't bother to process against self role */
> -       if (rdatum->s.value =3D=3D rdp->s.value)
> -               return 0;
> -
> -       /* If a dominating role found */
> -       if (ebitmap_get_bit(&(rdatum->dominates), rdp->s.value - 1)) {
> -               ebitmap_t types;
> -               ebitmap_init(&types);
> -               if (type_set_expand(&rdp->types, &types, policydbp, 1)) {
> -                       ebitmap_destroy(&types);
> -                       return -1;
> -               }
> -               /* raise types and dominates from dominated role */
> -               ebitmap_for_each_positive_bit(&rdp->dominates, node, i) {
> -                       if (ebitmap_set_bit(&rdatum->dominates, i, TRUE))
> -                               goto oom;
> -               }
> -               ebitmap_for_each_positive_bit(&types, node, i) {
> -                       if (ebitmap_set_bit(&rdatum->types.types, i, TRUE=
))
> -                               goto oom;
> -               }
> -               ebitmap_destroy(&types);
> -       }
> -
> -       /* go through all the roles */
> -       return 0;
> -      oom:
> -       yyerror("Out of memory");
> -       return -1;
> -}
> -
> -role_datum_t *define_role_dom(role_datum_t * r)
> -{
> -       role_datum_t *role;
> -       char *role_id;
> -       ebitmap_node_t *node;
> -       unsigned int i;
> -       int ret;
> -
> -       if (pass =3D=3D 1) {
> -               role_id =3D queue_remove(id_queue);
> -               free(role_id);
> -               return (role_datum_t *) 1;      /* any non-NULL value */
> -       }
> -
> -       yywarn("Role dominance has been deprecated");
> -
> -       role_id =3D queue_remove(id_queue);
> -       if (!is_id_in_scope(SYM_ROLES, role_id)) {
> -               yyerror2("role %s is not within scope", role_id);
> -               free(role_id);
> -               return NULL;
> -       }
> -       role =3D (role_datum_t *) hashtab_search(policydbp->p_roles.table=
,
> -                                              role_id);
> -       if (!role) {
> -               role =3D (role_datum_t *) malloc(sizeof(role_datum_t));
> -               if (!role) {
> -                       yyerror("out of memory");
> -                       free(role_id);
> -                       return NULL;
> -               }
> -               memset(role, 0, sizeof(role_datum_t));
> -               ret =3D
> -                   declare_symbol(SYM_ROLES, (hashtab_key_t) role_id,
> -                                  (hashtab_datum_t) role, &role->s.value=
,
> -                                  &role->s.value);
> -               switch (ret) {
> -               case -3:{
> -                               yyerror("Out of memory!");
> -                               goto cleanup;
> -                       }
> -               case -2:{
> -                               yyerror2("duplicate declaration of role %=
s",
> -                                        role_id);
> -                               goto cleanup;
> -                       }
> -               case -1:{
> -                               yyerror("could not declare role here");
> -                               goto cleanup;
> -                       }
> -               case 0:
> -               case 1:{
> -                               break;
> -                       }
> -               default:{
> -                               assert(0);      /* should never get here =
*/
> -                       }
> -               }
> -               if (ebitmap_set_bit(&role->dominates, role->s.value - 1, =
TRUE)) {
> -                       yyerror("Out of memory!");
> -                       goto cleanup;
> -               }
> -       }
> -       if (r) {
> -               ebitmap_t types;
> -               ebitmap_init(&types);
> -               ebitmap_for_each_positive_bit(&r->dominates, node, i) {
> -                       if (ebitmap_set_bit(&role->dominates, i, TRUE))
> -                               goto oom;
> -               }
> -               if (type_set_expand(&r->types, &types, policydbp, 1)) {
> -                       ebitmap_destroy(&types);
> -                       return NULL;
> -               }
> -               ebitmap_for_each_positive_bit(&types, node, i) {
> -                       if (ebitmap_set_bit(&role->types.types, i, TRUE))
> -                               goto oom;
> -               }
> -               ebitmap_destroy(&types);
> -               if (!r->s.value) {
> -                       /* free intermediate result */
> -                       type_set_destroy(&r->types);
> -                       ebitmap_destroy(&r->dominates);
> -                       free(r);
> -               }
> -               /*
> -                * Now go through all the roles and escalate this role's
> -                * dominates and types if a role dominates this role.
> -                */
> -               hashtab_map(policydbp->p_roles.table,
> -                           dominate_role_recheck, role);
> -       }
> -       return role;
> -      cleanup:
> -       free(role_id);
> -       role_datum_destroy(role);
> -       free(role);
> -       return NULL;
> -      oom:
> -       yyerror("Out of memory");
> -       goto cleanup;
> -}
> -
>  static int role_val_to_name_helper(hashtab_key_t key, hashtab_datum_t da=
tum,
>                                    void *p)
>  {
> diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> index c1314871..7c5a4e6c 100644
> --- a/checkpolicy/policy_define.h
> +++ b/checkpolicy/policy_define.h
> @@ -69,8 +69,6 @@ int define_validatetrans(constraint_expr_t *expr);
>  int expand_attrib(void);
>  int insert_id(const char *id,int push);
>  int insert_separator(int push);
> -role_datum_t *define_role_dom(role_datum_t *r);
> -role_datum_t *merge_roles_dom(role_datum_t *r1,role_datum_t *r2);
>  uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg=
2);
>
>  #endif /* _POLICY_DEFINE_H_ */
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 6b6890a3..02b076c7 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -76,7 +76,6 @@ typedef int (* require_func_t)(int pass);
>  %type <ptr> cond_expr cond_expr_prim cond_pol_list cond_else
>  %type <ptr> cond_allow_def cond_auditallow_def cond_auditdeny_def cond_d=
ontaudit_def
>  %type <ptr> cond_transition_def cond_te_avtab_def cond_rule_def
> -%type <ptr> role_def roles
>  %type <valptr> cexpr cexpr_prim op role_mls_op
>  %type <val> ipv4_addr_def number
>  %type <val64> number64
> @@ -312,7 +311,6 @@ te_rbac_decl                : te_decl
>                          ;
>  rbac_decl              : attribute_role_def
>                         | role_type_def
> -                        | role_dominance
>                          | role_trans_def
>                         | role_allow_def
>                         | roleattribute_def
> @@ -515,8 +513,6 @@ role_type_def               : ROLE identifier TYPES n=
ames ';'
>  role_attr_def          : ROLE identifier opt_attr_list ';'
>                         {if (define_role_attr()) return -1;}
>                          ;
> -role_dominance         : DOMINANCE '{' roles '}'
> -                       ;
>  role_trans_def         : ROLE_TRANSITION names names identifier ';'
>                         {if (define_role_trans(0)) return -1; }
>                         | ROLE_TRANSITION names names ':' names identifie=
r ';'
> @@ -525,16 +521,6 @@ role_trans_def             : ROLE_TRANSITION names n=
ames identifier ';'
>  role_allow_def         : ALLOW names names ';'
>                         {if (define_role_allow()) return -1; }
>                         ;
> -roles                  : role_def
> -                       { $$ =3D $1; }
> -                       | roles role_def
> -                       { $$ =3D merge_roles_dom((role_datum_t*)$1, (role=
_datum_t*)$2); if ($$ =3D=3D 0) return -1;}
> -                       ;
> -role_def               : ROLE identifier_push ';'
> -                        {$$ =3D define_role_dom(NULL); if ($$ =3D=3D 0) =
return -1;}
> -                       | ROLE identifier_push '{' roles '}'
> -                        {$$ =3D define_role_dom((role_datum_t*)$4); if (=
$$ =3D=3D 0) return -1;}
> -                       ;
>  roleattribute_def      : ROLEATTRIBUTE identifier id_comma_list ';'
>                         {if (define_roleattribute()) return -1;}
>                         ;
> --
> 2.41.0
>
