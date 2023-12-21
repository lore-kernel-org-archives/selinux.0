Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A74BAB7
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlyImJa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703150016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhXcjimbA+UHKFEnPBX4vXhMjgMxxyJ9M03URS/LJEo=;
	b=UlyImJa9TdbPK0Yla9YPdSAVWQsPOCXnVVY9d08ewvAKUt2MHI2dfIWloyi8NWUXlgfoxT
	/AIPMS28svGhUAF+2SBWBANGR0Wvdbu03sDhoHZ450saim/QmTMm/L8oAd04k9iPF43aRH
	I8gy4jhc1w9/lGgOadggQp5hxV1Vz18=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-UP1abpRiNiW06n1dEnXsOg-1; Thu, 21 Dec 2023 04:13:34 -0500
X-MC-Unique: UP1abpRiNiW06n1dEnXsOg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28bd843b040so324437a91.2
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 01:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150013; x=1703754813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhXcjimbA+UHKFEnPBX4vXhMjgMxxyJ9M03URS/LJEo=;
        b=C48Zs5swUZJyuVCBy79gPEN2usIHZCncORiu7SOP5pmbFR0oyEvwtUrvqAavi/8Cg1
         ibov4jwnS+m6kgEMRq6YobuKePr7WP7QTVyVP6aUUM+SCrt/Mh9lQLcuJrExUotph5oj
         wi0/wVoAKieyTU1esdDb02OjIe4J76isprjA6jF4qYYgf7MCJatXKTOrwMG1ZQVp2ACX
         DKospF5i/iF2D8ii682va5Hh6azseon3HGyAKMZJcmkjaeXkAAQSkHaRQz6nvayAY2I4
         0XGEo2wXvQt+Z85xLFj+H5Td4TuHjzkPX3XEWTvne6EyaRfAe2i1Vm/JeOnE56CokQQb
         V9ow==
X-Gm-Message-State: AOJu0YxUbBqz/OGs4rzXapr4xE4raXtSXDUQkGEmP1mbrMmuhHE/quFC
	qq/uLZAeSteGUfcluTOx6CThVHQeeaKcIDBRIhsdh092FNIwxDwfVvTJZbuE1C37wZXbL7ZgOuY
	/Qg1QKqHz7h/17h1FySUp717KfhHaxw2tOZfa3yIK+eyH
X-Received: by 2002:a17:90b:3113:b0:28b:f30a:d659 with SMTP id gc19-20020a17090b311300b0028bf30ad659mr164786pjb.41.1703150013372;
        Thu, 21 Dec 2023 01:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+DZd/3rec37F+j0xjrkF+sD7zo454JG9PXq4V4ddSKDgFZsmBvQVRKGqx/LyBdB3/eaBLyb0a3qdt+p7FCaU=
X-Received: by 2002:a17:90b:3113:b0:28b:f30a:d659 with SMTP id
 gc19-20020a17090b311300b0028bf30ad659mr164781pjb.41.1703150013088; Thu, 21
 Dec 2023 01:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220165244.126550-2-paul@paul-moore.com>
In-Reply-To: <20231220165244.126550-2-paul@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 21 Dec 2023 10:13:21 +0100
Message-ID: <CAFqZXNudh17nG1BonyQ+_UoxaX4GpOetW2L+Retci4rn5kdjNw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Ondrej Mosnacek as a SELinux reviewer
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Add Ondrej as a trusted SELinux reviewer.  Ondrej has a long history
> of providing quality SELinux kernel patches and we're lucky to have
> him as an official SELinux reviewer.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 931c52cc8393..295939417dc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19518,6 +19518,7 @@ SELINUX SECURITY MODULE
>  M:     Paul Moore <paul@paul-moore.com>
>  M:     Stephen Smalley <stephen.smalley.work@gmail.com>
>  M:     Eric Paris <eparis@parisplace.org>
> +R:     Ondrej Mosnacek <omosnace@redhat.com>
>  L:     selinux@vger.kernel.org
>  S:     Supported
>  W:     https://github.com/SELinuxProject
> --
> 2.43.0
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

