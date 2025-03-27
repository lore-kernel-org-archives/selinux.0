Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2A46B8
	for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743038463; cv=none; b=Aiy2PElms9CQiZP8Rt/UotyNJvxfLGn5+joPJbU+F15MwFWqFbKGjlpRWbp5UR2or5WDB8Gpn/Wzq7492uz3iRv1ViTBaWwMn65Y9zT2BnxIIh1B96+rfwuBpwOYAhIHi0Q1tMKQWp1hV5ZEYtCw3LNZIJF1Ruy6yRfhjxuD/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743038463; c=relaxed/simple;
	bh=rkxtS5suWD5Evz+m11GQWGobt3dWkXZJA9nOgREsdpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq8bQIjL7249Y0vetAedGW/q2VgRiZyPUGoKm2RQ+KfD41GJ9SDDcz8GA27IE3EkgloKdHxWXZmQn3dVo0KoQfS0J2slYI3UO0BIoRTBGatNiWzO1qw1YIvQbd0rf2OQRnEe2MkF5qGtHAxNuF3X4lvcLH5HU8KsRBdqTp/U/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F3jLtJqF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F3jLtJqF"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso2787497a12.0
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743038460; x=1743643260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI0EdooEMFFqAW+WoUqWF95O/QEtZzQxFpMruePbYtw=;
        b=F3jLtJqFpo7sSLRrDpi/Mpo9sO4dk9OizTo5gkiZOqYgGHteTU53Suevxd2zXiMhSV
         I5LfR6ZTjrHM6hVrRm9Ekw6ahaM61JljSrVW3ivIp5g0oslysnsPhRYn0MLM2K2Pmpwa
         PI2CD/uYQbRpFy5lQwUuWveiNQ/ypfyGEFdxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743038460; x=1743643260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI0EdooEMFFqAW+WoUqWF95O/QEtZzQxFpMruePbYtw=;
        b=ZJInYK/52nUDQPZCj668p+LitkdijkE6agnJG2swEUkwrk+MijLpXom4udI9eDtZV+
         ekoaFkIITAUpYkAmGbwZMIftZlvU5599igyrMbqbrk+4IhLJJ1j7zZLU6/k9HbOFha39
         rtqm2ABiRcX3GfUcsk0aJ+Qwe2ClMt862SP1cmGf3GOyzQStB4nn3QoDiJ/a0MwU+2n4
         4oSL6LRXqCznTWFHmEbPQmyCV4damvbeeo06msdQJMv/k0owRIHA9xkYKBtg5tZbFS/u
         TdaNcSR6V86mayt6Y1PJR77Ab7RMSnqxzunoqlfByr8nWlc2hu4RvrG/s54Mfh/0bcpA
         Bgsw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ndoX3G8rHuMVOQm8lfuq+wsP+yra5KHTLR2dKVZkOxniWF894YRs4Oszo3da0KDKpLr+DVIl@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMAYRTNkSwwXKn/wuTDzLFI2Ttt9dm5Zsh7KQOtZAhv9FvpQB
	zwAw9gyinjY6hf0QgbgJ3jLvYEtBuGVpC2Nqx+fXOQlC6X7WOEU9SCiO7VQ1GwRPORAiZZS4gle
	tGy0=
X-Gm-Gg: ASbGncv5gziYI6CpnbwkphfZCNfWioB67hadDbbfgd4h6CF8kYM9lVSe1fIBUyIKgpr
	j9YiyaZKvwTkLxmArkbIIOfVlP+msO9zVxujkDg/lvpHSjCTQS1EUzFXvLRRWNaHBgYgkerPSBB
	8DSsEtWJCLETda39Eymb/d/ZYPHIraXnsXjbwWZyw+2q3IYht1GJ0fHRlnb1RwwHZSXq7esei3h
	FfDULEE4Fp5cp80OhAwAGFRGFPpT1W+WjwtTD6A4YVdabWWscu/8L4KkM0/2RF1/Bae671ha0Jy
	CeW1gRG1sIiDsq0vXXNcZcIhFq3mWk+MLYOFpm/i9VGy/Uz7ykUVWlhV54rEgVGeOlnbEqb9W7h
	SQhwCa8gWrIHgCUUgaZodlmNvlmDdww==
X-Google-Smtp-Source: AGHT+IHwVnOM1hZEKz5QOfbk73SlRzC6njF1GcoDbIXHKXSwycoxleKDuXH+hSr1/C9KwbF64En4yg==
X-Received: by 2002:a05:6402:5211:b0:5e7:87ea:b18c with SMTP id 4fb4d7f45d1cf-5ed8a45a90dmr1625396a12.15.1743038459772;
        Wed, 26 Mar 2025 18:20:59 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0df302sm10501107a12.66.2025.03.26.18.20.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 18:20:58 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso82517566b.1
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 18:20:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3V6sNa8hdlz+NXgHTGjjOw+ovUXXmoEVKRRKRkGDCDEKPcOkoC0YIhcIUWXlo0cnewnCM7qru@vger.kernel.org
X-Received: by 2002:a17:906:c106:b0:ac2:b813:ac25 with SMTP id
 a640c23a62f3a-ac6e0a48dc3mr490833166b.14.1743038457610; Wed, 26 Mar 2025
 18:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com> <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
In-Reply-To: <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 18:20:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrMmGY1WBP2YbkNsM86xUUFOzf4O7ZMelOhzvZwerRqYfGCFS_CQ-gr9m8
Message-ID: <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 at 18:06, Thi=C3=A9baud Weksteen <tweek@google.com> wro=
te:
>
> Taking one example from this merge request: kexec image loading.

So this is the kind of "why" I was looking for.

> Currently, any process which has CAP_SYS_BOOT can use kexec to replace
> the existing kernel. Android has 5 processes with CAP_SYS_BOOT, only 1
> of which needs kexec functionality [1]. By using these new
> permissions, we will ensure that this process is able to call kexec,
> while prohibiting other processes. SELinux provides us strong, kernel
> enforced guarantees which can be checked at policy compile time.
> Extending on this, we will use this patchset to guarantee that kernels
> and ramdisks executed by kexec come from known, good sources.
>
> The other hooks are of similar value to Android.

Now explain to me how the firmware loading hook works, not some
hand-wavy "similar value" thing.

Because it seems entirely bogus. Exactly because the context of
firmware loading is *not* something you can depend on. There is no
"one special process" that has firmware loading capabilities.

I'm looking at selinux_kernel_load_data() in particular, where you
don't even pass it a file at all, so it's not like it could check for
"is this file integrity-protected" or anything like that. It seems to
literally say "can this process load firmware", and as I've explained,
the firmware loading is done by random processes.

               Linus
