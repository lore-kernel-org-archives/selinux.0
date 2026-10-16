Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044F4E06CB
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161917; cv=pass; b=utXbrlvDPC+UuRx8cUDM6UCXJAehAMEmCmtwKb7/EIZ2MGduvgQM0piQjpWEeKBdeNycpuyN78x0seHymx5UcE2JpCNdpWCbYW+XeuGGiXPkoSR6oLe+U0hUxjCFlDNtT6Zv0l0EXoaAyk2YKYTDzEt7C04PJf2mGwYccr+FcqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161917; c=relaxed/simple;
	bh=drmxJ/IrDX3kMCfCLYuFNUE9kPUpZ33JeHbIW8lcaRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxdfPqd8wMQmDb3YjTui+ep5wnRM4FIuGg9+FdyEN0eV7tC4BZ172frGGYjimXs7OXhQE9Z4l7KArfJhp8P7vx+v4AOhWCVeySBz0yz5dq0aQ2EPT7EZrg3jLg9J/CrngVPQ7GmEq7QBUDA1LisKt+Pyq6qARK/Vd5kC9KDUULc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgy8D6Hx; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgy8D6Hx"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab432273c5so59576677b3.3
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 07:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161915; cv=none;
        d=google.com; s=arc-20260327;
        b=poimu6u/i6iNYaJoT5AFScNbc2vC3gDrZfiu9juXJKSo/Exz31adflMaFpsuQU8lpA
         19JAO0GIbPZk574Ze9uHtx4M7eEasmDYAYLzG8RXQxKkus2LUz+j5cUQ6wGeWJOwlUzM
         KtiqGxkQC2bUgZaTGlLU2Nc06ibGZG+o8yDDYMmaKC96/4IKAa6YhvEFAfnOfmfsFsQH
         BgWvIqq6E/zILVuOfb6+cm5WCEREm47PY1ENGa1eZkWHttedYlkyY6YToquTgPRzUXN6
         5eMdFZ9V4rbjHO6nVB12tN6R9Q6T9cCr2IdICX11Cv3B9iObomMPX6vpRelNJv4aE7ZD
         q/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drmxJ/IrDX3kMCfCLYuFNUE9kPUpZ33JeHbIW8lcaRI=;
        fh=gBydrNMvjriJbd9HrIy1Xz3jsVrETImIXW7v+LTQWN8=;
        b=iG3lflgtvgMXq1D8MElsKEvVb4sxVeRf2tj5WiItpntHWIfO7fxt78Zevx0JywaifF
         wlznTWuPTujoxjC5cVAoFILpgrfYFL6QfVa2OcqKT2nm+qNJ9hqrW9uC3wrndC3F3wA3
         9YXJRUP42SIeOg28kL+ujss4h8baeaRTzs1Q5CWw4yAOBpVvKEzy75NGEnFphqlP6IZx
         mYSpTGK0UUHMRaB+Puwj4GeAUpnwtSgdju2Vp/85mbGjQ65lLaaQKEGc0CwYhb7eHaFK
         lVwl/+Y2WcR/QjTYWyMKmn8pwDWel8AcF7rEKn2jcXxFC66qhprFZFHhTl8MWgAm5lQs
         fJcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161915; x=1792766715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drmxJ/IrDX3kMCfCLYuFNUE9kPUpZ33JeHbIW8lcaRI=;
        b=Vgy8D6Hxu6MONGM4yRYbAOpmw1T3pNQ1rvJhxiLjOdkJfIHjxDR4VrdbhrcioRH2TK
         Ma+RnaA/HIIWt3PegB+j8MbIl7p+Xt0fNBCVTN1p0n/gLphK9rmx4OpxtiXwSdQIi78C
         zr4voYwyB27y375kMRQcG2uuInA1vSdmyeJkRDNx2yQtFuI2oi5Y1jjPYsXOetAw3IHb
         abvxdPKD4YKOn240Z737TzcqtJvSEfiBEbqC73pOY1y2YOT0ZCDGL7lSvAw9//pqyVGK
         9iKHK3xjDgmYhTbIlxwT9amxyAMiTn8rm0exKcnblF78yTEVRoUErc7KcN/y3HRbJYPd
         rzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161915; x=1792766715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drmxJ/IrDX3kMCfCLYuFNUE9kPUpZ33JeHbIW8lcaRI=;
        b=wkRHwmYnOXF2cWxuEgmo9oyPOPoPt1zcSiModlEaE4yjlpzLLAPDa+Dc9xwk4+RJfG
         SuDHxYZHCt1TwELRnshDcZkXvLKci9WXNxzQLeC2MXGg5eS7LGFvXN8AdO+xFFY4BFKY
         8M/HQf2EOzZKy0n7s5Jisa20tDnMOO3pBpGf0Ug46SWemoyDchHYgYqd1CvwReaRPxUQ
         dQPDw42l3Hf2FWQAdl54G8anCyylSPaJejEjPzum0619qSWHc8C0uHs2INiEcbZaX2Sq
         E463J62wBL72gNGCuIr2AH50psf1pIMEWwV3YZmQF4ZRb+cvkxCNnXP2YKPYX8Za+s3P
         lqiw==
X-Gm-Message-State: AFq9FYJ4++gvQCsoVjSMqaRA/AoMe5A1zubciCobf+FIEEmFMqfOJEBV
	HDaJv6fen60ZsiDki1zGZko2Wz1bOlgXq32H/ILK7nAwGLri3vLO4FP27+5oSekg0vw13n+xoJF
	upENw/rkH/hRLjeSZr0OHkMqPzETnU+g=
X-Gm-Gg: AYBFou0mO8yLOY6nGSpUZoT4iuh//nXAptInNL6+hEfWGjGXwbmDxeYtNon/OWFJH0a
	az+qbpAJm4OVDyws5nfRypQZZ1gHPXaCGmLOX/GF0Knw5/tD6HeEZ/lQgrFtlPTOZUQ7iFJj2K3
	+JZLdju1Q0aJTDF6EDDnxwqJeuVU4jkLce7RV8CWISzerZ9NNtnmAgCkVqgajgOhH0SmWsW3ytC
	2H6vC9FVv0aPczb7Q1kwHuHs8n8BXEKMTjXDEGWCY3UHMCPqkRGw+tmo4+E2CyHU03asv4xwzww
	oISc8b5NwXAdo/uDGl7BZMwETv0mO0Y+YjaYLin7Fh8EPS1YE1rhENvySUUVptT7/Q==
X-Received: by 2002:a05:690e:4102:b0:677:cc0f:d8a1 with SMTP id
 956f58d0204a3-67936ac604amr8079819d50.88.1792161914939; Fri, 16 Oct 2026
 07:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015014457.877322-1-tmz@pobox.com> <20261015151422.1057210-2-tmz@pobox.com>
In-Reply-To: <20261015151422.1057210-2-tmz@pobox.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 10:45:03 -0400
X-Gm-Features: AclHuK8Xctd_W_k2j73kCioIMgXPN8cq60PCksTtkhG6lrvFDOgALpWsh1lcrw0
Message-ID: <CAEjxPJ6QJH01hm2qfsD3305ENM42gaeL=j37+77PxCD0_L5VYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libselinux: add -r option to sefcontext_compile.8
To: Todd Zullinger <tmz@pobox.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 11:59=E2=80=AFAM Todd Zullinger <tmz@pobox.com> wro=
te:
>
> The -r option was added in 50f0910c (libselinux: add support for pcre2,
> 2016-09-15), initially to "Include precompiled regular expressions in
> the output" and updated in 36df3755 (libselinux: sefcontext_compile
> invert semantics of "-r" flag, 2016-09-28) to exclude precompiled
> regular expressions.
>
> The man page was not updated for either commit, leaving this option
> documented only in the usage string.
>
> Update the usage string to include "-r" as well.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
