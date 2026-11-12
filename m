Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513093;
	b=cAiG6flb49qztRHEF52FjoexM2N/AIcuL4uQyvAzy4o3+e0qjBEntOe6GD0dt3qUL8zr
	 3I8b/x5cFt9e/X3QAz7dWLwnTZBweqZQCIBg1iJkj9fJyARElICSsFPy16mNV8AuLzda0
	 R7tiJ3X6U7WfXE6+tGF1Oh7HIP4Fj3yYM6YVrAZ4RYyQ1jxECUFXS84UwQ4CJYTx6jq7D
	 ok+ThTWNDcRiOCI48v1y8VFX3J1kxHClOR4JcSc3Cffb44UeILKOKuNA+v4/MydtxdukA
	 mGVxe8wnjQ43QuMO3ouH/2SYQ5i3y8Q9UY525wGIJTjugbg87h0QqKb1lN+609085ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ox554g5AFUOxbiquAxy3AbKjOG2lAdQFzas4Xt+QLpA=;
	b=trQ9Ah+KWJAQ1c0cL0H1mC+me9XKTfpQtDOg827me5k9COSuOwm97ipohgB6sPA4C1ow
	 XMsTAY7qAJl6nGA9b8gpgwf5Wvni8aHa53HC/8F/2BeMm+MIcjef1KgUEenjHqLRoacX9
	 Ko8KeZGXpgHQAKAy7PVbyeuK29DSFSbU4c7hWOLsC7qLeRG0sh5Cq+r5DyeRWReb8KJcM
	 vwQ+XfEVHU6u2if1KtKBuMd+dtbkHS4AB50nNmu3tqSs+HAgIWKv+Iy8q9nh8LtFtjqNd
	 998syt6inixKR5fyWJqx3A3LMVq+90r9kcZDVtcFJuoZI7UgtdxcJOl6eGvPQ6pNksQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="MfTK/eW8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA0606A8A5
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 19:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DEA0606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=MfTK/eW8
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ede7cb02daso10171555ad.1
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 11:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794513092; cv=none;
        d=google.com; s=arc-20260327;
        b=qZQ59ewAdW0IxFq5FwEzOFqzz03ZSHPY1BSk8AT14UFL8NHswP2UNlCdBcLZ6+B0Be
         hRHxLsQaz8PhL2td0UhmglC0uQf8DipN705csUPY3SfCtKWueed9yyFkHD7b+V5YQZzo
         UxddkLHV6YNIMXwIg9RYnMw1r0KKRc231H+5TZF9t91bfHdeDEKHIk8++3BYmDib9mEl
         r5AtMyW9aSaYIKuIVv4wtEAwUTVBkGwRSGZvmnl7867MhC3cFSf4xb/eouyxEcQXKLID
         gF3xz3ZB1sQaXxItrV1CAsjdLksb7lmNB4Rm7x9CdKYyAV/oqV6VLgfJZ7O+ePNGwEss
         Zkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ox554g5AFUOxbiquAxy3AbKjOG2lAdQFzas4Xt+QLpA=;
        fh=KSRXpfC1k3YggboT3SfAZBngCOQOtOP4zBOS5/hTi44=;
        b=A1NEJw3Xi4Q2TLy6FdvZoEOGFu2IubTmAIcIf+Jtfi3f0IuzNxNmGGr1WGsRY3Nj1z
         XP+FtUXbUJvYhq/80+YLggqgihthBTRKqesWgvos9JbLgXQ5Owk7OGAb20AC873obLJW
         hpCltPQVUaHCbu8/XD7g7YqifaUk/zHsmG3jyYUuJ3dSiLf9nX9FlKy6lVNfbxwyXcKk
         ohxjiCnM9LQlNuamVqejU9nDfD7ySO/gl+GRA1W62bkQbnr1Z3AzQJP+3KbqfYGjO4x0
         tmR+eY4UpxV06ZFA/oHLK9rKZDbLO5ebMIen/ZCy7Q4T5xplxy67Nx6Kc355iXgLomQp
         q/xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794513092; x=1795117892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ox554g5AFUOxbiquAxy3AbKjOG2lAdQFzas4Xt+QLpA=;
        b=MfTK/eW8yDpUXVRfQkOUgsheQ3aTOMAxjq0s70Fgbe95v/4p90T+o1wUclNz5aa3F/
         xp/SRmdHDkpe5g0OmGFbEeu1R3+l1pn80OijKazcTAnQOD1VJXOGNSY1Zvjw16Zc24sI
         vEuLLtUrEuMgfgQvxMQbeHy3VaTzQV9R5pd9uhfd0sv009qJyd7StWjXJuNOUDsR2VsI
         /HITaodUNbpaUt/9Exd79sVLXrvK77UZnPkPlp4C5TqfI/1IIS52FCNPqmnqJq+t04Zr
         HQwqRir07zOFIperkU9KaRzR4f+I67ZHVAccMmIsYg/iIDUbeY8dEz7bqYYqzlBww/6h
         862Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513092; x=1795117892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ox554g5AFUOxbiquAxy3AbKjOG2lAdQFzas4Xt+QLpA=;
        b=QqN3KXY9PCxtWhR5imgz9/62WSWo3B6SphmdwjEZSHpFU9EO5aWdgXO+62TNVa8+iG
         v0iaq2QRbZKzzVC57A9IPKWbsLahWLN0UshgbN+/BFk6qRp2QHgRLF7SNe4XEmBH4W/q
         N/F34skCpYWJL4QNeOSUxnSxP6N5JgZBl57rhxQ687DEElpm8KEulGB214qCB5mZod62
         mayleqEkD+Sc7XHciCo1kmqs9ODIMniKr8bHQWzEHqASVxCyNWeKKmwZHp1YH4DkosdX
         LEqcMHbF001NMnizCMx8WNoB5doJr2ODeo0O4oLhYlDdWPrxGU46k7lRSuNRKE5d05w9
         pSRQ==
X-Gm-Message-State: APuU4Z8uK+UgbKH55cQBEbblam3OlvG+o0DIKcqjMkAF7lZSPKQb7EjT
	2IJXoTvawg072OWk2rse95jnYsUqC+tITHLZRUQ5RHvRMvF/Zv7IzsJtxpiAMf8moq0/EZobKW5
	atOifE21+VqCUJ9mEMn9ngP2u/WhhWaKBdKeIbuMw
X-Gm-Gg: AYBFou2AmERNCE6zm5Vl+XfrErzmMsgw111jpZAj9uTGvn/C7AlQYVrqnRjHKeXPLbJ
	RO/RmQ1HYd6yTrL+gRSVptYeK1i0quUP0lu8ohkAiQcbzwDsMPEPqHw7rizarbLmYapB4KASSq3
	pwWAHzM5vPA7dftjdZ3zc5D0U6fQmoRCJJ6gKAyc5jJ2OzoyyiLK1XPB1dOVa52EDxqu+nELM39
	qlteHp9iGSqZKLrFzCY8Sof5J5MkvbINSiXXDFkYB/xiTYrqqNcM9e7rIybRF+pmhErpE1tbC9L
	4Smv2+HjZh6Gz2Rtz6NEr5J2qFujA8gKBm0SaZFAsGFhHP+YyMkiTXXhjEunLYo/Iu0cdfwdlB+
	MbQfVnaysgTSbmbe+rkLlvCR9OhjM1hMSGHG10Nq2u2btYVJB4Fy2pHRtcsvdnDGoJErzk4L19p
	kha9F0VeKGsWymAA==
X-Received: by 2002:a17:903:3886:b0:2ea:dee6:d672 with SMTP id
 d9443c01a7336-2edf1f2a656mr26108765ad.19.1794513092208; Thu, 12 Nov 2026
 11:51:32 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110154125.31153-2-stephen.smalley.work@gmail.com> <CAEjxPJ4=X+nmp-abqfQQY4HbXB=nRvpMSN3RcpkMH-DPNp=8xQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4=X+nmp-abqfQQY4HbXB=nRvpMSN3RcpkMH-DPNp=8xQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Nov 2026 14:51:18 -0500
X-Gm-Features: AclHuK9Pj6gjn_3oaIxUJLIhi5O34nJZCDrMVa6Dg24VDycPDmzF_nHTugf7NmI
Message-ID: <CAHC9VhQbAj8E0b8jUmgq1egqMdSivEwBXVYq01A5uGCpnys-8g@mail.gmail.com>
Subject: Re: [PATCH v2] tests/binder: fix binder tests to work with the Rust
 binder driver
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnacek@gmail.com, jeffv@google.com, 
	tweek@google.com, Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Nov 10, 2026 at 10:42=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > With the original Android binder driver it was possible for a process
> > to invoke binder transactions on a binder fd opened by another
> > process. Hence, SELinux originally implemented an impersonate
> > permission check to control such usage. This however was never used in
> > practice by the Android userspace and never allowed in Android SELinux
> > policy.
> >
> > The Rust reimplementation of the binder driver intentionally prevents
> > such impersonation from ever happening, failing such operations with
> > EINVAL. Update the SELinux binder tests accordingly to drop the
> > testing of this now-obsolete SELinux permission and to not rely on its
> > availability for the other tests. It doesn't seem worthwhile to retain
> > the test for the older driver since it was never allowed in Android
> > even when it was possible.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 just re-runs ./tools/check-syntax -f to fix a formatting nit.
>
> This has been applied and fixed selinux-testsuite runs for the
> userspace testing (selinux-testsuite testing is still breaking on the
> restored NFSv4 tests presumably due to running with a kernel that does
> not yet have those fixes).

I can confirm this fixes the binder tests on my systems.

--=20
paul-moore.com
