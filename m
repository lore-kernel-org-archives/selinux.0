Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2552755E0
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600886; cv=none; b=rxwc10WpTTLVgH84U7mS7c63BQlD+aK6ny+j/B8MsU8IaejQ3Zi7S8l7zks1Ip/xo5RmD6hNb5eqgrybDVuZhwYleGdiwg61103JoLRSoJbYDVSFBymFq6JGSKjWfmDL9tVAjoG/uCOb0YI0UHqBwj/W/eWzDQ5kN9jg7hvhDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600886; c=relaxed/simple;
	bh=RYhyiIVWz9eFn2w79ZC0aXWXcXzgo5ScTBPjf4pmajE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=m89skOOhBI8UR/XXni3F+0xGtAd4cd+QYTCDmtdHMzTn6IXExFkkmwp7bUT8NIcTE2sZ2Odfzvgg2ORyblGQOzhposeKrXHi6NgK9aC/DvnK77Lu5PqQTW8KgZ9zj7ZVb8YWoo1nOQ6qAULjYKRpqL+3bodcZT7+rYLJqAZNOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CkdSYGOz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CkdSYGOz"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0ba9825e9so13134685a.0
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740600883; x=1741205683; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/m858znNp+e/bEeyuLLSlFR+G7YCuRp1y/0iqr49/o=;
        b=CkdSYGOzjipGNbgKg9MHVK1eM3p6Ved0KDxYlRYa+8qlt0zjZ+46xa8AFtC5nIR5Fn
         x1ApIwTCC+syWZfq1Mw7wMXDUJaLbU0fnNj0YnQaRPTfFWl0oAj+4kSIAS6wN+LwYtKW
         B55reWj6x3Dka/OecLSGKuh9RHXS5LfRkk5LrB1eUkMh1DrWb8bIoN3MhnEAo7nTkf9J
         eU4V0ANYz+K4tIjCsmOmj2zooObaYhGyUtc5e8ZdzoQyozdTQxeINTBBwzknkiLwkuf3
         +3gYlqXdG+ydhETOfjbFWW/BlwQrX6SKJkPEwhCJd/sx5Q0IVQoNiF6O3P87HUl/eMDp
         RX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600883; x=1741205683;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8/m858znNp+e/bEeyuLLSlFR+G7YCuRp1y/0iqr49/o=;
        b=VVfjS2k4cf3zU/hu0o2mfMAjodrUp42wvnHWCQ+7MkBwvGY8jLoUWU1yVXKu1D63mK
         HCJm37ydaDV34mv4AhyOVcDjwSe88zZNXsHke8ce2luFlbM0BeB8oFfdOIxJQCIqC+es
         SDqLi0EcNDYv3CmtYT7puTvYPDPgnrGepM6iPbZqPlq37S8OwxeX+DbVINtr0I0DnLjt
         VWIS0WNFAbX2cQV12Z3p2pWuvLzBNBE3SuweJZIf8/12eSAEKoSunwwHPx4dXd5QTIrR
         5mjSQVEJWyKRSzngspMe4/lIUGJDe+MKdp/gv4L+wWjYz/pGOQxunnWQeUWDh7QQkpMU
         Qt6g==
X-Forwarded-Encrypted: i=1; AJvYcCV0h2CgZNE6attuR4vt3GYnAZ+0HGJjgHVsPUn88gV/w9ghie7ONzhvMgYaHrh70o9GjA3c3LVZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwKK9JJPc5qupv9hSLAoR4Lre5HfRHmnCfYAVIueHI+1bolaC2L
	mmrBDur9QjmMkXbv/hhvwVIiI5HiBhlTTTnP/hG3Sfx8wE0l2sWtNANyGlGtvg==
X-Gm-Gg: ASbGnctn3aJPcQScggitbBu8M4uJFzPcoGQ1IY3U0Ex563bwpkknS8adh1fBSrPt5OF
	R7X/tOdie63qCFvyD6nRVN+Jn3+rgUgjtXyjdO4bRy+XvCnojgBnzbUjA8wZViosCbfTxVQ9zpJ
	9phXjkxap4yMCEviIXPcshdc71AulCKumxiSoaLO5MeHSLPjLojOn7rk2KSBLo1DnqJeP8JHEbd
	qLfKCOvyNEZTNMpHPbNgkniAeVWNvg4t+vOfIfpNwQX1ZwxEiYSmtVTLUh5o5EyTgPxdxAD/Jzl
	u1tKRxSMGpF/PR/+Icb+bQBp56y8SOC6mrQJFzPS8dnasd3cyu62Rh6YWB8uvWdbFUxdSYY=
X-Google-Smtp-Source: AGHT+IGOmSQpXkUnZdYt3mMxmKIKuJThMobl2OAw26tHyyC7x+W3/uSQd654Hib3GW+DawwwLa83SQ==
X-Received: by 2002:a05:620a:1a8c:b0:7c0:9ac5:7fb6 with SMTP id af79cd13be357-7c247f00cd6mr730633285a.7.1740600882744;
        Wed, 26 Feb 2025 12:14:42 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c23c327f4esm292153985a.75.2025.02.26.12.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:14:42 -0800 (PST)
Date: Wed, 26 Feb 2025 15:14:41 -0500
Message-ID: <f1c9e72d2c44e7c6dcafed2d24b26b7f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: kippndavis.work@gmx.com, selinux@vger.kernel.org
Cc: omosnace@redhat.com, stephen.smalley.work@gmail.com
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds  of kernel files
References: <20250211182159.37744-1-kippndavis.work@gmx.com>
In-Reply-To: <20250211182159.37744-1-kippndavis.work@gmx.com>

On Feb 11, 2025 kippndavis.work@gmx.com wrote:
> 
> Although the LSM hooks for loading kernel modules were later generalized
> to cover loading other kinds of files, SELinux didn't implement
> corresponding permission checks, leaving only the module case covered.
> Define and add new permission checks for these other cases.
> 
> Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes in v2:
>   - Removed the `-EACCES` return in default case in
>     selinux_kernel_read_file() and selinux_kernel_load_from_file(),
>     reverting previous fallback behavior.
>   - Added a compile-time check in these	functions to catch new
>     READING/LOADING_XXX	entries.
> 
> Thanks for your review! I've adjusted the default case so as to not
> return an error and depart from pre-existing logic. I first tried to use
> the pre-processor #errors but failed with the READING/LOADING_MAX_ID
> enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
> those same enums instead to catch new entries.
> ---
>  security/selinux/hooks.c            | 56 +++++++++++++++++++++++------
>  security/selinux/include/classmap.h |  4 ++-
>  2 files changed, 49 insertions(+), 11 deletions(-)

I too am a little concerned about confusion around the policy load
permission name, but after reading through all the suggestions and trying
to think of something better I'm left with the feeling that no matter
what we pick it is going to be awkward/confusing.  With that in mind,
I think the choice in this patch is as good as any, so let's just stick
with that.

Merged into selinux/dev, thanks everyone!

--
paul-moore.com
