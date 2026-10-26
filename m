Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021957;
	b=Jh/IGrnCYYmquG9/XJwbRR88hgJ32M5k3PlB42SmqlPD/d3BTvR7NRPTHxGRLJiGz+sB
	 +TMGsYaKl4oTRq0PyLSEAxBgTy6M1/9w/K5bt/+43Y4vSqQCun1q6OjTe3XvJ0a/D613e
	 8SL28JIrY0NyBdgs9ZX7imcpV3wUPfVDCTvpQcxU5bHCv4PDc6Inw5QiR7oniEpCyO7SV
	 zGyY4uPPzT7SLjBJv6e6gSSPoyR+9gH2/HkzAo4uw+IN9kZw0RXsT9cmpEI08gu2oFv3z
	 Uc277HokM/6ia3YK3sDV4JzJHGRnMsUny7WNV3fFaB4+vP1e4E+A2hgZYr4yj7y9o1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9/gHEXhccl7K2s0awxWPnx0p2EajS2lp/1uW2BHXLX8=;
	b=JI/gGTtA7bjjz8OjA9XXfS2OuqzSGD2dGsZiLI5YH3i6eXBDEOn2CXExCxF+B0SWlZ93
	 vgn3WzgVqa951HUgirhmqqBAh5GgM6I6p3gmpR/rsl13xa+vqYZisfp0J05nRLd7JQzsD
	 kMLTInm9AmAkMZLZJ3oZEIPQQZgS9xEFm9jk6RvtFpChbhxgHnswU00eJ1ilecCXP41sc
	 nhzgdM0WGKid6/AWKNgyuCSzh7vc5rCo55IIQU6bFIxvyi3Hg6AP/NMVm9z8BYQgFuQiJ
	 gX3HmdIzMbVmquSrgNpA3UqaNBQynJdO+xtlWCpTrLRN/ps/lc5+IWt+UC8FQRTpEAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LFvxKXCd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91583606A328
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91583606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LFvxKXCd
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-679a2b540f3so2582060d50.2
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793021955; cv=none;
        d=google.com; s=arc-20260327;
        b=NtF+Nhd3ZZA+hzESfmL+Xc8S4+LwOdYKGILixM/LRtkRfkJ6U4fAqgSj2p7NHsHaGE
         L9fx2q4Wn1pNHyWl494Srsiyndv9H9emZgME3owypWFRL5o0Z7EpYYYt8GFZcLNDMz9Q
         WI7ryNfPWjdl+Y+G4yG3NZKcxK9ZslvcyQgopuMX1CqioKC1P3pToi5v3xDIx3sF+Eff
         ht149EYNFxpwNhc6+qVL5bPQvtcYuNw85PTnr1hoocv7k0BmEqhVEmA1Bad3LZUN9vLa
         obIbi9IytZd4H7u/bRhlqtti3m/DuF2Bv/gzBMXiXh82s6+f2ZtzgxD5EZQHIx0jpwjG
         hhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9/gHEXhccl7K2s0awxWPnx0p2EajS2lp/1uW2BHXLX8=;
        fh=dOK3+QzSPN7gzn1PlS8ptJJmK6YYk6mhFKVaSQ0dNqc=;
        b=cyJQ9drzd6qcdeqAxTehUbjPukI277sDF/kk2chP5LUTIbA1PrUynKWEPxTrtUyClD
         sowufm+jEa5QgeGalPDXe6RphL16yNQ42djznakjpSlIQLxh3B6ZghkTe1AbxdKjMBu7
         eUmtuLdNQMzmuOopqZpSlHSTGFFL2OkrhSz8JBp36b/RewCPNwUTQ+sV/WpIzmlV/1Ia
         bQy5urv7B/dlgzY9sFpKmbE/7QNHhhd0gziU6+EbQ9ksByXi1Svf+OeCwcId3Lqn7YxB
         PE4Tkkn8Er4cG2WDaXsjqZUQ/hNMaF5Npr+VCBoJ2xZvzBwE4trzR4GDjrzmePReTdXd
         0gnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021955; x=1793626755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9/gHEXhccl7K2s0awxWPnx0p2EajS2lp/1uW2BHXLX8=;
        b=LFvxKXCd5LTDiYOAmtmvXKgyqlwDeTPvlwm81OgySHrRTgFsWX0D2XdFMfwY+9Lo+/
         EhotmjcBwklG9cYlWCAGMeJaMSM1qKJP8TtC9bgsscSjF/TQf191mYmDpZJv9H1belm/
         PK9cEOd1u4k01TURQmQVHfjZe0ZNjUxR7hqsDHyWvSRRSUiWl/ETLx6O6Zo0ZGH8OU/k
         EIyfhYYMcoMbVwuijPI2c15YVKWiPtGWYns/EbRlQ8yYCzg0jTN+nbUmu+Zew1csgt6l
         ochj8CutkzujTMsACW2/LCjwPyz9zwlj1DvX/CXuWobNmYTaM3UgOLoDzqdeYCeF5E7M
         xnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021955; x=1793626755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/gHEXhccl7K2s0awxWPnx0p2EajS2lp/1uW2BHXLX8=;
        b=TW3zTlKhksW8hMqNNMEyVGvwuuDRLEjtHIWM+xPKYnLCGHe1KIdEZaPJLUIt3ejjs8
         6UPUjd3CI4nd9Ikmw8jDUF+dHKvBRwOYx7PO2pDPemagR50yam2URiWu6hMry5cF4YSU
         tzcRwkGuzrXZeimefbv5SzT8y9bb3cSlZA7f49ARtNkL7J1XOW8AJcGD+FBsmruO8AFL
         vB+9PUMIMrGwajPv0IX8N3eUtox3ggd5AZFpTe/wa+LRZRd2oLRaTtxx+A99N+CSr5QA
         Nr8b1AaL822gUgGV0xrZS8LA48nJDsDMio7BHCOH0trAnS7vu7a5YQqKQoGrcc0Tx4sS
         joSA==
X-Gm-Message-State: AFq9FYJphlYM8mxKz/R18qnTSozUkiRd5eH3Ppdwj0EwWR0XaV3sq3Sp
	1tNMPzpcxXhVI24Ga+pywt4XV+4q+u5aq3o1XSNko3+zgi1mlaCTX48bK0TYMydLXECAwC3kXbT
	G2IkPdcXBmzET+Lr0gfSGEezMqHkD7l+3fNU6
X-Gm-Gg: AYBFou0XhRRRabZHu6ZRbK8CAqzpUtX3jbD/BdmLm83nFpMqbHiWFfdAp4nIoSL4zQs
	dNBrFLwPrNISmZ+5um7FDiDxHG0VU24qyxM9rHyIL5RKIXShiPz2yNY0UpaQV/8wM+ccUvXnd2j
	l9WYxNmsSMtzb6Q/V/f4hStDD6jFJbI7QUeMhEjFWUWlxGDGxQQDOaJxkoiHk0LyoxYTj4iv4Pf
	93kyc3yo5po/juy3Q/0VkUqkjDITUe/nmdlN3VmLnAfYyKFAKCSi1213bfnNV5NzufRdH7ZV10f
	SCc5d++IU8MoE5GATNxUFDNLWyhGT/kDQzNFePg8rDmFO0T4S+S1wgAeB5ah7TjrVjT6F+Tba+N
	Un/Dvmi4FuN5q2eb99Y1k0e/XRP/VwqWKCsgTgsEe1qI4DvY/NcueRmpDD4AuKYy6tHe+JcLSmr
	2xHghxgVaFmMNjyaavopIo70oURJDR+yQ3ozJCW6Onq/E=
X-Received: by 2002:a05:690e:1510:b0:679:a2c3:b2e9 with SMTP id
 956f58d0204a3-67a454aa148mr3793753d50.101.1793021955445; Mon, 26 Oct 2026
 06:39:15 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019140249.30088-1-stephen.smalley.work@gmail.com> <CAEjxPJ4tY5cpYMN4CwPoS5RN=+=P9RwzPiHGG0uTX2dRKWU-gw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4tY5cpYMN4CwPoS5RN=+=P9RwzPiHGG0uTX2dRKWU-gw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:39:04 -0400
X-Gm-Features: AclHuK9k1c4YIYQqziYFUn3I0UB7Ghq3KbcAfUD7838rGKTi09mv2wloqQcn6Ho
Message-ID: <CAEjxPJ6EbWx-t6zCQ6mX8nDErjnLyd7uTABCern=+wRuD_5zOQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: omit excluded mounts from the fixfiles
 relabel list
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, Pragati Hatkamkar <phatkamk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 1:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 19, 2026 at 10:03=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Pragati Hatkamkar <phatkamk@redhat.com>
> >
> > fixfiles logs directories from fixfiles_exclude_dirs and passes them
> > to setfiles with -e, but the Relabeling line and the per-mount progress
> > output still come from every read-write seclabel mount. setfiles prints
> > a 100% line for each of those arguments even when -e makes the walk
> > return immediately.
> >
> > restore, check, verify, and relabel all use this list. Leave excluded
> > mounts, and mounts underneath them, out of the list that is printed and
> > passed to setfiles. Keep passing -e so those paths are still skipped
> > when reached from a parent mount.
> >
> > Signed-off-by: Pragati Hatkamkar <phatkamk@redhat.com>
>
> Other than some whitespace nits noted below (not blocking),
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> We probably need a standard formatting script for our shell and python
> scripts like we already do for our C code,
> with a top-level make format fixing up any divergence for those as well.
>
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index 45f2d5ce..e266da77 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -259,14 +285,18 @@ case "$RESTORE_MODE" in
> >      *)
> >         if [ -n "${FILESYSTEMSRW}" ]; then
> >             LogReadOnly
> > -           echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
> > +           FILESYSTEMS_TO_RELABEL=3D"`filesystems_to_relabel`"
> > +            if [ -z "${FILESYSTEMS_TO_RELABEL}" ]; then
> > +               echo >&2 "fixfiles: No suitable file systems found"
> > +            else
> > +            echo "${OPTION}ing `echo ${FILESYSTEMS_TO_RELABEL}`"
>
> The four new lines added here use spaces where the surrounding block
> uses a tab plus four spaces, and the last line above therefore shows
> with the wrong indentation.
> Cosmetic only but would be happy to take a v2 patch.

This has been merged.
