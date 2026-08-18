Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344222D4E9
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083559; cv=pass; b=Ylw7wpWfdEoN1dZlnTZr5nS2opG3i8kwgS+iguCcmK29zMwf3WcHQ5rrkRu2WDKk9mR+7Hj9YSeYaCdgMeG3O9jHVIYQR6pnuRHh6QJcVgzId1qnmCgL+cugm/Yim23j+KUzv65XBvU7z+6TGsM9Kd3cSfBn7IuM4rkxFQZLv2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083559; c=relaxed/simple;
	bh=3T6yGZHjvDHMWMAcOtI01VaqSiYdy/ZFaBXY/A/McDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdhPM3Bg4iAEmoz6MpUqQeH5KDuXOfUMyuuHIKELrz+RL+UXFKQB8qi+kiWHJcYPQoOBRUmnyOmQUcmY3L8t+lDhQw69rOWBXWVGkuqNmPvJEJp+1Zsmr1F3SMmcTz9OPerX7xIA9lW1wK5ppcK0Pmb7OrzBHVAGboRzjgtN5Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUK9nsgE; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUK9nsgE"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b051516aaaso240942eaf.2
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 13:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787083556; cv=none;
        d=google.com; s=arc-20260327;
        b=p40dXV/4KfR3QOVRrFfQX8RgD1zSl6hF3J4zOn1MKEzW02PDC2Nyo6a6y1v/z7iMRY
         2COe2C9ubzvc51G+v1NDwsBcvglQAX78h68MSkQFdUZmZEJBkQd8k69ARE6pKySy8yHF
         4T9ePgKhTkWoKRddGXnt/gk59KjNc++CIxW1guqkdEuPPsSF8KeW+0O6tAT0nTnUcoC6
         W/0suS4WnRK5Dpq6uQQCEudBykf1MvB7nfbviLgQbs8e/lZL6KaVyQs+z7sl1fWmeIqQ
         6kkEmH6CSqAdmmGMQbC0ubuZT58DJ45+cXz6QttuM3GUczattbrfdGxr7dB462//yhtC
         1lNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZJGoWe1MAIoj0NLB0aX8YcY+OD0aIrWij4iQW84smW0=;
        fh=Vdc608U6fmQnkK4Pj/GsEOPoO5XtlZs1Z9K2hPCnM4c=;
        b=DaRiY8yildjlxxAV5gJTGSzWJ8IR5EJq3LoUxw5ag59Y0pjToRKlQzU7oPFT2j58AN
         njdmi2ZUTuXSB7PdHSgyzpUuv5ROwxIO0EgncnBTXytJfdijQv6BYjOqU3eS+g+4vFeU
         LHIjA0ZBwruNBlF2Cf+ovbeCpN6QXPMMGMe3dKwwBp5bRzAA7MKMY3sX9ghuXEH4hi2k
         8fDCyWMaIPFN6A8ngbJ2F4QIMGBq86ip625/H2MZ3w5M9hKnwYf+m71W4et70W30JAq7
         Ltj5TC6LsaCWt16o/5HFIaSP0NyxyvM3PKVcQFF80POBbreM5sAdRUWP5puEQuMeA6zP
         /YSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787083556; x=1787688356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZJGoWe1MAIoj0NLB0aX8YcY+OD0aIrWij4iQW84smW0=;
        b=BUK9nsgEYpxYqkov+np1yMxI/nE6hYrwOVYANLGQA5b+QZFjXyXVp2Bnj4vnMKGw9B
         HvdkyCOrq7Wl59YcCfupRwdU2FfS+yvM0mNssnovZ9v1dIRTFAQojw8A3lK9Ma744LTh
         bUPEXJ8g+XqIEFI2KM1f/8gdNNBVVlaDo0uNxGaT5SfQ6VS/wjYU1MPCK0AKSlhaOXpU
         b0fXHZthZtT/y7bSflmZ5QicnNgE1OuTzS8aHVC7ueM5cmTnM0OGxAPd+dssLTK0hgP6
         y3zM8RiOW7QHlnw1f266VJD5vGe8HzTfVomKtQNgue/k+5uSZ5NNThHoZY6U8c5YLD+E
         D2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787083556; x=1787688356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZJGoWe1MAIoj0NLB0aX8YcY+OD0aIrWij4iQW84smW0=;
        b=CRDgjj1eO6r7mEns9kBxdhPcUN4LZ/LCZWKS4jd6hlozmJ0nvE2gnOUVyrWhpVIpmx
         z82FNwswZzZjG71Bqy0IBCMmD85rS8i+gY5M6L0lU6/eGYxP71jPLtqQkmXNq2NDQCnF
         25rL4CPPgEt0QeFTWnHmiCkN4fSZxlKkhrAZUKbB2WwZx88vbDG/67333f8rxPCzPwFA
         ipZtnfhAK74czodZrRNtnn2LeVHJsxtaajhrQYvLWGH6ROxLGhQUkIkgH99tWCZSnBId
         vMHkcm1Vz/nlZlpMKi/dBMakrn04M7RAWdyzaW+MnwfazJJXZhKc31amfu8PpC9Po2a3
         857Q==
X-Gm-Message-State: AOJu0YzKxgiu3jowoxSppSe0/7RkAFcYCSzTM0b50K5UB1dw4e4Ni75Y
	Piyc/m1u08RrXXIsYPkxOFV/ZZLiHoVODIi96UqL/7NRxe33DrMxGrKiTPW2ErbBUnkExA0Lh6h
	OHXZ/PtT7D7rixxvkatTUsCmNfMY9TlQ=
X-Gm-Gg: AR+sD10wcuHtgw/fWnJgGXNeyEUqIGADDwHCeXUbJX9yhmDCqUHT959J/UXq2i5e1f8
	AZ2btevrI9LZydPx4PiSjIOyNY4M8XChDQGhrixLuDR6rtx7CZsooNE33zoA/TLjsN6lNUzWhnO
	ghUDfuuw2puUBHDabEff2S3aerH5OujQ536YpqLn2ionueKOHMzBnhGgwQBa9yEDQF0paSyZguW
	zBYr0aaAXBZhZNFXhh1uYaAySWFUxJ829xvd3quJrP1tLTDhVnMsdwNNb9vOHA/jFY1mr6NAPls
	Kue+9wPLD7uHzQXhmexbZsWkVkulMvApXUVvOf3Uu+7rLGUGHQELLWY=
X-Received: by 2002:a4a:e90b:0:b0:6b1:2d0e:ca1d with SMTP id
 006d021491bc7-6b13abb3cdcmr102229eaf.4.1787083556437; Tue, 18 Aug 2026
 13:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818192340.119297-1-boeroboy@gmail.com> <20260818192340.119297-3-boeroboy@gmail.com>
In-Reply-To: <20260818192340.119297-3-boeroboy@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Aug 2026 16:05:45 -0400
X-Gm-Features: AcwNN1XlPNME8bnizX1UmQoB0rqnICBlaNShZWKup4up4tOzD-wtRUPqMgfmRZ8
Message-ID: <CAEjxPJ7HWW3m4Gg5_32930-_XZtgUJXDGQNEvCvT9hbqfNDAEg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] policycoreutils/setfiles: use all CPU cores by default
To: jboero <boeroboy@gmail.com>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:24=E2=80=AFPM jboero <boeroboy@gmail.com> wrote:
>
> From: Johnny Boero <boeroboy@gmail.com>
>
> setfiles(8) and restorecon(8) have supported parallel relabeling via -T
> since commit 93902fc8b0b0 ("setfiles/restorecon: support parallel
> relabeling"), but default to a single thread, so anything that does not
> pass -T explicitly relabels on one core.
>
> That is most callers.  RPM scriptlets, fixfiles(8) and hand-run
> restorecon invocations all use the default, and on a machine with a high
> core count the result is a long, almost entirely idle relabel: a package
> upgrade on an 88 core system spent hours in restorecon with 87 cores
> doing nothing.
>
> Default nthreads to 0, i.e. one thread per available CPU core.  The
> relabeling is already serialized where it needs to be, and -T 1 remains
> available for callers that want the previous behaviour.
>
> Relabeling /usr/share (~588k files, dry run) on an 88 core system:
>
>   -T 1   20.43s
>   -T 0   15.78s
>
> Link: https://github.com/SELinuxProject/selinux/issues/489
> Signed-off-by: Johnny Boero <boeroboy@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
