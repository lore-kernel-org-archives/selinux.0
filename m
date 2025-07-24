Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9A2D29B7
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366331; cv=none; b=NwsXJWe90I8o5siHuXgGloMKmJGmo0oOwYSidDTpSGRee7cr3RccmrM+pT3fzI2cYz26oKI42RSwFLV2CNx/gLNFOLgQVdXxUFiAq01R2bKx405Daf0no6EdBYJRi8szvHhPR0sml+MHnP2NbSuC+F0/udPqVXJVYxmyjukhCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366331; c=relaxed/simple;
	bh=uo86mj9js+mkQVW6GuIxDCyyL3RXLdQkAiTtp6JzEKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1AxkptCm+oZbwPjA4efjlBQQIyvBkWsiShEaPmzE355rQfyRCIHCuN9XB4ph17kT/oq2dYHsoCtLan2zlnHvDQYvJjiCd5uEonK0QZfyiwwGvsc65I4Vw2mJ6c9yxrOVY+hNrORq+M6RLcULnXthSe7eGdDfUdaHr5Vtrm+hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiYmrO2L; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiYmrO2L"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31e41cfa631so1235284a91.2
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753366329; x=1753971129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbXXDJaduEGy4oLkofJj/8Tcp/FaiZHYTO+wR6ZkyUI=;
        b=LiYmrO2LPhn4yyYLQWualNSkCJnteyn9tV7tlCoSm1gItcxZIZiwBq5DqCfbueCNUN
         bv9cSAU7y1ZkG2Btxhs6Hg9dM3b6UqNhewDv+tFADquU0L/wdPEER1JHgiOtzR+ggB9t
         usrzdZPY2gDOPnd/1EQHr+KBu6pFkfNv6yFn1GDABNqCoheA0XYkBCIcKJV3SQyQlHzh
         QPtcuSovtOzxv06FoHKMX4Y4FTIKfP0OAjz4Tw1yU+57JzFVl6+jXtOTtUOYLFYb9bKn
         kbP3fmpOEft/92CnUiXk6fA1Jsflhzor3tpiCUM0wbUyq1sYlc8s5oLtBriZa6rGGyMq
         rEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366329; x=1753971129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbXXDJaduEGy4oLkofJj/8Tcp/FaiZHYTO+wR6ZkyUI=;
        b=Q76HNOwFVhH/9ZJ3N2QyHLLo5GcLvbJC47OzVHoTezXanPb6f8n+7cYRcCuttDSgpi
         tFaXBJZKBP4+6hNuLb62R58XPxQCjoqVRfZsoU9Qj1i59U8d4yrVQ+ScSzwvTJHjFrmb
         ulsjBmlLqACfB72/pFTaeBI4+5BmfgvS0wKZok2JydqY9dwrCVpfiSNTWlbSKIILhIk8
         K2oGbLj3tLucv7asp8oK4b+IttL/934GTTQhCQsZsK8jkmdCXqz2gpNGa8N6SJ+UKiDx
         8mDx8I0Mhu0TJYz6U4KYh1otPuSgg/DTgTbocDtxQZY6WIici3RE8rD54KgEYW9y3hvg
         r/Hg==
X-Gm-Message-State: AOJu0YwAjbqVVvsByRpkee/7ehsyDi2UBJrdN6q0pLJlyfl3xpk61DS2
	gzfmXcEnxqQ4f4zHlTr8lPwPIxZ50NVvzrjEY1bm75mJYG1RKoBnrrGRGJUGduAFCC68y6FKHG2
	4qVp2mXyN9McBcq25ojkQh2252kNQ8Y4=
X-Gm-Gg: ASbGncuobFyXFqx1l7I6Vh31xrDqinMgDDCyReqvH5mGdS+E770LOOz0zUNFTXrHDb9
	GobB9J8awRxK/sStoEvlzcI6pXz40ydY97JISDDbFRK29QhlCHizqZc8JuFTWMB/PWmeIlLjf4w
	rUur3ciHEgbJD8vbiL8VYE6MnoveNie52JcHhYel/F+2EBnnXAyVFPT0+LDGpTtp6ZnjFN97Izp
	uFNv10=
X-Google-Smtp-Source: AGHT+IEKpusk7rR1cLugmtWkkz9PFo97Oh1Z/+fimHQVtHNUNKaWBbUHXYWFcH4Oot+jNmnEWg9Q8ewoVJGWFElwCio=
X-Received: by 2002:a17:90a:d60b:b0:311:c970:c9ce with SMTP id
 98e67ed59e1d1-31e5082bbbdmr10747359a91.28.1753366329319; Thu, 24 Jul 2025
 07:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724104539.42620-1-lautrbach@redhat.com>
In-Reply-To: <20250724104539.42620-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Jul 2025 10:11:57 -0400
X-Gm-Features: Ac12FXzqt8iSKSs4Yp-ezioBJsYpAU2XjvS0k1NSsbeVpk8vq5lBsLVRv6Cuap4
Message-ID: <CAEjxPJ5vzcrkieyAieFDaiHeWGDhHgLprp4qi9mLeVKfagp75w@mail.gmail.com>
Subject: Re: [PATCH] README.md: add link to the github wiki
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 6:45=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  README.md | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/README.md b/README.md
> index aa98d7819b01..5c6caa9d710f 100644
> --- a/README.md
> +++ b/README.md
> @@ -19,6 +19,9 @@ Please submit all bug reports and patches to the <selin=
ux@vger.kernel.org>
>  mailing list. You can subscribe by sending an email to <selinux+subscrib=
e@vger.kernel.org>
>  Archives of the mailing list are available at https://lore.kernel.org/se=
linux.
>
> +See the [SELinux Userspace wiki](https://github.com/SELinuxProject/selin=
ux/wiki)
> +for more information.
> +
>  Installation
>  ------------
>
> --
> 2.50.1
>
>
