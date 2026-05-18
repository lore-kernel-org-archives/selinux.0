Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C28309F00
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134438; cv=pass; b=kr711sXKz2Gsvz5X/Mp5Sa3M/SXkABiaefEafT3E3Mt7EXNCrFye2j9hJVwPE2Dy0mD8OnFgHyekDMPzkIkygDrbxJ26cOyLXpiBQKG9ZscV0zW9eACr4Gxw0yp4W2FLL95XByCIYZM05zoee0ZluVcsqp48um+bEvQNWl7zrwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134438; c=relaxed/simple;
	bh=wVc6YdbT0efkz3ftSBW/jvtgcbrOJ7gu4r0ob9mlxGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1jFk4eKgxXg92PDsXA7cLGcK/VJss4OD7yYqd2Cfzz3aZGCqKPj+GCbVz8URCVm6vFYXUyoWu2eo04shJnKNZiD9LI3n+VwNDwPEOYdrcN6lWuWu2Cud6uWRmZScdvioQ4fqZ4iQKNpPzgmNewxuG5W5vVMOR8N+qV9SYT+UZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2tX12XN; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2tX12XN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3680540a6efso1392089a91.2
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 13:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134435; cv=none;
        d=google.com; s=arc-20240605;
        b=LS8VjRZ3HrCCT+ggps1YV54TVG6k6o7pRXFTyGgOpD1ojP+WttWUXt1RRLIZ3EF77S
         rJTkXPrgdG4cFY6kWzouyKV0xq/5M2ovXh1UjxHdtUX8v0q5s6ev9R6UBGGiAhYfbEfH
         ANGtaiezO9s6lZwVzyFtM++fAbYDYEbqH7ACr8/SPgvPPOlTY6wc+Ktkcu0HL3Sr+ibb
         VWAoFxwi8X4+zDJSxUSjNhHuVk8GB//ANWRXnUKhS3s6GNMVY91KfGdU0sy5dc9v1Vz8
         Z0Y3j+pMM41Iyj7nuuojsxKHmyRTVdXReSesn9c5TU2uxGyIVVomQf8MTsSH4Ko+oEQN
         yn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVWa6cxBXv5q92egXjwAKA1hGHDyqnm3OdBa5ogtYtg=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=WgIVQa5wCcCwnXmNhvLEYHV2pF3b4H5sBOMO+XEUoNWfbHsmcCYuay/p6Gkrins2Xl
         3VMnCnJA6qzXyCzR1HWyWOrtDVdMRgFAe2mAHLP/9Q1Ol/hcXwBSfeXd9iu0Zo8MDNFR
         eT+d/FebTDKQ5/JSxgn6NNXNPmd6ZE6vB9p/5HTBiD7jbNluskqAZ65200UTwo9wWOi/
         3J8v7rR4oDdSz5Wh2CQCmFrKXH4mePfM3LVO+4JbXMnvOZl8WmZZgokxtwViGtk80W2w
         jEnOSe+w6VacJdaWbI2ZfPzPjRHzenhMWyS1pwByF8GvU/ZvDSSGwInqGSB6y1QaaWvV
         11QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134435; x=1779739235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVWa6cxBXv5q92egXjwAKA1hGHDyqnm3OdBa5ogtYtg=;
        b=G2tX12XNUx66XrjeErMcZzE034gDXSuRGgOQSm93evIY0Qbt02asyYc9IUj7OlpdJX
         A+pOIDiNikb8yv1sc/uadQGOP+1CJq8Ve3MwNtCYYwSxwnyKCKjS7PE45d529STvrJXg
         TmpA82rBbCz0+PuvkZ7d8KjgTOhSJWAz0+UmUX3F92yuRAAWBZqbhJb7A/NMVjAJYqc2
         EFJomXF28+4kkfz7oxThtIiASLhNs1S/XIG6JI0Mv+RMFyCznw+OIdvedScD2dMJTLxl
         DmkMqpN6XXvR65MjMIO50BdArruYtc3dw9YaGrxwIUnBpOiCYj3QctdqmW8wzKACclcc
         /qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134435; x=1779739235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVWa6cxBXv5q92egXjwAKA1hGHDyqnm3OdBa5ogtYtg=;
        b=Eh3SX6z4wLRmjXFpP9Jb6YUONlFJQ6A1wflofxaTJLVqIMAp53YThD1orPypRNAB6m
         ZWhbHQ6oO5srLbtpFPQKa/JtHBF/hEoo5PzoKzZXAgRf9JlybHLylt8uKfmtC9unq89o
         jeUopcMw7ZobxmvUS4sdSc1z/R/9cUtW+PVElP+Bc8Z111IDJ7sh7gIuG6GKox+G5dhc
         sCaiwbZEaN3WmneYVxHFNYbosgdyxq4G4JDBPd+99dEitNRVcO94BmxGXF6M56ULBu63
         9DUQ7yEEClGF6q2HygWJnxNgflHGS6Ryr7rS2OaO8HMuU3L42iUnSm48yvv+/WCzOat4
         iRAg==
X-Gm-Message-State: AOJu0YzVRe7CVuApR5Or69KYnsRxt7LU2Kpj0dXo2AgqZb8IXRQNVCAg
	1END4r7jbHj9cN4IxvO/HnVEDLcMNnYCmgsWY4H7h7DKqczLU4aSFJkGJ2qjaeq1DaFJsFfLt+g
	UDKdZp2Gywbh+3MmMFHLx8rgm7/m0/97zZg==
X-Gm-Gg: Acq92OHtlGma+7vV0vj7ocj42O9W2Z6FQjzXPfVbb5W1LB7WTVhN6NKoVxgJxmhiFXF
	0ekAsnzgvsAle0vQMVpYbFIYDNpfJI0/70SWc+Se4HNaRgqAi186Of1Uuipa56lRytvH/YF0Uh1
	BSPA6kEqI7tmWcXw2N0jz3YazLxEoBmwFr1+sNlN3HW9y3l6ppiYVhJvO2fYcoCJ6ewYiG2LXNN
	grvpBw7fbLlxEz/Uc56Sa1ou4UlHV8SzVmBQOA6J8NQeoBr7DY84D1BM3SIRIZ0SCEKhmvYBx8n
	Oq+xa6F1JOTujh13tA==
X-Received: by 2002:a17:90b:3d03:b0:369:d704:d952 with SMTP id
 98e67ed59e1d1-369d704f6bamr3763654a91.3.1779134435236; Mon, 18 May 2026
 13:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513143757.39303-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260513143757.39303-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 16:00:24 -0400
X-Gm-Features: AVHnY4IRDQlelpcLsbUG8VwP4TlkmAM69qomHaF6NqOS3A9-XXHEP5ryYS5731o
Message-ID: <CAEjxPJ7WhCW+HtNmzRbDY5=22+hRAOWC6ZcKMtpZUR9EdxHHaA@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: drop unused runuserdir_r
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> runuserdir_r is created but never used nor deleted. Get rid of it.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  sandbox/seunshare.c | 8 --------
>  1 file changed, 8 deletions(-)

Merged.
