Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26427B320
	for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569422; cv=none; b=qSbEidka4B08ihD8+WkJIRU6NgdI6uSn4YUeTXihGBw1QCKHJeVQRgMFDMUUelO1xAyNcEqDjCww/cKoK96lFI3RA3CWTiWPpGCGqzKevo5Wj2Ck3yPbSHTR9nZSvFFTy/ZX/GRoCMsprX7p+0vQ35EZRfDWikqQC0zyTaIXPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569422; c=relaxed/simple;
	bh=M55kfbiA5WNrGJ3r6EqFqgctDNfA8Xd3Z8+bi9BHwqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTLUxh5Mu9AXKNCeJn5NtB4rrr6lh2jKnjJ4AvwPiGZosKzOlaWB2EQqH7sIoQlMXi4OR2nvDgu5/9iqU/P8JLi1RAAiyGPP8aQqBs8UMHAtOGXf/hs+Wa7yVFEUvNT1m11VSpxkRfHdyWz0L2DXj9jBhy/bwGPL0qDddtKzYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a5L0TJsa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a5L0TJsa"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so8105366a12.3
        for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758569419; x=1759174219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvdWOntfA4A2sQxeMILs61f9nOsNLek7agJHp14BnZw=;
        b=a5L0TJsaSgtelL6PwfSc5g1RGH5xXQFmKj5F1lLBAeFsG69TsSvyMsSrFNtc2wPL2a
         whvVf+1P6Xvn6utJdbFrhO8fyOhXDoBY2rlST9n/D0rmICcvUF5O1dzXv9inJoECHO9X
         ilXyo8nEQz1QpOhlnDnQmz0lHxNKPiNHUrv4jk12thJRYG6FqJ7zCf790fiTUsUzjuZm
         948+9zbPqmkPppmpcFykZDpX4SBd3I5vVjLb/gpoN1c2LoYLk5oBAjhEphmxQDiMnb7x
         wAPV6rdtxYN3pr+QaE2TKzq0FR+A5G8hVdAolnBiI+qM7V/8LlkuDuBsTGO7sQfIcFTs
         xrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569419; x=1759174219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvdWOntfA4A2sQxeMILs61f9nOsNLek7agJHp14BnZw=;
        b=PlqhlK2jgAS1Rh3O759TraWHbrJbJOPoylRDrymzowEIuLVSBAGvdoi003+Pasadwz
         F2BMItN4AHa4tjEKxWTRW9WExb+1uJ2+pxWjXlJgNQhAfPFgdhsiup+palu36Cja3bG4
         10AvvUYiZjA+ONCZhKtamytW/Esjy6MTcSW/HwslknPWvUqVJit0sLPswOSa1fosvJ0m
         VrW+qHXKrnZA/MeacI7LU+9dXipz+LFJw12fE/0MyFSs91aM6dBux3rvEqaY2eY/ngvC
         5f9EpNDtTf5d1RBsVY2pasHN9J6Vn+W8IzK5PtzF7JdfzHppgycsAbl/lBgD5LJ4Itge
         wqUg==
X-Forwarded-Encrypted: i=1; AJvYcCVmFYR3DC1z4MyFj5sCCV6+DSaI29uTb3wHRDecWTQdMlRk4sPwQt1D0Q/3PwTEu8iiN1ELI4l4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TBguQ676Wphlgdy1rI51PvQhphEsdcJh9IOW3nVrTSpr8rol
	gvgru3lpsgt5hzkGcGs4d/uTG/ob3Mlsxb3X0qi7SGkF3cmcpeTaDdiibRte0isFnCgoGbmrw0i
	A1n3EmxRpPNinPFalRD/LUr0NBFceGgC5hxeP7X1H
X-Gm-Gg: ASbGnctwqG2GD5noWqSVLT3CFhNTuaD7N6h0VuoyPO0L2GF3KcFnucZI1XoI6sIC+VR
	2TptWYBEf3n2eFUJzij6WuDn5AU/nVCiXQupgQMZR+5fM/J1Vf3DexB4mFGNSnvhb+J70hMovUl
	JPpLq2ZXNQi0s0DsixHn62UEjxJ+uJ8XTDRY3Khh/lE2kkINI1QpwAMx0HL8OQZ57I+p72nBC8e
	m8dicc=
X-Google-Smtp-Source: AGHT+IEiBDSh+6Em5c+U4LmqyUVPf4J6sg4KEYshuli5NnK7h8jqw5N22Ih+dxfjqxwcfWjX8MHUInxueYuNHXzg6tw=
X-Received: by 2002:a05:6402:5201:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-6337b1ea02fmr4563672a12.34.1758569418235; Mon, 22 Sep 2025
 12:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
 <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 15:30:04 -0400
X-Gm-Features: AS18NWA9HrHmx3YP496OglRtxh1AdycMtaqbc5LSlhUEUhu_PxKTgISVOm7uHlk
Message-ID: <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> When would you recommend that I re-apply the corresponding userspace
> patch to reserve this policy capability number for memfd_class?
> After it is moved to selinux/dev? Understand that it isn't truly
> reserved until it lands in a kernel.org kernel but would prefer to
> reapply it sooner than that since there may be other policy capability
> requests queueing up (e.g. bpf token) that should be done relative to
> it. Can always revert it again if necessary, at least until another
> userspace release is made (not sure on timeline for that).

When it comes to API issues like this, my standard answer is "tagged
release from Linus" as it is the safest option, but you know that
already.

The fuzzier answer is that unless something crazy happens, I'm likely
going to move the patches, in order, from selinux/dev-staging into
selinux/dev when the merge window closes.  This means that any
policycap API additions for the next cycle are going to start with the
memfd_class policycap, so it *should* be fairly safe to merge the
userspace bits now, I just wouldn't do a userspace release with that
API change until we see a tagged release from Linus.

--=20
paul-moore.com
