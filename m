Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607E1C433E6
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1891664FC9
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 20:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCJUPq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Mar 2021 15:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhCJUPg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Mar 2021 15:15:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E7BC061574
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 12:15:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t1so30046610eds.7
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FIwMkiIBivhNj4UbevKuwNOisfW/m8KnKTg73snCWE8=;
        b=KMbrvaCeP1QGUkMmRNTHAfJsRJZIlrIN4UAl61UGjkM9NJddg7l3pcaxeuWbKyfO4a
         Eb57ReNS5OJ1Mwd5BI5zinU7yeRMOkY0Uxgj0a12bPTpo1E0eJIqxDL1Vm14XgmWApIc
         72TLrbuALgpRzvolPxsfQDaJfRwIVpZIVPutMUjccDyIH4EziF58gqyrp1l7waEVfYDo
         Syr9uBv/zbPdCd8w4bT5tEwqPwkvslSCcENqyrn/b2vHQt+DtzqXwmZuhM+HnDFqO4eg
         yjnT28at17Rkh1aNfhQV8oaCVhGUUf7I61qMxDfnWGwGJm+4dlWCoYmGlf44NRHbeuG9
         jSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FIwMkiIBivhNj4UbevKuwNOisfW/m8KnKTg73snCWE8=;
        b=VwolnB4utXBBkUm5Otn1c582ynubdXFlKAP3EuVxHD/yQqm7LeYfct7wE7a5rewkao
         1DTP8K9f8MfsR65dtaTHO4t4bp8yP+RwuzfBJCzXRhz8DybNd/Ht6Vvk5rHJgV3v9ivn
         le1kFFcyFUsnMhe/xg3NzsFV7ztlSLjnOfIgp4JOqoaZnVVKRNROA2DbvBb9FzHQjJhz
         eL7XG83dr1Cz/i2nYvvVc5n0Vj48+H05dZoPiXM/Uk5NhelAbM2t3m/ZouzZNBkIyRPZ
         bEUqZxHdZb7dZTb4xgMoCwtmm3Kuz8kvwcibg5BW3794AUL/LWm7p+BuZ326jL9UFYBS
         4IqA==
X-Gm-Message-State: AOAM530pNq0DE1QTbWLIZiv7Z0whEIhXTf4z+0hZJJ8wUEsXGtFmF0e5
        oX/25D87sVXL0UI/hAqF0O5qEAGzP6I9NydRio8=
X-Google-Smtp-Source: ABdhPJzKVaYEonya8GUq2YtzF6FTWA5oszydfLo201QhoRqyh3xbwLqPOQunmxVbqEMY2sAUeVBWGlrmSMzwijGe7rI=
X-Received: by 2002:a50:cf48:: with SMTP id d8mr5400283edk.54.1615407334977;
 Wed, 10 Mar 2021 12:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20210310193012.166256-1-jwcart2@gmail.com>
In-Reply-To: <20210310193012.166256-1-jwcart2@gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 10 Mar 2021 21:15:24 +0100
Message-ID: <CAJ2a_DeSUHcBnXOTmTmexP_teYOz7Jt3zCNbKaHSS_V+fUs=EQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Expand role attributes in constraint expressions
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mi., 10. M=C3=A4rz 2021 um 20:30 Uhr schrieb James Carter <jwcart2@gmail=
.com>:
>
> When creating the kernel binary policy, role attributes in constraint
> expressions are not expanded. This causes the constraint expression
> to refer to a non-existent role in the kernel policy. This can lead
> to a segfault when converting the binary policy back to conf or CIL
> source or when using policy tools such as seinfo.
>
> Expand role attributes in constraint expressions when creating the
> kernel binary policy.


Thanks for the quick fix.
Tested role attribute constraints with bare 3.2, leading to setfiles
failing with `libsepol.validate_constraint_nodes: Invalid constraint
expr`.
Works fine with this patch.
Also seinfo does not crash on the newly generated policy anymore.

Tested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>


>
> Reported-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/expand.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index eac7e450..2d9cb566 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -71,6 +71,38 @@ static int map_ebitmap(ebitmap_t * src, ebitmap_t * ds=
t, uint32_t * map)
>         return 0;
>  }
>
> +static int ebitmap_expand_roles(policydb_t *p, ebitmap_t *roles)
> +{
> +       ebitmap_node_t *node;
> +       unsigned int bit;
> +       role_datum_t *role;
> +       ebitmap_t tmp;
> +
> +       ebitmap_init(&tmp);
> +       ebitmap_for_each_positive_bit(roles, node, bit) {
> +               role =3D p->role_val_to_struct[bit];
> +               assert(role);
> +               if (role->flavor !=3D ROLE_ATTRIB) {
> +                       if (ebitmap_set_bit(&tmp, bit, 1)) {
> +                               ebitmap_destroy(&tmp);
> +                               return -1;
> +                       }
> +               } else {
> +                       if (ebitmap_union(&tmp, &role->roles)) {
> +                               ebitmap_destroy(&tmp);
> +                               return -1;
> +                       }
> +               }
> +       }
> +       ebitmap_destroy(roles);
> +       if (ebitmap_cpy(roles, &tmp)) {
> +               ebitmap_destroy(&tmp);
> +               return -1;
> +       }
> +       ebitmap_destroy(&tmp);
> +       return 0;
> +}
> +
>  static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>                               void *data)
>  {
> @@ -333,6 +365,9 @@ static int constraint_node_clone(constraint_node_t **=
 dst,
>                                         if (map_ebitmap(&expr->names, &ne=
w_expr->names, state->rolemap)) {
>                                                 goto out_of_mem;
>                                         }
> +                                       if (ebitmap_expand_roles(state->o=
ut, &new_expr->names)) {
> +                                               goto out_of_mem;
> +                                       }
>                                 } else if (new_expr->attr & CEXPR_USER) {
>                                         if (map_ebitmap(&expr->names, &ne=
w_expr->names, state->usermap)) {
>                                                 goto out_of_mem;
> --
> 2.26.2
>
