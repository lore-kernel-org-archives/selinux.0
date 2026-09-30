Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45033A6F1
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795443; cv=none; b=UZx+8A5Dsmlbf2Bu346hNb+HyIDtoGp2j+K35FnkMjNHmoP/f9r91BhKshesvgFHHcY3nKWgQYNEm6NK/W22wKSIWQvna5TzxFoCVU8ZPs8qbrQwTPFxKH7DsI8XKOKw/zgaMJnhxsRL6CqVdEx6nsH+wO1xG2KsUN4vaELXLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795443; c=relaxed/simple;
	bh=b1B5zTrMiOlogTJdVHoC/5PfyNLUXVg+mnkd/ShkCaA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=r5Mi8EiJTU9i0zVpmZeb/9mLGPKd+PnIY6lBbZIw/1KQGJaO+8FQc3MaSbhtPRiO4RtXKmHnjuY1gVgowe3qk8hlpbpt0uVT+RG8MCEy/5Rfirue0ifHMBcC5bInqekAN+mxNE9KBUUYbL6SKLGdWDb8J2SqjAHgKdVwYHJASJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c/2QSzGX; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c/2QSzGX"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5338322d418so888761cf.1
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790795440; x=1791400240; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJRvZBYMPCBba1Tt4fmja+uun5L8buzR2kCGl+7+Hpc=;
        b=c/2QSzGXFqNGfD4lB5OCHt5FswPZgG7qIGSiq2vrQfFV3vJv9VErSCdSrQs3aLxh/8
         QpWCF6Dsbu2yMZMj4njLVLYYdjXRx/u7M90Qf0/vX34yTWPUI242pXQNOJ2WyzVTFx/U
         uo0F6AC9+Gj1xCkiH2DCFoWnxfR5nmgJJCokCWpvb7tk7NafIwzfiW5jpH2dyLri+sHc
         LdF/50eu0l/cB7BRKh4da+199V1ytZYgREp3blei1j8S/nOMmq4zMoU8DfnwGWD+QSF+
         XDOCtWZV3QgZg9frHyjTqAaoJUQv7Y+t6MmJS7p3IdWjbGNpi17+Wr5Myt75eJdfh0pb
         3lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795440; x=1791400240;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJRvZBYMPCBba1Tt4fmja+uun5L8buzR2kCGl+7+Hpc=;
        b=G9WI2VKc8QidCdPQHQOPvheb7X86kgDsQQxGq8e8rPiOwlBxBBfjpo24BdObsAS6U1
         Kn7k8Zdpsmg9V1V4NDW/M5vgwpeZCh1A7BK9s4HVmQaWvZxE4y4WaqXxOjN3UYJOqZ0k
         QSmQpkdybdqWCmiYUI1KH/+D6VJpQKRYOOW9rl+Q3egIO/eueA1q4PfE0z+hOuqxzTGL
         u7Bp9MiA69BYsh2TGMflaN8twAdbXhP49GvO68gt8MVUEigeyvTJXETXPYD2CcChwDsN
         Y1UU1F6tCPnB750+8ZcyZ4ZP77HovZnWu/bzBCjGfkbF9FI9uDa+zdOMHzWgT7LXnb6i
         H4LQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/W1NPVmC9gXY4EW/7KG4Q7JdgCFyfDGPJwJGfdIdI42RF+URUUb7kLfcH339opWlKjYo4LOeI@vger.kernel.org
X-Gm-Message-State: AFuF++lM61lU8JkqVWhAhw+uhkE6V91v19tv6eR/Ypu5UxgC4dnPr4GT
	McqeUflTz9+PrdRrgHf47qabwDGpLDISz2yWiQX3odKt2JtkYQeEr1rE1OUltfoMrtO8y0L3pWY
	KH2a8SQ==
X-Gm-Gg: AYBFou1mfxxbPvODsyMkAJsWgHazN5z3+ppiGrW+P5fwh9kw7KxkF1vbaqoav3CGl/y
	Vglaq+Ckz3SBOlZRYP4uOOwtaOWx7jzCm1+JclXbx18pjQHXG4Ko2y4iKkm1wsLLf1HmBtFyuSi
	jGYawkn1EaRlDfQuG6abgbuEfZdQcxHC7uWOwLPV/r6dYpM7Bw6TJTkM91Og5RWP6945A5FgYS4
	np/4fBuL7toZUSX2gZEABxTEcryxSAeT94wRBqFMGhg3UGAekRRlrYfSbbFebezVQPwjchdAGHc
	Y34Xmzu7aAoXVtg+zkwYkfvNnWFqSIWTCPcNa+X+1I2dRyJk1zFseswnPDBOsznk3sozOKKAQgp
	woX7BFbbR/JZcqEV7iyO/IhDbqhnsN5G7TANe3h1iCmrKWzhpzn25t3FHEwfEK8N6Ra/wGRUcXA
	wW9nPeBDh4w1qBmjPaqqSSNX6Lkd1k/CjsRCT6EBOBGxwUMB4cUEcoooxIwlgigk63snIrM4Vsb
	T4FhhObS+iUCo76RLMmOhdjb4Y1+IloJUgeBj/O7812HKwDzKoNsQG9FzQldmteXuH8n4AHpGw=
X-Received: by 2002:ac8:6f12:0:b0:530:fbd3:2038 with SMTP id d75a77b69052e-533833fe5aamr11697871cf.26.1790795440462;
        Wed, 30 Sep 2026 12:10:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53386140560sm2551cf.11.2026.09.30.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:10:38 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:10:37 -0400
Message-ID: <70496fd60aef3673da80b79ee28c8628@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260929_2146/pstg-lib:20260930_1504/pstg-pwork:20260929_2146
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] selinux: preserve NATIVE_LABELS on already-initialized sb  in set_mnt_opts
References: <20260928141917.17577-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260928141917.17577-1-stephen.smalley.work@gmail.com>

On Sep 28, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> When an NFSv4 filesystem exported with security_label is mounted a
> second time, sget_fc() returns the existing superblock and
> nfs_get_root() calls security_sb_set_mnt_opts() again on it. Since the
> superblock is already SB_INITIALIZED, selinux_set_mnt_opts() takes an
> early exit without setting SECURITY_LSM_NATIVE_LABELS in
> *set_kern_flags. nfs_get_root() then sees kflags without
> SECURITY_LSM_NATIVE_LABELS set and clears NFS_CAP_SECURITY_LABEL on
> the shared nfs_server, silently disabling per-file labeling for both
> the new and the original mount.
> 
> Commit 3815a245b501 ("security/selinux: fix SECURITY_LSM_NATIVE_LABELS
> on reused superblock") fixed the same problem in
> selinux_sb_clone_mnt_opts().  The reused-superblock path for a plain
> second mount now goes through sb_set_mnt_opts rather than
> sb_clone_mnt_opts, so it needs the same treatment: on both
> SE_SBINITIALIZED early exits, set SECURITY_LSM_NATIVE_LABELS in
> *set_kern_flags when the superblock was already using
> SECURITY_FS_USE_NATVE.
> 
> Closes: https://github.com/SELinuxProject/selinux-kernel/issues/69
> Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/92
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Closes: https://github.com/SELinuxProject/selinux-kernel/issues/70
> Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/91
> Fixes: eb9ae686507b ("SELinux: Add a new labeling type native labels")
> ---
>  security/selinux/hooks.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Nice catch, thanks Stephen!  I'm going to mark this for stable and merge
it into selinux/stable-7.3.

--
paul-moore.com
