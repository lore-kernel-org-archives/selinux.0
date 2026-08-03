Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447039B947
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787428; cv=none; b=DiDt2Fr01l6hezlh1UvO3bjX+iIxHlafR0OfSB6JKFH2OFeUpvu+LE/EA4sqTZlWVcwMlvY7gngZxk/ia1tbpvBrJnH31igNTMrNJmh0A3LuQhn3tMRaxHuxYOow8vFiHhqNncemp+EAaGqtkbhRx1itPyLh35gHqUAtlugWBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787428; c=relaxed/simple;
	bh=J3wWI5ZhIe5OGxI7L++zHjpDG2Y7zUd/pFsciW5nANo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FBxzs7/j8+ukrDstjScZsWR9Tv139Dt4aF2600G8HfXf6LdKfIpaRPtfztg4RMKgH/igSiCfDe/7cUu6cNY+Eefsa0RicRZZ7e15XjhuXHM5jpUElfE4NsP5ARVzyNxCtPFhunlqJUO4ivgumYM8UBg7anG8to/X4iKdrjdKZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DvcsAwD5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DvcsAwD5"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so2468456d6.0
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785787426; x=1786392226; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ST3v5aTWdJwcDuFgrd1Vx7Nc3MqcrV9H4KCytqnQotM=;
        b=DvcsAwD5WXzBdd+MHeJgHnrA8nEdlRmHB1rpPdtCNxfHdY8B45Hokf3WIGL6PDJsnn
         MPfYbmTsUkA2gAfC8xNf3yQGOct3d/54qw2Sr3reWMAxhHwX7jpuEofQXf72MG2CeQEK
         FqDXDBUjDA3CtUDASjDJznWn7ma9HggeSlVrEoJ3whdsi2mAxoAcd94fPMEmz2bnrsL7
         O//iYS9prNHE64Gj2bYZW8Hc2X8u2iCfb7fOXHNOMCXaUM40fWwlu+0X5ZqN1IOKH/0a
         1ukJfZBOWnYm5YMPCJlOosusOiKf5PTwLJsW1Wg/cPnnjaUZRLOW0bS6y7su4VrCi1cW
         ITPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787426; x=1786392226;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ST3v5aTWdJwcDuFgrd1Vx7Nc3MqcrV9H4KCytqnQotM=;
        b=CtKaQPFwI8Leeg66JeqkN+6BeUG6BB884v8kA2h16hpf2K9JNyrbdBlzuDflKirDIq
         EyAFVABHpVFDScrpZTsUbFjv0pkMf9w1orM3csWzN+OOlF6wqhgjZE6vpTsaZwPYtNJR
         rrZ3C1O5xwQYSsvqKVKUDcVHfERTJuMK1eHDAPD21VLEs9UJD0rTYe0ZrK4Ti3PjuHL1
         lWHJVgKz+vJFQhTV30+zIeqj9Ymf+TmkBRUU3SdVEM3IBabKlcG/TdE5dRq0a3QLJTqi
         rQD1ghuvo7ns8SMeGWBCDgrXUDvLbE+FuZGxWvetY9EC8RAV6ign9WyUOp0PYcmQ7Uqu
         +3sg==
X-Forwarded-Encrypted: i=1; AHgh+RqPNpZIg5dSx0TEO/bSjCXQ5tI1aKX0QPgeL1qxC7GrsFGV/NgH6Zr8L5/f+fv+NvVm6YKaOFi1@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/nLmeYUJREjfDZ8ErpwxJAw8sb1o8heAIAEzBhZGii7Y6N8j
	+DhsRSIiJ2mdzdqu3k7noZX1SyiRBKUGx5T41DhCXTShvOADQnabEB3Rz1/NJKn+TQ==
X-Gm-Gg: AR+sD12BLxCVO6qQ9ToUeinIInOXqo9VSYjy/Cp3o7qNnAIyRVpv7ioUtqrPBganpd9
	tmw0KSmJOkrSqbNFjS799GewWi7av38WZVsiPNoGWD2VvGveTLvMJ6gEz5lHlL94GJ7uCDsjzV2
	phHhQErX7JpLQPXjyzHInfDqW+xgf7FMvfB0BY0Lb7Tdf6DKUMSzOw547GBkrdmtxDUBCCJZKsm
	UFcZQFWyX1EUJLp2LDnAk+vfMuxuBgxUs+eSLxkTIqoiPrEAR0FJdLLscApiYY0gjFsfXhB1016
	NaeOuMz2GCVfKRzhIZu9Vf5Sv2WADwrRmFoWTGyKf15ADb440QDAwkRZ8lmlousHu4becajmZzn
	CN0Qsr+OIx/z7FXUk/yCUcNGQ6KzT5fS2u6M5Zq4heFzhjxYOUdt6S8KeIzxJ6vAHEFhbQi/caF
	G/8fQzjHIjX1QDQnyU+RC0VAGSxLV2lX7powQpnBkk6luxEP27jNsMJYI4gXNno6tZbvrjkPkNa
	vENamXORAXHM/HT4jj8SKl0Is9LmZLQ3w==
X-Received: by 2002:a05:6214:3d8c:b0:8f1:5e32:9b06 with SMTP id 6a1803df08f44-90872c2aabbmr22837856d6.13.1785787426262;
        Mon, 03 Aug 2026 13:03:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434a2852sm83188576d6.16.2026.08.03.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:03:44 -0700 (PDT)
Date: Mon, 03 Aug 2026 16:03:43 -0400
Message-ID: <2c8fd481b3855784165a43b2174d4652@paul-moore.com>
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
Subject: Re: [PATCH 1/4] selinux: do not cancel a policy conversion that never  started
References: <20260731-b4-disp-d32e997b-v1-1-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-1-0341d038ee47@proton.me>

On Jul 31, 2026 Bryam Vargas <hexlabsecurity@proton.me> wrote:
> 
> sel_write_load() calls selinux_policy_cancel() when sel_make_policy_nodes()
> fails, and that helper dereferences the outgoing policy to cancel its
> sidtab conversion. On the first policy load there is no outgoing policy:
> security_load_policy() returns early for that case, before it converts
> anything, and state->policy is still NULL. A first load that fails while
> building the selinuxfs tree therefore takes a NULL dereference in
> selinux_policy_cancel(), reached from a write(2) to /sys/fs/selinux/load.
> 
> Skip the cancel when there is no old policy, mirroring the check
> security_load_policy() already makes before it converts.
> 
> Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/services.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Merged into selinux/stable-7.2, thanks.

--
paul-moore.com
