Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4092FFF90
	for <selinux@vger.kernel.org>; Thu, 29 Jan 2026 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648352; cv=pass; b=n0zflDOtynn2J7vWgWnCFBiqCBBC5jLyX01jXSKsXshTPTrdsS5ZxjiRlomtAszDSGq73+J1Y/zDDGrF91K3TDUn4zgZWUh3Q7dts80FGvFUW4DQXK4uKbBTb5b8T/eXsOfV45Ziadgl1fnhru3OOj6oLpWP1vXpR7SCxmPD3Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648352; c=relaxed/simple;
	bh=+L+EqsxFGbq9nKKnaprPm9Ir3tOy0vr3+xqa2zLh1T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi0/QvzcPDJxyoO7qcyEMmqTC3AfGE37qsQmYQ5Z8xC/rp1gFoeb9IKOH/KLa3H2u0tuugMUVddRKss8SZuqJ+P3r0IyjV6eHuuK2L2Vq0dJp0DHhw4qkTybff2nRb9bOT+4qRZ0UZwkHmRBb2Q8X4H3m2QcpyJnzXt0MvuTFdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgiTQEnp; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgiTQEnp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so764775a12.3
        for <selinux@vger.kernel.org>; Wed, 28 Jan 2026 16:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769648348; cv=none;
        d=google.com; s=arc-20240605;
        b=hUfKz48dMujuNcmifTlAawSNTtRhVXRYEJd0//p2frr1c8RFldMzxhh67uFB6woW8p
         JIp0Ytj1s/1xfr/NEMPJ32GJuVmZlKjOMuipI7lVPqOpeMfNjc/+BjmcvjEx+I2pmGCU
         7pXnC5R6TQCTMYArY81UarLYpXVh0NU9mxkawS++wxSiKEvY2Zl3ubDokCLtN+q6WmPd
         g5jtvVwq1nUdqbAk3D8JX01NMLpGWBeAnizpuSvl0/tLWA01kMYMg5JGSTs+0sXwn7ok
         7z5lJQeRUr6S4eK1GDDrvP68+IKvcO0G3mKarGhqjIVoThZTgtnbKClq+HystwV8xCz3
         hz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        fh=w+SLROzAcJAzde4JDVJ2fPObcqQ0KfzxYx/gx0vVOXY=;
        b=Gutitu7imDrKVmWFeXmbSyfgLldGNH8B7ykeuB9uLOCVjXuder9j+Cb/G1Xd7NsOtN
         NtjTnqdq9r8tUSYnWBRpEj5iZThl89+Q2RByfhZuzbk9XN7Hqrcd8O2/u/4pCZqNSgrv
         RyBH++945zKvCb2FfvP0xGwD0/PEb9bRziUzkPJVh5ZK43CTbJOA5BPI1+ai2V6U/T2r
         eDj2V/IRQYJVE83zGt7pojHf/lQyyKFJv5oUmzrd+Y25xyij2OHpExaLH3D5QWy50d98
         V3OVtgrXQ9dhniZxnd7HIJyqK3DaNdzvTuwNrHg4Hl7MTbL/GC2jaMqTvVAqlvZLAEDk
         WHcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769648348; x=1770253148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=kgiTQEnpKJp/pjWzH8UIBoZE2prYNeOdPAmDcSgp2w5aKDPBJN5uF6sIQ17O5EEcaN
         ACyLVBvVNlwDDlteA0YIqufuqAY74ZjqMbYJ4tJU9NEEZn94CcJXo/9Epjd/HQczmXSw
         oQ68UlJ+ysPe1pwWStyhBRWb1KgBhwrl8ect/5mMeMeC2LbIGU2krUo3qleFHZZcB5UL
         oZIcbiABabn8ZJ0AByRhAkYpLWueJfg6OQRWhq9Hw7bnfLKCMVArAe1ksTnsKICVRJSs
         d5Dacf8qFkgg7Xd+y+e6WdzSOZLhxyO4qtDTDvpFsyFA0L760P9y01OOVPtjLx3ifnCU
         1Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648348; x=1770253148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=jA5jrD9FCylWe3XPMipcPlEq6OuQJNl0TpCC41fGpXVRPlSndkcee0ebdby/lefveE
         bFTnzYdndZt9Ux9xF9Vz7ywKg1mb8jfVRESB6e4C1xqfB0N860yEXduEXOfWtYcFnbSK
         Wyb9gijn7/Bw2i8+aP8rLbgvUBWjFjkf/6VoFPzkXrA3MnBDfXTcNlIgOZ+3OWbhoJ0Z
         5DTCsteZwaMeK9femPeeTqxG0RDbedRE+UZtn/2h/KV0ScbOp6KrDlEhenBQwd9gDLGu
         FirRiAiDGfByKKl7m84I5vG2R6xC4k4hp7LmwsfL8nsXAyC1NBzDHB9diZmjE2B2devO
         7v4A==
X-Forwarded-Encrypted: i=1; AJvYcCWcmsVrkH7z6ZXmzrcU+p+yfyYc4/89oNrBa23Shc1rsPBViGMTrHTYDKZgO0hkf/xv+ftz6RDF@vger.kernel.org
X-Gm-Message-State: AOJu0YzNUe3IyqFzfhihyLEaO5okgAkvMvT+qd9aTbZ1VcaEInheZSgi
	LVLVWMUdxba0OjxNu+Si4IRxvmM2QDUZAbxwK8L/OLz0tWO6wEJPryXQBmFAT0SIKaHyI0RfaDt
	9WAxIhZdE+cqvarZEG43qVzNBlVBydJLo0eEzB7Rt
X-Gm-Gg: AZuq6aJ9ArH+Pzyahq+i6qGZ8E1jpoED6zqTjEAgBfGBe5XNhNg8rQ71rUThIZDohek
	Q2bGW/ds/pdb4Bjs2J+pMkh2awhwMJch9khF8GDH9hQrWd+k204inWSIQ6eVxASz8jhckv8rLRs
	y3HgNp8lM/YHKQJayFiJRM78x5EhGME5H80h53HBPZ411uaFTgC24s74CcqkR/R4cjntUHjdZdd
	umkbpTOdy5wHxIYwIT5queaJBl0GDYt/DpbK0TGAlcPyfh0xXthkx1bO/84wu0dC0F5jyc9ouRk
	mXJkotQcdAzzJzXoU01qQKGrh+g0dA==
X-Received: by 2002:a17:906:f585:b0:b87:d722:f824 with SMTP id
 a640c23a62f3a-b8dab3cf66amr455166566b.63.1769648348337; Wed, 28 Jan 2026
 16:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
In-Reply-To: <20260128045954.GS3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 28 Jan 2026 16:58:57 -0800
X-Gm-Features: AZwV_Qg5mDXEWLmzjtDFHSng8MB2HQLUBKHQ6Wr860X_lRTmL3Z_ZmvOjLnN07o
Message-ID: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
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

On Tue, Jan 27, 2026 at 8:58=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
> demonstrate that behaviour?

Reverting only 1544775687f0 (functionfs: need to cancel ->reset_work
in ->kill_sb()) does not fix the issue. With 6.19-rc7 as baseline, the
simplest working recipe at the moment is with 6ca67378d0e7,
c7747fafaba0, and e5bf5ee26663 reverted.
