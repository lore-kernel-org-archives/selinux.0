Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B683033DE
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547954; cv=pass; b=XbE5zy6Y5QfXBoC+2snab9SmVA5aM9dOHmNoIg/VJyfCECmHTBvtZ8upswL6QqJ0n0rADpzPqkjyWTHJsMwfW/wCCJgrmqy1NkLmo+U1/XZ/KIa0++r33XSzARoybEcExPCN9TawjShX832nGO5rJxjvNj9kLEEi4D5Bb02FKxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547954; c=relaxed/simple;
	bh=MwDelRct1WE+B+rlnFbDnSZduImWDWzmcoKNQ0J2Ca4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf7FqhtbiYEl6/lQzdMYCuqHOD6vmomz6W9CGlIt3SzmEctuBAkA18RtIRuvWvKEbPe1fLrCMEaOXrtyuMIEbGnhAxStEveM9/18uY6KfAn+gpa9DYxUyVpkpyyJZsBO5+XS/rtTw//sr9k3XnwdzlPeGOrmb0YeeovXaFYEKU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXNxgwUc; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXNxgwUc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf20f6be6bso27785745ad.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 11:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781547952; cv=none;
        d=google.com; s=arc-20240605;
        b=dpFVJBEr3VXb/EDJuye0rfGJaLmNcn2pcuPoeV1JgqhOX1zB1bIhoM/oMvjxK2Bz+U
         UP0m1DKSpsuyvJWzVoQZk4es2k2EjW9DQM2mKxovdrQ3r9344u4rra8Oie9TGDY3ga4u
         tTJRgH7wphCnZ6qk1Mq7nknMxIvlrT7XewQsodc301VOa1u2JlCTuSnVVSCYvbfapuJu
         GCUxi/zSxxoTIG+JJiWmaMxiDjZYrCtaCeF2v8SXdSrhTqaa78oK3++74qGO/g7qnaRM
         2pUZGT8Alo3FVRPX99my/cXEDs6eTZPHr7BOxLG34FdJXxHnp31X6x1yR8ne2sKQFwxH
         SxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QX/vj0QuuC6Wtz/jYFBptNJ+jXywo44Og85OjhL2wyA=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=OKI9wDpZRPXtwECNvd4Q1/bvE+WeApBSZZm6Kg8BAsVIyftjzbkFmqkvVlFxRWtEzc
         GS/I+kWvAeI1aV0g2cjipykjfmt8F+Kv2SS/IIUDKnmRYYnH2KTAIV3yZfqaKOg4PKSI
         TUS4f0W5ETzvr14e4MTbCLkzVsSS9EUp9Xfdpzb7rfYau68ur0D+Q+ybQ7gVV0h2qzNZ
         JU+T5VDxa43ok9ume0iMnCT6XRXY5KHj6Inem7mcKtU+IZsKvp1WXqT9De57gPF/8K7Y
         cub/8qIkZ1SNSj0XxpuEW1i+AOetfae8ZmCoYmN7GDCnnDzp2PYmORWN0DxmMJC/8Jr7
         HNZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781547952; x=1782152752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX/vj0QuuC6Wtz/jYFBptNJ+jXywo44Og85OjhL2wyA=;
        b=KXNxgwUc2VduuUpiDzLadAN9fBzeHBRKj6fP4nBGyIpY45q4prYi11ZkD6ZF62ZnaL
         ZJel2Jlzs9NTewTHfqIqzep/1q1zp8GZNtdHtD8sm8gGHqDElnVd42RPDKhuNoKOXVNE
         eCQ0flVxw7h/BnZdqQTbgw6VCMAUwOcphQG8qmFknWHqjlrMLASA+zAp7DlL0lNW3sOI
         EBRMembOp3RkyTnTz+xgq0LN8fRHtC89FbdMuza3c/DVr+wtLUUKugIenMc8cpXBxfVe
         Rw95mmYzClfOvyddn4+xK1FlT8N4shPtUkjPgxXwF4vx1Y7Hi+9xEkGLdprFBJqKf79x
         OSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781547952; x=1782152752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QX/vj0QuuC6Wtz/jYFBptNJ+jXywo44Og85OjhL2wyA=;
        b=mG5HnyVuYONG2xRBHq+GF44Ia2Z1kQq+3UYstjaV+rj5FCvN9cJ4GHnAmL9EK6MVhU
         OdB4YgAmwBspDVkAJG+xkxH9Hax5oibdIC1xnEu+278sUA00yBmE1ymFfdEbJfcdoLr+
         5owaUDV3yvusV+WTqheehGnmrSkRiNuyDK+5jOW9jk3DTBhX2uLZIPydt0Jap5guT3fw
         ylIfzj2FrPzDvOp9AKXUCptYlnKtMYzqrrlzBX/n5fSo2NTgo8Z3W/rTWXFqcKlETprp
         YswDUCd53ma9p1NlHRBDqWuNzAXJf5szlhip3oKLHfymuJl+JJzRs6jRW8w/FYDE0g7h
         9qMA==
X-Gm-Message-State: AOJu0YxH2lvuhK1wVyoRtAYDkFU2gaOF3o5609cSXyRlW+6m1RngXFFi
	94r+pIZOUnKZrVKA7fDBcebE6MCEJqaJBnbyEpp2eiV5GqSMJN3kKZDmHKSpTcT9HwyoxjYjRzY
	fsyDU68xPzFuixXIjE0zb0gUouhElTYs=
X-Gm-Gg: Acq92OHgHY7Qw92iR1m+hIgdw3ala4hQrSkaQCwxM5U1faAUW5iz5Zzhegmnc2d3rtR
	9O/tioWykyaLETZQirX0NV3o0H0EHe4IxI3Ow8UreS7YpYc2owaxUZe/lPwoRvVeh6Aq+9mNhok
	4PCrpR7k+CjTE7WIMvpFMDspMZdSFxABR5yccVhNrfMebxrUxP/VsvpG1wzOvAqhvR5zyj/stLZ
	61ycBFdFKj6gwalhSGRqpU6jd1SJTPPhuaA+A7Ab0lhwFdA/b9rqkFjWlK+OsqyPzIi5Wdc6dKC
	SH8lqR0bEV8+Vm9LkQ==
X-Received: by 2002:a17:902:ced0:b0:2c6:6424:c79f with SMTP id
 d9443c01a7336-2c69a0dc52amr4087835ad.8.1781547952468; Mon, 15 Jun 2026
 11:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615180150.15567-1-jwcart2@gmail.com>
In-Reply-To: <20260615180150.15567-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 14:25:41 -0400
X-Gm-Features: AVVi8CdD191TuJHSl8Vyc4pTeEnNBuoNkVcBd0srSmi20HFmiykWgXvNtib3qQw
Message-ID: <CAEjxPJ5xr7ofw7PFMU-814CXAxEdE8rkh25dnaHVEgvCty5u=Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check for proper length of addr and mask buffers
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 2:03=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> When creating an ocontext node the addr and mask buffers lengths
> are not being checked that they are the correct value for the
> protocol.
>
> Verify that the addr and mask buffer lengths are the correct vaalue
> for the protocol and output an error if they are not.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/nodes.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
> index e3ad36a8..4acfc4e1 100644
> --- a/libsepol/src/nodes.c
> +++ b/libsepol/src/nodes.c
> @@ -34,10 +34,26 @@ static int node_from_record(sepol_handle_t *handle, c=
onst policydb_t *policydb,
>
>         switch (proto) {
>         case SEPOL_PROTO_IP4:
> +               if (addr_bsize !=3D 4) {

s/4/sizeof(tmp_node->u.node.addr)/ is a bit more general

> +                       ERR(handle, "Wrong address size for IPv4 address"=
);
> +                       goto err;
> +               }
> +               if (mask_bsize !=3D 4) {

s/4/sizeof(tmp_node->u.node.mask)/ is a bit more general

> +                       ERR(handle, "Wrong address size for IPv4 mask");
> +                       goto err;
> +               }
>                 memcpy(&tmp_node->u.node.addr, addr_buf, addr_bsize);
>                 memcpy(&tmp_node->u.node.mask, mask_buf, mask_bsize);
>                 break;
>         case SEPOL_PROTO_IP6:
> +               if (addr_bsize !=3D 16) {

s/4/sizeof(tmp_node->u.node6.addr)/ is a bit more general


> +                       ERR(handle, "Wrong address size for IPv6 address"=
);
> +                       goto err;
> +               }
> +               if (mask_bsize !=3D 16) {

s/4/sizeof(tmp_node->u.node6.mask)/ is a bit more general

> +                       ERR(handle, "Wrong address size for IPv6 mask");
> +                       goto err;
> +               }
>                 memcpy(tmp_node->u.node6.addr, addr_buf, addr_bsize);
>                 memcpy(tmp_node->u.node6.mask, mask_buf, mask_bsize);
>                 break;
> --
> 2.54.0
>
>
