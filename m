Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190E4749C7
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871509; cv=pass; b=WT5QdEf9omQ5WOnYLW8MDG+3ATTqQD/pDZlOJy3TBDVE7IqehQdyiuS5Wrepq1ifW91ne0RECWijDGUW9tl3L6mR1F/VkG2WDkA9qbr4GHWFPrg6fQIz5CGdd+UC5fL6SiijgIf6vK6MgWCFcTTdl0CdopqzyX+Gdz4F0dnE57A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871509; c=relaxed/simple;
	bh=3j5pMrF6pl7FTW4Hs8d5qdGP+k9t3r+OpbgxgBgU9bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAQ5KSl2i4WeXT8ljGR/TS8pYOioqQlhOhpoNOq2qRXk5J4s4eFXYFNFtTtVj97Ft5rOzEUeuPE7cRIh8/Sldp/5AqSi7lgY9cb13WX0hVx0fkKkQR4zc3SdxqlFTisXyldMZKlpwH+kidmFOkW+ltgJDh4447WPxjPB+9AxDA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpEYqL53; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpEYqL53"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-455ee8f529dso25380fac.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 12:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785871506; cv=none;
        d=google.com; s=arc-20260327;
        b=RZuJ05XTR9Ta18WueeiILkW5+Zkc6ZtKoCeVQ765yAm2d4vuvjIkUBaSBxukxQPg6T
         qEV5x0sgwEfLPhTui29x9venH5jTCuVD3p4E31/2NGAHl5mmj/I2rucE29jfW3K90ipg
         gf3hG2pGwNHG9Ad/EFadLWN7fnxxyJSnxmwVXbxhRaj1+TVDU/vsSeBoRUmHkiNAuqtt
         Gt4S4hq5NjC4Gss4BX8y5MS6TYoG2R2lfWZv1ylxIAX2MaVe++qn9px7Djemc+1DMeQZ
         /GzN+nGhuWYo8JltSnG8QlYA2lM+u4AkMCuHUKZCPsfy/WDQMhhjD5zdfx5hHGYWuu1G
         zMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZxoXq0cycmP22ASSnPIMNUK435DcvnJ1OADyR3tb/Ao=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Zn7Fi43cJxCryZuARtccSLVEUJBbXYD0hpAc/1FBVbKIXcQICGOMCTUaP1oRbH+VMq
         sqwpGzdOzsPHSIpR5JtbRu88DUvWmL06O+7De3NrD5xqLzvcCR+hgAe6L3lRMpwp2FUG
         p53wr2tvdD4OBUV8WHyw8/DtrdA1ZbLpE+PZaAOwRChAzl3m63rBh10TLjbEBBhY2gCi
         g8SEkt9pOBUZEdwUOz5heHtbKmIuIvOKBdQlLXY75ZyJXel1kSXuTx0Wy0JMu3oKWZmt
         Q6SOHvhH4wA4nP5tXf0D0cX6SBFmXnrlhhhiDqEUZIhyZg6JJLrpW6U2IoZzBUufptMr
         hd1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785871506; x=1786476306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZxoXq0cycmP22ASSnPIMNUK435DcvnJ1OADyR3tb/Ao=;
        b=fpEYqL53kFa+8ixTemDvsRA9KJwJE5ZfuvrEkUxvLEZP4JaaCHtPCZHZGx0+Fxarby
         o8Zzc+SFIaPAOrR5TerdJjwA3OZqsLcPjR0mPsW8Pivxk+hm2vG2vNtx9LBXAJ8KkXAh
         HGpMX8XK/huuh88nonZq8sPFqu1y3ktc+050DyXLJK4wq3oOA/dM0WfegpJJvrJWmQ1c
         CQ9WnL42WluO8SL0a0pGtBxXlz8FaeMG+EFzNfQuuTw7eteQnif5gpC/L0EVV9jYNFzX
         0efng4FuEDt15yHo20A+YdVRFVcnrTYX+UHDFfJGpuu64LrCSwH4xsbkWORIh1oKrNA+
         BHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871506; x=1786476306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxoXq0cycmP22ASSnPIMNUK435DcvnJ1OADyR3tb/Ao=;
        b=mYZXPcjyZNrgZBx/vgFfh/qNpPoqIkmNDfEWjeb4p2obDuysudxMHPOHNOaTcxJD4P
         FbkCgkphqpJ5bp+zBOR7WqWks1D9J+hOIWnKlIlXXP9+gy+n1+vbUu0kOhQ8cRCNf48H
         EdS5mAfQYqNEkcEcs1WgMnG3xuLiMfWnzxqoljmwVdx8awklaTrCYWzDg9YOkBjQ3CoW
         yl3JuJIUOKKHvBiUvsxBwOPaXGf2KvWrwY5gaC/+cIxV4WyB59qAQa7ZAIEA4qpiUB3T
         1Mhz3tDBmamwcn9AVp5BFhKcA9AKL3auZVgoQL8ZNqfhNOkDrs9sMe3+1cD8G2f+pdOb
         ByrA==
X-Gm-Message-State: AOJu0YzB+G1KkTx8EoafdVMo689OCdJ+/RCREF8kKzw4LkcagEgPlV9F
	MxgHgf6ttQtmHZk4j+FTikLTmwtPq7Yztc/BqyKbTT58Aw/+soXum+8V+dZpIA9vPD4AknMGm2l
	L6VAqvUKsf2U07wa4Fiw76ho2BkANn5dUlw==
X-Gm-Gg: AR+sD11Tg+A6ICrx/peHluJWyEJ+UAz/WGEmrXcCjIPMulJ7mnU+4+56Fe6yDvtDtJz
	vITpXWYhEDB8F6jKFdsJQL900bWEUdZ2KPpRohg/PEvZewS292E8M2ZqeROK7pw68Zu8CmMfKhG
	BNI7orc1Bhy6ZXsH5l0+Wl72RqByrQS8I+e2ryMUctw7DqYkW12w+PYPoZA4T9ol5cSAkMaIeWR
	37IFBfJes4U3D4LPKAvPXuOUknkeNso3A88UWVhEYX3oU6KqrA0b9pF7gUDz0abpFa0LU9Y8YNW
	xNS9WiUNMFtgTapVMxsLnzhDBr7EL9O+9RA6osEGjJqy
X-Received: by 2002:a05:6820:2214:b0:6ae:47e0:be20 with SMTP id
 006d021491bc7-6ae96bcccd2mr749637eaf.7.1785871506572; Tue, 04 Aug 2026
 12:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804184826.36330-1-jwcart2@gmail.com>
In-Reply-To: <20260804184826.36330-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 15:24:54 -0400
X-Gm-Features: AUfX_mw4KvzTNaNaXcGrefyvw8sDfjPGNtOUpGowmugJcb64agX_pdxCt94Nta4
Message-ID: <CAEjxPJ4hfCiAgRRspTW0OiVxQP-jwpFf9bPHtZfpsvKSUYdbqw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Do not convert mls rules to CIL for a non-mls policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> When converting a module policydb to CIL mls rules for sensitivies
> and categories are processed if they exist even for a non-mls
> policy. This allows for a maliciously crafted policy to cause an
> OOB access.
>
> If the policy is not an mls policy, then skip sensitivity,
> category, and the ordering rules for sensitivies and categories.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 06fbdc30..6876bd76 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2711,6 +2711,9 @@ static int sens_to_cil(int indent, struct policydb =
*pdb,
>  {
>         level_datum_t *level =3D datum;
>
> +       if (!pdb->mls)
> +               return 0;
> +
>         if (scope =3D=3D SCOPE_DECL) {
>                 if (!level->isalias) {
>                         cil_println(indent, "(sensitivity %s)", key);
> @@ -2738,6 +2741,9 @@ static int sens_order_to_cil(int indent, struct pol=
icydb *pdb,
>         struct ebitmap_node *node;
>         uint32_t i;
>
> +       if (!pdb->mls)
> +               return 0;
> +
>         if (ebitmap_is_empty(&order)) {
>                 return 0;
>         }
> @@ -2761,6 +2767,9 @@ static int cat_to_cil(int indent, struct policydb *=
pdb,
>  {
>         struct cat_datum *cat =3D datum;
>
> +       if (!pdb->mls)
> +               return 0;
> +
>         if (scope =3D=3D SCOPE_REQ) {
>                 return 0;
>         }
> @@ -2783,6 +2792,9 @@ static int cat_order_to_cil(int indent, struct poli=
cydb *pdb,
>         struct ebitmap_node *node;
>         uint32_t i;
>
> +       if (!pdb->mls)
> +               return 0;
> +
>         if (ebitmap_is_empty(&order)) {
>                 rc =3D 0;
>                 goto exit;
> --
> 2.55.0
>
