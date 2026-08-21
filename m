Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FB4772B9
	for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316969; cv=pass; b=E9OV8Bds5N9gWPBz07Qh99NamfxrrcwXDaehsijFzjWyO2p5PakV+JVlq3MKJtxzU8nYOjSUz1Jvzm+wcegEUnmiu5U8OQzD01kaOUSIlAn9l3waYa0/IEqcjFrDgIoYDNCb5JPXPREXOswHrAFmviXLiVghmL5dWatKzbwK/ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316969; c=relaxed/simple;
	bh=SzuHjvdWq8CCZaSBnu4VjPyWD8SDfkM97X1K/OBblro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sqz1PCoccPAYNfD3IyM02CG+TsOceF987drG8yaOXEMtNkyAkK+ymbEsFyWXI7Y/GE7W3yXqBKtev90zFXL5ee76qGFDPtdab4xN9+qP9ScOIhJxCi/ydsvlBBDhtbg8m+ZgVhzQo2ks+qysGLsmR0vOUGAd9S9UO7LvhhQP5VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwGQyh67; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwGQyh67"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-45eddb6fdccso500317fac.2
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 05:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787316967; cv=none;
        d=google.com; s=arc-20260327;
        b=aBdyDD/LEA3rbNI8ekJw2PLeGzMo5kxvTnDe9J8FJneMQ6zfz4t6/nxSBXPQi5wBJo
         20E58J7+/TOaLtj8FMe4c7B+/6CvT/MujPoelb9zxx/Ww7lGg8hQubEWRH/UXgUrMNO+
         +Jl84BohawH03/0MSlM1IZXXkVO034WbHVhphd7KZD8Gb584Uu7cpEQ8AIGTQA8baFX5
         aw6XAbHsGPIl4sulxms9IgdPpkAfCC5E8NEwbOJbF7DFZ9QrpL4CVw20/oS87TmNRf1N
         RcwgdAAXouhG3pGNSHkYeqRSw4fPck1f069uDULrFTXqOFPBcajGEz+SrfCvRzxFYcqn
         TjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kF0FF1eWEfu+g0VJm0ha6u/MjnOmbPllfioeVvNqQRI=;
        fh=zfDUEDhb3Au3NJI3MrDnWhPolJWjYyhfJ7v/XOCD7XQ=;
        b=ZTEq4NIYhKBetBcl/wYjT5weRv94VMFQMtXFAJ9VH3x0Yu24vnBnmmvFwVXAjYZNOI
         WClQ99lb/mqUWEZG2Gx2pdawrvL3HLTfFbZ0Yt3UNQ6BEFK3Yyd5SXkXNQa3WN7VgD5P
         iwJX4KwX44Y9YHK5Ou+dhgtEW/zsykqeZ6/IkPaqgAc+K46nNmDbbtqdfFnyLGWMLKwQ
         +29R57R5WX2gpTkCZSazmdjpHLmqGsfwAJKkyGay99zp5K8Bb3f0FpmEDQP5fkWSGuVq
         oUaUXqA6WDRtU+FxSBGana4sHi7A1fm0wqBJoeAfOZmpManOjR4tO1XMsdyuZPs+bCOU
         TjNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787316967; x=1787921767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kF0FF1eWEfu+g0VJm0ha6u/MjnOmbPllfioeVvNqQRI=;
        b=UwGQyh67RiUaM2YS2CzoeeWMafG3MWx0Zh6fm5drJo1LlofLDJus9ZC1TnHn4zyBcm
         kNjtMzEoWhf39/KeAPWeVVxLksv5rgo8lChbtL8xvXRK8PwgEO9F1uqh2IJUiHJtTcPa
         hQaih8LlupAXQh4Lm4XBBza5fhU/UsJhAmP/WuzlHvCYSW/0PuQ5Pw3iAYxR4YDi16M4
         Axsc+00hAnNdAhzbCNVzzMP4r8THTVvOHYpZ4HQN9W8cqLYf3UgkpzfuvTuoZKkWG7Rz
         PB2mBzi8RLRFgi7MbneACculjUni14Si8pA8wZ6d+QQ/xLtR4UGuCfxISQ1LW1IJ6MDp
         lJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316967; x=1787921767;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kF0FF1eWEfu+g0VJm0ha6u/MjnOmbPllfioeVvNqQRI=;
        b=GrbE3sqXJi3NoVpUVlR+JZ5AiJFnmw5UocymDiIAJrgpidvrXZlUyMch2OqU/tXG5Q
         mpMge6R63r+2jIiwjFZCjCM0ZK/PmCvPV4Nar9BOUMKoDWxK0Bi84hAPCKJtwNjqbPHp
         qFJkFSB+1ikk7Anto+N0d1Qtd8QEX7v78JpvYa98H6BHtywvndoxf5p5SqwtDT3g78km
         vZXJXTE00iYJaj1h5mr/VggrEQlfLdP/Us1VtqmbGdFsdpEpQB9xI9tUN5e0I5Iprian
         rw3DdqrShun0ZfTfHSZzsLutKkKLV4kj8MwkQdoia/sQSeKt6/SOLA/tdIzwdnoebxpQ
         Rr6Q==
X-Gm-Message-State: AOJu0YzmDmIQxT4T4xZFKVcmHpuKaVA/LeQSTEVzd97j8ZVMSO8+RLCp
	/sg1rcCWjI1l89C5eOk6xsyvmNgwRXm1sQ4jMxmWv3L2CepX1ZZsB3afl6ix1WBuxrk7G3xUP99
	djwT5mHeRz6rZlQlC7NYjHycjizUf7Kg=
X-Gm-Gg: AR+sD12Ex6bnuab+3q8xRlW9lslkQAle07f7MLQKEEEVBLGFpsxAtykQpdYN57AFCtU
	lPxirDzuAC1lFl3oYYN2aS2WZGzQGh3BSuFNT2jZ9zKGJ2gAzu3gvNxmjTlHZ5d3as5EaTgRFRe
	JooP1ftsbDbpB2iukxhkIOecgdTwRXgd5UNTaMAc4GeD0OHEE7NQAhibYpodV3yODXni/leHBhz
	AJsqtbhCo3JXANlrjGL7k0F6Ohvlzqdzblh+9PkvOT1EKPU1ddZu7MU4p4vojuBWZV9B2glT2T5
	6VuGrCBoo74RnYX2cXp7jDERP2Bn5fwMjoamFeP+Sh+Elzq4NxKVi4U=
X-Received: by 2002:a05:6871:8011:b0:456:b249:700c with SMTP id
 586e51a60fabf-4635161085emr6695009fac.19.1787316967142; Fri, 21 Aug 2026
 05:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com>
In-Reply-To: <20260729131413.1390890-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Aug 2026 08:55:55 -0400
X-Gm-Features: AcwNN1W3Y4dCU9h3V1DqCziGY289z8KXjlGsQWqjV2fi0vTb53B6lkEhx3Fc264
Message-ID: <CAEjxPJ48Ov9pT6oZ6Q-OU5eJMObA1spPnFhdcKOOjmrSAD7pQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:40=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com> =
wrote:
>
> The PCRE2 interpreter is susceptible to catastrophic backtracking on
> crafted file context patterns or lookup keys. Since libselinux never
> called pcre2_jit_compile(3) or pcre2_jit_match(3), the JIT was
> available but unused, leaving the interpreter exposed on all platforms.
>
> Fix with two complementary mitigations:
>
> 1. Call pcre2_jit_compile() after every pattern compilation (including
>    mmap deserialization) to engage JIT for both complete and partial
>    matching. regex_match() now calls pcre2_jit_match() and falls back to
>    pcre2_match() only on PCRE2_ERROR_JIT_BADOPTION (JIT unavailable or
>    not compiled for the requested mode).
>
> 2. Create a shared pcre2_match_context with a backtrack step limit of
>    10 000 000 and pass it to both pcre2_jit_match() and the fallback
>    pcre2_match(). PCRE2_ERROR_MATCHLIMIT is treated as no-match to keep
>    the lookup safe rather than failing noisily. This bounds worst-case
>    matching time to milliseconds for any pattern/subject combination,
>    regardless of JIT availability.
>
> The vulnerability was reproduced and confirmed fixed on:
> - RHIVOS 2.0 / aarch64
> - RHEL 10.3 / x86_64
> - Fedora 44 / x86_64
>
> Reproducer (149 bytes, base64):
> AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8GCygKe=
AYG
> KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgonVy9XV=
3cy
> eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=3D
>
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>

It occurs to me belatedly that this change (which we already merged
along with several follow-ups)
likely triggers SELinux execmem checks on any process that uses
selabel_open(SELABEL_CTX_FILE,...)
due to the JIT compilation. Given that fact along with the fact that
we are still seeing cases [1] where
oss-fuzz can trigger stack smashing on pathological regexes and that
this was originally motivated by
concerns about such regexes and that the source of these regexes is
always trusted (root-only config,
and in the case of Android integrity-verified, I am starting to wonder
if this change is harmful rather than
beneficial. Open to others' thoughts. At the very least, I suspect
Android might want to disable this.

[1] https://lore.kernel.org/selinux/CAEjxPJ6-b4KmkgSgO7hXf+8ZGgRtR_JkS1ZQU-=
ULVk0aex5zCw@mail.gmail.com/T/#t
