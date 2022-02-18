Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1B8C433EF
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiBRVQd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:16:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiBRVQX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 16:16:23 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD828B639
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:16:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s5so4446637oic.10
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l2IMpqNE1QUKWW25tQvn4MoStzE0ELe6ocRGL/Xq/ns=;
        b=F9u2VfOkbkhtLafNPsIba9/GoWdnmzKtMz5ebWezYAqdxnK6sRx+6kQintXyWVbgTP
         F4ocl2VklrCjmQYNcc5jUpKGPr5nMcto8WPID6WkwhofCh/+IiAh7QNGb+JafUyVa1wt
         b0WvKu5rexI3ZNZRH5LICv5+NMlLATRVMwffthXFDTkchHnPK3lRXwu42FFakdkJ4snY
         x5K63MeU9How76otQZl3ppsnPvsVMui0LEEQ7L2m5LP8Juh0EdKb7gAuv6b2FVes64o/
         Or6bxdbp8UwzsutF5+g+DN5McvbD3dBCuKV5eADqTxPdF1UTVeMuCEpO3Rn9CXmMshx+
         0NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l2IMpqNE1QUKWW25tQvn4MoStzE0ELe6ocRGL/Xq/ns=;
        b=CmLRZ9XozwkU83I3YrShAOzKQWwQ/eW59lJRGSPyZS3zSAVErE7g6JJHAn0MuAzG40
         2PoC/a0foQWYMhC/fZdrK84fe8RyMyBozKkCvmzYCAAXZojDe+EDjcQLpr7CreT/74QJ
         s8ssjLtvVFmpWEHSqsusgKHPUivjNGFu7lKk8+lrj/T+iG9wtW9GSUBAZJvf/8vFpIJI
         zolmAxh6aLzcp7FHAmPK9Wt4NLYEXvUsaClhkoX5U86IvBCzwqF9mYC+Cw/stiV2QxNc
         kcdB1cUfumU+4adp4M8/YRK5ckqJJHloiyJlOcr5BmEp2+AZyPA0rqfPDlFmupgnvCH3
         WlxA==
X-Gm-Message-State: AOAM530xmJyek8un/geVk2QVNOuvhvW2pgnxxOxfCpASEIYA5oydAk6g
        /lnVCOZyVKRX1CYYJ56vANu4PVb4bVO8+oXGYlE=
X-Google-Smtp-Source: ABdhPJybFbiV7RpStqZCPaDR0ux0D0iPHuZVCc0Y1DcRifiotk8qWFX/mMcFt+t0PV0pXF9ELH5Q2mWhuXG4g9BvDxI=
X-Received: by 2002:a05:6808:1147:b0:2ce:6ee7:2c8f with SMTP id
 u7-20020a056808114700b002ce6ee72c8fmr6002708oiu.189.1645218961300; Fri, 18
 Feb 2022 13:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20220216005326.1899481-1-tweek@google.com>
In-Reply-To: <20220216005326.1899481-1-tweek@google.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 18 Feb 2022 16:15:50 -0500
Message-ID: <CAP+JOzRuDOUP7jBzuzFe7S4SvBRA6sG69Q7tzd+LgpsRxNWNiw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Populate and use policy name
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        alanstokes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 16, 2022 at 2:27 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> When an assertion fails, the error message refers to a generic
> "policy.conf" file. When parsing a policy in checkpolicy, populate its
> name using the original filename (source_filename is still build using
> the #line directives within the policy).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v1 -> v2: Fix leak reported by Christian G=C3=B6ttsche
>
>  checkpolicy/module_compiler.c |  1 +
>  checkpolicy/parse_util.c      |  1 +
>  libsepol/src/assertion.c      | 20 ++++++++++++++------
>  libsepol/src/expand.c         |  3 +++
>  4 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 5f5b0b19..129650fa 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -99,6 +99,7 @@ int define_policy(int pass, int module_header_given)
>                                 yyerror("no module name");
>                                 return -1;
>                         }
> +                       free(policydbp->name);
>                         policydbp->name =3D id;
>                         if ((policydbp->version =3D
>                              queue_remove(id_queue)) =3D=3D NULL) {
> diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
> index 8c1f393c..f2d1e04d 100644
> --- a/checkpolicy/parse_util.c
> +++ b/checkpolicy/parse_util.c
> @@ -47,6 +47,7 @@ int read_source_policy(policydb_t * p, const char *file=
, const char *progname)
>         }
>
>         policydbp =3D p;
> +       policydbp->name =3D strdup(file);
>         mlspol =3D p->mls;
>
>         init_parser(1);
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index dd2749a0..74f6d9c0 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -36,13 +36,21 @@ struct avtab_match_args {
>         unsigned long errors;
>  };
>
> +static const char* policy_name(policydb_t *p) {
> +       const char *policy_file =3D "policy.conf";
> +       if (p->name) {
> +               policy_file =3D p->name;
> +       }
> +       return policy_file;
> +}
> +
>  static void report_failure(sepol_handle_t *handle, policydb_t *p, const =
avrule_t *avrule,
>                            unsigned int stype, unsigned int ttype,
>                            const class_perm_node_t *curperm, uint32_t per=
ms)
>  {
>         if (avrule->source_filename) {
> -               ERR(handle, "neverallow on line %lu of %s (or line %lu of=
 policy.conf) violated by allow %s %s:%s {%s };",
> -                   avrule->source_line, avrule->source_filename, avrule-=
>line,
> +               ERR(handle, "neverallow on line %lu of %s (or line %lu of=
 %s) violated by allow %s %s:%s {%s };",
> +                   avrule->source_line, avrule->source_filename, avrule-=
>line, policy_name(p),
>                     p->p_type_val_to_name[stype],
>                     p->p_type_val_to_name[ttype],
>                     p->p_class_val_to_name[curperm->tclass - 1],
> @@ -173,9 +181,9 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>                                 /* failure on the extended permission che=
ck_extended_permissions */
>                                 if (rc) {
>                                         extended_permissions_violated(&er=
ror, avrule->xperms, xperms);
> -                                       ERR(handle, "neverallowxperm on l=
ine %lu of %s (or line %lu of policy.conf) violated by\n"
> +                                       ERR(handle, "neverallowxperm on l=
ine %lu of %s (or line %lu of %s) violated by\n"
>                                                         "allowxperm %s %s=
:%s %s;",
> -                                                       avrule->source_li=
ne, avrule->source_filename, avrule->line,
> +                                                       avrule->source_li=
ne, avrule->source_filename, avrule->line, policy_name(p),
>                                                         p->p_type_val_to_=
name[i],
>                                                         p->p_type_val_to_=
name[j],
>                                                         p->p_class_val_to=
_name[curperm->tclass - 1],
> @@ -190,9 +198,9 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>
>         /* failure on the regular permissions */
>         if (rc) {
> -               ERR(handle, "neverallowxperm on line %lu of %s (or line %=
lu of policy.conf) violated by\n"
> +               ERR(handle, "neverallowxperm on line %lu of %s (or line %=
lu of %s) violated by\n"
>                                 "allow %s %s:%s {%s };",
> -                               avrule->source_line, avrule->source_filen=
ame, avrule->line,
> +                               avrule->source_line, avrule->source_filen=
ame, avrule->line, policy_name(p),
>                                 p->p_type_val_to_name[stype],
>                                 p->p_type_val_to_name[ttype],
>                                 p->p_class_val_to_name[curperm->tclass - =
1],
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 8667f2ed..7da51a40 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2970,6 +2970,9 @@ int expand_module(sepol_handle_t * handle,
>
>         state.out->policy_type =3D POLICY_KERN;
>         state.out->policyvers =3D POLICYDB_VERSION_MAX;
> +       if (state.base->name) {
> +               state.out->name =3D strdup(state.base->name);
> +       }
>
>         /* Copy mls state from base to out */
>         out->mls =3D base->mls;
> --
> 2.35.1.265.g69c8d7142f-goog
>
