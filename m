Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D54570C4
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946683; cv=pass; b=ZZl2w++n+CTTx0eNwLV0Y4L8YzHPgyqMX+eA2z1OM8mudVKAp1DK8C+LlLZAoFehZHKuvXI0J6NtYCNjnqUyrygl9n1HSLUqM4r92579QzC7sVnjVJGxSFvCxdId25/WiUrdWNWPJkCPFwxzWLs/jSMs5t/aRyB2XmxYM1bSlAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946683; c=relaxed/simple;
	bh=t/mFFYx30c/RJsgkhUokpsCP6D6/iwwYVThcpxDJhe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nx6J8pSpFz0aTT5KjY/UXg6Nj4eMQnSgCDeZPD7Mz/zTuEbVMSbcs4tcJN7Ew6mmdWbLRDLWFyJVlEOzOL8Frd+ihf5a0LENcjI3trNJcTq0zixLQPhGBHBbDSCG5M9Y9jW1rwiUThiwIX2MBxUlPDnLJoL6OGHhOT6OlYRnt8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYoJh4zF; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYoJh4zF"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44cedfaab6bso616065fac.3
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 09:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785946680; cv=none;
        d=google.com; s=arc-20260327;
        b=CKQ6WXqeTDQMTIbxKqGFNmz2VrG1c+fWuvFCuQZ/vrnWDA3QQ8E5ds4i4ukgQD4MVr
         U3dRpZiMJMTf65vRols7PIfBlsmVoZ+DGfVAznp28d94Qn0ckRWBiPNmXiqhHNRtMhpV
         hGf4AE9vpN7F0VsOSV118epDsSLB4dboAhin1RLmlNlYRnzA0iQFXNOxAqMsRCOWvk22
         QYE3et1OiBVZc3nmC3kvDh2mH/bX4/pNKVecNUVZK/zeoWBx+9vTgTc89ico0+DRpsld
         FZv0j0AekcJxXMSLusWrWxHfPOBulCSiHyX4RnASriznt6GofF7FLchkBSjjW1TokFKL
         72Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FN+nh1teMzSNSbRI9XJADeHkkGD53TNIFSldM32VwdY=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=i6XwTfmQhyOCLMigvp7hrlbyBODs0tvr/jxHJWfxrDzxK4LAhrfyZ51Q3sQsgl6n9z
         KAZ5nfn/b9chrWIyAicQBRm/0f8VRTKauDk/FOq9K/v3mdTPao9rA+57E5YBY84QAB1z
         nZGDXYSnOoh+GzKKVnezdkcxwQeWExTbRCo3YHSpmqk7ywvC1iit0uM43vTtZuqwi3s3
         bJC3Zm50Wy7nkAMVKIrHt/myb7FYqXXwCioJRO7acPtjUWXt0rjkqKkytA8A13nH7zV4
         oEMzayWdF+bemKGsRBr9Gfn+W/PVa8PuW7SSMzdBXpQPSom0E/HrlFSlP6TX8qMDeaEF
         vg4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946680; x=1786551480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FN+nh1teMzSNSbRI9XJADeHkkGD53TNIFSldM32VwdY=;
        b=GYoJh4zFx62JIInkzSZQK68NKpnxtTnbBc5UNLF0Ap9lXL/lUpp7FxFQhNz4m0MHPB
         Bu2H5vC4w2y+viv/dwSNpG3Y0LJrJufand2XbpDk1EfO8WzfLq8usoq0WyXWpig6AT7k
         NYZghkKqvFxCJKW0SWxujvB2U650FG2sF9Bj5r8zDmowWOXZuCWhKHgdWcSSFthDv2YF
         D+RNyFu0U1B0ZM3wndY7wWd+8LzKYhQQhtZ6cbrDChKHAQyuwk8gKMjnllJgJPnMY8MN
         Dj2NnNTJPzcRgP4r61XD2U685su0hoZJt62nAi1c1Y0vAGVau65/z9ouH5nRB6pIlZ/f
         Yl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946680; x=1786551480;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FN+nh1teMzSNSbRI9XJADeHkkGD53TNIFSldM32VwdY=;
        b=QiOm3I7kDtXYHO55u1MvBZsNmAzqC+PSf8nK1gwHi3gbmz03yvUUjr2Ji2CUq9rKm8
         +YXs7w87IB5WRCiGUeTeLMYBdRlcJT4dOdJOIp8fXoh/qHr/ufKDG5k00x0wPBIorN0Q
         y6l6AwKSlVSfLn3gJTFAwHLqSO71TLuFuc5cX3qxsNqVo1pxFHjpqVNMInJ8dkwHWShA
         13dAraj0p5h97A5kJgsw2DZ9BGggH4YN0fqZCfILYBdlbdnmie7QJNADNimtEWMy1sTH
         4OtKaGE+1I2jLbfdX25hTonBQPwCqviuAAZNNazqX5h8VEVEdU0rmHO80r0k6b7mDk5D
         W5qw==
X-Gm-Message-State: AOJu0YwpuAuZXcgLCyIo9o/H+kb0KFzBLbCIwdOHMxHEWty6XQKNJAUx
	Blc/FD4/AmywLJOrSUTb3oGaqGvBf5MYRdIkRNAmWMvE7fZvFDwLUpIzlwd9rb0Br5M1TlNCttj
	/T5MTZlYdADN78i2zmFvUyxDOxmYSnhY=
X-Gm-Gg: AR+sD13Br6VZkqkEEYN+am5i8xKJ2BhmVayId6ghSKPWcClMtO3FZXyVMDENFyrT3XP
	OSMpjNtnaSJIoiW4iSCPCPPyv2e6syapzZXBwzlRd6DerqF1C+bHcbUGa/E66LKgYeWfHNcq0b5
	X+gY8+r4dHQnAei6WRhNW3QRdlDCssbsrqFQQGziApGxMbwyjvxqol5Ly7P30OFf2lxQlnY1ZzO
	vKmXWJgb8meRPazWHKUlZhGKs6pV8T1T6v68bKIHg58Mz6DJxDqHl637hFm2qkU44rFbGAsWWpP
	vW+XFYMfjzVHZdMjUlI0LDm0M1UwqTfRdCuQQt9tlJ0C
X-Received: by 2002:a05:6870:3912:b0:456:3830:2d97 with SMTP id
 586e51a60fabf-4599ecaa717mr3907509fac.2.1785946680497; Wed, 05 Aug 2026
 09:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805101817.2195037-1-pmatyas@redhat.com> <CAEjxPJ5-tmkUfL53LAtg9=2_LgcB3BB875D0T4JdW5K7c-AnCA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5-tmkUfL53LAtg9=2_LgcB3BB875D0T4JdW5K7c-AnCA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 12:17:49 -0400
X-Gm-Features: AUfX_mwz_clJ6JwUnZ9Zu4Hj0X5K_ObdsI67vOJTI6JJhb3GOkYdrG6BzdBzvfI
Message-ID: <CAEjxPJ4L9QL_HbQgtFOMxNo1RrOtaFXVjZUNGA0x=oKQ2uihcA@mail.gmail.com>
Subject: Re: [PATCH] scripts/oss-fuzz: build PCRE2 from source with sanitizer instrumentation
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:29=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 5, 2026 at 6:18=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com>=
 wrote:
> >
> > The selabel_file fuzzers link against the system libpcre2, which is not
> > instrumented when building with -fsanitize=3Dmemory.  MSan requires all
> > libraries to be instrumented; uninstrumented libraries can produce fals=
e
> > positives because their writes do not update the sanitizer's shadow mem=
ory.
> >
> > In practice this causes a spurious use-of-uninitialized-value report:
> > pcre2_compile() writes literal character bytes via direct assignment (n=
ot
> > through memset/memcpy), so MSan's shadow memory does not reflect those
> > writes.  pcre2_jit_compile() then calls memcmp() in detect_repeat() ove=
r
> > compiled bytecode containing those character bytes, and MSan flags the
> > comparison as reading uninitialized memory.
> >
> > The PCRE2 maintainers confirmed this is a false positive per MSan
> > documentation and declined to change the library [1].
> >
> > Fix by building PCRE2 from source with the same -fsanitize=3D flags as =
the
> > rest of the fuzzer build.  With instrumentation, all pcre2_compile()
> > writes are tracked, detect_repeat()'s memcmp() sees properly initialize=
d
> > bytes, and the false positive disappears.  Both selabel_file fuzzers ar=
e
> > now linked against the resulting static libpcre2-8.a from DESTDIR inste=
ad
> > of the system shared library.
> >
> > [1] https://github.com/KwisatzHaderach/pcre2/pull/1
> >
> > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
