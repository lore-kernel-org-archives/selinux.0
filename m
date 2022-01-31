Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED9C433EF
	for <selinux@archiver.kernel.org>; Mon, 31 Jan 2022 10:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiAaKtE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jan 2022 05:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiAaKtD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jan 2022 05:49:03 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972EC061714
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 02:49:03 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id q19-20020a056830441300b0059a54d66106so12613439otv.0
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1wsITsMwMSZ1pN1fVchvkBZStipyMhmqpThpt94Dqdg=;
        b=B8Y4CQ9U7XyfXsawG76k+yNGPO1Ke2GmxVFX2CLMPP6Izm1wIcLZj3RsYiNmttl4Lg
         sc1MURdv9fjEPCEZL52o7GQ5d0iUw+50sjRl8WG24/TTwQ3MxOd02Nn63jEE3Tslr3Qi
         DgAigjbrbaZ5twxlDfxOWJ9aTP/tlVoKDFtlX3qId55jCSj1cMQZbbCiJc80OXMqwjaW
         vFTsMsD3bB3z41ReauZ7nFJKe+q6zwMZ0YRwwVyz5q2WVkXoFfGpp4Cynu1m9msmcgl+
         ef8FTwtduYnK59TnbZW/iiQx6UHyNJRP/whz/nnK7Pw4eudD9ygj2a5Yk9QC1GHyujcI
         K0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1wsITsMwMSZ1pN1fVchvkBZStipyMhmqpThpt94Dqdg=;
        b=3TvWVrJqyaHAzPsLSGq58i8TB6hERqFFlEw7GsPPsCiR/M6l8VxIC+0Hss4ReSNrmw
         m/otNkRZY477nPbMpC5nBEkV8bzIs3NNiwybnqBMo1mj3bjJKnxcK/uXC/0Sq2jxbWVJ
         n0+hI9GsJmipd95a9kRBjJXT0Vhf6TXFbOLN6wwpJZq+UXdCTgNbvBzff21kuSepmV0z
         +kJZv5J2kKl1NLTBU76N4mWD9Cx+XhSDgO6SjSwK3Eieo9pnduAi4Ea4mSoJIyeOFHjg
         epxfVRolx5ARPuxdL/zV3s/V9Mn9spo0rt/IhF1r/GCIBHC8jBDbDxETavwb4TH4+klJ
         uFHQ==
X-Gm-Message-State: AOAM533rM0pMrsEgbUK6+VrQFOz9Is4vh06BDn4GVNCH+k7xGJOfXT4k
        kRqWnPL/z5kmTOc0bvRT0MON13zoze0b7+OxHOsZBM8tNdbLfw==
X-Google-Smtp-Source: ABdhPJzhcLwJof71YFuhcGEhWcCY9+CvjEj2s+qzOpewwIsDxlzr6v+wHLnvx/WFqMWc7TCRi5pbUfIZ4dQrOvMD1Dk=
X-Received: by 2002:a05:6830:1d65:: with SMTP id l5mr10983450oti.56.1643626142580;
 Mon, 31 Jan 2022 02:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20220131010421.1960196-1-tweek@google.com>
In-Reply-To: <20220131010421.1960196-1-tweek@google.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 31 Jan 2022 11:48:51 +0100
Message-ID: <CAJ2a_Dfsx08LL7r9RbpfeEdS6OitX=K44zKXJ47wBD2XgLXa6A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Populate and use policy name
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>, alanstokes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 31 Jan 2022 at 02:04, Thi=C3=A9baud Weksteen <tweek@google.com> wro=
te:
>
> When an assertion fails, the error message refers to a generic
> "policy.conf" file. When parsing a policy in checkpolicy, populate its
> name using the original filename (source_filename is still build using
> the #line directives within the policy).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  checkpolicy/parse_util.c |  1 +
>  libsepol/src/assertion.c | 20 ++++++++++++++------
>  libsepol/src/expand.c    |  3 +++
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
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
> 2.35.0.rc2.247.g8bbb082509-goog
>

This seems to create a leak:

=3D=3D17394=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 20 byte(s) in 1 object(s) allocated from:
    #0 0x5c179628aab3 in strdup (./checkpolicy/checkmodule+0x13dab3)
    #1 0x5c17962eeab1 in read_source_policy ./checkpolicy/parse_util.c:53:2=
0
    #2 0x5c1796309a4f in main ./checkpolicy/checkmodule.c:279:7
    #3 0x7fba24eae1c9 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

SUMMARY: AddressSanitizer: 20 byte(s) leaked in 1 allocation(s).

fixed by

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index fcbc0eb8..ba80894a 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -99,6 +99,7 @@ int define_policy(int pass, int module_header_given)
                               yyerror("no module name");
                               return -1;
                       }
+                       free(policydbp->name);
                       policydbp->name =3D id;
                       if ((policydbp->version =3D
                            queue_remove(id_queue)) =3D=3D NULL) {
