Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7F43F4AB
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512036; cv=none; b=HNC3D9wmpRCrKOasXZH6d45qrcOnltrvV1fy7ns4ylecuKwsxjMwUOJqVxSJQEIwsFbdX+QLozUm8CL4/WqnC2yBfWOkEjOf8F/n+txElJqwCnZPp0w79J2+nvbp/2GYc8x5JV8J7c0feta29c+4M7/QM3b0D3Fhow+PgOA/nyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512036; c=relaxed/simple;
	bh=woNq/l+3U0zz2akwXlegxA86rTMivcRmcH7/T5sMXMo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FMSWtSiOyUHwkvc1qxEFoOoT025TEAx7Kz+xnU+ENMyF27AIoKOdjVUShRgxEwwVg1uPhhstddPdc56g3KlzekXWNEjhYdJKUK0R7IWkT7rG7QRHZzUaqOKRea/PIWnKRq3BJcyZbUdhDLrp6eMLidIkJUbCawSy2wVYNTtlHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y3u1vViB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y3u1vViB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-527e352a167so7049371cf.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512033; x=1786116833; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIaFXgBtOm81nfXrtruizv0xq/Lkj36YYTwsO8jgCiI=;
        b=Y3u1vViBio+nqrIXHc3PLM8T7DOvrochPqB15/haNdLZ3fXpwy0nU0obhbmwqe/iX2
         l2MK3TXATohJun+/SSNLSvnA77hZG2imJvfgezTMLOv4lpazgEOov++Msg3p8ZEl9mMD
         BhJE5AT9BBTnQkKoBvXfUsHKW281dkv8wLQytxLkMrLdO4HsokQ20EySQRQ5YT7F3M3w
         eC46HBMOhcGZJr0V3ApkDpMTFNMTGajV4sLrP/UHDJwxs+vPWsC28IIqHCCb2TsH7VeQ
         sE8uvaZkAP2MBwHpT/pgq1LPxt17ovYV+1WGtCO5XWfK57b1mdqAS6uDlbwEhNS2wXp3
         Y/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512033; x=1786116833;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIaFXgBtOm81nfXrtruizv0xq/Lkj36YYTwsO8jgCiI=;
        b=E0KMnpiw0ViczDNhLJdhuk2ef47EVKekluWDO3fxHf7jQKjc73KFhf59dwzdqx8bWQ
         9zeo85kV7VGY65ML64kYKUUpqDSzs2m2h9EBTXOOWx9e5ri2LcjBwtvhsfqerE71Iau3
         CxxnvjZrshbTuNsXL0HlwliibPknE2QzvXy14GhLBEY8WnTt6K8jhpoC6lsoOnzIofgH
         2zWCNjcBsvtaeClSfyPXYap7Nvpg3+ZLtjUP15ruh/IclEn2vCjXzU8MY0va9Te3Z0Mj
         jC08yPjPEAp3mEGH68DKZDfowNW3Z687xTyNuy9y7tdOTJa0+h9WWdUQJyybZl8cT0qj
         9ivg==
X-Forwarded-Encrypted: i=1; AHgh+Rrkmi06O4v8Qj1uosqZM4AMps4ebz0G63nSgbS4OIczeyTQvWyEgoRARWIUb4nxQXC09fbCoq8K@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmBosMcBwk43ELjZpU++Id+wSjO12N3CEDRKlbJqN9gIGClLj
	QbZmugD0eBoAj5bZ3cAsLA9At60jMcCvibSQVy2WbDqKgP8vgL+LFIt4niGuY2OW7Q==
X-Gm-Gg: AR+sD11+jwyMaO3Pzs5p0VnEgDn2gq6mOzAIq7CAkK5QghNjv65fRC8KQ2U/4iE7I/1
	9rDKC7+1XXREOEwgXz8XAhh2NF0PEj1hPE95SQfJEvFQvytOTGqyeDWg/evBcHDRS05zmm6eMfg
	BspaUtNOm2wIewqyf7SpnB47sRACfbleGmuGGFYOx9DGrJ/Ci1nVb6DqfsTAVejy44ImGjZiwkc
	OG9af8t7+/kDhXq9/7btM3i0yzG5YfOrzRnGtdAzKVBIB63mDYysqjsz+hrpRBgYEzVroce1msk
	FTVUUHN+BUSTtUj6s5AwO4R+y3+W3mX1seRQ74vVZNWUal0ZMuvw7CVp0pybbDnNUgJoBYCxuij
	dlxkV849juF1tao2Kz/ShRaRUNLUs0HeemzxhnNGX5iKmo4VQK6DVfys75MDBi0URCbpEbqWm6c
	dzjmmtXJBs8jz1OP6EHSDzIviFGX1LVKWaIDu4j4Ny5BG1dG/Xv7pBH7oGjdSZ1USridRNyYPsp
	ntbcbIYT/rV+QHOc5DnLlOWLX77jml0kA==
X-Received: by 2002:a05:622a:181c:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-52b566f6f4emr11298121cf.5.1785512033469;
        Fri, 31 Jul 2026 08:33:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ebeb909sm9993881cf.29.2026.07.31.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:33:52 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:33:52 -0400
Message-ID: <f3768f73f951ef02b4fc3f89d53527eb@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260731_1130/pstg-lib:20260730_1437/pstg-pwork:20260731_1130
From: Paul Moore <paul@paul-moore.com>
To: Carlos Llamas <cmllamas@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
References: <20260730221508.3846409-1-cmllamas@google.com>
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>

On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> 
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
> 
> Do the SBLABEL_MNT check before the inode security is initialized.
> 
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> v2:
>   - Move the check further at the top per Paul's feedback.
>   - Collect Stephen's Ack.
> 
> v1:
>   https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.com/
> 
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged into selinux/stable-7.2, thanks!

--
paul-moore.com
