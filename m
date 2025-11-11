Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494733B969
	for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856912; cv=none; b=JX3AsGg+saWdKh1TRU2XDBVeZoCSwKPfI7kTTbCqDVgK+Zs+VqmEacHWg04Suu4zs8E6m0Cg29qPzcmFEqNsFT8sUEscFNPJeJgyhbBbH4gJY+/P+UwfxnwdLqCYAJ0Qyjw7TlQ4guDyqGmUMRokdLF9S0SQ2YCXuAbYRcM3CW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856912; c=relaxed/simple;
	bh=AFJjiFOvGyHo0S6e8akF06HQkuXboJRcqUguRvorBaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pINr16RXsBaBCfv5/XIra/H2I585eFs25+AbnYtPzAtgUSiaPpk0jLH9jigk0Z6vrF/PFAU23IpYOLoQzKafPugK6Q/vW13fdudD2EJ0C9oyPOjSrHpTzbQRTsCdi2z5KKWqFw11wX6ZvCGELzlKtiWu9AtTJJXXtIPbPJbUJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S677OMUs; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S677OMUs"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edb029249aso20330951cf.2
        for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762856909; x=1763461709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h/p7mEepN8jUuWyprYCkVkbNxCuAN/nU2Y/T4HHlQA0=;
        b=S677OMUsTqJF1qJWtI73xM3czE842pFDa4Z3u6wgcHg/XV9/ynva0/WZAQSUJTVye3
         RAw/yyuEH0ysJcdYdNkFWVhuAC6gwvAe/aOJifEx4sjXEwAkhG5vctExTDyw9eYdZTpx
         KoJTGHwJutDyzWwASbXuKTO+L6tY34jBFFhG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856909; x=1763461709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/p7mEepN8jUuWyprYCkVkbNxCuAN/nU2Y/T4HHlQA0=;
        b=XTKMt0E202PdPRjqK1HIbKf0gsX0QFKy0E+MkCie9IHJUAebQ6loJufg3PeJFGgS+9
         UaMUCxZIk5h+hdeb3QGrGLvMGa0tT20lHEvadJLfHLrb55C71XJKkXEcn58EX0x8Fu+f
         D/Xe/VNsJzCAktQrDu19ePQ+c+EKNDl1V42tmszDW8rs0XgJNKdCcgMt7m+Co0KO44TJ
         H8Wp0HX40+KYcF8O4VjXVEO7Be8rjjsX7aqJLJMajwt20qSmxgUEaJrGCiCmLYHLKfmE
         h5Z3p8pPVhLR9Dc2PM1c5h8RorHIyk9xR4Gh5Ygxuy2O7bORVxm9PiMl6svBe4uDqGdu
         2R/w==
X-Forwarded-Encrypted: i=1; AJvYcCX2m3RUXpVK024i2yC1Mg8kERck/Cq2Xo1YvWifFe84v86mCn2j40OFDUFbIpZs5ghPM+aBRtpH@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHYJvPEzra7zJigeUtmObfwvx6o/Y8GBlt9wEKJz0Z5KtvCMa
	RToPbZwJtlnwHTmU7pm6Yl7SBY7lMhtTfwgorZbF1Gb4HZiyaJrjwxraTxzBks501LCUb/fi5z+
	PJkgx4zu2g5cxnebMdzP3WKeGiNFDqrEYzgNvoQKWkA==
X-Gm-Gg: ASbGncuOviS5P4/xm3CGEJm85bpoMMLg0FXCJIiRq2atHEF0TEhdKym5j8WjPE+zvxN
	1rABmqxnx7ow2XAd0iKMUiadz+QuzOEne/TQwza0cmOP+XKlVqhgXmbTqT/UWBWVeQxyMY5CWsB
	DCysJL2JIP+HfswD8DusY8m3DPcCsdNJLC+chnuAxRt+eETrvqYFhJdbHTsuUIqnxKBZg5APa7D
	Xyo89h3YITQju5T3bPnEUGgEQsztob9T335TZN/81xnUZuaTzGh56UKf5w=
X-Google-Smtp-Source: AGHT+IF2jsXtOYznzAlKiswAAYjfBT86jbKpGaMbobTgICmObIV//j5aCRxdPYkP+19MfGrAnajQvcSXxRuiu1TbWoM=
X-Received: by 2002:a05:622a:1898:b0:4ed:602d:dfb8 with SMTP id
 d75a77b69052e-4eda5043040mr135933731cf.82.1762856908949; Tue, 11 Nov 2025
 02:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-18-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-18-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:28:17 +0100
X-Gm-Features: AWmQ_bl7He3VQsld2UXN2E831Naa9ot3hmwpZMaWScQnQVWsufspzsog6zo2yMQ
Message-ID: <CAJfpegv0jMq96xD8gSbMBydj=1wRixVGy+qd3feC2vSSn7v_rg@mail.gmail.com>
Subject: Re: [PATCH v3 17/50] convert fuse_ctl
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> objects are created in fuse_ctl_add_dentry() by d_alloc_name()+d_add(),
> removed by simple_remove_by_name().
>
> What we return is a borrowed reference - it is valid until the call of
> fuse_ctl_remove_conn() and we depend upon the exclusion (on fuse_mutex)
> for safety.  Return value is used only within the caller
> (fuse_ctl_add_conn()).
>
> Replace d_add() with d_make_persistent() + dput().  dput() is paired
> with d_alloc_name() and return value is the result of d_make_persistent().
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
