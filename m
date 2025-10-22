Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739231BDCF
	for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176299; cv=none; b=g4WvaRYLeeHlI69MDsyANcgmjuL0ctXTGt0JHedi1bYqI6G6rEJNcMnynpZpodgdNW9wZeWWvuAv8Juv1VP+cn95weBT7+9eg7Vzi5APWi+JtB4uwpx+N1iKXVdOhEBkp9VD/D/Wwn39Mid0pxpivZR4Y8v56SPlV+Xd/W2jz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176299; c=relaxed/simple;
	bh=LYKIPVspJfdSDazyirPz9heRK01nd07VwEgWmL8zD1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGI8twMRMm43hTMuTiWgBDP7BY4gEhXbh8KTFHKpa5WBpaDDyd1NwJP1UBnOzbJ7MA/XaJ5Dd3CSHqF1K4oTXvthSBe7hg2lgTn6ADWTyESmoVKCVCD3aAWPKs4HNYT0rANdrI1n99AZ9PUIpfUi3BV4z+JsyTH59qzHpmqYiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qx+vvEKs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qx+vvEKs"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so189208a91.3
        for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761176297; x=1761781097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYKIPVspJfdSDazyirPz9heRK01nd07VwEgWmL8zD1I=;
        b=Qx+vvEKsiss2jyAS4ZL52ZrnPKZoXtZZHIKhFRVqMez9YaK7R0hwb2cJvRqjgtm833
         D49SIEv/ZfUFiMLzZX26P/0BphYMIIzqLm4E9R+zDvV4qEHYg6iVZn+MDaHk54dmMBsj
         vT2XfKKP8h9bLkz83+7FPmkMUzaLahWdw/NzchupCCuKKJPDoIFDW9QT/uiL09H+5XLp
         Amhn4QWtsh2AyQ7hcoIiPkBD8w25mefugFfmxgQVtbJHVJtnoUl/yywFbYo+RSHSbU7R
         /xViKIIliFpAsw5cFH+h/biw8InxG+wwDVVTPlaLBH+enQYZ+X0yrffOXgclWTIgc37J
         QFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176297; x=1761781097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYKIPVspJfdSDazyirPz9heRK01nd07VwEgWmL8zD1I=;
        b=ux3HSOnToxlvncMrW6auG5Xo5fTaua9swfvVPat8JNtLB3MFIb0vyf+Y8JkeakkUEt
         v6wijaZcoKJ5/KOaFcCvW8SjZaXDGY1Ne6zHRIh4MGnsHJ2ReJsPW6tV4CcxTucpFFkq
         QntX/4jlvsIIje+EMmz7HejlPDmSGSn31jK9cWDq2YS4fGXegMMiBo5uFjCpI0TGFmC6
         PaLnpXkeO2mayL4R1LkgjDCzJU7jMCnVajcNOKzKgIW+XM8vumnFRDJNg7RqqPjq2k7q
         jPvfqrtUWrxiW9m37VoVUFUVYIsrvSIrgR3QvqNkRL6U8sBZ0EpID1lNVx5f9RGjxx4u
         wzJw==
X-Gm-Message-State: AOJu0YwZ4kJyOzKBsmIwRVf2YUo7OyrL/kTC0T7li1oSRzHMppqCaQci
	VNa2ER0RDTnNEbiRaLeqGjg0BIrcY9m/559Uwm6AaxvYCqG7LQ4HtHesXYJHf/IWInt8gZklbmB
	/yJCqgQ40KjC15oKrqiaDhYoxBjzVH4+ezP8Wb+Pq
X-Gm-Gg: ASbGncvgfSbhoWu3NNMVE8VflulvlSt3xf9zYRBcen845DGIFY5ji1ctn/PbDracGrJ
	wL779AEWj2uEMc7I84L/g4ANQfCe7iE7+h46BW9D52Mhjnu72VOVZZjGJPsy9Ng5D5Xr0e4NUkV
	dbgYHe/q+C+mzJ9RFaaiCuL9xHbd4uDIaMswZ93tHjeIxbZcsqsaI0MtlA87y/YOXEnxTXB8SRU
	mnCNyJ3T2qpDRbrpmv4bfBysIvpiabfzBjPHY9+pIkBGMH97eZwn6onWS9EZF6UR611+Y8=
X-Google-Smtp-Source: AGHT+IFK04iAW3gOsHv8S1u/QXELPW5K5SBc/R9s4BwDZHCkM4JlYq58OhcVziGaFi/ZCwxwJYz1TQcg/OikgCIEF4o=
X-Received: by 2002:a17:90b:1d88:b0:32b:df0e:9283 with SMTP id
 98e67ed59e1d1-33bcf90e86cmr29335173a91.34.1761176296693; Wed, 22 Oct 2025
 16:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4CNH91Vh-5dF=43Xwg7WpSq8obKn+iAyg0HhqWqBzAUw@mail.gmail.com>
 <CAHC9VhQZ9wdb9Tr4V40kXu_40xF29+dizae2oysPL5LKnkfU0A@mail.gmail.com> <CAHC9VhQwR8vu1ajp1NDir3KhWC=XW_TiqeNHKz2nHRWCHnADEw@mail.gmail.com>
In-Reply-To: <CAHC9VhQwR8vu1ajp1NDir3KhWC=XW_TiqeNHKz2nHRWCHnADEw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Oct 2025 19:38:05 -0400
X-Gm-Features: AS18NWD9fS343AEqcWNTqXNVEp4p89bWGq6pnMwhEoGbbJKWPTPqB1hYF4BRWk0
Message-ID: <CAHC9VhQ9xk7LFVKkZ8uVeWVQUpSO-TtWOziDtpJYDcbUzVi4oQ@mail.gmail.com>
Subject: Re: Fix for v6.18-rc1 udp test bug
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Oct 15, 2025 at 5:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > ... I'll add this to the kernel-secnext builds now so anyone
> > using those should benefit on the next version.
>
> Kernel version 6.18.0-0.rc1.251015ge987e.18.2.secnext, or later,
> should have this fix.
>
> https://groups.google.com/g/kernel-secnext/c/6NKuDyD-DHY

FYI, I also went ahead and rebased selinux/dev to v6.18-rc2 to pick up
this fix so that anyone building kernels directly from selinux/dev (or
selinux/next for that matter) should have the fix.

--=20
paul-moore.com
