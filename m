Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90C2BB15
	for <selinux@vger.kernel.org>; Wed, 14 May 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231217; cv=none; b=pdYHEXzrqhnU8l8UczWJHMpgat45B083znpXWvf5dngoLkihmOt01smO2tGZAH/iyQpR6lWy+/0jsDxiamWVuHCH1jl3dUYIluJ4PdpO9dwXjKX5SEjPqauRAdFa+kezXrBqNTzD1yHDp1fQHlqoQi+QKEOyyUAHgVWFnxrvGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231217; c=relaxed/simple;
	bh=5xZGsSP/JGGdOR2JY8uEMSiGs1eqj1Cp4CKuv0BFN6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flgf1ZEs7TKxMsgL4zN+1ShVmot8SbjfUF2OUVkr+YNNnb0IMobUTu1fu69ZCM9ob8foe4WF3AXoTVGFL+NFJBBP7OXSr6tYQCBZsdD3uBmhhjnKcbOnci0qAuDgmOtjuE8D6/nxhZWHWD8xJwTh1eEQJRw74NgPQkq0kdKaaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICzXckZF; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICzXckZF"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87a0b4b4053so1145136241.0
        for <selinux@vger.kernel.org>; Wed, 14 May 2025 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747231213; x=1747836013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQXC1CwZGz5QbYwrOPdErl7WYBb0YmHPblClCK7opSk=;
        b=ICzXckZFYhcZBVSA5W6Va5cOmvDqqOxjNbGTUFk6n7WqTNgZTqYq9t+XWBCu0NKyKW
         BVicYSuFPRV8ZdzqLOuOH/CR+c4N38l5z/AYRcqG9GZAPL4vRW1Fw2kVrwp9BvK2YLGu
         68v1+WSEjRJlvCppmXw7MUQIcRe9HuG4OpSCksyyhnpFqJCF/RZGZF9rmk3SLujcVpi7
         6EhZJCXe+pKKaYISkT6dkUakeKU18n4rrnvdTOaiV7ET96s1h0tovZ4bhlQXG97DfJIp
         9GXjG0Epawh82Y1BKyl4XrP+uphYkoAm32Ix1Nrbeie5mDmFFdEaX5Gl1I5Pz/Lfv6Vl
         wzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747231213; x=1747836013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQXC1CwZGz5QbYwrOPdErl7WYBb0YmHPblClCK7opSk=;
        b=LYLFgq/VupY+A11tf3Bb8NJkHwURmrNZtVOVNPjHcMOUe1PvT951o8k6iR9EqO+0TD
         xPYhas5QuuMkQz2wEwoaVgNPj4jjI22nCUwb5yTKUJFE0eB3xwmRL1FmwsLiPDUk6Qwc
         UQ6X7KdbyeyL+X54UGx2+5/qMlW2fUB6TXYt6mv4FpOKa9zC0uO9fGJ05kb1y4dHH5Wp
         dD/zedOtU3kLHpcKwQo4kJfkGM1fqcuOXFvj7GGFSBkDh0+uxfau+5Y0ZhwhWeYlX1h9
         iPODoNzwoaVwau71/MBv3UASp2L/486soDSdhkppr7qB8yeltuwplnlo/g3CadfC4Qyb
         qZug==
X-Gm-Message-State: AOJu0Yx1T5JonAgHryHoMVDJA2AnxekOK78PtihslvC4315wf+in0q8l
	tRiXebiwS0l94zvMDRDcqMVgJeJzuc+QwnLJigIgVWeVujxEZKj/gCVFZdsMZKlWsO7yqp4ZpiU
	ByC+1yzIu/cPXX15y+OjkiTBcefHlsAiZ
X-Gm-Gg: ASbGncsUpVJ3WdbA9nM2VzovRyU3KsmY/b9ZLiR1Ga/iFmmMboaeizsXR4CBjDZ7zXU
	ct5wySiGWXQSnuhfV+R50zAxVS9mOwCUrE0wdgZNZUbxuxKPpP11Cwms3ymutNnCyhIiYSf4dte
	CihQSyUmX0R1OcqO/Q3WYFoFKnTj5O3dpgcTgdulq7
X-Google-Smtp-Source: AGHT+IE34zyomO47BVCCShOTj8PJZxjLmjp8+wSyLpLekbZPV7d0NADNO2bBxCVu2iHaz5sWlQFw6q43tR/Iwr+UFL0=
X-Received: by 2002:a05:6102:4b10:b0:4c3:6a7e:c9f3 with SMTP id
 ada2fe7eead31-4df7dc87905mr3207831137.3.1747231212890; Wed, 14 May 2025
 07:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514070651.223058-1-lautrbach@redhat.com>
In-Reply-To: <20250514070651.223058-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 14 May 2025 10:00:01 -0400
X-Gm-Features: AX0GCFv5Eyy2yE03I_nVGcOx-uAgJ6K8Cy2J-YEkyWMTJb5xI4cHgkkbQYNxVHc
Message-ID: <CAP+JOzTrufGGRqxbf0A1i+B9HuZ7p-WW4huutxXU2fDa_-vwJQ@mail.gmail.com>
Subject: Re: [PATCH] README: update subscribe information
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Kalevi Kolttonen <kalevi@kolttonen.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 3:07=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Majordomo commands are no longer supported after the migration away from
> legacy vger infrastructure.
>
> https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordo=
mo
>
> Reported-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  README.md | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/README.md b/README.md
> index 1e16beea6536..aa98d7819b01 100644
> --- a/README.md
> +++ b/README.md
> @@ -16,9 +16,8 @@ and system libraries which allow for the configuration =
and management of an
>  SELinux-based system.
>
>  Please submit all bug reports and patches to the <selinux@vger.kernel.or=
g>
> -mailing list. You can subscribe by sending "subscribe selinux" in the bo=
dy of
> -an email to <majordomo@vger.kernel.org>. Archives of the mailing list ar=
e
> -available at https://lore.kernel.org/selinux.
> +mailing list. You can subscribe by sending an email to <selinux+subscrib=
e@vger.kernel.org>
> +Archives of the mailing list are available at https://lore.kernel.org/se=
linux.
>
>  Installation
>  ------------
> --
> 2.49.0
>
>
