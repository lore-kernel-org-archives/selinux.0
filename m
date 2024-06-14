Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A16FB1
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374378; cv=none; b=Iwkf5If9H6M1vRdUUz85MRts3X2vyY26QzC3HfObWwe3Boz3OQ5V8ofA264sLcDVIhZIMR06KqnKIcjl/0uxGViqIEARbM3QO7iRGgZAL7OCz8waMbh1ypzfWBIm9RhZvYI53DIJS9kK4SdarMIU1IiU631C61sjHeDEV2+rUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374378; c=relaxed/simple;
	bh=198BxMqlLwndjsJoDVRFU3ZZiPJhyfVjLMflyqB0pkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyGSWNTSUTBJmi4ueuiRjIYgm6TmvTLs7VSKVD7ItMSt1zEUeQh6+yF6Xo1DFz+lblyySxK0La1KZ3ZT5a9EpAzVHqauPMjpcHER52CGuH4Ylk+IXNgBE29ZtgskV+BndOJ6iJIvhtoTn+arOJY7z4sjqoNyq6Yit0AfBb/ircc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGUyZodO; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGUyZodO"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d1bc6e5f01so1171062b6e.0
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374375; x=1718979175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti5H9Omj275D7UpCIMHjerUhanTxG7Fufx8XZHUjPNA=;
        b=nGUyZodOmwiVKoC5yPVQF5y7sbymByotIdJvZVyiZNJx+OKOcuEcO8AfXD2jAY1+9r
         NxItyUypZ9pd/P/1c0xVLV+8Cuhgk01921rRgD3IJ4vgahRzR1E5aOK7DKxW4buv18op
         FTYr86plrJpOkZ1m7nvLTEjfJ0cB7oFl/GgCU8c/cOQlgkLp8P2u1aaYQFg+5bHSIzra
         qcQyxg8ojFOK+NeyQUzGG92ldvqAR5G87DTdjStS4pnljTXWd3ti4BYk8LHAuiy7p9Jn
         X9+ZttvutRBT7JyDf6QRa5eeXfHIChktyHfqMkVhBKyaUuABexrHyIDq/8rdnT4X/DW0
         SE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374375; x=1718979175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti5H9Omj275D7UpCIMHjerUhanTxG7Fufx8XZHUjPNA=;
        b=FLc/C0RmXzBOuWKIcMPJESjpNQflzbHyD6U1RUdoD5jVnkGPLIXQObFnAREw88LIca
         cZ2oqG6Rxv419EoxWkee74KUd9mBH3htbRb0IuKu8C79z25qg107yh8Fe0qt157hgzwd
         dAooJibXf2ULAOn5JiL9KrA2nFpvuRhuoXcI100NBuyCLK2KIVm+gWb/ib0Xf5dBhB4P
         yoAc6rtzTLnD44U2QkQ1jV2mGaokatNgKbcQV4a9BakO+PU4Ods6tLzyLQaoxKPZvzjg
         /tA/gRNGG9tMJdnI++3q2j2jv7Qos+cfczMTOy0x+qOnBlqpVH1IHhMN23BLPJcj3HtQ
         +nSQ==
X-Gm-Message-State: AOJu0Yz/bPLm6ZhvnGlv+QlTzw2Ymp5rZ/br/7/9u67AWvit9VMug+on
	wdeZtTYBQKijSEKInbaq7/mJqBXa2rsRd1gMYPtXDCkaF+p35uuTNAtx1gYu4dAeyannQQ0YAr1
	FU1RM39xxK3zW2ylSxYfY0qnaU9chFA==
X-Google-Smtp-Source: AGHT+IGTjBMayhNgpMYaUeWwxtm5eO9xMZdPTZmTf3fIFGN3fxOgh9N5yaZbu6eH4aHTYQD0pPhOyjPsB9/lWH+otJQ=
X-Received: by 2002:a05:6808:1248:b0:3d2:18bb:b5e3 with SMTP id
 5614622812f47-3d24e8f3328mr2952243b6e.25.1718374374804; Fri, 14 Jun 2024
 07:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172233.139679-1-cgoettsche@seltendoof.de> <CAP+JOzQsZUbquuChoMchiENi8zEiiFu-4wgFtqfRa5kFS6hCAA@mail.gmail.com>
In-Reply-To: <CAP+JOzQsZUbquuChoMchiENi8zEiiFu-4wgFtqfRa5kFS6hCAA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:12:43 -0400
Message-ID: <CAP+JOzQPkWt22FK+Eo=tf5q+7t0uA_KNkx+XJ-N98K014XqLTA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: reject duplicate nodecon statements
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 9:29=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 8, 2024 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Reject multiple nodecon declarations with the same address and netmask.
> > Avoids mistakes when defining them in different places or using both th=
e
> > address-with-netmask and CIDR-notation syntax.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 186 +++++++++++++++++-------------------
> >  1 file changed, 87 insertions(+), 99 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 1d17f73d..4931f23d 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -5238,12 +5238,45 @@ int define_netif_context(void)
> >         return 0;
> >  }
> >
> > +static int insert_ipv4_node(ocontext_t *newc)
> > +{
> > +       ocontext_t *c, *l;
> > +       char addr[INET_ADDRSTRLEN];
> > +       char mask[INET_ADDRSTRLEN];
> > +
> > +       /* Create order of most specific to least retaining
> > +          the order specified in the configuration. */
> > +       for (l =3D NULL, c =3D policydbp->ocontexts[OCON_NODE]; c; l =
=3D c, c =3D c->next) {
> > +               if (newc->u.node.mask =3D=3D c->u.node.mask &&
> > +                   newc->u.node.addr =3D=3D c->u.node.addr) {
> > +                       yyerror2("duplicate entry for network node %s %=
s",
> > +                                inet_ntop(AF_INET, &newc->u.node.addr,=
 addr, INET_ADDRSTRLEN) ?: "<invalid>",
> > +                                inet_ntop(AF_INET, &newc->u.node.mask,=
 mask, INET_ADDRSTRLEN) ?: "<invalid>");
> > +                       context_destroy(&newc->context[0]);
> > +                       free(newc);
> > +                       return -1;
> > +               }
> > +
> > +               if (newc->u.node.mask > c->u.node.mask)
> > +                       break;
> > +       }
> > +
> > +       newc->next =3D c;
> > +
> > +       if (l)
> > +               l->next =3D newc;
> > +       else
> > +               policydbp->ocontexts[OCON_NODE] =3D newc;
> > +
> > +       return 0;
> > +}
> > +
> >  int define_ipv4_node_context(void)
> >  {
> >         char *id;
> >         int rc =3D 0;
> >         struct in_addr addr, mask;
> > -       ocontext_t *newc, *c, *l, *head;
> > +       ocontext_t *newc;
> >
> >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> >                 yyerror("nodecon not supported for target");
> > @@ -5254,40 +5287,34 @@ int define_ipv4_node_context(void)
> >                 free(queue_remove(id_queue));
> >                 free(queue_remove(id_queue));
> >                 parse_security_context(NULL);
> > -               goto out;
> > +               return 0;
> >         }
> >
> >         id =3D queue_remove(id_queue);
> >         if (!id) {
> >                 yyerror("failed to read ipv4 address");
> > -               rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         rc =3D inet_pton(AF_INET, id, &addr);
> >         if (rc < 1) {
> >                 yyerror2("failed to parse ipv4 address %s", id);
> >                 free(id);
> > -               if (rc =3D=3D 0)
> > -                       rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >         free(id);
> >
> >         id =3D queue_remove(id_queue);
> >         if (!id) {
> >                 yyerror("failed to read ipv4 address");
> > -               rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         rc =3D inet_pton(AF_INET, id, &mask);
> >         if (rc < 1) {
> >                 yyerror2("failed to parse ipv4 mask %s", id);
> >                 free(id);
> > -               if (rc =3D=3D 0)
> > -                       rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         free(id);
> > @@ -5303,8 +5330,7 @@ int define_ipv4_node_context(void)
> >         newc =3D malloc(sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> > -               rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         memset(newc, 0, sizeof(ocontext_t));
> > @@ -5316,23 +5342,7 @@ int define_ipv4_node_context(void)
> >                 return -1;
> >         }
> >
> > -       /* Create order of most specific to least retaining
> > -          the order specified in the configuration. */
> > -       head =3D policydbp->ocontexts[OCON_NODE];
> > -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> > -               if (newc->u.node.mask > c->u.node.mask)
> > -                       break;
> > -       }
> > -
> > -       newc->next =3D c;
> > -
> > -       if (l)
> > -               l->next =3D newc;
> > -       else
> > -               policydbp->ocontexts[OCON_NODE] =3D newc;
> > -       rc =3D 0;
> > -out:
> > -       return rc;
> > +       return insert_ipv4_node(newc);
> >  }
> >
> >  int define_ipv4_cidr_node_context(void)
> > @@ -5341,7 +5351,7 @@ int define_ipv4_cidr_node_context(void)
> >         unsigned long mask_bits;
> >         uint32_t mask;
> >         struct in_addr addr;
> > -       ocontext_t *newc, *c, *l, *head;
> > +       ocontext_t *newc;
> >         int rc;
> >
> >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> > @@ -5411,22 +5421,7 @@ int define_ipv4_cidr_node_context(void)
> >                 return -1;
> >         }
> >
> > -       /* Create order of most specific to least retaining
> > -          the order specified in the configuration. */
> > -       head =3D policydbp->ocontexts[OCON_NODE];
> > -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> > -               if (newc->u.node.mask > c->u.node.mask)
> > -                       break;
> > -       }
> > -
> > -       newc->next =3D c;
> > -
> > -       if (l)
> > -               l->next =3D newc;
> > -       else
> > -               policydbp->ocontexts[OCON_NODE] =3D newc;
> > -
> > -       return 0;
> > +       return insert_ipv4_node(newc);
> >  }
> >
> >  static int ipv6_is_mask_contiguous(const struct in6_addr *mask)
> > @@ -5483,12 +5478,45 @@ static void ipv6_cidr_bits_to_mask(unsigned lon=
g cidr_bits, struct in6_addr *mas
> >         }
> >  }
> >
> > +static int insert_ipv6_node(ocontext_t *newc)
> > +{
> > +       ocontext_t *c, *l;
> > +       char addr[INET6_ADDRSTRLEN];
> > +       char mask[INET6_ADDRSTRLEN];
> > +
> > +       /* Create order of most specific to least retaining
> > +          the order specified in the configuration. */
> > +       for (l =3D NULL, c =3D policydbp->ocontexts[OCON_NODE6]; c; l =
=3D c, c =3D c->next) {
> > +               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) =
=3D=3D 0 &&
> > +                   memcmp(&newc->u.node6.addr, &c->u.node6.addr, 16) =
=3D=3D 0) {
> > +                       yyerror2("duplicate entry for network node %s %=
s",
> > +                                inet_ntop(AF_INET6, &newc->u.node6.add=
r, addr, INET6_ADDRSTRLEN) ?: "<invalid>",
> > +                                inet_ntop(AF_INET6, &newc->u.node6.mas=
k, mask, INET6_ADDRSTRLEN) ?: "<invalid>");
> > +                       context_destroy(&newc->context[0]);
> > +                       free(newc);
> > +                       return -1;
> > +               }
> > +
> > +               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) >=
 0)
> > +                       break;
> > +       }
> > +
> > +       newc->next =3D c;
> > +
> > +       if (l)
> > +               l->next =3D newc;
> > +       else
> > +               policydbp->ocontexts[OCON_NODE6] =3D newc;
> > +
> > +       return 0;
> > +}
> > +
> >  int define_ipv6_node_context(void)
> >  {
> >         char *id;
> >         int rc =3D 0;
> >         struct in6_addr addr, mask;
> > -       ocontext_t *newc, *c, *l, *head;
> > +       ocontext_t *newc;
> >
> >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> >                 yyerror("nodecon not supported for target");
> > @@ -5499,23 +5527,20 @@ int define_ipv6_node_context(void)
> >                 free(queue_remove(id_queue));
> >                 free(queue_remove(id_queue));
> >                 parse_security_context(NULL);
> > -               goto out;
> > +               return 0;
> >         }
> >
> >         id =3D queue_remove(id_queue);
> >         if (!id) {
> >                 yyerror("failed to read ipv6 address");
> > -               rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         rc =3D inet_pton(AF_INET6, id, &addr);
> >         if (rc < 1) {
> >                 yyerror2("failed to parse ipv6 address %s", id);
> >                 free(id);
> > -               if (rc =3D=3D 0)
> > -                       rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         free(id);
> > @@ -5523,17 +5548,14 @@ int define_ipv6_node_context(void)
> >         id =3D queue_remove(id_queue);
> >         if (!id) {
> >                 yyerror("failed to read ipv6 address");
> > -               rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         rc =3D inet_pton(AF_INET6, id, &mask);
> >         if (rc < 1) {
> >                 yyerror2("failed to parse ipv6 mask %s", id);
> >                 free(id);
> > -               if (rc =3D=3D 0)
> > -                       rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         free(id);
> > @@ -5549,8 +5571,7 @@ int define_ipv6_node_context(void)
> >         newc =3D malloc(sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> > -               rc =3D -1;
> > -               goto out;
> > +               return -1;
> >         }
> >
> >         memset(newc, 0, sizeof(ocontext_t));
> > @@ -5559,28 +5580,10 @@ int define_ipv6_node_context(void)
> >
> >         if (parse_security_context(&newc->context[0])) {
> >                 free(newc);
> > -               rc =3D -1;
> > -               goto out;
> > -       }
> > -
> > -       /* Create order of most specific to least retaining
> > -          the order specified in the configuration. */
> > -       head =3D policydbp->ocontexts[OCON_NODE6];
> > -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> > -               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) >=
 0)
> > -                       break;
> > +               return -1;
> >         }
> >
> > -       newc->next =3D c;
> > -
> > -       if (l)
> > -               l->next =3D newc;
> > -       else
> > -               policydbp->ocontexts[OCON_NODE6] =3D newc;
> > -
> > -       rc =3D 0;
> > -      out:
> > -       return rc;
> > +       return insert_ipv6_node(newc);
> >  }
> >
> >  int define_ipv6_cidr_node_context(void)
> > @@ -5589,7 +5592,7 @@ int define_ipv6_cidr_node_context(void)
> >         unsigned long mask_bits;
> >         int rc;
> >         struct in6_addr addr, mask;
> > -       ocontext_t *newc, *c, *l, *head;
> > +       ocontext_t *newc;
> >
> >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> >                 yyerror("nodecon not supported for target");
> > @@ -5658,22 +5661,7 @@ int define_ipv6_cidr_node_context(void)
> >                 return -1;
> >         }
> >
> > -       /* Create order of most specific to least retaining
> > -          the order specified in the configuration. */
> > -       head =3D policydbp->ocontexts[OCON_NODE6];
> > -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> > -               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) >=
 0)
> > -                       break;
> > -       }
> > -
> > -       newc->next =3D c;
> > -
> > -       if (l)
> > -               l->next =3D newc;
> > -       else
> > -               policydbp->ocontexts[OCON_NODE6] =3D newc;
> > -
> > -       return 0;
> > +       return insert_ipv6_node(newc);
> >  }
> >
> >  int define_fs_use(int behavior)
> > --
> > 2.45.1
> >
> >
