Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62B32B106
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042789; cv=pass; b=c6J5xQdua7Y6EXTbxv6QjrVh9AoRSLjYW8ip9LKmFACu+UlecOLutWeoUjlZbdwhipnbf1/v1IAXV52dKOcrBDtCwPw6TBiuuls05Dj4CNoNASjIjmMSxXVfjiWiliDAj/0G6QxEFAih2HxyRsYDh8BV0W5Cyr/DKXQ7LIErr9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042789; c=relaxed/simple;
	bh=46pno5mHW/37SVnm6Z4tX+DisFqeQNB9UjfIgC528cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVVmphvTwuJtNxbrYMqpfyCzgPjKnBd/oFb45tcE7IYxUsm/48kX8u74JugCXJLqX2B/I1jlOIU93oY/CQ/byu7RikBs7f9jcSll/TyejrejqhTnGvttdusy7iT9Fo8jSY+kOtQjq2As/vfpegZyURAfJyzY0QFeFMl+Y/IlV+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfpwETtY; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfpwETtY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38175907a56so889557a91.0
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 08:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784042788; cv=none;
        d=google.com; s=arc-20260327;
        b=hXb3mfgdACo6UfKv4Lz96mKc6IvzN6mW8PG8EvC/hykofayJ8tDDRA92sLX4AGBVtA
         14QI2E0w79S07Z1prVifM/U7zaEoaYsT1vb9hR8uSPFJkTpBWfIGcRwSsuvEEJa6t+bs
         j+1Wh+3smMKtzen7AlvCqw/6rR2imIENOGPgluxNBnqr8JHjHLpSzzCir/1ge4EMBpkJ
         6mlAC9dy90FMT3fvjBqmvT0gbL6KQO7BqnuKzQx3ctK4SH6uR53p8CFhJgF+32cpY2aW
         9P+1rwM2SIYPN2H4WamBmWK8bbZMOU2R2KRLryIV6UoGbY/BVC8og1spcm6avGgCZylm
         gkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46pno5mHW/37SVnm6Z4tX+DisFqeQNB9UjfIgC528cg=;
        fh=Gzm6LjOJmmnop5YeYo6v0qvUG6qXAD0SfnklxJ6VEmY=;
        b=k0WO1wFCtjC/PpgFp4RpkxRs6415tlxGyRiXHFmszQ/TAsmzAQmSXkmXGS5HBKQ534
         nJJWzOA6AgPs46cPnc0pbkwIeWfh1S/sp4AeorepawqTEIAZ8k7N6EMzLOhm6InWP9tR
         oDdtjWZF375Lp9JBZjE21Giy+/nM77eCYfmydaBn0rLVonOfphHQMLgjSUvzS0ka7MtG
         KMgV5SkU+acryHMlVO8Ic69D3a0aPvDHQX3qexChlDGh46OjgqLjuvSQcN5hlbkbho+R
         OiW+hUF5b0/HT3GYLcrHARR6hAliHca3Lb390Yak0+dlmjYaerLhqjcI2nNkZOpvxSKw
         sKbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784042788; x=1784647588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46pno5mHW/37SVnm6Z4tX+DisFqeQNB9UjfIgC528cg=;
        b=IfpwETtYavkT1YoX9ClTH5YWTRHnMR/LIfXfFFBxRzLhE17ciUQp0s25j4VjfGmGR4
         n3dRaWyT8haiI31uE8s+aVx3lE4M8qTy0rzYzhjTNLDXiRD5/PcFpW9mp+WC+dC0TiPT
         BWL8yehvSlcQR9ybkUyI5frBaH+wSJ4HAasXy+s8rVP3pLu69dRvJW5D9/Oz/2Qmyl0S
         jFnS+pCTtqnBg6GjTnxAocHi7eOKFlQ5fadr9w6PpdW6QTvpvOlbohaQC+AkxI6LmXHX
         ny8MI2lqnQc8VakOodWN+1AXGT2/9xhiZiE3zS/dLZzyRjwDuTZpRjIRWhpRZnaG3eCa
         yOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042788; x=1784647588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46pno5mHW/37SVnm6Z4tX+DisFqeQNB9UjfIgC528cg=;
        b=TBjBhhkHDglR2rmWuMfw7B57L46OjRWoOd76rUFfnn/I9CSNTYgx05XcyMD9gfMbkT
         Rw706TJ8Wr6UOqVBVyKva+CO3c6ULOuSjBCmDDTjq8RHosMQq1jyucIdaOudHwbf04HU
         pjpGlecDHTHJH7HBig009KqqFMUgCOpHjO7kIlDF4Hr2sSY0G7a4jsoyiC0t6LlXC50Z
         0H84HT8OzHt4daFa06KJKu+B5XxHQShQZL/NpFPUXJuajFCjKao1PapJo4Urzf6fqDBf
         r2oXfNj2scVALw3ohRWhiCzDKXkaQiKz6gB6CHOa03l3AwGeowww5f3/UJ1VnPUKXvxV
         a1KQ==
X-Forwarded-Encrypted: i=1; AHgh+RoACD8KPhAFuQoAT/EBk57kwP+VmixKlotLksC9twjtjubE29g6EoYixZGei15xnawMctl0NO9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcPTMSBIR2uaY4ZhcgTz35HVI9qHOJI2941B5OhRcOG1sl96/
	7Lmi0w1SL0ujECBBGVwnPcWJvepxA7DvXOX6yH/nAkp0bhcWvvgYZHms9sQr6DDClEHMP55hK+w
	ZU4SWJmKuu3HpXkRe0vwaYUzWiSLwmQGfqQ==
X-Gm-Gg: AfdE7cn0HETLRtm6zEMnVbUIh7yb6seSynMEyYcDLpp0QVLCrpzR6rmikjiU9zUJHCb
	PgxQycpNdk+hIKUq4OS3urqZ4Z4qGJLb7glbYPG8Ml1NpN2RliYqzMcAjcfXfO+bq8H4hUK6dTz
	70ix/dIjYuj8JiZSCy87iA82XiZzG2v37PQnTxP67fljh703R+6DMnCZobLqWIKvBjfOZA+ecjU
	flvpikCKCswXIkY2QneztbSf/p9N83jOP0p0KeIQToec+CwDD8L7YsMOtykqHGxTRODT8SH
X-Received: by 2002:a17:90b:3c0f:b0:37f:f089:c81b with SMTP id
 98e67ed59e1d1-38dc8071aeamr11146859a91.3.1784042787727; Tue, 14 Jul 2026
 08:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714125759.1042127-1-omosnace@redhat.com>
In-Reply-To: <20260714125759.1042127-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Jul 2026 11:26:16 -0400
X-Gm-Features: AUfX_mwAyA7ZPtZNgWo5jtIXmdv7MpiaNcDH38jv8IJmNQB6D_vKqXMV1gQe_Eo
Message-ID: <CAEjxPJ76t7w5X6Aki+rjgY9VZOKtK983FSG9Bur2aZV+E40MvQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix incorrect execmem checks on overlayfs
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 9:00=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The commit fixing the overlayfs mmap() and mprotect() access checks
> failed to skip the execmem check in __file_map_prot_check() for the case
> where the "mounter check" is being performed. This check should be
> performed only against the credentials of the task that is calling
> mmap()/mprotect(), since it doesn't pertain to the file itself, but
> rather just gates the ability of the calling task to get an executable
> memory mapping in general.
>
> The purpose of the "mounter check" is to guard against using an
> overlayfs mount to gain file access that would otherwise be denied to
> the mounter. For execmem this is not relevant, as there is no further
> file access granted based on it (notice that the file's context is not
> used as the target in the check), so checking it also against the
> mounter credentials would be incorrect.
>
> Fix this by passing a boolean to [__]file_map_prot_check() and
> selinux_mmap_file_common() that indicates if we are doing the "mounter
> check" and skiping the execmem check in that case. Since this boolean
> also indicates if we use current_cred() or the mounter cred as the
> subject, also remove the "cred" argument from these functions and
> determine it based on the boolean and the file struct.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
