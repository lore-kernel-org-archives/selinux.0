Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6057C8D
	for <selinux@vger.kernel.org>; Thu, 13 Jun 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309018; cv=none; b=hFpM+6DopYOdi2wC244jomLdSOA5fbTtCA1TMBG24r8UD1iwTXErGQqGNN6M8h7oWUnHp/6/VyptdfIXCicMYHPgrCEtCTcUhrINM4nn2aKhTnskRj5JtlEqcIhTKAoQsnXwMYV+XvuAgNfYRj49wneWG+KzpJ2yC84AfZQ0qY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309018; c=relaxed/simple;
	bh=b9fnkl0Zm/f8jbjZ9Bxl9Ivcvk4MmlTAYv8TxnH27lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N18OXA1a9q1a/upBA0BrZpj/qf0fOdMTEZA2kJLjFMMZmkxoBIbiQLtwt3p3RLnAC/rbAInErDBikuf8Q64LVNnWilBehaZh2hue+1BbPtURNSVhraSFSoLbrgt03GGaay5A/iDqgFplUQuuvPrwTcwkiE/MXCbA7yusvCJVfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQIB0zhd; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQIB0zhd"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d229baccc4so742065b6e.1
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2024 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309016; x=1718913816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJvGDMvhDPnmHwMLPPIRNTR/vOKROlN+fBnicM9+HDA=;
        b=lQIB0zhdWdCQC0OEqvhHUF7K800iwYw2NmLTDudkkSdscNdegSKGaOqiIjzqoEBdW4
         ge4HADyR3Y2MbC+gMr8fdmS83OvuH/Ux9ORGk2O0ytSwC1k3nd4dVtglWfDVK8ShsSw6
         JWP+2oYyB3LHzkA/Mq7GGfldhOMwMOqR41ILyr7BEZMR7E1MgkB2BZuu9zGptxbcWXgO
         9sMa1sI3G2McVUhI63mWtbxlGVe/asUiedCJdfByKGgKmNFmew3yh1GNkbMzyPHnc5KL
         56Fw7kmAzeYcd3APZ13vg8RZeh5qpjnVv+J16e7v81hQqpYYGpOrUeaQwNF7QdyuKrQY
         wsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309016; x=1718913816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJvGDMvhDPnmHwMLPPIRNTR/vOKROlN+fBnicM9+HDA=;
        b=S/6ydUkG+rWSS6DVOf7Zlhl3F4Ya3BrX/Yersp6khXfFA6PqBmhbvP7IiuvU5P9MKY
         rUWB/RIhWhvNfmgVraZx/PaQm2sQcsFGGaFVPeHUoJPmGM7zOgZk44YdJBbnLi+E2QFI
         cJWMz+GTcG2wdIMGhr45cKvBOSVyJaKli588gOArUg50M5kn4CPXy9gcwGtMlRK6xAql
         4lNwvoqtjfNu7SE5hVYbGbdWceFpgzNaJCzeiTe1Yx38n/llRf+v5ryh9peIW5TLPDpp
         8QEKb5tZiDmsT9u7WXs6WuksFUDmQ2mqKlCzq/BTHPi0bZGhXQTpZ9nmX7VszvQPYQND
         J/GQ==
X-Gm-Message-State: AOJu0Yyzcrb1Za68j82+7NQbvWQoxIN0XxBwH1+vC+sYBYNy90vBz/3G
	CcTATkLp4fOfBA+/4YueQM+r1A7VTDwSGypvKxOTcP/Lhiq129C7/yfRvbQm3159eGYTA4+oGtT
	mnuq5WiYgqpY04FvhRdKXLMzsv4huk93w
X-Google-Smtp-Source: AGHT+IE0t/wxJ5mT8nRyVDHJhHerU0kuzWuD513Nl3/EBt4Bfe5Ncr8Or7PZEOElN2GNdgmTkS/JQCP8KHwgUx9FPKc=
X-Received: by 2002:a05:6808:1686:b0:3d2:483e:ec3f with SMTP id
 5614622812f47-3d24e8e12a0mr558813b6e.22.1718309016068; Thu, 13 Jun 2024
 13:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163901.65239-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 13 Jun 2024 16:03:25 -0400
Message-ID: <CAP+JOzR8k=-bxge_ntCyNi5Zh_5sKfLHS-1QgVWjfm2ROGUvcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: free empty scandir(3) result
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:39=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> In case scandir(3) finds no entries still free the returned result to
> avoid leaking it.
>
> Also do not override errno in case of a failure.
>
> Reported.by: Cppcheck
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/booleans.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index c557df65..1ede8e2d 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -53,7 +53,11 @@ int security_get_boolean_names(char ***names, int *len=
)
>
>         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_DIR=
);
>         *len =3D scandir(path, &namelist, &filename_select, alphasort);
> -       if (*len <=3D 0) {
> +       if (*len < 0) {
> +               return -1;
> +       }
> +       if (*len =3D=3D 0) {
> +               free(namelist);
>                 errno =3D ENOENT;
>                 return -1;
>         }
> --
> 2.43.0
>
>
