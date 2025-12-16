Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC928D82A
	for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914832; cv=none; b=cj/QdbjhD7tpgUwsAeYwGZLFXEHvxBbW7Owr9kCdeS1cYj17s+PfhTYrjc2VrjQPabUr5qF7+qXcNPN0qEVG4dqhhVu79y8M95J6wAqvrv5Fu43H92cmq0huq4q1uX4dPc2GdvorYexhwZqRyBadVy2MoQwwghUHCW0oJAxSsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914832; c=relaxed/simple;
	bh=wW7zZiXBgWt6ulNXx2COXzeY94J/nWHPjBd7YYgyu00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fdktGo732/NGY0SCCIpgsVaDAdXaK5rJmVyhqX/WCkObmb/c+1dHrzHCCljJSp9/AUYr6Zum60KwB3iEz5b/w2NX/lHmcln1Hl5Cr1RJumFd394CNWtzfx39wwWNju1rxA1gcspKF5VKOejEEnPPdr6jFZAsqxZdNHngNYmSwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HizuWp5c; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HizuWp5c"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37e6dd536b0so47366111fa.2
        for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 11:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765914828; x=1766519628; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHJzyK22VLDZNbT3Rfhu0mEXM3BSf2i2Q25F5FkL/Hw=;
        b=HizuWp5ckwj5PTUZ8CTbkGF1AVZs+Rdjzw9rJ28gwcwEGGS9WnnTCf8IFCb0BF2dHT
         7/wus/nA6/F113WhAwQTEhpzHX0WL8OD5jCnGo2iDrNa8gicTC/XX12dcCOTyePNL2Qt
         ez/tsX/OYRQnRc1mqNmiAL0rbmsWxsDVBgzqk1vHNUKYe2x1+WviD/eAUFSAk70u2zov
         1VTFvX42i2nT8uxfBKt6Fjnc7ydbArD13BGRXE80Wzm9KSEbWKNo0AuAybBRgVNN71tC
         hLTgHv7JSKkyp3hfyJKyiH1AN5s3/tHsJj3mJh5rwP69UDdKdppiVfwlPrqqNBOag/Yi
         c46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914828; x=1766519628;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHJzyK22VLDZNbT3Rfhu0mEXM3BSf2i2Q25F5FkL/Hw=;
        b=rIKz+CBTMOWtjRpT8bO357ph0tV3UG9KO3o7f0NvFjKLJf3lNzb1nn61cOh+pmq//M
         QSdYKJg9ZcFk0jpCca2hxTkGMACurjb9M7aNGl0rEGQnMRWYK0igWPvcTkuMkwh0mYI3
         pdvzSRLnLHX7/yPQs/STzBj0yIpneelq6z8gUMxvKeLzpQJvFhgFE6ZDnwhjkPAm+pRd
         vKsbOlt4qH+PvNXRoIDmKWPoqFZkMfOrnn81pWx4lMud8AJPvUf1ZsAXvsC7230OxLPJ
         uomUabH1jSLQVkgsy4zDquJ2ZIOqe4LMViLJ8+SwOAyVfMK0AMW3mel0gqwmq2AeBt+x
         mKyA==
X-Gm-Message-State: AOJu0Yxy8mb0l/VCphdS83bUfcSZIpkI5/O+mcGhVbv/HHUS1YhMcqSe
	yVtsyer7K3Zt2yCCT0OHypCtW5T2rnOP4A+XpiRP1wDaa5exM/QPTnlHeyYTFuRYJLJtrKrcrWe
	gs3lMr9LrN9aZanHDf9RAqkonNlwE4VZyZw==
X-Gm-Gg: AY/fxX7gFoTmVl5iUp1RWok+j1r4eQ+1IAb9mkwUT5zJmo9aKJd1gdt8Rfgy1F3YoLb
	ceODLm1ZQhn8fDlZvpu5QKpFPQYON3JCe3boDmjl3aTCanASSIE71sjz1aZp/egbTNF1HfzYr3i
	ftUobpDsDuJl5Qbtf5EItn30VHNL9yBZKaPFH45c0hPWQeZ0ywD/RkKWhpISTKWhGAV6mrmih8Z
	n33sA5tdrhx9RD3QuBJMrH2jhTbO84et+r3sSpzCuN0IMN5lYALfiY/sTZkJE7ySsNP
X-Google-Smtp-Source: AGHT+IElwOVwEWqhQ74e2elFUwg/YLvO4UL99cL+9ScV3TmIVZuHhV5u9x9CB5ninh0X4rekSg9YRG+7OW7jiXzbXuM=
X-Received: by 2002:a05:651c:1502:b0:37d:1911:7a45 with SMTP id
 38308e7fff4ca-37fd08d0905mr46337831fa.42.1765914828292; Tue, 16 Dec 2025
 11:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203163218.54939-1-jwcart2@gmail.com>
In-Reply-To: <20251203163218.54939-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 16 Dec 2025 14:53:37 -0500
X-Gm-Features: AQt7F2roIKFNOHtnSesXLwQNGZ9vvwAJlIxGX6f-Lmhf4dH8QYZDSvYr4omwZh4
Message-ID: <CAP+JOzT2580LFu60mdNw+vebAN-DD0VGX4R4qqbRiVtk-+SoPg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Fix bugs related to policy declarations
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:32=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> In testing an upcoming patch to allow type attributes to be associated
> with other type attributes and expanding them before creating the kernel
> policy, I came across a bug in how type attributes were handled in role-
> type statements. This caused me to take a closer look at how declarations
> and the things associated to them were being handled.
>
> With these patches, I feel that the code in link.c and expand.c is cleare=
r
> and more robust.
>
> James Carter (6):
>   Fix problem with bounds statements in optional blocks
>   Provide a better error message for implicit role and user bounds
>   Fix an error in the policyd validation of user datums
>   libsepol: Fix processing of levels for user rule in an optional block
>   libsepol: Fix problem with handling type attributes in role-types rule
>   libsepol: Expand role attributes when expanding instead of when
>     linking
>
>  checkpolicy/module_compiler.c    |  34 +--
>  checkpolicy/policy_define.c      |  11 +-
>  libsepol/src/expand.c            | 396 +++++++++++++++++++------------
>  libsepol/src/link.c              | 153 ++----------
>  libsepol/src/module_to_cil.c     |  23 +-
>  libsepol/src/policydb_validate.c |   5 +
>  6 files changed, 296 insertions(+), 326 deletions(-)
>
> --
> 2.50.0
>

This series has been merged.
Jim
