Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AC1DA41
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMdCAnqp"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28bd8e76024so52485a91.2
        for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703105698; x=1703710498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEQpRvKkFSX/GF0Fi8lqsvfM4WigS7Uf1dnpFJAbtuc=;
        b=FMdCAnqpHcQ49g86F1XrRjVw9zeCzGthMmTOXs6OFceMlw+qpasc5fcHQ4PFxJxk26
         skcFOmyheg1yl94ejp9Bpi7nps8LBgvU/B5Yl7MnRoPs9KrU40rqTGhlk7i6oX/dQC/p
         oTsRU+y0Y04CWp9JsqvpL375vIWKLmBoGhcNdf+mqF11yxdCUQw1Oqa4D4OxEUV/CjW8
         Ui+krscRHFNFu9YK7xEDWl7ST6aFLsohhI6UVx4mB1RnQanRCIqIDJp0sSAYrbsZ6ukc
         dvehcp2JDuvmhrTyeRH6HLwSuA4i6Pbio2w+Uz4aUsA7hL6vcvReFME83E0wRfGV2yTx
         tVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105698; x=1703710498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEQpRvKkFSX/GF0Fi8lqsvfM4WigS7Uf1dnpFJAbtuc=;
        b=C+pHRRpXAxZVw7hfg/EhvHj3WFsqed8Ze4jv+CEdTcDb7690x4NAS/XRRf/hExR2cT
         ow4Aa6nuHR0jEbTRuJd+tF1GdD1kKOraDOveRbrvR6UlvbckzYJd55krWmEEEWYKQEss
         0bdEiXE78T4j6KoSqByeD8DFXQGhAFREzuEfsR4fhDS6FrFAtcVZJuuDpOtZBVTRnM6w
         RC1l3wf0t6Lo5fc9fdDXSUwCOj4Gtejgw9l6dIWMDQQYjN+6XkjEZoafB7gesDffdRM0
         3ZOpJKiai6v5xtfnMvbpp2ZUD/vuERpr9nubxQZyv/Z0abXLk26DEP3ynCi9nWLkRwHo
         P3hg==
X-Gm-Message-State: AOJu0Ywxvw2Axj6VguAtOk0iwasRD7KwkKas02NiTzNITkLEeLPSfKFE
	1+HLaC4xXfzLNni0+UfYpHwz9NySbQt34AmnS2yvji9m
X-Google-Smtp-Source: AGHT+IEK+iGapRb3Eo4YGPG7BBOJHyrQ6oOpPDSt/Qd0dljPT2X9r5VNggYQDMu/WT+l4eciC0qgEpJm49kHCvPK+98=
X-Received: by 2002:a17:90a:f0ce:b0:28b:cdf0:5be0 with SMTP id
 fa14-20020a17090af0ce00b0028bcdf05be0mr1319396pjb.89.1703105698373; Wed, 20
 Dec 2023 12:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220165348.127587-2-paul@paul-moore.com>
In-Reply-To: <20231220165348.127587-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 Dec 2023 15:54:47 -0500
Message-ID: <CAEjxPJ5W6w=Zi49_CWe7Bj9_zC8UPNW_z-4zwQooN4uXybLiCA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop Eric Paris from his SELinux role
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:54=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Eric Paris is an important part of SELinux history and we are all
> thankful not only for his stint as maintainer, but his numerous
> contributions over the years.  Unfortunately for us, Eric has moved
> on to other things and hasn't contributed to the SELinux community in
> several years (his last SELinux kernel commit was in 2013) so it's
> time to officially drop Eric as a maintainer.
>
> I also want to get ahead of any claims of impropriety and state that
> this change has absolutely nothing to do with commit 2be4d74f2fd4 ;)
>
> Thanks for all you've done Eric, you'll always be welcome back.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Likewise, thank you Eric! So long and thanks for all the fish!

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 295939417dc0..1901468c32d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19517,7 +19517,6 @@ X:      security/selinux/
>  SELINUX SECURITY MODULE
>  M:     Paul Moore <paul@paul-moore.com>
>  M:     Stephen Smalley <stephen.smalley.work@gmail.com>
> -M:     Eric Paris <eparis@parisplace.org>
>  R:     Ondrej Mosnacek <omosnace@redhat.com>
>  L:     selinux@vger.kernel.org
>  S:     Supported
> --
> 2.43.0
>
>
