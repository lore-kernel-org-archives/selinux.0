Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F462192F4
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071544; cv=none; b=r49v/yboud5xvnRZwj/9hNAnjj6BKUhgMvqoSKVPo2SquYEo9VPnlgcD4t7TwAYuEmTBZw+l65wNVOT0I4t3Vl7h8T/iiiIu8Ru4Y78wWntu8BH5Tz4foinCm1n69odfnyYn0TO4rebJ15YOVGGT672WPLKj7/zVHIj1ghzkaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071544; c=relaxed/simple;
	bh=SkWjuvQQzYSRCCcQFZmLShIe2VMnWL7NbyvJUTYNoRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bN8Bx8LtpJvU2ADSNurxBEMgjZP2JDct6AREhztE+e/8E6YqxnE3nDsyNxMH1hrerEQBoDZ9qVJg4dhK2mEJKcDFnhJfbbkLdQ3HdDX1eW5r5FcrSoaVez9ES7U7J+3iEa+0AgqYrepR2hqGA2ZqdH9qSId3Mp34qaq6M9t2ZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVokjG6J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVokjG6J"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso67515375e9.3
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780071537; x=1780676337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8ivf4oZU2OMq2EC4pcFXCevvcnJjeHsSceuHKJCb7Y=;
        b=bVokjG6JN4p5PKkZsoUF/8Zv+qHrM1qGCU9q5BWlsKYbgLriBtd7TUuOXvPaIc06IP
         RczGktbCaGwQtJ4ZfVWavQOa1ZATpK3ZFqcdzraxHCwXriSzx5GEaCx87YUaFekEO0dy
         sSSiUroNH9ZNKNDEw61sgc2TKMFVDRGFhTRBPOiQ95T37cc0t7BeEpZAR6ZLYUe7tb4A
         EiySrEH/WtbqCSYxvjKQ3TdApY6GKMzYAfSMmVZnJuPeHGT0YYLvTyCcPgPEky2NoJxj
         s3A2UH/PuYcGNmn22FNCGg4K3ERqvmu0uZH2c8R7WsGPxP3XrnZUL7vZlqkXX7Y6H+1/
         7A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071537; x=1780676337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8ivf4oZU2OMq2EC4pcFXCevvcnJjeHsSceuHKJCb7Y=;
        b=drIxdaViwUDweFs+23DUFv87dExb3dC7Y64ESjTS9OTHGzpVM2Iz59TnYU4QtNXVp5
         J0tj7Kdw+EHOn85RmJw9P9tDi821OV1eDXioMjPkuUgdRHj174RxGux2JjbLHBKFBdSG
         a0i2ZmEGwg8CAo8ZweJfdvU6ohrfoWSatpsLATwdqxGLT2bV1rwheITAwsf6aKbss3NU
         1sVIzBxgFdKT5avK9WrIMj8LDXXsaim0nx1MdJ4ZcPxw0lZ/h1h2AaF6B/v8TN7PDajT
         PU9JJENuWGRN/lQTFfDuySZpFkGFEPAAkEs9Y8EQTuDen0aU4NTPB/gWFKapxlKkGUsA
         5LZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WBm7Xh98FujNQwWKuV+jb8/VRt2Q7/qn/DbKVg1GVp60fjOBEdrY5jSGUBd0j6dx71k+F5Oqq@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuC3HIXQy54+yNIzyzWaR8qF6/DOuie9qHHvLJZoaTJ3jEFyM
	hEULJSdmG32sjPzSX5IFnXjLvJ63MZyyHnMTJdKK7T5Rs7jJ4YzA5cKS
X-Gm-Gg: Acq92OGSiNAoCzgOfNvTNka+TC5lLsr5xRaAK4hz37YmAbHmK+jsVFs0jTFf92qCdIg
	od+RbKwTvPD1IwZpo7z5lCrCZP1SiLU+SZmbxPcxZImzGeZY6y1J2eneqWh42fCOOLxMumd4yK4
	zpdogb9AkdOEBEG1E6I9aqbGy1g+m1lqKVAs/46Wkfuq+WsrsDIu0FFEFs/b70IooiIrxoxhxoh
	Bzv+9du73NRLks/aSsMnFZijkHpjUQa6wiUwm1atO7zj8hBT5BqNP1NxOJxj2yA1AWmPa1SHuu7
	mwzCxQWpPmYfBYSsh8EBC4F2pfH4A6I36Hn6UJYmsOCz1Nz4YubdzMiyQ2udhRp0+CBzaybWjgg
	a1yFIwosZ/IuHV8s2sq18RPVPkZvUx4F52uPa8OUvrBb4W2pErDGHO+ISwHI0c5HUngkJIR3waE
	zGZQKdwOFGtX9GP1o2Z+5+Eh47zdEcXx8TSwft4G8cQTU5vOUNZ6W1D4MM3Jy/LxX62XrBrbg=
X-Received: by 2002:a05:600c:314e:b0:490:31e:d6fd with SMTP id 5b1f17b1804b1-490a2968488mr4398265e9.25.1780071537044;
        Fri, 29 May 2026 09:18:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0498e0sm25344335e9.0.2026.05.29.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:18:56 -0700 (PDT)
Date: Fri, 29 May 2026 17:18:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, selinux@vger.kernel.org, rppt@kernel.org,
 paul@paul-moore.com, LKML <linux-kernel@vger.kernel.org>, Ritesh Harjani
 <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on
 Power11
Message-ID: <20260529171855.7966b752@pumpkin>
In-Reply-To: <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
	<8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 19:07:22 +0530
Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:

> On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> >
> > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11=20
> > hardware. Attached is the config file.
> >
.
>=20
> Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname()=20
> to allocate path buffer as the first bad commit.
>=20
>=20
> # git bisect good
> 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Date:=C2=A0 =C2=A0Wed May 20 11:18:56 2026 +0300
>=20
>  =C2=A0 =C2=A0 selinux: hooks: use __getname() to allocate path buffer
>=20
>  =C2=A0 =C2=A0 selinux_genfs_get_sid() allocates memory for a path with=20
> __get_free_page()
>  =C2=A0 =C2=A0 although there is a dedicated helper for allocation of fil=
e paths:
>  =C2=A0 =C2=A0 __getname().
>=20
>  =C2=A0 =C2=A0 Replace __get_free_page() for allocation of a path buffer =
with=20
> __getname().
>=20
>  =C2=A0 =C2=A0 Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>  =C2=A0 =C2=A0 Signed-off-by: Paul Moore <paul@paul-moore.com>
>=20
>  =C2=A0security/selinux/hooks.c | 4 ++--
>  =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

__getname() is kmalloc(PATH_MAX) aka kmalloc(4096).

The old code was:
	buffer =3D (char *)__get_free_page(GFP_KERNEL);
	if (!buffer)
		return -ENOMEM;

	path =3D dentry_path_raw(dentry, buffer, PAGE_SIZE);
only the allocate was changed.

PAGE_SIZE is not the length of the buffer.
Should be PATH_MAX.

-- David

