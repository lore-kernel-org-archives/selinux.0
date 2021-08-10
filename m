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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5AAC4338F
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228E760724
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhHJS2z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhHJS2y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:28:54 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB85C0613C1
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:28:32 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id f33-20020a4a89240000b029027c19426fbeso5584004ooi.8
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u7TMFOxlIbd/CX3HghAPlce/UeQJKgb4jiIcPR3q0w4=;
        b=pXC/m8PUqjjUFzBJLr/Ji9O8apCa5ZejMZW59i3xFBgOWSh1J3wPf1ooHXLKf6SPAp
         Y7r+OeQEYiWPvqd5Li79wkxnxExvxYFEO5ruNm+jiJ0vfKK+SNU1wI0ZRGcL+szZLU7g
         6xthbP8y7Rzvs6V9qkAmNuzh1XoExHeIwTxeE7hyPZEXewM2kxSrGC6Wg9gRIrVedNL9
         8IQ8XJVByLBqWigDw92+TcCMsVH7hGHoIuZK9CkYIGhL1PchvbP0FxX5WBTEQm6ZZyuW
         Lu/UgyAcoCLd7V1OazPVbiexgYxnPUt/2EeiGlzJKff59/WvwCg5/5map6omC1oRTa4r
         bd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u7TMFOxlIbd/CX3HghAPlce/UeQJKgb4jiIcPR3q0w4=;
        b=K4MyAXV/3titJyvoe/2VKmmASuCmcghyqh3U/BagsZoJY0zj7u3SbP1BbpoFohTjbw
         rn/5wcX4xfg6MVlRdMflPN8cZTtvFgaZK0Au3ffSPHtxhxS+rjT6bxB0htDMnql/7ZVy
         pLVf8F9LkHZrtEyEgdk6dZIOmPlsZKDfyKfBhoO8lM15e5A2dEcYbjdE+URO3uTQp+pM
         DGFaxnbV77GTgV52LLwVnEe0aCSP/RXY+mzCgYGMiapomF5geCcXsIf1Zvu94m+NpbH2
         Q6FuPHC0oCju89qT1cb+/QM+ilSFBTajD7V2CUeTXSR7HJpUq9Z64pMnLYOun8iop3Mh
         agdA==
X-Gm-Message-State: AOAM531+RufVIOFb7a/EUEqK+4p7R1YzwQ7H62YMlJiqYIzoclylVOwJ
        SqANz+depknoetBt5/yfBKGtCTXmulImWku+Of4=
X-Google-Smtp-Source: ABdhPJynoj0iyqrYFce2g1MZ4iASZrbBuecGEV5rkd9vSgd6d2qQvlbTvXodc+WjBAgHZjt+pOvS56HK+rTcXsD5t8g=
X-Received: by 2002:a4a:e9a8:: with SMTP id t8mr19339001ood.59.1628620111554;
 Tue, 10 Aug 2021 11:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210809105209.12705-1-cgzones@googlemail.com> <20210809105209.12705-2-cgzones@googlemail.com>
In-Reply-To: <20210809105209.12705-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Aug 2021 14:28:20 -0400
Message-ID: <CAP+JOzS6X-HzwMs9FJOLXdU5t4kEbrEWWsyHmtFobmmAgESuVg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] libsepol: replace strerror by %m
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 9, 2021 at 6:54 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The standard function `strerror(3)` is not thread safe.  This does not
> only affect the concurrent usage of libselinux itself but also with
> other `strerror(3)` linked libraries.
> Use the thread safe GNU extension format specifier `%m`[1].
>
> libselinux already uses the GNU extension format specifier `%ms`.
>
> [1]: https://www.gnu.org/software/libc/manual/html_node/Other-Output-Conv=
ersions.html
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/ibpkey_record.c  |  7 +++----
>  libsepol/src/kernel_to_cil.c  | 11 +++++------
>  libsepol/src/kernel_to_conf.c | 11 +++++------
>  libsepol/src/module.c         |  8 ++++++--
>  libsepol/src/module_to_cil.c  | 11 +++++------
>  libsepol/src/node_record.c    | 10 ++++------
>  libsepol/src/services.c       |  2 +-
>  7 files changed, 29 insertions(+), 31 deletions(-)
>
> diff --git a/libsepol/src/ibpkey_record.c b/libsepol/src/ibpkey_record.c
> index 6f7aa656..d95e95fe 100644
> --- a/libsepol/src/ibpkey_record.c
> +++ b/libsepol/src/ibpkey_record.c
> @@ -38,8 +38,8 @@ static int ibpkey_parse_subnet_prefix(sepol_handle_t *h=
andle,
>         struct in6_addr in_addr;
>
>         if (inet_pton(AF_INET6, subnet_prefix_str, &in_addr) <=3D 0) {
> -               ERR(handle, "could not parse IPv6 address for ibpkey subn=
et prefix %s: %s",
> -                   subnet_prefix_str, strerror(errno));
> +               ERR(handle, "could not parse IPv6 address for ibpkey subn=
et prefix %s: %m",
> +                   subnet_prefix_str);
>                 return STATUS_ERR;
>         }
>
> @@ -64,8 +64,7 @@ static int ibpkey_expand_subnet_prefix(sepol_handle_t *=
handle,
>         if (inet_ntop(AF_INET6, &addr, subnet_prefix_str,
>                       INET6_ADDRSTRLEN) =3D=3D NULL) {
>                 ERR(handle,
> -                   "could not expand IPv6 address to string: %s",
> -                   strerror(errno));
> +                   "could not expand IPv6 address to string: %m");
>                 return STATUS_ERR;
>         }
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 336d53b0..81427e65 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2779,13 +2779,13 @@ static int write_selinux_node_rules_to_cil(FILE *=
out, struct policydb *pdb)
>
>         for (node =3D pdb->ocontexts[4]; node !=3D NULL; node =3D node->n=
ext) {
>                 if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADD=
RSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon address is invalid: %s", s=
trerror(errno));
> +                       sepol_log_err("Nodecon address is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
>
>                 if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADD=
RSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon mask is invalid: %s", stre=
rror(errno));
> +                       sepol_log_err("Nodecon mask is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
> @@ -2819,13 +2819,13 @@ static int write_selinux_node6_rules_to_cil(FILE =
*out, struct policydb *pdb)
>
>         for (node =3D pdb->ocontexts[6]; node !=3D NULL; node =3D node->n=
ext) {
>                 if (inet_ntop(AF_INET6, &node->u.node6.addr, addr, INET6_=
ADDRSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon address is invalid: %s", s=
trerror(errno));
> +                       sepol_log_err("Nodecon address is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
>
>                 if (inet_ntop(AF_INET6, &node->u.node6.mask, mask, INET6_=
ADDRSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon mask is invalid: %s", stre=
rror(errno));
> +                       sepol_log_err("Nodecon mask is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
> @@ -2867,8 +2867,7 @@ static int write_selinux_ibpkey_rules_to_cil(FILE *=
out, struct policydb *pdb)
>
>                 if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
>                               subnet_prefix_str, INET6_ADDRSTRLEN) =3D=3D=
 NULL) {
> -                       sepol_log_err("ibpkeycon subnet_prefix is invalid=
: %s",
> -                                     strerror(errno));
> +                       sepol_log_err("ibpkeycon subnet_prefix is invalid=
: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index cb8e1380..179f0ad1 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -2652,13 +2652,13 @@ static int write_selinux_node_rules_to_conf(FILE =
*out, struct policydb *pdb)
>
>         for (node =3D pdb->ocontexts[4]; node !=3D NULL; node =3D node->n=
ext) {
>                 if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADD=
RSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon address is invalid: %s", s=
trerror(errno));
> +                       sepol_log_err("Nodecon address is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
>
>                 if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADD=
RSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon mask is invalid: %s", stre=
rror(errno));
> +                       sepol_log_err("Nodecon mask is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
> @@ -2693,13 +2693,13 @@ static int write_selinux_node6_rules_to_conf(FILE=
 *out, struct policydb *pdb)
>
>         for (node6 =3D pdb->ocontexts[6]; node6 !=3D NULL; node6 =3D node=
6->next) {
>                 if (inet_ntop(AF_INET6, &node6->u.node6.addr, addr, INET6=
_ADDRSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon address is invalid: %s", s=
trerror(errno));
> +                       sepol_log_err("Nodecon address is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
>
>                 if (inet_ntop(AF_INET6, &node6->u.node6.mask, mask, INET6=
_ADDRSTRLEN) =3D=3D NULL) {
> -                       sepol_log_err("Nodecon mask is invalid: %s", stre=
rror(errno));
> +                       sepol_log_err("Nodecon mask is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
> @@ -2741,8 +2741,7 @@ static int write_selinux_ibpkey_rules_to_conf(FILE =
*out, struct policydb *pdb)
>
>                 if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
>                               subnet_prefix_str, INET6_ADDRSTRLEN) =3D=3D=
 NULL) {
> -                       sepol_log_err("ibpkeycon address is invalid: %s",
> -                                     strerror(errno));
> +                       sepol_log_err("ibpkeycon address is invalid: %m")=
;
>                         rc =3D -1;
>                         goto exit;
>                 }
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 9b53bc47..02a5de2c 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -796,7 +796,9 @@ int sepol_module_package_info(struct sepol_policy_fil=
e *spf, int *type,
>
>                         len =3D le32_to_cpu(buf[0]);
>                         if (str_read(name, file, len)) {
> -                               ERR(file->handle, "%s", strerror(errno));
> +                               ERR(file->handle,
> +                                   "cannot read module name (at section =
%u): %m",
> +                                   i);
>                                 goto cleanup;
>                         }
>
> @@ -809,7 +811,9 @@ int sepol_module_package_info(struct sepol_policy_fil=
e *spf, int *type,
>                         }
>                         len =3D le32_to_cpu(buf[0]);
>                         if (str_read(version, file, len)) {
> -                               ERR(file->handle, "%s", strerror(errno));
> +                               ERR(file->handle,
> +                                   "cannot read module version (at secti=
on %u): %m",
> +                               i);
>                                 goto cleanup;
>                         }
>                         seen |=3D SEEN_MOD;
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 21d8e5db..9c7e3d3a 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2668,8 +2668,7 @@ static int ocontext_selinux_ibpkey_to_cil(struct po=
licydb *pdb,
>
>                 if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
>                               subnet_prefix_str, INET6_ADDRSTRLEN) =3D=3D=
 NULL) {
> -                       log_err("ibpkeycon subnet_prefix is invalid: %s",
> -                               strerror(errno));
> +                       log_err("ibpkeycon subnet_prefix is invalid: %m")=
;
>                         rc =3D -1;
>                         goto exit;
>                 }
> @@ -2714,13 +2713,13 @@ static int ocontext_selinux_node_to_cil(struct po=
licydb *pdb, struct ocontext *n
>
>         for (node =3D nodes; node !=3D NULL; node =3D node->next) {
>                 if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADD=
RSTRLEN) =3D=3D NULL) {
> -                       log_err("Nodecon address is invalid: %s", strerro=
r(errno));
> +                       log_err("Nodecon address is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
>
>                 if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADD=
RSTRLEN) =3D=3D NULL) {
> -                       log_err("Nodecon mask is invalid: %s", strerror(e=
rrno));
> +                       log_err("Nodecon mask is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
> @@ -2746,13 +2745,13 @@ static int ocontext_selinux_node6_to_cil(struct p=
olicydb *pdb, struct ocontext *
>
>         for (node =3D nodes; node !=3D NULL; node =3D node->next) {
>                 if (inet_ntop(AF_INET6, &node->u.node6.addr, addr, INET6_=
ADDRSTRLEN) =3D=3D NULL) {
> -                       log_err("Nodecon address is invalid: %s", strerro=
r(errno));
> +                       log_err("Nodecon address is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
>
>                 if (inet_ntop(AF_INET6, &node->u.node6.mask, mask, INET6_=
ADDRSTRLEN) =3D=3D NULL) {
> -                       log_err("Nodecon mask is invalid: %s", strerror(e=
rrno));
> +                       log_err("Nodecon mask is invalid: %m");
>                         rc =3D -1;
>                         goto exit;
>                 }
> diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
> index 9ef429da..2e575bf1 100644
> --- a/libsepol/src/node_record.c
> +++ b/libsepol/src/node_record.c
> @@ -53,7 +53,7 @@ static int node_parse_addr(sepol_handle_t * handle,
>
>                         if (inet_pton(AF_INET, addr_str, &in_addr) <=3D 0=
) {
>                                 ERR(handle, "could not parse IPv4 address=
 "
> -                                   "%s: %s", addr_str, strerror(errno));
> +                                   "%s: %m", addr_str);
>                                 return STATUS_ERR;
>                         }
>
> @@ -66,7 +66,7 @@ static int node_parse_addr(sepol_handle_t * handle,
>
>                         if (inet_pton(AF_INET6, addr_str, &in_addr) <=3D =
0) {
>                                 ERR(handle, "could not parse IPv6 address=
 "
> -                                   "%s: %s", addr_str, strerror(errno));
> +                                   "%s: %m", addr_str);
>                                 return STATUS_ERR;
>                         }
>
> @@ -147,8 +147,7 @@ static int node_expand_addr(sepol_handle_t * handle,
>                                       INET_ADDRSTRLEN) =3D=3D NULL) {
>
>                                 ERR(handle,
> -                                   "could not expand IPv4 address to str=
ing: %s",
> -                                   strerror(errno));
> +                                   "could not expand IPv4 address to str=
ing: %m");
>                                 return STATUS_ERR;
>                         }
>                         break;
> @@ -163,8 +162,7 @@ static int node_expand_addr(sepol_handle_t * handle,
>                                       INET6_ADDRSTRLEN) =3D=3D NULL) {
>
>                                 ERR(handle,
> -                                   "could not expand IPv6 address to str=
ing: %s",
> -                                   strerror(errno));
> +                                   "could not expand IPv6 address to str=
ing: %m");
>                                 return STATUS_ERR;
>                         }
>                         break;
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 47a3dc14..673b3971 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -145,7 +145,7 @@ int sepol_set_policydb_from_file(FILE * fp)
>         }
>         if (policydb_read(&mypolicydb, &pf, 0)) {
>                 policydb_destroy(&mypolicydb);
> -               ERR(NULL, "can't read binary policy: %s", strerror(errno)=
);
> +               ERR(NULL, "can't read binary policy: %m");
>                 return -1;
>         }
>         policydb =3D &mypolicydb;
> --
> 2.32.0
>
