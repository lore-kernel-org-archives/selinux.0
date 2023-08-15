Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D822C001DE
	for <selinux@archiver.kernel.org>; Tue, 15 Aug 2023 06:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjHOGwc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Aug 2023 02:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjHOGwI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Aug 2023 02:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E421987
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692082256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wyfeuJxa3I941giBPEqk3MhyhRHTd41DEXidXD29Kw=;
        b=GednLxsv5L9mmtSectASUOTh3YF4wzPVpc6L3jRvY/AOuveF0bWkEkP87SASzomK3COLr6
        Y1Gj/sfpyTlF83ng/KGmZS4HJpF6b9hthc2Ac0r6DBLXl3zuQT+F2Yo9lleOWsBG1LYWNE
        MyyAOdXMOiuMQu3we6MQrNMgfEYn1RI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-pcZBwpAMOweJ__OFT9kraQ-1; Tue, 15 Aug 2023 02:50:54 -0400
X-MC-Unique: pcZBwpAMOweJ__OFT9kraQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2724E3C13932;
        Tue, 15 Aug 2023 06:50:54 +0000 (UTC)
Received: from localhost (unknown [10.45.226.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6FACC15BAE;
        Tue, 15 Aug 2023 06:50:53 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Subject: Re: [PATCH] checkpolicy: Remove support for role dominance rules
In-Reply-To: <CAP+JOzTJSH+-z+7uMidazS+V+dHoLXr8fQH20yZ+WXY-BB3aXQ@mail.gmail.com>
References: <20230714173240.192987-1-jwcart2@gmail.com>
 <CAP+JOzTJSH+-z+7uMidazS+V+dHoLXr8fQH20yZ+WXY-BB3aXQ@mail.gmail.com>
Date:   Tue, 15 Aug 2023 08:50:53 +0200
Message-ID: <87sf8kbxyq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Jul 14, 2023 at 1:32=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
>>
>> Role dominance has been deprecated for a very, very long time (since
>> at least August 2008) and has never been used in any widely deployed
>> policy.
>>
>> Remove support for compiling role dominance rules.
>>
>> Support will remain, for now, in libsepol for backwards compatibility.
>>
>> Signed-off-by: James Carter <jwcart2@gmail.com>
>
> There should not be any controversy over this patch, so I plan on
> merging it soon unless someone objects.
> Jim

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

>
>> ---
>>  checkpolicy/policy_define.c | 184 ------------------------------------
>>  checkpolicy/policy_define.h |   2 -
>>  checkpolicy/policy_parse.y  |  14 ---
>>  3 files changed, 200 deletions(-)
>>
>> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
>> index 8421b253..23a65339 100644
>> --- a/checkpolicy/policy_define.c
>> +++ b/checkpolicy/policy_define.c
>> @@ -2926,190 +2926,6 @@ int define_roleattribute(void)
>>         return 0;
>>  }
>>
>> -role_datum_t *merge_roles_dom(role_datum_t * r1, role_datum_t * r2)
>> -{
>> -       role_datum_t *new;
>> -
>> -       if (pass =3D=3D 1) {
>> -               return (role_datum_t *) 1;      /* any non-NULL value */
>> -       }
>> -
>> -       new =3D malloc(sizeof(role_datum_t));
>> -       if (!new) {
>> -               yyerror("out of memory");
>> -               return NULL;
>> -       }
>> -       memset(new, 0, sizeof(role_datum_t));
>> -       new->s.value =3D 0;               /* temporary role */
>> -       if (ebitmap_or(&new->dominates, &r1->dominates, &r2->dominates))=
 {
>> -               yyerror("out of memory");
>> -               free(new);
>> -               return NULL;
>> -       }
>> -       if (ebitmap_or(&new->types.types, &r1->types.types, &r2->types.t=
ypes)) {
>> -               yyerror("out of memory");
>> -               free(new);
>> -               return NULL;
>> -       }
>> -       if (!r1->s.value) {
>> -               /* free intermediate result */
>> -               type_set_destroy(&r1->types);
>> -               ebitmap_destroy(&r1->dominates);
>> -               free(r1);
>> -       }
>> -       if (!r2->s.value) {
>> -               /* free intermediate result */
>> -               yyerror("right hand role is temporary?");
>> -               type_set_destroy(&r2->types);
>> -               ebitmap_destroy(&r2->dominates);
>> -               free(r2);
>> -       }
>> -       return new;
>> -}
>> -
>> -/* This function eliminates the ordering dependency of role dominance r=
ule */
>> -static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unus=
ed)),
>> -                                hashtab_datum_t datum, void *arg)
>> -{
>> -       role_datum_t *rdp =3D (role_datum_t *) arg;
>> -       role_datum_t *rdatum =3D (role_datum_t *) datum;
>> -       ebitmap_node_t *node;
>> -       uint32_t i;
>> -
>> -       /* Don't bother to process against self role */
>> -       if (rdatum->s.value =3D=3D rdp->s.value)
>> -               return 0;
>> -
>> -       /* If a dominating role found */
>> -       if (ebitmap_get_bit(&(rdatum->dominates), rdp->s.value - 1)) {
>> -               ebitmap_t types;
>> -               ebitmap_init(&types);
>> -               if (type_set_expand(&rdp->types, &types, policydbp, 1)) {
>> -                       ebitmap_destroy(&types);
>> -                       return -1;
>> -               }
>> -               /* raise types and dominates from dominated role */
>> -               ebitmap_for_each_positive_bit(&rdp->dominates, node, i) {
>> -                       if (ebitmap_set_bit(&rdatum->dominates, i, TRUE))
>> -                               goto oom;
>> -               }
>> -               ebitmap_for_each_positive_bit(&types, node, i) {
>> -                       if (ebitmap_set_bit(&rdatum->types.types, i, TRU=
E))
>> -                               goto oom;
>> -               }
>> -               ebitmap_destroy(&types);
>> -       }
>> -
>> -       /* go through all the roles */
>> -       return 0;
>> -      oom:
>> -       yyerror("Out of memory");
>> -       return -1;
>> -}
>> -
>> -role_datum_t *define_role_dom(role_datum_t * r)
>> -{
>> -       role_datum_t *role;
>> -       char *role_id;
>> -       ebitmap_node_t *node;
>> -       unsigned int i;
>> -       int ret;
>> -
>> -       if (pass =3D=3D 1) {
>> -               role_id =3D queue_remove(id_queue);
>> -               free(role_id);
>> -               return (role_datum_t *) 1;      /* any non-NULL value */
>> -       }
>> -
>> -       yywarn("Role dominance has been deprecated");
>> -
>> -       role_id =3D queue_remove(id_queue);
>> -       if (!is_id_in_scope(SYM_ROLES, role_id)) {
>> -               yyerror2("role %s is not within scope", role_id);
>> -               free(role_id);
>> -               return NULL;
>> -       }
>> -       role =3D (role_datum_t *) hashtab_search(policydbp->p_roles.tabl=
e,
>> -                                              role_id);
>> -       if (!role) {
>> -               role =3D (role_datum_t *) malloc(sizeof(role_datum_t));
>> -               if (!role) {
>> -                       yyerror("out of memory");
>> -                       free(role_id);
>> -                       return NULL;
>> -               }
>> -               memset(role, 0, sizeof(role_datum_t));
>> -               ret =3D
>> -                   declare_symbol(SYM_ROLES, (hashtab_key_t) role_id,
>> -                                  (hashtab_datum_t) role, &role->s.valu=
e,
>> -                                  &role->s.value);
>> -               switch (ret) {
>> -               case -3:{
>> -                               yyerror("Out of memory!");
>> -                               goto cleanup;
>> -                       }
>> -               case -2:{
>> -                               yyerror2("duplicate declaration of role =
%s",
>> -                                        role_id);
>> -                               goto cleanup;
>> -                       }
>> -               case -1:{
>> -                               yyerror("could not declare role here");
>> -                               goto cleanup;
>> -                       }
>> -               case 0:
>> -               case 1:{
>> -                               break;
>> -                       }
>> -               default:{
>> -                               assert(0);      /* should never get here=
 */
>> -                       }
>> -               }
>> -               if (ebitmap_set_bit(&role->dominates, role->s.value - 1,=
 TRUE)) {
>> -                       yyerror("Out of memory!");
>> -                       goto cleanup;
>> -               }
>> -       }
>> -       if (r) {
>> -               ebitmap_t types;
>> -               ebitmap_init(&types);
>> -               ebitmap_for_each_positive_bit(&r->dominates, node, i) {
>> -                       if (ebitmap_set_bit(&role->dominates, i, TRUE))
>> -                               goto oom;
>> -               }
>> -               if (type_set_expand(&r->types, &types, policydbp, 1)) {
>> -                       ebitmap_destroy(&types);
>> -                       return NULL;
>> -               }
>> -               ebitmap_for_each_positive_bit(&types, node, i) {
>> -                       if (ebitmap_set_bit(&role->types.types, i, TRUE))
>> -                               goto oom;
>> -               }
>> -               ebitmap_destroy(&types);
>> -               if (!r->s.value) {
>> -                       /* free intermediate result */
>> -                       type_set_destroy(&r->types);
>> -                       ebitmap_destroy(&r->dominates);
>> -                       free(r);
>> -               }
>> -               /*
>> -                * Now go through all the roles and escalate this role's
>> -                * dominates and types if a role dominates this role.
>> -                */
>> -               hashtab_map(policydbp->p_roles.table,
>> -                           dominate_role_recheck, role);
>> -       }
>> -       return role;
>> -      cleanup:
>> -       free(role_id);
>> -       role_datum_destroy(role);
>> -       free(role);
>> -       return NULL;
>> -      oom:
>> -       yyerror("Out of memory");
>> -       goto cleanup;
>> -}
>> -
>>  static int role_val_to_name_helper(hashtab_key_t key, hashtab_datum_t d=
atum,
>>                                    void *p)
>>  {
>> diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
>> index c1314871..7c5a4e6c 100644
>> --- a/checkpolicy/policy_define.h
>> +++ b/checkpolicy/policy_define.h
>> @@ -69,8 +69,6 @@ int define_validatetrans(constraint_expr_t *expr);
>>  int expand_attrib(void);
>>  int insert_id(const char *id,int push);
>>  int insert_separator(int push);
>> -role_datum_t *define_role_dom(role_datum_t *r);
>> -role_datum_t *merge_roles_dom(role_datum_t *r1,role_datum_t *r2);
>>  uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t ar=
g2);
>>
>>  #endif /* _POLICY_DEFINE_H_ */
>> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
>> index 6b6890a3..02b076c7 100644
>> --- a/checkpolicy/policy_parse.y
>> +++ b/checkpolicy/policy_parse.y
>> @@ -76,7 +76,6 @@ typedef int (* require_func_t)(int pass);
>>  %type <ptr> cond_expr cond_expr_prim cond_pol_list cond_else
>>  %type <ptr> cond_allow_def cond_auditallow_def cond_auditdeny_def cond_=
dontaudit_def
>>  %type <ptr> cond_transition_def cond_te_avtab_def cond_rule_def
>> -%type <ptr> role_def roles
>>  %type <valptr> cexpr cexpr_prim op role_mls_op
>>  %type <val> ipv4_addr_def number
>>  %type <val64> number64
>> @@ -312,7 +311,6 @@ te_rbac_decl                : te_decl
>>                          ;
>>  rbac_decl              : attribute_role_def
>>                         | role_type_def
>> -                        | role_dominance
>>                          | role_trans_def
>>                         | role_allow_def
>>                         | roleattribute_def
>> @@ -515,8 +513,6 @@ role_type_def               : ROLE identifier TYPES =
names ';'
>>  role_attr_def          : ROLE identifier opt_attr_list ';'
>>                         {if (define_role_attr()) return -1;}
>>                          ;
>> -role_dominance         : DOMINANCE '{' roles '}'
>> -                       ;
>>  role_trans_def         : ROLE_TRANSITION names names identifier ';'
>>                         {if (define_role_trans(0)) return -1; }
>>                         | ROLE_TRANSITION names names ':' names identifi=
er ';'
>> @@ -525,16 +521,6 @@ role_trans_def             : ROLE_TRANSITION names =
names identifier ';'
>>  role_allow_def         : ALLOW names names ';'
>>                         {if (define_role_allow()) return -1; }
>>                         ;
>> -roles                  : role_def
>> -                       { $$ =3D $1; }
>> -                       | roles role_def
>> -                       { $$ =3D merge_roles_dom((role_datum_t*)$1, (rol=
e_datum_t*)$2); if ($$ =3D=3D 0) return -1;}
>> -                       ;
>> -role_def               : ROLE identifier_push ';'
>> -                        {$$ =3D define_role_dom(NULL); if ($$ =3D=3D 0)=
 return -1;}
>> -                       | ROLE identifier_push '{' roles '}'
>> -                        {$$ =3D define_role_dom((role_datum_t*)$4); if =
($$ =3D=3D 0) return -1;}
>> -                       ;
>>  roleattribute_def      : ROLEATTRIBUTE identifier id_comma_list ';'
>>                         {if (define_roleattribute()) return -1;}
>>                         ;
>> --
>> 2.41.0
>>

