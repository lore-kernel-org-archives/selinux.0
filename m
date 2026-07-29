Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB074314BD
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328656; cv=pass; b=RN+5MYfqzePSLMCu0MVL8/Y7C7451kV0qT55UGg4l9r9Z4oT+MEpS85bPhl1UTkwWsjpEjw3gKtnrpoXkoTVPgqgHYqoqCQEv3jx1f2Jwq4TEZ+vx4/5H6QAqJIHtcgQXLIj42EJuqgNvHtjoHMDo6KFpa+9dnw6enPZr54a3lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328656; c=relaxed/simple;
	bh=w1nzDO0gcrm6XuA4B3lnDXlhwS9n+E3ZIn6uZxeCJk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjs7NR0gSN0glB+My11Cam71vNFgElOM5XqJnmVJzV6cckOwMXSQxYwNUTPrq20KPLOaPiJrVRE4vxnf2l3I4S6DqmHockllL5P0HuwC1ioGLWNilIjXlawjruXNlg+jDuBCylWqguMXUaYoNeEYNHGVbLKHOgcDLL4rcuzwtro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT48DAud; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT48DAud"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aca539de11so333761eaf.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785328643; cv=none;
        d=google.com; s=arc-20260327;
        b=DhoZFByB1GNmUwio+ZMZX5EYvoH0NhVdXm/UkmI8MWVrzQCUmMCS6wuDWQ0OAmFVzo
         yqWLqBnUFF6x1CrbNaXwqPLFB34gWnzW2lHs25ZRk5/J16YMauXEvk/JzWhRbhLe6SKr
         4TES8LK0sX9uzkkO+xrbwVixNl12a1BfsawMOKqvYfg7Jpt9We0jvE4uK53winM8UnI9
         kkE16vtKggMYHkpNc+ZAd4phcvy4cNIiYGu1jiL9aXTQutp/OG7JdgtuBmO+XYJ68bHh
         RS9W9mBh6AY9StrC2xXMFOCm+M6fWyuQYjrkMGDbEFIT2LIWi9hrcSVjPRi+1c9Tvqhk
         p8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gL2+pNIuKvwsR2MeEYPR0866Hd2FoTouu57sBxpbXnQ=;
        fh=J2aejDNMt8rqF1JAirW1WlPggzDaZeZAAAG5y/9rBOA=;
        b=ZKOS1bNRyKlczvIJnJ8u37vWtYeODsSYn+rfz/wJXEpwoX/dCKkJjOknb/NTlUi8+Z
         sqbAys7as8Uc889VYUraEBOn8Jq1dWcvfcgs/m5dHoN5f9OZHTvlb11wdJkQkccC3S2N
         mzv9jhl3oh7aPg60d9EbHj/q4KHAdu+5Yk7uGFp86cO6SOswW1z4jKrOxoPk3CIJcCU5
         WXKD5uuOt6pFnQX6LrCS2MqkyvsChB9zRkjxbVtX6P+i0qcAjU9LxFm8Z+wSzcGNoa1f
         ZTvjm8u9r9eRAsk5W6hsT7ooo6VQIMiQn+Ybt+z8Hs0DTPIkSGLCzRFMLGtEu7q00Bv/
         Xgqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785328643; x=1785933443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gL2+pNIuKvwsR2MeEYPR0866Hd2FoTouu57sBxpbXnQ=;
        b=VT48DAudwZBjI8aq2pX1ZF2J/tp1WgfQG4heyfD9LR70aK5bV4D/GXvQg3Zd529+iT
         UisVEDUspAaorY76wKsX1MSmDXLnBHTML+i8OUYSb2vkF5zlt654q61+6+eD+I9GAByI
         QjoN8ZWuqgADY9N3zjdus9T1T6LtW32vyQ64IIghjKGdDOZfsACbtcegFFFrefezvW2n
         NXW6Oqwz++m2SR0HbyhuS9zQIOAD0Wrbw8IQy0h5ak0CA3/MfOLiEsoLlO9DroaW+f4T
         wIvuht2nrlm4OHcjgFJ0W2DA4L34VEEFJiuiBO7RzHIwiIqz2lZ7QT/+eyPg17HinbTt
         Rprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328643; x=1785933443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gL2+pNIuKvwsR2MeEYPR0866Hd2FoTouu57sBxpbXnQ=;
        b=K2+RPQs2+P3KyoayJDwFlSv7pW7lBHs+FfjUXa2ote7T1vzLXNAlX5gICU8g2JmTIM
         Gjphc7TxdvqrQ+V3qFVRY5DS9L07+UUNYgeLKpPN+zSS/qg6m+6/TP8jxGDtpPAGdHyA
         9ZEosyR00kG1Dn+DmOrvTpOJd8Jnv3+4neIRsEYDp4UW9skXdJMHDuhwNZQyLc1/uRX5
         lzCMUOKKFsl9n32hFUH1WAks+vp3KPW3UEokHIOBpo6Dt5NOZcVvC7t2IooB4ISwumRZ
         zXnfRgTQeFpFYpN6EbjbWhA7eaKoWdaoFCQNmbNTdtm0nbkxnLEL22SpvORSOEoVUllz
         pAwQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8fFzD2gTRVAEgMtAHDZq/88K61MBqhl1pfXBW3IOBhbfX4TvR/fpv3lw8SEMHPVqjzt38JNFg@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRLX4KxvrlT2imuWOj3SS3EWdD4nGzzuI0Ez1/mk+q1UzS+io
	ZaFyPuhRRflmaSEElCp0uyBjLGEpzoFbpHIfJ9gfDx0be6/yIG8K2hw2OwtHLwH2/+tVoSgsY0V
	V7PsjBAYFx54Ta0cpv8QDKYWsc4kJj/t+6A==
X-Gm-Gg: AR+sD12KCjyAYup9pVHxzwZaY0ANmV5IyVW7QE1HuAb/SglSoNQ9/o3UkcA2r+sxeTY
	yvZF5cRy4SZitSI3zQ/xqC9Nj7wZjvxYcGEJEciq0E/ZWuWJ9N2bcXAxCQJBu3h1NQ/C2n15nnJ
	+3vI74J2KDaleepE5XQy2tfQqbtPY3bCD0yDjin9/nDVimdBraYBYs8G/sjbfnpf8LiJ18iURx3
	EQoGZCdSjdhQR9HtlxpSrxWTORObUjmqS7uftEExsq210X7MyxsB71E8sEti9ETzulw2j0QOEkW
	WXLSnSkpaTYPMETsWsQEoRDQOnp0xnm5b8+QFRRgGHOD
X-Received: by 2002:a05:6820:4b05:b0:6aa:ec37:e539 with SMTP id
 006d021491bc7-6ac96d265a7mr3275549eaf.66.1785328642641; Wed, 29 Jul 2026
 05:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728202632.4784-1-nicolas.iooss@m4x.org> <CAHC9VhQUrfH85GNLTDYp0Z+KYmpqyVzs7HAr78+J+QM0p511OA@mail.gmail.com>
In-Reply-To: <CAHC9VhQUrfH85GNLTDYp0Z+KYmpqyVzs7HAr78+J+QM0p511OA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 08:37:11 -0400
X-Gm-Features: AUfX_myqXjdcqcpa3JuqBK4jBSmcJagvdVO-hn6O9xZymvFYfVO-opr-aDaAoc0
Message-ID: <CAEjxPJ6D3sdFDHi2DxtBSzVQ=69ffyZRS2d8om1fOrj9Da28bQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] SECURITY.md: Nicolas Iooss is stepping down
To: Paul Moore <paul@paul-moore.com>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:32=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Jul 28, 2026 at 4:34=E2=80=AFPM Nicolas Iooss <nicolas.iooss@m4x.=
org> wrote:
> >
> > Since I am no longer able to spend much time working on SELinux
> > userspace tools and libraries, I would like to leave the maintainers
> > team.
> >
> > Update the set of people receiving security reports.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  SECURITY.md | 2 --
> >  1 file changed, 2 deletions(-)
>
> Sorry to see you step away, but I appreciate all that you have done.
> You're welcome back anytime :)
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Likewise, thank you and feel free to come back any time.
Merged.
