Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A36C433EF
	for <selinux@archiver.kernel.org>; Fri, 11 Feb 2022 18:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiBKSkr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:40:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiBKSkr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Feb 2022 13:40:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30C227
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 10:40:45 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a8so24723867ejc.8
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGHpvVTXq48IAiFd+yjSQ21crV5EYOoLjwC8JEfYx5o=;
        b=khyOYaTIm5GE1ZYXYP0qWhCG35F0THBd59gACbVAo6jvXYM5gS6kgrfXGj9+EiSSbS
         8l3R5OoT4c5JS+efuaYaFMFFo3YQJrjtCP9cs3+Xkgta8UBc8tbQ0ClcLYTcIYUL9mWt
         fgqQfOpeVxx7w5JXqgo8GoMe6qqmC1GLn+IMkT2cTR3x/kzdupMQvtXpor6/1XxV+9uK
         K4K2l7SFHNd2OS4XkQ5ha/WufY3ue48xfAnKBFKV7hTAQrBsR8RIZVJbymGI7pI5yWIM
         Z+klUecdhGqUs0W7J1Jt8p7ZZ9yST7RQ5FH6MLM0rkB3QnFRCaZzkh2aJ4tj3tSIb6ru
         0V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGHpvVTXq48IAiFd+yjSQ21crV5EYOoLjwC8JEfYx5o=;
        b=VVUIDampYnvWZUkpgD4fQu3tIMzwS/m7NSNSdbnJAMVlXU4Vg9M02GB4A04YqEkp4Z
         uUwhsK30jAK8FO1qcbtanjF4AhEiVAkuEjil55EnT3pSOr0FNHZAzcx6YZPqTf9qmSaF
         MvUaMRl/Lky8YXUkBydMjHX+zQxMWgZ/bOIQD2SoS822STy+bgNuNdv8eNDe2NdPLEui
         TW+qxQ3vYztWPPHD0yNUovuqLdETdKhIaai2qFpo3v1jyqNcRuD0nT7lUUGhqGfjulqK
         CUG3fS+JNC3WYsS86RI0qkWNiZI1qRI5TYwuDNonW3E3fseidDUumbDVbZaHH100DO10
         TNNA==
X-Gm-Message-State: AOAM531qMSkcryBTICxazMS39Xq5B2AL3jKMfaEourLjwijpYOmMkx1j
        nBCFJli3JirLFeu75RXyRL7+Jb1JFw653X/4FlG5Mr5JS2U=
X-Google-Smtp-Source: ABdhPJwwvOwNkUaFSfxrrwKnipizbfamGrN0LOWQOdyTEwrrkdTZB0b3PEGt6t8hmP/5BHzCc4lrNcbAabepK0Uu8Ks=
X-Received: by 2002:a17:906:c10c:: with SMTP id do12mr2508067ejc.470.1644604843550;
 Fri, 11 Feb 2022 10:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20220204133717.27793-1-cgzones@googlemail.com> <20220210183823.39187-1-cgzones@googlemail.com>
In-Reply-To: <20220210183823.39187-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Feb 2022 13:40:32 -0500
Message-ID: <CAP+JOzR9C+2Weho74wNtJyt4_6SONPFyT=wfxb-jeu-6gcQ+eQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: allow wildcard permissions in constraints
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 11, 2022 at 11:19 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Allow all and complement permission sets in constraints, e.g.:
>
>     constrain service ~ { status } (...);
>     constrain service * (...);
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

>
> ---
>
> v2:
>    - do not set invalid permission bits
>    - omit constrain rules with an empty permission bitset
> ---
>  checkpolicy/policy_define.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index b2ae3263..16b78346 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3477,6 +3477,8 @@ static constraint_expr_t *constraint_expr_clone(con=
st constraint_expr_t * expr)
>         return NULL;
>  }
>
> +#define PERMISSION_MASK(nprim) ((nprim) =3D=3D PERM_SYMTAB_SIZE ? (~UINT=
32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
> +
>  int define_constraint(constraint_expr_t * expr)
>  {
>         struct constraint_node *node;
> @@ -3590,6 +3592,22 @@ int define_constraint(constraint_expr_t * expr)
>                         cladatum =3D policydbp->class_val_to_struct[i];
>                         node =3D cladatum->constraints;
>
> +                       if (strcmp(id, "*") =3D=3D 0) {
> +                               node->permissions =3D PERMISSION_MASK(cla=
datum->permissions.nprim);
> +                               continue;
> +                       }
> +
> +                       if (strcmp(id, "~") =3D=3D 0) {
> +                               node->permissions =3D ~node->permissions =
& PERMISSION_MASK(cladatum->permissions.nprim);
> +                               if (node->permissions =3D=3D 0) {
> +                                       yywarn("omitting constraint with =
no permission set");
> +                                       cladatum->constraints =3D node->n=
ext;
> +                                       constraint_expr_destroy(node->exp=
r);
> +                                       free(node);
> +                               }
> +                               continue;
> +                       }
> +
>                         perdatum =3D
>                             (perm_datum_t *) hashtab_search(cladatum->
>                                                             permissions.
> --
> 2.34.1
>
