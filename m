Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C617C77
	for <selinux@vger.kernel.org>; Thu,  8 Jan 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891826; cv=none; b=XDJtdrL3Y6A0bBmfHvis9Uevd8CDBNy0y1H/Kyntc9bMVNIA4s3IJRjDsDuiJAfoKh93iooKJBLW8y7OKuLFWLRaUTJZXwimFFuDhMLwGF1MIvW4HfkZRn3p+7RN1nf/1bwcSQYgXWlXNXQ44Pu1CwMyd9vFs7z64KvwbcuQG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891826; c=relaxed/simple;
	bh=oLXKrWjIWaSxe32RP4zad62MBf6/8eebQstSBSnc73I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RktYOs9JQBesOjNADc3Z4CRdefUVyNaa9Bjj5NU+N2I1QUscF9siJPJqcfNOsurJDQeei0qmHBNmvRnyFdfLW9ANVCFzfilzN15qfq/AMl6NrmeTFJ5WE8LoUCZ6YipLyEXlSOp6tJL5HazscoP/sZe0/voKS9rFDMQiO34qZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XARLOoBl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XARLOoBl"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b7073f61dso2643121e87.2
        for <selinux@vger.kernel.org>; Thu, 08 Jan 2026 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767891822; x=1768496622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLOY6t2r8hj126NyfoI/BkgO7qWO7BRz44n0qgJqrp4=;
        b=XARLOoBlQHGiOo9MUKIez5uaxbrXdgitjht7jmTkSovEjtYiK/Wgy8IHM9gdBGr+x5
         f4tyKhzJMAVLokXUwPwi8ZAF281dBp/0SU26CB6L1Km7hmd+hOWmmvAbQC2Z3G08Gblc
         6OyneGf3VCcjwK9dRgP3g7wCt6V4PasE/pPiYQfseXQiFCDJlitRNK1QVnEqXMoPzi6V
         aw4JghnfDeG7JdQQYxAOMThMK6XbOVshQm1qIUboqJwiOuS+SLpUDDnaC/dlyH78Nj/+
         vQZ3cU4KbCPi1xA4a196IAKchx03rjfWkbx3BGc+0YHME+JgSi8aVY8RCj+gVCENtJ9A
         YScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891822; x=1768496622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RLOY6t2r8hj126NyfoI/BkgO7qWO7BRz44n0qgJqrp4=;
        b=sm+TNnTOJdYjGfUeEEvw2AnUjYySwSgC8HPVHiWyxaL0W7mz53kTa78cSPCl50hVuZ
         NY5QKRpQWu5DgjG2CZz3IPpl45E6asCmi5vLAvbVpnJK5TOVWKfq4ABypglcLPJIBp2b
         yGTQaPbglSvGp6cQf8dgHD3OWh+LsJQ6l724j5LpuOUVPHGTZIi735VtVMEVs1p1ZKqk
         kpXtF0mQcG6nOqTvmkVGG1fINxfCycPHSCeG4wIKGkO60X/ezIZDIsEzOKbIOOXWDkTH
         0ri3RqQF9xpbmjsEsBASngskS2LIMbL0VdA38OFEWeZZ5P1WDcLwtnh8zMd6Auz+7tpM
         hJOw==
X-Gm-Message-State: AOJu0Yw5o7u0YtfxlTLqiIrdgF0ZWExSFCQHvgiz6ngRU6jtdPsQS6ne
	A/Y65zhX/WPRuWyFdDXlJ6i8Ev2hbzyZdzJlDwDw8jTThPqtDvhEdF7ZdgDGOokjrbl95l5TOVz
	wpO9eHPHyIcmtgPwUNmciLT99SJzFj3o=
X-Gm-Gg: AY/fxX7NwK01FlS1AlYVg/zLTcD1Dchv3c/RstqTwBFyg9yRzfXxIvk0yH0BYEqYXa5
	5HiUzVG+w544/qj3Pthh1MEkBncbtCCcUDpiFJd3OTONtsHbYhS6GBUJB/29yQvKQ9OvzKBMWmD
	bOFQ2Jz8dFx7Rqiq11V/SCGoGzf0TznFHOiWpN2H1oYOeaaU7czDYNX4fw//JjgaIuu6C9yXqAR
	cE0rIZMiKjWGuY5U1sxEuF99KuBTTUkHeToxBQnaxmD7O/q8GdvY59FNjoKVTg1QDD8
X-Google-Smtp-Source: AGHT+IFj/OZUqIhpbFTNJsfD7HbnlI1FX6zlSI2feZhsLRzVgY/Tq4Npg47aHeIzM+bW/KuGZ2MkBJe4ZTY3nvpku28=
X-Received: by 2002:a05:6512:b9b:b0:59b:6cff:c6a9 with SMTP id
 2adb3069b0e04-59b6f054d35mr2182631e87.47.1767891819300; Thu, 08 Jan 2026
 09:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123065843.377806-1-nvraxn@gmail.com> <CAP+JOzQRf9cvUAe1CJyxUh_QFxxZ+-PRCgWSW==XNifMJ1s+xg@mail.gmail.com>
In-Reply-To: <CAP+JOzQRf9cvUAe1CJyxUh_QFxxZ+-PRCgWSW==XNifMJ1s+xg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 8 Jan 2026 12:03:28 -0500
X-Gm-Features: AQt7F2ppbeVKwHgGPYrsuaMG08xska-9VlGa6iY-Oze_NUQV1s3l-8gEmenOMKM
Message-ID: <CAP+JOzTbeAt4dgGGvyMfLABFx6qzxStwLEgrFGBNqCjGV4zK4Q@mail.gmail.com>
Subject: Re: [PATCH] cil: reference guide: remove extra @ in valid symbol chars
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 12:18=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Sun, Nov 23, 2025 at 1:59=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > @ is listed twice.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  secilc/docs/cil_reference_guide.md | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_refer=
ence_guide.md
> > index 5ae5a3a3..bcd34b68 100644
> > --- a/secilc/docs/cil_reference_guide.md
> > +++ b/secilc/docs/cil_reference_guide.md
> > @@ -93,7 +93,7 @@ Definitions may be repeated many times throughout the=
 policy. Duplicates will re
> >  Symbol Character Set
> >  --------------------
> >
> > -Symbols (any string not enclosed in double quotes) must only contain a=
lphanumeric `[a-z A-Z] [0-9]` characters plus the following special charact=
ers: `\.@=3D/-_$%@+!|&^:`
> > +Symbols (any string not enclosed in double quotes) must only contain a=
lphanumeric `[a-z A-Z] [0-9]` characters plus the following special charact=
ers: `\.=3D/-_$%@+!|&^:`
> >
> >  However symbols are checked for any specific character set limitations=
, for example:
> >
> > --
> > 2.52.0
> >
> >
