Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF738A2A1
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812329; cv=pass; b=PIoKEAbPCUtlOIiU8VHdcYVTWOgc0sm3rl27wok0heSYmeZcFh4fmPq/0jDWDw83xxozK/uRiTeIVuj0I/hD+Yv43ajtBYl12X4Iw6cdHMxzI10G872Yc0X2NNRyFf67mdm7RW47wHveGi4NUzTcZlK+FidMToknL9dE98L/f1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812329; c=relaxed/simple;
	bh=1L9Z4WjLTMd/nETiB4o0uKotvQN4Rh7dUtNkmBInouo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5InNCttlg/jhPUBnWvOdbiqXZdad9HRryrzSuOXjW6w3xb5OLNt/IGcigbg9KamsuhsdzmCMJeDPhDbnKkp42sOmzQoRLwQAdaNqhynMpUVs14vAeoeKXJFOgFz0ERJQ1sdyMOtlcJcSOB31B94E2u7jKVRXzIwTb8VVGUr9x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSsduIhT; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSsduIhT"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885e8c6700so425047566b.0
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 14:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769812326; cv=none;
        d=google.com; s=arc-20240605;
        b=TYex/Y4De4+lRepQGEIePZzpfDumZTF3U9MBXvDl6GDwxqxxEwx0y3d8VzCuzOmTWn
         S79SZHt/AatOVYPS4mGVdyaY41f3Xu7NbYaLfwOX1FmfssqQRA0CIx+fgB4DBfWwNRBc
         lK/2Aj4S7PcsVLrNWETXcop7NjyoSv+Zjo1creD29twyYPawgaBDoO6YxoP6EAYiof7g
         7YK68tGabTaD+ngR5YG75pwRfEwoEI7Pw7RmpUt9ntAQstYJCXsXU02jpNH7gB5qpPA0
         3InFGS1Jj/wOvURAW0HzQqTWhOfvepqyipoLCcXGgxDU9bYoqS9/G00gzd/WQY07zu/I
         fE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        fh=PDwYkyvICiD8WeVP0bxM9CLmOPZxk7NVh9bZ+kCRmZE=;
        b=KI/wC00KWKPRYBcuneH2I8WIGTJBZicU6Xj45vpyXyt3us+j2dLQxuzU49XVPli5Rs
         XOasUVngVPen3Sov3+sTK1uydae7kgMPpqSmuVhHA9JWoUWhExa2xTPyuNDUtnvfZUDD
         RBUq1CY/rbrdOoybYJjengyvv6fmf4bb2xrFXLjsCyC0rlEQexuGHTC7SYl2Keo9h0Wl
         2f4JpF7GXQxdZw/RKqbi2nVCKvTjb8gbgLwAz2ncmOpBJtXst9QpUXujb9G81JM9NJOB
         l39HG/WBttbgVQUhz/gqGSUjfn2FnunP8KklMpnQF3ETfLQ/q2ZqDTqxDKoatmrp8dvO
         kcqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769812326; x=1770417126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=xSsduIhTCrRwZ3JLNdbKh8tE+MdhFL5H9uFQ+5tllsHBric51bEYgyU7uP/nPJVuVm
         PXBuoZbGBGhd9jC11zRL1GU483f7Fvm6uslzLapeb6QBFVPq0QqUEi22Yh4za+kn63ZO
         VYPzScWvoAqGFSaLLyA8MHrbxgl4Go5rekjKE33pKIWosCL170UwdnhFMbcWW6Jy1nHl
         BTUoIyOiMwtb7w1k7xMz4I30jgy1NoIFY4KeyxuPTUlWRVzku48qag4B+Mw5y3wg9X4J
         7qYXltKRhjuTRa93Kg/i5KMrUJXJP9GaY7mIYlek1UyxtuCoSVeghV/7vYzm2MaotHdL
         Ekpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812326; x=1770417126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=CCaSpocogWv6xsdJwkzwn0KtN3cgfIUevQSoRErGr8InX2hOPmleneEbMtJfyu2iBh
         /U3uzCLO8ZRL43ifVsq5CJx5JVc7FzVGRkLtXyJF00MY/vrUWEf9F15VCoPGpUO3evgL
         5STZD38vCS4B96lRwNVR1Q/5p1AO+doac+RCfV7eYrBgQTp7Kwd8FPcu1jBOAFaQuBS5
         H1toOos8/pn5nk6So0Meugo0az0LdsZp2RkcDhoGy0tIcMDs0stmBtcMte7q444WPQke
         KP3GFAe7yZHwKyKKNHMRhNYAQab9M3//3tXBzAzWxv0ABzN/I4iOgicwsHWljpqcu+G1
         RAnw==
X-Forwarded-Encrypted: i=1; AJvYcCXHfg2w5JuFQlnyKaVVFJGHMZPJcxGkg2SCduQuK9UXupNe/N5xDsE2Puf6QFm4oS97jHrgA08D@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+SkMFzP1luL8Neqx1zT5EOl5lUbidlfVpEpwbZipIb9AxotM
	uUIRDvCS5r9zh33Bo0Z5jEbPRe3PaGf4zbIm8WE3izuoA1Bz/8yxHA0ycpndnKh98e+D8mTkVxM
	ehweL06qKiO27U9Rz4KLfSJiZM41XXmWsGbCLXbpy
X-Gm-Gg: AZuq6aJSPrhznzGy73lTuEy9TwMs/n71rQ1SWTX2OQ0i+X+mizrCnS+TDn806vqFbsE
	MkgTusKts3cR1CQA0zfJPeTWyQPF4am7qXcWNjk7Yo9bLdhGh/GIj9D1pVH3OGmjYEy1rOnJDqT
	KbG5QxJ06s7pYPtmGEPTNDxcKWIwzRnbSbss6tvBFoEc0/gM+Vqa/emVrDambCupVoyR6CkNpJQ
	1PpiOg2qKE8s457U1FlPVMu2YXmkwRKeuUp75DBMm4qjNR9UyTwWh5laZq9cL4nfWEP
X-Received: by 2002:a17:907:e0d8:b0:b8e:14cc:9197 with SMTP id
 a640c23a62f3a-b8e14cca990mr91520566b.15.1769812325869; Fri, 30 Jan 2026
 14:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com> <20260130070424.GV3183987@ZenIV>
In-Reply-To: <20260130070424.GV3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 14:31:54 -0800
X-Gm-Features: AZwV_QjYrhpLENkXIfDxcZ9u-zvP7f57lE4mcVebqUxFVKgl6ULvCT7XG0RHQoc
Message-ID: <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> OK.  Could you take a clone of mainline repository and in there run
> ; git fetch git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git f=
or-wsamuel:for-wsamuel
> then
> ; git diff for-wsamuel e5bf5ee26663
> to verify that for-wsamuel is identical to tree you've seen breakage on
> ; git diff for-wsamuel-base 1544775687f0
> to verify that for-wsamuel-base is the tree where the breakage did not re=
produce
> Then bisect from for-wsamuel-base to for-wsamuel.
>
> Basically, that's the offending commit split into steps; let's try to fig=
ure
> out what causes the breakage with better resolution...

Confirming that bisect points to this patch: 09e88dc22ea2 (serialize
ffs_ep0_open() on ffs->mutex)
