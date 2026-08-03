Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E730AAD8
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788320; cv=pass; b=epHgEyywp6FBw+K+YxNSOxuGihZFyX4SnYKFErJdksry6gqDPVsOMHnTKx6x5ew/iWeFwNvWJTlk+gptX3evLMhHv3kxG0Fg1ERRFncDx5A/FaJQcOP3CHw0heZJqyeqw00eLsYlTJ92bPEHP5xMYXZiiMzDTBHBtVLfAx73Bp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788320; c=relaxed/simple;
	bh=KdJTCyoBA73KdsxqYaZOY1oV/vhexhjSns3+BgSlOKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arqAqFIIjj0AQhTWrZoMbb2ejFXVvMAjWtaViyJqEC4lLK7IgreDA5WhIUFD3Gq91HGZrCzyJqJ6xHphRimoPlEe/a8fkC3TJ5jUenzCH5OJCEvYz2bkeJQQsuN6jHEXSq5rXOCAog4/DblPcSM0XnONQTUu5f6gAUFRNaZjcwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTtOAKXk; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTtOAKXk"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4583b1703d3so1089018fac.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785788318; cv=none;
        d=google.com; s=arc-20260327;
        b=fzXL9ArdZzawBL+KBIbATg6wl+/+7Zq5I4lvKUIsnFrwkkKVcSovp60XxaqzZ7WHdj
         enRfD37dKPZTMineTikPC/FWHMCgzesecGveVChVXtyZ4BgM4ZomnzoaSPUpR4/qvEfk
         d//oNTVcGuKQCX4FohJkRnQfXWb6VikZPTDlSuWZmqyYrVaaNOU9ZiHvc+XXpkyUCCMJ
         cBwJajXKZlYtP845CY3O3hmZ5HaS1AwDHULYdo5m96ECW1S2EQu/soEg+ipepaSjSGiJ
         w9+h9jX4vXkQw5dNbEh49puvZm+/w+4Lg176UJtFU3gmpvJS29S2JmGhqVD5aHUiznnM
         a/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KdJTCyoBA73KdsxqYaZOY1oV/vhexhjSns3+BgSlOKE=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=EUi8lgctKWmHKFLdqGZyEvUcvM4rMFqc62nMiZoazUDYpSppLfG+xOiTx79udF98ZD
         si/Ng7pLTaF2nA66ZSeffB0PDqacx9Rw84L9nZQwKZpxtCUm9tAF9FyXDW9ZvYTTkcGI
         QcHtYQ33eaijQ561fWnzi70CTfl5ZK/HjqIyDc7xbk1Rjh/ehannvFoULvd9PLFQHrgO
         5oKO6TqKf9NHTc9F06VEfEl20/iBQ1UaYueQBC4ebjSfHsDU0c5RWzDcc+XVdlVVxJ3W
         yCQhhxMVOZC0tnsOyYMuEitoQWm8bqFEabW0PZCnVxkO4FbI8nWnTTe008UHgk1UDa2l
         zZbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785788318; x=1786393118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KdJTCyoBA73KdsxqYaZOY1oV/vhexhjSns3+BgSlOKE=;
        b=rTtOAKXk32AjK+Eu50ycKvDyBIWTPM0pG2tpC9pFEM/Os1qGfBx8SVI8U4GsSdjQKf
         7AhDNzP9XcYEPg0Q0Y745rY2qCTdQq0I8bBm+xVLOfH6VI+ab5EOo57lTma8oeyu1K31
         k6jPk4tMw1usMA95CoUiq4IzlnX+pzSoPYUOlhuKL6fpHmksr/lna2ypo66PR17J8eLr
         +78HTauHCNAdOengbnIOjwnL7cdDpZNRB7gaNRb6JptcJRjn0my+bIj7+A5C+JdG4bEG
         +DAVamGgi/Ooy7as84UPfTQUqXJ7RR92+oroZ8KfOPTwSKH2+6Cs8uzO+Broabsc+fxm
         viug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785788318; x=1786393118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdJTCyoBA73KdsxqYaZOY1oV/vhexhjSns3+BgSlOKE=;
        b=qcTNIh7k/Z3IUxYfIhzxMZekQH4eA2+evJ4KSKEcMxnQudT6uEIh/W0F4/KlGoPYjT
         tc+pe+Z38zPl+SFrSp/8aXYYbnDgjfv9St8xSQRx4OluAmywRbgzcoBe0UxFOE0mTn52
         dwPA9As3GHpRitnwAnRB6hojfQeyKfgN/9wGB+fqvIiO7m9cc+bW/VoA/onw4nFS/9Qk
         JAOjZGnbfzuqFVJWBkHh4HOcs2Z3xzTkatbiOmlZjyHGPwkTx/Irp7oDWdGbe+grTXcF
         K1pM/8+ZnpCMrtflgAexLwGmooHqVaiDG2fX9xnVrKhXvkKJxzGcKYoMF9ZGRfuwaW4r
         1YSA==
X-Gm-Message-State: AOJu0YwpyTnu846PtaNXDZrczY8g7uPQinQBwe5eWJo0h42q3YwKKtFo
	v0cQPwYAJvFA+8U4VQ0osbU8bMUriz9n9eOSlH9fm6EbgdWJQOW5bO5xOgfqzyv8Mf8x41AbeO3
	DXjw3nrw5DTCEASyBh6Tlda6P2oGn1vpBfQ==
X-Gm-Gg: AR+sD10jir4mo5DjFRP8OyHvbwT8LCY4i5L7H0nC/sVJdNhhgNns9SThPJVbqYWV/nV
	qXrS7+b+Vq7MdI+zyzR1ixavGYCO8ZYBd0bGxo9OABprjpf4GglYEH29wiSzxORNMV1bVAvRm0F
	rpXpFCpt1htYo65n6q9S6Jt74AHiTFsOU71uedXyPBOpg0vf8DgtZAS1ht4txK5+F0zdCKTv1g+
	tJX774oKd3aU+J/qWYtQkkpswOODXQ/8qpSJedIu6avk/uZdfaqMcUrFPPbhQ8zJDdZf2EWi5Mx
	AKWorcfa4wv6VOWrk+nuUBin5snN8XvFcqHwCR+UtaF6
X-Received: by 2002:a05:6820:f02b:b0:6ae:47e0:be20 with SMTP id
 006d021491bc7-6ae47e0c034mr13640287eaf.7.1785788318080; Mon, 03 Aug 2026
 13:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803154748.18370-1-jwcart2@gmail.com> <CAEjxPJ6EKS6u0mxxuEbNGUB9TZUJgkvcMVzzKKtZTrUSaFrvOA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6EKS6u0mxxuEbNGUB9TZUJgkvcMVzzKKtZTrUSaFrvOA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 16:18:26 -0400
X-Gm-Features: AUfX_mzIy7r1kyNcaXdc693CrMvd47mKU3ZpodleI1WtDeOZtAz4iILGBDVYgAc
Message-ID: <CAEjxPJ6376BUuLtb3pEYNzUZZfK7_TEOd89Cd_O6Hd1xB7SgfQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/fuzz: Validate output of expand_module() before proceeding
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:35=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 3, 2026 at 11:47=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > When creating actual policies the output of expand_module() is
> > written to disk. Converting that policy to CIL or performing other
> > operations on it will require it to be read by policydb_read() which
> > calls policydb_validate(). The fuzzer is not validating the policy,
> > so it is reporting bugs that would be caught by validation.
> >
> > Have the fuzzer call policydb_validate() after expanding modules
> > so it will not report bugs that are caught by validation.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
