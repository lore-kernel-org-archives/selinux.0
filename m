Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B5EB64DD
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjHKQim (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKQim (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:38:42 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3828D2D79
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:38:41 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-79414715edeso528797241.0
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771920; x=1692376720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOSSu2Hpg+lI/n/laHqvk49ZJll6AYVODmcT1+VVWXI=;
        b=Y9IHJVkN0uSF8OWeLhgUN0T3kXq0acrxcaR4fH4l8GaXNCGZTlIEtHQhamjjQWKujZ
         lAhcxelKue08CCRs8kZ4mQnpsHvjNieqzl1rgY0r0o8isGcyE24yT/gTBqO69XY228yY
         Z5uKpn9+EWUVqKedKjPrNqupB31P7oYC9SiyJRzZZg470Sblz88Y6st8xRTGy9HljFk6
         7ntcOi1IB596lSiDeVGD4vaj+dRosywyvgGWknciWGI6dmY4ZcSot8Thak01LWp27oXq
         xRAlLaWoLYvBMYd7dxvzSyVkm4C7vW2TsNYQiCnUs0hPRVHN8tV19g8w3zSVqEywZH/3
         E3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771920; x=1692376720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOSSu2Hpg+lI/n/laHqvk49ZJll6AYVODmcT1+VVWXI=;
        b=IsxLwD4qlp39mq6tg26BTeIFrOxl+8n2bvb4OKp7y36zuAHB3ebVQVjLvLoe2WTQOQ
         PDfPMfWm889STj3nkIUJvbDkh4hmQNETRcSEbjyfj0zKjSwlilBCFY2LrLlY/USpK+P+
         PW1Blb57QO68dOh/xZG3WJv3RCijN2+95XpdgyTJs3NAel2YFUMSeHHccfOhSTarejmc
         eAk7foNR33ifKTNH7DP8duAo+Y+5O9FWbbaVWxWfITFDDD3we5D4LJZUS3p9cl1Do5ad
         Jymi2qrSoDOJnopR4JvjGj8Z7F1A9gnSGn5hvTr8ycc+dNDrdglxU6tmRK55mhmYwsgx
         UJVA==
X-Gm-Message-State: AOJu0Yz/7+F/L4kPPPTE+XlCy313OShVqvx1F16YPtHYLb6Km2qxwIv7
        Mi+phKvIeNIanX5LFjRdn6Agf4SlasmJVPlpXPg=
X-Google-Smtp-Source: AGHT+IFU7SeZ1XuS0lzgv1Zjt6XGhRgNYDQ7OQNhMqV6+J1INAN/VRjbJ9xF1iIJM6zjRSYlo+9HdLnJd8bIM7K9Gik=
X-Received: by 2002:a67:e2ce:0:b0:443:7eba:e22c with SMTP id
 i14-20020a67e2ce000000b004437ebae22cmr1049466vsm.8.1691771920188; Fri, 11 Aug
 2023 09:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com>
 <20220721150515.19843-4-cgzones@googlemail.com> <CAP+JOzTZeqY10FX8znd0bReEkszhE33YtLB0-_JDvzfHdi6fNA@mail.gmail.com>
In-Reply-To: <CAP+JOzTZeqY10FX8znd0bReEkszhE33YtLB0-_JDvzfHdi6fNA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 11 Aug 2023 18:38:29 +0200
Message-ID: <CAJ2a_DcOeDWotazAexEKGh8rLs69F8BkRRNUu8e39mDCBmvJ1w@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] checkpolicy: add front-end support for segregate attributes
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 8 Aug 2022 at 19:09, James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Support specifying segregate attributes.
> >
> > The following two blocks are equivalent:
> >
> >     segregate_attributes attr1, attr2, attr3;
> >
> >     segregate_attributes attr1, attr2;
> >     segregate_attributes attr1, attr3;
> >     segregate_attributes attr2, attr3;
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  checkpolicy/policy_define.c | 66 +++++++++++++++++++++++++++++++++++++
> >  checkpolicy/policy_define.h |  1 +
> >  checkpolicy/policy_parse.y  |  5 +++
> >  checkpolicy/policy_scan.l   |  2 ++
> >  4 files changed, 74 insertions(+)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 8bf36859..cf6fbf08 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1220,6 +1220,72 @@ exit:
> >         return rc;
> >  }
> >
> > +int define_segregate_attributes(void)
> > +{
> > +       char *id =3D NULL;
> > +       segregate_attributes_rule_t *sattr =3D NULL;
> > +       int rc =3D -1;
> > +
> > +       if (pass =3D=3D 1) {
> > +               while ((id =3D queue_remove(id_queue)))
> > +                       free(id);
> > +               return 0;
> > +       }
> > +
> > +       sattr =3D malloc(sizeof(segregate_attributes_rule_t));
> > +       if (!sattr) {
> > +               yyerror("Out of memory!");
> > +               goto exit;
> > +       }
> > +
> > +       ebitmap_init(&sattr->attrs);
> > +
> > +       while ((id =3D queue_remove(id_queue))) {
> > +               const type_datum_t *attr;
> > +
> > +               if (!is_id_in_scope(SYM_TYPES, id)) {
> > +                       yyerror2("attribute %s is not within scope", id=
);
> > +                       goto exit;
> > +               }
> > +
> > +               attr =3D hashtab_search(policydbp->p_types.table, id);
> > +               if (!attr) {
> > +                       yyerror2("attribute %s is not declared", id);
> > +                       goto exit;
> > +               }
> > +
> > +               if (attr->flavor !=3D TYPE_ATTRIB) {
> > +                       yyerror2("%s is a type, not an attribute", id);
> > +                       goto exit;
> > +               }
> > +
>
> It seems like it would be useful to check a type, so an error would be
> given if the type is associated with the attribute.
>

I am not exactly sure what you mean.
Do you like to have a policy statement like

    nevertypeattribute TYPE ATTRIBUTE;

that checks at compile time a type is not associated with an attribute?

> > +               if (ebitmap_get_bit(&sattr->attrs, attr->s.value - 1)) =
{
> > +                       yyerror2("attribute %s used multiple times", id=
);
> > +                       goto exit;
> > +               }
> > +
> > +               if (ebitmap_set_bit(&sattr->attrs, attr->s.value - 1, T=
RUE)) {
> > +                       yyerror("Out of memory!");
> > +                       goto exit;
> > +               }
> > +
> > +               free(id);
> > +       }
> > +
> > +       sattr->next =3D policydbp->segregate_attributes;
> > +       policydbp->segregate_attributes =3D sattr;
> > +
> > +       sattr =3D NULL;
> > +       rc =3D 0;
> > +exit:
> > +       if (sattr) {
> > +               ebitmap_destroy(&sattr->attrs);
> > +               free(sattr);
> > +       }
> > +       free(id);
> > +       return rc;
> > +}
> > +
> >  static int add_aliases_to_type(type_datum_t * type)
> >  {
> >         char *id;
> > diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> > index 50a7ba78..f55d0b17 100644
> > --- a/checkpolicy/policy_define.h
> > +++ b/checkpolicy/policy_define.h
> > @@ -68,6 +68,7 @@ int define_type(int alias);
> >  int define_user(void);
> >  int define_validatetrans(constraint_expr_t *expr);
> >  int expand_attrib(void);
> > +int define_segregate_attributes(void);
> >  int insert_id(const char *id,int push);
> >  int insert_separator(int push);
> >  role_datum_t *define_role_dom(role_datum_t *r);
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 45f973ff..acd6096d 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -104,6 +104,7 @@ typedef int (* require_func_t)(int pass);
> >  %token ALIAS
> >  %token ATTRIBUTE
> >  %token EXPANDATTRIBUTE
> > +%token SEGREGATEATTRIBUTES
> >  %token BOOL
> >  %token TUNABLE
> >  %token IF
> > @@ -320,6 +321,7 @@ rbac_decl           : attribute_role_def
> >                         ;
> >  te_decl                        : attribute_def
> >                          | expandattribute_def
> > +                        | segregateattributes_def
> >                          | type_def
> >                          | typealias_def
> >                          | typeattribute_def
> > @@ -337,6 +339,9 @@ attribute_def           : ATTRIBUTE identifier ';'
> >  expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
> >                          { if (expand_attrib()) return -1;}
> >                          ;
> > +segregateattributes_def : SEGREGATEATTRIBUTES identifier ',' id_comma_=
list ';'
> > +                        { if (define_segregate_attributes()) return -1=
;}
> > +
>
> I don't see the need for comparing more than two at a time.
>
> Something like:
> disjoint_types attr1 attr2;

That would lead to quadratic growth of statements, for example in the
Reference Policy example of

    ibendport_type, packet_type, sysctl_type, device_node,
ibpkey_type, sysfs_types, domain, boolean_type, netif_type, file_type,
node_type, proc_type, port_type

Also one could see supporting more than two attributes as syntactic
sugar, which the traditional language already supports, e.g.

    allow { TYPE1 TYPE2 } { TYPE3 TYPE4 } : { CLASS1 CLASS2 } perm_list;

>
> Thanks,
> Jim
>
>                        ;
> >  type_def               : TYPE identifier alias_def opt_attr_list ';'
> >                          {if (define_type(1)) return -1;}
> >                         | TYPE identifier opt_attr_list ';'
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 9fefea7b..d865dcb6 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -123,6 +123,8 @@ ATTRIBUTE |
> >  attribute                      { return(ATTRIBUTE); }
> >  EXPANDATTRIBUTE |
> >  expandattribute                 { return(EXPANDATTRIBUTE); }
> > +SEGREGATE_ATTRIBUTES |
> > +segregate_attributes           { return(SEGREGATEATTRIBUTES); }
> >  TYPE_TRANSITION |
> >  type_transition                        { return(TYPE_TRANSITION); }
> >  TYPE_MEMBER |
> > --
> > 2.36.1
> >
