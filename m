Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEDA326D53
	for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485086; cv=none; b=h2a0u/73qdV9+4qJ6O9wshdhKptUPRnr6PiHbUavf0YDPvtKgs3OMQ+AuYqhSoLPEUDSZTVPS6MX4iH79Eb66ZwFfUSv53dXX983gTTvyBhYYTAHbXxSPiRDUPMp1JdjLd0AYlqCA1tvgeVODxErt8r2+SXJUecQuz/UtUJngqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485086; c=relaxed/simple;
	bh=pHyUzdGIEuMbKyrMh+j6H6WX/5fl8Lbl5tqXrks6ehM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHMhcoexFz+H+rdPbLZR2T2ekUqKD/JO0CMcgDkeRJK2XcT+V72U7NFamQ+OQwq8bIe5M+53Uc3KSFfgcxyR6D3ufeAaxYikplASk7FVtAq/s+jVnvKN1WduisI2wpkQr7O3bAyTKDppH9a1byVtnjxeNekqtE4CjVbMT/DttGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRd13MX+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRd13MX+"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c1so9901565ab.0
        for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756485084; x=1757089884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Aq9F6GkDNRj0W5kCY4QlKzlsKBjTYse7H5/E8RG41o=;
        b=KRd13MX+7P+3AH1dA3PWUdQuEZ8rs/th7cksPNkocp07v0xeyyGkAy+3IcJvplUUey
         gZSuI26Yh3yQLilHOzqjiZZW0eOWzDqkzVi9/1JGMq1jqHmp4pIdWA31iY4pBnVC1t7g
         0Tb5xvzZWeW+4vq6MrY+JS/AylEx0AVFNGv7Y/H0CLuYwy+69qRPCbiWbKGs/I2BADCM
         YobVpfstmo+i9xDaXOEkVyj4d7sRQFG3RZ1Ay1DFpsdJyR40edcONvx5yRbfKmqshjlY
         dbjuf5D17B16unQBmCqz8jY3VYzVArhGFHSco2e+t4dHQS/g3Ba5cYH2BrXWDFDLFvKk
         uUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485084; x=1757089884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Aq9F6GkDNRj0W5kCY4QlKzlsKBjTYse7H5/E8RG41o=;
        b=WrJQQyHyq7wmCLyYQZmpgSBny8H9msBfxOIMecCKrArDkUGgoa0WqxgSDkShUAw3qM
         qOz/+HIFErMNOvUf71tLHQIzxBMWhJEI3+898K8U2r4R1E+9B6m6x1Ad/8MvyVHwSfCR
         NsIBUo5OvQ2/whLHZk835Z4SWj2cAJAUEYbZAeI6niNNYF4bORV8sN+NcRbHacHwmSX2
         bsJfYPDrOup8IUcoxDh8F8SRogcd/c8cCVjLBnE/qbB0m+lT1gw1KMZlNwdshHbAzp8F
         Is7YtjJ757Qm2YgjTuOl4nNeFxWPp4IisIkGfEtzq9chx3AAHaEw6sGaHlxQWcMKqiJ0
         Sp4g==
X-Forwarded-Encrypted: i=1; AJvYcCU1CowA6DDD+AZPmDc2Jo1rYYGtC7Zi+DgSxQ8lfRqT7PbkKQ6YtpsVJazFIrTX2A63M2ypoFCq@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmrLwlMTXNnuS5kebumq9Ztu0qMKqkxrq8ls48Xgrlq2JWxLg
	Hclp7qNibPBVm3Es983szAFA2RzbUrAhxWlIlu/Qh+prsTYs3uqS7WlpzpPh/qOSBg==
X-Gm-Gg: ASbGncsKUeLS7jPYkZ9l5iH0wQlMpM7UpR8iVGr2ZbQcLqQZ4Pvp164XINiibTegOhN
	PpvD/N00hwYOML6lJ9B28mfisp4kXeaPNnL1FUuF3GNAz9UAzMtOyLEGzZWlVJTCx2NUGQLE8Gq
	zPSrjKGUoQsRZfw6s8XYJ9vpb5bYUlkkaFf7IYEyaR6EJ/HC9G1MPtyV/T56punaIybXm1cEYVS
	sYKVrtHo29bCiLcI3Lrdoj1tt7R4ejv0/YKWS0DZCoZCgpN0JTin1nBFkL967i6lxd+lY5E2EaE
	JUKeMVNV484PQeAiVj3cM/jqFWfiVtaDB1sxikyQe7CqHlCbk0DsZ6jUgEptgsnKCLxRypdS7ow
	+WHLpyfp9Tpl74H/e3IrxjNx+Azlc2h8IsA0NlzSS78LmZ/H5oEbDdLCzoIySG8JCNA==
X-Google-Smtp-Source: AGHT+IH8g3k6EVCj6uu/y7CYnCfGfvfUlntaVdqZjmhIzXo0V9tMdpenbFbzM26tob/Rtwf21Sm4Ew==
X-Received: by 2002:a05:6e02:16ce:b0:3e5:4631:547c with SMTP id e9e14a558f8ab-3e921d461a5mr379924525ab.14.1756485083760;
        Fri, 29 Aug 2025 09:31:23 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f29f7864easm8752885ab.20.2025.08.29.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:31:23 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:31:21 +0000
From: Neill Kapron <nkapron@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	kernel-team@android.com, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: enable per-file labeling for functionfs
Message-ID: <aLHV2Tb5aw1Znfw8@google.com>
References: <20250828170317.2322582-1-nkapron@google.com>
 <CAEjxPJ7-M5OAiTLmOynP36HF6XmJKhH2kTFAGmhg8ohCkZuT8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7-M5OAiTLmOynP36HF6XmJKhH2kTFAGmhg8ohCkZuT8w@mail.gmail.com>

On Fri, Aug 29, 2025 at 08:18:08AM -0400, Stephen Smalley wrote:
 
> As before, don't rely on the policy capability bit remaining stable
> until Paul merges this patch.
> Also, not worth re-spinning IMHO but the changelog below normally goes
> after the "---" before
> the diffstat so that it doesn't get included in the commit message
> since no one cares about
> the in-submission changes once the patch is merged.

Thanks, I appreciate your guidance on this!

Neill
