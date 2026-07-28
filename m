Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2CE15B135
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197233; cv=pass; b=X86NQXDqoLfOsC0jTeWTk7pAP4n10OzmRKml/AatGgECXdvGRGhY0n1JQ8rLcQ+EddNoiqPcyxbl5ND+NVPoavwm0gG+/yNMolfF4i5JwvDSQz6HLXFou4lanvVvyQZVFAhL5VRyAH2DK29IzXyz+Ly2qpNtjRNhSdgfEca/sJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197233; c=relaxed/simple;
	bh=6c/xKHarSQWBzSzGp7Mht9F0BAEdGm5WXKYEBjoem4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJYhGdbkuTd73IG3uIkS932uZeXYeJRkqertpHJYlMUGpCm8SpGHeN/SxUCbAokiae3nPtdPZEeoLNyLrHIQRYKBz4ciCpilx34fgCCZaDyUl/ItzsSWKGimENAfoOIic52K4SPspa1+g8p98vzHOCoFtkGtEFWfIKgx6E1ZaeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WazXm8qj; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WazXm8qj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2648546a91.3
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 17:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197231; cv=none;
        d=google.com; s=arc-20260327;
        b=rNVRoli0cwe1vLg02hxsZm42SCDVbAA7Unw9jZ27f4kMiwE5qfmT8Ddy/pxwxRRTSZ
         Y86tUV37NNkEJzAlo+fzctdJpthq6HcvZJwp51LhyQbWsp43AUzPtNIDyQK1mVv978YK
         ew09A4O90lXe+qpe635vwNWXSYmk4Z/oyXD30scxZPNKGACodzCqs1UvRmoy8fjCGO46
         fyAfnE21Bn4s6g7/5NBcNzBACWjodDo9d8KJCY+yK8qlqttWk1o7FKYGUjH/kqV6ZMf+
         iLAoJWsf1RJ2rIjHt2YpKtKbIUWqn9gujcleRkE7TE7JnjLJY5/MvD4S+FzFm+vgcaKl
         e19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/s9Zgp0xHgHRCawDxynZGu7ydKA9tk1TtAIItjYulT8=;
        fh=PJCj4BxjzfHmpQ2IB1B4dvGiTrwSZkxmWjhRvSDz878=;
        b=NmSm1y4vYCryXBDLnlNDUmVr/AWWH8Md6EwvUoh8bdm1oj/Dy7bbflgOjDwZhYQ/UY
         DJT9spPDDhEzKdLji5PfM1KgjQXZs0oILj/WO15olebR6A5cY5dar3sBSkGz8wQ7RfHQ
         +JRiXvg0895S81cGGp5Xi5U92JoZTx8OPgOlCUm7pGwEA8yR236JrivK6EWg9hStNVty
         oQfJrdrrTNpGHe8nbiT8FMq18M3ywP+vDYbefht9gUrfGNIEU34LO3jSORiTR6ClL7t+
         hgp5JVgWgaF5WCLBzD7imOGaNNVjcKr1GjMg3pw773AcB5aUmnuhcHYjdItqkwqUlVEZ
         hXEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785197231; x=1785802031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/s9Zgp0xHgHRCawDxynZGu7ydKA9tk1TtAIItjYulT8=;
        b=WazXm8qjtKh3ioui0rP33ezGTkTQDDhP1CUf0/OP9KKMYydCQo4V8HM40nGkNXmawr
         IKuwg00CYSMbEUp/fUiL19bvQdlrr3m0dvkftjJ5A77ad/eRmGmuYJVRHXm+4YbrPtiY
         UNdwL2KVJ1gPG9WUCjkFkLsE2UEtwCfFA3x+nzO8KlfJKuc+D1aytc31COGYdDxR8aqI
         qX8TfBHI9MCeZJpjvxwHoF7FjRHkYweoho9FaCEO72Y33DDI5uj441wxfqG8w06Q4PSi
         sG43L0/dtd4x5xwB9fPjMF8Vlto3jZc7RQhzMMTxl4zwXf3OI0KV+klbwNNmuxMAqIUj
         0KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197231; x=1785802031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/s9Zgp0xHgHRCawDxynZGu7ydKA9tk1TtAIItjYulT8=;
        b=oj24P+uvOQwcdAmIdLqxf+dxJrr/XYdzr5CpHq+9ZFwtCARunRVVVeWdIaplcllY6g
         Vmhh67jhoywgR7s9CF+I0XwueEpBvwjmMtvnxWqYOx89CIvq7MN97BeaLDvXarYyu5Cw
         PzHJcF3QL/3ynrEM+cas9oZ8FIZAjuCYIxMVCV7k3E+82T53iLkWJ8SzVxfUfurNkz3S
         MI9C9K0Zzm5YUAa3R9X3fM6z/jM1iC2klgTSiEXZqOsmMyjOnNHSoxfM0RoHzP+Kx+l3
         k0dEMaZG0iyMD20RgCQlUSJ/VT0CFzlWKTAUd2Ed00BC19suPTXMwXkH9C5KARwCizAm
         NDWw==
X-Forwarded-Encrypted: i=1; AHgh+RoLfjg7cUkQh2kl5oBEVueZuCZuGE30v8yueXjPQfury41Z4OeeLYDJoNJ6uH4vKyNgb5+vC/DF@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBQDlgHbOjUvTTp3+jXv5B06yJw3sj6EOabUT7VT8GuEpaJ03
	LrRNQTsM3b+oyVHgY+3ZXgtcso01FESZivVEkTKXsFD6nFXyp+iKpWlKAEIGHsHrsoJSlz+bOgF
	aoQHK13OESCr33xo8oMcBTtVyYWWlAvtizAUGSarS
X-Gm-Gg: AR+sD11ZOkTj+KA5Dni6y+gdBtWI4/WYBA56R8VwFlMeQ4VmrRe6oTY6wu4vAtxQHJF
	M/OtbqyJgbNrnC9X4dnIMPpwZrsPvnRBvZkU5PfQIz3u0HpVubggIvSxuL3jo7Y0JZZYPBZngZA
	y7mwgXLAGu0WAgy5huf4M4H6jGA742rVswbexN6eI70r+yvG8phsglW1TLVPBHZi6M0kTQIkbmA
	NrVfODuyDYGgwSjRraralK0xojG/79YzYUj5fNyMQCNLOwqII45ijyccdNyDTkQof8Ok05GFmwd
	6VDuePw0434iGPv2gu+L6ZGUBprIaNWBJma+TuYIRegF
X-Received: by 2002:a05:6a21:9185:b0:3c3:9835:e76b with SMTP id
 adf61e73a8af0-3c8ba5d8566mr140129637.49.1785197231172; Mon, 27 Jul 2026
 17:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
 <CAEjxPJ4_chAbtJa4obgN+QSjMnCwk9XQ-4bnyOFxgFoFxTsV9A@mail.gmail.com> <CAEjxPJ6pTrKAdhGFVO72x5117RkXCn9xKeqW9NTHfgi-6eaywA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6pTrKAdhGFVO72x5117RkXCn9xKeqW9NTHfgi-6eaywA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jul 2026 20:06:58 -0400
X-Gm-Features: AUfX_mz0mPP6nq0gsFKq9gnL0DiIgccYW-ITptgck-GOQN83YL6AF5gWLsOSqYs
Message-ID: <CAHC9VhSN3nk==hTwTzodSOPX-COH-zxLfybqvO-CDpgc+BxFTQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class
 permission count
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: hexlabsecurity@proton.me, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:56=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jul 24, 2026 at 11:48=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jul 24, 2026 at 10:47=E2=80=AFAM Bryam Vargas via B4 Relay
> > <devnull+hexlabsecurity.proton.me@kernel.org> wrote:
> > >
> > > From: Bryam Vargas <hexlabsecurity@proton.me>
> > >
> > > perm_read() bounds a permission value by SEL_VEC_MAX but never by the
> > > owning class or common's nprim, which is taken verbatim from the poli=
cy
> > > image.  security_get_permissions() then writes perms[value - 1] into =
an
> > > nprim-sized kcalloc() array, so a class declaring fewer permissions t=
han
> > > its largest permission value drives an out-of-bounds heap write.  The
> > > top-level symbol tables are validated this way; the nested per-class
> > > permission table is not.
> > >
> > > Reject a permission whose value exceeds nprim, which is already set w=
hen
> > > perm_read() runs.  Well-formed policies are unaffected.
> > >
> > > Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classe=
s and permissions from the running policy")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > but also see:
> > https://lore.kernel.org/selinux/CAEjxPJ7YRgtOXrbPYar0qXAq=3DwNbOTTMS-Es=
U=3D9HKR1NQ3qA1g@mail.gmail.com/T/#me98ec932b314ae94242ed3af7ab74445d273cc7=
d
>
> Also wondering to what extent this may overlap with this series that
> was never fully merged:
> https://lore.kernel.org/selinux/20250511173055.406906-15-cgoettsche@selte=
ndoof.de/

FWIW, most of that patchset is has been merged, the individual patches
that haven't been merged were held back due to review comments.

--=20
paul-moore.com
