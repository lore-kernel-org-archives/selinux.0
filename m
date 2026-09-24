Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8914D5983
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285423; cv=none; b=NJdEKSDzJiPB7a+VFJcbFsN772yM6BLxsODjatIpfU7J787wMsfOU1yoVPoeFuotftp5HA+yZqu79fxV5rghOrOj2lwLDyQoSzxZ7XIC8uh9gxQolpoOGzmDEaYREjnJJj8Ib5cRGl8lf49Br1bzgXRz4a9JCzImdVK19d4NUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285423; c=relaxed/simple;
	bh=F59MoMMLkugmX8nRLyukxNYqecxuKeOlOzR/spj+qoA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pEsWcCtC2Um6iylEVoCsZ1KtKRP+frOV39C1nN31Ndk8HXWCAZmzqHKn5dHAuS3t3aK/YJRtGDPjEzOxLULrYlFTJKu39TK4MMaEJWEH6k1nykUYKQfc2zWjcumkhiPA0J77kz/GVzC1gyhSlrvRL666JJySaoMfsmLlUQ8P2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JGWCha0D; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JGWCha0D"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe20aso4075796d6.2
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790285418; x=1790890218; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I07fZ+U6aBwV+xv0U8I4P5EjEq9BZiIffOI/yblTsVk=;
        b=JGWCha0DVAy4YDE+eQsT4VpY1AfAiGVVi9wUG+sy4naOjVhWhzScgwW0Dv+ctMsL4/
         A8lOdFNpkjXbMQMMNSTVNFI10Mmx65FLvQfS9l1b/wIPwqKb+/ax1WO10TGU4/SaMnQk
         c+2aGV+n8Ntuy6b2WmnhQw4FyrKQykJNS/0EHepTnrwLqWmpBELgv2V0/T8uNTGKC0FJ
         XE/l2KaX9d8BiITll0Lo6KY/U+CyAyZKhwmuvbKvc253og9ZcQoHu7Q4gyc00j5jgFQa
         ospdcv6xKp0fVpbV6AMT7vS8Bkg+4HCJwFLZ8EYNwmnw1hI8Mu24KAsdr4uSwA9j41NG
         AAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790285418; x=1790890218;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I07fZ+U6aBwV+xv0U8I4P5EjEq9BZiIffOI/yblTsVk=;
        b=Vd94n18OC8CqNy2K/o0gR+F7XsbJfhPMwRZHJVudjCGWbCDPCB7m5l8qtaJn+LZPFy
         COr41gpZlpcRKQ2rwUloj+LfIhs9TtCdUWrC8vO02i/4pueG+7Zd1Pr3ICmAIScFSukd
         sXGDRSXTGALtSsz5t4v+75YUcyJmH14RkBU2MYJ7a5kk9LMJHI2MB3fga/hz5J7ExofX
         YThwh7bYlsVnrBqp+9J05AZhO/Fo5o/d3AaVVuhtDavB8Vzr0H+J3EKn1EU+aag4tQD4
         iPtKoa0Pfm71StTaQYR0tzw5Q7GuhJ+i+LPRtSgo4tf+HEyIU/oukV7Ht1Idyf37V5ee
         KQKg==
X-Forwarded-Encrypted: i=1; AKwUvBwq8N98WibxAPweTzfLYshAlDb4nN3D4d4cAIqdq24V4UpgaJlQUaiHeQSDBmxbCxnM76tfa9P4@vger.kernel.org
X-Gm-Message-State: AFuF++k+OWs1BjaasiXuFwa3MSMEYITY/+NsecfYordIEBYbWfJFciDm
	6Nwzfm3VN0ywfff8YwV1NrDmvOixBeY14PR5UWoPYaSJ65dL/3sBt9t1XT53pOyY3w==
X-Gm-Gg: AYBFou17GQLzSlkok49P0QEzJLC1dbjV5YT7sWEYvKgp5iUhAlkRA8h1KFmQnFtRb4m
	lcaL82c489ZCjJmFpVctHuMGCP7VdQKi71fjr/jpSfVL4iGndEQOvHotCf+rCSXdtV/LplPRnjz
	DUZviazx98ocgaAQQvVYCfj7vsEIy0h2HhFmCszcRsSub1lZ+FVi2Aul60c6TxgrWCQtIMaTIwa
	FOFOPx4m+xftXWku/AVCuY5C4BqGNhrT04RJqvmRq62oatIEpeeDeeV0hAH4yVjpfJIABSj3RR2
	mr2BeLAlaeSuQ7HMith0AXwyWH5MDek5UtZ8DAcJkKcHv4Dvo+IiOoyFMlW1g5YDq1R8ZLJoAsh
	Yd8SMJuuogdrG1udctgChhUb7DEFzzIcERb84vmbr9FILGp0nFGYc3IAy2YFfFcayPOXBDTPB5Q
	cSMqdCtSM72OTXpB0ozk66OYlCWaSx5LxTU42Ptu9FdZUpWwwGmJUDTP2oYlHsJruDqxObKu2Vl
	v/N856KGiVldkrwKJgvBXxpfXOD/L+lShJc3jPJUUgZ+C9ET8ORLwIOFBrRHGCI9AwWw67mbAo=
X-Received: by 2002:a05:6214:5345:b0:910:3453:505d with SMTP id 6a1803df08f44-9142f8f69a4mr9631146d6.31.1790285417723;
        Thu, 24 Sep 2026 14:30:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e0be09sm2699576d6.29.2026.09.24.14.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:30:17 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:30:16 -0400
Message-ID: <41a06ba1784707e62f2e0ef06c1652c7@paul-moore.com>
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
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH 2/5] selinux: bounds-check filename transition source types  at load
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-1-cgoettsche@seltendoof.de>

On Sep  3, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> filename_trans_read_helper() validates the target type, target class and
> each datum's otype, but the per-datum stypes ebitmap is read without any
> bound on its set bits.
> Reject a stypes bitmap whose highest set bit is not a defined type.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 4 ++++
>  1 file changed, 4 insertions(+)

Merged into selinux/dev, thanks!

--
paul-moore.com
