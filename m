Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD130C62D
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781468733; cv=pass; b=bLabgBcDrj/3Fsr9t323aS61KE0oOjYbwgOu7wsfg9iuHfHiKShWBQM6SvmzaThXzI6h15k+T2EzhLsm4MpjdEQ8106Qhmn1KBN6cVfgmOlukb3M64rb/KQzWt1cK37g9zGPR8as45X/poiYPzZDv1PaXjGktiB5TGq0bZPJfGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781468733; c=relaxed/simple;
	bh=bOKxDPKuaCxZCEB4psu/WuUy/sKwaJ1/swXJRxsOzFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqH19kedxhZO7WXJgQNiKsQxAwcvfc4YH4ifDCsSbGS7klB1eHRRxlwcDvav4lzd9WHg3ws8HFr+Cx3tKAOIE8udnjGEBHO9+QXKhtdncTD6fNEuK8wfuhQtR6f9MzOs/TJVIsoJ2cKnT7JBzJ4oRS3gcbdh/kuEe9fq/vhSIhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SVPD0tJe; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SVPD0tJe"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so1669802a91.2
        for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 13:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781468731; cv=none;
        d=google.com; s=arc-20240605;
        b=GJDZUrxaI1vzET22WB2mO2nlxKD0r/6NssUPJgIV5cZc9+PymkDWnubfZlxis7DYdL
         EyhZU6q+q9Fs2PDv5v4tQQ03pNcsZVASx8AObTy4Wr3D5yw2YTwR7hWsPKyGCENwOGk+
         ok3vq7NT18TssEGVYklrA3ZJO4z0lDOyW9Tb+yWEvDjAv1ZuPVtUHD0EYu7Zo7iJrRvh
         s1GcR3aMx20TRQH/U0kP18M7J9L0qnHISuVk0XgclSRhCM3rwZReyuzLh6fF7T7DdzWx
         hm2AgweYWmFhsxEXyecvytUjWkKmQ6AJvpRa7Sf8dfbI9VNAX0uP5MCEKl32w/h2FY32
         2MXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6175+bhRhWWA9QTYt0jgA82Mq/7abv3w42zWcC6M6b4=;
        fh=xXinDKdGn9a6c1rimV+S4jIE+s7QV4YkzpdMpXjeHgI=;
        b=e9aBGEGVnAFeY/1zYWasm6k/Aq+EKSr7GrITe8S75ffhID+ZrBQPEsomb1vd9GLnyX
         JDAt0a3mO7uDcejua6IrhG2Rz6uOZM4xCu2JJI0Cy6MSqovWMx3tOYfayq/Y1rWJOXnM
         ury33tvx1kta2lcDFXbyAcJafSggpfMGwMzu8ArmVLEWCMTIYae6UUbNjfFz7hzV1UB+
         UfHietBsScN71wmfnGaaVMHahRl8jESHbXdZUBIAFjapMhNHx3Lxsh7TIcdZ5hOfBJj8
         4sWex2WqFcVP5u5y22m5Ri0AHSu3SnGgpg4HLypuAYugRjqAwMANSxoSufInGqVzWrsa
         iZ2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781468731; x=1782073531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6175+bhRhWWA9QTYt0jgA82Mq/7abv3w42zWcC6M6b4=;
        b=SVPD0tJeGfv58tUC40z0BCArMc8XceZ+5AIcLvaPZCQFfjKGhKpSGj+CDBr5Bpu3x4
         LjZrxg5DEqG3Vab+PW2Ti5gIC7/fW0QABub8YzXVMrECUZlbq6FK57HEOo9X7jXKSSto
         FRz4ZabLEN5CXO8Ac4TNQjn4LiwI6k2k/j4bsfy/b2LEPJz5HTtb/1JZ0l4Tzu6P2hKL
         Dct2XiAsyOSeDjt5dcuqVq1NOrkkSHIoM/aLrdl/jyo2nf0zt1LYHDMVuBFNMqEAdJ2k
         x0nq7+DFgrTZZAvY9C63M8+ZraMnxJcI3GbUjj7ACSZfwoxCNGP+m8R2s3m01T1F/IUt
         pLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781468731; x=1782073531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6175+bhRhWWA9QTYt0jgA82Mq/7abv3w42zWcC6M6b4=;
        b=C9M0CKA+XpGoJqMZ8IV9oJgkW1nXdqmP7a1wD/hJzQQmiSpq/s0Ru25ZEB6xSL9KCf
         A2UBMY5sj8vW/pm4Hy4/TvIB5jJENNNBJYe9HDN5VyjhdlojtDOOI4vBbtLLdzZ6GDKh
         EO6X3RIjxMj8nxOWprzzTE2FW+xt0Zho36cHPDnoxFQugfTTxna15ZZvmN9TXOMfGOHG
         SMWDjpqb5Rp4NYVruic9t1YTNMBsFOpS/oIOaa2vgfd33oiSl1k4AdkHq54c2/+JwuuM
         DTYpzWIaqV5wTq7BdIxaR2IYwn5crcbvMinB5JpnCuFkEfR21O5wYtiMCIVF1ukRQb4y
         xrqg==
X-Forwarded-Encrypted: i=1; AFNElJ+5PNpI76VykUmy4QedafRKtOboJdJRH1l9DCeqn4FrrtLfRsRQwfn5BxgVOg/mVZUQ1NKwS+f2@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZS7NPevD1yRzI4mFbj2f++hGKDNJwpr/IlFyumii9fFPzU+7
	Iy2dYjnv4gK5TFLdVAuKb65MxUcwq6TWsTpPrrYORPqOTjD/gh5P5G5BJvfiU7fNU5MgPzUWHaz
	4S708MV1SWCrfcFh4B+h/TbC/FAlZf4pk26GA/GIu
X-Gm-Gg: Acq92OHMk0ZTeI7GOuzLeuTnExYXg+8ofRPYUmfZLoNUAj8emrVepUuZC53A8Kl/AH5
	T8DvpA9NlK79E+ownuYbt/jL7evVXMLKjaC64Ja4DDRIzeC+8XkRpJ6mwV4vmFMKtqXH9WXjvie
	nOgeTcqv/ACixRWwrXxcOoOZoap3StUz8yBIjIST+Rd4iCtJjU+4P5UUbCVcCb+bct+ULltTcoG
	0elm+DSLDY7xJPjI8FfDebnSxODm1nAA8gVU1EI/1IvKzG1i30fyef+UbLL2EZAFjqOALGHS3rN
	DBnPWqc=
X-Received: by 2002:a17:90b:53cb:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-37c2bce7aedmr7047109a91.16.1781468731181; Sun, 14 Jun 2026
 13:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
 <b99c011e6d988fb98ad017265115b323@paul-moore.com> <1c87912e-7d7c-49a9-b964-3568e63e74a0@canonical.com>
In-Reply-To: <1c87912e-7d7c-49a9-b964-3568e63e74a0@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 14 Jun 2026 16:25:18 -0400
X-Gm-Features: AVVi8CeHUOSJ_1WPAZ_Ef02Y1P18TzRtWRSe47IYgVhmXKXgZJVaIOmP9BY_9dY
Message-ID: <CAHC9VhRvGUQKiJUNCY6oYY2PuWqQeuV8xdczoAqXyRw9NAtdSQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
To: John Johansen <john.johansen@canonical.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, casey@schaufler-ca.com, serge@hallyn.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 7:29=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 5/14/26 13:47, Paul Moore wrote:
> > On May 13, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >>
> >> Just as proc_pid_attr_write() already does before calling the LSM
> >> hook. This only matters for SELinux and AppArmor which check
> >> whether the process is being ptraced and if so, whether to
> >> allow the transition.
> >>
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>   security/lsm_syscalls.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > Thanks Stephen.  I'm going to merge this into lsm/stable-7.1 now, but
> > hold on to it until next week before sending it to Linus.  While I
> > can't see why John would have any objections to this, the extra time
> > should give him a chance to respond.
> >
> you would think?
> well finally getting this far back the backlog (sorry)
>
> no objections

A review is almost always better late than never ;)  Thanks for taking a lo=
ok.

--=20
paul-moore.com
