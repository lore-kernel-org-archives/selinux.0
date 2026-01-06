Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126C2D7810
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737598; cv=none; b=skzKdMbtk/c8kCNPNenDUQbt+s8E4oCQfKqbW2Lgeh0BbeDcoVbzhRAWLcr5gHJk+qOW4iG5z3KHV09Sw6fspyfFLkO8zS+7pM6bz6Q8phA1as59xdu4wXHqXcM6OR1pPq69iP3KzwmU3Ev6OMWSt+RVtdam2gNsaUH+IiXEXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737598; c=relaxed/simple;
	bh=GluBh8m2y3PcEGE3+V9nl0D2yS7kGa0EPK26bG84vaA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=J7L74nmN2RBQP2YRCV0HgvRJtr/1kL3uKGBtAmHIwKg6Wj9DAmJ5kSTKodFEbS9vrdlUpH45zoUr5SdcADhETFsNMSKvVOr8XFiKJ+Vo+8W7FBOBJxMm0f5OustoD+6qWbROdZwYFrs7zPYjyZTOZOp631YMfrpRUdaMmsTLbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XQPsTu7C; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XQPsTu7C"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a379ca088so15808796d6.0
        for <selinux@vger.kernel.org>; Tue, 06 Jan 2026 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767737595; x=1768342395; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ndqp7w6INqSmDj45WR661sezFnhIaCas/O5ymSiHjQ=;
        b=XQPsTu7CGWrwhmDA1fIvenjHRnkIhsaeMXmGkj1NClTQtpGehA3W1yPzyQt/uQEqHq
         1NuPjhVh5s7OKK6+UmgUS45uqoKs1pJowLtUqO+yPsYDMjF2EaAQAEMOnNubOrpgEUlp
         AYAndsEGX4GCshBEHaDqRh0TIn7V3owdjZszR9sriC1xGb1Cseh7Vh9+OtwCVXQYDqy8
         B4cQ/hhAR4YowWtqMx+hzuHrDOLGvjBhMQh1l4zsGYOSv5Cski6EGr8OkhjAHMwN1b6B
         pPbAiHAYCAcBNjkklqbF1kYr38By80Zk9HNwHlIC/h5/nCKtyyrfXbS6O+Y49ilddWbx
         pYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767737595; x=1768342395;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ndqp7w6INqSmDj45WR661sezFnhIaCas/O5ymSiHjQ=;
        b=W1q2IjAA814ypMRZ3tKJFXX8a6WGwcZsnvIZTp3OlXc65T7D2oUkd9sm1tDKNdiVw6
         bsoR2cxNle0qk2J8X/A1dXib24yOsG/dQKJXo+4J7lYhxpZLxYke/ST83hy034rvNz7g
         iH+YvawoBsHv4m8T+e9IH9EuX0xzpS2UGGguq+aozsg6QkiZgyqaQyKZ2HvlemSslelz
         gxqTarXwAuAmT2PITPu7Nov5MpGV5wwVfKlvVNztYt4aJeQh3Yflut0KVCDoievkYNMI
         UnWLJsnhxyDDG0Pa/YWw+RipYU+rM8QAzTTNB33j98CU4KATu0uRdFbhAqSCnKhdU5GI
         84AA==
X-Forwarded-Encrypted: i=1; AJvYcCXNWbn2pw8iNKcJnC+kGoz8bjVrlM8JGuc1gfLDO32kRrVV+cIZ5u1HC882qUe1IESOzSYdyYso@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSgd79iTPCkWOYbuUNGLozTA0klsy+G0Cvg7dFIgqojg5F9j/
	pEQy3OfpmAfxKDqvFvQQFLU0Sa0mMJWLHglnjqgy0FPIP4MRE9jNgboCoGIv/7o2Wg==
X-Gm-Gg: AY/fxX6X7IoppulYQgDTEe+MfdVQKelWwTatppCJ1Wjhn41Sk4AKlzK4FfPvmSP5K54
	xMkPc5BUWpKg6WvagZ08EPXgVDFbxDYywO4dZ+RNwO4jwwMzXeucuSPAFa7JGoqkuK1vHiP06ry
	6fXT5ECSnMQePb5CnVyaVGwIhf38wMFJ8oJHlH2Ur+DgLqjwZnpdmcAX2HmKsFbDJX6h9jAHcPn
	gRpDhQfEt9i/o79eKgh+8+c8/Ml0bDHHEtmEO22TiY6PX2qVj+S0LJrGYSWSfZ7ladCxQWr4FB6
	Xu0ysfpWearfIqkfyLxn4fTOHOFb4dyOFe7Lzp9QJNvVWabL8OWDXtProGjk6Kw386HRMt9VWHK
	Hrffm+Fxy2r+KGBW+o544U6DwyANkzdvi6s55evHXeTgDyBezAqkOgAca2wR7+/zVROB3UizSUe
	cU4n+6JNnFLIYpc9ry//zHso5iIow9EtzINdgH/mpEa8XuZb7HOXZXtF4/
X-Google-Smtp-Source: AGHT+IHcmlCgI7WlFr18qOoSGtSo4kPbBkhNEeig2CIGNrNBUesdSzmx2NVuMD6+7V/OhPmQRFjH0A==
X-Received: by 2002:a05:6214:5509:b0:88a:525a:8db8 with SMTP id 6a1803df08f44-8908424fc75mr7312106d6.35.1767737595588;
        Tue, 06 Jan 2026 14:13:15 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm21004626d6.18.2026.01.06.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 14:13:14 -0800 (PST)
Date: Tue, 06 Jan 2026 17:13:13 -0500
Message-ID: <95dbf9af0e01953e2e6dca14eead406c@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260106_1639/pstg-lib:20260106_1639/pstg-pwork:20260106_1639
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, trondmy@kernel.org, anna@kernel.org
Cc: okorniev@redhat.com, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] nfs: unify security_inode_listsecurity() calls
References: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20251203195728.8592-1-stephen.smalley.work@gmail.com>

On Dec  3, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> security label") introduced a direct call to
> security_inode_listsecurity() in nfs4_listxattr(). However,
> nfs4_listxattr() already indirectly called
> security_inode_listsecurity() via nfs4_listxattr_nfs4_label() if
> CONFIG_NFS_V4_SECURITY_LABEL is enabled and the server has the
> NFS_CAP_SECURITY_LABEL capability enabled. This duplication was fixed
> by commit 9acb237deff7 ("NFSv4.2: another fix for listxattr") by
> making the second call conditional on NFS_CAP_SECURITY_LABEL not being
> set by the server. However, the combination of the two changes
> effectively makes one call to security_inode_listsecurity() in every
> case - which is the desired behavior since getxattr() always returns a
> security xattr even if it has to synthesize one. Further, the two
> different calls produce different xattr name ordering between
> security.* and user.* xattr names. Unify the two separate calls into a
> single call and get rid of nfs4_listxattr_nfs4_label() altogether.
> 
> Link: https://lore.kernel.org/selinux/CAEjxPJ6e8z__=MP5NfdUxkOMQ=EnUFSjWFofP4YPwHqK=Ki5nw@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 38 +++-----------------------------------
>  1 file changed, 3 insertions(+), 35 deletions(-)

It's been over a month without any comments, positive or negative, so
I'm going to go ahead and merge this into lsm/dev; if anyone has any
objections, ACKS, etc. please speak up soon.

Thanks Stephen.

--
paul-moore.com
