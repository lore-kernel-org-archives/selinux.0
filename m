Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA35477998
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573948; cv=pass; b=nkzZWoC0x4yd8rH38uFieZvercM7fX0tOtC6/YyOHSCTablskdzPircSfrcdalrsejnzcdiW5t+0l1deN2jiwCh/+jMtS1TZKLQxoyyrOGtTB51xpMpYcQAJkvkYPZp0V/3OZ9hOMZGdfyjpbRf1rNW+4uci5upQj6ML8fI05Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573948; c=relaxed/simple;
	bh=FCYhD0W3QJPi8nwxa8VBDgZ0jA4gTisTz93+KI8w42I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9LLe49YG633yDZQatS162+EtMTHkqbPEi4NZBlXCQd1CPJhAWLy1QrPrjBSRgyZGmU0aC8H+U1JpWowSyB9F2xU0+Xo0+CiCj+4p280B34aemdl0MSMYmQ4C+5qaJ0Z0K16dDpsSbc4JDm2T2sOkeJo2mVH/3uEX+ELFy+oyEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuEd6eT0; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuEd6eT0"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-364ad762ef8so819923a91.1
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 11:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777573946; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+kSsZBg/DV8BCSXgDcNnQ+XENtX1mkNdkMLTCOBfak+9aQBd91r3OL6HmebuqMyHG
         Uizr1rwIFVt32eSkbXsVrPtgCnKmTSZSToCTRL3QWn3eE/58tpQDFWuVHMuqomGdZ3X0
         1sjGAAS37Li6fpMNtCWclLIIsE5cKGOcD+ujRFDBOfE162D4Gont2BVVaa8okjZUYjb/
         vGBsE4OBQMTaKneq1lWWT6APCRpQ1I+dkDv9dVXGu76fnB5e68uPH1rn4TuDTh4yw3Xs
         4rkSPDSLKtqvrH0WvuEMdAFJJA6ejWEbAp0uOHvbVV+xB1S0dwg3abostWGbLIaOArEC
         kptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FCYhD0W3QJPi8nwxa8VBDgZ0jA4gTisTz93+KI8w42I=;
        fh=K0P3yueWX+9wvznQ61j7DXol8naVFvlsq/Ek+LAYujo=;
        b=KCkqZENBMa/V5Qt1io0nl+yOyhvQ03yN9XVtRdUlOcgeuwyGt6dcKMZw3pHr1/24MF
         YoOymVruftkMKopc82hKf8e1e0JFoXdd37Qc7aomvfT4XOeXuH1QDqz0hOGVUTYTASh6
         DFFv+o1iuIlvt/ig/ljgLWb1HjjToZ1zJNifymIgRHPtiXMhtv0GI2ubAAzWPILwPyQw
         jRP8Mktb/8CGleYsGyYklhq5fSykPU4nCjuKrhe0p9M9qHrDVajUsvn5UMmkYs0Prw2n
         qDvZ4ioAkRnuOyxBpeZeAf3rG4SixMtqWJXM3U3tpHnEaybRzERqeGOs7Lxs2Z6vtsCU
         yyjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777573946; x=1778178746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCYhD0W3QJPi8nwxa8VBDgZ0jA4gTisTz93+KI8w42I=;
        b=TuEd6eT0Do0lsvx1qM90JHIeioyvVpw/DCiniF1JwszDAB9tzgoi1BJRMEeBGm3aQw
         AcvsXeecCBeeae6u8ZW6cXiRrRe6DSDOmbipqTEe2hgFLO3aaL16nMn6Xs8lfudh53au
         FngH7cxBI63OKTa9Ngp+CFeF2xO8fnD+KI0v6aVekXl54xt+WCp57LfU+ZZTvxSm/JuH
         NzYTrrD+s3y3LtFUKoSeihTQndTriZgiOQn/eByE7ctRspkYv1brUjj0VYU25TFlOI+H
         dMteGTHTMpIAQpgkXYrIbZJ0l5eoW9M/CHtjhCdbFruGqaaNQ4UhKgQIRFQal1ytSQv7
         nySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573946; x=1778178746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCYhD0W3QJPi8nwxa8VBDgZ0jA4gTisTz93+KI8w42I=;
        b=TjdFTsIMsIxcJoZsq5XGz50eS0bHvvZGSTEYfBYy/dN5gco6kQCkhTr2aNwrrHIpJR
         zntKrS1DFvNBSwb96HZqJSHA05WKIiLphf+bTkCDAYhhiJe2BnitTk4OAlAIQYl7/7p+
         PKHwcT6kUE9KrtScucjQaDSyzRFUxTAxUlcCrkcexeDKRQvzinKjdnzpMnEO1aPf6JdF
         56YultC4bC/Bamg9QA6rZ4qfzavbqR0oSYocIPZtOF6oMEzYMlSdwW0AO0BHe/nNVtSO
         VqA0IVm3hZoj4M/UDlX/HbIFb8VKiuaaJd0IGM7ktnoTNEqNCFacgi1K49DbqJSw0vvT
         5DfA==
X-Gm-Message-State: AOJu0YwuIMD3fCpQk23lApWDpa94GQ+I5xc7KcZL0yTJsr5BEqjF22I8
	3EdH7unxVD3V72dOlKjA9lzkLx/VAdhiTEfI6ZL70ppXAQ2n7ojAbWbVnxn5zvlY17t4hlYWqvq
	MwEsN1Oswpn+NuGI5VtnfBPVgDczk4goq5g==
X-Gm-Gg: AeBDiesXO1W1jq/55Nh/lRHiOKCHH+zrQ0VDo8EvM6cHwmE9YOL6PyR/g09xaT7/ax8
	JzQI0gkWGa0/Di+adi9UxRIAbpFzzz0QmwPX8WSCgVxF7jSRGVnFZ4jEAyQEmi9DgsVbyUXRzhF
	fVlUzRUbUzEvhncuklBnBtyCbqMZJ4YJNsEkkDZsggh17/ZiJUgpjQGaqeGnF2EGYif6nzn6DN1
	6Fl4dl232vXJ5O/oYyC25tVkJwWhitNsLdNszfxAS+/S8P0oUsWX+I8+V8i10avp5nxcDfASXrz
	lQIu5262isG00CwpjQ==
X-Received: by 2002:a17:90b:2fc8:b0:364:87dd:b2c4 with SMTP id
 98e67ed59e1d1-364c32aa4bdmr4108268a91.25.1777573946139; Thu, 30 Apr 2026
 11:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430164034.1904-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260430164034.1904-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Apr 2026 14:32:15 -0400
X-Gm-Features: AVHnY4JFJ8mm53j_SFICrzIE_Vn24DRQWzq1cvV6f8ixJlw6JjbGnFqRBPxKPGs
Message-ID: <CAEjxPJ7jrF2dcOZxR3MA0-184STKTxZQSro1+n=R=K1mR6xRXA@mail.gmail.com>
Subject: Re: [PATCH] selinux: shrink critical section in sel_write_load()
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 12:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Currently sel_write_load() takes the policy mutex earlier than
> necessary. Move the taking of the mutex later and drop it
> as soon as we are done committing the new policy. This avoids
> holding it unnecessarily across the vmalloc() and copy_from_user()
> for the policy data.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

Sorry, this is wrong - please ignore.
v2 coming up.
