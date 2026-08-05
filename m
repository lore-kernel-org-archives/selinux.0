Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088E47143B
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936605; cv=pass; b=TxXFn2b4uvwNu8AcKven9F18FKOfw758fRXISD85b9NoGm7s+kItRwhvyD8Vn+En68FwHn08Em+SvjJ6zsKD6Puy1PAr0wPYdCo7ghKhkKYunvroJd7R9p0Gli0NoToYIRWeuRVivL4631bx5cQOYIh7hPWyVxsTFra6SMAe5mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936605; c=relaxed/simple;
	bh=fYArtiw7TEsB8vKJukfyinHeu7fRGN35p9LT7JZN6a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e238SLeSNZq2Ufo/IxQ1DbakqSxBctkqqSibkb4Z8pwV3Tcb9ONn1wCRyYqma34mvyBwjAOSec2HMimBPZeWqDetNtCd5HMLRF2yJXUFC+Jzlw9f4tx3BtiaSnmklW3PP05s+AxDPfGJlMC4TpptW+BUik+TQbUrGevcpPuILUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM5w1S0d; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM5w1S0d"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4513435cdd2so391810fac.2
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 06:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785936602; cv=none;
        d=google.com; s=arc-20260327;
        b=Z4djhhwG3ChRmDfVj+2FOzF6/dDRzk11t8SeiB6NKclVW1MoWYDNK3jDyTkZpVrI65
         4ebSN44DfAdDFmAgCnQ2LbjQkIu1dMiDqDDezw1+oiJC9RHN0v18+DgpkbQQ+jxTD+YK
         XTzQG4k/SYyBub6WIdWQV7I6APKSwL2Pwj4/kINuC79f5IlWjtxgrPGNDWUftbltZiBD
         nhdnHkcmuAMIpuHmxnFIMNWJfic5mzHHFim7eOe/EPlZUq3zZENFfpfmCNOdwGViFH7O
         5enbOBpDwLzePXqfa15CeRxGuTYw2h+5ZKtQAayXzI7IT6jO7MCTxqV0B1H06BLCTW5O
         c+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vr+E4uZld/n/23iLHC8LSWADAElSqhxOUKjl5AIWZFo=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=pEup1N37HJGKndtBcWhaTEgMVokCUKq92EZZ0cP385DZobN8gBuat5QbPCB/6PKW9k
         Kj18bkWIPGtkI4kj5keXPpEI9UF93urbaUj0oBtSX9TU4RP9kgH8kNuSaf99cCXDRQln
         KH7ZlLrtUP3nTt3BlXClS73KcNxFEvB47AODJqWzjICGNIdaz0J5FWdrVPcE9Z4OpCzM
         ePWcE/imo3/q5YSjlRuL3qiAADat8r3JmS734Z7dScupVQ+akQHsNN9CPJ2f59678MQ/
         6NctMP6y99a5yxHDrwTs0kmoJo8klGouQ4iuumHFxkJ1TF4+Xrwa+bGl23TzcTJooEDw
         TfKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785936602; x=1786541402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vr+E4uZld/n/23iLHC8LSWADAElSqhxOUKjl5AIWZFo=;
        b=RM5w1S0df02mFkaLkPZfHV7StqRixhjyKO9+M9XhMQBNqz8NR5WIU1JLPRCA58OfwK
         2gNpHiv0yKNEskRCaSdrgey65t3EbZGW/Y6tWoWKiCCU8qFwqVlm2jei4bQrTjnnSQdq
         o7arWZk2o6wRj4a29AfJI1EZUdt4RxA0ArtK5Z5XbCxqwnx0Yh8mQbF0eeJyEoZr1rfX
         v6A905yBOlHa8eVzJ4ZoKHAzozcaSoa9/Xjgbu+qfRfWgBUiVcuQDD/wnROzNiWofLbK
         ZmwUGsNTf/kHB8XpMmdl1sktY6qnfNiQpn2WGaDNtTiGwFQ0tbUlgKA6snbNvxkfYu20
         GUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785936602; x=1786541402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vr+E4uZld/n/23iLHC8LSWADAElSqhxOUKjl5AIWZFo=;
        b=jV4hyTIA7unfgOY45FUA4PsEzy75Qnmv8a75V0iUWuObZBMVRGFKVyTwClqZPj+cyl
         ewyyZICx8tVRXeh29EeAhxyFLsqds1HDXCPnI/lwa9OTRIEqqJKmHwUxnUAKedTReXEY
         SGI7o4c5mB8jOMP/XJp5KWLhP49yyixdVUBblrGDOGFhHR07FC6XyciQYJ/8K/xdfIaU
         lgIJCq31Kdv6eBrEfd6VeVdRKs6Yl0yW4DEw8+IsXXZFigcQYTEIzImLDQalX0hDE2XX
         q3ED+T1xlCNK2Vs/1LUzR2DnBDO1XO9j2ORwLI8GjkYU8+kIC2scGamXvHrYm5GtcFQx
         vlaQ==
X-Gm-Message-State: AOJu0YxzhyjZoe9fDuUuvuXGUYKQGi6jeTq+uifWkXEO7hgE79u7aTSA
	25VmCwcr0J2BYAoa0YgSBWbYy8EMg1jKIyA6ue0r/76SKhlUUFJVtl4UoNEHTh0JxLZ5LPpOG9E
	aVj8TAerUSxH6frxdWVdR04u35mjrrKc=
X-Gm-Gg: AR+sD122j5NHoe2YZCSZZqyqNTY9yiazK+LKyf7KZHpvzws4yzLUTtonIqmyteztmfX
	qACRelrIPDiwn/OfnRh3CKcO/u4WfQmkwgPMb/tjzXc9O5TAgn0688Lu6e5BRPR7ntPip/WnuaA
	1SLrOFPJBlbiw+oInG9FvFffCTv5ROLX5Ot6T/Rp4UO1lJ0EGxE22Yta9n2q+t+RRgxevCwFL3W
	YhLcDhKitYUgvrsnUjshC6gPyDdJ0yQXxTxWmAxBKJ4aHMIl0bb3XP1zNNm6RTn/CiU3ODGtgW+
	f3FPr4p0o1RQHMxa8rCYVO+v+cVR8/KtXda6SAj4yKmpcQ==
X-Received: by 2002:a05:6820:1c89:b0:6a3:92f8:96ab with SMTP id
 006d021491bc7-6ae96c17c48mr3223251eaf.1.1785936602290; Wed, 05 Aug 2026
 06:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805101817.2195037-1-pmatyas@redhat.com>
In-Reply-To: <20260805101817.2195037-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 09:29:51 -0400
X-Gm-Features: AUfX_mzgf_63-HsCyCaevblX0TegFuH7paBC19TGAtHjsTPEai4p1BB9XaO9a0k
Message-ID: <CAEjxPJ5-tmkUfL53LAtg9=2_LgcB3BB875D0T4JdW5K7c-AnCA@mail.gmail.com>
Subject: Re: [PATCH] scripts/oss-fuzz: build PCRE2 from source with sanitizer instrumentation
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:18=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com> w=
rote:
>
> The selabel_file fuzzers link against the system libpcre2, which is not
> instrumented when building with -fsanitize=3Dmemory.  MSan requires all
> libraries to be instrumented; uninstrumented libraries can produce false
> positives because their writes do not update the sanitizer's shadow memor=
y.
>
> In practice this causes a spurious use-of-uninitialized-value report:
> pcre2_compile() writes literal character bytes via direct assignment (not
> through memset/memcpy), so MSan's shadow memory does not reflect those
> writes.  pcre2_jit_compile() then calls memcmp() in detect_repeat() over
> compiled bytecode containing those character bytes, and MSan flags the
> comparison as reading uninitialized memory.
>
> The PCRE2 maintainers confirmed this is a false positive per MSan
> documentation and declined to change the library [1].
>
> Fix by building PCRE2 from source with the same -fsanitize=3D flags as th=
e
> rest of the fuzzer build.  With instrumentation, all pcre2_compile()
> writes are tracked, detect_repeat()'s memcmp() sees properly initialized
> bytes, and the false positive disappears.  Both selabel_file fuzzers are
> now linked against the resulting static libpcre2-8.a from DESTDIR instead
> of the system shared library.
>
> [1] https://github.com/KwisatzHaderach/pcre2/pull/1
>
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
