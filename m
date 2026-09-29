Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E33DAAAF
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696128; cv=pass; b=p45heCNI3BZ2/q4T8wocHbM4NMHVFbIUQ1zsX3n6JDb1I6TbCLfl6hfTyiRV+Kl6YJS8c9XKUgMEMgHFNcnaAc/pO1+m5Xll3GNi3bITz0qmEf5KBInYw+psEwN16m+irO0GwVYo+hsI6HfFuDJGNbDOt6MvfY3KRDUqMjwyDzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696128; c=relaxed/simple;
	bh=NAX/FwX82D9AaxkTQ0a+Ema0giIHNnMakUrxw8akkEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yc5ZuIqWYdKzDffsXSgn0lCCHa23JfjuuMCYPeKDUtOEdWeLD+DIsa3qHDRdyx8Lx8iULOhhX9GlKJVgF3aw6DgT9LaCod6HkbSTMQzUcAvX5Gwfp8/rGD8rqfNNLmye2rpuqAOMb6Hhtgtc/37eOGFTJYSEDBJ/ljAI6asrLf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2R2Guwd; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2R2Guwd"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab441c70f2so6680247b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696125; cv=none;
        d=google.com; s=arc-20260327;
        b=aCXzNdMEEPQ46c142FtjyIHN5LHSKO+Du30E7S9WsQG8KLzjNTFEX+zxCepSiWT7P3
         MsXb0jzHMwFmmHJlvUL6Zn7Nu0UJ2N5Ww0Xm+1S+/KHHUSbLf1YJYjsPwarkI+z/hFVk
         +hJuKlnFaDgEob3fdla7mJ7XCfUZxG+oeHya3T/zGiEU6G/1bubCIOhrIhqCkczumt8w
         kcAyb/rvW9t6parky55IxVvnS30U48Rb0h2zLUBIpGsetpub6nkyyIWp+xDaDCo/AdJm
         W6GF8Pejkh6x340He2qmkmh70Ovcn3WpkRQzSo9AC2ISueK7yHmCkkJsE4HLcgTa+2l1
         TQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ODlbwll3NIElosxsbV/bwkK5yDrQzKpIU2sOtyWNXuY=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=V01N+xpOuTUTUGUeSMMpwzGYGmOySC61aQVeVDup9q96fUmvG/dOYUD3b5Q09i5PbA
         xffef1O9UzJw47hCt8/00Y1QEloCmtlWzyicnvtjb5HgoToep6CnWP3d5ekG4rOz5o7Y
         qKWy1oXN4YiYUsFgGUECJgUMQua1A9MYCE7rORinVrRer43BLxpZiwyWG3IhrDgIslWO
         ch4hrRGltg27/qs3VRAiIgDRVLw3j1Qimz7necfpFm4HvGncDeppmn/3da8IC1uqbzLl
         1TLq4epIaSAyqXW0PEGf6bNkE7OWRrI/kUZR8NvlVqnBmuVYD8LKG9NZkY+eCGOPrcAi
         8JUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696125; x=1791300925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ODlbwll3NIElosxsbV/bwkK5yDrQzKpIU2sOtyWNXuY=;
        b=G2R2GuwdLNw3/DUWPcBz5WiBeeWBxPDNGC64UqiZgco9MiN1z2jtnW61CYT5VU8Wm3
         r2qk5Hr1ERkMHEvM4/aQGFzFglggNJjjXRKHC5AEqIyIl9ejyv7gXTMnYAFOtuto1G0I
         Bpcvd8xWGdaFF36r0/kppOiVcs2s14OhhOwU07bTT4q71A2/gQ2kJBw68cWcRzWW/RMK
         UE9r84fnhIEHaPQLvmD+uIoOeuostYn6HFaNFVl/+bKc5Wy1Q2jCY/DyiuvbNA8qMEO7
         Etog+vkogIcu/8yL+skN3s4a2XTVpi7CH5nMGEgopQV+a8TvD+JK3nW9T6q0FH+hnT/G
         UhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696125; x=1791300925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODlbwll3NIElosxsbV/bwkK5yDrQzKpIU2sOtyWNXuY=;
        b=zdBN8czzeay28/BYQrbbR0l/fMpfCpleC5+m5Q6wUZ2iLepjjhCD6cBF/bmAowNine
         gBB/tEuRIcpqXKYoKY14tipDj1gfWGgDG3xwVyqAN/rilCPWOxLVCavr89j6WpMaPmse
         /vPm6g+eCvsyVCBAXGCMnynPWJXZ0J3onMHeRRb6VmPA50DlV4xTDOHm+xZD/iK4p6AY
         EfmMg2jTqvb2tF0BwVvyTwx+bfhZ7/o/jVqqZyD1a+bDm6a284iiqBHIGQmUYY/0Pvb0
         FEF0Dq5NBwL1MnvcljvobXCD0iCqhSDTUYCmUNGBGdgdZyvYIlnU/EPcUOm+jYDBEoKH
         mGRg==
X-Gm-Message-State: AFq9FYJ8psP8+0KtRgvT+ofq4b/WOn6hlZSa397jAHbXQ3s7VnEcarTo
	7VY6M1Pjs3tSKCRGNRx/Vb4UF8nfiK86eg5ly6PFGcwTw/uK61Ns4XUwSTOLudKfkWBKI1KkO3v
	OQoAJ/PFQmtiKJ2nvcXqnmLU5DDZ/uSDkldcF
X-Gm-Gg: AYBFou31irPHpBSDmDcmqugGeo18Ewb2G3mxRzcntyawYi0IgIW3AhoQNsZDY8PQA+v
	easfpJUCcYZSzzJOkytvVBle9erTHhf+KKHQ014aaPclpVWA3yMyXtpX3lfI3LfJU2TtRTxLqQn
	lTtjkIRF01pz6b1an9vtV/i50z7yyZx/nOKfPex4B+xa/mdKxE8PQ3cPXKP+rXEpSn8AfSNmAv3
	dmK3vrkJwllJfbd5IyksC/LPZ8hdNUf3jva88+ubpEWjd1SVzicA+h+csb6pt9sk5DaVOFoI8WT
	BG9JLphw8Owpb39xzJV+tM2QJtN4IsrkwJvh0EA7cc7P8QXPAAy0myU=
X-Received: by 2002:a05:690c:c4e8:b0:8ab:41a5:648 with SMTP id
 00721157ae682-8ab41a514efmr9525477b3.11.1790696125518; Tue, 29 Sep 2026
 08:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-7-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:35:14 -0400
X-Gm-Features: AclHuK9-xlWfShk_nlMYviFpVeTdu7PWMkC9whItuRd6wdqswhD6eJ3wcwInjGs
Message-ID: <CAEjxPJ4a445RA5szOGXm-hrpY97+=9-+bDqGqDusG3SA_hY14g@mail.gmail.com>
Subject: Re: [RFC PATCH 08/32] selinux: use rounddown() and roundup() in ebitmap
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use the generic rounding helpers instead of open-coding them, as
> ebitmap_write() already does.  EBITMAP_SIZE is not necessarily a power
> of two, so the non power-of-two variants are required.
>
> This also changes ebitmap_read() near the u32 highbit limit on 64-bit
> systems.  EBITMAP_SIZE has type size_t, so the addition is no longer
> truncated to u32 before rounding down.  For example, a bitmap with
> highbit 0xffffff00 and a nonzero map at startbit 0xfffffec0 is now read
> normally instead of being accepted as empty without consuming its node.
> Bitmaps whose rounded end exceeds u32 now fail validation instead of
> being treated as empty.  The 32-bit arithmetic is unchanged.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
