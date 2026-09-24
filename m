Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD614D8DA2
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284089; cv=none; b=lDp4gRLzYsnepmPgZ4KbB0zd3J2iHGu5bE+QxdFL5tk5cYWroHb8w2bp+T8ZTa8EiBvr8jR8BZf6+pspnVO2vyRA9zu2bYG7Ics4woMmfd50kujI70zxwOBX+UMIK02mx25vAyQEfkUZPlyYKgWBERpt1vORbBO6hMk+20y+rHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284089; c=relaxed/simple;
	bh=dmnG+JiB/Hqz0wX/Dx0UuBS8Jqksqtf0DFFQccFz5BI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=IGbV4yLkAnjpCxUkfkAIObx6uVzVx7TFSNZ1JZChJ74pBYnYJ2mzCuylcQHqCGJRFhca3CIjYpRRbsyNkaRQP7pUbkb/dS2LKrdwqTjPgV+wWovVKH2VzPCHXe8rvQTzK5gqqVluaWrKl+xMK9PajjWQdltk29MIwRyrHdU5sXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gaQA94gS; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gaQA94gS"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53122c5bbb4so2720461cf.2
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790284083; x=1790888883; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GsnY7yTw0/IskNHmr4R2bfGyvukf/UNcXZzMjGLkV8=;
        b=gaQA94gSxWNkzi3kbP64dAikLDDxfqA0+H2cci2IUO9IMnqpPxetOIdY23//sGemp7
         L98HDKFxz00Xc6uduZOj+K8LQBKwe07Oml4s150Ero6l7wUHX8C8lPYz4Vex7lo6ZQnK
         KZ2gxgqp5WJt3gcnUDTjp5sjEHzzN10Q1zqkJswFtFrmUsthgxolKySfmSKshcS8gx3T
         ueBYzpj4ZN8lDwzzPGEiO8isCPEp8CuAp18qicY9kBJJueqpcJzjKOPC7k9FC/qrRfpd
         4Wffn7kMrtwyFCwwy9A7/pW8fV5xUCviBW7awwAtQ7Uo7PCb9mMJv3To43ALgmrOltFs
         NphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284083; x=1790888883;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GsnY7yTw0/IskNHmr4R2bfGyvukf/UNcXZzMjGLkV8=;
        b=j5OgSJqRbiJWGXPtY6PlFAgF/PcPvn0vw1u0A6i+pB6TL8SRsff9uuiUjJtX0IAKWH
         vc1hHka3CdXADNJf88biigx1koZIhGF/HFeRszfqhOVKmMU7YYyG2p2pXxXfSAx0Q8LT
         Y+Jdj7XBDSxCy4NcKeupXFxC6FBCW7yY1AckQXUMW/1LgUWq3yHP1mU4mPXbqXRsgxxC
         woAuI4Nkv0sQ8UIsQKntzhm1+IDLyjo0TQLfaFwTwxhjkCBdXCgO7z97eK9X0/7dlh74
         cT/YpzImXG7sm6H70PI4hB4lmEFdgDWR6vJNc0SsM/99RktCnI7wc7TTDDZkkoXZRYHn
         Js/g==
X-Forwarded-Encrypted: i=1; AKwUvBzMkEGfRlZ8wBpiYZvc/JZSlinEhUkuhPGnjwAPmjjBjga8IbRFGal1FN9qOWNfIzNGdTVJepFW@vger.kernel.org
X-Gm-Message-State: AFuF++mARs09gWJT3VUTCrGhIud9l3ErWHG837DX+CIRoZUFaEmZpS4j
	6/tz1b46awafsuJE4MczatiqOsyFOhaFmFHtF4Kqsi+E7nU67qJqYL9XkWdH0QCIeg==
X-Gm-Gg: AYBFou32EBW86z4ymoc4dsRajY/N/rykewqlUmEJBXWMfK2XHo9S5PhVHuK+g6Ot9x7
	XBbmyOxRrVxKtYZejjYNeYM/rJa3j+c2OLM+uQZH9dRkwRYnX+uof3Rp7hBQdeLwYW86URYLtfs
	ATnruLDxLF2poyS8lHWjpc8GZSuXFerHNZ+zfLjaGqICQt17dLESayfudKVa3Xz4oq0gHpf7BiR
	FUOtCX85MSCeiEvzeqMK1WmVLZp9J+UPhnVedymBx3yC/JfCQ4WgooFGgUO1mW7HuVthUrqbV8i
	FBwJnhah/WYvPdZsyvtBkXg2eppYpnsjxqe/SQH8wg6wQTayvff2ERuSWghz3Cdznq1u7Rk0LZ0
	4q2+2O5OVfDpiw0lAj4aL1SHt091+3b6/JZ5FYe8R4japGQMEy8sYg6dt1B8PSRRqWzY0TYHQsY
	G+YhvPtQFjJdycsc+zW5gTRWigotyZYc5YHTr1zwjhxNGyHdGgmnxM2nW9YHgvOv7Dpb4ZmAy1a
	R8KK/1JNq39nNBNh9lkJZFCzMWAVCKeg1z+flR0WUOJej9SoX22+YTD8SjmAu6PyO38uEvN7xku
	kmQFehHr3w==
X-Received: by 2002:ac8:7f47:0:b0:532:d007:8738 with SMTP id d75a77b69052e-5330dce452amr3126871cf.36.1790284083230;
        Thu, 24 Sep 2026 14:08:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330c0452e8sm2158761cf.18.2026.09.24.14.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:08:02 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:08:02 -0400
Message-ID: <ac3e378a3a0012815d4d37f4740e2d76@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260924_1657/pstg-lib:20260924_1656/pstg-pwork:20260924_1657
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnacek@gmail.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] selinux: reject a policy that both rejects and allows  unknown classes
References: <20260917142038.60637-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260917142038.60637-1-cgoettsche@seltendoof.de>

On Sep 17, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> handle-unknown is a single three-valued choice - deny, reject or allow -
> but the policydb header spells it as two independent bits and
> policydb_read() takes any combination of them.
> 
> libsepol writes exactly one of the three values
> (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown), so no policy built by
> the reference toolchain carries this combination.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
