Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA451E8348
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140615; cv=none; b=jFzA1B01T570OQrXfj25LyPFylGgMXeycr/vqsBnfv7vOw1GI1RG7TSuAm3Jgep3GyRd/BhgSEnANBSmuJiTJvKgfg/qjONNMYdBJO6SQt7/k2gq6u8v+1V3bBbCJUZMjS/THjgCutMj2P9p7zQMGwZMQu6EriSM2Pb76AbHgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140615; c=relaxed/simple;
	bh=n4cACpakvgGkheh0DbJQW2Qo2CVKULduhn3NpR88744=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er/nBkMuSwaWhSSUVA1b1eGnqQPf0FIhYR4iCA7u9sSavTgVxHIWjvktof1Ein7HhWVcaT5k+OC72lK29n4vJ17HcCmhn6WO0lF2cN/Mh2ZZh5GIRvA86XhIxz6NIUbIPnF5woe5wsS3nUSrK7FiXkbCI/hDQ6KgYDnyIFCIoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ag/ARq7B; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ag/ARq7B"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8bd2eaf8ccso4496521276.2
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140612; x=1753745412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YScyYlmWxZeZkUXTs2GiN2Rd6DwhYsAR3xjaaeYH7iU=;
        b=Ag/ARq7BgOn40Y/lJD7sVsbZ2lsPEdxxlm8svUIJZ4XH8fzo7S6b+HEiBjVq1LSKWx
         1lRGth3RA8Q0+JTMPxNKow/NaaZsGxj1/1B1guYgMHI6ZJKav9mt6gHGRM82Tzkcn3dk
         eP39VdDBh8D8BlcSxE8ee5bAP2ysriawpOyf7TffME7O/4zOrpXLjUVTnnXOGrBLeCTV
         GagOPpe6rfHhwjagdEp2Oca+po+lCfm6sNPSUcMRriJ5cfDY+LEDS8lRJXKbxmCGZPBm
         Q04xolmdGJ7JD/DU013lX4d3PRtPFp/ZEkYnQkuc5p6tlrRMhaa6EJv1S0gTDtA3r8TR
         Nvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140612; x=1753745412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YScyYlmWxZeZkUXTs2GiN2Rd6DwhYsAR3xjaaeYH7iU=;
        b=Jm3c4TFnQHvFWa1ELer844CgLsNSTAWBOt5kPeyUz22FjZLegMAt6NnQwWtJk/38Hx
         m/T1fN46E9A7uFrXMjjBlFL+DkkHg3Fshd0brB5oqNmBlP8Gqyiy7WPjvnNdmbsCkDBK
         lwxRugk7h4y6FIzL8fOr73WtlQ9ok+rfacrQIdtilvtVVsHYpXo2jM6TCLmJlt6M+mSl
         XcQfw+GHimkhOr1IuICxEWTSGLq7Xy2bBB8w3pUE5QQBzWYvvSIiagZCur9DKOsyc+7Y
         DjTsi5hQoDvMtBdKHU00VxwOqqiI0tpvA98Rvv4Eh1QGIr4k55c5qkzRitZ4X3OZlL/S
         YvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkkqf5uLZRwofNIhCG4Y3m33Odemu83asMTFSN253xExVsnes01eOAjbqF4g00zHoO8BamGRwf@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2eaBVG25gRnAzFfCyesl8rCrmZVqmAajQ3qmNURc0DDVTX+U
	FjxC2HFNk/LfZXFnoh04Aa3zpp5LbdQKNTTdbP0oz2Eqyg7746dyCwFt5/DhEsBscdLViSglt69
	Io0BYeja+2ovPjfHyohAhS3Z0OY/YOJYVaeEtgC89
X-Gm-Gg: ASbGncuc9mQr3Nu9055xjBJB9hJ4HgsNr9w4+mvL52boZqdXkLLkTz+2+ipHboviwdb
	G9tntLPM+O9TXPLZ+mHKlBKd/YonCdWprFv2shJDifVfCwucGNvYXN8UUXojUfOQ2Rohx1Q4yuU
	Odo+r7iQ4lb2B/AkflOH/WJ4US0tfA9JbQArJ2Vs2V0PORcKhKnUyjAK9GzzGM7ulJODba+FlKW
	lD4g3U=
X-Google-Smtp-Source: AGHT+IHzggdi+b4kD0YQImV9DfXMg1yZN6qGQ3w9w0ti/VLY2zLiyXoRGLzOSdsFZx3ohVsfNJkmn2R66Rnpi25gOVI=
X-Received: by 2002:a05:6902:6301:b0:e84:4341:4101 with SMTP id
 3f1490d57ef6-e8c56d10083mr15777492276.10.1753140612431; Mon, 21 Jul 2025
 16:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-67-paul@paul-moore.com>
In-Reply-To: <20250721232142.77224-67-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 Jul 2025 19:30:01 -0400
X-Gm-Features: Ac12FXx2zja76sOQ58TOV5f_D8IAFTcRD5gf5X3DAnwKfDgcKZX5GBzOMn7gBmI
Message-ID: <CAHC9VhSY7FoQdSo=VvzZCs=_WQhOz+HKjV8jXe==-4wOCvpVjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 31/34] ima,evm: move initcalls to the LSM framework
To: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism.  There was a minor challenge in this conversion that wasn't
> seen when converting the other LSMs brought about by the resource
> sharing between the two related, yes independent IMA and EVM LSMs.
> This was resolved by registering the same initcalls for each LSM and
> including code in each registered initcall to ensure it only executes
> once during each boot.
>
> It is worth mentioning that this patch does not touch any of the
> "platform certs" code that lives in the security/integrity/platform_certs
> directory as the IMA/EVM maintainers have assured me that this code is
> unrelated to IMA/EVM, despite the location, and will be moved to a more
> relevant subsystem in the future.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/integrity/Makefile       |  2 +-
>  security/integrity/evm/evm_main.c |  6 ++---
>  security/integrity/iint.c         |  4 +--
>  security/integrity/ima/ima_main.c |  6 ++---
>  security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
>  security/integrity/initcalls.h    | 13 ++++++++++
>  6 files changed, 63 insertions(+), 9 deletions(-)
>  create mode 100644 security/integrity/initcalls.c
>  create mode 100644 security/integrity/initcalls.h

...

> diff --git a/security/integrity/initcalls.h b/security/integrity/initcall=
s.h
> new file mode 100644
> index 000000000000..5511c62f8166
> --- /dev/null
> +++ b/security/integrity/initcalls.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef PLATFORM_CERTS_INITCALLS_H
> +#define PLATFORM_CERTS_INITCALLS_H

Ooops, the above two lines can obviously be removed, vestiges of the
previous revision.

> +int integrity_fs_init(void);
> +
> +int init_ima(void);
> +int init_evm(void);
> +
> +int integrity_late_init(void);
> +
> +#endif
> --
> 2.50.1

--=20
paul-moore.com
