Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0724AC001B0
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 19:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjHKTsw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKTsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 15:48:51 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423BAEE
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 12:48:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso36195621fa.0
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691783328; x=1692388128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADVXWoGI4Z6TKyB/rrgxbm6tPsWrzk3G8eqPYJ9CuYM=;
        b=EmHmar3weTi5BxzF81x6MXnh+vFrNDV+AreKiKQ8sEY1Rz8Lr+XbahmDsMFWaGj9/N
         co3VRIkWrKNdfxVafu8iJKZZcUSw4U1edxwpQMp2i3b1qd9TkwN/Qco6JKrXuixW5StG
         SM7NCAxHDsiYGKpS55VYNcmHiHBsFOp4KC0/myQzm4H40/J+5rxPZxETTv1Hja3oJwT/
         WzA2i5EfMvg68jYPR8JQ+94IxcI5hndgU4lI6EoVlKCL7Zkvqs4vTr5Y53ReSfm9hidx
         dMgImizWiMRaKc+Atlb/asktn09ygUvamKv5xlxKQD2ZubZbMCiO5f91tJ6OWGvMZWfs
         719w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691783328; x=1692388128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADVXWoGI4Z6TKyB/rrgxbm6tPsWrzk3G8eqPYJ9CuYM=;
        b=BfDxolMIlq9UPX1DJMG+JqZbLqGsXi0D8wPudunSbUangIfoPMlknaJdNPvhVKfnOK
         tOkzn2JBdJce/m31lFU2qgnFrjByo8OYj8ubsIWImUquwzz5qY19/PC10llLAYSsOaTM
         xC3Ruz5mEweA6+nd6fqFOAAR/fszRzwhsc6HRNQ+ju4OoOrST2ABvniFC/vfqRr89wfK
         ocUB7EJ1mocwSwQ07BAl9jvlbt0GSYAC67YHQgsa8wxLpOwIrzp7Lapo3pfzCjijXrYZ
         +Q1dnVwfdr/dUyryc25z0EywulMAhbBpI24hkQlHSHEhYCgoijTJGXN4hq9DDeUyj9MQ
         RjeA==
X-Gm-Message-State: AOJu0Yxkk9CW7MvoxPgXlXiTOYrMo0GRHtwYPKqnmdHg3x3dT1MjKPFk
        aKAy6o8vQ2sZ42fHovta/nIdL2rCaTyfzGJ5rY6BXFUf
X-Google-Smtp-Source: AGHT+IGurDJztEe66l4VHozcHSFKtiZgcjXGPY2QX0VlvVAcdZL4R+JmoccX5K3vGdramaJn3/L6uFBdADIrqX9t+Qw=
X-Received: by 2002:a2e:809a:0:b0:2b9:b41a:aa66 with SMTP id
 i26-20020a2e809a000000b002b9b41aaa66mr2463483ljg.20.1691783328092; Fri, 11
 Aug 2023 12:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com>
 <20220721150515.19843-4-cgzones@googlemail.com> <CAP+JOzTZeqY10FX8znd0bReEkszhE33YtLB0-_JDvzfHdi6fNA@mail.gmail.com>
 <CAJ2a_DcOeDWotazAexEKGh8rLs69F8BkRRNUu8e39mDCBmvJ1w@mail.gmail.com>
In-Reply-To: <CAJ2a_DcOeDWotazAexEKGh8rLs69F8BkRRNUu8e39mDCBmvJ1w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Aug 2023 15:48:36 -0400
Message-ID: <CAP+JOzS3K46j=rFt8m80ScGjqZgwXspcmEYXTK-LQDMzanbQxw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] checkpolicy: add front-end support for segregate attributes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 11, 2023 at 12:38=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 8 Aug 2022 at 19:09, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Support specifying segregate attributes.
> > >
> > > The following two blocks are equivalent:
> > >
> > >     segregate_attributes attr1, attr2, attr3;
> > >
> > >     segregate_attributes attr1, attr2;
> > >     segregate_attributes attr1, attr3;
> > >     segregate_attributes attr2, attr3;
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  checkpolicy/policy_define.c | 66 +++++++++++++++++++++++++++++++++++=
++
> > >  checkpolicy/policy_define.h |  1 +
> > >  checkpolicy/policy_parse.y  |  5 +++
> > >  checkpolicy/policy_scan.l   |  2 ++
> > >  4 files changed, 74 insertions(+)
> > >
> > > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.=
c
> > > index 8bf36859..cf6fbf08 100644
> > > --- a/checkpolicy/policy_define.c
> > > +++ b/checkpolicy/policy_define.c
> > > @@ -1220,6 +1220,72 @@ exit:
> > >         return rc;
> > >  }
> > >
> > > +int define_segregate_attributes(void)
> > > +{
> > > +       char *id =3D NULL;
> > > +       segregate_attributes_rule_t *sattr =3D NULL;
> > > +       int rc =3D -1;
> > > +
> > > +       if (pass =3D=3D 1) {
> > > +               while ((id =3D queue_remove(id_queue)))
> > > +                       free(id);
> > > +               return 0;
> > > +       }
> > > +
> > > +       sattr =3D malloc(sizeof(segregate_attributes_rule_t));
> > > +       if (!sattr) {
> > > +               yyerror("Out of memory!");
> > > +               goto exit;
> > > +       }
> > > +
> > > +       ebitmap_init(&sattr->attrs);
> > > +
> > > +       while ((id =3D queue_remove(id_queue))) {
> > > +               const type_datum_t *attr;
> > > +
> > > +               if (!is_id_in_scope(SYM_TYPES, id)) {
> > > +                       yyerror2("attribute %s is not within scope", =
id);
> > > +                       goto exit;
> > > +               }
> > > +
> > > +               attr =3D hashtab_search(policydbp->p_types.table, id)=
;
> > > +               if (!attr) {
> > > +                       yyerror2("attribute %s is not declared", id);
> > > +                       goto exit;
> > > +               }
> > > +
> > > +               if (attr->flavor !=3D TYPE_ATTRIB) {
> > > +                       yyerror2("%s is a type, not an attribute", id=
);
> > > +                       goto exit;
> > > +               }
> > > +
> >
> > It seems like it would be useful to check a type, so an error would be
> > given if the type is associated with the attribute.
> >
>
> I am not exactly sure what you mean.
> Do you like to have a policy statement like
>
>     nevertypeattribute TYPE ATTRIBUTE;
>
> that checks at compile time a type is not associated with an attribute?
>
> > > +               if (ebitmap_get_bit(&sattr->attrs, attr->s.value - 1)=
) {
> > > +                       yyerror2("attribute %s used multiple times", =
id);
> > > +                       goto exit;
> > > +               }
> > > +
> > > +               if (ebitmap_set_bit(&sattr->attrs, attr->s.value - 1,=
 TRUE)) {
> > > +                       yyerror("Out of memory!");
> > > +                       goto exit;
> > > +               }
> > > +
> > > +               free(id);
> > > +       }
> > > +
> > > +       sattr->next =3D policydbp->segregate_attributes;
> > > +       policydbp->segregate_attributes =3D sattr;
> > > +
> > > +       sattr =3D NULL;
> > > +       rc =3D 0;
> > > +exit:
> > > +       if (sattr) {
> > > +               ebitmap_destroy(&sattr->attrs);
> > > +               free(sattr);
> > > +       }
> > > +       free(id);
> > > +       return rc;
> > > +}
> > > +
> > >  static int add_aliases_to_type(type_datum_t * type)
> > >  {
> > >         char *id;
> > > diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.=
h
> > > index 50a7ba78..f55d0b17 100644
> > > --- a/checkpolicy/policy_define.h
> > > +++ b/checkpolicy/policy_define.h
> > > @@ -68,6 +68,7 @@ int define_type(int alias);
> > >  int define_user(void);
> > >  int define_validatetrans(constraint_expr_t *expr);
> > >  int expand_attrib(void);
> > > +int define_segregate_attributes(void);
> > >  int insert_id(const char *id,int push);
> > >  int insert_separator(int push);
> > >  role_datum_t *define_role_dom(role_datum_t *r);
> > > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > > index 45f973ff..acd6096d 100644
> > > --- a/checkpolicy/policy_parse.y
> > > +++ b/checkpolicy/policy_parse.y
> > > @@ -104,6 +104,7 @@ typedef int (* require_func_t)(int pass);
> > >  %token ALIAS
> > >  %token ATTRIBUTE
> > >  %token EXPANDATTRIBUTE
> > > +%token SEGREGATEATTRIBUTES
> > >  %token BOOL
> > >  %token TUNABLE
> > >  %token IF
> > > @@ -320,6 +321,7 @@ rbac_decl           : attribute_role_def
> > >                         ;
> > >  te_decl                        : attribute_def
> > >                          | expandattribute_def
> > > +                        | segregateattributes_def
> > >                          | type_def
> > >                          | typealias_def
> > >                          | typeattribute_def
> > > @@ -337,6 +339,9 @@ attribute_def           : ATTRIBUTE identifier ';=
'
> > >  expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
> > >                          { if (expand_attrib()) return -1;}
> > >                          ;
> > > +segregateattributes_def : SEGREGATEATTRIBUTES identifier ',' id_comm=
a_list ';'
> > > +                        { if (define_segregate_attributes()) return =
-1;}
> > > +
> >
> > I don't see the need for comparing more than two at a time.
> >
> > Something like:
> > disjoint_types attr1 attr2;
>
> That would lead to quadratic growth of statements, for example in the
> Reference Policy example of
>
>     ibendport_type, packet_type, sysctl_type, device_node,
> ibpkey_type, sysfs_types, domain, boolean_type, netif_type, file_type,
> node_type, proc_type, port_type
>
> Also one could see supporting more than two attributes as syntactic
> sugar, which the traditional language already supports, e.g.
>
>     allow { TYPE1 TYPE2 } { TYPE3 TYPE4 } : { CLASS1 CLASS2 } perm_list;
>

The case above would be a pain to do and making it a list would be
better. I guess using a list is not that big of a deal.

The problem with checking that attributes are disjoint is that it does
not tell me *why* they should be disjoint.
It would be better to use more neverallow rules because they express
the goals of the security policy.
If a neverallow rule cannot be written to say why two attributes
should be disjoint, then either the policy is not fine-grained enough
for it to matter or there is a problem with the policy.

Jim


> >
> > Thanks,
> > Jim
> >
> >                        ;
> > >  type_def               : TYPE identifier alias_def opt_attr_list ';'
> > >                          {if (define_type(1)) return -1;}
> > >                         | TYPE identifier opt_attr_list ';'
> > > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > > index 9fefea7b..d865dcb6 100644
> > > --- a/checkpolicy/policy_scan.l
> > > +++ b/checkpolicy/policy_scan.l
> > > @@ -123,6 +123,8 @@ ATTRIBUTE |
> > >  attribute                      { return(ATTRIBUTE); }
> > >  EXPANDATTRIBUTE |
> > >  expandattribute                 { return(EXPANDATTRIBUTE); }
> > > +SEGREGATE_ATTRIBUTES |
> > > +segregate_attributes           { return(SEGREGATEATTRIBUTES); }
> > >  TYPE_TRANSITION |
> > >  type_transition                        { return(TYPE_TRANSITION); }
> > >  TYPE_MEMBER |
> > > --
> > > 2.36.1
> > >
