Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C29227E83
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502418; cv=pass; b=KalI8FXWfQTBp6cjpwoew635QRq7C+UfvXYVBgPFzh4is/JG9yhMeodNhDFnl7erAZSsig0uS3MiGU+3ED+25qVEKsu0J+h7Qs1cMam0SSc7bD03ih6xHIKhbtw+n4f1B+yheCLGomEsHZBl/YPDfnpHWYUXbteOYWqQKJWDulA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502418; c=relaxed/simple;
	bh=RkVexlEY3wwSIZVNy1cAaXU26sun2mjnTv93pt9q/7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XvXQgPJlwE2S/GKHq6ySLsNd98XhytlVZOyUDlruj/ZyYpNfbX1K/HhOnkIaFhQeAdI4UISeiknyplIkEOkkp3ccmrfz1/sOC5vpNKSRtDDdTV05C7+/zXv4WLSeL3x1+36mVz1nmWtgJtn8fKm0Ot+Zk3PRfRbuPdBzgTtc95U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LcLhYqlh; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LcLhYqlh"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c1e4a9033abso691570a12.3
        for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 10:40:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768502415; cv=none;
        d=google.com; s=arc-20240605;
        b=F3jwB+S+bvLOBnMlgnp7yhDAUiAS6DVJFCyL8kiFWySUbglXeySV3ZKlzd0i7YhKgA
         r4QgNGof9Ncd8xPom8Q5Mi1mepna92zX4BQATX827onhxUWdnr1sKvqFEizclieMy9LH
         l9LHZ0Mf7mLVng7hSrKfBCvC8YFEoyp/49H8WwYWuXwhgp4A3rOfIro3oPf0Pcv030B1
         UMHQyHuwgF4wvou8OoEMUQm0kbZqWFAlcJA65uWX4MrKjGov5QoayaWlfrV5Iq5V/KOu
         wufTff/QbVzyibGf2ATmOUiLtwdM6kNrYMSav2obGAyqm7wnjZOtYa10yO6rVWxiZ+1l
         9tLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iUhogEggxj0h8MxbH/BDijx4CSmTehySUT6vxVOshto=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=bpvGbisEgrCEWc/s0ZgKBInFbFQXwOkrTncnZWJpMv+vVEKr3kffasjrDHrSyuwfwY
         r15kth0cRAY8ffJfADQ2R4WuQgw1FRjv+JFRC+4eVh0Y5vKsWy50YtcOzdTu/bKlndts
         QqyMsPjUTqwPEmmT6CxzMmcy1Uy3JU5IX0DebosCxFwyJb38aUr0bsHNh396B5YGh0VE
         yO3kcRLrCG0k9jHX5NwR11d7Q5bW8TdkM5HssKQpNwDQu0ibJQuNyIGhQzaOnF2XD2Ve
         ulpYxGT8T4AaUBG7IN2geGc5/GaG45g72da//ctojIXrB6E3Vx55PMGlzD6EB0ZzAKPh
         XVqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768502415; x=1769107215; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUhogEggxj0h8MxbH/BDijx4CSmTehySUT6vxVOshto=;
        b=LcLhYqlhukbs1pUyuol4xm/Bzpp9WjIHrgzcL+S27fwi/fvRSmSlZCIcXeNd4qGN9F
         Pnf49Rhy5E5TSWTHwZ18vWifQcBhU6vwElcq9WkbqsAuA1NsIsz38M5ctpY1LV+4Lzvu
         7Udn8INPa2y/5GspB3EDLzFJhGXlUC09dHszQZtnLlcrWnfL5kSy/afa7gNXaq88sNQP
         49w4mkXtAeVQeCoRHP1ZKVRlFhSHBaC+GXrGGFi2YoVjUb93VthslxXWk5QySrC6Ll33
         L+uyMb6p9ep44jey/ArJ54ss6NhAWjfQ2xa3ULM6Ibr8sUh58HqwNDsqFYbDzpF355Cl
         1hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502415; x=1769107215;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUhogEggxj0h8MxbH/BDijx4CSmTehySUT6vxVOshto=;
        b=B16XeXLYW3DjsmQ240fAzQ2l8Uv/y13mr1sQWwjqG7xrPDeJ9h6IixGd9OuX7btWwb
         Sdw05FIPt5AGU1FCoTHJmvHiq6G1MS7/3mZndpmtAWz/crCLr8PtKNOhv3cM0iepj1An
         Nb438kthDR6cY/69B8OuivGlnHju0Y3ENnO/X/0e9RiUW98ykZT7vB2fyh9F7P7W/ski
         /fzqEXepjbVaExmKtuTQbsZfiw5o4scwtzCbBW8IcaKUVetQArCA5kWSs7ank6FHDjMf
         xcTe6ZKpy01x0IGxn/w8DMcc2ddO1rFVKj7sgcHvkz6KCy5McRkF5tytF9fAxgmKLVws
         /2sg==
X-Gm-Message-State: AOJu0YzUwl4/9HhPua8kcPyBZcsROAZAg7dhmve5b9gypx3VV7iDiacD
	BZek24qwR9Ntklxg80EMgbUTDFTS3EDxhfX8cFSIfdjksDrJ5PwDupmzOkHmGiEE6uy1hYr0jtN
	ZnqeTeJyKycRa7UqRU6kTtQRHPJtCoEzsoMkH9t9XD21svnsLy04=
X-Gm-Gg: AY/fxX5R+ymJpS+K1hLiP6Pi6wk8v3iRyl4Syz3wgMnS7+RiyaXB9tJ95HJ5CV/HDee
	OvAgbaMgZ7E3vBPPl/eGdYA52JGA9ZX+V6Xl8Zax+px5GWm1CfQotKwZ7lU0ONJS7gK26TuKQQd
	R/qM4tan/unHt9/8OQx3Mi9P1VnN7hCZk+iTWHbsiuWLRFTYAOThPH84dk+eMPBOJTJ2ki3x1GH
	6iAaYtakO3kdgijl70aEKqFSBPWng+7B3sJtiRg2JoQvU2FytjsHE9cEJNhA+bsMPtYqis=
X-Received: by 2002:a05:6a20:7d8b:b0:352:4411:6785 with SMTP id
 adf61e73a8af0-38dfe76e2e8mr693066637.44.1768502414982; Thu, 15 Jan 2026
 10:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114212713.296107-2-paul@paul-moore.com>
In-Reply-To: <20260114212713.296107-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 13:40:03 -0500
X-Gm-Features: AZwV_QipakX7MnY38EnH-qfb3bKfZZ0PspTzOty3JyjHEK9u2hgfDkLN8bRzEbg
Message-ID: <CAHC9VhQOqSe44DL0BhxbdfxcwA2kZsLzVYVTXm-BDxbmTCWJpQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: drop the BUG() in cred_has_capability()
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 4:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> With the compile time check located immediately above the
> cred_has_capability() function ensuring that we will notice if the
> capability set grows beyond 63 capabilities, we can safely remove
> the BUG() call from the cred_has_capability().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into selinux/dev.

--=20
paul-moore.com
