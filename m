Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CF2264C7
	for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019097; cv=none; b=Ouche7TCo6rfjVRbF41jLGug9MpW6zDZOBh6FwmzTCiNl5ZtOosERuYRX9f1uHDKhopya6Raft0+wqNSSnYzxlKOHJVo82rg1DKj/fql1hmKThGbYSiU7rMNTw6pVF7Myg30WudOMyegelBNUmlZrhQ0ykoZZb2R9OSvG6QFTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019097; c=relaxed/simple;
	bh=/1/AcIXKW6qI9qQKGtUvf0EaTv0IPP0cBe2w8dCxcXM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ixO+BUPnTI8FSau+xqMqHKbjGldZ0PqKGIhbJS8MSHNMkJ9F3/rfU9v1sUJF0xgqtpuL6rGcyabIJ8xWgMv73QdpqAuAOFQUl+WEMR+l0oMHJJUZh68Kzj5XML5Y+blTNa9Bk6Qumi2489TvEv/veV5q5qqkEXb+fRFrIBDUc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mpk57Cja; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mpk57Cja"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70756dc2c00so73879826d6.1
        for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755019093; x=1755623893; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZI90C2tnuaKIdrwdu0WyqnSd0Q2d8pZCzdJupkSfts=;
        b=Mpk57CjaoyPYJM6sRl1tWus/CaIVyZEaVym19ZsytqPyB2f8d7j73dBPci3tjHYvRz
         RaQAOn0BTi+53cutgDTmGO5SNlYumN8gl5MMdXUkwXCL9SBDZ5t82ShQvK+g8dzkRK43
         jUGeI8ygJGAIKreqKGCe8BZoyITnPhUfg8dwaha6JsB6vAOkP6rdHtSIgUjLrivdOSmn
         8A87cQ/PMankbRaZZxDWBQ4hb7c7YCoDn8H/q39YQ2s/ZBdtWU3BLK8tgZ8k89xp32d5
         /eFapMIjsbQ67viT2TRel27kMw5Nq1P955uYvuC4Yj9+A2R8XPOEK7CZXahPBgEfPO8V
         KkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019093; x=1755623893;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ZI90C2tnuaKIdrwdu0WyqnSd0Q2d8pZCzdJupkSfts=;
        b=AyLYxSIraC0qyljezSl1lWBfnJWKENZNDgItf+436Q7glIQ9FaYBLt6n7Xupi7ZL3+
         Gd4rOpyHe8ResTet883ImrfJ9ANagf+WAJmL44abZjFGfuFVHwSM2M6CsFqFTTn1fSkb
         TRG+JZn5F8GwdJRKB4hPYERnFM0mVWGpWb8UyUAtoilxr0Y4wj22miNJD6eBA/o2SRKf
         ABDTfi2STNlsTmHqjkzt9aj7RxStyDbcUiFugpmVoRDxh9zOEdf77mU6UUpLQ8hBv+kU
         xJuPZ1bGGt00AvReLZ56LAJDPGZgGps6F8TJQrltFHmxNrfOYT3/jjCUwQ3qzxWyL7UV
         Yd7g==
X-Forwarded-Encrypted: i=1; AJvYcCV2h9HWeS8EwXVjTYs5S+AClxht6DHiWS7UtbcutYah4VMSz5LSlbUfWnhyqBhIqdahXyOIsQ8v@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSfa1yeIq5jVFAioJNr47oserb8UKLG0z5mVZuEoPXeJgYSL7
	e6pgKVqHiwVFYz58mnBOLCRu0twKQ+YI0YvP8GY7GShT98lYZ9zGUliWAfdmLJKUFg==
X-Gm-Gg: ASbGncsppk5XCGHP3smBcFlf9H4/fnLUGX5WHk10qEFmvE3n3s28tz/jwy2nHlUsjab
	9Lg1ppQB2rVzhamsD3aozzLjwcWXQh2vZb7maGgdZJ7jNxX7YoE1kl49DJpz8qVlQLoqGOBihIz
	h29r3MOLcy5tRS9WiOAuicOIOPfpvtZXProaoQL8BgcY6fpo9gne1TAzzGI4N75j/FEeuUQvukM
	ug6ByUmK6bO/sK7c5uaIF9121x2r6QvIjN9b4O9lBqYOJjJyorL8cRNChUxH7RyL6FI2Xo90yhB
	g1wDq3c9C5sJ3ntQU7r6N2ZvJm4KskFLvcKIW9TcXn0nUO/JQNLkc4ZY9ufU4G9YteguFhIe1os
	hCrH9NUR/OMUT1ZL28gPtOzYlO64dmAigfZ3T6nhfZja3FgtNr514WyQIncqEzAp+Z+4=
X-Google-Smtp-Source: AGHT+IFFxlzYtv9/lJGBE1NR5KyO4C9Gn0dlEhp7e0IyW62FroGzl6MnQ1bI7Yv0CgoeIIwr0ShuyA==
X-Received: by 2002:a05:6214:ac3:b0:707:5759:8464 with SMTP id 6a1803df08f44-709e6d486b2mr6084496d6.44.1755019093063;
        Tue, 12 Aug 2025 10:18:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077ca1dc91sm179342506d6.27.2025.08.12.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:18:12 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:18:11 -0400
Message-ID: <c673760d9f02f494f06ea7df9ee6128a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250812_1310/pstg-lib:20250812_1218/pstg-pwork:20250812_1310
From: Paul Moore <paul@paul-moore.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH] selinux: Remove redundant __GFP_NOWARN
References: <20250807140545.566615-1-rongqianfeng@vivo.com>
In-Reply-To: <20250807140545.566615-1-rongqianfeng@vivo.com>

On Aug  7, 2025 Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> 
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Merged into selinux/dev with some minor tweaks to line wrapping and
horizontal alignment, thanks.

--
paul-moore.com
