Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5A448BAA
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248927; cv=pass; b=SlYvQFZ4L0mMAV/0LP17NRZWADrIo5h7EBHoJg4FMUCAjtl1WeWAaiQXNy8K2/S8pQpWxocgvBjeHdLNTCgXRkI+IipM6ncq9Fl/iVg+3ILpLbnK+/WDZX+yg4dmKICvE1gO/SPll7QdLQoCmVaKFjR9lkXfPObWi1Rol7QpVG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248927; c=relaxed/simple;
	bh=FnFg2q31A9bQqWYze3/mSEVJT0TTVUEEbZTkmINEVAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TN/61pcn0Lwnd9+rma5ZKkoHU/bem/dxZzN5JWZ+niXLkHj7SiYgYYMesQ/HsmHdbNlGnQ9u/f+GlSLGDZ6b+ImNyMPRDCtiQHXwQYBS3JEvJs4wRgVR1eWpXcESJkuSX/IhWUyg9cAOIVLDm7/n6eYjLsfSLJ+bCUUtkSBbzl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTIsnBmI; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTIsnBmI"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6aca0f482e5so120225eaf.2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 07:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785248924; cv=none;
        d=google.com; s=arc-20260327;
        b=I7qW/QwgqVJbEF3b26LLiHA+fO8q/sUpWaGjtR32nKEgJyb+UasyVGhzs73fEdVGPR
         VafG64efCKKAADWozCbJkyg+ibOuKtrPz8Wnwt9DGJKIZPV0as2PK/IHqhdssf+ChDrG
         OH0HiJnctouQagrdE25PPb9V2qgZ3jmW6XjrIsIGxQy/todSbc1TDm/2/ZQCDU2fyKC2
         48AzXiGV6XS8LLz9ivm/eJFrFwl6XhKd+uLg+FajI+ljrpfiJWd9qfBHvk7MIWaDO9qP
         l6mouSSvj8tTmtbCXtxvH5OX9zWDMHFFsJ7lzEca0yH3bc2PZlPUlbYWFFOC4ZuGhMsm
         xOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p7zQd8u0P18+a2cNYRtDbcHSYA9Vu8TeKAlSr06Hrtw=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=BhxNBVfxW+I8aLKXlLriDc+S1tF3U0LLzoFVCn0vIU3nEfN3dGVASL0usQV12m+D+D
         Y06ikRTBBCElbdJ8g+jBSXbpCMV3DdInPCLawcuFVAepu27Yr1c5oobAqvbsPpHQHsqE
         UuEr58zDJdwi28BqaLc7HlBML63H6JPQcV45tRuRHyehYvn/JBFMnoAdjinyBRta8W3/
         7wOugMXzjJfN7DtBrBB6qBoHSiCNURka2gseaYnBOc5t5Fc4YazuP9uGoiY8n/jgJ2tk
         hlmGW8v7P/6/WH3DgQTQBZgn4XLlch14MxHWP2PrDKXwaFTpkygGFyQuF8LqLfgJ/NXq
         NyaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785248924; x=1785853724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p7zQd8u0P18+a2cNYRtDbcHSYA9Vu8TeKAlSr06Hrtw=;
        b=TTIsnBmIBmt7hbVt+vCaiMi4pGprA7Mjg6vKaoCPlBhEF2MAjSioVAmdzKG9g6ZZgo
         ktMZ6RNHmI5GWpvsJl4rwvXfonYnc2cTNyAo84vu75LxC0G44y1gLgDGJU7UObGgDkFl
         GLPNLS4m5H+dAhaqCtbZgwr88969mgPRTdV+tPQPmgZMxJdcM2JRMwwAyqI2SwEEL/72
         vEaYaeZDphbhC1gD+I2/npWrLhYu8xkJKaLLVZu9RbqqcdR0OWBKj+k9csFBD0kisSzQ
         pLyjxUWXEcwFQbcnZLSegmXEnqsTFqEvihcnbB8/6eGW4jspwoQG9sDskH8jX6p1p4i0
         mRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248924; x=1785853724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7zQd8u0P18+a2cNYRtDbcHSYA9Vu8TeKAlSr06Hrtw=;
        b=pR/E6likElPYYNj+3XAZtrSAny5EOSslhY39JgQ074y0lIXH9cm19GXjmaCplJs5Oy
         9jEbQYLwwQaBb0HCYzj5Nndsp7kszx2X5ud43QflqrL1F7++7dyijFQMTXTXQhY9Mhfp
         BrHf8BCTMCPalCew7YpgX1Gm06ZVIsGGnEE2/3oaL50vBbk/Gi0E02SJFdQTIvuNX413
         0mzTQc2sESVtwS3nrwibsyg/5DNP5bBxvpAw2d/ZKhbTCbOhtmHGNzuRb0JujUH7w4RA
         vyvaQK25l7xMUN5ii3U0L5n35UVt+lxPEkN7gkLfNLCb/87iI7a9obyEEkkBPzKHSWII
         bjWg==
X-Gm-Message-State: AOJu0YxY7xpeGBor4HiBnl49NwvR+PZHomnFe8dr3874c+PCp6A/VJwE
	TDlj6HK6UAX0Ip8ohEMCwt8o59gVE1aA38b/fpRHJhiecG78ZSQ0BaygvNdmXJCYRDTcHqAe9sy
	0bHO4a2a1cxqOg2Df1x5DYYLq1VQBA0U=
X-Gm-Gg: AR+sD11FMG0XBsb3G8X1gsrXNiiQ0CrqTnpyqii6qRTPLR5X9YDlMH9bSkTZNSFW3OR
	rBvTj0bLhB9c+nOjGRi+Sg7U0gc1lzxZoJjn1NgomxLBStDVZK4BgUzuFe83Htwd7IfBLueEepr
	h/TYeJzdiVyLIJUiCk8U9ymy4RioNd57uRAJXmgLlyipiBtrdnz67/T2D6tSMjmsgqdkX4L/jso
	8KLviNKYTiEIpggKt7HvFOP6hrV0l/OIrak7VOfwUKKnBM6I7rN08TAjlnYig==
X-Received: by 2002:a05:6820:4d04:b0:6aa:f235:cce5 with SMTP id
 006d021491bc7-6ac96a77e43mr1386958eaf.26.1785248924508; Tue, 28 Jul 2026
 07:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727223242.2507658-1-akkohli@redhat.com> <20260727223242.2507658-2-akkohli@redhat.com>
 <CAEjxPJ4cNnYyN=YSXYArpUwFBSf-CkSNcKNLFnBQ_fkedKPHFw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4cNnYyN=YSXYArpUwFBSf-CkSNcKNLFnBQ_fkedKPHFw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 10:28:33 -0400
X-Gm-Features: AUfX_mwnoF0SzlShSyaKPziu6xf_BBhZ5RN-N9_ev9S-3yK1zIdgSo-UKdEpkos
Message-ID: <CAEjxPJ4KKx1sktg8-A759JQiq+fca5gwe6pqoi4cpb5EPZV=MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] checkpolicy: extend bad-data tests for type, role,
 and user errors
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 8:34=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 6:33=E2=80=AFPM Akhil Kohli <akkohli@redhat.com> =
wrote:
> >
> > Add negative .te fixtures for duplicate type/attribute declarations,
> > type/attribute name conflicts, invalid type names, and malformed role
> > and user stanzas. Run checkmodule negative tests as non-root in CI so
> > the unreadable .te case is exercised outside root-only skips.
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> > ---
> >
> > diff --git a/checkpolicy/tests/negative/bad_role.te b/checkpolicy/tests=
/negative/bad_role.te
> > new file mode 100644
> > index 00000000..3aae2719
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/bad_role.te
> > @@ -0,0 +1,12 @@
> > +module bad_role 1.0;
> > +
> > +require {
> > +       type foo_t;
> > +       class file { read };
> > +}
> > +
> > +role bad_role_r types ;
> > +
> > +type foo_t;
> > +
> > +allow foo_t foo_t:file read;
> > diff --git a/checkpolicy/tests/negative/bad_user.te b/checkpolicy/tests=
/negative/bad_user.te
> > new file mode 100644
> > index 00000000..e7460dd7
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/bad_user.te
> > @@ -0,0 +1,3 @@
> > +module bad_user 1.0;
> > +
> > +user bad_user_u garbage_token;
>
> You might have missed my earlier comment, but again:
> this fails NOT on "garbage_token" but on "user" because of
> the lack of any "requires" block to meet the grammar
> requirement for avrule_decls. Is that intentional?

Also, you didn't fix the CI breakage in this first patch, only the
second - it would be better if you could ensure each patch passes CI
on its own.
