Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AD38AC7B
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340283; cv=pass; b=G252DFQfYvyMMtQ5d3R40eKkm67wliD7lchLEle6PV0dmWX6E7Z9IZ04vta80osktt6omEetkDuf14MboU/YMLWYR8BVZZ3ySptvCMi3plt98vk+Y3TYlVw5faK+hfTLnZTJ2C1/U8URgmMDnHMaL+aj4CkKGsGDVthHFWiTHo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340283; c=relaxed/simple;
	bh=lV2QUTGQqHeKuWWf8BTWL3Ps2zo/YsZ7dA0AJyCQdy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsbqUNg1bh9QtK0qPadsh7fuPTpY9xIzDoxSIL55/C0J2UcudSrS/5uAfRO8bkaXD0UU6ov+8oT3s49q+wNcw6iyogLsyguTkfmvkLHHFhPl1uUP2q3nQ0j2xrxNWjNULFXMAxgAIgzWKwqg/fUhAroi8Sx6qXAO/7FsmXMUzL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgur0Mgv; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgur0Mgv"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-44caeb973b3so869581fac.1
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 08:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785340281; cv=none;
        d=google.com; s=arc-20260327;
        b=oqKQdazrK50uYvBPOFL7oTl5y8d0BZL3lgF7bkTF8aP3pxnDv1u47mCRRyuDBmCFaU
         8S+miNFJ1uS/LYXu0YR1Q5L5fF1O079GtRaAodGBMNTvxSntlS8zUITjVz979gdpa9RJ
         BF+RBJamecaB+012IUkLZwvdxEFFUs/QqIkZkDqxop17iNFoow1rXFoA5cQ9I6eZIZzg
         ekTm6UrqawvUOC5PFGD/704iQDUW/kycugeMuA47Dgsy9ZaGAt1OBZPNahl3+Ng3sLxf
         Wl7caxr06DpKmTHEYvo6byKfn5gHhq1Bk3f7H47H8bkhOp8CrsLxQDyKI9JdZ/5lMK/o
         CJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ChWJXmagMyuIamHgKDmglZLSbL566kdihy1k4a9gym0=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=QC+VN20uXHENkXXKDPJGBnTJPuDRHjcIzcKQnyTXlIzOO9JtnLD1saPSi/q45mfbto
         tTPe6nbBPHdrYBUCxHOSOUOH7JrtZwf7JqXT3Uu4lgskOTCM7BgDbzu82SYquz3E9j9x
         W7hjDvXBwylzK1tGD8OlXRBR+uAZcVfPMcgTMZf7NtZyOxCJ2/lcXwNQ4KdEPsE28kk3
         qZcS9/f+uhMVfYaWnnoXjL5Vh14va2eAE8VgLI77JLEeaOoe7EfdP5uKo30TZK/DCGy6
         Xshln16s7XRYl2h7ILhcHXPq9gfdDYb+KoimswBnh2y2jefVMKzT8vpIdzLR1Nla8GRA
         2vow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785340281; x=1785945081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ChWJXmagMyuIamHgKDmglZLSbL566kdihy1k4a9gym0=;
        b=Dgur0MgvVIAfHEt7xiSJNVWcvpfpawb5iBMDa+oblom2O1Jl+2b5/g+BSEsmU9bqzx
         DAonJBRr3mggsqwQHf3packvZRQ2Li2xZlQ4ia0eyCyGtMzQ7EQzT45TZpcdlhrhgZUk
         dBHXMyqy736ma8zUOKUk15AtLY3uQXxJOG1zT7HXokTVUYWLqNbggyH55hHNOCLmm+zg
         hleFLzvH7U++XakDZ963FRkDtx8+QYuCb64C+1gRVd11GxGA7WXwf1Kq5qMsgr1urtqF
         4czAi+Z4jM8TmVtyLuzd9pqlNZkl10W+AJFxj854YeIcdrKEkvU585jG6HQeDkP87mIo
         Cbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340281; x=1785945081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChWJXmagMyuIamHgKDmglZLSbL566kdihy1k4a9gym0=;
        b=dIZFWcwjFQuoQ7GKCffbItsTYya9sxLkkveQqnhj2dZpKBCD+tCv1frgsK2nyA+heC
         PLA3SOg3lkL9z06A1c6DgRJgogRNTYR2Qn6csa2oJU4iCLur9zrmBHbJt3a8gS9YJ6os
         cIH981ZzSGmE+sSUY1EGdDQLeUjxLESUHSeIpbMjmSh2TBKpylWhpt73o0YCeTUX7Mui
         m61yX/CoiTRN1dNHzF0NgFgpQX1zVOTKdZqydDLaBzffKmpAY4VP7XHe/9JLoU4uVBcl
         3hev2onz0ycCrmS9M2AQ8EEOqbv/FJZiDZFG9vw22zTeUsubJZr8ozcJ+d7fP+o0za5I
         6FBg==
X-Gm-Message-State: AOJu0YyfdhGl9nrJ4uSvbfnVjmWQmkyV7c/Tsd8pbZO12MmSrb55K5uO
	PJVYtRT3QEn+d7BZktDrASe7eBrGelwSB+nA8tFkBtY8Wtu3s6yLpvuahtRiG7B370V2ZKLG+7B
	lpq4Jve2IH+GupMZLb8yIi8Xz9BqXcto=
X-Gm-Gg: AR+sD10kmuqIsEJd19cwwGmXoRY3aX3Zdl9MLkQOhVOJpJxZd2JAyV7QuuYJsqNYlkt
	jzdi5wRLcsOHwMfrlO1ivsN8i/nE4BwIytfg9u28ZE9UG3hugW6aGyVuELz2LNmQJCqVwcEtK8+
	qWGrJ3WiQF/HRzAQdcTFFhxmGIt9S2RW3waRz8GcX3O7MMHNW6K45+Zn0V2Su1oalOG0zguA/Uj
	PVNcBR8DmE9BqRhW97Cp06vrcDTR2opPvOyBmedkySksiUWi43bic1SttmAms3CjNA91rGXLIxB
	kpW/H2fSgAoEEoQOmXzWrJlT9C+5AXZIAh2ahh3SV93e
X-Received: by 2002:a05:6870:31a9:b0:455:e2d8:179b with SMTP id
 586e51a60fabf-4586c6a752fmr3978956fac.7.1785340281248; Wed, 29 Jul 2026
 08:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com>
In-Reply-To: <20260729131413.1390890-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 11:51:10 -0400
X-Gm-Features: AUfX_mw23gWZeshKGWIAGWmjjpgVCLxVrQXWpnKSvVMd7nrJVZM6spDfh2Pepqc
Message-ID: <CAEjxPJ5Cd422TFMiXNow=m1LOwZL_gwpLXd9u=JgNYWbszwU=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
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

Thanks for the report and patch. Given that file_contexts* is
root-owned and the caller provides the paths
to lookup, this is only self-DoS. Will fix but don't think it warrants
a security advisory; let us know if you
think differently. See below though for one comment on the code.

> ---
> @@ -262,9 +289,15 @@ int regex_match(struct regex_data *regex, char const=
 *subject, int partial)
>                         return REGEX_ERROR;
>         }
>
> -       rc =3D pcre2_match(regex->regex, (PCRE2_SPTR)subject,
> -                        PCRE2_ZERO_TERMINATED, 0,
> -                        partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NU=
LL);
> +       rc =3D pcre2_jit_match(regex->regex, (PCRE2_SPTR)subject,
> +                            PCRE2_ZERO_TERMINATED, 0,
> +                            partial ? PCRE2_PARTIAL_SOFT : 0, match_data=
,
> +                            match_context);
> +       if (rc =3D=3D PCRE2_ERROR_JIT_BADOPTION)
> +               rc =3D pcre2_match(regex->regex, (PCRE2_SPTR)subject,
> +                                PCRE2_ZERO_TERMINATED, 0,
> +                                partial ? PCRE2_PARTIAL_SOFT : 0, match_=
data,
> +                                match_context);

You only fall back to pcre2_match() on PCRE2_ERROR_JIT_BADOPTION, so
if we hit PCRE2_ERROR_JIT_STACKLIMIT
the lookup will fail rather than falling back to interpreted.
