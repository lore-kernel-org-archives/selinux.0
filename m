Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570F2D77FF
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843295; cv=none; b=XP7CMQPMHpleizpqk/hMn977almuEbqU+ENtrvueskMFa79ttVz3/EmQ2a2vj7MmLhpTzfVkvaknTQCY5Q9i5UHrIPfRScWTSMJMSdkotRadBI6jLRBtOzZt3iF+0t6gF1VC17si0Onjz2TVxfZiCEnuh+bi1pYBaemQS9OVSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843295; c=relaxed/simple;
	bh=WNo4WFYAEnlQylYxTOs62ms5wwgHtqE1Ugsc1tmlLAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2eQ78rI5X9GYZD7WI3nraKu7NxEmGko5M3iprqX3BlUeU06q9AsChyryAcpcotOZDEuZhbn1vhHmSuvhR+pQ7umzLAcD8CpO0My9DGFL0KkKKQGPNI+mh1fPF81KcwwwC5yylXOr30iuUQViRdNpcwIKATqPgZqC0SG47f417E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0zleYyX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0zleYyX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so6729300a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759843292; x=1760448092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngluoHumEh1KRqoazjdBD9LiwPuV3qFMnm0o3YCVk1E=;
        b=f0zleYyXdP2q/amko7WkURlOv5/8QzagJPUUA67IhtK0WhTUbMe5dt2XbUuuJbSDpo
         njGkfMHbygjF/0RabtUxEQfwYFephI3a1XldVkhQvgn++/mmFwC4I54DWQ/cZ115Z6FB
         HCVbWHNttu6Tw9ZgLVUqpN0n37PRm9Lb9mrZopA0s8GdyZR3n5qwPEjTMcTnGOrKOcNT
         jjgYJnvRhcnpru77QPzyYwuUuWiku7M5PSA2H5zYuXod5emk7cLJ3nlhhoVdSGWP68xA
         E626vSYOEPwjqeq3PEx0F2dlk1ZgB1LhXgrc7HX1uvAIMyZvkhdRXeqJEZr582r3WQab
         Ao5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843292; x=1760448092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngluoHumEh1KRqoazjdBD9LiwPuV3qFMnm0o3YCVk1E=;
        b=QBfjf9htDKu515r99APxhxalIVUewG7/w0rMCU9fCw506GWAoOv+UhPN/PR6WoeAJ0
         qGRtAA1v2V0AS5gKxOjRd6DtYK7aDAXYKyMvtVdnMhN/FVZClO55yncRDuLPAppaMTM5
         ovaYHi6izvsA85xfHNxKLLIW5QpRwDSL/DsxiE9kPmG4AubMYhGOKXr0cmMxCqNzFEB9
         2aYKT5jEKtsfT3kuAtQxFxVJwuM1aDym9sR7zIocFvpa8Mpwll38eytzmrjn6ZkkTJ5G
         xQxfMRTOCgmorQSsTsPSIE1GPBeZ4SSri9qMAyDvI0zQ+S2HIXuMMTp6scmoX5noWDxy
         f31g==
X-Forwarded-Encrypted: i=1; AJvYcCWuWtmp+ExOaHJhpetn3ZggU2LqRmH+VTnC8/VckPycHk0DhqQL1KATKxdF/rLlOw5YxMvQS6MH@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGTTwsXE3i8hnyCleDNLsTEYE8O/A/UlU3yBtDjrxQ1jQlQba
	MN38asv5AKJKDsc5yYsVhrZg44eUXdCki6JxLbqR8D44YGNyqDMpshUYRF+iGwZyiptHBEBQmfm
	uWKE0uHIkrJz/ldA4wt2qQ9og7EXJkMU=
X-Gm-Gg: ASbGncvkuI3kbMW+QKxznCrv39fYsEtKAQ8InhvsBPUEvriyQqstOvC/bGE7bC4Xbwb
	LxV+bC56JqP1TSHwMWyJ9/7f9UQqz1gvYTqHy2s54cf+BI6wd7DyXsnh5bmXQKX1JYRa+TMcYUI
	bx1JW1TIG9gRsKL6oRGJJm6yK/hQz/ycygS3Vl78iy5r8gAyPqYkYgfqBLCcv3dI8UBxotiJ+LH
	0K8Tqdk1cB/y0auyzc3FPHP4qRqrmE=
X-Google-Smtp-Source: AGHT+IEZv1uygROQUwLV0bvAeCct4D2fLbpyW0CmI2YCRdYJxJTz10QB/TDcD2hfmKJVGV3TERLIFDIXFArNzknrkJ8=
X-Received: by 2002:a17:90b:1e10:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-339c2732579mr23664770a91.15.1759843291861; Tue, 07 Oct 2025
 06:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldln43to.fsf@redhat.com> <20251007104656.479127-1-nvraxn@gmail.com>
In-Reply-To: <20251007104656.479127-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 09:21:20 -0400
X-Gm-Features: AS18NWDs-cjQo6U0ltAVR8PkUjJtiCNZ30sGIKtd_-F3gRqA9HH6jr4TO59NztE
Message-ID: <CAEjxPJ5cMQb2DE37BnzrDQYars8eRfe4VSfN_4mwRQAhj2nW8w@mail.gmail.com>
Subject: Re: [PATCH v3] treewide: add .clang-format configuration file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 6:47=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> Currently only an RFC.
>
> Add the .clang-format configuration file, taken from the Linux kernel
> repository. We don't have any official style guidelines in tree at
> present, which makes it a bit unclear how to format C code for new
> contributors. As well as this, different parts of the codebase seem to
> been formatted with different styles on occasion, so using an automatic
> formatter should resolve this.
>
> As well as this, replace all the existing indent targets with format
> targets. Commands used to find and replace those targets:
>
> git grep -l -E '(\.\./)*scripts/Lindent' | xargs sed -i -E 's@(\.\./)*scr=
ipts/Lindent@clang-format -i@g'
> git grep -l 'indent' -- '*Makefile' | xargs sed -i 's/indent/format/g'
>
> Also add some empty format targets to Makefiles that previously were
> missing an indent target so that `make format` does not error.
>
> A few other things to consider to do in the future:
> 1. Reformat all existing code. I understand this is a big change, hence
>    the RFC, but we may as well get all code formatted if we go down
>    this route; afterall, it's not like this will cause any breaking
>    changes.
> 2. Possibly add a CI target to check that all code is formatted as per
>    the new clang-format configuration? The options `--dry-run` as well
>    as `-Werror` can be passed to clang-format for this.

Yes please.

>
> Comments/feedback appreciated, thanks.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>
> v2: remove linux kernel ForEachMacros and replace them with ours
> v3: replace the indent target with the new format target. also remove any
>     mention of `.editorconfig` from the commit message; those changes are
>     better suited for another patch (they're small and self-contained eno=
ugh
>     that they're a smaller thing to merge).
>
>

> diff --git a/mcstrans/Makefile b/mcstrans/Makefile
> index b20279ab..28d8c7bc 100644
> --- a/mcstrans/Makefile
> +++ b/mcstrans/Makefile
> @@ -21,4 +21,6 @@ clean:
>
>  relabel:
>
> +format:
> +

We should add targets for mcstrans/utils/*.c and mcstrans/src/*.[hc]

> diff --git a/secilc/Makefile b/secilc/Makefile
> index ef7bc8cd..2518933f 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -87,4 +87,6 @@ clean:
>
>  relabel:
>
> +format:
> +

Should add a target for secilc/*.c
