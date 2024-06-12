Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E5176ACD
	for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198972; cv=none; b=XSv7shBA33nfFCbosyFEMaKzI/LlmgayJ3yDKTPbMufvruqi337XszWAPDh7llDohcsPJMV3epeNwDKQ+RWcMQi+bSbI/MqmqLVzjUQGnMD6kQeJx9KHr/X4KjGbzFKPj8y7zJNdACkBPrTW9rMVJR9F0OZr618FIFC5QAyy2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198972; c=relaxed/simple;
	bh=BamJPPgu8Bs+li/Fn065jODvIDBv8wlxz0jJ0qHyORw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piiRVi474kpRDfsULRBHZVIK2CrRHd1r0XtW2cIuE5A1lT5V6PjjS91jFhWM29cJlM61hm+UE0XsDngLHUKKfwBb6git9xuGcleyR4UkWmuaCfdeKHUEViEy8+fmyW0faamBPRivH9mIFev2i2ywkIuKR5N+lPezohKxisiiPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACq+Rd6k; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACq+Rd6k"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48cdd1eaa0aso705599137.3
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718198969; x=1718803769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Garp3QbFOeM0woGnEnirihjgDD4XZ1VUmTHJv+jAmH4=;
        b=ACq+Rd6k5sQjPaAE9o/oNjDsFExFHvlSQI9XpwpjRnvnxSyMklooiApzkaYHtlHyc9
         i5rjF3l1Nb3QOe7MlTHMc5tAKOxZ9ld2R4U6Du990SiZnlyofLuEp/+zml6PjqbDxD2Y
         b3RwGrp0uP9ZRRpV2v9K4zvpSvDTzzg9O2eCi//VWtySZZhMtGTk7vboPnurcSxQBnHd
         ksGsr4KTNFYeF2eKjfo/5ojY8Zh1jiX/jVp0gMa2iVeERPb0kgs8k2gbD7jkUujTOz02
         BZCpgJFuIF8Gju8yejsm/Osa0c3PLydeUEs4qfeQUcyv4mOfF3zsNN/s+iiIQkIhGI8v
         gE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198969; x=1718803769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Garp3QbFOeM0woGnEnirihjgDD4XZ1VUmTHJv+jAmH4=;
        b=Sefr0bAsNG6vDYCctx+f0BQDbtFA4+9WSp9Hwjbkp2QmBOzRxOA3NG60D+yEgoV6z2
         o7SlbTx+XNKFBmqE4ZzKGDa+drK+uLRngnFCQ0DEvCjD1Vl+/V55CCJLFGgh11U2obfp
         v+jrPvCEW1FCGTA7bbRwXLNxQfr0cD9a3VoZ+xBpIDi3astMPMusYk4ZKfB3UBON6lfp
         pN7Rxz9fKo8xM45JsDT0SOm4HVvEvd3L72TkMk5qj8veKymJ4uVhR5WHFohF9qSsozUB
         d2YSNYHJWA4o1UTnkMEvcNEbgvefCRvnjP7oYAuip8B/ztOLsmBkWW2yPJNQnuHERZyR
         Av4A==
X-Gm-Message-State: AOJu0YxauQj1Tjd7W8iYicflUEy3H1tAJJYjASxNwQxQ6okAtAnIGqQQ
	YIFM1NJwstfVUsEK6aDg8cjicplkbwSfOImqxURnpk6MNaPiE1fdWbV+6P6emjgCFNjYHi6aQAL
	dkMAc8xKf0Ly9FEDU7bqkJ0CB/Ff5PVnH
X-Google-Smtp-Source: AGHT+IG6XYXtGmPKjcUY5dpv1/7g7gkImKmf+I+9x0PWX/Ps04eaW1sT0ufRzZ/hIjzou07ve7GY0zyAUDzJBHXxRoY=
X-Received: by 2002:a05:6102:ccd:b0:48d:8284:180a with SMTP id
 ada2fe7eead31-48d91e84accmr2266108137.24.1718198969318; Wed, 12 Jun 2024
 06:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172233.139679-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240608172233.139679-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Jun 2024 09:29:17 -0400
Message-ID: <CAP+JOzQsZUbquuChoMchiENi8zEiiFu-4wgFtqfRa5kFS6hCAA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: reject duplicate nodecon statements
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reject multiple nodecon declarations with the same address and netmask.
> Avoids mistakes when defining them in different places or using both the
> address-with-netmask and CIDR-notation syntax.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 186 +++++++++++++++++-------------------
>  1 file changed, 87 insertions(+), 99 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 1d17f73d..4931f23d 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5238,12 +5238,45 @@ int define_netif_context(void)
>         return 0;
>  }
>
> +static int insert_ipv4_node(ocontext_t *newc)
> +{
> +       ocontext_t *c, *l;
> +       char addr[INET_ADDRSTRLEN];
> +       char mask[INET_ADDRSTRLEN];
> +
> +       /* Create order of most specific to least retaining
> +          the order specified in the configuration. */
> +       for (l =3D NULL, c =3D policydbp->ocontexts[OCON_NODE]; c; l =3D =
c, c =3D c->next) {
> +               if (newc->u.node.mask =3D=3D c->u.node.mask &&
> +                   newc->u.node.addr =3D=3D c->u.node.addr) {
> +                       yyerror2("duplicate entry for network node %s %s"=
,
> +                                inet_ntop(AF_INET, &newc->u.node.addr, a=
ddr, INET_ADDRSTRLEN) ?: "<invalid>",
> +                                inet_ntop(AF_INET, &newc->u.node.mask, m=
ask, INET_ADDRSTRLEN) ?: "<invalid>");
> +                       context_destroy(&newc->context[0]);
> +                       free(newc);
> +                       return -1;
> +               }
> +
> +               if (newc->u.node.mask > c->u.node.mask)
> +                       break;
> +       }
> +
> +       newc->next =3D c;
> +
> +       if (l)
> +               l->next =3D newc;
> +       else
> +               policydbp->ocontexts[OCON_NODE] =3D newc;
> +
> +       return 0;
> +}
> +
>  int define_ipv4_node_context(void)
>  {
>         char *id;
>         int rc =3D 0;
>         struct in_addr addr, mask;
> -       ocontext_t *newc, *c, *l, *head;
> +       ocontext_t *newc;
>
>         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
>                 yyerror("nodecon not supported for target");
> @@ -5254,40 +5287,34 @@ int define_ipv4_node_context(void)
>                 free(queue_remove(id_queue));
>                 free(queue_remove(id_queue));
>                 parse_security_context(NULL);
> -               goto out;
> +               return 0;
>         }
>
>         id =3D queue_remove(id_queue);
>         if (!id) {
>                 yyerror("failed to read ipv4 address");
> -               rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         rc =3D inet_pton(AF_INET, id, &addr);
>         if (rc < 1) {
>                 yyerror2("failed to parse ipv4 address %s", id);
>                 free(id);
> -               if (rc =3D=3D 0)
> -                       rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>         free(id);
>
>         id =3D queue_remove(id_queue);
>         if (!id) {
>                 yyerror("failed to read ipv4 address");
> -               rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         rc =3D inet_pton(AF_INET, id, &mask);
>         if (rc < 1) {
>                 yyerror2("failed to parse ipv4 mask %s", id);
>                 free(id);
> -               if (rc =3D=3D 0)
> -                       rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         free(id);
> @@ -5303,8 +5330,7 @@ int define_ipv4_node_context(void)
>         newc =3D malloc(sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
> -               rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         memset(newc, 0, sizeof(ocontext_t));
> @@ -5316,23 +5342,7 @@ int define_ipv4_node_context(void)
>                 return -1;
>         }
>
> -       /* Create order of most specific to least retaining
> -          the order specified in the configuration. */
> -       head =3D policydbp->ocontexts[OCON_NODE];
> -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> -               if (newc->u.node.mask > c->u.node.mask)
> -                       break;
> -       }
> -
> -       newc->next =3D c;
> -
> -       if (l)
> -               l->next =3D newc;
> -       else
> -               policydbp->ocontexts[OCON_NODE] =3D newc;
> -       rc =3D 0;
> -out:
> -       return rc;
> +       return insert_ipv4_node(newc);
>  }
>
>  int define_ipv4_cidr_node_context(void)
> @@ -5341,7 +5351,7 @@ int define_ipv4_cidr_node_context(void)
>         unsigned long mask_bits;
>         uint32_t mask;
>         struct in_addr addr;
> -       ocontext_t *newc, *c, *l, *head;
> +       ocontext_t *newc;
>         int rc;
>
>         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> @@ -5411,22 +5421,7 @@ int define_ipv4_cidr_node_context(void)
>                 return -1;
>         }
>
> -       /* Create order of most specific to least retaining
> -          the order specified in the configuration. */
> -       head =3D policydbp->ocontexts[OCON_NODE];
> -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> -               if (newc->u.node.mask > c->u.node.mask)
> -                       break;
> -       }
> -
> -       newc->next =3D c;
> -
> -       if (l)
> -               l->next =3D newc;
> -       else
> -               policydbp->ocontexts[OCON_NODE] =3D newc;
> -
> -       return 0;
> +       return insert_ipv4_node(newc);
>  }
>
>  static int ipv6_is_mask_contiguous(const struct in6_addr *mask)
> @@ -5483,12 +5478,45 @@ static void ipv6_cidr_bits_to_mask(unsigned long =
cidr_bits, struct in6_addr *mas
>         }
>  }
>
> +static int insert_ipv6_node(ocontext_t *newc)
> +{
> +       ocontext_t *c, *l;
> +       char addr[INET6_ADDRSTRLEN];
> +       char mask[INET6_ADDRSTRLEN];
> +
> +       /* Create order of most specific to least retaining
> +          the order specified in the configuration. */
> +       for (l =3D NULL, c =3D policydbp->ocontexts[OCON_NODE6]; c; l =3D=
 c, c =3D c->next) {
> +               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) =3D=
=3D 0 &&
> +                   memcmp(&newc->u.node6.addr, &c->u.node6.addr, 16) =3D=
=3D 0) {
> +                       yyerror2("duplicate entry for network node %s %s"=
,
> +                                inet_ntop(AF_INET6, &newc->u.node6.addr,=
 addr, INET6_ADDRSTRLEN) ?: "<invalid>",
> +                                inet_ntop(AF_INET6, &newc->u.node6.mask,=
 mask, INET6_ADDRSTRLEN) ?: "<invalid>");
> +                       context_destroy(&newc->context[0]);
> +                       free(newc);
> +                       return -1;
> +               }
> +
> +               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) > 0=
)
> +                       break;
> +       }
> +
> +       newc->next =3D c;
> +
> +       if (l)
> +               l->next =3D newc;
> +       else
> +               policydbp->ocontexts[OCON_NODE6] =3D newc;
> +
> +       return 0;
> +}
> +
>  int define_ipv6_node_context(void)
>  {
>         char *id;
>         int rc =3D 0;
>         struct in6_addr addr, mask;
> -       ocontext_t *newc, *c, *l, *head;
> +       ocontext_t *newc;
>
>         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
>                 yyerror("nodecon not supported for target");
> @@ -5499,23 +5527,20 @@ int define_ipv6_node_context(void)
>                 free(queue_remove(id_queue));
>                 free(queue_remove(id_queue));
>                 parse_security_context(NULL);
> -               goto out;
> +               return 0;
>         }
>
>         id =3D queue_remove(id_queue);
>         if (!id) {
>                 yyerror("failed to read ipv6 address");
> -               rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         rc =3D inet_pton(AF_INET6, id, &addr);
>         if (rc < 1) {
>                 yyerror2("failed to parse ipv6 address %s", id);
>                 free(id);
> -               if (rc =3D=3D 0)
> -                       rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         free(id);
> @@ -5523,17 +5548,14 @@ int define_ipv6_node_context(void)
>         id =3D queue_remove(id_queue);
>         if (!id) {
>                 yyerror("failed to read ipv6 address");
> -               rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         rc =3D inet_pton(AF_INET6, id, &mask);
>         if (rc < 1) {
>                 yyerror2("failed to parse ipv6 mask %s", id);
>                 free(id);
> -               if (rc =3D=3D 0)
> -                       rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         free(id);
> @@ -5549,8 +5571,7 @@ int define_ipv6_node_context(void)
>         newc =3D malloc(sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
> -               rc =3D -1;
> -               goto out;
> +               return -1;
>         }
>
>         memset(newc, 0, sizeof(ocontext_t));
> @@ -5559,28 +5580,10 @@ int define_ipv6_node_context(void)
>
>         if (parse_security_context(&newc->context[0])) {
>                 free(newc);
> -               rc =3D -1;
> -               goto out;
> -       }
> -
> -       /* Create order of most specific to least retaining
> -          the order specified in the configuration. */
> -       head =3D policydbp->ocontexts[OCON_NODE6];
> -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> -               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) > 0=
)
> -                       break;
> +               return -1;
>         }
>
> -       newc->next =3D c;
> -
> -       if (l)
> -               l->next =3D newc;
> -       else
> -               policydbp->ocontexts[OCON_NODE6] =3D newc;
> -
> -       rc =3D 0;
> -      out:
> -       return rc;
> +       return insert_ipv6_node(newc);
>  }
>
>  int define_ipv6_cidr_node_context(void)
> @@ -5589,7 +5592,7 @@ int define_ipv6_cidr_node_context(void)
>         unsigned long mask_bits;
>         int rc;
>         struct in6_addr addr, mask;
> -       ocontext_t *newc, *c, *l, *head;
> +       ocontext_t *newc;
>
>         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
>                 yyerror("nodecon not supported for target");
> @@ -5658,22 +5661,7 @@ int define_ipv6_cidr_node_context(void)
>                 return -1;
>         }
>
> -       /* Create order of most specific to least retaining
> -          the order specified in the configuration. */
> -       head =3D policydbp->ocontexts[OCON_NODE6];
> -       for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next) {
> -               if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) > 0=
)
> -                       break;
> -       }
> -
> -       newc->next =3D c;
> -
> -       if (l)
> -               l->next =3D newc;
> -       else
> -               policydbp->ocontexts[OCON_NODE6] =3D newc;
> -
> -       return 0;
> +       return insert_ipv6_node(newc);
>  }
>
>  int define_fs_use(int behavior)
> --
> 2.45.1
>
>
