Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A4DC00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiHHRJ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiHHRJz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:09:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615ACDF2A
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:09:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j5so5351162oih.6
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Y3z+ekiMjEvMcNq/8/Rkbg9gleh0sDv8rHs86wxqrZg=;
        b=Fpnsj2DfbzRrZlFqW+hKPIvKb5vNW1nsBzDO8M7s6Q0mIYqKyX351K4/uH7sPiybtk
         k9TtHhvbfVDVMgRhcFHcKQ+1mi+30Th9n0ZqZ7g7vDCWQlV+W3fZjCRIk1fsdslfFBTC
         wM8O+C70wPS+Lh6IHQaGz8LkUgzg4qL9MaMJsK3OBsB9kwc4W74nWDYqmbqCp+mcbDJy
         dtQ3L3DIBHDdLlWhkHyNApg/JPSGIx2H4qsBF8Un+UOCqdhl2KyLsADbLoQ0HbT+4vaS
         2vjtwRNOc3JWR2OOOvZQe7nn336rQ3N7C4C3D+kpzXTBdWhNSVn4XBmeJc/un5KXhghx
         RhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Y3z+ekiMjEvMcNq/8/Rkbg9gleh0sDv8rHs86wxqrZg=;
        b=mGs9bLFloP1YOLtaJStrshN57YpBg+/s8LAUA5EwEToz33471Pzz5O0OHmaIh+4GWL
         yJgBMmGAkoS5pE0jvb+dnLnPt9XilCJ+JiZFRHJOjIUe2dGG3ofqq1QQhdSmAhzhUf0E
         yGbCHopTCFKP6R1vM83I0rhif+Kweh+iz+Kgap5Xfcmtbs8VAc0eNr5WQ6jc/oQJ8nJE
         1PW+9SHb3rLJdX5t2VlbaZdaQr7Jk5vfqGzV5uJFNut6HYQj9dld3VGIgn03pRNmgp4Z
         ZGQ7VcXG1BSMQSHGEbggrwdII0HlqJvn5iOZTS7a6+qI4/60TkaEr6EIKwbGLAEdJuqk
         4ZMQ==
X-Gm-Message-State: ACgBeo0dfp//RemCRBWEukT8yXLxrTS9JuQHuCQzt1TJafxIZQ8ii/nC
        XyrBgTm8TTMTUVCDmiUU5yf+nTXGTIdYAKbi6WtTeviB
X-Google-Smtp-Source: AA6agR7sM9SLPXnim5Shz+sawvUiuYsIDqge6jiRhnwhkb3vrQkdZR0r6ZIuh0U2vImq7u7rTg7Tr0LF1sfENu7MynM=
X-Received: by 2002:a05:6808:2091:b0:342:c50e:a2ef with SMTP id
 s17-20020a056808209100b00342c50ea2efmr5906773oiw.182.1659978581682; Mon, 08
 Aug 2022 10:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com> <20220721150515.19843-4-cgzones@googlemail.com>
In-Reply-To: <20220721150515.19843-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Aug 2022 13:09:30 -0400
Message-ID: <CAP+JOzTZeqY10FX8znd0bReEkszhE33YtLB0-_JDvzfHdi6fNA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] checkpolicy: add front-end support for segregate attributes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Support specifying segregate attributes.
>
> The following two blocks are equivalent:
>
>     segregate_attributes attr1, attr2, attr3;
>
>     segregate_attributes attr1, attr2;
>     segregate_attributes attr1, attr3;
>     segregate_attributes attr2, attr3;
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/policy_define.c | 66 +++++++++++++++++++++++++++++++++++++
>  checkpolicy/policy_define.h |  1 +
>  checkpolicy/policy_parse.y  |  5 +++
>  checkpolicy/policy_scan.l   |  2 ++
>  4 files changed, 74 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 8bf36859..cf6fbf08 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1220,6 +1220,72 @@ exit:
>         return rc;
>  }
>
> +int define_segregate_attributes(void)
> +{
> +       char *id =3D NULL;
> +       segregate_attributes_rule_t *sattr =3D NULL;
> +       int rc =3D -1;
> +
> +       if (pass =3D=3D 1) {
> +               while ((id =3D queue_remove(id_queue)))
> +                       free(id);
> +               return 0;
> +       }
> +
> +       sattr =3D malloc(sizeof(segregate_attributes_rule_t));
> +       if (!sattr) {
> +               yyerror("Out of memory!");
> +               goto exit;
> +       }
> +
> +       ebitmap_init(&sattr->attrs);
> +
> +       while ((id =3D queue_remove(id_queue))) {
> +               const type_datum_t *attr;
> +
> +               if (!is_id_in_scope(SYM_TYPES, id)) {
> +                       yyerror2("attribute %s is not within scope", id);
> +                       goto exit;
> +               }
> +
> +               attr =3D hashtab_search(policydbp->p_types.table, id);
> +               if (!attr) {
> +                       yyerror2("attribute %s is not declared", id);
> +                       goto exit;
> +               }
> +
> +               if (attr->flavor !=3D TYPE_ATTRIB) {
> +                       yyerror2("%s is a type, not an attribute", id);
> +                       goto exit;
> +               }
> +

It seems like it would be useful to check a type, so an error would be
given if the type is associated with the attribute.

> +               if (ebitmap_get_bit(&sattr->attrs, attr->s.value - 1)) {
> +                       yyerror2("attribute %s used multiple times", id);
> +                       goto exit;
> +               }
> +
> +               if (ebitmap_set_bit(&sattr->attrs, attr->s.value - 1, TRU=
E)) {
> +                       yyerror("Out of memory!");
> +                       goto exit;
> +               }
> +
> +               free(id);
> +       }
> +
> +       sattr->next =3D policydbp->segregate_attributes;
> +       policydbp->segregate_attributes =3D sattr;
> +
> +       sattr =3D NULL;
> +       rc =3D 0;
> +exit:
> +       if (sattr) {
> +               ebitmap_destroy(&sattr->attrs);
> +               free(sattr);
> +       }
> +       free(id);
> +       return rc;
> +}
> +
>  static int add_aliases_to_type(type_datum_t * type)
>  {
>         char *id;
> diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> index 50a7ba78..f55d0b17 100644
> --- a/checkpolicy/policy_define.h
> +++ b/checkpolicy/policy_define.h
> @@ -68,6 +68,7 @@ int define_type(int alias);
>  int define_user(void);
>  int define_validatetrans(constraint_expr_t *expr);
>  int expand_attrib(void);
> +int define_segregate_attributes(void);
>  int insert_id(const char *id,int push);
>  int insert_separator(int push);
>  role_datum_t *define_role_dom(role_datum_t *r);
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 45f973ff..acd6096d 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -104,6 +104,7 @@ typedef int (* require_func_t)(int pass);
>  %token ALIAS
>  %token ATTRIBUTE
>  %token EXPANDATTRIBUTE
> +%token SEGREGATEATTRIBUTES
>  %token BOOL
>  %token TUNABLE
>  %token IF
> @@ -320,6 +321,7 @@ rbac_decl           : attribute_role_def
>                         ;
>  te_decl                        : attribute_def
>                          | expandattribute_def
> +                        | segregateattributes_def
>                          | type_def
>                          | typealias_def
>                          | typeattribute_def
> @@ -337,6 +339,9 @@ attribute_def           : ATTRIBUTE identifier ';'
>  expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
>                          { if (expand_attrib()) return -1;}
>                          ;
> +segregateattributes_def : SEGREGATEATTRIBUTES identifier ',' id_comma_li=
st ';'
> +                        { if (define_segregate_attributes()) return -1;}
> +

I don't see the need for comparing more than two at a time.

Something like:
disjoint_types attr1 attr2;

Thanks,
Jim

                       ;
>  type_def               : TYPE identifier alias_def opt_attr_list ';'
>                          {if (define_type(1)) return -1;}
>                         | TYPE identifier opt_attr_list ';'
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 9fefea7b..d865dcb6 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -123,6 +123,8 @@ ATTRIBUTE |
>  attribute                      { return(ATTRIBUTE); }
>  EXPANDATTRIBUTE |
>  expandattribute                 { return(EXPANDATTRIBUTE); }
> +SEGREGATE_ATTRIBUTES |
> +segregate_attributes           { return(SEGREGATEATTRIBUTES); }
>  TYPE_TRANSITION |
>  type_transition                        { return(TYPE_TRANSITION); }
>  TYPE_MEMBER |
> --
> 2.36.1
>
