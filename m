Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294D253F30
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792752; cv=none; b=gNvhCwnzfqQEEl6u55hE6x317ioeBpU7Tyfdvn+4IQCyLUiLSmlt6MOW6LK5+Dr61Fxe/irU0dj5Laefkqe82s2TQW5Qf492dyd7GUmXaQmJeB0IiqStt59FFNFp53UfRrr4PzGzFDJf73MNPGbqHOetYV+CGNdW3+hf1S3wjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792752; c=relaxed/simple;
	bh=Qo4zmRNLgu6JxAeRou4PO7CGE0OiFyOb3VDGevusnFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YagZNMto9I4wjiTVo0GRGGNBIXAyPLGMOFz7JVz8hi79NU+yZRU8Y2abtdGYUgYjtBv1hKyZ+qtDAeT0AF24KShJGH8UFw9lurJuJGax8XvzpoKaFSIJNtLvyxzMxSqIAGghF04qHb0k9SCWE9KbW6svxo1PUdo/lTnCpRVjQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RybevWW+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RybevWW+"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fe5e0a80so55923261cf.1
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741792750; x=1742397550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta+2AXG9vGoVAfHuoTqamEWN9uDj8Tn9qcvuYur5Roc=;
        b=RybevWW+1dvIKllMBqJvRsw9d8HMD6qXarhyYR8SYRMP1NTRstOP5D9fjO9IR1+s6e
         9UuLv21RY4Kg3xCevG+V3hQvLeqUfqmXyCV1lR5DggccKZJNBGvo4K6HEOC+3QI3qvY7
         P84EB+gQDTenzcXHPQrDIEM+PbKzD26E2Vnj3UWTCP8g6RFaarxEpFe9hKZeMPmIl2tG
         SHlN1sibRM/hBTAlZ1lhcqHrm6tv00oN87TLT8KSjKKbBMHxLaU4lw5MfLx1zqa6imvO
         eihjNQue1TVUum+o4xtdL1mdYBiAveOXLu0T16O+tL0zHfH+HU4F/AQt3K3VFRkIvlMF
         enpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792750; x=1742397550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ta+2AXG9vGoVAfHuoTqamEWN9uDj8Tn9qcvuYur5Roc=;
        b=B1/rZvWU9LIxGYfJz9AjhALduUu15cBLzGPf1U/ROxWJ4TVtYLP4WSrbxN7I8XJtyZ
         9iBOuRyz1wVWG7JXt5IrIM8IiuVwr2Q2qL8IhjuxEoCJAVoHPryjlTJoUAdULUAaeeLR
         oDQxm/U9/CDL7h95xE+cCdHQd04fDtMiFosokXcvxcpXGaLVuMOYCKmwjs3e+NpV0BYm
         AF0x5UmtWPMlBPVAuSwhiGBHhfoyXySgOQOJdSji/sbQAu1PBmPrjY7TNMsTaaKAczJZ
         QNm3KKQ3lSv1JYx/Dq069DjXTmqAy6UyGV7cuPahszQ5T++dfBoZSspL/fN7OM5qB7aJ
         Drkw==
X-Gm-Message-State: AOJu0YzknLvSFrVJU88Z8UHy0V1V3yE5lUkKGwUrJblXKsSfP4Uy3LtZ
	pIxOiuNZmGJIk5M53TBpun3ZjPw/joUmhEl51synGVGjvo1WwXnj6LQXu3hIeUrgYEzn/1rJDmX
	d/lQ8Y09MpUvVZPAhJZcnVFdHUu4=
X-Gm-Gg: ASbGnctR3SZXiLQ/wmDF0cieC7zIuvKJBKwbS8Pme4UT8DeAt9w2MbbVW3qG2SJ7W3L
	makqrQV7T5VFnO+Z0A3lOi1wwJYMkWQklXM8v+yP3YiMu77cajQZXgyvoxmErUYG54b2kPhKONO
	OOx+gQcOFNBZ2j7yn2IjZV0Nk=
X-Google-Smtp-Source: AGHT+IEoPvNbW0guIh7Yeqh9acvOxhbluTFwBTlz0cXKF51jCvqXsm0FgV2Kai9M/Sp9qr7g1I/KpRal9Q9DUnK1LlQ=
X-Received: by 2002:ac8:57d0:0:b0:476:8028:71ce with SMTP id
 d75a77b69052e-4768028a24dmr211117491cf.3.1741792749807; Wed, 12 Mar 2025
 08:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131175556.21836-1-cgoettsche@seltendoof.de> <20250131175556.21836-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250131175556.21836-4-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Mar 2025 11:18:58 -0400
X-Gm-Features: AQ5f1JqAbtt5FOIBSOGGLcIBcfSdVMYxyCiZLkJF60hI9CTbZcyg3U3aYLU9bK0
Message-ID: <CAP+JOzSWHhqM_dahL9AZm=GGy0UALr+psZrzyJAnh-FY8p3yEw@mail.gmail.com>
Subject: Re: [PATCH 4/4] libselinux: limit fcontext regex path length
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 1:03=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Limit the length of regular expression paths in fcontext source
> definitions to reduce the worst case regex compilation time for abnormal
> inputs.
>
> Reported-by: oss-fuzz (issue 393203212)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label_file.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index ad7699e6..7a9834a0 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -434,6 +434,12 @@ static inline int compile_regex(struct regex_spec *s=
pec, char *errbuf, size_t er
>         reg_buf =3D spec->regex_str;
>         /* Anchor the regular expression. */
>         len =3D strlen(reg_buf);
> +       if (len >=3D 4096) {

I am assuming that 4096 was chosen as a reasonably larger number and
not because there is some other constraint.
I would just like to see a comment explaining that.

Thanks,
Jim


> +               __pthread_mutex_unlock(&spec->regex_lock);
> +               snprintf(errbuf, errbuf_size, "regex of length %zu too lo=
ng", len);
> +               errno =3D EINVAL;
> +               return -1;
> +       }
>         cp =3D anchored_regex =3D malloc(len + 3);
>         if (!anchored_regex) {
>                 __pthread_mutex_unlock(&spec->regex_lock);
> --
> 2.45.2
>
>
