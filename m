Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DD246783
	for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090721; cv=pass; b=Jlsl4Ytk5Ji9SutzxN87sns2c4kjuGntqrdjs+W2v0/tj74+gdtwAXP+FZ3Z95x3IZYngRc1zyrLYIrapmBPY8KfF4sfj3LsA5KPFA2NmHRm1vhzjZyj7L4Sz69qA56ZYd9RfoiYJjGv8f2beTQK3ASTVafBFYqE8amis6dX2+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090721; c=relaxed/simple;
	bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJqQ6vr/j6IZTumAesr0tylYcQv5sE1GHL2+3R53tDR/XivUv3mRovAr9HcmcvlvZPCOLNQgl5GbZjxQQcrR+QIiBiXInl8s2dy+HgITHUUMCo+abI8FAI2EGhH0uVETUh9Qnecqud5mWi4g1B7Ny20iguEFd+z+dWy9UJ+I/yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QhfGUmg8; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QhfGUmg8"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1851736a91.3
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 11:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785090719; cv=none;
        d=google.com; s=arc-20260327;
        b=A1AWg+mTegxpCKuUYXSc2oMr2JVNA465UjcbwN9QDK4qCwxJds2SXYdsbKqZA6vzd3
         2qZIh7nlUONyLvRM7yIrD8vW3TVdg9B16oaevK/6dZrOy4XPL+//pTyLCP+RCWIo8FNx
         CupMHRrRHuhKR81EX4AXlRj5iu4LeXuu1hnE0D3aKfmryPtl8VTYToQGnkU6x75kopN6
         ppl6Te+O2ptbEwD/6TWZW9//qu3v7MOdBIMmFpHzBXX7D68O8FVGSBWmu0ucrwEkJkwr
         b3afsLh7ojuXM01juexknhEBypL89huF2Mit2SP0dG9nFmCIgKR7o5CLrIwd1bTrqPlj
         IxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
        fh=pNcl+HYoQDiWRfFOgyBh/l/ZPpJ6MURrM0Mf83aJLLw=;
        b=P4XAGrRaWjQ8lKA7AbTm74vKuC3pMqjAxET99ATB214dkVa6zurDaufd+DiaVxQAGs
         F1Vp8dXzaasKJ3TOkUy+W8ZZnPaVDdNLaqEJGovTXZRSBr07GJb0ckclBL9Fhcvu7Nsy
         tJvVH95VqZdMUW6Y7rejJ5gms3aoeyXjCCZ6DBjB9LBQz2qr0Yqb8Ju/zWgNtMHfS7zS
         qr4FMlnX7k2z2mS74Oq7OSM5bUyq3Ml/vMdkGz17cTZiZG9tsttwdXwsWOwBF4Fd2GwC
         T1A2TRFRFtNHRyS6eAPM0GnGUcF6IPDcB38ER1IsOamdxa4nLUlJ/VAPGhCs9TjA8/0Z
         O2Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785090719; x=1785695519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
        b=QhfGUmg8I3rPtrSgegmXPOrMxtuAM90LL69pxeCzyvkBgck0+1CIwlPfdQHYcbZ2n7
         NPZsjgWQ6YIJ3a66AZwCZOsQxMqeRTRXTHQK1biARWYSZNJcyWkbXmpYgAlOo/g29vVP
         mt1Yod1Yz6tz2WMced4Q0CCH50v/IAkyDmcoMdNbo0s6bBOY+9ojymv6H8OE/eZomFIW
         098l+4Alxb4NQhFezisDdjNi6PVu+bMrbm2b8IXziiln2JRPF+JwyOYNZBUmz2UP3uwi
         zs/OtRZuudl7wXU36cUtnxA92rzSkZvJZp/BDJLIxFjaU+52CHkksN3Fue8zp+XHHSVA
         0mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090719; x=1785695519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
        b=fnns25ZAPmVUm4DKo1cbSH0nHeJ2uqkSzyrModSwxamcyTM+Up06sdWCjUY8HuNi4y
         H+0qzDsSjVXZ3004/Nra3hiubLnIvnL/WPLfgh3ZNN5i2NlPDhStPp7yTa3XSXA6ASha
         dGgkYYsAgqF9DOqQnz/M7sCuTU9SGU52cFc6R4nkjX0r1f9n2crEFNrhVn1sf6SNSkyY
         aR7xyLAercCe6hvM772/lmpfeAJU4mdiWVmzjN9C2pQ8IsfyCy1Ul72wwgpDub0KplMd
         eXoABjf+YnjSLjvR5/pRHq5yjH5KlOyOtdL3PYSyiG1xhs8+4mdSXnpxzcKgQ9LdCpzk
         pJNg==
X-Forwarded-Encrypted: i=1; AHgh+Roh0QiMBT+vbFuwU/Iqaju6gKbiUi6LkNaoX5ptTC39ZhDDuiCTX9b1RwnAOyVOy0e36Be2lDpO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqex+yQUouXqVyl3bUsqKHZkX2MPxBFopqHatGcKfqnfiesT1h
	RRAffV189HdbUy/YafiuGOmXuxOcnADn4mCDi9+SZJQHPGMBJdRE48EHoXbcYEfNUoeAVOcfWBp
	asxQ7OMKIoJ6f0fZWQdxa+l/AjrH9K5g7ba0CFcEJ
X-Gm-Gg: AR+sD13c3YC9gOfcQ7fS4loj9OUXpZBAug/Ai1BWvXn3CRvQh2JB2e1o3J23hXyTDZz
	ALKiQtWXtNWWHRyqnV8lBOBlSb4FyINp3Gmlu8NoJihXbV3DQtNg1Qf9NR1BrLqGuUGk2AtUdvO
	dfi34Q6jXLomjRpWsu0WM4iFzytZroZ4vKay8wWXjVnOn0XDkbdnbXLOqdca4jiH8qggNtBG8LQ
	k3Umt4UftVdU5JZ5Edk+DmjZILqTHANq721vanc1ZDN+cYNMs2pHaxqf96rXNMhqrwK/VEn
X-Received: by 2002:a17:90b:5443:b0:384:5dbc:cba5 with SMTP id
 98e67ed59e1d1-38f2961134amr5446040a91.26.1785090719086; Sun, 26 Jul 2026
 11:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260725200958.4471-1-cel@kernel.org> <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
In-Reply-To: <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 26 Jul 2026 14:31:47 -0400
X-Gm-Features: AUfX_mz4s5ELv8nSMCfCIDeYTuebpIuEr3Rnq7Fv6nbadAxzkUffEPG3Vn49cbc
Message-ID: <CAHC9VhSh=fXCcDG88m0Qbt61aKajx=cHGQXX7DbyiQtkJRtKYQ@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Chuck Lever <cel@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 11:03=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> While I don't suspect it will be very interesting, I just started
> building a test kernel with Achilles's patch that I'll run through the
> normal selinux-testsuite automated testing.

Not that I was expecting this to be a good test, but FWIW, the
selinux-testsuite (and audit-testsuite for that matter) ran clean with
Achilles's patch.

--=20
paul-moore.com
