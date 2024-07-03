Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82952BB13
	for <selinux@vger.kernel.org>; Wed,  3 Jul 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041277; cv=none; b=ZpHb6nQ6Jm6GxT0N+0TbbpRakSOSymSgAJ9Y4FDxNHD/zIlw4TWIBOkK6OIUsrg+IB7x7qf0ohXRenZC4+aD7EhxDjMxixWMjZCyj43PtlybQM3YdKZDyqutAjfIlRK7j08g9h+n78qiPYrHKkL1D2fh2mX6mMCrX1A4VP2WJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041277; c=relaxed/simple;
	bh=cskfApFNSUaCrjJIA0qePKSTib+4zP5ggDOMc07BnqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpkgTMQKVi95tdG4IPZ9z3Rs67jYF3WnI9W55cRsdXyYmuXaxvCuTBOsQVHJGHUvmtwDx7E+Hhxj1tX8/I/NLt6RyWsadEHo78jsWh9UD+otMqWNoz4DVp4DBy1hapBo0z4zaJs4qtzZihJtqcx5EAHBgfGnJBgZpaZQGEAKuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CD4wMs3y; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CD4wMs3y"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64f4c11d2c9so29844157b3.2
        for <selinux@vger.kernel.org>; Wed, 03 Jul 2024 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720041275; x=1720646075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUaoO7N2GAuQnT2k1rXeKu1l0hF+h2kO+5W0dSVH7BQ=;
        b=CD4wMs3y/QfihCUeTeaYoqTOksqPOEquarCfvGxKc17RrlYDJ6p/MC1iHvQTPawCUC
         L5L4R3+grc8WP2X0UwbJudGNk0COYZ5X/KpTQrsIIclNlDIMWAPuTvXvI1NJj4IZKDpv
         BdZVmNpV0YrR3Mgir4nMXRkUanerOFtAC1WBbDqbZyzExcViNZnQ6rUDpmtbjEgPah7F
         2cKtMsGTG53VO+Og9D4Qqam7wXu2e7Cu6khyZsB5kgfTcJn2QlgeeQ3CCCYcLDcutMd+
         LMy4a1s3MC/TS3K2LGCbstv5j7ywt9c2IEHBA4bKkTBFnhCb6qedmC/sRJJVhvnEi3cv
         W7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720041275; x=1720646075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUaoO7N2GAuQnT2k1rXeKu1l0hF+h2kO+5W0dSVH7BQ=;
        b=XLTcCsL/l9vK/ZKTSI651hrqJdhT7n8hwrJ0hywU8LN4UmTt7cfZPb11oV2vCfXbUl
         jJ2AGvpbewboVs7hm+180tbujbwwufrsNl8yZScDumBWA/xMArMWKCtu45r6vX2cm81P
         zxNoBsaQOOXI8DrVgZ1DRIBLXDGexfojvaNGptNEimECpktMQ517leR2agjmC3gXUroX
         o2Dem7FbUcq2Em+EU+yn0GxQy596QtY4jrTHEzod2NBBcjMD7Q5Iw05GO3AaCXrl/+Be
         VKUxAVhWk6cZUl9uLMzTPPaM7rdSEh1Cq89hynfyaFBzxj6Ue2jnjd7H7TLS8rCbH5BF
         xxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8tZB14J3V6CacrljnvTZakOwNmhBr2BnVntwcW/iHt1OLpK+ixYN58hJ6GNYspNBZP/oWdWjr9JxL+eWduwJ9hYfBnRBlw==
X-Gm-Message-State: AOJu0Yw0DqCJd+5pLULp4/JOpPgMwRUuNuS638OrOjgDxWfCT8D1+Zsp
	+DY43FYSXL/RldpPrDZCNwlCGUoLOTS26jfS3GF2c1rezf7cFP+I6dl9+PWl25pLl+WkVkPY4kc
	FoYl1FUNe9OT1wa4HzuYfN5KU1ShzmuRokFPz
X-Google-Smtp-Source: AGHT+IGhol8452o97yDFCbRe/iruMptqEs8IYB13hiDwT+PJaxa2TDB9/usnaUvLI7bE5WHM7vtZTiZX2YR/vMWdIlY=
X-Received: by 2002:a05:690c:360b:b0:650:a5cf:eea0 with SMTP id
 00721157ae682-650a5cfef86mr70503377b3.20.1720041274746; Wed, 03 Jul 2024
 14:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703211134.349950-2-paul@paul-moore.com>
In-Reply-To: <20240703211134.349950-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jul 2024 17:14:24 -0400
Message-ID: <CAHC9VhTA5tUUH7DAYx9k6X2L4eTzJ1a-ETaJ5+sMZrxKqjKOKA@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> moved the responsibility of doing the inode xattr capability checking
> out of the individual LSMs and into the LSM framework itself.
> Unfortunately, while the original commit added the capability checks
> to both the setxattr and removexattr code in the LSM framework, it
> only removed the setxattr capability checks from the individual LSMs,
> leaving duplicated removexattr capability checks in both the SELinux
> and Smack code.
>
> This patch removes the duplicated code from SELinux and Smack.
>
> Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c   | 10 ++--------
>  security/smack/smack_lsm.c |  3 +--
>  2 files changed, 3 insertions(+), 10 deletions(-)

FYI, this is still untested as my test kernel is compiling now, but I
wanted to get this out onto the list before the holiday in the US for
folks (/me looks at Casey for the Smack bits) to look at and
potentially review.

--=20
paul-moore.com
