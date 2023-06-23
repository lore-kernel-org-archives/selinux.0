Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2216EB64D7
	for <selinux@archiver.kernel.org>; Fri, 23 Jun 2023 19:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFWTKW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Jun 2023 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFWTKU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Jun 2023 15:10:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5013A9D
        for <selinux@vger.kernel.org>; Fri, 23 Jun 2023 12:10:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b475b54253so16655311fa.2
        for <selinux@vger.kernel.org>; Fri, 23 Jun 2023 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687547415; x=1690139415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+cvx5bknuJrsVZun2ZLXJXWNR+f0wYFv/gKwhnOKBU=;
        b=FHchhthCnKZpWVGhGX8EXOY7wVHaqMf+5+hkR8fMRyWy+9nlj/w5PlssnqqnteYgCk
         lGHS4Td5giisK8hgteNHqaodnRg/uNGj2947rjKJlbuMYkyWizmque5uvnRc38AKHqBA
         Pg/Qo/dMYdZnekGCcOBAEbyXbf17GmdU2uRDIIqL+g6Pq+53TzwOP9p1uk5yJnVTGwC0
         GwQV7XVDEHzHd1MSwNGoJHFCcr891sRfiLspIjHPC6ds4YWLdXsV6fP6ZXGO0/Uw5Or7
         c0yQDelhf4HSS3JVMYot5IWK46/ffKMR29h+H5DzyEXYn/O2ZR1QKswjlF3URvYRC2jn
         KprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687547415; x=1690139415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+cvx5bknuJrsVZun2ZLXJXWNR+f0wYFv/gKwhnOKBU=;
        b=Cqy7lcY0QdRHe+3mIsk9MC/rTmB+a6N89T5heWCIr6lStu8bxFnWsNoSbJsZqSpR+M
         Ouk0iWd91wvuPgyWHOXOkK5sPCktob7DZysoRqvvZpufoKMayXcCbGq8pYkYDSKt6UCA
         s/Ls5S0UaXpqCBNx7HFgXLjxbHvt/WowdGirmcgAkXdT2ag/TBBJUvlaYFi0qHIj/J1O
         LN/DaPcTB17sWKix97iXhjqksOgU1uUSnSuRu6+7hLN71Q+pgp9HaIwj5GkthcSt0pjI
         qMgf8tc46TJpiLET2a69vAJgF+ClrsJyEVRcR2RiRbwSf0w7vLmXyuO39nA3WuVkgxVw
         PB1w==
X-Gm-Message-State: AC+VfDx93kc+WN5WTp8BZsuZ0nkVRzfiUltojWmcOxsTEgrE18VOvBEV
        A6Xg1id6Vhk5a1H/jGLazUo/C0NzF9K+IkBEn/KbaswVt+s=
X-Google-Smtp-Source: ACHHUZ64E3chEoiDIUkzsjzK8m05Jbgk3HgpOmcy5dBcBuce7dYY0fdEjFQNV+lTGhOkhQpNiDIhuUTGK6l8o8otYvc=
X-Received: by 2002:a2e:9910:0:b0:2b5:8d7d:641a with SMTP id
 v16-20020a2e9910000000b002b58d7d641amr4314941lji.53.1687547415167; Fri, 23
 Jun 2023 12:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230612093107.1066410-1-omosnace@redhat.com> <20230612093107.1066410-2-omosnace@redhat.com>
In-Reply-To: <20230612093107.1066410-2-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 23 Jun 2023 15:10:03 -0400
Message-ID: <CAP+JOzRBA3wfcm7oeMpisyS+KEMenNTfUq4Z=JGEm3qD1VXc6w@mail.gmail.com>
Subject: Re: [PATCH userspace 1/2] libsepol: stop translating deprecated
 intial SIDs to strings
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 12, 2023 at 5:50=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Many of the initial SIDs are no longer used by the kernel, so
> translating them to the legacy names doesn't bring much value. Clear the
> legacy names from the table and let the code translate them to the
> fallback "unknown" names instead.
>
> Note that this only affects the generated text output when converting
> policies from binary to text form. The text policy languages let the
> policy define its own names for the initial SIDs based on the order in
> which they are declared, so the table is never used to convert from name
> to SID. Thus this is just a cosmetic change and has no functional
> impact.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c    |  4 ++--
>  libsepol/src/kernel_to_common.h | 36 ++++++++++++++++-----------------
>  libsepol/src/kernel_to_conf.c   |  4 ++--
>  libsepol/src/module_to_cil.c    |  2 +-
>  4 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index e9cd89c2..bd04c087 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -567,7 +567,7 @@ static int write_sids_to_cil(FILE *out, const char *c=
onst *sid_to_str,
>
>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>                 i =3D isid->sid[0];
> -               if (i < num_sids) {
> +               if (i < num_sids && sid_to_str[i]) {
>                         sid =3D (char *)sid_to_str[i];
>                 } else {
>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> @@ -2577,7 +2577,7 @@ static int write_sid_context_rules_to_cil(FILE *out=
, struct policydb *pdb, const
>
>         for (isid =3D pdb->ocontexts[0]; isid !=3D NULL; isid =3D isid->n=
ext) {
>                 i =3D isid->sid[0];
> -               if (i < num_sids) {
> +               if (i < num_sids && sid_to_str[i]) {
>                         sid =3D (char *)sid_to_str[i];
>                 } else {
>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
> index 159c4289..6073ff3a 100644
> --- a/libsepol/src/kernel_to_common.h
> +++ b/libsepol/src/kernel_to_common.h
> @@ -13,33 +13,33 @@
>  // initial sid names aren't actually stored in the pp files, need to a h=
ave
>  // a mapping, taken from the linux kernel
>  static const char * const selinux_sid_to_str[] =3D {
> -       "null",
> +       NULL,
>         "kernel",
>         "security",
>         "unlabeled",
> -       "fs",
> +       NULL,
>         "file",
> -       "file_labels",
> -       "init",
> +       NULL,
> +       NULL,
>         "any_socket",
>         "port",
>         "netif",
>         "netmsg",
>         "node",
> -       "igmp_packet",
> -       "icmp_socket",
> -       "tcp_socket",
> -       "sysctl_modprobe",
> -       "sysctl",
> -       "sysctl_fs",
> -       "sysctl_kernel",
> -       "sysctl_net",
> -       "sysctl_net_unix",
> -       "sysctl_vm",
> -       "sysctl_dev",
> -       "kmod",
> -       "policy",
> -       "scmp_packet",
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
>         "devnull",
>  };
>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index c48a7114..3be87184 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -464,7 +464,7 @@ static int write_sids_to_conf(FILE *out, const char *=
const *sid_to_str,
>
>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>                 i =3D isid->sid[0];
> -               if (i < num_sids) {
> +               if (i < num_sids && sid_to_str[i]) {
>                         sid =3D (char *)sid_to_str[i];
>                 } else {
>                         snprintf(unknown, sizeof(unknown), "%s%u", "UNKNO=
WN", i);
> @@ -2445,7 +2445,7 @@ static int write_sid_context_rules_to_conf(FILE *ou=
t, struct policydb *pdb, cons
>
>         for (isid =3D pdb->ocontexts[0]; isid !=3D NULL; isid =3D isid->n=
ext) {
>                 i =3D isid->sid[0];
> -               if (i < num_sids) {
> +               if (i < num_sids && sid_to_str[i]) {
>                         sid =3D (char *)sid_to_str[i];
>                 } else {
>                         snprintf(unknown, sizeof(unknown), "%s%u", "UNKNO=
WN", i);
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index e7bc6ee6..a46775ca 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2549,7 +2549,7 @@ static int ocontext_isid_to_cil(struct policydb *pd=
b, const char *const *sid_to_
>
>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>                 i =3D isid->sid[0];
> -               if (i < num_sids) {
> +               if (i < num_sids && sid_to_string[i]) {
>                         sid =3D (char*)sid_to_string[i];
>                 } else {
>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> --
> 2.40.1
>
