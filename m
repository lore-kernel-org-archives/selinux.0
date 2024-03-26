Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD213D523
	for <selinux@vger.kernel.org>; Tue, 26 Mar 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485605; cv=none; b=bJZ86uq1AYJKnNHos9CBtSD9VBhgCzsULStfKwyEMxzK3f2L9YBBGrM5m90f6rfFr8rMc4p9JcS93lTHCuzou26Scg5Sh8sHW+bZu3fGiA3n38kLDFXThydqndmbutMJZciXwKWsmC+VkjwvKmbmjcxuKvNIrNwLyBAydT4oqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485605; c=relaxed/simple;
	bh=WruQOz9RaEv3HVSegh36YJN7OSGfDHYA1SUjz10NO3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNxaI2709RyiKeDai6McewZ8pE0Wr/m05ToT824CiaErNPuMJiTnIfh6ILmK2JGjaD9/uJ0zxGXtAsjO3/PS3tKfj1z3c7n6W6C1B2yaWBffTZbCre3QQzTH7kd7RplNVP+GcGXaBLLcyz9ADPKqjdSESMkHXrPPJv4MQJSW7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EDF0sf5Y; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EDF0sf5Y"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a0a54869bso1934867b3.1
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2024 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711485602; x=1712090402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfA6Bw+OqHDFIH02i3SdSOQOzi8KrIdytQiZZA87Vsk=;
        b=EDF0sf5YQ0IellJZEMR50G7XA1/CyYTEIdVXam2F7o4cdYEV8eIsSeV/J6As+iBxvh
         2yQa0UF/6oxk1g3Zpv/4F4nqu0j+iLG7H06h5kkA26vtF3QW8QiMIIpb+Oq9jX9ltiah
         K8aRRMYtKumV/UgWqBzNFJR8WguMxzqSuFtNHU1I0dX9jKIyjAMYh1WM0r0nPfybnfFe
         mHcs85loQkHFlzAO1fkjgBkSF5d5cHJ4NqmR9zIuyDuh+eEoImAexZfICL5hjnf47Nv+
         oBpOxqTblKi+wSj5FrnG2xEUnQPYKJVV9nOYcRPKPOnggolhiqdZ8NU0MCLGg7Sof/au
         jpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485602; x=1712090402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfA6Bw+OqHDFIH02i3SdSOQOzi8KrIdytQiZZA87Vsk=;
        b=krvrsjlorW77RBVxWdc/PfuFtxwzvK97slovazts5+/szahAuVgVG8F+0CZN4hz1Cp
         Vcjm9G5oHw5ki1TedX3YOj6apOhiKwJwhWhzwr0UYERUMhgsSCHwdAfMyS1bJyFLAbbz
         Fw5YLs0DGxpTl7w0HyG+Z3D9F5eb4XVKeuBSeS/iIpoudY/Slncm17Df2kiTZ2hEdekf
         VaB28KPQiqMGFJvmVahfWbZt28pr7GnlLKB8WUyVXAdSJvAr9pBWxQdN83friJr8VjaP
         VjWflWxS+9Gm44FEPkt13oda4Q2fbCNSBO6xYCLX54Cx+z0s96CXYtEvbST8Ppnv1xkb
         vN+w==
X-Gm-Message-State: AOJu0YyOw4Mr32zX0mc+tkvY7oAG7O+DHKYFImheBt0nJr1NJALL+MVK
	a8J6M0Km4uN528GptyLO223E1nk0iJ7HSHx0yDbmSMhCzyemvDRZ9eUnNohwPy6Ys0NUWpmkfMX
	v2FtESy4mSWk5O0l+RNZLHnS+a+bkAgcYvJIZ
X-Google-Smtp-Source: AGHT+IGojsm7tQ5IjgAZja3ZCicVNmkHB0OiNPAhpMRvWu2bsnClyYgJZH/nGSm005+lB31cavBaGPAdYzYaSe2kNak=
X-Received: by 2002:a0d:eb45:0:b0:611:71b0:4ee2 with SMTP id
 u66-20020a0deb45000000b0061171b04ee2mr1807908ywe.23.1711485602560; Tue, 26
 Mar 2024 13:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315173105.636749-1-cgzones@googlemail.com> <20240315173105.636749-2-cgzones@googlemail.com>
In-Reply-To: <20240315173105.636749-2-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 16:39:51 -0400
Message-ID: <CAHC9VhS-nTktDCbdrb2Zos_GtbN1C87VijJUqB88sZWpn+6m=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: avoid identifier using reserved name
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Avoid using an identifier starting with double underscores, which
> signals a reserved identifier.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Thank you for the patch, but this was addressed by the patch below
which was posted on February 23rd.

https://lore.kernel.org/selinux/20240223212640.305789-2-paul@paul-moore.com

--=20
paul-moore.com
