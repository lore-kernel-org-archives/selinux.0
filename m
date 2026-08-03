Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD54140F74F
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779115; cv=pass; b=Lkg0Bv0lxNFVU3LXLbP56+F+hcS7qp2lwGgHDs0H8qMIRSUQdjQY4aSX3NNmPGPG5rm3gP943NSnE8ZkmRwvWrXGDBIWCeKQwErO/+0jUBNTjiRKZsC+MdPKWdc46Q//iezU54AqaTKUDqsMZs5Dfi/DyLmVjg55PNCmc34trp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779115; c=relaxed/simple;
	bh=i7ww9IOZqwsa0LHmziEbiKv7l8r/8t2KL6qKAgK2n40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhUXLqrEdeN3OYb0/XCsIoRJVVxfkKBH/niPab6iEVeiDTxZ/G3xIhSO91WKxyDT1PnRBPMSfaMJKe9WdPIPqr0NMphnJRx7eACUhcygj6jMQQixmFYa9AcuJ2wNMrLuF8Eb9rPLxg/i5KLGd++0tymldIUGG1czeOf26GLNMtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9qyfaWq; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9qyfaWq"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-44caeb973b3so2289727fac.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 10:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785779113; cv=none;
        d=google.com; s=arc-20260327;
        b=kP0r6fz4XFhwWC4EYjJUJrF8H99nR7mc+yjCq7q43jBw2i9RbXyVRgF7qXPViSWjM6
         GyJdJ7vi8IWweg5J00zXV8ngZqL9Xn8u0CFTclzhlRb4n8ql+diFuvj6TtjWLpywpN7e
         Nk7QiWGF/nVivw98P9y3n3CdS/x6rE79/tjhP3AVJMLPgcbochoWqOohR2u7X+KNJLS1
         MHzAoFfchzoEPkj6eKOQgsX/eJQltahcZZMZm8g62HSZsDt2mR3U6YTzDDl2d16b/fmA
         5StxOmcBcokHWHBucOMt3VL17L/BAtwlEXJJMuxFqDh4f8wK+82CTbakVBpQMqlD4OvC
         eKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v3xhNa4ruAe8KzDK9bmvnCR4hYh7w4gzrCNU++gopWk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=aReZCWzpaFPiQ0gn+8F3AKF4sprf8e0yT4YRejbIxjkGl28DnHwGXrdUPQJ1ig1dIh
         c2E5jMx/UDPzYxNIB37abCFQho2WNw80LAyNynzPrxmJrbnxKnWlHolc03go414iS6QV
         ECsH7sEt+6xZeLe6SpZRNYYKHoYmfwCpOIS8uKQbEhP6pVp875FhenIccAr2wEvpskpD
         1uCUteMLeTKI5oSAubY28xhSJsAV6uJzF5mQXufbNAC1GJ4WBTJoi80aLjmfLNTrfjki
         MYiTWAaHNXr9nhQ9bcdOB9IUZZ6yRN6PAwdHfAau7XoGG8dAdY2rF0UC721cYkqzOK/G
         +tzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785779113; x=1786383913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3xhNa4ruAe8KzDK9bmvnCR4hYh7w4gzrCNU++gopWk=;
        b=H9qyfaWqY+FrLoevwUxAd2+rOFskwgASWVAaxolTTuZ/Dw4jcrY+6ck3yTApA8QJqr
         yN20Z4zVUs1Ja2dZ8k7Bmf+v1XDR+MQt+lRVE2BEECq7WuH8xZo0GxWsDxjSgsJWycU5
         dJVmCg32UszVMAqATJEgv7OT1OrqePzx8rZK0p4oYyR7ckByehYu3krcOhZNV++ZtUFK
         WrGtQbJprGGDRTk4qEZfUdfypdEVPnBmTkWR6k/o5eeg9/XAq0NHbZIl8WcERTJsjV/S
         8I8BhOYtAZh37VsKBdWXKp0+u89/bY39OQjwwn0685+T+0xWNrmNVqJfe1BJaXO6p3kV
         Xjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785779113; x=1786383913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3xhNa4ruAe8KzDK9bmvnCR4hYh7w4gzrCNU++gopWk=;
        b=G24fBYuKKr6Hj+T8Z93H8DxLV/St5HLOrGQDlsQRAtgGoR8YFdP0MJ9TW/o/dDIGjf
         7HYE98ayO5XrTS4nA7viRa7pji7Y1++K6XIZ/oevWL3TASS7On+Q+lJVkoc5vFlfvN0M
         bgXxoFxd865+G26dr+EggnG+98+g2RTZQAlqAjmIrQ48jIramGwEp6AiXtB0cg1evkpq
         5VdKYKGSH3YaxV0GkMWpq9idmejlGMJwHK9E71J2ax3PA5cOjUK0ZgiF5neOIVjQv89i
         ZFDsonnhbJeRT5251+qOxlLTP7bnhDUef/MmbufCgXWm+gGaJRQFqlodgny5ocx/H5Jc
         I+7Q==
X-Gm-Message-State: AOJu0YxgwlvQKCskJ1VULJdnOi3WK0hW3CXVpvImW8yEsYT1O1eqFSM8
	49BNk/mNtjZQUdH47FidkSgIa2Bok5H6Rh/ms25lMuCu+1Y6KT+Ovismemi3c9o/N8KkHZCkWpj
	Duso8FndCMHyP6Uc+/3XcZ2UHs8pfq4Y=
X-Gm-Gg: AR+sD10TWwc/9c2hKx4P3WkUKlSlJbMyCzQx4gKWMzqr1+j1fvCT837bqoty4j7ezc+
	shEduH56e82Uc0SX/M+8RmpBSI8CJRFb5ifGTuWflO3NJZbA69B5w6vN6ipPfPhgWc8qqmSYfjc
	dXVZsH6FBShExiHVL4yAUXJ6OKsSDn9KyeS1Bt2IQeaedI0KOV+yWheAo/XGIzr/VVycsnULS83
	tXB5ZMeY6eORO6EAUSUxahxwZAAw5byEQr6ArOIn3Cj2h9I3ITTBZK7/aCX9q02vbASnrm89tsj
	NGhgdy9sdZsG1j4c7/QjjVPH2tBTFTfHxxphAD3ygzsNwgQfEVsaDEA=
X-Received: by 2002:a05:6820:4cca:b0:6ae:42c7:ef83 with SMTP id
 006d021491bc7-6ae42f56a05mr16975048eaf.0.1785779112696; Mon, 03 Aug 2026
 10:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803172420.23048-1-jwcart2@gmail.com>
In-Reply-To: <20260803172420.23048-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 13:45:01 -0400
X-Gm-Features: AUfX_mwc1p1FkoPMO7kneZIYIU0rWkZg8DuVmYvYgnK8QHoUqH7vwRjv_XKbtpY
Message-ID: <CAEjxPJ7h=AqMPVP21rp=bv6ymZRmXfgKvAPRqD0x-=SDCTGckQ@mail.gmail.com>
Subject: Re: [PATCH] secilc: Use size_t for file sizes
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:24=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> The programs secil2conf, secilc2tree, and secilc use uint32_t for
> the value of the size of the input files being read. This could
> lead to a file larger than 4 GiB being truncated, so use size_t
> instead.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  secilc/secil2conf.c | 2 +-
>  secilc/secil2tree.c | 2 +-
>  secilc/secilc.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
> index 9c028656..8378aceb 100644
> --- a/secilc/secil2conf.c
> +++ b/secilc/secil2conf.c
> @@ -66,7 +66,7 @@ int main(int argc, char *argv[])
>         FILE *file =3D NULL;
>         char *buffer =3D NULL;
>         struct stat filedata;
> -       uint32_t file_size;
> +       size_t file_size;
>         char *output =3D NULL;
>         struct cil_db *db =3D NULL;
>         int mls =3D -1;
> diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> index 039d1524..e7238a94 100644
> --- a/secilc/secil2tree.c
> +++ b/secilc/secil2tree.c
> @@ -71,7 +71,7 @@ int main(int argc, char *argv[])
>         FILE *file =3D NULL;
>         char *buffer =3D NULL;
>         struct stat filedata;
> -       uint32_t file_size;
> +       size_t file_size;
>         char *output =3D NULL;
>         struct cil_db *db =3D NULL;
>         int preserve_tunables =3D 0;
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index 016ffef3..54a15767 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -88,7 +88,7 @@ int main(int argc, char *argv[])
>         FILE *file =3D NULL;
>         char *buffer =3D NULL;
>         struct stat filedata;
> -       uint32_t file_size;
> +       size_t file_size;
>         char *output =3D NULL;
>         char *filecontexts =3D NULL;
>         struct cil_db *db =3D NULL;
> --
> 2.55.0
>
