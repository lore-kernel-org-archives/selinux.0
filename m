Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02C3D75C1
	for <selinux@vger.kernel.org>; Tue,  3 Mar 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556427; cv=pass; b=Xq6VGyRadufsYN22KvgZexSESy4Sya//QH9lNrS2ryML4nd7PJRqkIOe8rkDkLaUZVmBrVIJMh+YY0M+vwjDhGC5GfEOjaBqQOC/rPxCIQ7YDyQ9GslrT6pFF9TWq7dq6CeFSanIpwfrzYIK94uCTwKbKyJFKB/ppPQY0rxvz/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556427; c=relaxed/simple;
	bh=SM44xZTfCkfDv2e/gG3FPefonBOZyBwlh9V8PSHZAos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgGXO1QXYCVLWju8nYVXZPeqNjRB/ZY2bCS0DDmqzoZLN/hMOwVbJ8ttf9NKsbPbFSB0jET0/EVwR2cw6wtvyC3Ill8l+jlrePUC6LvQ+YwJqQf5rc4Q1xfYx3yu/x+SNLeudZO/wKz65m2cM36h7RAQWEjP5XfD2pvTaLfuJz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NGoK2Zqh; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NGoK2Zqh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-356337f058aso2945632a91.2
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2026 08:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772556425; cv=none;
        d=google.com; s=arc-20240605;
        b=N4KFDkSy/JkBCNpe3dMYxDvY3oPf/ZFLueBY2k4lR5pngMjCf2coNzoQSF5jaDJ13c
         OY5urMZWIMX+RsKhGuHL7JGMMA+C79CiE5CjjsplJDnsKdQJEaQOvUMlTiw4yyimiN2n
         9qRuozNPdfTmlksErLtqqvrjTZ5Gnnvz+PucQdw/0xKXf3/MjGrmC0GaR8eHrXnMO9Or
         bWPyQK1lk6VulpEaqhn1NLkzx20DI0g/fr1E4UeVERfx/aKrYj0Ja1hqP35zXOXyv8sa
         bXqmSAJEePaHNBOnvucbkor/pMyz/bmA9LPlGBJXYxg7FLyN3EmlP0+n6X6w9PLjII1T
         QCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=znrF8xKITR+luWgbXLWnwiyzuzV2rFTt6rBzVhsxgC0=;
        fh=Q8YpCWr/TelCEm8BT7SQvBbv1jcjfsu5cCJEDeSfNqk=;
        b=NFeVQQ6JJUV2OF9sXfRKRNZbQOmZH+74kaJb9kBbN5lvtvo70PC9Nx3W1W+/b5045G
         CtKQc6gYih/j4JbqUWekitp5TQD/V2HtJRpic/9lMeBzZ69cWiTeJcJM7NXAXHbXI101
         6dhTjXOHeYAKVt7lJDGn/VweP/CEra+dJ7ZjtlUb2mMKspcFET2tRkQ0wuI94bdMiuv2
         tV5UU7BWusS3RvclC9iEQK+XWiCjlSSFTfE/A+06lZBZeEjWzSw0DItxI9ZRkKyDMtst
         ULytAcP7Rcx6zVgADZjhd8anZrSI5TW1ZwILFl25M+46uDiImoZ8yMrCeauhnBreqXC8
         p70A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772556425; x=1773161225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znrF8xKITR+luWgbXLWnwiyzuzV2rFTt6rBzVhsxgC0=;
        b=NGoK2ZqhakjVdy7zgREbZ/2vQHCbwjZ5uY/Swkr/8iKYrRgvsQ45RaXEsRkidqiUB3
         8JHbXmQORNA0/wMF8lqpNwvE61VxcjUbdcoJvHqssAM5DS99CE5oZrE9KIt4f6SzlVO/
         J4tuv2jRrzjtRh29IE+j06w/fPZ982bzJdbga1Kz15mnsPdyKZm0btJzXO6kOlTl25nu
         rhyJF5PVvo0+q53OMa16iCe2xxeAlEIVhyfkjEilhJJfuMcPL54zIjLrTiMNZwtIP3s1
         sncFMdymKUHX0FvfKNyBZ02ND6MB53OyV/3ZkpuvQaS5/2gMVwrk32zjNr98rc6TKSJX
         g4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556425; x=1773161225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znrF8xKITR+luWgbXLWnwiyzuzV2rFTt6rBzVhsxgC0=;
        b=pvFMhdBYfExyEN60X/OikXFqMkFD4bhe/Hi68Ob7p1YbePS5Qvx8KF7PwaU80JCUI1
         fS/TY4rw+WgFyrOu4DR+6iqWnC3Fyqq8TVNgXYCR8rKYQyHlog5wl5qu/IrzupHOqXpC
         yH6Onz0n0DQreKzmpFjTutpCj7NobYQA/adYKYOXBk3mAH8ZK1bROMO9q6z5zjNbgszO
         XITde8FoKw0aZXoZXxrKTGmjnKmSaBYf4fPFnkR1ojlKCpeNhwejDnGVdey1m2v+nFlg
         Xe3vn504V+OznZyMs7RaNhcONx5cCb4Okw9zF7+qOhH0rvSZLY2CRIaSE4M2g6OQmTWU
         OXrg==
X-Forwarded-Encrypted: i=1; AJvYcCVotdm3zFHRKiqjXuZjFaV+lJgg5p6Ia5Cw23hIom3SV46jR7UEEdQSJiWF8eYomH5/+evyb4KJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgws31P98lP40wiN3WYAm3jZhI+IdFL2oZ1xaIzKrXI3soZbly
	469mgJgOgbl6LKnTZ9N+91F2lVVHcpmnEZg6q/8kjQ6RGuPT4yXIAh+Hctw+l7KML0XHHSD57hd
	YlSDPUgSak22zDLRJIGrKZ0Av/LYPRpVvqhUSTnmjV+Ui5vtoKXjdR5xA
X-Gm-Gg: ATEYQzxPWqrCE5w6lGO+AORXn3HlT94fmAXQFREjt60F3FSLV9yG7X49BrsAkpb1XwT
	JIknLnYbg3f3iGlbJc3I/S5HHq5aZDj39XWyCAPr9650fEhdPhJA7HbSTNuMj+fWBOaT0p0md2x
	GlSKxwQ6/HdkrImNJKHhhkxxVn9b6zMoZXoUKqyg9GUgTiKNAlLdTkbUj0x3D3coXNV8ANkAhpl
	iZkLWxPZM8TvrA9YQQcSCKV+DS4iAXnZxnOc+zVSv5tbNkWP5wEsFgdj5LhVCOk4IYXoU6ne6Tp
	oVPtVwA=
X-Received: by 2002:a17:90a:f950:b0:354:c6f3:d365 with SMTP id
 98e67ed59e1d1-35965cad890mr16289046a91.17.1772556425425; Tue, 03 Mar 2026
 08:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com> <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Mar 2026 11:46:53 -0500
X-Gm-Features: AaiRm51pCzabUF6iI4koJfoZ_mMjPn16GxhDeRowfLtuCabpuC97a0lUOhwaMOU
Message-ID: <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 8:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Feb 25, 2026 at 7:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > I spent a few hours this afternoon re-reading this thread and tweaking
> > the original proposal to address everything discussed.  The revised
> > proposal is below, with a bit more detail than before, please take a
> > look and let us all know what you think ...

[Yet another reminder to please consider trimming your replies.]

> I think my only caveat here is that your proposal is quite a bit more
> complex than what I implemented here:
> [1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.smalley=
.work@gmail.com/
> [2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.smalley=
.work@gmail.com/
> and I'm not sure the extra complexity is worth it.
>
> In particular:
> 1. Immediately unsharing the namespace upon lsm_set_self_attr() allows
> the caller to immediately and unambiguously know if the operation is
> supported and allowed ...

Performing the unshare operation immediately looks much less like a
LSM attribute and more like its own syscall.  That isn't a problem in
my eyes, it just means if this is the direction we want to go we
should implement a lsm_unshare(2) API, or something similar.

> 3. We don't need to introduce a new CLONE_* flag at all or introduce
> new or changed LSM hooks to clone/unshare,

While I think we could get away with a new lsm_unshare(2) syscall, I
have zero interest in an lsm_clone(2) syscall.  If we do away with the
namespace related LSM attributes and rely entirely on a lsm_unshare(2)
syscall, would everyone be okay with that?

(I think we would still want/need the procfs API)

> All that said, I'm willing to wire up the SELinux namespaces
> implementation to the proposed interface if someone implements the
> necessary plumbing, but I'm not sure it's better.

I'd really like to hear from some of the other LSMs before we start
diving into the code.  It may sound funny, but from my perspective
doing the work to get the API definition "right" is far more important
than implementing it.

--=20
paul-moore.com
