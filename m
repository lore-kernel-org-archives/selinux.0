Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0323D7E7
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036668; cv=none; b=t2cNQKiuACZMCY2W1RoeN2YFbLi9UTZguOp5erAjCNuvX5g/ig15h7ydMyvXeUJ/oi+01le3TpeD9WBJNXo4QyYmzzMBXplI850uxRx/0DPhiYtVVx+gbmSU1bYh/XNJHqH2MiePpjSG2pn239YITDNDHnzita3sac8bkPzPx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036668; c=relaxed/simple;
	bh=tEkNtulJkRcUV06J6nGLoBhqlkwtcoj298Pc9JzUa24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaMenSs7EFCZjTlxxzQ8sX9qLYlqDaBU08O/TJvCVLQbpjzDnayJ78L/tod6SsAEYXjJPLG67Ohez0BvjNCIhwbI+UykAnt0FvsaX2VI4ea6sztfGxY2DWTnGW5y3MRP/PRHR/Y5klaemazH1kurcNwPuf4dDmexWEMRe5/Rjs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OeG/iwxJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OeG/iwxJ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7761b83fd01so3908670b3a.3
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758036666; x=1758641466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXMEkCGutEiFyLi/jvO+Ium7M7pq5hCMeTZ4PB5j6QY=;
        b=OeG/iwxJ8kuZGOAYJuDk/m99guURWNEaOVfohSRs0ys/EpPXFQ2irPce5fM94jIsjR
         s0k5p7HEJv2g4zcW1UOV7eYShi9fDVssiKNtEvFa24EAHYJPecszmdbQWd8KiYRKZhTv
         SHGWx9k69Dd3d/rZ3D6wAGZObNmM6Idr+VJzRz8CrTvBeaKhwGlNtxgWV3PeWaHaAzs5
         PO5P5aQDlJNLwGdda8u0JVWpmBXwEw9QZARbsYB5DSutyBU+/QyObGJSFUoiNtORbzSK
         x/9Mtl+0jEhxt0oz9L9ueStZymS73ADD7FHsIXXFIskQqpYIhKVOCPR69deAwfEKnEP8
         OJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036666; x=1758641466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXMEkCGutEiFyLi/jvO+Ium7M7pq5hCMeTZ4PB5j6QY=;
        b=kaaaSVZXQgVgm2twJPD99w647bmL2VHJc5ECSTo8NWbly+eNpwFQr3GbV9+3qob7lD
         eY5BjCjTBBbVQlCWacIhD0lxAZkmXZ38hMvoQI56mGEMGKIDKclxCn64sRXZQc5Ox0WZ
         D3CZitgsb5c7M3B/TNt2gABBl27kbodwQCo11nP/X3Xj6qX8Ejid9GdYfuP/j+YS/5it
         Er1lpgXHo86Lt1u/Xt1Hug7Sv6uzLEss7i3A32m/62VXr1+3H0NMspB/+SXjU7+e+tyi
         nW4ZCi5KuzlUbtCkTCWB1D3WK/RFIN3dqsJGeeWiDZ5uGUOTvhQgqMvubpH5jzmwEtxW
         d3hg==
X-Forwarded-Encrypted: i=1; AJvYcCV+QOmkKt/xxN6wK5lNQRV1KYiePLNvAd4xjoE+M6FwUfFVYd0zy6Xc4MHiNhkpbO8V1Wa2NaKA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38a/zFIL+O9ybDAM0JU6irpj3gHOXYcnkR9I7C3SWkcgJWzpN
	P9LXUVvSWewhmmbv+H8zBdfbTnPAJ1F3Vzvwt1ADxi3KpnvmN/8QELz3HDQk1w3uOZCFF18P7/l
	NvYYh2PZLTUw6wglCcmmmLcBNye7hdAl0cWBUPvCP
X-Gm-Gg: ASbGnctz2G9SGsJ8JrPeULu1wBigCjilDlSEgwDCPTgk8/o1Y412aFx8O9sDahSVlji
	KZAkPhxWbmn+huPl8bAdcpB4hVzw/dD2hi8UgEjfNlA4+mqY0HkFzgm5QLetN5hKb15YkG6t+I4
	JYPQ8on3gGvasjzhTqsFNob1rZf180Lc2pA5aJJtzZUStgseyQzmrv67rFhQidQJYkDosIqFh1O
	0lgBBY=
X-Google-Smtp-Source: AGHT+IEMRycRsGG0ThFdUSyfSe7K64xBl3hVVl2AZ2GF4f17wt82nx2DWaelqEKBo+2OnQLQy1J+OidjCHgpXn77LvI=
X-Received: by 2002:a05:6a20:2587:b0:263:767c:28e2 with SMTP id
 adf61e73a8af0-263767c2b08mr11490674637.12.1758036665758; Tue, 16 Sep 2025
 08:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6D-3kVh1sZgHGVxS7jRbKxn29Qmf55AF0co302jWZLyA@mail.gmail.com>
 <CAFqZXNt+sFKYsM4ds2dA9JROU7+ZmUqqLwKMWSw6q0tX2bdXjw@mail.gmail.com>
In-Reply-To: <CAFqZXNt+sFKYsM4ds2dA9JROU7+ZmUqqLwKMWSw6q0tX2bdXjw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Sep 2025 11:30:54 -0400
X-Gm-Features: AS18NWB0JTBIzMI1Yp2AaLpSUuWjjbW46oj5FsYuKC4K6xgYxVdYZTiHKeMamvo
Message-ID: <CAHC9VhSo9uv8G8Pe5pX3+cNWrmF4oxxGHqd5g_tNYVQ8GUa+Zw@mail.gmail.com>
Subject: Re: selinux-testsuite patches not always going via list?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Mon, Sep 15, 2025 at 9:41=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Noticed some tmt patches being merged without being posted to the list
> > (or at least I didn't see them). Working as intended or bug?
> >
>
> It was intentional - I sometimes apply simple CI-only patches (usually
> whatever tweak is needed to make the CI pass again after some external
> changes) directly, since those don't affect the testsuite functionally
> and I tend to be the only one who could really review them (though
> admittedly this wasn't really the case as the modifications were
> basically only in a shell script).

That's understandable, but I believe there is a lot of value in
posting the patches to the mailing list, it helps promote transparency
and might encourage someone with a passing interest in that bit of
code/scripting/etc. to become a bit more involved.

> I could revert to sending all patches to the list if you prefer.

Yes, please do.  Assuming the patch isn't world-ending critical, I'd
even suggest waiting a period of time (24 hours?) between posting the
patch and merging it, just in case someone wants to comment.

--=20
paul-moore.com
