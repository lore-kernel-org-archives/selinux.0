Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D2C433F5
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 13:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhLQN51 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhLQN51 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 08:57:27 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C1C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 05:57:27 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso723467ooa.6
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 05:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ULhhcAlaG3w+sh0Ls2Ca9YTqV1oLTTsy2B8CzvAO+6g=;
        b=pz6O7UJK2nmgiVj6KPCn3yZBu84w/j+mKSiTqFHkBcHzqITVlJzYDbseEJAHoPVyq1
         YbPQ+3MU934aTz2lvs7COr5JyToAxgvRg8uH0h+/318XGXyGCTq4y69wzcwqcDzKXVYZ
         smVzRtq63Ul21ehXD+JIJ29m7FtL7lltNO7t+ou8VnaKrh3CVfDYCyaMlRHKlelVEA2L
         7UoQynHjoI+d2+ztsz0XVPZOAN3uSBIFrBhGJTDnNfazESvXfrIc9nchZaABXWe5ZuE9
         nbohq/uvOkmrXK07HUmycTYKkxLHYalkNZyllm9E/jFHWFbx4DUU+mZPvHd4z6xht2Xb
         n3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ULhhcAlaG3w+sh0Ls2Ca9YTqV1oLTTsy2B8CzvAO+6g=;
        b=MR4fk4qfGIap/I0pM9OQvKQuQ/weBNYQLgFRaLv8nwq8L+iiYGrmw738g62hFJ1gFO
         poRPxMkbdw/M1HzpeoHGN1K50HfEwJ/eFwaMwVGpXsMYIlrBO4mLFc4lVsLWApvECRfk
         mhzqZGaNUbvfop73VsYLfySyo4bSAYGsPZrrzK3uaM8dLq/bvUfkW7fw9izuVo8PaTs+
         libRj6ucP6LcUMtglEFqdd55m59SaXFTMmL+3vUp+kM8DJrBK4XxYlCTMUKaj9Btiise
         mGNjv/pzaFrDzssYVenEJlupzv2J0gkKVCK3AHnhRg1H3FBmkPrDL7VuyyAX/NmUMrQV
         nL0A==
X-Gm-Message-State: AOAM5317sLEZjpV2/pCxNUwxf/hUykQU35O4gVNFWHnizQxG59Nfay5p
        wIdn83RSF/7iE50kVfTjUSXeB3BjxY5Oseizh0o=
X-Google-Smtp-Source: ABdhPJzMFDsM6WAjbc2wtqMwjsPB+3mtHH/WqnMzRjjLE8Iri8mA80/2+LH0Nsy08Oit4swVZ1MPvZB0r48fOp+Rqvk=
X-Received: by 2002:a4a:dbd3:: with SMTP id t19mr1998172oou.8.1639749446357;
 Fri, 17 Dec 2021 05:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20211130110034.12920-1-cgzones@googlemail.com> <CAP+JOzQjR9wbnb9aQu7MmzhbD+kZ-F_Aep=UOdEpnPr_s1D0mQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQjR9wbnb9aQu7MmzhbD+kZ-F_Aep=UOdEpnPr_s1D0mQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 17 Dec 2021 08:57:15 -0500
Message-ID: <CAP+JOzQNE3JHZXj7EdoGq=zrQ9Jx9m8ZTG=eukV7-Qm-n7U=7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: support IPv4/IPv6 address embedding
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 9, 2021 at 3:30 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Nov 30, 2021 at 4:51 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Accept IPv4 addresses embedded in IPv6, like `::ffff:127.0.0.1`.
> > This allows using those in nodecon statements leading to fine grained
> > access control:
> >
> >     type=3DAVC msg=3Daudit(11/29/21 20:27:44.437:419) : avc:  granted  =
{ node_bind } for  pid=3D27500 comm=3Dintercept saddr=3D::ffff:127.0.0.1 sr=
c=3D46293 scontext=3Dxuser_u:xuser_r:xuser_t:s0 tcontext=3Dsystem_u:object_=
r:lo_node_t:s0 tclass=3Dtcp_socket
> >
> > This does effect policies in the traditional language due to CIL usage
> > in semodule(8).
> >
> > Also print on conversion failures the address in question.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Both of these have been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_build_ast.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index 9c34be23..eccb331b 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -5668,10 +5668,10 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_=
node, struct cil_ipaddr *addr)
> >                 goto exit;
> >         }
> >
> > -       if (strchr(addr_node->data, '.') !=3D NULL) {
> > -               addr->family =3D AF_INET;
> > -       } else {
> > +       if (strchr(addr_node->data, ':') !=3D NULL) {
> >                 addr->family =3D AF_INET6;
> > +       } else {
> > +               addr->family =3D AF_INET;
> >         }
> >
> >         rc =3D inet_pton(addr->family, addr_node->data, &addr->ip);
> > @@ -5683,7 +5683,7 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_no=
de, struct cil_ipaddr *addr)
> >         return SEPOL_OK;
> >
> >  exit:
> > -       cil_log(CIL_ERR, "Bad ip address or netmask\n");
> > +       cil_log(CIL_ERR, "Bad ip address or netmask: %s\n", (addr_node =
&& addr_node->data) ? (const char *)addr_node->data : "n/a");
> >         return rc;
> >  }
> >
> > --
> > 2.34.1
> >
