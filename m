Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D84175A6C
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035456; cv=pass; b=XY5B5sgXTYRgb9vQMHh1cO7vEujfzT+oqTxPvqniOItkcopaOE2kGLlAXW96XEswI21M2gKgBi51N9f32FUjbpJKTmyHEvwsPEBSftHSTGz+6cFKJsSkeAQBhT/SNEBgFM9YSSWysAwlJb3vWDvac5G/KWzQmZwG+VuUoP2gRZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035456; c=relaxed/simple;
	bh=6O3cI6jJ5g0ksWTM3fEBqCAZTJkmOxpFLTxzfWBHUBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFDMdHKoh8+CgqWAvg1GXk7dJXs/tN5E8wEoA185pjWLKWDNnolOzjEqoBZRAltGvtdw5CUua067r8IVAlF/btyTGlrBtm9hcw48Dm/h8CVY2PLlsdY2a3DyXoH+S/zj8gKx7srwfRDQnoAKReK9ATmh9jyq6wnuD6iqHWx4HjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5OhWgCr; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5OhWgCr"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43b7e186a0cso885072fac.0
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 09:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786035452; cv=none;
        d=google.com; s=arc-20260327;
        b=Ksz7H3KL5RgbXcYmWOPpXYS4hUNxZ2UoRPeYnY/tEbdh8AplmAA2TAAy87Dnycah66
         95MSTU4xRIraPEFok2zlIVKUT8TJlIKcphd6oChaP/K/+olZqXhFtnBWyJwy+ThAMM/O
         WE8IEDpn3UtKZELuq4jJc/evR4ZqEBB55Wuf3aLvLLP3Z8qr4IUKPDMgid7cqrvs/tAk
         /oEk3WFsWfyTRsfCoz1sB7WyLMPxwwC/HvE8/rmbKpD64y7HvoiETKUPMvFEKGg6cEGB
         HHc4nr4BrgqBndIKeSTMAEmraHpd/L9QxPnoOTqCWzLzdOB7pm0y2lD/9H0iAQ1jDLSH
         uevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6O3cI6jJ5g0ksWTM3fEBqCAZTJkmOxpFLTxzfWBHUBI=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=YQe1S5mDdr5/qDmp353ibhYm0F624jysGfDJEvwOpzLf/iAubMEFa8/TerBuLx94lF
         vEeELcHNYwiewWGmIMRFHvv00tVZztTu8BKc3SiwbqaUGCvMhPbRZ96reKvpBNmGUkc8
         jOYzkHCRIvt+4Pz3atHEqNNT4YL+DnOBPKpcDFWv150olKhE0y49qXiNpM25yj0k59nW
         Xs8HvFwwHrpZ3Jn684WF1vY6g4QNsN5zCFZsQEm8BLKiFzUPqhDODgPVIO0hp08cJ3o2
         vITOz6hrQLl6PWYFk+7S8vKEImV/HdZxKJF9hF6GrKPQO6L7O698HXO3+plMl0bqTc0v
         l1YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035451; x=1786640251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6O3cI6jJ5g0ksWTM3fEBqCAZTJkmOxpFLTxzfWBHUBI=;
        b=l5OhWgCrE1DDgJ+8LhwLPL1+WrY0Dv/x461x1dgNJFUhXPmbi+IgDGoT9xAR9zc6S8
         g6eARXIk+6Fgs2O/pGBfeTG4Qemhscaej5y3feFZHv4GY7XeU6gBXB1bl6piSiOIr+fM
         24GhxiGDtUZ6LjSboGAOKYQWBdUb/o232IEa8lFhmZBDBmNfVo7HRCzyddP9BdNFAjZS
         WAtl/7lilXg8xUo4TwTbiSe6opxz+P3pfSPe6k+CBR+wxTgL4gc05+ZO5clkv5usm759
         zWIXV88BWBeMPsnnbw1wEz9qvyxzyFCztHXaDifM8A6LwLa79SQJ9g1tHgOSsi9EzE25
         aNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035451; x=1786640251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6O3cI6jJ5g0ksWTM3fEBqCAZTJkmOxpFLTxzfWBHUBI=;
        b=Fj1nfEvPGdJMitYfClQbX3yvM6rMRGRyMx1Y9Nu9NP++UU/0VziRIZmnumNDDz9xSR
         4sLgqiieTDeMlofcLfWnJeKCizUvR7EEyRnmxqLp48gijQTIone8EB+NL+O+ujwISDDk
         20WtaUkQPgIbIHQALaSnLFpYH0CXnAkEmfxlNB7XCB1PDIrOxcmM70/8YfJl1B9ar37l
         kFuDLeKtZvSgQOIKsKVCHRApt5JY/CUU7Qb8wyWFmKeM1j40oPAKbVpNbnD8GtzwJIfW
         /bVfS9tKrra1Z5nEh/w/DzqS2+QNCNjq0uD4nPlvt7RgFu05zrpZ6c/uUJ+1DkqL/QJO
         IUng==
X-Gm-Message-State: AOJu0YxyGXwEJbZEybVnL0gQ3OqC9vdXjbOii+RwtugpFFdCdSxUDqT4
	eSOr75tWlAjKoakkDcCga34fXIyzaDDS8ImOWojyK5NFvCSQLXhvwB0XrzR52StVit02NWwHYDt
	Lj5aqQeVXhruKASI7qXb7mhHqLZ8FsD4=
X-Gm-Gg: AR+sD130J6nDg0fbrjp2ZZUuEgPBnstus6KXXLCqu5bsw4d8onQxdrSRU9nXwjBUAMV
	T6ktqW9GDwYfCCPLoivXLZ8n/jyUJTivCjpYkz9FrEJ6MHAlWxCDWfabdV7alYW3W/jA+BoYafu
	t5z8bny2i8Fyx+w+Y0gvZQZdyMqtuCOI830nmIE65R6O8cvUZs1ZiLmgf6UvPkrM25TYwVKTsgQ
	Pru/lYesEEOrnRg0jUPIy2cxW0ia5Pilv9Q1TaBvYvDDWNIrF4f1T73/h32KxLBEm6WuNUaWXvN
	5/pm3TF8OxGTcPC4KnrK1L82+s5kJ/FVXJgJzLxWhpU5
X-Received: by 2002:a05:6870:56a9:b0:455:d4ba:1dc6 with SMTP id
 586e51a60fabf-4599ed5a251mr8405242fac.5.1786035451602; Thu, 06 Aug 2026
 09:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806141514.101723-2-stephen.smalley.work@gmail.com> <CAP+JOzQ-yqb7KBVABmZic8A1qCZ+6SQAbjT64St04Q=U8uFPRw@mail.gmail.com>
In-Reply-To: <CAP+JOzQ-yqb7KBVABmZic8A1qCZ+6SQAbjT64St04Q=U8uFPRw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 6 Aug 2026 12:57:20 -0400
X-Gm-Features: AUfX_mzE3i0_HC4Aro9xmo22pzbquYZ0o-9AUo4-NSCjA4HUGX9bCBvP7uuX6gc
Message-ID: <CAEjxPJ6Fpe45o1hBTVAgYiO8QwvJQEBK97dKSNqtNnHHXAsLKQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy-fuzzer: drop invalid assertion
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:35=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Aug 6, 2026 at 10:15=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The checkpolicy-fuzzer has an invalid assertion; checkpolicy
> > intentionally tracks errors via policydb_errors and does not always
> > return non-zero from yyparse() if there were any errors during the
> > compilation.
> >
> > Reported-by: oss-fuzz (issue 471491765)
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
