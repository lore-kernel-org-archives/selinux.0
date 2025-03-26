Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365823FC54
	for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014214; cv=none; b=CnZTU84go/qxW2AQKBJEkavkRo1w/qjZfrxtAmf652sw8okx5F39u65cAdQPgoObOTEYQWuCnrN94B+9uxz7KeJN6ep4E2uBBXhB/noOACuGwwxx+DDxkaZbTaOG0I9Idys5pifT80xl7SQUy0gJuRSWDTURZjEA0ZgHtiB2Qjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014214; c=relaxed/simple;
	bh=gvQ72XqhVYqahbcBoHdMWqC6dXEXWPdoOpspT2sL2Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5iUkftYUQq9oqHjy2hpJxAUKVpLwpnRPrn90Df21vrkLvCLCppl3LBCchF7qvgC2jsmQ7McBG4YQfiBHc0Z2sNTjeQQEVk42jvZRluXcXEHpw4bIv6ZH41u/UmqYU1nNvSHzOF6QmXo+I6rlEdsCp7Tr8FfTQiieLhKIXnnSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JdGv+Aqj; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JdGv+Aqj"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so196588276.0
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743014211; x=1743619011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qNPVx9J3I2u7r+pWJFYW27zcpF92LIDKBWH5rLLtBo=;
        b=JdGv+AqjAv8LLeVQj5TlsDERBr7Yo1+Kv17NLE2JFzbsyXyekVeSOo8bZUl7wWvGHN
         Yn/RZdTIpcraNGpE1bJUtn9snPZbyrP2cgQuVH/YWups7DoPi3Aq6baopaFo8/WjTxQO
         7RuBMM8XFMasBv1SV0TSa1Kcc5wHR1PVLu+fU1cJZgs3CoX4NHbLKImEvewp58w/VLrh
         B7eTrx2LmvS3McLer22BXm/mlgnPJPv4TIKBHphGg8tTx76o1VIkCPxCiP5g+kz3zs/9
         5wBJY7e546a39FWgAf5bCJ/CFYZLwhyTC/ZNksAS+N3pzo+cVSvkOeD+o89Xvt5h2cZa
         8QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014211; x=1743619011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qNPVx9J3I2u7r+pWJFYW27zcpF92LIDKBWH5rLLtBo=;
        b=o9B+qnc6Ac0sLmtduwGu1NhXw5dZGQOaVd+3E6uCewA/VmcRbqlzRjDnfuOpM37qS2
         rDmXykkXZWwdWiwoATYOcT1nDG64Bf70GEKNSljca2MF4Q415srrQr5CqFvBEFD6Gtse
         HNZ0JQX9+31ltNzD7JC6uYPOu8i1SCdVCXtyNsKPPwNMZcl8O8RMFR15BkCVNjH+L3sc
         aaeKcv+gyQef/a7GZ1S1lSK5ErUgZALbtUtPDvjvznMUouyqSQNt+Xa1nDmmRTQQXIx4
         g3cwnL2+4jDnCvoMySLMdQ2kglio+i7pM3q0Qe4lUy6CYlM9FMbNK3Ps0ZHlUSpNW+gq
         fPiA==
X-Gm-Message-State: AOJu0YzQHoBenOJP5oeSMqAVjxj7aNyVwjRFm9ATT8/OVwkqHIgJwJfP
	qCBTpvvVjs5jUrZdCs55fq/XGR4hxrarNE8ev9+1S21dfd0xaS+G9q5XZ9Oe+wnosyaeb/bYUsM
	3XAZ81FVXyAJ40qpQh7RKZdkGGPEDcqS0HUy/
X-Gm-Gg: ASbGncvNEbITYTlHgHorPMVx2Z4zLHtEbhiEDFZTvnpemhZOPManHgIoulKhCEHV7Uf
	dPUkydStwm16hCNjrFLaUCcS66LjvyMmnzbkVql7vRk7JPV+l6eozVSiw0MuViJ6MtCCEAzdsnd
	ZnvB4n18wWajuCSB+82aDMcp/2ow==
X-Google-Smtp-Source: AGHT+IHFVthYODlKcOsuPG80+S5CYT0fq2uoWH/clwMi/MGhGD3v4JKAA/Stluyl4CMIT9rmrhBMmk2BmOBi+Yn61EM=
X-Received: by 2002:a05:6902:478e:b0:e63:ef84:1098 with SMTP id
 3f1490d57ef6-e69437fd0bemr981758276.34.1743014211543; Wed, 26 Mar 2025
 11:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com> <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
In-Reply-To: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 14:36:40 -0400
X-Gm-Features: AQ5f1JrbC2zBMF6igGTE7A-fwhhXGmslJ1ZVSxkucZ1YEFk3sLw9u2wDn0GzvK4
Message-ID: <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, 23 Mar 2025 at 12:39, Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Add additional SELinux access controls for kernel file reads/loads
> >
> >   The SELinux kernel file read/load access controls were never updated
> >   beyond the initial kernel module support, this pull request adds
> >   support for firmware, kexec, policies, and x.509 certificates.
>
> Honestly, is there a *reason* for this, or is this just some misguided
> "for completeness" issue?
>
> Because dammit, adding more complexity to the security rules isn't a
> feature, and isn't security. It's just theater ...

From my perspective this is largely a continuation of our discussion
last April, and considering that you ignored my response then, I'm not
sure typing out a meaningful reply here is a good use of my time.
Anyone who is interested can find that thread on lore, unfortunately
much of my response still applies.

--=20
paul-moore.com
