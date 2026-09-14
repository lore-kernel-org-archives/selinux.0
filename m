Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C049F10D
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418518; cv=none; b=ZBgj3iHqoQJ5Lf6hvpuXkvUZfHrGr33pqiIvlr4TIEh0dYYnQIaT9Qi3SLXlafYrCXVP7C+XZg81erkx+HqX8X+PBDH6LyHM1rhwSmoa8Nf2IizAyUGpI4cXSWsnqOX7qXjGsdSPdPfIBMSfrpq73J8FkW1Xd78zwhSqS5pGMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418518; c=relaxed/simple;
	bh=NGWB4j6Qtj1I45qJXTxUF3DXiZ03+1wrOcaEWMEdRtc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mxcp4ngSRMO34HH+US4HoL86EI93qsXQaey9iQNE+sxwhC/afzsUa23PDyJgJYWRyX8TJZd6Yo7f9fufUEsIiyQjTMMGlrhriwEa9oRLik6lUomAuGm63xAHkjuMrfHf5f6RDNVDEG3S7oLoInvr/vpgBsjg7muQcfh2uJY2QAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BKJZYJqx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BKJZYJqx"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-530e5b2cab9so15262581cf.0
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789418512; x=1790023312; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=BKJZYJqxLJgFemMBcjr5I/aDXNKPtJB3WRJtLpLBN90kCCOc2ISZa//Hx+A9+uy7hz
         KotROizMJXWX9tEzVf5O2jdHFH3zcLlGP6MzE7D9BcffRwl5dnFhOwNpSiEVpj1HEnJ7
         EvvPhvn7MfJE76qXhcCt4bZKswpUqfwd0aWhG8mfZX2zxmbfWiqBIzrihkzUvkRM4+pU
         0txeqCV4C+FMMdpJa03B+HismbOogUi7Ezhk+FqcN08IynGTUWXRYeAFxW76NBiVlJ0L
         L414LmF6/TYULPjGTgneeLNYrcAk3bxDHO3JN/fQrYxHr7NjczBjhvGl0Vfc2MBYNYf7
         gRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418512; x=1790023312;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=VAc+tTOcTF5aiv1NxI3bzHjzshL8bZr0JNsYe/uPyUmeA/iPEdSjHmuCoxz83RtviJ
         1Dl8w8r/QFl2/yfDgpjbfVP7v0VLO0j4PWf83aHT+Ir3x9FSXqLks2pZUZPy3f5VdSek
         VrA98GBOjUzCOzFTtXQH/oHYnmLwyMPsVo1guO0PVAJXuXrNz/g1YEhT7yuXtuIxRkcv
         TuHKwPN9Q0dusOE9m+6wup9xMfMj5B6bUSdKSXZqIkbJ2azTJNcmo5tCFKLoz2Jws7OQ
         pGW0gLL8bVT/D/Yorts7I1ZjaiNj+4PbdTYoKffZ9z2cBL6hAKAexb4X9Dxak8udLUKQ
         27Ww==
X-Forwarded-Encrypted: i=1; AKwUvBztbtV0gmnKRTszZoD3BFFziIlNW1RgDXzdyggIhS/FG13D7QLaGNGIspnt2v/01Pnlmg2qYq2D@vger.kernel.org
X-Gm-Message-State: AFuF++lXdLRkbI8F6BCvg1xLWMy0T+mK0VgYr3VMbob2JanAnWcNo63e
	xZXI3IFJ0ZAbg7K2ryEi7tGkyclhpwKEBTyxR4bMb6IcoPlxvIsgJkx3KIe2lHIUDA==
X-Gm-Gg: AYBFou3MVIchrxE48eWD1egKVOTVhz9jo6zDQPtfKtkoos7UDAHGVZq6CW2v8WoP+Jt
	s2zuxJsRiK6InyqBcc1t/EvXrafbnOFd4qKUPLJ8/lGvBRNuxDoNrWKmoXUugKzCqb5e7aUT6Lx
	hleGjvxr0PUn/tIS8IVeYRjt3On53z9nzDjhgV4A8HQ04kW/5l2LXDwONUWTQNT1f8XLmFO5Kjl
	RoBYZBRiG7KVd41sh3xCQgJZgM/Z9H+qQYnHl1xEaS3xSSZp2FhEQvtG8hEHlzSss6e3Xb/6aR2
	9YT2lygsw4JfjoGE850/i32yPbV1t2Ax/5K2c2Hnp+qxOE7Nnb+lkgMVXZkAwyHZUfsiWX6QOxM
	0llSEBEZrUdB8Ypp+/JxD30fq9HbAmgd+XA4vtB439gx0zqNUHFGdh+DkLYgMbrQigEgZPgbMUK
	KcJIQWMmYClcoDQpb59NutVd7/Fi2lIrwnsqapPAjl4UXPRBBqXdI6bKi0wID2W09uiGVtJ7mtY
	P+ETQethPzUehp4OPuvHOGDqlniHFuUwiWy3ny+CZnUTXhSdTtYc/VL07FwrHRs/RFw8gblUIYk
X-Received: by 2002:a05:622a:15d6:b0:530:b2e1:8e38 with SMTP id d75a77b69052e-5310d063e03mr64295201cf.51.1789418511760;
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca3098easm108403901cf.3.2026.09.14.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:41:50 -0400
Message-ID: <af4448a7a2b428d0f4af0ea4c19abeff@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260914_1619/pstg-lib:20260914_1251/pstg-pwork:20260914_1619
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] lsm: Preserve full ioctl commands in audit records
References: <20260910144837.381855-2-mic@digikod.net>
In-Reply-To: <20260910144837.381855-2-mic@digikod.net>

On Sep 10, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Ioctl commands are unsigned int values, with their encoded direction and
> size in the upper 16 bits.  However, struct lsm_ioctlop_audit keeps only
> a u16, and the common audit formatter uses %hx.  This logs 0xc00ffeee as
> 0xfeee and makes distinct commands with matching low 16 bits
> indistinguishable.
> 
> Change cmd to unsigned int and use %x.  Pass the full command through
> ioctl_has_perm() as well.  Its driver and xperm values remain u8 values
> derived from the same low 16 bits, so SELinux enforcement does not
> change.  Commands that fit in 16 bits keep the same audit text.
> 
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 671a2781ff01 ("security: add ioctl specific auditing to lsm_audit")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/linux/lsm_audit.h | 2 +-
>  security/lsm_audit.c      | 2 +-
>  security/selinux/hooks.c  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

This looks good, thanks Mickaël.

However, I am going to drop the stable tag and merge this via lsm/dev
instead of lsm/stable-7.3 simply because we're changing the audit field
(going from a 16-bit to 32-bit hex string) and I don't want that to catch
anyone by surprise in a stable kernel release.  I will leave the 'Fixes:'
tag for reference in case there is a downstream that wants to pick this
up as a fix.

--
paul-moore.com
