Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B080346A0E
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732812; cv=none; b=lVzl7oaDN3ZcxHzdHpEbPCUmQnxp6IgnI+bdp7qi/fOLoZNJyS91aFi5emdIhoPHae8aUq8oYuOOugtwS1R1kcVTMZPFhbW2pXyxOntHP5P+nx3CGrnJUNvoc7FvfzwGBuTq/2IDw7Yk1gFyFqyuP2gCVpqGa4Wj4IdqHeFlwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732812; c=relaxed/simple;
	bh=XRnupV/QJLc8sXou1M8dbGu9RLj7D/1Sq/blNEmzl/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVHf2k5lYaLJbTIwU3akRuH95Yxmv1AURCS5d4ZxBCDKwEdNA7/vRLlBSljZSYcwxPTY9N+kx5FARk1FK/vnGKozu5LfHgqCMVHobwWujhprFPg4+3aNsxJCL4gpP9AL0Rm+FvvUIbN7NYI0e1ZOBeepWRkfcIRzq35Dw0TeuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz7YVX2Z; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz7YVX2Z"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so2045296a91.0
        for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 05:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763732810; x=1764337610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77vz8RBfezkZtH9uDRMzfjGGctbCIkZO2us9G3nzzrQ=;
        b=Yz7YVX2ZCN3TGRuIZNi+7sYJJczeKAHoPMTk9H6ZyuKAkGqCDALnz2y0cTU52rLjKn
         R1OQC1gyVnN+JXDSC68jy0QNY2WsJs9pnNVCN1WPZPBNe5f6JxVy5qBDvzQhh5XC4ISM
         lsiEZphsAPa2Gqz/M12VFXMVI/sXgo8ys43UTAZ3NEl5Gk6HJrMYtkKgdkjJoQ8FgUtE
         m33THt8PUmHxqnwhtNxp3AyE212hbP2Vo7+Fu2v5aKthkFggRQPDYM3HG0p5nJitfYuW
         pkunnn5ejSwDr+nlldoHW/pGCh/JlqW71Rp6pL/WE1XQPEit9XwR4bOzR0x9cG2ZThmh
         w09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732810; x=1764337610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=77vz8RBfezkZtH9uDRMzfjGGctbCIkZO2us9G3nzzrQ=;
        b=b/OLXDYt6AQv6Z81urbILfPSxih+6hMWkEpGKpb2q1J0GMhParr6Y7PWNY7SwylQvt
         t5cMN0YZK48pwL9Uph/LO4e+fOeG38/Y55wIk0/HBIZWDTbA24WnPr25KYB6Pcop2QCl
         9CVo/6FbJD5lPD7uOL1TAhmyPhpyG2UqaRoYV9Y87QgRc1I9NayhqG3y8ZqYqtilRlg7
         nL2fekDSthfbBtVzL4ikgHgv9bkekP4NUvfh2PSqIRtrXh9Jp8kQrePrVMTlccJqcz6h
         TrwZP/bbvc2dVjMYkBncWSZhLqx+IUUQmaHM8bxVDaCO851I5G6SaXjPjg92d71oHr7O
         VjPw==
X-Gm-Message-State: AOJu0YyJfuWFkkcPmfZtlRuknNPe2slj5COyv01O4VEvY7fKThINHwIh
	E0xcgiFv3+ND4EEBPvPQVRtJZX05s9z8pFlstb6Xp8eaAIRXwAnupfA+emcGx2IuVi+LrfoWypj
	OVIqxJy8gzi81WTIMQX1V7rkkq+Q2DG226g==
X-Gm-Gg: ASbGncujcNqqw/m6YNWoC/nquBdpld0KfsEjtpxcdZ0aoZkyllWczvvi6tT8ow/+KDC
	7yd6mMJyiKWCr/JgoIWVK7kSkofAbv2ikXQyG/iDDLV0KVWrsfse8AyNyzdA+w9AOzxXC2qKsZO
	l56l2QxjweL0LdueP1wrT+rSOa+TrrAYYWrdi6OT6L0Lt59vmow0+1WDcXWT5w/0+t3lqXuPytk
	GRPJ7G0APoLUt8iAsFchvpDmXPCaUn3XIRN16Q02tjmgQEIow1wd3fgDMVn3h9rkW1golobc+aK
	/1QBcg==
X-Google-Smtp-Source: AGHT+IFvnKvOafszEJZp8RUCczHf9Gi7UJ5hPVRL1wdPi8pIeR8FblE/wfVDXyC2CTQBVJU+hNgmUVb1RJMBJG+vv5E=
X-Received: by 2002:a17:90b:394d:b0:343:e461:9022 with SMTP id
 98e67ed59e1d1-34733f22796mr2726682a91.24.1763732810509; Fri, 21 Nov 2025
 05:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121082038.735276-1-omosnace@redhat.com>
In-Reply-To: <20251121082038.735276-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Nov 2025 08:46:39 -0500
X-Gm-Features: AWmQ_bll6JIYIY6Jo9AbAaXWgl9iqrfNnWh31nCm4rR9M2DOX0ta_4oZkNAiHkI
Message-ID: <CAEjxPJ7BkZ39UfpLhQjx5L16Chzu6V+0tjYR_1Vhnir2fK4mvA@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow testsuite caller domain to ptrace
 testsuite processes
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:24=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> While this is not required for the testsuite execution itself, it is
> useful when debugging by prepending commands with 'strace ...'.
> Testsuite domains outside domain_type() aren't allowed to be ptraced by
> other domains, so the permission needs to be allowed explicitly in the
> testsuite policy.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_global.te | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/policy/test_global.te b/policy/test_global.te
> index 759353c..cb7d9c2 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -69,7 +69,9 @@ optional_policy(`
>
>  # Needed for domains outside domain_type()
>  dontaudit testsuite_caller_domain testsuite_domain:process { noatsecure =
rlimitinh siginh };
> -allow testsuite_caller_domain testsuite_domain:process sigkill;
> +# ptrace - only needed for debugging (e.g. strace)
> +# sigkill - needed for some tests to pass
> +allow testsuite_caller_domain testsuite_domain:process { ptrace sigkill =
};
>
>  # keys test may trigger search AVCs for root's keys
>  dontaudit testsuite_domain testsuite_caller_domain:key { search };
> --
> 2.51.1
>
>
