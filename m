Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA289280A5F
	for <selinux@vger.kernel.org>; Sun,  7 Sep 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757264327; cv=none; b=nch/VwUFWxQoeaaknyM6q2sbaAIt1ew2UZUUN5mvnY0s3VKi4L/HgPDTtuQ7qqbO0rqK6ZhO9jmD66HmTjQVZjLXsO3aTNQTdISQ5iDeUIiUuXw9z+65Ldcwcjr6Fgd1pojakWSEXd32GZw9N2JkGGjdfCvhktGGclGyf+rsSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757264327; c=relaxed/simple;
	bh=UG6aaIt/J4hlqTLrVipzyXLPRoWjC628BnP36N7T3tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFewgakAzxtGeYoa1ebGVuZL6ufiaBGXSazawuFTTk3+AIbOkhDuy525ljyF2EG8NrnGUmNv3fknRjhs/59yCfvnmDycfqxsoA1QMbvk2guLEX+rpaCiQ4EjgPjzbSlSAIOtoWik3zZCm7ee7o2ub7EDCP9P6ziLanv2NZwERa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QsRCqpT8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QsRCqpT8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b2de2e427so25676295ad.2
        for <selinux@vger.kernel.org>; Sun, 07 Sep 2025 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757264325; x=1757869125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8rxZBcVWqeQttZjBzXJXbXm94rgTwoH9ei9j3iaczA=;
        b=QsRCqpT8mfEfDjQk9wir2rYkxZyBxKdUdVaAilyomOJ0wDXQ8sckCyP1nVibeeD7fI
         5zCIukFyw1Ktrs3ABSvf2rGEJUUrrI8NF1QACheZoywakeAxqdlnLL4edIGrnDyJflKN
         gZFQuzojroFnuBVyFc8rrrLTrdZ3C7JMiXYv5xZNmt8M9b2madgtQJ9S50BwAoFYOhzb
         KATyqvucVbNudODuh4/tnUeOpKkXohZrHnGUdhP9dPnwldsdPUf7poMIgjjvQ9Q/Anpm
         5ATc2UaxgwJlWCGHA9t+afOu97ghCPTKmNtAijd3yQYccDk5kD2JtTMKrCWgkKfRNzM7
         ZPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757264325; x=1757869125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8rxZBcVWqeQttZjBzXJXbXm94rgTwoH9ei9j3iaczA=;
        b=TzAIpPiW1OyupcCKunFk4ZPm3sxVADw6Yo0xzQnytUInXbB09MEEu2tRn0EQdxUJkO
         fk9ANsZL4M/DEGh1d+rZnn+UZspqanSS3zwdn7taIBbFAiYfxrCiquZCfEyrFJbqDwNR
         hUruy2dTGbjhjv52pm46/9mAYWjk89sAFIn3SGofXclEuMhxjsMm3YKgXcKY65wh8blx
         US/LYXlYgLSGQG7S2uJInvDZ5kKhJGFUxX2/TfW2ZDDjXflVL2Z9xyH61h5joe0YfP0X
         triSnzqVTlvF0LGXNZ1+3zYS9J3VFit1amiNKa4uySzxnB7wx4/Yrm7orgptAhq7HgFG
         2Prw==
X-Forwarded-Encrypted: i=1; AJvYcCXrzpKd30omPZ0ih0Ij1kZamscB53A8ja13b4lAkiqHE6DzES0escpr+2ZhMeuQ/5/YGZUt8y5F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VULuQGvwY50vFx/5IQSrKpc5g9crpFqcTFPYFO7fFwrnXLGq
	mKL3VYGcQqTpdX07sye50HRHrt/IQx+laXw4Rp5eDhZLn+uxE4nPlZ6NkVdKk2nIcgR3SZFB4YU
	U0K71O141JstB3djIkCnvuxoUxDwJXL3iBHu0gXRP
X-Gm-Gg: ASbGnculgGo/ZoVmPD3YVpcDy+GXl86em1D8gQT70kWQwGWyKw482wvKCwumEIVG12Z
	ivMZwa8GpfilYRJZzU5zRA9RBnztwIASuyMPREre1OasEodBFPcGSeuL8U7c26FrSSqltMF9HjA
	hQyOlwGpWWM9jQWBbJx12T0fwrTg5DPgAQAMEqPz2VJ4MYUDActT/hZl4IaMrAJRWKRA3b3zq48
	CETbz9C9zEtORfJfA==
X-Google-Smtp-Source: AGHT+IFaE++x7GtzCCIsBv907Sl2uWTltDpZX4herwHYVlHepL8ORXOJe8XeTw2pWIVYggy7DyLPn5X/oi9GlRRt5xk=
X-Received: by 2002:a17:903:1b68:b0:246:b46b:1b09 with SMTP id
 d9443c01a7336-251715f3129mr65953055ad.30.1757264325209; Sun, 07 Sep 2025
 09:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905222656.3692837-1-nkapron@google.com> <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
 <aLunR_0BPCrATnBP@google.com>
In-Reply-To: <aLunR_0BPCrATnBP@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Sep 2025 12:58:33 -0400
X-Gm-Features: Ac12FXz4UWnBPZx5fAUVbpMVPdPjXX8qeZE7T_l2WMRkmXHmb_U-YFwEaovDvoA
Message-ID: <CAHC9VhSaAm3G9bnJ86Aj+DnTio19ePE1Pu3voaB3XUvBveodbw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	kernel-team@android.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:15=E2=80=AFPM Neill Kapron <nkapron@google.com> w=
rote:
> On Fri, Sep 05, 2025 at 10:13:01PM -0400, Paul Moore wrote:
> >
> > With the original patch sitting at the top of the selinux/dev branch,
> > are you okay if I simply fixup the existing patch by adding the
> > missing '!'?
> >
>
> Yes, that is fine by me. I could submit a v4 if you would prefer that.

No need for a v4, it's just a single missing '!' and the commit
happens to still be at the top of the patch stack.  In cases like this
it's easier for me to just apply the fix manually.

Fixed the upstream commit and pushed back up to selinux/dev; please
take a look and verify that it looks okay to you.

--=20
paul-moore.com
