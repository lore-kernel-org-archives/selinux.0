Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF4245C6E0
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161990; cv=pass; b=EjQGQI5n0WsHior4AdMBiYSDuKAl1Ij1P8j9sKN+mijmBZ06BmuP+ndTqeepQpscUa7zcoerjOcW+NtYE1Hf0l8GLI068eGIPRgPQg0CWlcp9dUsKS56Qc/a5Ag2hg2ZtYXM1YGkicwM4tcDJJHrOiRaGka9Il8XSLrTW8QKrAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161990; c=relaxed/simple;
	bh=iJ+AwkfmXsadjP8odHEt508m4Va68RYKbSSzPF6XLHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auZOZIsQJEXXiWVe4e5KLQ4jUISBO0cb1WC+6E+QZE4DxLYSWkAGGDJFmbZ63fkoJ/9FgmSHchA1yGPTGG+hUcuYZjFPtps9jVv/cFIpBsA6SuNeI9V1Iu0GBQf7F74nS+5Tm36CCWU90ziW/Gl2d1LFX52V93UJZ5cClDqnvZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d58wBrUY; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d58wBrUY"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab432273c5so59592967b3.3
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 07:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161987; cv=none;
        d=google.com; s=arc-20260327;
        b=I+hWmsnZzmKVyUxxrcmJlp7yPBMv/sXL6VhjebHeQptgQBkHRJv3IuCkZWpsKz4cJ2
         ONgEYPkt2nRdJm90Rk9IVVCaD1RZUyY1JONRVtFMqwBruEVIzlgSUuJ4RSk1BIJUW5jU
         VVeGSKMvStl9dxDXYejt8Jjez5zvUPIEhlESn+TP5FlW29zlBeI6wuEbzNKxMi9M6SpD
         a1nPqgBeJsKbr7Oj6PtxHE883OmYdeq9FZB+zgMA+f6YzuJr0SLC7FKwYdBBe+AFSn7c
         bjnWIUjmQOfSikm2cwwjP+ak6rgqmGZTITMiYJs10LzpqvVO3CXHcQN9FrbZK4xHVIUD
         ceeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJ+AwkfmXsadjP8odHEt508m4Va68RYKbSSzPF6XLHY=;
        fh=gBydrNMvjriJbd9HrIy1Xz3jsVrETImIXW7v+LTQWN8=;
        b=aC5m2WLaTTtRgm5VrOOsMEVr9n1wMNX+18JF3kchOoM4Wj56L0szflbFI4BzQw81tH
         1z2HVN1smDg5ybdbDlCo03Ph8e4y79GCcGiF7c+VhlhTAqtnc8xHRdDRuwfRk5wNKsBB
         sFYm+BtZLuujqiok8La9r3IXVt6EnKi80xZ7RzZUVxhYPqVyEoa6PoUdvL3dtzABGt12
         qVtzlaCID6vu8mLgqBpg8Re9BzPiXe1XEK9+4UuqpSXihXNBnaZAoXivWJMC+9oiw7qR
         pMeINif/SiSOofyv85merq1B1xHkbm4SNe9tVHcwxjUQH3oP30X7WoGF2pd2uJ/fFvYy
         r2wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161987; x=1792766787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iJ+AwkfmXsadjP8odHEt508m4Va68RYKbSSzPF6XLHY=;
        b=d58wBrUYpq+5q4Wr8gHpRLv57H5MKeTA7VEWmjwvWaBlrValL0TCU4fz1tAP7NVpXF
         XVy7KTw7PRM32chyP2QY0aNd6yxnWi4/urHaTd2zhOCsuDNbIM4E75vhEXteN3Pg4MZ4
         fNAbg98mn24DB/MVy0eTnp5qjhxf2K/zgAU4lwt5hEc49MPuGsEtgOsxjJIohFCWgO8Z
         Zg0sIlP0zRBVebQMfghEo2N6JiF/TVFNjNTr2f2CoTzeRF1cH9yvQ4VnFrjm7n+pK2eb
         mPkyCFgmjIJkRtTRYR6W/cvIZjTkvDWGb8l1inX2XsRC5q+u3dENjJyv+dI1CkZw6pT2
         q3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161987; x=1792766787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iJ+AwkfmXsadjP8odHEt508m4Va68RYKbSSzPF6XLHY=;
        b=BOMQW9DbzaSX6DySCV0yIVxD6rrHv1ML/r9C+KRjT5myv1OIRBY6m+wnj2IOT2/kjG
         okunUqqKzaTfNqL+TiO30fWRDBf/626Qwyc+D52HESJwm8PQDkjT8QwhBQtK4uiX5U02
         k+yDcL6IRyWkqbOmongxrCVuuIx3myD9UIEslBQTAc84f3jKVLuxQ7raBRCiidbobdyX
         ak3Ckqn88hfDpsjFh6C7s20VpRyWYA6EurPXs+PEkkFmkx6PQClIyVHWVp2tJyU1lbhQ
         Iuu8kyHU4cIRBoigK+50m7IB50Wnl4qkQ0x3b4WQ2v/MEkPM+GcBqcZEjSQtZ6ApTo15
         XY7Q==
X-Gm-Message-State: AFq9FYI02FnkmriF0vU2zW4/BDDzFmbf9dPcv8YMg/zsMzGcZmXdK+3C
	WG3qAIkbuFmYQg18Mcq7o+n5mizSoT/n0Gz+dCOW2otejwfO6x6qJ9LHGqPU1MyySXW/ZBAcRof
	yOGztt8SJJSBiWaISeE6uFT63TZUi+uktpeefvpA=
X-Gm-Gg: AYBFou3IYkPMADFbjVdd6xHrmYVujwp3a+jJT0op4MpcNaYJTW6RTWCW/xmdHW+rJmT
	Se9TxwdzvS3p6sfxP14b/9aQ9nYVTxBaVSKE8+8DO6oPrOjDP+66ZMkq/KqitUZ9e9qFDGaXMK7
	CTUBYUS9DEApOq4qeSD9zzvDKkXL4IIl1PuwWozhd2g/QOHtUwxARZe14Z/G/Bk6nzpbi0ePwcc
	N1raEXmy9y8BUVJ98BIYO4DqrVXVpCGf1Gq3Vrx6qxff/D7sZT6UE3Qc5HIUvM59jF8cKYQWAbJ
	En88lzeQNzYMOEJ4hGUA+eGQwFo3KhJNWxye1W8gRxELXgzdZETqABkf
X-Received: by 2002:a05:690e:4089:b0:679:c86f:cf7b with SMTP id
 956f58d0204a3-679c86fd2c5mr74645d50.72.1792161986580; Fri, 16 Oct 2026
 07:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015014457.877322-1-tmz@pobox.com> <20261015151422.1057210-4-tmz@pobox.com>
In-Reply-To: <20261015151422.1057210-4-tmz@pobox.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 10:46:15 -0400
X-Gm-Features: AclHuK9wZKQEp6cquIBiD4C8GDP1VOFVtKEN8iGc47WmmYPjYdXMyrec2UuyTe4
Message-ID: <CAEjxPJ7=VJ966Ln2x=stHr9sWn8K7foVS8T1QS2j9FrhmSFnUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libselinux: add -V option to sefcontext_compile.8
To: Todd Zullinger <tmz@pobox.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 11:53=E2=80=AFAM Todd Zullinger <tmz@pobox.com> wro=
te:
>
> The -V option was added in 92306daf (libselinux: rework selabel_file(5)
> database, 2024-11-05), but the man page was not updated accordingly.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
