Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468918FC6F
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619443; cv=none; b=KnPDfCa0UIs1Jy1zn/DD99GYv5PsVbicX1D4vbeLRpYwLyXa8/uTSaGFx4qb2A92NhOsF7WSl5ZNvMxcaYT+cR46m0wmbf4c8dsnGftjw+rZJz7aTt7cixbCsAqPjoRq51c4UQ1tPVA6iPUXnJfZYTQlnfkqr9Ew+8HsribkaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619443; c=relaxed/simple;
	bh=mFARHWaWzSq5CWWUUsYz70ecAV4gKDO4yHznw+FV/zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2Kp3T0LXwKWMFFJVoFm7Ck59ZHE3g4nP5Ao8A8cCX36XRL6SHPQJ6Vg05CYAbjJ53zN4FMU3YBEgBTAzuUdweWOZJWFLWIn3MFe6KfLfAuNPCesyAWCnGRy8/jpZV/BrdWWNEzjim0LJm433CAJa9c79hChzKK7CUzGuQMdRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHfgm4NL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHfgm4NL"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af0684c2bso4046070b3a.0
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720619441; x=1721224241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFARHWaWzSq5CWWUUsYz70ecAV4gKDO4yHznw+FV/zY=;
        b=dHfgm4NLGQZKbNrt4Tt80Sk0F2Ka85kZoAygk7yUhXmd9H1oQQZ2TAk7rFWyHQeVnj
         u4bYXGuNM97VeKRJNqY4zkXpm0U+vgObo6f3stYWIfCZAwHBZX9LGOZTVEJdQMtycygX
         T/6m63mJIrtNpE6lBZcmFk2PG11MT3nQiPexJqV5zgV2mAlyNUPffkOaOI+O6gc9WAvw
         KjEkRmx2f6HseeTP9YtVCLpJGvfIGhnTRpVbQpHGHe8oi+m+pGVIe5Hf0tXn/crayysm
         KlmYhKzs/dXXfbDKmXM2zyiEZ3ofCKU35OBTHOSILSjHx/C+8N1fmQsYIoH06e6dNfNX
         mm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619441; x=1721224241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFARHWaWzSq5CWWUUsYz70ecAV4gKDO4yHznw+FV/zY=;
        b=O/wC0Lrxk1ERf5PFELB8rmsWvTDZUyfwkczfQjXcUYHL35FpugoRt47begIR9KSFOd
         IyPVxaMf8Cq67Q6ZXeBk/TESXFuwPWPBeTUasvpNXfvwO6cAHjdERDG9mIo7rOBJXKjA
         NUyTj3xyZecul+bPJXVmdmEJ9qlOjKGJqEalG1psAVv+u2gIdWrxfJJLUKcij53/9SvK
         He/zzLnIUMWYhksnQhupNVpVwfa5QCY/Z3yiusuJPgqk8xI46QtREwAAtvtT1NSOJgM8
         2AjWgIrlgSb0KskZwjBpYwdcwhqKLC3YKdt+/6mBhldbErNPyZmnKQmnrtSxH3iIdVDO
         gETQ==
X-Gm-Message-State: AOJu0YxNo2viQcuiW2tlvs/mPkM3Db15A56tUYXNIfOgHBId2GIx4uT2
	Yw6Y8gDrcEZzfbfwXaKMf3BD1h16UUulHvPwqIQ0b/B9eKja2zYdUD2MnpwiwG6zDgRt/YqrnWK
	ozeHEg9sZ4Cq4CHNu205H9bsJoLhKIQ==
X-Google-Smtp-Source: AGHT+IF9JAg/metl6F1dcqoNgFh7rtpApHWBjMOBeHtiyjk756A8DoKs1qvwr4mmaouKqMwXZmS0n95sFl6w58iGKXQ=
X-Received: by 2002:a05:6a20:6f88:b0:1b8:9f3a:c1c9 with SMTP id
 adf61e73a8af0-1c2984e17e0mr6116774637.57.1720619441513; Wed, 10 Jul 2024
 06:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v81d74pj.fsf@redhat.com>
In-Reply-To: <87v81d74pj.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Jul 2024 09:50:30 -0400
Message-ID: <CAEjxPJ45g8jh=0LtjWE14+ANXjOknnmyZUChu_D==z3M_5wZdQ@mail.gmail.com>
Subject: Re: In permissive setting labels that are not in host policy when
 running unprivileged fails with EINVAL
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:32=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hello,
>
> this is originally reported at
> https://github.com/SELinuxProject/selinux/issues/437
>
> There a question why kernel blocks changing SELinux label to some
> unknown label and requires CAP_MAC_ADMIN even in permissive mode?
>
> Reproducer:
>
> $ id -u
> 1000
>
> $ getenforce
> Permissive
>
> $ chcon -t bin_t /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/systemd=
/system-generators/systemd-ssh-generator
>
> $ chcon -t selinux_unknown_type_t /var/lib/mock/fedora-rawhide-x86_64/roo=
t/usr/lib/systemd/system-generators/systemd-ssh-generator
> chcon: failed to change context of '/var/lib/mock/fedora-rawhide-x86_64/r=
oot/usr/lib/systemd/system-generators/systemd-ssh-generator' to =E2=80=98sy=
stem_u:object_r:selinux_unknown_type_t:s0=E2=80=99: Invalid argument
>
>
> Quotes from the issue:
>
> This is happening on a system with SELinux in permissive mode. Applying
> your suggestion does not change the result. I assume this is gated
> behind CAP_MAC_ADMIN for unprivileged users. Is there any way to make
> this work without needing root privileges?
>
> Hmm so the kernel blocks unknown labels unless the user has
> CAP_MAC_ADMIN in the initial user namespace. I'm assuming this is for a
> good reason and it would be unsafe to allow any user to do this so I
> don't think there's anything that can be done here
>
> One thing that's not clear to me, why is an unprivileged user allowed to
> write labels known by the host but not labels that are not known to the
> host? What specifically is unsafe about unknown labels that's not an
> issue with known labels?

With SELinux disabled, setting of security.* xattrs at all is gated by
CAP_SYS_ADMIN.
With SELinux enabled, the security.selinux xattrs can be set to valid
security contexts without any capability if allowed by policy.
Support for setting unknown security contexts was a later addition to
SELinux for a specific use case (original motivation provided by Red
Hat was to permit rpm to set contexts on files unpacked from a package
before it inserted the corresponding policy module from %post), and
was not expected to be used by unprivileged users.
Smack had already introduced CAP_MAC_ADMIN at that point, and it
seemed reasonable to use it for this purpose, since setting labels
unknown to the policy is effectively like being the admin of the MAC
policy.
The policy can't make useful determinations about what to do with
unknown labels so it can't provide any information flow guarantees.
There may also have been a concern about the facility being abused to
push arbitrary data into a security.selinux xattr to be fetched by
some other privileged process later in a manner that would ultimately
lead to a vulnerability.
Not saying that we can't change things here, but would require a
graceful and compatible transition path.
