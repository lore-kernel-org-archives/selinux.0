Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CB224D7
	for <selinux@vger.kernel.org>; Fri,  6 Sep 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647863; cv=none; b=JP/8IzG9Jft/xzqt66w7DpBhsL0+hi3QaJF08tK7u+ab7245BnK8P2fTcW/bG8ltqYc6YfV40EU/Ocnmv3KoXU6UDYr+XgqI8v1tXl4hcBHh7YJZ6L64kDZeRzIySJ/AlSKEFw3eEX8HknV1fsmC5Qga45d8JhHkMplE2h4nam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647863; c=relaxed/simple;
	bh=3R86fHaAC7ic+4gC2wPebPEUbI7Ky+xk03VpQbVcoms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjlwFO2w6zBjkTQN2D75HsMOCgQ/m/UA1BAFSKdSRVUS7lJjNkISNQ8kkw5HHpmevZ19T9kMyIWqJZQ9h8jY64Oix35ueJqfyMJeZMmzG7hxhTCZAesETeTc/xAyk60Lh2fRs7DwW6NP7QvrLuqwJZ1L5q3y0oTMrGCvIqQQYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QW9sDR5I; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QW9sDR5I"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso2796956276.1
        for <selinux@vger.kernel.org>; Fri, 06 Sep 2024 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725647861; x=1726252661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcE46SBOgSHYzKXpHvBrm582CvYA5FJmYgYbFncHkHM=;
        b=QW9sDR5I1U9qxU4CvBhIRlZe5OB/ssJWg2elznAdit0i19iMBOOxk28fwUDNqLLAlQ
         hLPR8xX1T1IZ9mrB5QCoXVUEeTiZjFWdsrHhUTuCfMVbDSyBt/bf4vcLOOvI2Tfexx3a
         T6RjloefbGCxXZoGgyMl+b/kZ4MdrSR4WocI83HkYwTuiKHoVacjtOYa5/JCQMYrVaO/
         aiUhMrtE1Yk1nCEZJ/FG+7/0iEkG85hyQVWV95CxAE+/TlpOPP2V35qajv7v8WaZPW+U
         m+H2oi1YbTgCWjF6MpMwOnxJqpHg2i1OK+3ujChFe+b8ag2ep69VPcyGLMP+Bvvf0vjd
         9kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647861; x=1726252661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcE46SBOgSHYzKXpHvBrm582CvYA5FJmYgYbFncHkHM=;
        b=eZSg+bxclQGhe+V9d80eljZrobx63Qz5kyH3H33ym8V1hH6J70rdtER5OAtYwOESqK
         Tx4TbUB1Dvud+IXaHNYcul68/rTMEANa9ldZBuG8WFaRmysFzAzlKXCajCPd2BrzKfH1
         BQbx0OPvfz8IgzmeNxlQ5619ag09Wd6MVv2SFWurD0frv27dsU9j87ZyLr6lNOzkK93I
         yipkgzGSm5niF/fVrJL5k64lrf5cwo//i/oSDgicfJvGdm35K248N5hBJyKb+sPjFfic
         HLJ76vl/gxFDTetDl84Vn1WNXgOjmn27QJuDFMSr9lIa8P7Bf/D9kNnlDR6T8rpOUIL8
         iM3g==
X-Forwarded-Encrypted: i=1; AJvYcCU8Q/rTN4rdh/u8MAWE0gtuCHlhxqeAWz+sm4tJGCg5yodT9njaKz3RoUjnJRo2Ghhru6KcIEs5@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpID7KBrf1eHvfejawXeNM5rn0C8frd7wml1nlsDerrO7G1U0
	YakLMxdDzciPhdDC1jfZgQAaxA40jSfkiR5NjSDI8ueRNOId+8N3zkE7fyidOdirVCfMpBjq9PY
	CCDBQx2Oo8BgHMOKvKX0bqmHa72+CIX3dNIiM
X-Google-Smtp-Source: AGHT+IGHKzx8grp+TLiTddlEC2JyfObLVgpXE3jF+k0MX2S4nWZSrCRBhx/aoPnCn6G1NU7NrT4hzTfw+xovgEnB/qs=
X-Received: by 2002:a05:690c:6609:b0:6d7:3c0d:3adb with SMTP id
 00721157ae682-6db442a66a5mr33551717b3.1.1725647860717; Fri, 06 Sep 2024
 11:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906172934.1317830-1-masahiroy@kernel.org>
In-Reply-To: <20240906172934.1317830-1-masahiroy@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 14:37:29 -0400
Message-ID: <CAHC9VhS=5ohpS18kkXUKaE4QR5HfGZ-ADbR14WPQPor3jeFSuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: do not include <linux/*.h> headers from
 host programs
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:29=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> The header, security/selinux/include/classmap.h, is included not only
> from kernel space but also from host programs.
>
> It includes <linux/capability.h> and <linux/socket.h>, which pull in
> more <linux/*.h> headers. This makes the host programs less portable,
> specifically causing build errors on macOS.
>
> Those headers are included for the following purposes:
>
>  - <linux/capability.h> for checking CAP_LAST_CAP
>  - <linux/socket.h> for checking PF_MAX
>
> These checks can be guarded by __KERNEL__ so they are skipped when
> building host programs. Testing them when building the kernel should
> be sufficient.
>
> The header, security/selinux/include/initial_sid_to_string.h, includes
> <linux/stddef.h> for the NULL definition, but this is not portable
> either. Instead, <stddef.h> should be included for host programs.
>
> Reported-by: Daniel Gomez <da.gomez@samsung.com>
> Closes: https://lore.kernel.org/lkml/20240807-macos-build-support-v1-6-4c=
d1ded85694@samsung.com/
> Closes: https://lore.kernel.org/lkml/20240807-macos-build-support-v1-7-4c=
d1ded85694@samsung.com/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Reword the commit description
>   - Keep the location of CAP_LAST_CAP
>   - Include <stddef.h> for host programs
>
>  scripts/selinux/genheaders/Makefile              |  4 +---
>  scripts/selinux/genheaders/genheaders.c          |  3 ---
>  scripts/selinux/mdp/Makefile                     |  2 +-
>  scripts/selinux/mdp/mdp.c                        |  4 ----
>  security/selinux/include/classmap.h              | 11 ++++++++---
>  security/selinux/include/initial_sid_to_string.h |  4 ++++
>  6 files changed, 14 insertions(+), 14 deletions(-)

This looks much better, thank you.  We're currently at -rc6 which is
later than I would like to merge patches like this (I try to stick to
bug fixes or trivial changes at this point in the development cycle),
so I'm going to hold on to this until after the upcoming merge window
where I'll merge it into selinux/dev.  See the below doc for more
information on how the SELinux tree is managed:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/RE=
ADME.md

--=20
paul-moore.com
