Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206D03242D9
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408308; cv=pass; b=L/S8CMGNksqWS2B+Rq89GdpuKsmYl+3zgzyDvX4TA1uYNIV5Qn8OYmLq+uREvD+m2EfwvC8AMNNBqRHDj7eXX6joP3H87dCi+S0mnHYeUj7+qRwi6eYYfkWXrGRBFBPpBJjdR4NYWXmh47cc2fD/O0FEp3Zqlt7Vqr7xz0j7Q0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408308; c=relaxed/simple;
	bh=PqRLtCHriCUVVSAxPvMc7IsJASJD0u5kx2CFcPRWcUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftnsAE7xM883KLO85STW0N6gW+Ni1xFl34bBKo8uYy4cWBGsWuFEq+VpSY6UqnCam48HJ91YyReEl32KrK0rwHQYIJfuyQ8mYOvZVHaCZjhImKyHcVM5gpC935aYF9Nz7EdVEGZWBxn1iqDTGPTZuok5Le0ws9IltHoiaOXx45k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMegnfUC; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMegnfUC"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36baec934b6so2405137a91.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 06:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780408306; cv=none;
        d=google.com; s=arc-20240605;
        b=Tkikcg7JuJCCUh3ifqN0htQ9gzl7VU91Hsz072vXb1uid2uvFt9AiQkH8Oym4d3Qbo
         SIo4nyNfBnv9ETDFvsLkBfovqSiF3PjS3VtpWUXHJkpp7bucqkXMprYVK2eIS20ZEgpK
         HTpBPwraJPNyZtZoS74xmfyws3LyBsJttzlh24qBVvUkDQLEIl96LCWc9A0EGRh076r4
         XLkWt+Xjx4tQjDF+1/fu+2B0HwZF4kXatsNg9FLCLLZj57dthJzaxe4ZIF5wVyrSuRf0
         gYqY9iNeNGxXChcT19CSV+qHo66hfjUaMi5aKg9t0bUVhvW2LOu7FJp68/4aTvU6HkSc
         t3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PqRLtCHriCUVVSAxPvMc7IsJASJD0u5kx2CFcPRWcUM=;
        fh=WfyB5oLgzhfFKr3mRGv66Pk8bsIleNnJmIMwKepUSeQ=;
        b=aG8YqmbKcER25tReupftgiHz6I3y7w4cDAlJrvoh846H8TCb+kPHzpiH/MLtZoIM8U
         Cp4BMRxuRSD7NKh/flc9n/YTrQL4qpl8UdybIdc4cGjHRPcRc7THMvsv42Modq76afqt
         U8y0UgUjww9EKcqEMBv8T1ck0mM5QRP5Rcbuo1BvSjXVPpyFCMgcgmroV+wuneGKEeqw
         9GMtH691RuR03BGOe9DaRY4rGNARqm36bv4wqKY5+GpVjvAcSZGb8DRCPIx3VaULx9tE
         1rN5XI5n7R/2HauCbC6YzFG2fSp/ew0dO+VAAmVCu+12eOcVAwETxsUUkLRSnLipmCUP
         MxuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780408306; x=1781013106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqRLtCHriCUVVSAxPvMc7IsJASJD0u5kx2CFcPRWcUM=;
        b=AMegnfUCr4RRKIY7gxFe+hPGL2F5ZPgrPEciN5+T4MXmkYNM0VpDmGfKs/M0laJ8rX
         p4jA6tVhAVzCzqcP9VApOUk5e4mJSvpyH2HyHcqwXTuVyapgG1625XZMBuIWYjf4c8vA
         1WcZy7ja28o3uy3ndSzu+ebmuWxRAaKLgtwXBJdLzcSqHGmdghiafEKCWkw9SiD5j6IV
         0HM2jAJhdCtI9x+E4/fvlxVWZlHafszXN4r0BSFGhNAYnI01PDB/sMjQOSMJhcx1cJlZ
         yPsJjX/naFsDFUm/1F0K3T6auRUoNeCM4Y0pNNpPntsx6e2lVskHvjA3400AYaPDyNFi
         0sKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408306; x=1781013106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PqRLtCHriCUVVSAxPvMc7IsJASJD0u5kx2CFcPRWcUM=;
        b=X+bmM1Kub4I0tfjZkbyhRDPtZiFM8ymnmEOphRyOEOBjHQuRg97+I9HrD4tOR/7VSX
         cRKvFamE+xqiyb8BfrNIBgienFtspP/PQs3SDdMcSa0/ea7BKjH+CdP3S8OE/UWK9Bzi
         E8te73pNrTYP6HRcHuLt7tnGPjxogq63PJakAYliVby80/wT33pn63pnLkU5ogsKo4IZ
         pw8xQvcCTCdmGQW0uyil8YBr9pxBeUwrPI9gKUPOqt923ZggJD5SMlpfbzYknt6L+rFa
         5TuBieP5MEnIi7qBvs+MXVa0J6nsJGFWfDrKQwhhqRjq4fqGLYSYoOE4gbFiiRxPwgu1
         ZPcA==
X-Forwarded-Encrypted: i=1; AFNElJ8uyY6/QOT9ZWFoj43xCbzM6J8TQ7/4hyQd+WdVAz71FNKypP8s/VaQWahEwS076e7LOzRLWzmo@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOznvM5zkI3JwtiwpJkWnz4eqotcnKn3AVjMbI5Fswcb32W2u
	oT34I0ev3g4dMXagrWyNrfeSKRoppwd5B5fRrKPfGnBYGSRG5iQP5kMHKnSWdTHe8LuW55ghWMq
	QikyQfWTpQwkUVUfcKjBh/XDyDYi6iPiJvw==
X-Gm-Gg: Acq92OETmrCazwENe2J47EJXRy/6cZO4fttrlvaJ9TzHX7cE5NZB42+c19jiXgQvdlA
	hHyS5IibzkCpxb8UYaju/g3cUMCpWRsujbGdgCrhDEbGdxFlTtTR2uNy/myFYo4OFKYzn339O03
	9eMGXgJht8bR2giNwgaMMF/HmWpQhqEnmQiNd54UwRAtWZk0uRobdVuVaKuu+bMq29wdQabOckV
	qDd/b9QLyrl075wUwF+poHIMys923TBp91Vwpcmu4iFGlh8TUHqTPLzvj0tM2XtOTh9d+Mo76RX
	zIt8kUWyVwACEmj6x4kiw1sfP6KS
X-Received: by 2002:a17:903:4b4f:b0:2bf:2398:6009 with SMTP id
 d9443c01a7336-2c10ccbc173mr33463775ad.14.1780408306274; Tue, 02 Jun 2026
 06:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531165852.1478916-1-rppt@kernel.org>
In-Reply-To: <20260531165852.1478916-1-rppt@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 09:51:35 -0400
X-Gm-Features: AVHnY4JhNVfVDmIAi0cGCpyHpd4o1jCnj2KwFd-_ehxdx5wc-CzK3LfEHSlBR7U
Message-ID: <CAEjxPJ4GA8+xHhN9X7M-dkEZ=SQsF2HQxpfpk++K-hw=CJoZNQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: hooks: use kmalloc() to allocate path buffer
To: Mike Rapoport <rppt@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, David Laight <david.laight.linux@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 12:58=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> selinux_genfs_get_sid() allocates memory for a path with __get_free_page(=
).
>
> Such usage does not require a "page" and the size of the buffer should
> actually be PATH_MAX which may be less than PAGE_SIZE on some
> architectures.
>
> Replace __get_free_page() for allocation of a path buffer with kmalloc()
> and make it explicit that the buffer size is PATH_MAX.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
