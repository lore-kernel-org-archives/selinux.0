Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517537A488
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079000; cv=pass; b=RcOsDqgdAEL78FIdpZQ7ssvpabFXakbzebR8AqKNlsf5JrCDHrn459zuOHVUu38WdehPVINO0lIy+Bhdu/uGtehrO2mkcvhMc56Wt5Sxa2iC23w3ts7isgYiQQdvc8ZrtJs7w2/ONFmag/+D+a1lscHQVSHkaXnvF7G1WaHcoRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079000; c=relaxed/simple;
	bh=fxCveQaN3YYGD3YNchDN7HId7soPkIEWPjmMSVqYWiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEwTZxUHuMvsbQV2YWHMlRLNsQaCe1EqLsQ5MP6FhWDXVYtzCbRJQCLk/khM3C239DPr07ajCNNTqBIlJ0KQp1+tqkFNnIQUOx+uXgGseeXWnI2nuGkqtiUFN9oIumaw8rauxPEl0yud71R2UdReWVkp28T5RYqa35oyplsZyq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Wum2e3a2; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wum2e3a2"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3698e34a567so12974152a91.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 11:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780078998; cv=none;
        d=google.com; s=arc-20240605;
        b=aeDPrxt3oaIG8TKGPPMdaOD4S7PP4bQNYXcEvjO1MeSU6MCrOYxiFfYPitft91sWGi
         T0dS1hXyPHQJxwOA/M61z52ZZDhH86tt70BtpUG9eACfPYoKhrrxwaX3qqpZsohoCKqj
         7HKXdggl5XbAm43GgQCEthv5o2hxaVKCYAF4qGivD/fTOXtOSAfcR3GO213sLxy4V6eB
         aTSqjGFniZcq+qeQytg0WTcDtK9eNfKa3sC6cXsSFXOHQPWqVn1/OABOk10NXErbUxm5
         QcfLLRK9QlYvyNsyNSyLAqgtV1oWch1eFaP5Y4810E5xt8EH319pKkgFa2TFEpH4o81p
         srYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dC+9xrOT3fgTxc8ls+prWRQG2kCX3O7CMMA4vKRipE=;
        fh=aV/QRpfoB6OZf8NOC0MihoCX2EJ8n/78kaAH5NBF/uE=;
        b=lwuIFtYQxfp05qeYXfzxk85gtZO39jw/L2Zu9eTdNlBgRpG0lg4gZJZHspe2q8dzL6
         o9g0cDRQfmKMB8+mIllXWfs4ZpmW94fnngeXL+HXffFLd7oUXu0nt56nqxJRERiN2poI
         jexlPVxMo3vs9gKadV9jAV+JiT35amS3CwxVRuig2EQKY+yN4BLrEMSJOAaGunc4AxMc
         fpoHfV1wlkK5KUSMqGNW6GuvLmDp43z7YM2NXt2jSnMZBPxguAHxSQzgQqjvgloPaX/Y
         WkV/QwN6Y8LCNfehHkqYdjxuh1Q1h0GlJEhzvTxte4H24cnEkX1sEvvyQpprDtVIi+iu
         f8Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780078998; x=1780683798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dC+9xrOT3fgTxc8ls+prWRQG2kCX3O7CMMA4vKRipE=;
        b=Wum2e3a2gf7FR/twgo2jTRHGN37cZd6B6gjBNfY2jpX/b3EUgMuDy8x5tIQyF0aXOd
         wsCbcXJ4gTT5pyh1u/xZqHEiLXMCTPvV+v6GZ96MMd72EqeG5vXFv2w+BzI1n/9IbQG5
         1TC+32S3rJ5elAn55wyotPCHEom48gldfa8APcebiVJI+R9TVTqkSdnsycWwcPYzSl1J
         xMmr+JhRA9iaVcszOdDXSTvXi2OZNdzDfErI35FwxjStP93kDI0vG0XFtPjIXRIUhWYu
         qA9HcqYvWLOKOUuy/SJ0gm/hMvV2tk7oAYiWfOg6Z+FTJwj1I3XtnZgDATfOUikMV4s3
         LUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780078998; x=1780683798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dC+9xrOT3fgTxc8ls+prWRQG2kCX3O7CMMA4vKRipE=;
        b=N7KI7ijbOqdqjo61MUfbRighnLARg9ckzfgJXAfuaLyQurXVbD5CA/BVJsNSZogWeV
         6XgUvjRP+i3ZwD+673+TcxK6FiS9GLrq7SpnBdhNTkrJDU3eQTWcS3bEX6v/4Fa7PM9G
         ILD2BZW3cxxwC1/WsU2kInAWCJLsZXyRypF9CodGOQymfg+JGVlKzfyzTp0d8yVd3pRb
         iK4/HYTvLrngvNyPwfRreP3NdyF6RJErTa/ASXBXjjyYjtxpra8+zIVH4amrJKPWWNDw
         q7pd3RnSl3/KFlv4yPocQ403p/xuQCJm3H+ifvQG2HmcKwjZE8KpX2xBAJApzlO9P5VJ
         uuhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VvmDyHKkbChFDJYZcgBCeHQMJ6B5rde9ondglssSJ7Td0L2bniDwOPiRI9iNsOIHnuAyxSsqC@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFk+YFGDgdhrD/Fj9Lk6uNyqlv02bmb7FKpoXg8pGa/Vo87CB
	0ln6/Rn5QzXo9y4Ys0KS0F34ueHNGYo7nPRY2pLO5xGIkzC6NwfeHs1+Ozkz/5S0F0WlQ1QlBu5
	ZQ2pgeqREk/XsnybLJZ2ix6+vYnmbukYKYWJDlQ7u
X-Gm-Gg: Acq92OHPxkN8OFliT1Zo0691vRUjkU/OBaq7WZWktBce4/FUdFUY+T8ZJq6y4m0ACdd
	6rF+e2cGrl5hiyYtRL5KI10zN45aPBCFnN3Jk3qjyqM52IDSY7vmkoJWx1jvXA3edvrq+bp6t3c
	Src6CI9qUoZvIIc6JduorBm1cyCq0paJlm1uC+I4K92/9p9+FumFyGUI24cSc8C2CDtTRMwqBRO
	Xvc0b/bGHay+jDwI76qRzDEjQXIcdNNQP8WIkrc8JPMbsK0O8fBh3vdpUbGxjpaPM8Kb/h6BEL6
	XOOpcBgrPXaxPb+Ypw==
X-Received: by 2002:a17:90b:2d4d:b0:367:cb53:7435 with SMTP id
 98e67ed59e1d1-36c50211c27mr291718a91.24.1780078998658; Fri, 29 May 2026
 11:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <20260529171855.7966b752@pumpkin>
In-Reply-To: <20260529171855.7966b752@pumpkin>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 14:23:06 -0400
X-Gm-Features: AVHnY4LkrqqXg3z6cLc0b8TGCe9ixXYqrmd1DAmZLfW-cIHP9o-9OV932XiG6Rg
Message-ID: <CAHC9VhRAbCAxg4swOCBT+nAUaqRPsdBuOa+nm=539ejpN4wmWQ@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: David Laight <david.laight.linux@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org, rppt@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Ritesh Harjani <riteshh@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:18=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> On Fri, 29 May 2026 19:07:22 +0530
> Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:
> > On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > > Greetings!!!
> > >
> > > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11
> > > hardware. Attached is the config file.
> > >
> .
> >
> > Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname()
> > to allocate path buffer as the first bad commit.
> >
> >
> > # git bisect good
> > 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> > commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> > Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Date:   Wed May 20 11:18:56 2026 +0300
> >
> >      selinux: hooks: use __getname() to allocate path buffer
> >
> >      selinux_genfs_get_sid() allocates memory for a path with
> > __get_free_page()
> >      although there is a dedicated helper for allocation of file paths:
> >      __getname().
> >
> >      Replace __get_free_page() for allocation of a path buffer with
> > __getname().
> >
> >      Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >      Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> >   security/selinux/hooks.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
>
> __getname() is kmalloc(PATH_MAX) aka kmalloc(4096).
>
> The old code was:
>         buffer =3D (char *)__get_free_page(GFP_KERNEL);
>         if (!buffer)
>                 return -ENOMEM;
>
>         path =3D dentry_path_raw(dentry, buffer, PAGE_SIZE);
> only the allocate was changed.
>
> PAGE_SIZE is not the length of the buffer.
> Should be PATH_MAX.

Yes, as discussed earlier in the thread some additional work needs to
be done, and verified, but since we are at the end of -rc5 I simply
reverted the patch.  We can chase this down next dev cycle.

--=20
paul-moore.com
