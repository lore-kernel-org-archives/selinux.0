Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06115494815
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046828; cv=pass; b=tAHpOheWE7TQOaB15K3eHRl/1zEqEF8xgo/cz9L1eU6P5rj3p4/xe1rDnJPVoHfvlCwwVNM2v2V5aIzOxrrpmasJLrvKb9c+OrvpNl4JiBjp2jb4W9eFoiB36pji9u0ipjLhA82bnRwJSqBhChPdom6WjHCYp4D0+5Sa7OwxRaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046828; c=relaxed/simple;
	bh=7JOXH7PDKwAmmCAzcd7VYj09Rwn+hY8r5ejgWmOm7lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkjv6WySII4H6n+yWkhkkU6ASOggPjPmZXHuGAoxcMjjQoXpqfBj7oqV5gn0ciffdfSjDzqQj/jjiUJUjMJtSvZ6PhKoF4iuxI6ovpc3E8K/u7cehmBzWc2EpFXGnqnppWQR7DHopWJjtRfsHfmAzk9khvexAzm/HWXYMDrbMVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISobDA0u; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISobDA0u"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so980879fac.2
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 13:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786046817; cv=none;
        d=google.com; s=arc-20260327;
        b=VPUxpI0Sq7i55ciAR1OgQ245L4yG5JlLXERmXEp2dEGs50nu30o+Isr3zOh3tJnfKD
         n2pLEQhj1s8O2pkZkfoS4HJbNOMTEnRuVoP0whK7anzX7hwBmpXONVH44G8+mmhS92AT
         5tuu6Ar+guRjvIKBKmZq0bpieOZ4PMbOKgBteyn9q6A28t2m1Q3vETJfQJCG38QSkNSR
         vD08yRFCE9k1aga8cmDD/bCbSpfjkNZq9VVB95Ye4BeGYKKkxX7VcsF/+QFJsyk509dh
         VS9aZKkJQQdG4jtaZVlHvo5x2nKQoh1HiDFD4kH9oFoBl0Z2yP0ZyrhP8QEWfwdHaqvZ
         BdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7JOXH7PDKwAmmCAzcd7VYj09Rwn+hY8r5ejgWmOm7lw=;
        fh=nRnzhT6DP80pF4gsFXYam5FK82Nya5Ydl0jv/aHNY4k=;
        b=bpaR4L6DlVYLbGC7lwyz5IJvRnumzu3Ww491dyigfQL/Mm9lvDWN6RNl/Q+d8JxB8+
         pQ6am2kDFKzRvHmyC9wFVeIXfxEcz7Zbitgh4NiwdBL51Hjn8Ew1BZmlyazF6ONP+os4
         6IQJHAioOz3kJqU+QK3XNVLsJbF5NXyg4VqnspyEWrqPb3nqtKd807x56iAFIHWsmsvt
         RTe2N7jDv70A5EoH5SHhPWbAxNkOBxNmHZ9wF6Ru8BIfPCdHUixC2tuKEUd+yX/fBhGi
         +xw7fVYPKYsoM0RUFwvDBGpeyx4H3UPqIznUCCFpQPDio5YxY9YrKzGTx7chmdpuNdQ+
         2p8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786046817; x=1786651617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7JOXH7PDKwAmmCAzcd7VYj09Rwn+hY8r5ejgWmOm7lw=;
        b=ISobDA0u3KiWO4PiVKamh0ROYNicGC8FMAVlTZGH/6jNvkFL0Rf14FhCcQLLp/w37m
         2eIT4v53vlyOK0Lz4QzGy3WScpsMyDfDCoGCUdMtKIfsCLcHWScJ3YmEMrlGZIlvgpb1
         pMYmjd7huHk6sPBq4IpsDNKv6WOWYGxlq19DaEA4wWY13C8tHPKpIhDbP+3ObrhkEm0M
         A1jiCjv59FjE9ui64tr98iruA3eb2fnnxR+0KJdno7IKoLMoRXGFI4gHEnGZgpVNmAZY
         Xe8zCIddmmm6ikbEwcY9uCwdQltGgQlQeofTwiEvJoEWgWGun8JTza+8e62JyscUDK0V
         v99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786046817; x=1786651617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JOXH7PDKwAmmCAzcd7VYj09Rwn+hY8r5ejgWmOm7lw=;
        b=jpgkUBtF581wyjAkF/icrhGxcxZZzHEEffKjsyzeNRna0Rs+B3umCOI5s0GRS68FC7
         c9SCkcGmBMPd3jLuaYLxBwr0qHelXPUVOxd94CZpu1O3SHjWWibYNC2jschGQkp43zCA
         IJuoID9tsXuByUvl6VvlldkOIJIsvc7tynj78jpZmn2Lhi7tjw8nF6rkPNvt0y7VDzc8
         Fi40P/w1nU1Kqqe0lFEZ6p2uTmEjTBv5xRR/9QyJb3Ull+DWIOBIB3F0jYBLO9zAdnAY
         VW8Is/eTd9iz/XG+3cBwQW40KwgEx8gXHgoUE6XYXzd9hwv5unoTC+7ecLuZAM/uv+TR
         J6TQ==
X-Gm-Message-State: AOJu0YzBGxvSKlnzNda+wf4NLEU83WThUoufO9D20FNIGaSq6lDXR6s3
	XZRTkrxMrx/QcBCC5/nmDS75a9WPRQAOXHlLpMALdwbf5Jrse79Y7PsaSvsJb/AU8rSgZPvVAbE
	vZCFVq9bbSYPh2oWJrABMDwUiNfBtspYuPw==
X-Gm-Gg: AR+sD11cXKkhKAQ7hNH642sLeInh4NNpaQ5EYjTLPTVHrXUHuV3Fv1AdC/se2QStbng
	5mk6+wVGRXc9FevwTQe5wJS7cu6N125ooHCTGObZmSLFgU8cGVuTr52XCS8X3Xq2sfRLs+L8zlF
	NAKTL6NxWKq9q0Dg0VnIdRnaBUNIB1x/DS/L/ZuGeevnZR1ItyQfhxk/fjiCoDN9Pid9imZCUBA
	up+JXNGxLHZ1ifrY1U4QvvmwNVgIhw7sGsXSokIUm2gXyEId/ULnw+lCKxHVlbtJXb42HUQ4NHI
	k3PLvSquNYz4n2/jzWXjmXIIvKBgJAOcO9R1d+Iz9il7
X-Received: by 2002:a05:6870:314:b0:448:908d:27e0 with SMTP id
 586e51a60fabf-4599ecb3ec5mr9004036fac.4.1786046817531; Thu, 06 Aug 2026
 13:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806143044.42884-1-lautrbach@redhat.com>
In-Reply-To: <20260806143044.42884-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 6 Aug 2026 16:06:46 -0400
X-Gm-Features: AUfX_mzw3lgtiQ8YUc6aSLeY-oSTkZ3ojGlfFbiAzqiZ8d8Aef_gsrZdpScH43s
Message-ID: <CAEjxPJ4-sSa-9NA=FokRGM-HQFOzwFwTjPwHLoKJvy_Ky8pkGA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Replace PyString_FromString with
 PyUnicode_FromString for SWIG 4.5.0 compatibility
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, =?UTF-8?B?Sml0a2EgUGxlc27DrWtvdsOh?= <jplesnik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:36=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> SWIG 4.5.0 removed Python 2 C API compatibility macros (PyInt_*,
> PyString_*, SWIG_Python_str_*) from its runtime header pyhead.swg.
> These macros previously mapped deprecated Python 2 C API names to their
> Python 3 equivalents.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/538
> Authored-by: Jitka Plesn=C3=ADkov=C3=A1 <jplesnik@redhat.com>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
