Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626EE3AB26D
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787430; cv=none; b=lrYiC/ei9IwgHffnHDRpEoEv9Lx2ecM/9MkQiLsiwottnJ7pLlwTtb9KcqkUyeLlUM5O6dUSBc3PEreuNQce2ccqhdCboY5LwYRtOPXclgxCGI1IwoIoquy5FdoEt0woSbmT/5uZTJN5NvYoJJ0gJdmnwr5Zpu7KczK3jdk1dc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787430; c=relaxed/simple;
	bh=aT49OffwABkWVv4EIBGwYpySJxRUFX9qeA7/ajUZryI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=buH8UqCYVl63mjm0zR2G3YlowXIfLsgFamP1Rbip3PqqN8c7pPGcBuFSEFhv/6LIDNCzmkai+LoF45cdjEtnE9geLNyM4T8+VacKn+H3173+qSaBufn8DvNuXr24/dfeD+KdMNr+M1Sf/fZdOt3LM7r7hIeuk+A0y+oJrY9DUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VIefU4hD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VIefU4hD"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-934956bee57so330463485a.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785787428; x=1786392228; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GrM8OuNgXXrb+t+iBt1N92EV6KvYbox2YuCkBhGF2R0=;
        b=VIefU4hDDYdnnjJHjHBmwMqSbSTY7fFydOuP2yjxGzNZq/8nYLhebD0vyBFxU1w6Hl
         ATh+LKzItUSdI+9NxpX6MlBcpY9ndzILmyjeJ+CUZISXU7vMVQ6eDNmrQtiO4IvWg4RO
         efXDSvOPnkpspjwjLq52Qj54d+gP3KFG4qdy3S4tpcPMCZ3gcWD2KcLAUqfSON7pVkJg
         wE7u6pHvIPsmmxY+fyeO4n8EhM1RSd/by+31suDDEJ26WY7/FfUfkIv3pUQOwVCXTpdq
         dHVRrURJfI1zPdtUupALkDqM5/0M5HzaXNnlpilsHeBTzkKtv538DGxNZgYEbnaTUl31
         g82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787428; x=1786392228;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrM8OuNgXXrb+t+iBt1N92EV6KvYbox2YuCkBhGF2R0=;
        b=faMEO1tmWJ7RAPWeukUhDnCjAIvGGd3gkojug7d7+WTnwAZrCGUf3p6MxaPq9N3XaI
         dnH/ZrJXsom8aB2RJeRcDiHDXCDZzuOYwsFR970E4TJfsSs1HtfYN9Gij7yQ/UhlU53h
         aNJB848lBav5fxw0GP72HRUO5OIayipdkWjtT633GtfqSl/qMkKM4t/LDNElnIQD1DWz
         U+66Y0rynF5Ilyj1ZXb7Tzw5YmR8NRDvQrPCUHVCyAT++/qoza/OQVq37i8TLHWoYmRs
         IlYM0p2ZlJY871NL0G9bBzBU42N5pOaCc6b4R0QFEQUWROXy173jounxoJ3D2eYlHtZr
         fjiw==
X-Forwarded-Encrypted: i=1; AHgh+RrhnnoZs/UiXQV/8Wp3zMkgXZ/xznkmUEALAb0SsQNPuPdczBe5icPm1EjxM0Rsx0Lvc6lf/dYG@vger.kernel.org
X-Gm-Message-State: AOJu0YxiijL4Jm+cPXW6IsaKyi/D//aQIAUm17jAcSYpPSV51w3isRSr
	oBA6/fpHSdp+B2tx+m3RRD87s7O7CjqJGKSYdtppVCDkPDkuNdOXL2Z6Y6mG6V/6yQ==
X-Gm-Gg: AR+sD12aEweus8Nhebtcgr+c6UMqjUN5xqZ7zsf0LfEUgt5HWHXhPBCXtFr3wHeYgBf
	CwEiV3Cw/6ITwPdT5a7GJgp7oQxoyIL3JrLXz5YIO/dn2zoNMNS/Bx+6zxXLKSs5F3bUb8Z0jpX
	LjskGb8QjJ/xBYWE1K7UmVVQd4LJ0sLtQPiWhRu0VrnKphn2+5xPTHMf+TCxP479nRyWLWATh6l
	y5QtWsZDRgV7tIimjPRoqgiBJ+oA4AgINKDYvqQwssRCL/dJQ3tD/qo/dp/T3l5Mi0VlXmYsi6E
	lCrKibDPPAjt2jQCkXqOOlOIs0iHMy4VZsEpoZdsGHtbkFvbhs+M0WmF26S+5cNvYIR0hMWjdT9
	1erIr/puSJ2K/46Ue4F34AvWyt+mslLgfnI/PxQuyjY2qDUlpVsi5Ia5Wh6uVpB0zPbosUYkYH5
	BpLi7C6vL9f/wTGCkkM2oaGBZSz8g0FrsobqNOct8BmaEKiJTqEgY8SdiFYGtV7dVdKI7edAb4O
	g1QFoRZVHNq+g5Bm8HrXv9l3ASa2P15WQ==
X-Received: by 2002:a05:620a:a407:20b0:914:bd27:2d1 with SMTP id af79cd13be357-934a0783490mr1787176385a.11.1785787428305;
        Mon, 03 Aug 2026 13:03:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c199b76sm735839985a.24.2026.08.03.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:03:47 -0700 (PDT)
Date: Mon, 03 Aug 2026 16:03:46 -0400
Message-ID: <e56c9e8eccdade4c8ecd078412b0cada@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260803_1511/pstg-lib:20260803_1500/pstg-pwork:20260803_1511
From: Paul Moore <paul@paul-moore.com>
To: Bryam Vargas <hexlabsecurity@proton.me>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH 2/4] selinux: require a class's permission values to cover  its permission count
References: <20260731-b4-disp-d32e997b-v1-2-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-2-0341d038ee47@proton.me>

On Jul 31, 2026 Bryam Vargas <hexlabsecurity@proton.me> wrote:
> 
> security_get_permissions() sizes an array by the class's permissions.nprim
> and fills it at value - 1, from the inherited common's permission table and
> then the class's own. A value no permission defines leaves a NULL that
> sel_make_perm_files() passes to d_alloc_name(), an oops inside
> sel_write_load() that strands selinux_state.policy_mutex and leaves every
> later load in uninterruptible sleep; two permissions sharing a value
> overwrite the first kstrdup(). Bounding each value by nprim catches
> neither, and neither would a count: the symbol table is keyed on the
> permission name, so duplicates pass.
> 
> Track the values each permission table claims and require them to cover
> exactly what its count declares, rejecting a count no value can reach.
> Conforming policies are unaffected.
> 
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 51 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 5 deletions(-)

Merged into selinux/stable-7.2, thanks.

--
paul-moore.com
