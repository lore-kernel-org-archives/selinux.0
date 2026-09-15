Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF13DA7D4
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509098; cv=none; b=nJifM+tN+qJG+TI3PVQXHsRjvXfGKeH/kSXrI6kc5YzsiyKXplQSIWof2gkyHIly8qpSnTTHiJwdoHjh5U5XoT8Z5M3wGnwOW1HY6+HRf6VNvAMeem+YSluI9HJ9xvpZikxRk56xMCuvkMOWYL0r5NJdHHJXqhSg0aeTayrmq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509098; c=relaxed/simple;
	bh=ly65/lYJAv9yqMxGlq5L6FwkiHXB17HPHQFSTCFjswU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RwaumMzN6+bJMiglOGm3M0MpzvoOBI12tqajFhwvfCh1OESf+eJeJ0QatnaEnQbEUpJXmsOUgbM+2AkF2VQP9BSgXF5a6XLBke4rPsW3Rr9nr2JdZdztKEr8O3/ixcPgO+dcFCMJ+4hkQBPPMCG4719nP6i1n0/E9/2+EeA7Plk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W0h1UrOX; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W0h1UrOX"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb7so33973785a.0
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789509096; x=1790113896; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=way524WzPuZ5Bm0NV9da/+bG5TkEVW3nYeUYKhk/l2I=;
        b=W0h1UrOXuiXQrxUoqXh9PhzTYGyP9ak1+HCVMdRod99n2dgzecaUfgC901B7POIZFT
         lUv5tJB9qm+vyZqgTrb0OsutrCDlnn8ZxBod2ERfo6tOJ+qMJ6qNkJnqbr2TeRCJQkaJ
         ZgrXNSGXfBho/LsLEsXuLLn3AkUbv6e4lWEtPSIjJh3ZBapd404bfLtuknFUeW0eQI81
         gsOfVG+mpYqp6ylyQ6dWuJ+ViewomVoo9ZPCiXK3F05j8ZDhPXoZeXXgvDdGvcLe2jN+
         zbFvuwT1TwmaWaMpXSF9iwL+wT4UGNPpNwmkbgx7nRZjh/1zVhHybp4odE9CKrOE2Qrb
         ZI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789509096; x=1790113896;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=way524WzPuZ5Bm0NV9da/+bG5TkEVW3nYeUYKhk/l2I=;
        b=G5FJZ6zxPJGR9pztKqnILA2b9IRXKLSiHbhPJKGuGB/ZUhpSLP15ZXUXhh2Sl0gcqZ
         wOJ117wyGsGpAfxFabs2bryGR5SvNM36DSrn4HELFAeMfMBOo6qnB4oDWRis/3I7kL38
         Y8aw1qVF7qa5B5DlTW2VVmYEpyYdJUu+uoujLLIjkXXEcOBFB8VLWeR5ufTtjXcDaxsM
         Mt5vD27ZEeC/TLpnlV7BE812w8XowYxDyzUxg5t+FVatOMItIjxhv5oeRNSVuNy7Re+l
         FJDlCp3A87+dVtMJbC97ZWJmc5h56yMQ5ymCBPX9yTCIl9NS+JmdrXA8D4Pkb+7ywPhz
         8nYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKWJSTqkemQCpYXzBprneLP3kohgG79yNWB869DMlbmp4zhKzMFuiC4DBUaIB7mKlNRnN6gcaf@vger.kernel.org
X-Gm-Message-State: AFuF++mhmq1N/Kf8w9HLbyoA2PWnA8B8CK0smj5nhHqOHd/3xcH4vqxs
	aq1nwlDol2HWWDTcYBMB2GRuUAx613c9okR2KYMHezuCl3U8HbgnPpG9gRjAWS8J2Q==
X-Gm-Gg: AYBFou2SsnqhnmBf2G2cyVr6ePqnsT/ZZBMmemw+EsAlu6/F4QuC3byDpaSgrMp1CNt
	LfKyLXx5qZJWswV26oEihK8xJGSHAlIWqlA1ZJ560tNzSXntLXrqJYPKa9Ef1iT3cTamxTKny8l
	FkwatKlNcAd3itxi4nOhVzNSSbFPE7GNwoH0yewCKKHPXYHewGvIpJUOtZcgfiwIRe1QFqU7sf4
	eSjVWP9kGUsRRa/vRhD4ov97eZTXmIYJ2fZfg7kvtis0yyMDDWAZieQ6fYC9u5yYKLwX5d0DOb6
	uER8gupcp2E6n/Ar8dk1+BfvE1ZIQWgGkXYqUo4sCCv9ZFqy/q0ZXSmTiAFSUsvZEQV2bWUXzJ5
	brM6+AVGOFEbbIFJ814+r4yqmlxfOfQALUAjV5h+GhFqe2wlxJG3vLrUsn8dkRgYyzxDiJ5ws6Y
	eNPfRb2B0uQxN3YNkXI+oKz8u9MmInwhKPrUU2GKc1GL983Ula0/v4sb1bQy3EXFEuC4j/qnPzi
	Vyn/gRa3DGX1KHLIW4fsO3eZ+vpQJDxYozAL4lwXuUNlOS/vK+Co0wDLdGpFEu5GF7OvBzBeL+u
	k+CZxHYsUo0=
X-Received: by 2002:a05:620a:288b:b0:939:6de6:5487 with SMTP id af79cd13be357-93bb794cca1mr6778785a.44.1789509090720;
        Tue, 15 Sep 2026 14:51:30 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d147ffsm57637885a.43.2026.09.15.14.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:51:30 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:51:29 -0400
Message-ID: <f3f3f22a56760011aa9bf5c1ab45c95d@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260915_1728/pstg-lib:20260915_1318/pstg-pwork:20260915_1728
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] selinux: always fill AVC decision in  avc_has_perm_noaudit()
References: <20260903114338.77055-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260903114338.77055-1-cgoettsche@seltendoof.de>

On Sep  3, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> avc_has_perm_noaudit() is documented to return a copy of the access
> decision in @avd, but its early return for an empty requested permission
> set leaves the buffer untouched.  All callers pass an uninitialized
> stack variable and afterwards feed it to avc_audit(), and the inode hook
> even stores it in the per-task decision cache.
> 
> Fill in a deny-all, audit-all decision, similar to avd_init(), so every
> caller receives a defined value at no cost on the hot path.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Fixes: e6f2f381e4015386 ("selinux: replace BUG_ONs with WARN_ONs in avc.c")
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Good catch, thanks Christian.  I'm going to mark this for stable and
merge it via selinux/stable-7.3, if anyone would rather see this go via
the traditional selinux/dev branch please speak up in the next few days.

--
paul-moore.com
