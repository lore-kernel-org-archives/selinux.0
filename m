Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC79C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 20:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhLIUeW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLIUeV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 15:34:21 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA45C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 12:30:48 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso7503379otj.1
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 12:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GvTFe8LCXTzi1Fkbg2f7l9pLPoCCaELF6eAhkxMxRa4=;
        b=N1KT3tRZTalAWiDfDGUmM4R0oXwMMA0Zh92QiqDY8+MpBg3iuSIWlOC/8sDanUeY59
         p9KzDpTEduyqdzxzkzzaN4UYj/qVrtX58hjWE8d/lpUOwxGEby8GqWpS+QYytuB/bDHi
         mMzrgDIZeHD+OsvCyfxa247TPDcDKReLaNESD0JEOz6vPB4W8NyuoLSemNsJdpc1E3SN
         r56DT8XdCACX+L7R7jVIJJwpmZvt5Wp6AFh4x3p79pmr1U2aXPgvllb+i478okG8TG7C
         12zAN1rEfTGO/aQ7Q3YLDWBXPxE1MEHa6B+mVmTY+4bLf5cX0ql8Cd0kMI1r+GzZHpPV
         5LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GvTFe8LCXTzi1Fkbg2f7l9pLPoCCaELF6eAhkxMxRa4=;
        b=OMlab46LKQ2CghSohhe/x4TJ/SuSzx/bOoF8bvOZb/1N6EMTu+1SrhiqhxoLh2Anp0
         PQPmdoyyW1E4cK36Fc2TJ4zF44NwViS3YYp8ju9Ps68K1SQEwQeDjW8PEGAUxOr+Nxcg
         7Uky668miD4DufnhKetpj32I2WVpH/ggGKdgy7dLfGIq2EDbxzOVBH0Dkb+euf+aF2mc
         YTgboXXXC1NtZNvjs5jgHE3CuJGyApFDTMYkHg410laH2ZzpjzI0BKa8G4DA2sK6Ybti
         D28k3yC2WntBbf2+q2btLIv/QcE9xOSaF0q7mldqynr2+XII4UFU+0uAh216YV6Rf0vO
         vs2w==
X-Gm-Message-State: AOAM5331zAi63+9oeFl06MAFBMYytDfJWNioIL3k0t8FZjIbZUQBYuBQ
        6MYQop/LzJzIAGINAqb/Nj0E3gsxZSkm/M6qwME=
X-Google-Smtp-Source: ABdhPJxtdZrCcOXP/I3b1JqGGjy3kWiGu61B0nzIZW2VIAevcO0I5WSDysfTu7efCYJ09q3GluPmcOt3U9ACtbG1uvE=
X-Received: by 2002:a9d:70d4:: with SMTP id w20mr7659595otj.154.1639081847478;
 Thu, 09 Dec 2021 12:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20211130110034.12920-1-cgzones@googlemail.com>
In-Reply-To: <20211130110034.12920-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Dec 2021 15:30:36 -0500
Message-ID: <CAP+JOzQjR9wbnb9aQu7MmzhbD+kZ-F_Aep=UOdEpnPr_s1D0mQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: support IPv4/IPv6 address embedding
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 30, 2021 at 4:51 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Accept IPv4 addresses embedded in IPv6, like `::ffff:127.0.0.1`.
> This allows using those in nodecon statements leading to fine grained
> access control:
>
>     type=3DAVC msg=3Daudit(11/29/21 20:27:44.437:419) : avc:  granted  { =
node_bind } for  pid=3D27500 comm=3Dintercept saddr=3D::ffff:127.0.0.1 src=
=3D46293 scontext=3Dxuser_u:xuser_r:xuser_t:s0 tcontext=3Dsystem_u:object_r=
:lo_node_t:s0 tclass=3Dtcp_socket
>
> This does effect policies in the traditional language due to CIL usage
> in semodule(8).
>
> Also print on conversion failures the address in question.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 9c34be23..eccb331b 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5668,10 +5668,10 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_no=
de, struct cil_ipaddr *addr)
>                 goto exit;
>         }
>
> -       if (strchr(addr_node->data, '.') !=3D NULL) {
> -               addr->family =3D AF_INET;
> -       } else {
> +       if (strchr(addr_node->data, ':') !=3D NULL) {
>                 addr->family =3D AF_INET6;
> +       } else {
> +               addr->family =3D AF_INET;
>         }
>
>         rc =3D inet_pton(addr->family, addr_node->data, &addr->ip);
> @@ -5683,7 +5683,7 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node=
, struct cil_ipaddr *addr)
>         return SEPOL_OK;
>
>  exit:
> -       cil_log(CIL_ERR, "Bad ip address or netmask\n");
> +       cil_log(CIL_ERR, "Bad ip address or netmask: %s\n", (addr_node &&=
 addr_node->data) ? (const char *)addr_node->data : "n/a");
>         return rc;
>  }
>
> --
> 2.34.1
>
