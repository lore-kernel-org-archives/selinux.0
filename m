Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12874447807
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019257; cv=pass; b=U7ntXMt5Hx70Gerj0DgYCcUAlIQwVrZJEi5fMc5xnaTjUBVl0Nb5PF39cMKlpGQDRjmihPW9U0lFzUdwuhe7tzkX1eF9kHQyrjIB5Dtjt1rN23UJ77QyPKYnOE1/hD2/mAnMkTrtEAmk/tc4KUnhIx8//cR7MCIYgQnyh+dQ7AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019257; c=relaxed/simple;
	bh=Kugym0YvilalSCIXnJnUawX32PNtHzgiRK4R5BSrxBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyjHDrVGGh+si6np1dlep3VuqWzQ2FAuJ54QLgyq0sHtJ8FRWFxiKTTkkaSY1VSWqpy9kwYBiaihfAmzAXTGg2gyHBAygyCVyRLiA7hiXiAuMZWBuQZsUNv1h8bQvulwGgDCNeW07udKCbAae50mtg2pBy/uPiriF1oGaCGoja8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZd8TvQg; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZd8TvQg"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb63dbd229so653288a34.1
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 05:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786019255; cv=none;
        d=google.com; s=arc-20260327;
        b=Sbaixu8h3hjWYNHg7Qk2erxjKVUqA5Srhvg4gjyeaGAmuwAH3oFtQfOhv2A1gtmzlv
         xkcoX4+Q300oFhWO4eKS3rWsbkCp/URvHIUvk8MwDPfbfX2zucdsjZLXT0EqBpTh6gXo
         7lYTWTbZ5t7IL+oDHeTBS1XfEIWiMNNcEfcJqvOxQhP3WACV/Hi8Ecztwv3xOmVyD+CN
         U6w+sNCqZH+CMbMTTnRLyGig9tz8Wcbs9nXkFV2DIGnbvpFF7/YGK5ctHcyHiCwkHorY
         tuOX1Y5JjCpo54y+WGkwYh449oH+OCvpIyz+FfHgFsLAT6mAGze0T/BNXW9Xeu2e4G3m
         Kg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PGLV4axFEtQvcLVBgHfhsvnUEG7mv0CuNXLx73QrF/I=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=BIeOfzeuklm3i6NPfVtqOTJDynOEvxGOEWQ+97oAjfmFqRQ/dQq+I6Rk0GHRJ1fGR9
         s1nQ5masG+YpgHtSoy/0tNmxMMjlwS/TkkL9YC3axfygxaCchWY5plTzqI7xFzorKRDR
         a3HKzGrIJOT2mh5v7krm7rDpB5Ap9NRg3EfHwFx0c4SQT4+h7JKZ6NTpqf9DWSQleyxn
         I57yqwnwIwQfc/E1FhDCbMnMUXY9ZN5PyZcC26dHRwiN61yGAP7XnfCjIknsOKOD+d5h
         Ua3SaL1065dEjvlQvie1J0unr86eGYaYGF0jeJ/cfFWazxnnVplgWqgk6q87HqJMvUSZ
         7uJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786019255; x=1786624055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PGLV4axFEtQvcLVBgHfhsvnUEG7mv0CuNXLx73QrF/I=;
        b=hZd8TvQgdVTC/7j0Fax2tNctqe7BEQMc/rnc8LLXtWCv04cXojjBKdH3AkywUJMDbC
         tWkllbhOFRkJSuD/hTwD3nMchfwDXS14OSc+4bkv/hnIQ1koRc3avrtSsIivk9NbfLYN
         s0/YgXn+i2xY1SAPArpPHE18XMRRdeQ1k0MJ9WTvSLdcMJYrC3VytDSuCqicYYnVnq2+
         BzJY/QSXUXXCv4mcMfLj5TOlUkmmkTOtXHwcmkLQmfrqbOEIqxXttwYNPpD1nBJ4bULo
         bGiL7CU07OkMzMS9oIrq1DTQTeKorrf/evO6sPLjVva4DjmSBBEGoMsYiUlFg6lfoL2U
         SYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786019255; x=1786624055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGLV4axFEtQvcLVBgHfhsvnUEG7mv0CuNXLx73QrF/I=;
        b=GzGJtUVE52XSCBTLaUi3oz/u8iP8tMVQ8xCxW12EtG9BXRZq8cptldcDbsQJa18/ty
         EQNoTv5GAxs1xdVPtErR70GrBp7T/gaO2iGxDlNLT/nGYDQ0oIiZmD2ZSnxJySYpQzzB
         BdVzCW75P3IBFiIzzgGlt2XNm8HhYH9uPKKh5lQbgQaSNiyjfFFdsLN1hb5m93cwMFBa
         89Tz+Ao6IJGnjwejXAqBQCdIov+FY1erdQqgMfoH9s17R1s84hr9iIpB2zpT2Negc5zc
         P/EhHBoAgFgp+28ntiHUybWlZE8WDCK5aHNNshY03MyywRayomV0KoSZ9EiyC58U0wAk
         iX3A==
X-Gm-Message-State: AOJu0YwvUkG86X5S847ZogtWyOQXDVeRGcn2EpwuGozXVOctH+sDKeFP
	XVAx6xPH712rirOGaIwe18zXBXleSceg5SerOBmWQeypQc9sacVELgJG4j7Z/xlh1YUQf8a1U8v
	Y0TmFrv2eL3GF4kvgDnRZiVXuLC0A5LM=
X-Gm-Gg: AR+sD10p0suuV1gq8z41X9k9FFaZmnLR5eyIe0ugJoKKlGqC7McnLYHBfDupE+Jk722
	VaZIgBDWRa9aTFZlI8MloFqXkONW94h1A9jZdWOtD7EN0oIgrTBtHU5kRPEmuvuFluT28XCqsQu
	iT5TpYB3Yw2TfUQQQ/hiCpEPIUrldRJpUjrmWbkDAbTgauVKnET1+TBESSJzizGWpBV/CQBdYLu
	x60gqKBwJYurdX+BtaVud1blfdAlD1CcelOJYIoxinTWbPHwPTveEjj36Bfw66oE1tCosJU26Yn
	PFtU9j0K8hWNyNID+kfIhQ/VYFirVEy1Z4qJJ0DE6Q3z0OEBOEvF23F+wrApVoKWqmU=
X-Received: by 2002:a05:6820:4cc1:b0:694:85da:3f92 with SMTP id
 006d021491bc7-6aeb24b4535mr3559717eaf.17.1786019254894; Thu, 06 Aug 2026
 05:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805101817.2195037-1-pmatyas@redhat.com> <CAEjxPJ5-tmkUfL53LAtg9=2_LgcB3BB875D0T4JdW5K7c-AnCA@mail.gmail.com>
 <CAEjxPJ4L9QL_HbQgtFOMxNo1RrOtaFXVjZUNGA0x=oKQ2uihcA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4L9QL_HbQgtFOMxNo1RrOtaFXVjZUNGA0x=oKQ2uihcA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 6 Aug 2026 08:27:23 -0400
X-Gm-Features: AUfX_mw71Q7SaFXbOeDnQ3wtGWy79WY1SxB8mtyGqlMnhyw_oEvOvw4gBX2kfhM
Message-ID: <CAEjxPJ4w8NHXYTuwr4=oz8yEhDf8LAwiTOwx_VhMGqX65q0BpQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/oss-fuzz: build PCRE2 from source with sanitizer instrumentation
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 12:17=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 5, 2026 at 9:29=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Aug 5, 2026 at 6:18=E2=80=AFAM Petr Matyas <p.matyas13@gmail.co=
m> wrote:
> > >
> > > The selabel_file fuzzers link against the system libpcre2, which is n=
ot
> > > instrumented when building with -fsanitize=3Dmemory.  MSan requires a=
ll
> > > libraries to be instrumented; uninstrumented libraries can produce fa=
lse
> > > positives because their writes do not update the sanitizer's shadow m=
emory.
> > >
> > > In practice this causes a spurious use-of-uninitialized-value report:
> > > pcre2_compile() writes literal character bytes via direct assignment =
(not
> > > through memset/memcpy), so MSan's shadow memory does not reflect thos=
e
> > > writes.  pcre2_jit_compile() then calls memcmp() in detect_repeat() o=
ver
> > > compiled bytecode containing those character bytes, and MSan flags th=
e
> > > comparison as reading uninitialized memory.
> > >
> > > The PCRE2 maintainers confirmed this is a false positive per MSan
> > > documentation and declined to change the library [1].
> > >
> > > Fix by building PCRE2 from source with the same -fsanitize=3D flags a=
s the
> > > rest of the fuzzer build.  With instrumentation, all pcre2_compile()
> > > writes are tracked, detect_repeat()'s memcmp() sees properly initiali=
zed
> > > bytes, and the false positive disappears.  Both selabel_file fuzzers =
are
> > > now linked against the resulting static libpcre2-8.a from DESTDIR ins=
tead
> > > of the system shared library.
> > >
> > > [1] https://github.com/KwisatzHaderach/pcre2/pull/1
> > >
> > > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Merged.

This resolved the issue with oss-fuzz. Thank you for investigating and
fixing it!
