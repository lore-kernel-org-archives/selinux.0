Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE423F8EC2
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983898; cv=pass; b=T4owRdFsow+ScLSlcTBqS5fHnIvWqIaBefwvXjfM0wgnS/deTcPAfHghCL/2+3ZGboAj7urxzBhitUCitfWLRwWKEmBErGU6YJtcRNDb9BrkRX5nnDCTe0l4xj23rI1GiXZcTOcuY38JX2agc1PEkgrc9IuuYGvhxjpkPRyyByo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983898; c=relaxed/simple;
	bh=f7gCgwi/d2c3JXJrct+fkAjPixmq8qHypBxPBqaHdE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0jOjtik1DtuHexuWtpNApaff9Kb51ipmxUbh0YPjgIZwqU9Fev4RdtpJrX4pHePHy/ScabV/Y+eBql0oWpFa/vgj+DlNYnk7cztcCXlNxgLWuU+Ssftox/C0BChzj7SXmiBBXewbmuXgcJOxWgObBF12zidUfK4TrYe/wWN+j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC/M9hub; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC/M9hub"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a746f9c092so17455634e87.1
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 08:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779983895; cv=none;
        d=google.com; s=arc-20240605;
        b=N8f7JbUnrxiHcOCG2Ajc1vMTlk3jwlYacle8wg+djuOKTPPPQsHKzSJGlV4jsfAoY2
         4L/TY2sZqMCXp7iwPUrHWQbKVWKYHgzzuqg9afBN+mEQyTRrso6jfMlM9gmUYdwI3+qZ
         uj7KJ1ewcoU22rIdHlgKayVfakW96TH7Za6Yftg5Pg69hMMc5ze8Ocdfr8e7DuAWJHsf
         yu2Ugr4bhuoL//M5qO7EaDzSb+VcSIpCPR20Wrcg+7sZ89un8NHIBRt0q8D8RKfQ2MLe
         mzB2kf6xjjeuqayy2s53FUtmYIJzHlARaxEy88tP27LviMjx3cpcA2F5VNh/jXPcIQ8v
         pbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ma9mop6Koxg00T7rMOZYeDtIo2Gze2rgqFJvzRoblys=;
        fh=2nUoOU645MPXhCEYZcWOzMsh1DNyGNyPl8ky1pzXhP8=;
        b=GIyc/anhiWKS6Q5Rv05THFTmduAtiwfJCuS3ZsR5S9w2rircd9LBFdnf7JZIvyjnaQ
         Ityql0qjrku06z1uWzIleYiB7wCxWCbhc4mIbi5ivPoWCO9cLduEHypAbaLKUjFjb8MY
         uMHQpnW9m3IFOsld6kLotRNVgfJbJ6vYBXy/xKJUO0UwxUek/gQjUfwMIB4noVorBXRw
         Emuljzz2pOt8OJWWa6qhY6iBJ8Ly7kaQ8ZaP2OlOnwUw4CsexI0bK3/BkPAUp1I8l90L
         DR8ruRMOoNEZct2B/kIKq+/sNgHBU9UIOJmGGRm646XjcQt8YmMDz4y7Ki6YGSVA+ied
         arGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779983895; x=1780588695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma9mop6Koxg00T7rMOZYeDtIo2Gze2rgqFJvzRoblys=;
        b=EC/M9hublqRJzefdX/dMfTdSbaiw98BpuJSyKE5//5yq9o9z7iKNwaxXb14a4RJKJM
         FmzGtUCbhRTaH8jHPdxR9CtEWuaBTIuULOLxiQ1LKZ1uABAnMNoR3YkVXZEy/mMBaSun
         te8mGB4LSsh5CXS6B8Z4tl8U+sp+KsvK+V1o6nikX7RW/Kdt2XNQXodOPeR/PQPs2Xiu
         muntV8819p84BTCUhA7Zc5ehvdjwwJajPaVVHo4f/6vstT7y9cNIbAms6yxpgq9Vypj/
         7FnlMe4BSGyLMMf6eZG5SJ7OikcbeMUvkPJIhe5FeMM4hXac3knJpaZK1E7DtiQuxEmZ
         Rkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983895; x=1780588695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ma9mop6Koxg00T7rMOZYeDtIo2Gze2rgqFJvzRoblys=;
        b=adSvIll/EWa6ObpanSbEEpN8vwN+1V1o72N00H9xiJcdYt8CWdsE9RSERTXcgx52p2
         gcK+SqIdGC7Hs4zDROvKFRi6W8LYrK5yydgw1D2KJsTRXvWlJCnScCVX7L/Ow0xpq+1Q
         +lPVPLLaC9tT0bK28aoptyWSCgxvdcXM2P4osLE8KBDBdbbmiNd9Az5MxixCVkYwW68a
         JTfliV9IUvGaGBzwfPObpWcbeNAG4hCZHdxMwIp9DuxFntaEFaQJz0OHj/Ur7j3RqVTI
         Py1E4bopTrTQIANxQEC231qaDifILPBuH9Dso7fi6TZGnfoz6Qinv/MzqAS0JJjy63tD
         WRHw==
X-Gm-Message-State: AOJu0YxIUKycEMg1lv87Ita5+5GXUEvTMK52gklzVSsItR5CHaQsiz3v
	iHHqc4EY6c2LiOsqJzpC1aB8v35xe4ET7+fQT7RjAjAQUjEJRqB2QRB0BUkkzxf7upH1n3buuiG
	k7vFydVWp6TF5GoxqGR0ye06F62ceh4E=
X-Gm-Gg: Acq92OERSdesOc6vqQd4kIVcynATgw6APMayrHupxKjPO2o9lM5+I6DJJuOdvE2lWri
	Gurty4mZuQYFaoLZn7buolNK1lahAlIrYANMPbz6rNczowrZLJHHwXh1r4SoOTJo1rxUbTVPQRm
	SExwrqCUrW97o5tHimFtUUVOK5i7VgcAjYP4gtf2w5XxWX62CNIrxCCGndTebj8Rh5O4mlykpNX
	fMFwPQioBQiRWej49R7h2XwMOvbIFrOLjdSHTmgjUusrNtUdZRI5b35IwHq++9e90L8VyTFflVd
	ipirblp2TVZZqnM=
X-Received: by 2002:a05:6512:ba9:b0:5a8:837a:2a98 with SMTP id
 2adb3069b0e04-5aa52de1dfemr795312e87.14.1779983895085; Thu, 28 May 2026
 08:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86ldd3k2kd.fsf@posteo.uk>
In-Reply-To: <86ldd3k2kd.fsf@posteo.uk>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 28 May 2026 11:58:03 -0400
X-Gm-Features: AVHnY4J4GcPkN4vZ6qBP6fmT4QEH2BB12lxleBDJNAgZWSQPVvlH9wXA0GefYjk
Message-ID: <CAP+JOzQe8Mr9X=mV263-g0dr4VKM2kpqKQ_X1bg+Es8oXoUZYw@mail.gmail.com>
Subject: Re: MRE: secilc and checkpolicy backend bugs
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 10:56=E2=80=AFAM Rahul Sandhu <nvraxn@posteo.uk> wr=
ote:
>
> Hi,
>
> I have stumbled across some bugs in secilc and the backend for emitting
> kernel policy language.
>
> secilc appears to miscount AV rules that collapse to nothing, so seinfo
> errors as the policy binary emitted by the compiler has no valid AV
> rules contained within.
>
> The backend for emitting kernel policy language used by secil2conf also
> seems to emit invalid allow statements when cil permissions collapse to
> nothing, something which is, at present, valid in CIL.
>
> Patches for both are to follow soon. However, I'm a little unsure about
> the semantics of allow rules that collapse to nothing: is there a
> usecase for them and should the compiler error or warn on them? I'm not
> sure if erroring, or at least doing so by default, is a good idea given
> backwards compatability concerns, but I think it may very well be
> reasonable to offer this as a warning.
>

It can happen when you allow an expression like in your reproducer. I
wouldn't consider it an error, but a warning seems like a good idea.
We specifically check for no permissions, so I am curious about what
is going on here.

> Please see a minimal reproducer below:
>

Thanks for the report and reproducer!
Jim

> rsandhu@carbon ~ $ cat repr.cil
> (user u)
> (userrange u lowlow)
> (userlevel u low)
> (userrole u r)
>
> (role r)
>
> (roletype r t)
>
> (type t)
>
> (sensitivity s0)
> (sensitivityorder (s0))
>
> (level low (s0))
> (levelrange lowlow (low low))
>
> (context context (u r t lowlow))
>
> (sid kernel)
> (sidorder (kernel))
> (sidcontext kernel context)
>
> (class foo (bar baz))
> (classorder (foo))
>
> (allow t self (foo (not (bar baz))))
> rsandhu@carbon ~ $ secilc repr.cil
> rsandhu@carbon ~ $ echo $?
> 0
> rsandhu@carbon ~ $ file policy.35
> policy.35: SE Linux policy v35 8 symbols 9 ocons
> rsandhu@carbon ~ $ seinfo policy.35
> Invalid policy: policy.35. A binary policy must be specified. (use e.g. p=
olicy.35 or sepolicy) Source policies are not supported.
> rsandhu@carbon ~ $ ~/Workspace/selinux/userspace/secilc/secil2conf repr.c=
il
> rsandhu@carbon ~ $ checkmodule policy.conf
> policy.conf:5:ERROR 'syntax error' at token '}' on line 5:
> type t;
> allow t self : foo { };
> checkmodule:  error(s) encountered while parsing configuration
> rsandhu@carbon ~ $ sesearch policy.35 -A
> Invalid policy: policy.35. A binary policy must be specified. (use e.g. p=
olicy.35 or sepolicy) Source policies are not supported.
>
> --
> Rahul Sandhu
>
