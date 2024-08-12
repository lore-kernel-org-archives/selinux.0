Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06F4B5AE
	for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474389; cv=none; b=Z54555e6FDXd3qUreX87PyOmb/OdJwlzptsT8xTXY9aNaLITFHgwz3UAFjbgt5Sviwe3VUerHknSgQBr3bLUf9jLuzalkTqipVuVASSwsRrPDtH4nYt+Q9Lzm3N5l2FHiIOxKa+1QJb5bDMlfYdl0kj7t2/dwkz3ayfZYhQ43fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474389; c=relaxed/simple;
	bh=OSahQtQKAcDbAcewtK2Atpz2yqC9AoN9y46Iv8pR3K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVVBEW3A1s/6pBFKXqU3LUU7rWo4kgGJtiql+JqS9poHVp5be8FpAGcGx2tYVB7pJfzuAUpL+gflsT+Ea7dJGPsjgZlBbHpmH9FxxtgiykoP+G6EYzt+NwK1hBllF1NX8Y0g5s5GRylbsdZyaqTtJMFz1mPOeXT+Y0AeL2b6+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaUKMzum; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaUKMzum"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-825896b2058so1171671241.1
        for <selinux@vger.kernel.org>; Mon, 12 Aug 2024 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723474386; x=1724079186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGLhdEIakA7d6DsKOQnFk9BeQMMAVw8BzsQFu5UjqG0=;
        b=VaUKMzumQmR9mx+TKuWmUO/oWGPR+XC7UOUS2nLyz9NQTLdDlD24qJlvnPKJPhZyWJ
         ta0giOJZVPWty6d6rLdVl4hvgOJSytqB4qkrXoSAkpd7MLfumZkjzBJdM8s7jkuVQ9vi
         E5Pzz07SjIsOLZFiYKV4/sUjS7sIvlxwRh1EfEw4y2u6yDbgOCPK4AdX6SyHIjWc5Qkq
         eSTC9KmiRBQrB7xRym5XqgC3dnBpQhcg5snGW3uB6x4+kuOq20XKkNHtFXATmRKkVgHW
         dwwwYOban1J3TKdNyjr/XSRtLAD6Rdgrm3dz7k58QeqK78jA9EvUFm0frF6bJoM9ZduQ
         7ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474386; x=1724079186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGLhdEIakA7d6DsKOQnFk9BeQMMAVw8BzsQFu5UjqG0=;
        b=obvwEpaKMr2LBadNZBVGyQ3e2qCD8jCRPkc9wD44+drDM2J5+r4cZnz2s4vX/ZuAZs
         zfgBKW63oZ9kiKKc39S3oLQ2FKQva2hy9jMd5XojDyuKmo3wDoGIZ5m0X7uy6RaHZL7m
         Cr5ZBguauuLX5FYFV3KezlnivJ52gQaeNJI3VJ6ja13HzkL1iwjJXNFDxLvxzCJP/6Cj
         y9Jxx6MTc+V/izLd8hMTu+c3adAib/iq5825CbqenpdAeyXywXRAFst53iLtlKbMOQLA
         Mt3TITMONz3Zokb3FnZ+qIm8+B/KBDUbBqN6sQUNDqjS0uweoCCyR12gLzH4vNfmAaEM
         gNGQ==
X-Gm-Message-State: AOJu0YzdJ90zxE49PpoSlDeNgdJMDbUvCrcnQfaozK7+DDgkrCzOV8t9
	gcK5M5DJHHTfFnuJrU/EWcumd8YbqjM5dE4zkZl0xc1PmGN8CS46SHOIvRxNTjTruooF34W5hiK
	Lr+fRBV9lPtDFWQM1CoOKCueDUTxN6g==
X-Google-Smtp-Source: AGHT+IFfjsE2DcVoMARf6jcGqMvaiic5A5ffuyHl5qzHDlCuE35SnriwzQ1wbzX/qbxkfQRGLvRABy101BoaHd+VDqE=
X-Received: by 2002:a05:6102:d8e:b0:492:a39c:57d7 with SMTP id
 ada2fe7eead31-49743942d87mr622447137.4.1723474386189; Mon, 12 Aug 2024
 07:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871q2v157z.fsf@defensec.nl>
In-Reply-To: <871q2v157z.fsf@defensec.nl>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 12 Aug 2024 10:52:55 -0400
Message-ID: <CAP+JOzTOB98vKVM+aNZ+pC1pNAi1HtEmxKOqD_FQ1mt9bgcHvg@mail.gmail.com>
Subject: Re: no period allowed in typealiasactual libsepol 3.7
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 10:58=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> Debian finally updated selinux to 3.7. At least libsepol.
>
> It broke my policy. This is the change I had to make to make it accept
> it:
>
>  (typealias dpkg_script_t)
> -(typealiasactual dpkg_script_t sys.subj)
> +(in sys (typealiasactual dpkg_script_t subj))
>
> Is this a bug?
>

Yes. It works in 3.5, but not in 3.6

Thanks,
Jim

> --
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl
>
