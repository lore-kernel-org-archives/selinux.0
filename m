Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5F213E7C;
	Thu, 27 Mar 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094541; cv=none; b=DhdzA9JnaC2YuIbHBUYDua180ncao2+hQKWB7nyRo43hRcpPwVwTIX8RQCzSBtvPvFrmgp+vKYZ9AGMqz7DVGplxD+mO/28NvkIh2Q8B6VsGhbepsp1TrlcnQ/OtXvSy92Stzf7OLHI6oEiJoXXwlD8H2su/mtRzYyay0gCSlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094541; c=relaxed/simple;
	bh=Uon3qEGg/NvHUBBVl/pz1yTtWiws1AYFbn/fiq0Yx1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct1mct70cUV9bz4tYwlp5Rb64SOlyLX4uOM9Zr1vR8/bupsAIXXXhC2Ct9pjk3mD73yMJY70NEiDxMEx4crCTx/tXyEda0kuhhd3t5KTdfLXm5kB2rmGEI6LMDcwWicueqPnGnYF1KsFk70clqD/ou2kAmNOwugVnOVdbhBWtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNd43Tpn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNd43Tpn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30362ee1312so2117172a91.0;
        Thu, 27 Mar 2025 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743094539; x=1743699339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByFON7q3KhC7QtbeHTvpKs4Q2ulFdF7osJUVJMISfK0=;
        b=DNd43TpnkyEO/KqQxwefjbHysI54sg0kxri3AkSQhDcZNi/GytHOCbyurZbRy6xtou
         LRvefrbkL8EJrQBeSt2BLHDutAHXb60Bhn9htVRzIy82Cl2ZBFv5H7FRnmY5Xb+zHeLR
         bl/y/f3eCHs/hYEFtsRvIZHWpFBNnDChMJ9peLZe48Bn9a6pUSRC5R3bxwLaVfveCpHY
         EE6QZwYVAYe6TCZ3YGtixxQk6wfKkv1SWMGXQ+w9qCuIvfXX/0GZe/LbbYriq2OXoC20
         9ZsFwz/3dQF40CbICpjWi8EKXO3nLotmgn+eU0XilDbP4oSgZOSm6EeyNd9XQFHoOBPA
         LOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743094539; x=1743699339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByFON7q3KhC7QtbeHTvpKs4Q2ulFdF7osJUVJMISfK0=;
        b=A00lRcrZEKs+3MaKzaF/6S4FxG91xwKMnpn3V551uypJffh+4NzpNcJya8Waz6bQgX
         wRCcvN5/A9E5jR5pL+tUlTpdNHbUpDfZb83ZpuFgrjFd4/9wsgdc3I76goD4kwKHZCyS
         /166xZwuWSeSuQtYbKswjq7VBwH7qjbXBdw7dIKnuFSVWpGp61OsFJKFu/TUKoOnCch3
         B2g+fHe/rbTBQKedRMhmtp1UMfD8WJ0yExYCnKqUSqY0g02A8ScTzCXsbWfR64sqlmUj
         RNTzC29tWiqq8DryPgoJnnVP0yuafl3NDGh7ELyJGb7JuJlB/V305DgudHWz7CRlimDL
         HFJw==
X-Forwarded-Encrypted: i=1; AJvYcCULmQWmi4cQ0sPmsErfvzMYoS1fVlWiO504ku2zHTwnjqX07HRf7PSEB+8DSO5lX0npeetCpaFzEQ==@vger.kernel.org, AJvYcCVJ2ghDsedckmu8oEILSD5o717h+yd2Jt34HvlDkreYTnoDKYO4nEg5dhQD/704i2w3m3a7TMpNZHRqrBEQkQ5Heofo6+rL@vger.kernel.org, AJvYcCXnGN1rH2wzEQwe3CzhvDmo7X2Y3ELDt8U7SIXnuyDp6vIBcZYy3MeQOJCfMOGG8+SypfnruQyz3FXqbmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNrJszBRmS696/7cVvWKjEbci98kPUaeQPbQ1rDdvYUS9h4cRK
	Ak8ypm73dUbzW1AXeIu6NLHKD0KkTae+ZgXjQnQ3n1jETMWBNASGDvF+Ohosv6oMKRtyFENW7ii
	25Rx8dxnjzfPag9Wdb37tRH7qHU4=
X-Gm-Gg: ASbGncsKxruXINmO3ha44EoYP2DiKWT1GQAYYJToLB3XMTjudxkfpKC5fmBkhKezeJ5
	uU8u7uSYaVsjzDp9Gh55x9VLLfMrb4vmKCUUvTQoyVrERNgX8skO7wDg8Yt3NVN4etSOs8tNFkA
	xJjqkqKf55D0h5Em385aKoAeyI9Q==
X-Google-Smtp-Source: AGHT+IEfiQ0zED9sdnJweqipuxK1ghpqF1l+FajTofew22k1VjuHajI64waSNC6gzwEHJhqs05Y9D1svRzrWb1HRpJc=
X-Received: by 2002:a17:90a:dfcb:b0:2ff:58a4:9db5 with SMTP id
 98e67ed59e1d1-303a8e76718mr6457357a91.30.1743094539334; Thu, 27 Mar 2025
 09:55:39 -0700 (PDT)
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
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com> <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
In-Reply-To: <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 27 Mar 2025 12:55:27 -0400
X-Gm-Features: AQ5f1JrIU0ct8VM_xqsE5wWw1tRmHSeiBAX7NfO2AF4-t-sBob2lPIYKMYUi4go
Message-ID: <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 11:50=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 27 Mar 2025 at 01:59, Jeffrey Vander Stoep <jeffv@google.com> wro=
te:
> >
> > The value here isn't so much about checking the source context
> > "kernel", but rather about checking the target context and enforcing
> > that firmware can only come from trusted filesystems. So even a
> > compromised privileged process that sets firmware_class.path cannot
> > cause the kernel to load firmware from an arbitrary source.
>
> Yes, and that's literally why I earlier in the thread pointed out the
> new code in selinux_kernel_load_data()
>
>   "I'm looking at selinux_kernel_load_data() in particular, where you
>    don't even pass it a file at all, so it's not like it could check for
>    "is this file integrity-protected" or anything like that"
>
> because I understand that you might want to verify the *file* the
> firmware comes from, but I think verifying the context in which the
> firmware is loaded is absolutely insane and incorrect.

So the only use case I could see for that particular check would be if
we wanted to block loading firmware directly from memory/blobs rather
than from files. If that's not a valid use case, then we can get rid
of that particular check if desired; it just seemed inconsistent
between the two hooks otherwise. What's the purpose of having the
LOADING_FIRMWARE enum or hook call on that code path at all then?

> And that is literally *all* that the new case in
> selinux_kernel_load_data() does. There is no excuse for that craziness
> that I can come up with.
>
> And yes, I'm harping on this, because I really *hate* how the security
> layer comes up in my performance profiles so much. It's truly
> disgusting. So when I see new hooks that don't make sense to me, I
> react *very* strongly.

If you have constructive suggestions (or patches!) to improve
performance of LSM and/or SELinux, we'd be glad to take them. Or even
helpful hints on how to best measure and see the same overheads you
are seeing and where.

>
> Do I believe this insanity matters for performance? No.
>
> But do I believe that the security code needs to *think* about the
> random hooks it adds more? Yes. YES!
>
> Which is why I really hate seeing new random hooks where I then go
> "that is complete and utter nonsense".
>
> [ This whole patch triggered me for another reason too - firmware
> loading in particular has a history of user space actively and
> maliciously screwing the kernel up.
>
>   The reason we load firmware directly from the kernel is because user
> space "policy" decisions actively broke our original "let user space
> do it" model.
>
>   So if somebody thinks I'm overreacting, they are probably right, but
> dammit, this triggers two of my big red flags for "this is horribly
> wrong" ]
>
>                 Linus
