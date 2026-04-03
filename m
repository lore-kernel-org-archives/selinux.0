Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850D3D8112
	for <selinux@vger.kernel.org>; Fri,  3 Apr 2026 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250885; cv=pass; b=Ru5xD978zBM1QYt8IES0qFrQnhhLtTlwsHKffb8j8iQAnQ+fxMjlr8/QY8n4xHXGubnKSQwahnwyOy0iBf49sPPRom0G8g03cKk0GFA3I0++DZ1ZCcj4cSc4AUBZJCqEo6OxMdhizvm6txEPEEDneQg0vfDY+F18bydHP5N1QLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250885; c=relaxed/simple;
	bh=iNQ9qdRSCL3uUh77rSWYNovDUs8lKN7UfJ+q0K1jN/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gshVRYTtIp+6ieDGLfZ4+Aeke8IX9F5aDwh/oJmgIjL16hKsa3qEZ176rsOg/ovgdG6iPp3pHpeC5xg13x08Bh5DUlyJIE7LZwiGyZ2YZLV2yimS7lZhaQvNymjzBD5Urr9n2LkjapsgUeunlIxVSJe9N3l2vFOp9Aji5wSVcac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ie+RQjJA; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ie+RQjJA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b258d93ffeso12968865ad.3
        for <selinux@vger.kernel.org>; Fri, 03 Apr 2026 14:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775250882; cv=none;
        d=google.com; s=arc-20240605;
        b=EdTxibmxh1dx89KZIZ71DCj73foyliRajUFdf0QtWQzL50GPZg+q916Z1dLXV3TFbq
         FemdLT3xnva18YJHF0n7GexwnpjVeVaEBYPtyVHnaW/uZ5iu7zKtHHYKsrPJ+Lo5blM/
         yU5L/xNigqbfjgcx0C2UM2blcTs8vK3Dk6f0cV4cR4BG5z5S2MM9GfO1afTS+rmDld3K
         aU/PMCjKCBD954lYTfVLl7/uVzV28u20QM0/p31XmTKh0L1Yd/Om95+SzrKek/0+Mv2P
         3tgJOsHPn2HniH8Jfe5sveJhGc695K0Hv6Vs0EzoEx9ky45ABvXIjyHYwqNmrJoXMEqv
         EruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        fh=T4Wf67hMWIinCYzSb6b96NP9/9Ev7KRcO+ZfyhIO83c=;
        b=Kxyzsw5CRbmydWsfpJfmdvOSboNWrVSlKWYROAXxgq7ApeVaGL1KKJNUDUcpRtwrsU
         IsVMAKefvlLZ0zQw8wlus5ehd/WseYn5uQH5Pg3pDOBTxDlaZVrlmetTJv2QyQWoZX7B
         eS2209TAAI0FfblVYtXFwos1gMFu9TJ9FGburgcoAcUxI1Kxd7In+pSCtTcfabfkfKH6
         tZPP8+4ycr03nn0lDVPXvPs3VVnwEWh1Ah+8PDi2Z6o3hqhqJbj7LCbdKTIGoLIxDRgr
         GHMyWgXPb0uPKdnd0KFlC+duqE5KeaH/O4RkV3COy5XHCw2ikvGBZsVlw49j8HfZAolI
         XIKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775250882; x=1775855682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        b=Ie+RQjJAjFlwLmuajd1+bQFaYVKDGeETiNfVlqMIuyVr+Arbdhb582dBjLK1c8gUvz
         O7uOwOG2Cw8nmaHA4crKYPsQeFFt1DZfnmQ0vwRALKMdKAbfFqoj5zL3pkKOST/w9yf6
         0amZgjxpk4U21DzkcEx4K3iJ3dylBGnObQEqbb+gdlw9I0DjU/gYNG5wOmWfPz2S7tSn
         MXghGHq0GXeZsos9sS6A0Q4DNZYmfQvOgePBu2W4K9Bek+r2hA4PQqYUxRag/j+b5Cno
         k9dx5WSBP+5AzU49wkTMU1itGd7DEnC6/pxwDRHQoVuLkjvMZGk+VJJnmHLzYuz+PXJE
         H0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775250882; x=1775855682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        b=D5EqoSu7iKIHkNjd0I9urG4poEgi9/y9sI0juRJjCNDpx+nGsJTc9Kei43PvjaP0CQ
         fg6ocMvczJNfhw0UhltO3LF8niVtl0SjuWdANu1sGIrJEbvzkZSm1zeDVZM8KyjYlOl/
         ybC7TxnRxJKnO/EJJRlZqAthLFH+kY48SUcsFzmKtvvotC4gF5WIhF6Hx+r/loFnWsnr
         wDNRpOndBrKidY+mDWOAmz81WisRBzUa6XHQ0Ay9ax0VgeEE65Bagj2gmcKIapAvygLx
         DZ0GtZ0H6RPEJgfVDingcAnssDj1jagEPMqGCkDmyu1jZiuibvrJ/QiDWLteWycfSqTH
         7fdw==
X-Forwarded-Encrypted: i=1; AJvYcCVl4Z9PcMj4YU84sKjvbVPAIlXDZnVxrSu8g3NNPle0268WFQDTuOWRoPUumEpvDSjWxJP/tJhP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6Sv0m5x10X8c/7UkilVroRUrrINfeQhHkDowhn/Bj+/zW2fd
	8WjGV6azOYqNV673P6KNOhVCB0x9FdN0o/nsevS/Xz0tp5vCsNCA7QaaUhwScG5aQ14NMyYtNLN
	xigPOdG9VO4gawFhkBqdFUj14XYVQzZ49r3nXEc64
X-Gm-Gg: AeBDies1axhzRPy4ptEv3A8dagFG6NDpHIM26wilBzEf2GPukeh9OOheQpWmgA42rhw
	BQ6Ciee6zw56ftowXfIQH6rr2cNsE18xG6MIMAHdjJN+SBs25t9yST48icT+n38/awApWdp3n1u
	gE/is0kw5/PsGqu9IDXTq/UczepoGpB9MXgZioN28qSGeu/I9IKQhoRiiHGx768pISmCIHQnAos
	hTY4wWcTuXSEttMQWrwJgZuQNDaqTspYm6Ai08Lo+5Lp5WfmDdXvGXcfAZ6LtQ3j/L4aqv1zQo5
	uz9uLNw=
X-Received: by 2002:a17:903:2ed0:b0:2b2:5091:1c26 with SMTP id
 d9443c01a7336-2b2816d8626mr47571725ad.22.1775250882586; Fri, 03 Apr 2026
 14:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-7-paul@paul-moore.com>
 <CAOQ4uxgd1wo9U32L_sQLfswY93LRp4yPzkJvKtj=wDKi8h13gg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgd1wo9U32L_sQLfswY93LRp4yPzkJvKtj=wDKi8h13gg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 Apr 2026 17:14:30 -0400
X-Gm-Features: AQROBzBl5cCyhzn_4rsiKSOgf99yuNguIB3BwaumzWCCJnTdkerDXkp2yfIst38
Message-ID: <CAHC9VhTyFJottNM-Reg8dGbU4T_gAG63oOQjwrOY0x=2sCLR4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 2:12=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
> On Fri, Apr 3, 2026 at 5:09=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created:
> >
> >  security_backing_file_alloc()
> >  security_backing_file_free()
> >  security_mmap_backing_file()
> >
> > The first two hooks are to manage the lifecycle of the LSM security blo=
b
> > in the backing_file struct, while the third provides a new mmap() acces=
s
> > control point for the underlying backing file.  It is also expected tha=
t
> > LSMs will likely want to update their security_file_mprotect() callback
> > to address issues with their mprotect() controls, but that does not
> > require a change to the security_file_mprotect() LSM hook.
> >
> > There are a three other small changes to support these new LSM hooks:
> > * Pass the user file associated with a backing file down to
> > alloc_empty_backing_file() so it can be included in the
> > security_backing_file_alloc() hook.
> > * Add getter and setter functions for the backing_file struct LSM blob
> > as the backing_file struct remains private to fs/file_table.c.
> > * Constify the file struct field in the LSM common_audit_data struct to
> > better support LSMs that need to pass a const file struct pointer into
> > the common LSM audit code.
> >
> > Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> > and supplying a fixup.
> >
> > Cc: stable@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: linux-erofs@lists.ozlabs.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> That looks nicer.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks,
> Amir.

Thanks for refreshing your review.  Since we are at the end of -rc6,
it probably doesn't make much sense to put this in lsm/stable-7.0; I'm
going to merge this into lsm/dev which should give us at least one
week in linux-next before the v7.1 merge window opens.  If others want
to add their ACKs/Reviewed-by during that time, I'll update the
branch.

--=20
paul-moore.com
