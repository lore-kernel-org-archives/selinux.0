Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195451DDF5;
	Tue,  6 Aug 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950766; cv=none; b=iutbIEj4nXizij0rTJBT+PZAmtMvyuHuIRipa7tm+/ZiqnwIcH4R47ZeBbj7qCciapCp7scoD7GHX+0dZgmnw4LxIwyM1LSKXRtUOeNC5okJlClMXWNDMqqi1H61BwWxAO6edjoMzUa/iJUQNKE9gI0YLl5kltDdw8JLlGOfnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950766; c=relaxed/simple;
	bh=AyuNxMyh4zUWBkVZV/n9fM2nvkdkU/rcgSii9IhMIIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbcdirQEf/VRqpTDVNhob7Nnt2kutfWlzw+VFpLEZBM+g6uxuzJHfGraq3tLH5b5EbJR9EkkVJKHp8fxqf8LuFyMzJV5EhFgi2sAPKQEYRAUHJ+oR/0b1BdKFAhTgtbe3lkDyHyxLnAanCO1FS6HBgEvfgot70/zDjyQm+jrv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHhDb3qS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHhDb3qS"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb5243766dso581340a91.0;
        Tue, 06 Aug 2024 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950764; x=1723555564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy7bUu11FomXNhdiIBOfoEquEd4jJxCHt/44zI6khbw=;
        b=HHhDb3qSAVZCl5L4BZ9BvNAgvgNYMjuCXxyl1gM6jhVbI9Tvxjglu5kZHLJywL7oCn
         wM3/wfIiPGaTGcDTtwSSBZSFE2R10IEHPDu4Q+t3nNGaQMzaaWlFecxIxv7YtTkxvT1V
         w1qNDOdMXy7DYSBYzKMgwzfaCFCnRIq5Jj7yIMfQTybtj40iV3ij2SeljdOr7HO8+GKw
         /jVkK7A3B0iUcyfkeanJSS804O1BXixcJN7hwqfxhCYBAfZbgSfSFPE06MpzY3g5IuqR
         3592xr/vzVyGTsMzvdcw0CLLbjJRgqZZdXYVKKr0kD/1Yleit1d46ypcsW4bo0lU/K2i
         nlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950764; x=1723555564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy7bUu11FomXNhdiIBOfoEquEd4jJxCHt/44zI6khbw=;
        b=TRTozWKJrpIeKSWGxUs8U+3SvAG/frfPmO3uZ++LH4/QSsUW39DqRxM8g4HiXQpPGJ
         gZ1Zbda4saZ+wz9ZYJF2DgK2F21aEWqjhMeizJpGSZw92oti03gYpJWFruXemGVnaQxd
         Jbv8KsgyvZOMP71gCYfwIujfM9IC2cxwF4zdFZVbRTz/vveoa45yCXCurDv43IgGjy4J
         ksKSaVcqq/gxF+NebwUMFVKQPxApX01larOFclXRUNymtcT+Bet8ey5TkQmVrH5wA6G7
         6iuz15JFJln0G1fyhyNbc0uD17n848ZOBDgszL2MQpjoZAf6+OF5taXJoRwY+Bllk5HX
         k9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWRFsDZu7jBDA0nH3Ca1jKjVcQpyraaMMVXrAeIJFwCpmL6qrcqmQaFSwor4gHVx6IojQ7fjdZW55YNwHnqSMHZo7mBtDvb7knrBT9oeERErkza9TNZhrgrLTtTcYGH+LeHeVJy+A==
X-Gm-Message-State: AOJu0Yz/3ffK3OAusHiPuGdwmWwaBMNWCIjdlC0nK7nUFCypr2ICmQZV
	PGOpdhnffJRQeGupSFyBN+z/U4CAaHLZyoWQ65WFybgGYwWA1kfrJxTJ5lkjds60XaEwHxXuq4b
	grSE0RhPcFnjvBFpnXyQsj/+0m34=
X-Google-Smtp-Source: AGHT+IGBSjMtbj8wgs57ayyLG/2RShvUlugBOcI+pSg5bWKr2HkOFIi1oc/8xtVHSEhU0kjtruD71SUpskeXuF/p8rg=
X-Received: by 2002:a17:90b:274a:b0:2cf:cd53:327d with SMTP id
 98e67ed59e1d1-2cff954f8c0mr16406268a91.36.1722950764308; Tue, 06 Aug 2024
 06:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
In-Reply-To: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 6 Aug 2024 09:25:53 -0400
Message-ID: <CAEjxPJ59=rHFovk3scmkhLuiAdu2uinGiua60y0naJ0e95GLmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux: Fix potential counting error in avc_add_xperms_decision()
To: thunder.leizhen@huaweicloud.com
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>, 
	Nick Kralevich <nnk@google.com>, Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 2:51=E2=80=AFAM <thunder.leizhen@huaweicloud.com> wr=
ote:
>
> From: Zhen Lei <thunder.leizhen@huawei.com>
>
> The count increases only when a node is successfully added to
> the linked list.
>
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

This looks correct to me but I also notice that the caller is not
checking or handling the return code for the -ENOMEM situation.
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 32eb67fb3e42c0f..7087cd2b802d8d8 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -330,12 +330,12 @@ static int avc_add_xperms_decision(struct avc_node =
*node,
>  {
>         struct avc_xperms_decision_node *dest_xpd;
>
> -       node->ae.xp_node->xp.len++;
>         dest_xpd =3D avc_xperms_decision_alloc(src->used);
>         if (!dest_xpd)
>                 return -ENOMEM;
>         avc_copy_xperms_decision(&dest_xpd->xpd, src);
>         list_add(&dest_xpd->xpd_list, &node->ae.xp_node->xpd_head);
> +       node->ae.xp_node->xp.len++;
>         return 0;
>  }
>
> --
> 2.34.1
>
