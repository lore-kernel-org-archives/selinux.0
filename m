Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E753435519
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570785; cv=pass; b=L/FJm4uq17kb4m1VJCXmcZPU9JorGu9jt1DNInKBFyMNBUASkVYkgRD6ycSTWOmsyOWBWfZulYafENcsC/A3+Ygz+pVkztwkYMx0KvW5gk3IL3GrXMhx/DxTBe3Txk8G14EJRqePG1hrrgVPaQM9RfIKBmuylpzy5DBI0ufAzNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570785; c=relaxed/simple;
	bh=6sJy9PZJ/5uu+uq4/s91e/0S+srBf6fkJM0yl1tesOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU8+GfLvczhAIoduD33peCR3VxL7+g78EyHV2A6nTwTrfkoERf7I7DYhYjwmBhKqcbvJ6vO0eo/bCN/XljihiiCAA3leFPm8WjQYHlaS/Z2bpWZ+9g+/Bxas0GgHPpInzn4jQWX1caWZsCiH2hZ9HNI+jXeeyb7LomFHLqzvKfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVuGv4D9; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVuGv4D9"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-907ae240ac3so1248226d6.0
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570782; cv=none;
        d=google.com; s=arc-20260327;
        b=LKe76doiEk4kllmnhbdMHNHpcbFdJqjgLoT2zB06b6zpL4c2IQ+pMgWcqbpcXWVPrO
         v0rIhmST2E1EtgBp4LxWtHLXDI4fIQAngnHZt1/QpqrEztO9xlOxYLrxDUWQcfpuj0ut
         SVzO4yT6KU8VzX2fcH+pX8F8NaeDjVzd/Be9sXTtE5m/5xFwvs2BDs18LOidgtgM6/1M
         gmwP0p/LxUl+S6LPdOGEAdLHSlNZuzzTlDUebeRPP2nAwiVx3b0e91GPUV8NVsC+43Hn
         99ZOEBH86E2k/3hkfwLPq7XIIUmhvGipkan/FLzlUnyx4ua+C/L/aKywZdgq3rjDswuS
         WbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        fh=Sbg4wl8e4jVEC5t1kf8izLDdeUBXKuSuUot5KellFT8=;
        b=pR3wfX/F6tnByLIRM1mfMBjr6wl+96OgiqJ+xLnZMsoNfrk1zgTKnvnp1l4+OCi/rB
         YfGyC7TGlh/w0uBpRXPsiu0+kVAkkv91lOEEMVxQQMrW1JQE1K9baABSYO4ZAqGALRep
         4DASmdymQBTd1eGlFipFpie4o/ar9kDIm9jtRBt3s9ViVZ1MoZkYKH0n3Jb6XijSxKpW
         LtEpP7dbm9l2D/xX74C6O4y8jhNm8/K4SH0y5P5/zHunc8eQ8vYBYG65XtWbYqOVRFku
         +TLJp0T+t35In5qzVCaQxlyBxem374lObreAyHcSCDHhRl9u/hJr/AC852XH0eo0CAlH
         X7BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784570782; x=1785175582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        b=qVuGv4D92AgPHJeaD8GZFiyzv+DT7Rd0tbKf9FpNpK9JWGWh8yNPZ+dDFAOJpgSQlf
         dKkN9HCTovfUqy5M/xL9HKeA4CTVm1ovHTIyUsA1AklqzmcsMZ1X8gz+isn+c+ZWvNWc
         y1h12Otum0BRnlX2KQ24j47IRyDiGGThUZbNz+aBVTEypmsZan1aTXjs4xSL4f6qpMJX
         bx6j3Dgjv6AnSRHoQhc9ufDQE3/BsFxokH9nK2DwRV8dE9WJYQAU18uTa+xQFLKAttqK
         yBtERcaagBEo8O0jmMC8JMB2v5xsws2OTAzXuO+A7xbna373zvvhR+GFxYCO4hkKD2nP
         hAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570782; x=1785175582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        b=InvCHLN1msbsOXrnRgz8n9wAqAsI4MjAZUnNzmZpjag8CpEeycGXdIme+djF9TdZ2c
         YpcY5mvnNKoNXiRygjTZY09GImwOGHwEOoq3izZPNSmkvIKypfEb5PxuYaTHjNN3r/4T
         nZ+JEZZbxGAiMuuu43AcCWVBVR9PKoriax1W0GBMFrVRd314IfG30voNXOG+YdYIdrhm
         ah3irYOZPhWuqfB7Ez3jEYK87tNCgpEFZAxjwSdFfOmVV4XAdXB01KF/dFQ52xReCOqs
         wxbsceSulCCrLb4tLynCWoc2X5wLiOb7WwNl5G8O8uv7qA+qv7nkf/j2t0bqM0jljbRG
         cV9Q==
X-Forwarded-Encrypted: i=1; AHgh+RogFM9mtR0umuLSD62vV4yt6KeOjU9w8AyIlQXf5KVeGp4Yr/XCdeiL0HcS03MBsQz4fyNXZWlD@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHeB5TBxca+/MhWssH9JRQSw5Xp5iKBuwC4YvZboagSvuUGFr
	1F6fDwfepbGIa8bm486gy8Wi5wPqsJ7B/p7xUZrYwtdj0PEEICFE64bCJFS74748HNX3oGDS+ss
	vCqdxXgj3EIfR2mSxIXmW9Nv4g/9sj4A=
X-Gm-Gg: AR+sD11oIKy2jA1rgubDBaB7IMnqbT56zKGGMFLMoShSas5ZRwMbMrVafAwsT15pDEh
	iKzi9R1LjlcnpD8vk5a1w7H8/pRhXyBpU6F31Z7hCCyNYOcu7FKsFrM7eE+Iw/dSba3uIFkUNP3
	FcqB4Jt+2AzwRcWUD5k82StU+E4ehjhoR3KVYMewMhU5gT6FohgZ4u3g+bOWzuLwK906sCZ0sgI
	M8p8lFiaZRtBFUJZn17nHIFtIGIPmOJLdgXfTycaIL2vbxkutQ3zfmcNQRAs7uUtS50ydBLcnYL
	TXS/iCyvdQNXxHL1
X-Received: by 2002:a05:6214:e45:b0:8ef:ddf7:3135 with SMTP id
 6a1803df08f44-907783b38cdmr173632066d6.38.1784570782095; Mon, 20 Jul 2026
 11:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-2-dwindsor@gmail.com> <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
In-Reply-To: <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:06:07 -0400
X-Gm-Features: AUfX_mxzIpBrzcPTV9KeowoimwOb7WQA9GzVVHyfVuwu0lx2Q8xYaxFF_5bIdv8
Message-ID: <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> > +struct lsm_xattrs {
> > +     struct xattr *xattrs;
> > +     unsigned int xattr_count;
> > +};
>
> Please separate out the 'struct lsm_xattrs' related changes into a
> separate patch from the security_lsmxattr_add() changes.  I know they
> are related, but they are different things.
>

Will do.

> > +#ifdef CONFIG_BPF_LSM
> > +static unsigned int lsm_xattrs_used(const struct lsm_xattrs *xattrs,
> > +                                 const char *prefix)
> > +{
> > +     size_t prefix_len =3D strlen(prefix);
> > +     unsigned int i, n =3D 0;
> > +
> > +     for (i =3D 0; i < xattrs->xattr_count; i++) {
> > +             const char *name =3D xattrs->xattrs[i].name;
> > +
> > +             if (name && !strncmp(name, prefix, prefix_len))
> > +                     n++;
> > +     }
> > +     return n;
> > +}
> > +#endif /* CONFIG_BPF_LSM */
>
> More on this below, but this function isn't strictly BPF LSM related so
> let's drop the CONFIG_BPF_LSM macro bracketing.
>

Ack

> > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > +                       const char *name, const void *value,
> > +                       size_t value_len)
> > +{
> > +     struct xattr *xattr;
> > +     void *xattr_value;
> > +     size_t name_len;
> > +
> > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > +             return -EINVAL;
>
> Sashiko raised a good point about xattrs->xattrs being NULL not
> necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
> something has gone wrong and -EINVAL seems reasonable, but the
> xattr->xattrs NULL case does seem like it should simply return early
> with a value of 0 (see SELinux's handling of this case as an example).
>

The problem is, SELinux has already set the sid by before calling
lsm_get_xattr_slot, so we do indeed get an in-core label for the inode
before returning early here. Returning early here from BPF would not
mean the same thing: there is no label anywhere, in memory or on disk.

> > +     name_len =3D strlen(name);
> > +     if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> > +             return -EINVAL;
> > +     if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> > +             return -EINVAL;
> > +
> > +     switch (lsm_id) {
> > +#ifdef CONFIG_BPF_LSM
> > +     case LSM_ID_BPF:
> > +             if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=3D
> > +                 BPF_LSM_INODE_INIT_XATTRS)
> > +                     return -ENOSPC;
> > +             break;
> > +#endif /* CONFIG_BPF_LSM */
>
> I like to avoid macro conditional code inside functions whenever
> possible, and I think this is a case where we could avoid the conditional
> block with a little work.
>
> The LSM_ID_BPF macro is already defined as part of the UAPI so that will
> always be available.  While BPF_LSM_INODE_INIT_XATTRS is dependent on
> CONFIG_BPF_LSM in this revision, that should be easy enough to move
> outside the CONFIG_BPF_LSM conditional in bpf_lsm.h.  Eventually we
> should probably expand the lsm_id struct to carry this info, likely just
> a permanent/local copy of the LSM's lsm_blob_sizes passed during
> registration, but I can take care of that later; just make the
> BPF_LSM_INODE_INIT_XATTRS macro always accessible now.
>
> We should also probably record the xattr suffix/length when the LSM is
> registered, but that can also be done later with the other lsm_id
> additions.
>

Sounds good, will refactor to remove the conditional.

> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Combine xattr value + name into one allocation. */
> > +     xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> > +     if (!xattr_value)
> > +             return -ENOMEM;
> > +
> > +     memcpy(xattr_value, value, value_len);
> > +     memcpy(xattr_value + value_len, name, name_len);
> > +     ((char *)xattr_value)[value_len + name_len] =3D '\0';
>
> You'll need to add an additional memcpy() here, likely in a switch
> statement to handle the different LSMs, to copy over the LSM specific
> prefix.  It's a little ugly, but when we have things captured in the
> lsm_id struct it will get a lot cleaner.
>

Yup

>
> --
> paul-moore.com

Thanks,
David
